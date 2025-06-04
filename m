Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F6F221F11
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749022575; cv=none; b=h/vHOW4BDeAlXfoWc1tiHkr8wXlex4X4mNIVu1RWaK+DvVMOWcqWT4HXGF3cVK3xn86q16mEI20APEqIU1I/lPTxn8gWKryj6sodkTal8D3cxj+23WGICBULHqBzyO+hLmzgF1PMg+JOwQCHW5+8/K/8Xi6tagb/Pc54KfaLOa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749022575; c=relaxed/simple;
	bh=sifj5ua8Wi7DgwBznyMnyUVDMt0MCo40pC2amEC6eI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrO2jRNLhy5p61MoruoUNXM3+W+51HHZeM6Tyn2QHPHQ4nG885Imfg1bD0VxWmKVhYA33cixD+AZOqdbDi8nSME3k8o3H0EkxN4uYHTR7aP129K6HXZLKY8KF66+QJZmclkj6ddV6navdxUftNz09iYV8hJqRiWhHuzS3ydSyWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EHEAl1QS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TGY97Lcp; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EHEAl1QS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TGY97Lcp"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D00B51380407;
	Wed,  4 Jun 2025 03:36:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 04 Jun 2025 03:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1749022572; x=1749108972; bh=B2td8Z6bCO
	su22BkWN7sSYCGmmZvqsDWoDSBRD4U0TA=; b=EHEAl1QSpVXIV12ioyXv7aGBfg
	A2jNxK7MvQmURTNc4Ap8Khv2wAGLXYFeU9i8D+mRAdYHtSD5tuBHvcfMOGrcoP7g
	PaBQUll4MGMclAAFDcEenwsIXzN3SilJSBa5e0ht+jPEnoZbh5+5/I2Q4nPsyHYS
	OgByrRd0rbjkok7WTCN14lP4yuD4AvvwdSWZOMxfAGI4lKg/MY+MIp/sFu26CoTc
	CSHMb0uTEKWY+EzrNh3WO5us0YK+Rja6D7XClOAJFrPAA2wwBp3GciMdelC+NJod
	JDs1o5mkMDm56N/ImqgWTcnGPLChI26+nxvsCN85Yc1GKIkX51/SW8wOBYqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749022572; x=1749108972; bh=B2td8Z6bCOsu22BkWN7sSYCGmmZvqsDWoDS
	BRD4U0TA=; b=TGY97LcpTzaiG4dwEJOesYgjhGPETQ0sjNN9/wbRU5iLhn+4DlI
	xmP++nq/1N6P/sp4tyPqxV5fzFMzxKcP+TxBlSOLzT8/4a9rnQa7JXIEqUfugYcr
	EFFYNqeYui3qEUMgTcNQHjIvMwskSEILbeITVnBFNyl7FxWBOYbt278m8CuuRdAE
	bRTj1h9Qe87eW81W5aR1nHjOfnUEORcOAuLo754Zv7S0QTGqmGRgotg/YTlivoqT
	u4R9OxFzCHz0jTSjqmrmoVabP9P4KiQNBNvne6in1a5a9ESd4nsxjK6SgTlv08iH
	0RfuI4uZV3YvUSFXgoJ1dNKX6SphLkwm1Zw==
X-ME-Sender: <xms:bPc_aBwCp2ciAkOA_3l9Y1rOdOyirKgWQ1j9ZLosaEL0kkq1HKv4-A>
    <xme:bPc_aBQqx68s2-3mHsEmewxW0QEy-8c0AfjZEjExspGawMXbmtVkepgs1ugo5IPl-
    ZVgauGQ9u7TfYJyCQ>
X-ME-Received: <xmr:bPc_aLU6a-Fd_ka3Gwbq8obgM9t0N0QhZ6XBHQ9v_pivwlX0DbpB8cSnNsc_MLp5dD2jsjVCeirutxhpNMrXJPfxJ3QhYJStWrJBhQAaobDb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddujeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehmhhesghhlrghnughiuhhmrdhorhhgpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bPc_aDgJJqvwLZ7HgVqOaZFi_oVIWiOgLn4BXPEYNpTBrjqeRDYmQg>
    <xmx:bPc_aDABXld-aO4OJWzxHdjvJWL5WwrPdIBKqZIKTph0ZcV452YA2A>
    <xmx:bPc_aMI9PuGiwf_-TkIRihSSSR1oNBiXjkpnSEQOFPaIZqRKHSW2LQ>
    <xmx:bPc_aCApcnDYVKxpACaeaLq9PBuj1lEqp4LQdjI9_oyKFc2vO6noJQ>
    <xmx:bPc_aJ7WHR9ED05oWkPi-GL2tGgQhRTXJ1ydmv92LwOwdtOnRS7Ii4u8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 03:36:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 508457ce (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 4 Jun 2025 07:36:11 +0000 (UTC)
Date: Wed, 4 Jun 2025 09:36:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 4/4] Fix unreachable-code warning with clang on Windows
Message-ID: <aD_3ahX2jyrtfvjq@pks.im>
References: <20250603230646.2322671-1-mh@glandium.org>
 <20250603230646.2322671-4-mh@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603230646.2322671-4-mh@glandium.org>

On Wed, Jun 04, 2025 at 08:06:46AM +0900, Mike Hommey wrote:
> ```
> refs/files-backend.c:3187:5: error: code will never be executed [-Werror,-Wunreachable-code]
>    3187 |                                 continue;
>         |                                 ^~~~~~~~
>   1 error generated.
> ```
> 
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  refs/files-backend.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index bf6f89b1d1..af21eb80a9 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3183,7 +3183,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
>  		 * next update. If not, we try and create a regular symref.
>  		 */
>  		if (update->new_target && refs->prefer_symlink_refs)
> -			if (!create_ref_symlink(lock, update->new_target))
> +			if (NOT_CONSTANT(!create_ref_symlink(lock, update->new_target)))
>  				continue;

So the story here is that there are two implementations of
`create_ref_symlink()`:

  - One macro that is defined to `(-1)` which is set when
    NO_SYMLINK_HEAD is defined.

  - A function that creates the ref symlink if NO_SYMLINK_HEAD is not
    defined.

The function won't cause the error, but the macro will. So wouldn't it
make more sense to wrap the macro itself in `NOT_CONSTANT`, like this:

    #define create_ref_symlink(a, b) NOT_CONSTANT(-1)

Patrick
