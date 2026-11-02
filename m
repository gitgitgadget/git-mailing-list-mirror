Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608181;
	b=3nhnt1/wVD7f+I34MaJ/ZcCzQuZ3o6fW2YkdcUugMYde3tfzSNBKdmyV4f542WfLhEwD
	 O+c4caHkXySLWQYOTRU8QOLK62IpOkj3Gv9lm4xFFQfJXLuZw1gxfWN7+CBRUwX5hUlCZ
	 ZGKC65EqVmYmZGj96FaerjQaHo9ANFRJrQo5fWb2r+phu8wVXUMFSc1LhlzND+R2cfqrF
	 uwq1DN3gnhi5KTdW4w1gnawRVkfVeCARPNc/j8sddeKPLuL46Nb09QqJ3F59sG2KTbhsJ
	 ObXcH/NA+XHBwrxZ+i31WiqMR7JNiTnaQRsU8NtI4cdJU2//7+s/5ul1Yzh1Ql7+OoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608181;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eKmMw6lfA7brvcOCaLCT+f8Ykopf4OZ44sp2hUgcG84=;
	b=KvLL3hp8jRXgXWK4pVaMsHKJgsYbhwdZNTI4sBus1qEsEVJ9A2Rq9AUGeFuohHmDdrQR
	 tCJDcNB1m0KnheyKDHQv7OIKoQQqfmsc2vCuqBtZR84w6pCT+BSVfjS9KO8lxInhXpzK7
	 O79kVDaL+IgP2v54Dm21Ey56ZMd2K9eimgUSu2XtM2FfON5VNYac0uVCsUQhYgzvVWXyK
	 slQahQLZfAJvKJxfeSPWg2VpB5yhHFbQpcddim3i0qQsiG9iBTg7cARmCBd8Yf6GBNIwi
	 uFUckbFTyJCTTkpdojjNE/9CLWVjTQ5mEDrohOR5uaZsnWLaIO2oFoFqOKMFekOpuPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=B96yxMrV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=EFsExCiw;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF53D606A336
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 08:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF53D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=B96yxMrV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=EFsExCiw
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E14C51D00168
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 03:29:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Nov 2026 03:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793608179; x=1793694579; bh=eKmMw6lfA7
	brvcOCaLCT+f8Ykopf4OZ44sp2hUgcG84=; b=B96yxMrV0F82JDKLXB6ZQ2NxXy
	nbb8im1AxnohFnRTpP0NHc7mlVGBdoggRg6YxdkMtZq2AguUAVGipYiSRuloUBnc
	euMKA+koXt5T8wFLysTQeg9PHRxd9MQVLNOD07AKTOSObkuhPunt/AnbFrIFmM8x
	KiNsAnD7CaS732q+VYKfNbeR5HosRab4hFiPYKjj9xCFlrQi8IYiABbzv/d6osj9
	Oe2wiwMXXgYDX8d+nCT4P5tPVI4dKJWki3l73hxr7krGCk3G7rt8sSVDaYPU1fi3
	FuJXLKE9clJvFXt0fa6/z1qxvKhE4NH9G8KxSMknR/s8yStsTkMXgiTRnGRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793608179; x=1793694579; bh=eKmMw6lfA7brvcOCaLCT+f8Ykopf4OZ44sp
	2hUgcG84=; b=EFsExCiweVpdr559OJEaDMYW5b9kLuxwF/1H+qhr4blArWI+JU8
	kTXDxi0qQWHkA9su/0TNWJiLPXigQokutx1HNSoecfH+pMSb9sgg1aDRXjbgonqx
	7rJKI/sJrOZdlcAPPCmtWC/Zjct/CZEP8n1DlzKFXcAndTLu9qvI+T3cEHJmPjUL
	dD6TmZMR3ket9lPX1KmGYW7icPQ2DEU9iU3czZ19bsNsOOoid1LfV5CMF2TiJWwh
	/HvNq4krazFOGcHURfCBeouM8KOV9kLXMp5SaLiTpDryeNtRFKS1dAfdV+IGjKhU
	Cc6D7uoCXEcjytagKO+/VEQ8VpNpt+c/MFg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793608179; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ZU5JNyPnBe8h+xN35A2Q0h7GDd2gMGeMovwh/adf8hvUKo4
	U3NzXTpkXXiDsbnAe7guuIJAkwzzGn7qt16ZwoQxdtGUBq0rLst1PvvES9kb721f
	F+aFdGCzudzKn3iuR00Sp+Y7d8phNcEQP1/6KyKohl8M+/rl3WgsYs7CwcB1sqEE
	nVcdaUmkMutE4uYoskE4RuXDpxquaE9PsJb/Us99uzSI0bj9VJ9tUxAjJ/qgmkVh
	3i2/pVLlgmyCHgywjuHcZWCNBTPd6p4JfiE136WOwd5MJ4M6hBmqDWiDvDBojz6K
	dR2JBPUuvVaToaDBidBNBtCCUVikMbIx5nS/Pvg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:8jVbpfdXfAnWIEE+dJWv+9LajJyOirP0OZySy6/5MVE=:r30EK4oMTxG6hoOfiq1C20pKFhOLhK3POIdQsxYCbJI=;
X-ME-Sender: <xms:80noakDpmIPLSUdUUhwMpewpXzA0EgsFKrixtmvf9ptjZQ4EfpJmVg>
    <xme:80noata21wsie97tZQo3WuZKBDLlt6FzqpPxrg7_2rHQkdm3WjmGU26RPH0Tdyd8c
    p7nLMXh8u8jQiriZR0i0R91clu5FfOBHe-cxDdm2cRJmLsfxnpkUTEI>
X-ME-Received: <xmr:80noav6vd50Qs4yKo53n5KmP2p9BlTer03H3Go9QmT1Y8A6HYVLD0BXWiEvvx4cMaE0cnA>
X-ME-Proxy-Cause: dmFkZTEpRLI4PP9Vp1OY4W3tZb7wJWnAy+xfJ/bkJQQGuAdgqtmVJs7ZoHQnRrUR0yxAKA
    iFxNrx5DzdV7M2U/CQtxMeeER5xrhrVzKx/2NOD2y2jhxNtwrmbHNNdGmJ6tI8/wvfGLGO
    1v5TqPzHEJEgPc/g2ndk8UA5KiJ67b5fbCu4ue/+gtObnNMAZOOXbi9GDb8XyUW62uGL+f
    SsEa/GpRROTtTWpuALVhfyaNx9CETbgrrXaGDDui2z7cICdr7iXxwe1KpV4QYssX5sBWbU
    OgifvPdtweTSM5aXgfgTyan1cOM3L3Wiksv6RtsGcnKxo1MW43Rh5tGCLjL8H71uEEwveD
    rIZiukKcm/kVdLNai3OeI/GNBn5d6i76YIawiDKx5/OXAeRCJXrjgnSUq03+1M0BFlEedF
    fCz58wjSch5v6uR7zRjS65ero1VmmfcYXPPX6NeSHjjyWv8N72667unWVe+rkFTFK4jVEP
    +kMsR5tjPF5vVoqllSHElVb3V1oOtDJh+PtSeu5aiVyQ+vJp5F1wYxmOkrstyXQWGCrsQ3
    rR/qhItDfWHJY0rvFA20Hr8RLpqLlCkmuCgG6fihC64dDczW4tfnTZyzvJ9purLPKe8iTt
    sljjFEG2S1H0VFYG9KGwf1Ez8eH6QQ5VOIXqXCoHVIjkHw5oDFWHYBpgPUkg
X-ME-Proxy: <xmx:80noamZN3ZvSJxAnbNdboZRSSP8NdrxbFTGuMJieDhzW4jr99pyGlg>
    <xmx:80noamhV4TPrdN54BDZadVPcDdxNpNRid3sKrdTdTD4G7h1ol9_uOg>
    <xmx:80noav8miXkswupy_E8yl5AoO3jOCr6JkfwaUbTX2xldltrxhokU-A>
    <xmx:80noapr8u2POQuZsjvft-rCXwlEE951f5IovgZfxd035l1-4LAt1FA>
    <xmx:80noahywFPw5P0oEMZNfquSZzbU9MwawHiK97GpuQhi4MpitVGXOu5Zr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 03:29:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f7394b54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 08:29:35 +0000 (UTC)
Date: Mon, 2 Nov 2026 09:29:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, mail@thomasbachem.com,
	ttaylorr@openai.com
Subject: Re: [PATCH] maintenance: trace when auto maintenance skips due to
 lock
Message-ID: <auhJ0B_1__9z3DEC@pks.im>
References: <20261101105859.25579-2-pushkarkumarsingh1970@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101105859.25579-2-pushkarkumarsingh1970@gmail.com>

On Sun, Nov 01, 2026 at 10:59:00AM +0000, Pushkar Singh wrote:
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 81cecf6b6c..e73d1f1d49 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1409,6 +1409,8 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
>  		 * recursive process stack. Do not report an error in
>  		 * that case.
>  		 */
> +		if (opts->auto_flag && errno == EEXIST)
> +			trace2_data_string("maintenance", r, "lock/skip", "exists");

So we now know to report failure when the lock exists already, but in
any other case we don't log anything at all. But wouldn't the caller
want to know when we failed because of for example EPERM, too, or
because of any other error?

>  		if (!opts->auto_flag && !opts->quiet)
>  			warning(_("lock file '%s' exists, skipping maintenance"),
>  				lock_path);

It's quite curious that we only print a warning when `git maintenance
run` has failed to acquire the lock instead of bubbling up an error. I
would have expected that we:

  - Exit successfully but print a warning in the case where we are
    executed with "--auto".

  - Exit with an error code and print an error in the case where we
    execute without "--auto".

Silently swallowing the fact that we didn't do anything in the latter
case certainly feels wrong to me. And git-gc(1) for example dies right
away when the lock exists, so that to me is another indicator that we
should follow and do the same for git-maintenance(1).

This is of course outside the scope of your patch series, but if you
feel like it I think it could be easily fixed while at it in a second
patch.

Thanks!

Patrick
