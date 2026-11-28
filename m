Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795836541;
	b=sbcFYAZfop5kWcVEM+6bBaph3Ahw5w2S+GWdrre5wA3lHL0c8/2bndLGJQurXO4Q4ZoE
	 27ChFX1LSayojc0ISxCS3tAnxXi8CQwBX+BzWzq+ryR2HTKX4sYu3cjodLFItWyV4rqo1
	 gm9HLSjhNKt0Rp91FFgjIDm910lH0ffBAO8M6ecHC7iFyK1B9TxntIDHgLoLI2TZVF7+9
	 NsP8i0E/qOn20mAlSeo95A7Y+EauaCHOFFfqOntd7Q4yu3c1Vy1GuOE4WlQDXsdP6r8Qs
	 kaF7YHEK9llGaLQXjE3kssjb9tuVuRJux1ppo8qq7Xmpp1trD8t9kFpxwpTCu1STTKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795836541;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zbl2LoqGawFS9XWHxkMyZHgO1jZ/oxHu2p6dqo7jX2o=;
	b=PdP686LIlsseDx8GwYS3/o8RbhFlVO936B4h+b91Xn7gVC+bK7tl11j7M7XyeeY093Tp
	 ttJW8D41uBToEEk6BYqBO421m0HY/T7SVEAYUd01djlmE6j5Rww74/TjnnqQQ1fNcqykS
	 +rJu4LMMqUXd553azTbN7txz5ycpyreb3c5nAzRIGIR3/34Fptp4lt3NAaS3ILHu0pNY4
	 v4n9UMzOaCUxQYZzbPY5MHmnXNFA5GjD7UrXscXTsnEYxZhkHUml31lS5EEe3fleiWvnR
	 OpwHMC3Eba+Ns7Kpzsp/BOxfgaqr8qm7cB2uhmBozPxZYRKJtwCcOofnjd2rDltPZBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WdFNX9fD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WSxR281s;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAB6606A31C
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 03:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FAB6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WdFNX9fD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WSxR281s
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7B2FA7A0517
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 22:28:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 27 Nov 2026 22:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795836539;
	 x=1795922939; bh=zbl2LoqGawFS9XWHxkMyZHgO1jZ/oxHu2p6dqo7jX2o=; b=
	WdFNX9fDPrwjr+Zl2Y3aHT8mtuE1/KLNExxfKKk1//QfgCqI7hc8iM5HQcH9HiA/
	0ZoCbL6ofuxVCeIL1dZK+6pqN30sNRQn0bWUAz94j/5iueRaypJLW/Bi+m3Kqkd6
	E+94CYfyyuoCF6lKKK7rx4xwWhytO28OMoyXKT8qKS43IupJ8nyq3SqyGLcw4aJH
	UMxWNzYvg3f7ppcox3BMIVcPV9cNH5dldzuVDyM4teS0YrmToWMLeD15D9x7fArM
	ImzFmGRTImyhI5HBwjZcb9wmsT5lUkzixRNZsyd6scFrKW9/L3gUTXP/kRbOs4Eg
	l2H5KDQJQAQkt3aoTQEQtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795836539; x=
	1795922939; bh=zbl2LoqGawFS9XWHxkMyZHgO1jZ/oxHu2p6dqo7jX2o=; b=W
	SxR281s6El8W9UcWxUOxp4MHI7ouLe/LSixlfynbbMwZsB8fcLIO523X2yc7jsvD
	3GskzcFFRGmCZGgIQDqJI2LzFYA6bXF0nlXSdUYwZD5ik0GdclW2clVfMxnZ8bYZ
	LSazA8vfCFV+xecGEf7jm4hk0lrKAUJ2wbc8JTQ+EfZ5ZXP/l+6mWuzbEdlrjih4
	I2frh8qopCs3V++IA1B1LteDWtTgnKmIAkSqGRy9VzzOuwBZls+fvtpiDc53qT80
	ugUQytjaxmsqfmlWueQYyxqNiMNDLvEnVU6HRyVvk75SB8smJ0bl8BksmurLZvcr
	m29iTChf11JU6GVf9Be7g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795836539; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:F8QrFZa7klczYeG9oiZ8ua8HgM/DbUIfVNI+s92AnAtZSqW
	+v8CPglMOQs7ZPoEPtvaxb9gHd85E6s1T3HRGr/bLvzyG6vVg8PiyYU3WAg76www
	7FxjSVX1k/0fbkl4cmRg/kVJAsAW1o5sxx3To/bDnHBRw6DyiKeEjTTNEKN0EvkE
	5DG9pOJdLci6SA5CERcWofgkLUZmz+8nNzomROMr7YgRw3XzodLODFHlTog4xnPq
	5y3OsqOJzdfIk+I8YaLwHE0H2tDO3uOPQetwjt+zBU88P8oZi0O8RHV8mNk6WgEt
	bj64ijFr9lc/RvJPOgbNHgD7W/uTtGI7ejrW58Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:GLU+6E0OOydVE2eoJhztXaPOHiQjsW1TIJh07ZCtPZo=:XwEzqwYn49LUPcqIi7QRB5Skbw6N8osgXy3frKhU8o8=;
X-ME-Sender: <xms:e0oKa93GOE9uX5xymsR-siEMfd5itRogtm_brGXfsdWn-yM8g6EYgw>
    <xme:e0oKa7H6wRqHP3p7VlLAH_UCoiTfUGFoMhs_Jja1E0mDWuZ9qciI_-Q3IEkxcLRN2
    61uv3VEUnHowR-bjJy2g0auUuTQFZYsnfYVoD-2louhFnHW96C3ZR8>
X-ME-Received: <xmr:e0oKay7R6LJWQoZSb6fSu4DEKc6qpdEYmOGlh9PeD_rq3BXY5sLcKFuCh5TJRteTsvj-ENHzkUjlK-tta8XTZ0pjP82BVTF8sTklyOM>
X-ME-Proxy-Cause: dmFkZTFlZKvmbZnj35QRBAb4gRqPpwVM+WtxjhWL3VtVu3k0wucVhXwvE0/D2wDeV4KD2f
    hBZugIdcAO4lsXxrZ7NnJDyESKsZuO7q4jQCnMZlIb5/0vRVMhnLxA1dPgA8Jm88i5zZtw
    SJiV9j+7PAwn6FfPsYNFhoq3WoTon5oDBz+8chsjicgvzX4MiiBWFGb6/PVv3TjAqhH/lq
    qxWBaSBxlYnuX6ZNoo34SM4Y59IKf+CM/MIYBLpc8tLWJLVTB3JVQXERdfx/YzgCp0krUx
    sn5SKLyXDlEK2qVbhbdIzdWPS9oB2o5we4KVZ+62THLiQkX6BMQvBk7uHpNOtFoteoIAeI
    81rvYtpGf24QasAF3jQvroneIjs2TVj38vtF23ClYi05iE1sF/J5emuM/ktCrjJAhMl07m
    FDLYvbJqFeSGsCTUuwpjHjSrOH+fleU/zCW8fB+KQkS3aJqRCni6NgFOpuU6CKotlE2aAZ
    OP/SeKk95LApjNA7lxrlD9Tlp9DPi3/Onw2aqbAnjihT4WKKRt81IG3tXF4kNIY6VDVYcC
    NrXUruy0LKQ2sXEPMUcAecFDW2a9YQl7JVwFgOAwJHvU8EB2AgYSvfyNEwf6CkKlh93ZDj
    4HvMQ47/RigT6lUIDBpjHDHKiuHXC5mkOjv0cpKVrmwlWr35eDGNGU6Q6MSw
X-ME-Proxy: <xmx:e0oKa5tymOxmkQJ424hLAnbYGPwCcV_2P5mBI4BEMuDLCenoBdzDSg>
    <xmx:e0oKa75DBXIgTQWsJnALVL8KD7M5WqAd1UtGaZQtTivG_zQKXZ_Ynw>
    <xmx:e0oKa8XZ2MyTqbfP9FTDFNKQUzHU9RJ9mA-UrjJ-drc_HfUkpf9DpQ>
    <xmx:e0oKa1_Kgiv1AjTFxwQ4aYQc9XpxLOwfR-RrnrPR_CEKvmo3mjDyFw>
    <xmx:e0oKaw4eGKrzrr4Zcczp_Lw3ElRSkSDWH2Iu9elu4hPr-rp2VhNy1UvG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 22:28:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: tboegi@web.de
Cc: git@vger.kernel.org,  curtis.allen.smith@gmail.com
Subject: Re: [PATCH/RESEND v6 1/2] read-cache: do not trust a size change
 when conversion is active
In-Reply-To: <20261127194241.10085-1-tboegi@web.de> (tboegi@web.de's message
	of "Fri, 27 Nov 2026 20:42:41 +0100")
References: <xmqqwm1no29m.fsf@gitster.g>
	<20261127194241.10085-1-tboegi@web.de>
Date: Fri, 27 Nov 2026 19:28:57 -0800
Message-ID: <xmqq8q2dzlae.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

tboegi@web.de writes:

> Helped-by: Torsten Bögershausen <tboegi@web.de>
> Signed-off-by: Curtis Allen Smith <curtis.allen.smith@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> ---

I would have pretended that the patch was relayed directly from the list
message by omitting my sign-off from the list if I were you, but I
presume that the above accurately records the chain of custody by
stating that you did not pick up Curtis's message from the list but
picked up the copy I queued to my tree (and later got timed out).  What
we see above is not wrong, but I do not know if the distinction matters.

>  read-cache.c    |  4 +++-
>  t/t0020-crlf.sh | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index c4cf08a3a3..70f4787de9 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -9,6 +9,7 @@
>  
>  #include "git-compat-util.h"
>  #include "config.h"
> +#include "convert.h"
>  #include "date.h"
>  #include "diff.h"
>  #include "diffcore.h"
> @@ -480,7 +481,8 @@ int ie_modified(struct index_state *istate,
>  	     */
>  	    (!S_ISLNK(st->st_mode) || ce->ce_stat_data.sd_size != MAX_PATH) &&
>  #endif
> -	    (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size != 0))
> +	    (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size != 0) &&
> +	    !(S_ISREG(st->st_mode) && would_convert_to_git(istate, ce->name)))
>  		return changed;
>  
>  	changed_fs = ce_modified_check_fs(istate, ce, st);

Keeping this check in ie_modified() rather than ie_match_stat() is the
right call, I think.  Because preload_index() calls ie_match_stat() from
worker threads with CE_MATCH_RACY_IS_DIRTY, attribute lookups must not
run there.

In contrast, none of the callers of ie_modified() (refresh_cache_ent(),
builtin/ls-files.c, builtin/mv.c, and is_staging_gitmodules_ok() in
submodule.c) pass CE_MATCH_RACY_IS_DIRTY.

When a regular file's size changes and would_convert_to_git() returns
true (covering clean filters, working-tree-encoding, CRLF conversion,
and ident), ie_modified() falls through to ce_modified_check_fs(), which
calls ce_compare_data() and index_fd() to convert and hash the file.  If
the resulting object name matches the index entry, ie_modified() returns
0 and refresh_cache_ent() calls fill_stat_cache_info() to update the
cached stat data, so subsequent runs match on lstat(2) alone.

Files without conversion still take the fast early return on size
mismatch.  OK.

It might be worth adding a bit to the comment above this conditional in
ie_modified() to explain why DATA_CHANGED is ignored when conversion is
active on a regular file, since the existing comment only mentions a
zero '.sd_size' after read-tree or update-index.

Thanks.
