Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7899B23C8AE
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738944769; cv=none; b=vDUdsISoB/0Igr6Y2dDTCbjLTRs10aIsOzmT3NvwdDAym53pILvhilRHV5v0rw9b3V70croEctqtFc/WKZ1HU89zPgnlZDdysSMUooO5pE3GGe6CPXq7ISbLs9km9LxHKzA1zmeWgm2oPIwbgpEDV8qF3kuoqo5CVyspZ9R8SkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738944769; c=relaxed/simple;
	bh=wYrkKF4LoGpzr7IdLo1+YdxFFuJSFblRZvne+I1pFLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6sYv2atGAFwlEAB78Zr61TDvObE1GQrMy3csRj+g09ih4vUirnmOcx+rV7Lcw+u/UpXez+/IIs+o4oOhPkN0qUJXiY3aM+yswotY/NmZ60NBX6gkuBT8RgVz489XmDjgrYof8yZ0tvJzvLZNFbFpB1aSfgVzyv5s0meDFa+y5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=abE87ZmZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xgof7NoM; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="abE87ZmZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xgof7NoM"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8AF4B25401AB;
	Fri,  7 Feb 2025 11:12:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 07 Feb 2025 11:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738944766; x=1739031166; bh=VTgAXE47Cq
	+6Zx3QnRBm4mok74mIL+lYNq/mrVeyFBk=; b=abE87ZmZjC9Yeu7I1Ip+mUSPXM
	hhTANDP28hOREAIrnIHjbaMhiCPa/WqPLHP7xZxgGcRMg4oTX+h9d/NmdUuWdKnt
	zzFNm2SlBjfeQ9KzDt6HKygFC/xKbqDB/muDhl4Rf7q+/LJbpRGOwVSz4iLX1Gn3
	rQRcQwnuPy567kcjPPatZupMjZY6I1za/hrvju0fwHyI8ujVkU2s4W5O13hW2dVl
	J4iIFdUjLtF9n2QH5mjY9sgU2HrDlRdyrtsYInPua220tpM82C93Uz7JjfWylZGx
	5JLuhneuLChxMh/zpZGphZ0So9HFqv6l0RKCfsls6frMuCQ4YgI73HITr85g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738944766; x=1739031166; bh=VTgAXE47Cq+6Zx3QnRBm4mok74mIL+lYNq/
	mrVeyFBk=; b=Xgof7NoM4+Lg0AFi+Hu7WS8zrsPZajJG8gfZE0KG0/jaXuFkDVq
	5srvv1Fp0fZy1yWmSwNN67MIayCaAFzYtm9zkq+14imVW+mwBmgEiyUNsiCklI3D
	eGNglwqzvZpOD86kxR9R11EVeLsaKzHF08Fl1FMzFzz2qz/2LLeZoJgiWFN2Et+g
	oZFYzxaVuxH56f9WmN07SJhJjTnTeZn2T+2pn8StI2DQHK7LkdxWzUk1hgPGkElQ
	Bbpmis8a561LTbnb8C+uBFHvqIqo3Eyg4+hGsxnpq/4g2nWarJUtTITKB+Ha/pHU
	RTMv+KYgvs0cusWxloCQkYjAPwBzavfHfhQ==
X-ME-Sender: <xms:_jCmZ7-OWrbAkvfplH1tIA0mRM_UJOOGEGjRFyXCnCfUUjYr4-jVJQ>
    <xme:_jCmZ3t92IKwtk3kphunjSGC_cXJFfNUooPe4Bkyj88OPw8ICFZRwNgbCJvt7icOk
    6HLJ3khhkpEp44JWA>
X-ME-Received: <xmr:_jCmZ5BHroWH-xbT9oVCe8jfZNtCu1ZrVOciWnFUZMeM629zwaSdCnH8hDWhHQYwQmsu1s9GOgU54xsIgpAHo8yjpWkXVzang9H2Z5gj9MCJB0Fu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:_jCmZ3dEI50ttTU8_8KVif0pOzjpmGKbd3qqLQaAuf80yvIgehQbLg>
    <xmx:_jCmZwPVfiOcVpFv9dTy8NwBiBu4CYaAlyl5k-by-JuizsMEspfhvg>
    <xmx:_jCmZ5kADIq4KctlAABrJ-CHTbKKl9waCvc1ltEUUN2q67Zv9lARlA>
    <xmx:_jCmZ6tITz1wJr2CvoAKXksD1WTfLHIn_SsKnWKqJn_W1NX2uh4lmw>
    <xmx:_jCmZ1qAsEKVUWuGHdzGQ1qw2MZJKrru-fZyLNAafzgHb9C-1iBFWBWl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 11:12:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9d2b6399 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 16:12:43 +0000 (UTC)
Date: Fri, 7 Feb 2025 17:12:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com
Subject: Re: [PATCH 1/6] refs/files: remove duplicate check in
 `split_symref_update()`
Message-ID: <Z6Yw9RK6JRKERmn9@pks.im>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <20250207-245-partially-atomic-ref-updates-v1-1-e6a3690ff23a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-245-partially-atomic-ref-updates-v1-1-e6a3690ff23a@gmail.com>

On Fri, Feb 07, 2025 at 08:34:36AM +0100, Karthik Nayak wrote:
> In split_symref_update(), there were two redundant checks:
>    - At the start: checking if refname exists in `affected_refnames`.
>    - After adding refname: checking if the item added to
>      `affected_refnames` contains the util field.

Okay, it took me a bit longer to understand what's going on here. What
you're saying is that we already use `string_list_has_string()` at the
start of `split_symref_update()`, and if that returns true then we would
bail out. Consequently, it is impossible for `string_list_insert()` to
find a preexisting values.

Makes sense, but I think that could be explained a bit better.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 29f08dced40418eb815072c6335e0c3d1a45c7d8..c6a3f6d6261a894e1c294bb1329fdf8079a39eb4 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2846,13 +2838,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>  		if (update->flags & REF_LOG_ONLY)
>  			continue;
>  
> -		item = string_list_append(&affected_refnames, update->refname);
> -		/*
> -		 * We store a pointer to update in item->util, but at
> -		 * the moment we never use the value of this field
> -		 * except to check whether it is non-NULL.
> -		 */
> -		item->util = update;
> +		string_list_append(&affected_refnames, update->refname);


Nice to see this and other code removed.

Patrick
