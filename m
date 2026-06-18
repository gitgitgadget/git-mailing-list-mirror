Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A5F3438BC
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802190; cv=none; b=LZL67A8Yl0FIglviIt1AIfhMvxAlIu2i5XTQk9ggZx/VXGWQHklbwgr8EByTb5WM6TQ4I7OEnGXF1UEMc3lpbc0OPTwT+IUkbdiguBo8JYZ1or0H/mWIO5o5c74xcpOwCQppN+osQ0AtRpoobA7WQn18Q9P0PiJLWxWNpoIoOHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802190; c=relaxed/simple;
	bh=JngWDhLG7yIBeS3LenVJR7XO1JsAgJvCrVqZlL8Q42U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DuSgCu9nwm1f+qEJCWAGDGz6uVJXTFu7VOSeYgYJEOGEnRncoOUj2wvha/I3/bj1z1RPC7TBy4VOCzYZ+f7Qnu/AV2VkPT7kXffhsI/u0ZS5eqVDW9nYwRjxxp8fcs42Fj8cGjBxImdrBjEZHK7pbvSId250wmslXqgBCyimOT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FuvQwbO6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IVN9r6Le; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FuvQwbO6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IVN9r6Le"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B6B0EC00B5;
	Thu, 18 Jun 2026 13:03:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 18 Jun 2026 13:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781802188; x=1781888588; bh=f+d5FbYFTB
	X4VF5/YgRjoKX9rThfymcQTGdirnE2bEY=; b=FuvQwbO6pw/LP7DPkdIIo/nyz0
	PDj83L0QcpYZ0uNTWT9017tEKjl25Z1p/2cTFLuBOxNZ1Y/ogwLaGCd/CscI24Ta
	O5sm8iy0u+U4eqZS9coTkKT97ongcGeik6iY8/se1DtxmsZj5bUVdg20j2z1ZBUS
	NO2ELrZZzLDxXRZXne5MMnYYH0HUHaOYf154ifOiMAtaZSbR6ZrYoaBMrQu29Pd+
	xh0ROxGtUY0CsA73aACDUG4a4wJckRTRIw1VgNhBpyikQj84anJr1YQ6UhzRDzKA
	cJMumyikTHYc9fjxr/g1glgaquKjk+6Bi2hZQidSU6O3Bi+1TIKw0nZp8++g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781802188; x=1781888588; bh=f+d5FbYFTBX4VF5/YgRjoKX9rThfymcQTGd
	irnE2bEY=; b=IVN9r6LeAQODeTIDMebj8L7SB9tqVtHbBzNd5iEA1AKGarCkNfw
	kZNsKzT4F5rv5fYnbQSAoxcyFu3LRyS6AE0f4VpFAFjaQZ9DqUXcSo1J2p+gRXd/
	rrKB/Pttmj+SlL8OKqkXERIK0b8COjTJJVgM3BpIZrV2WylK/MAsBYINI+PaqI4d
	dFP01gUYf3xBL/ni8m40fMuMRNlqA3JwK4O86hB0K4h1W0oj8RYfGMOp/iOv2og0
	JhJN6icoVBLxiEw1Zm+QfIctL6QrMnmBo257Bm3vjCB2GqUSiB+89ywt6TekmM6b
	nP+PwPUEOkU0nZuBBcsGkQboUH8RWWRWlow==
X-ME-Sender: <xms:zCQ0alpwArsLORoEuID4YgBKXKJVZG6oxCWNSrpWGClfo6qjMxsm8Q>
    <xme:zCQ0aupyIdNLZLEzeEbNYxeX1whLiAHxnvGLHFm6-JrGAJhe4T7YG2O8Ls3IVOllr
    u-uqRsQm6Ve0XWiDue31ngoCqcPrIQbKFIN83gAtEPY5Rakfw5lIA>
X-ME-Received: <xmr:zCQ0anM3Hjz6AlznTb5zZIXXKvp7Qr2FVarQ_3ivj20KSgxsBNHDx2v-t4Gacobuy4mcObbL7n-Mc1QXgOeyyLbkwcxbFH6Xe4UE>
X-ME-Proxy-Cause: dmFkZTFelVzqSk82mACs49Ndau9ZOe5MZqUGmD8SbTO1ODpPm3cauvniLFWxtsQso/y/9d
    WoT7L3YviplgrI+1dlrSWWFlgIGGDgMAfyTqCj8utw5Gfa9TNS1pdh4B7oAz8uYbZGqOUt
    skGSh+S1jP2QN7Geh8AUP40aH3fAwrdE7tQdRZTZWE23p2BZRwdefOH3yb3vRY5ZQvgkNI
    DURUkUGkuOMiHdKcuf1aow6iKk4UatpvN8Vf8yQlJ+kcDR1mH+bb/HMqGFd/iOTkaea66a
    iHgd8BA+f61vkLaQYY3BQes7pvtHFz+eAua/omd2xg6hucxfsYbaBMCbac8x8SX1khwBVD
    4gpWrodIb+Aj1DZm8gMVJAFwP+xyGVZF+Ca3+4sbYh+/0NGO9upQdg+ikMCxLZbJUoxPpU
    c0Kp/Js5HXmoQ+tiEHYRQIq+jBO27aEVxF8ChW1mD7pajHHRHI5izS0iD4kJFLEaRymVgG
    EWE2EEx/pf3TRg6JtU/gOuY7ouMxe4JSYS3yuLTMm3dfqrg1LChTmSw2NpZPHeX/p4VaHY
    74R4/LWLVRV5HPZoZOPAnfC2Z+yZ0EV0bhiSSKiG6Yw7h/f3ZlnWgDP3r9sTBm31QFTIax
    0whc//XiUj5kW+bmMtiWBaEuHx2YiI6dvOKQjQ1EHuFN+YJn4OfaXZfCp6og
X-ME-Proxy: <xmx:zCQ0avz70m_N_PsCr6JXaJuNI5R8WrW7jhYd-klyDxXxKmO0H5x-kw>
    <xmx:zCQ0agvoyqyBvUFSTOb8054GVcFky19ptqCU8cKdQC9JWfxcvO9Z8g>
    <xmx:zCQ0ao78mKEzZysu4mf4Wbfx1sl7hscatsp00Tflhj5lpZ6dorTzaA>
    <xmx:zCQ0avQv3r-iHwU3OgrWB2Jff_pWFQfJyxKlSTLN87Amr37UZz-fyA>
    <xmx:zCQ0aslWsVNcNPtHlNiZgu4_lL2tjuy8qOcnDhgZLovuNoFpOf0T70JM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 13:03:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] zlib: properly clamp to uLong
In-Reply-To: <pull.2153.git.1781790619424.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Thu, 18 Jun 2026 13:50:18
	+0000")
References: <pull.2153.git.1781790619424.gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 10:03:06 -0700
Message-ID: <xmqqzf0rrdbp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The original in js/objects-larger-than-4gb-on-windows says things
like:

+	s->z.total_in = (uLong)(s->total_in & ULONG_MAX_VALUE);
+	s->z.total_out = (uLong)(s->total_out & ULONG_MAX_VALUE);

Your patch ...

> +static inline uLong zlib_uLong_cap(size_t s)
> +{
> +	return s < ULONG_MAX_VALUE ? (uLong)s : ULONG_MAX_VALUE;
> +}
> +
>  static void zlib_pre_call(git_zstream *s)
>  {
>  	s->z.next_in = s->next_in;
>  	s->z.next_out = s->next_out;
> -	s->z.total_in = (uLong)(s->total_in & ULONG_MAX_VALUE);
> -	s->z.total_out = (uLong)(s->total_out & ULONG_MAX_VALUE);
> +	s->z.total_in = zlib_uLong_cap(s->total_in);
> +	s->z.total_out = zlib_uLong_cap(s->total_out);

... is an obvious fix for that.

> @@ -60,7 +65,7 @@ static void zlib_post_call(git_zstream *s, int status)
>  	 * We track our own totals and verify only the low bits match.
>  	 */
>  	if ((s->z.total_out & ULONG_MAX_VALUE) !=
> -	    ((s->total_out + bytes_produced) & ULONG_MAX_VALUE))
> +	    ((zlib_uLong_cap(s->total_out) + bytes_produced) & ULONG_MAX_VALUE))
>  		BUG("total_out mismatch");

Because we now clamp (not "taking lower bits of") s->total_out to a
value between 0..4GB and store it in s->z.total_out in pre-call, let
zlib do its thing that increments s->z.total_out modulo 4GB, and we
clamp the s->total_out (before incrementing) the same way in
post_call here, both sides of "!=" above even out.  But the comment
before this comparison that claims that "we ... verify only the low
bits match" is a bit off the reality, I suspect.

> @@ -68,7 +73,7 @@ static void zlib_post_call(git_zstream *s, int status)
>  	 */
>  	if (status != Z_NEED_DICT &&
>  	    (s->z.total_in & ULONG_MAX_VALUE) !=
> -	    ((s->total_in + bytes_consumed) & ULONG_MAX_VALUE))
> +	    ((zlib_uLong_cap(s->total_in) + bytes_consumed) & ULONG_MAX_VALUE))
>  		BUG("total_in mismatch");
>  
>  	s->total_out += bytes_produced;
>
> base-commit: 7a094d68a27e321a99c8ab6b700909e503904bd9
