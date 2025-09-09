Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567F930505E
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401804; cv=none; b=b4kqoz7t1CBZwSdlJBmzMnAlqzF/wzvmWEr+jg8UQzQOcZ9mDXcIdQ1ugQWwA/bM7GMUfiVSS2nkrWqtVbmuTFkY2lYELXxNP+fJGkf3Bd0Ah7JhYLYp1yJIpWh+KDgfgO9zMbzcqJX7aIhrRNK2HWF85gH8R43g1FPQY+gspVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401804; c=relaxed/simple;
	bh=Yr+Po6tvGZOda5AeYF+nTKTD5Vn2vXhD95v2Zqi/ddc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siFZbgPatxEgCKCNdllPK4TICSTLYdT0kLrFicPsbKblpBRJUzhDAmJ0v7FHb4Zq3NZoA6rfCxVB0+lVcS6eik569NJJLM5KogWDnz2FX/Nx5nF9h2+TCqFY4XOHfH2gWWfZaQxTrG6ddz6bgpoXaUtnMGxbN21YdF7EKnndrSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z4BI4SRJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AQW96VGH; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z4BI4SRJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AQW96VGH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 73DB41400199;
	Tue,  9 Sep 2025 03:10:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 09 Sep 2025 03:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757401801; x=1757488201; bh=E1ii4Vdb9W
	ZcBbIK8POToOhPoLSmzk4EU0KpmBV27+A=; b=Z4BI4SRJdWSd7peWr5dU+P0rhW
	zDYSufaAjJ+w8Z43FKFGPtBX6y0PU1Th8NNJeN4hnQonfEDaQm28PRdiIB3zQiiX
	sHfR8DJQo0UjMSfR4LWa7GG1AMUlCo6U06nAkMzGPtzarUPmduT4IgukPgBPO2Tv
	bdnMtucMkUGIAlo/ED9oLcSoIW551flaJJxyU3u9YQGZsZqdaAoO6fAeoBjVAlTR
	F22bGAi+i5k+ohehMNHdxHEWUfIFU+/ENzg3jc1gu9la2SWne+O3nyGde8J1DTEO
	XZy5aU1mZTCHABI9jFRBerBB/WP5DLz9CCDsvYtkMY+ygiHAcFTPLiuOeLWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757401801; x=1757488201; bh=E1ii4Vdb9WZcBbIK8POToOhPoLSmzk4EU0K
	pmBV27+A=; b=AQW96VGHbMdw36RMuYKqYv745iXSJ67CA3lntxz6X1hJCkJ70vG
	WbpyWV4/y0ObGW7mE1e3WHBOrlLsBNMqi6NrQ1xBObNWXW0DEh8//hezUBaKmWhE
	8KaP+7vJo8WAfEQptVjKxd81MP+f9YpDh4YR/bYUM1HJwmo79JsxghjmZG7On415
	VIPBo/DF7g2l2vtlF7ABhg4uB//KY8SiSCUAFSy9eNPf7gWb41REb8R52cgoOb5E
	5Jt3xhYsAAvFgHVHHVf35bMmjBy5XCyd1Tsg16z0RLovfajkC0lyT/9Fyui8AqVx
	cgcxuLyoN70tEv9/cy8s7Ot1xT7q4MG+VMw==
X-ME-Sender: <xms:ydK_aJFoMQy8_5zcgOBQrjv9A73Y2-aCVfVYhY81ewkh-AnOHGDtsQ>
    <xme:ydK_aJ1euluW1sK1nMWNpck1rEIQlwoeRQwDwrKztJx4JPUA7CdzSk9kd9jpigBzW
    l9FZ3D-vN4pA1RvOg>
X-ME-Received: <xmr:ydK_aBmBuGM6yTYCFsMj6jM6gbB3MbS8sN2XeE9eBXzwT2N5_4c7AlFucrTr4rQtwaYfGCxtqkmh23ofzk_vFySZl8rrhstKqsTyUgfOMK0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjoh
    gvrdgurhgvfiesihhnuggvgigvgigthhgrnhhgvgdrtghomh
X-ME-Proxy: <xmx:ydK_aJ8qrR_1ynw6RsgkdkT7Ool3-aH_siA6dOvrxzvDYEINgANA5w>
    <xmx:ydK_aGpZlkFkP4_VSqGTBvncJ7qi62l2ZFrPfi2dvbtNE2VLxH5KdQ>
    <xmx:ydK_aCmWSrEY6_2Hc7cybQ8KAqMP45gbf7f1sJjwZzeJq5jH3g6HWA>
    <xmx:ydK_aNgG6HIuQdvgIWOyfqg4hUhAfvo30s9UefwubkTi1HpDi5qGoA>
    <xmx:ydK_aDpDjKdJn4RqBz_fRDB5itz0rndd7CweCve4HhLeId8AmYeZY8bt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 03:10:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6b1650a5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 07:09:58 +0000 (UTC)
Date: Tue, 9 Sep 2025 09:09:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Joe Drew <joe.drew@indexexchange.com>,
	peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v2 1/4] refs/files: catch conflicts on case-insensitive
 file-systems
Message-ID: <aL_SwghVaAXL-yeX@pks.im>
References: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-0-b2eb2459befb@gmail.com>
 <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-1-b2eb2459befb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-1-b2eb2459befb@gmail.com>

On Mon, Sep 08, 2025 at 02:37:35PM +0200, Karthik Nayak wrote:
> diff --git a/refs.h b/refs.h
> index eedbb599c5..41915086b3 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -31,6 +31,8 @@ enum ref_transaction_error {
>  	REF_TRANSACTION_ERROR_INVALID_NEW_VALUE = -6,
>  	/* Expected ref to be symref, but is a regular ref */
>  	REF_TRANSACTION_ERROR_EXPECTED_SYMREF = -7,
> +	/* Cannot create ref due to case-insensitive filesystem */
> +	REF_TRANSACTION_ERROR_CASE_CONFLICT = -8,

Nice that we now have a specific error code for this error case. It
removes some of the guesswork we previously had to do.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 088b52c740..58005d2732 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -647,6 +647,19 @@ static void unlock_ref(struct ref_lock *lock)
>  	}
>  }
>  
> +static bool duplicate_reference_case_cmp(struct ref_transaction *transaction,
> +					 struct ref_update *update)

I think the name could use some improvement. How about
`transaction_has_case_conflicting_update()`?

> +{
> +	for (size_t i = 0; i < transaction->nr; i++) {
> +		if (transaction->updates[i] == update)
> +			break;

Why do we break here? Shouldn't we continue?

> @@ -776,6 +790,9 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>  			goto retry;
>  		} else {
>  			unable_to_lock_message(ref_file.buf, myerr, err);
> +			if (myerr == EEXIST && ignore_case &&
> +			    duplicate_reference_case_cmp(transaction, update))
> +				ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
>  			goto error_return;
>  		}
>  	}

Okay. If we cannot lock the reference we now try to detect whether this
is because of a case conflict. That only catches the case though where
we have a case conflict in the same transaction, right? How about the
case where there's preexisting refs on disk that cause a conflict?

Patrick
