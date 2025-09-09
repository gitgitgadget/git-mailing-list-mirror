Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F71B3019B1
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 07:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401808; cv=none; b=GenKhaevVNg4uDy6Vlr/Q8i4hLcU0P3qiBS0Kyb8wH0c/LE34MdvhHabA5xlMWIB95AHpurngKOfSMPxlQ9dzW98ZLDHXLVLvs2bO+8qxWTyKN3yZxvrQsK2HEoyjDMxldiLxHXkK4UD68Iwcc79RRxMt430cpZ5vHpMMDtqOtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401808; c=relaxed/simple;
	bh=2dKLJYm2bGfrYB0MH4Jk8hZh8kucm8tyIcrTEGtczPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgD7LgJl3iPx6iAbs5tMOejJnbwBrJ6SF1hsOmgK/Vx1+MQc0ZYrzjoLc+RX4SYkVYndPhsGvxWubg4B0nlfLttlMqg8md34oSSX5UYv4i0bS6C34TgeENCpmPlp5EGv+jGLCE/Y2PnEZDqL1PK5MsVyVrAnrYzqHgRE/iwQekY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A+f0clIV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n7d07Qcj; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A+f0clIV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n7d07Qcj"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id D3559EC01D4;
	Tue,  9 Sep 2025 03:10:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 09 Sep 2025 03:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757401805; x=1757488205; bh=L4cA/Hcdli
	kHg1oyEfptajGYG40do1b9ht8+cK2MBY8=; b=A+f0clIVc+8LAqzvZDVZKSQ+hS
	AMNOchkOhW6ZmTLLxdHgUSST0YKzNmr0heI/uMdToAEzFQObJtJip3Q1hzPo5R2f
	ZxkhVTNKHtJehX7fPxqdoecX3TYvZZQhKWzK8n+n3LbPVr7awVVdcMcaIJ80+184
	W75oEeAWZaEH0bOP+dGDqy6FDqe4RDs9sZD9YD5/JpnxWThvpqWzpPuagdxnm28Y
	MPMxLGUB4BlIX3XysMQFeOD35Te7IS88nY0uJh91rD8n6EsRqX6tqZFKtRw4xnSt
	LLRbrHSJaSHdY+3RVf2ofHAfAs/NwVhWP98FnVLV+pS4vpT8yTRr1FGjUtUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757401805; x=1757488205; bh=L4cA/HcdlikHg1oyEfptajGYG40do1b9ht8
	+cK2MBY8=; b=n7d07QcjpIE4JGWSQdZdbvgIQHWq67UHks1QEV9IFB47ESnUzb8
	IQza/bwc0VcvTgOdUD7nObBUu+CPqR/sVxXUI/oxGEBsUHY4aIYYOJbxtZtFfwLg
	jbuO3bWEuenlkwHatMHhAt+GaSO2OOpPCHesd8yFZ3TWTbnKtWGRKC30t1sP42M2
	Uh5oUSG05kMGyco4tTXXgk21EyVAd1q8oU7NO3CUG8ioPyoQr6O5ON7I8r6qQvfW
	Uqpex6/vow4Q1TD2Y54W0FpUzL/4bvfs4863lObn8iuOUr+kodIswmjcJH85IFtW
	gG0P4Vo4Pv63AJ199oOD+6/9rFeDUu23qZg==
X-ME-Sender: <xms:zdK_aE-qgHEpoJC3Ho0H5mL-to0O98dOvFQQ53hyK7TNHZgwuTkBhA>
    <xme:zdK_aIMQshJ_hvu0rl0yalHFGdAhr4ztNZVekbHSm5j0EP8RclQ4ydwgKVp0eSYUb
    ENA_cQXzvmDyyhvKQ>
X-ME-Received: <xmr:zdK_aAfkC0mHNulFJFv_BSM-GC_474S-JW8NXS8Yu71RAPq56x0YJpYQXLafCXgMcBEeN3b1GRzAZYFd2ZK50AksBrdI-XeHvRaixXIX87A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhovgdrughrvgifse
    hinhguvgigvgigtghhrghnghgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:zdK_aPUdeEbr2SRzL90Nu7wrkd4CcoY3UUom1IeGyEgKVOhAikmfZQ>
    <xmx:zdK_aAg55wPVJsKAV8n3IQP0w_ZZTdqcBP39RRnrPtvlbHo8c0a-Lw>
    <xmx:zdK_aG_ASUBMvwUPSCCQi4moLDsLgSUMSdK4_6IncBgQB2n3oPrVtQ>
    <xmx:zdK_aKbqD0LkAyFtE6FcQ004eG7BftGP403cTvFiH66zcN5o6oskHQ>
    <xmx:zdK_aIC-mXwVdMsCGeap_RAllqyV8KrxfHg943DYce0WXogNPqIto2_z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 03:10:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id acd40c7d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 07:10:04 +0000 (UTC)
Date: Tue, 9 Sep 2025 09:10:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Joe Drew <joe.drew@indexexchange.com>,
	peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v2 2/4] refs/files: use correct error type when lock
 exists
Message-ID: <aL_SydrNjXdQrtFC@pks.im>
References: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-0-b2eb2459befb@gmail.com>
 <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-2-b2eb2459befb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-2-b2eb2459befb@gmail.com>

On Mon, Sep 08, 2025 at 02:37:36PM +0200, Karthik Nayak wrote:
> When fetching references into a repository, if a lock for a particular
> reference exists, then `lock_raw_ref()` throws the generic error
> 'REF_TRANSACTION_ERROR_GENERIC'. This causes the entire set of batched
> updates to fail.

This isn't quite accurate anymore as we may also raise
`REF_TRANSACTION_ERROR_CASE_CONFLICT` now.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 58005d2732..2730713d23 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -790,9 +790,13 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>  			goto retry;
>  		} else {
>  			unable_to_lock_message(ref_file.buf, myerr, err);
> -			if (myerr == EEXIST && ignore_case &&
> -			    duplicate_reference_case_cmp(transaction, update))
> -				ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
> +			if (myerr == EEXIST) {
> +				if (ignore_case && duplicate_reference_case_cmp(transaction, update))
> +					ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
> +				else
> +					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
> +			}
> +
>  			goto error_return;
>  		}
>  	}

Hm. So if I understand correctly, we now return CREATE_EXISTS in case we
have a conflict with a preexisting case-conflicting reference, but we
return CASE_CONFLICT in case we have a conflict with an update in the
same transaction?

It feels awkward, but I guess that's the best thing we can do. We
happily overwrite case-conflicting preexisting refs, so we wouldn't even
see EEXIST in that case. So the only case where we still see that error
is on a D/F conflict, and in that case it makes sense to return
CREATE_EXISTS.

I feel like this should be added as a comment though, as it gives some
important non-obvious context.

Patrick
