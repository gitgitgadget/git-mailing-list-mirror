Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794142455;
	b=pYUBW/5wVhavjase4uT8zyPzxnW5rdYjs1W3XmpqbLzmoasMc6jBQlV1FsmZv6SY6j7w
	 G77xNGzJXoY71MYM9yaVEFms4lXap+NJdt5nPzU7i6YmMnrmGLIv8ysOeAOXD+i0HKs21
	 6OJ9bUtu0s8GiOJobxp3DisGfvdlPraztLiVy6rJWDHdePcG2bZsPRxcHMiBeCbrXjRzc
	 J2aM7J+6MdPqFpJUcO4wcqwEbFRDyb3Pv/t+8n06ybKLZKSsnOngybmCm9fsJKYg+qi5H
	 MGMN3yhPq7xlxDJCGMhhxGq4OmJhbQSHdE1AqNRNLNX6Q8B+rDYxY4WYLph7y1egPFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794142455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=xEtkzs6wht/wmnjE7Zkb6EOlW6f6sIOIOigFc7EvTpg=;
	b=1bRGnCzhEuYQ3UA5SRIL9pSqZtCFMvtlL+0bOzm6L67+trFyFNRYnBVKxtNoNXWCnstP
	 naCyXISpWi1NvCMFTur8u3hVRPqR8M5fjY3krNs29+CaL02ZhqPug4Aak2Ot1r4Y+F5g5
	 Nx9FWWYZKG0Yxu/XKfokrzWNCnpByerIiRhg3ZSjbR88djRlu/a3peVaFgnjmL1SRn14/
	 SSJDpPT6155drydJNRYRCtk/ZqduuguD+R2sVZAvqVXCvzybUGfWjzwTYzPCvS+YaCDTo
	 WAV7k8sy1ZA0NXBRIpIWQHG5qLE94owxMQOqLENW2S6X50myBN1/byJoMdMGAiMfp/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SfeYNmgi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CDB606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 12:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29CDB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SfeYNmgi
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f2551f57fso1114985a.1
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 04:54:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794142454; cv=none;
        d=google.com; s=arc-20260327;
        b=oLMT1Jvaf9c2EKl99DRe/kAXe2aP0w0NyW5tKIGF/nQ6KDunosiT4SXC64yH9UyOku
         qCUYa/T09J+daej1CVs/3USp9DEzNkwmdFDNWdPGQlrAp9ygMswsFPyfh6GG1M5Qnf5G
         GEYAvc4nr8X1pptG9sRmxzdrihB6lIK9/i19kJ4cI5bdN2BKx60VjNmawlF5v9I75Rl9
         hJD8S06UNFWDcI5q/gN75jAej6ZN3sdvOEVDc/lawcc/T38KNeuJMc3jeJKy6ZGYdnDP
         hypTisx8I/bLqZGbsh3zqXuvopgRIvIk+DYyGpJioZpC/LxAQMP3lHywjyCwa26YgNpl
         zF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xEtkzs6wht/wmnjE7Zkb6EOlW6f6sIOIOigFc7EvTpg=;
        fh=o5l0Eu0aYVhYLNaknXG9Bd9QW+Oip/V1pdMxWtUugbA=;
        b=Hv9ZhAUq1pxJ1/hTbhytRTMOzJvYI/X9HS0rAdx+e8iwtQVsrHplk62K90Nm08wlAN
         SLd0Tv7aPI7w6+yDzFfNacpta4lU/uxfXNtFHsCq6/oTOgcvPMyEwQYjbPYVZANSvSbc
         iXB5RgTHSF6Hjaeo+R/7Cepe3ris3wWFmJPWuGa487PM2YOZ2tvv6RA1MHiwQQsJsGVo
         uyq0ds4Q+Lly3cP2Pr3su0JFF9Dezea1D6c3y2vrz6AgS9EImgfDQ1xZ+M7aDQgqwXW2
         YutS5XtyTxv/DXZbY44Hxd6GEYDMt5CKZT5E7pqytL3c77DHLPRCtu9uqiMaNLj19oBW
         43jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794142454; x=1794747254; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xEtkzs6wht/wmnjE7Zkb6EOlW6f6sIOIOigFc7EvTpg=;
        b=SfeYNmgiifOyPLIqXjwQe1XLO5Tazr9Dz+whV/x9V1b0AH/YWVX1WZ6hXmoPG+TwcL
         SqdB1zoX1WGPvkyxAluXKbfKUPpNvWOBEHLW1dxG/e1YgIL4jRna3GgL9ZMcwWMWj/kH
         7prxwCv4N6OvmuN1URnmA0o3I+diW8QjARtpx1LB1ayAFxp+hHgJH9F4mbCw+rU/6sLO
         hNtM5GwZ+SJZsPOu4FOKMqXPydfgIWeMFPcpDb1Fv6OjUquWB6oFL4xQCQek/uIUvj8a
         9rErfKoaZDNLW3Ydw7DeL+ZZJcfkAKoFBYaIMPp71NrDaGrmg/jkdn3U3sM4QM1uw3Hi
         bmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794142454; x=1794747254;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xEtkzs6wht/wmnjE7Zkb6EOlW6f6sIOIOigFc7EvTpg=;
        b=oERtAmCrygjRVwmzjaDEvNmuXPAXG308YaDjTenIxvNvZNPdNacioZU0Ryt5N6tStp
         SKxVKlmR3DETfWZM0htdFmXJQH4N2DhXFp+Uboex407goyXIjgeff+c2HQzH2/YRbtnr
         7N5+rDiFLZYGyjTuIGeRyLC+Su+QR/dak9m++jwB52uXXYqrHehwIwHlw+3uhIEJzlH9
         1kkW3k8q1OVtCjLLFMSZkaxNsR2jssqGIYFcf/cHEAMoKsz7/TtbZ80/oS/hn2yptd0i
         11YoPaA8PS71MUYVLmL4j5+YgRPAy5Fc5uG4dlCgN9GaHOqSiuEHQT87NGAI/thmrjfM
         fR0A==
X-Gm-Message-State: APuU4Z/3b6hOsNfUwYZL+Ot77QPvmYAMmquCtMfCIiTpIBLkSs9jqvzB
	gaFzKRvWQ08wBi1822siI59GRJsDqBFcwYffOSgOqv4BFoLh9DI/PEnluyZYAf194DqML77zG7z
	YuRBny+44fx/YVWV2tl4TOGtuDXlw196s5zwHnB4=
X-Gm-Gg: AYBFou1bMmCPrDKxXt0A/oGxvStOfg0JxJpEq3CHmqv48pldM/UYMYJqWE14XB4zSa3
	tkqF3F46emO8xEbAbNcAM7BOERU0g0rP9hiY1UBopso5qyNU0DPQND48EZmq0CfAJ3LcWVgFPrI
	ngsguclcEk0BNbAbe2e0xlI07BjWx0p9xTtXxO0M7CkfB4Y4rDGqFQOFOeeJlJ2mJOx01mWQVb/
	+87fT6bj+OuaB57wTthmtnutjAnH0/n0AAdFHNGDzmtvH4EdkRrehIcgMxgXyQ6VVVp/1dCVWmD
	As1ti/7Xlr7qOwWmw2IILwoDt//XdA7C8Xs2GNayN/3+jpNy8DqsQr4bHwzmIZk0s9HoVapq+Ud
	ft94gW5Y/ZCAZcFAhWVTmauO6jfMh7oaRNWbc
X-Received: by 2002:a05:620a:a90d:b0:945:c5b3:6356 with SMTP id
 af79cd13be357-94784143254mr223253985a.2.1794142453899; Sun, 08 Nov 2026
 04:54:13 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAP8tz2JPXzq=Skokn4OtH8t6c3b+p1Wny1iX6AhXReUGvsBhuw@mail.gmail.com>
 <CALnO6CCFfd3VcZkFGmc6kYHqEwsafa7UbOg-6cN0jEfsipQm5Q@mail.gmail.com>
 <CAP8tz2+CQcQyTdj3YFpEaiVh=hVoK5Xo8WFxGZNMJoCCM-u=hQ@mail.gmail.com>
 <CALnO6CB=tmTrNKcWOanb79Bm9gPT5H_dntNGRJGp6iEYHe_aBg@mail.gmail.com> <CAP8tz2+cJ4E+Nv_dHuY-8-DoGj7_nP1=98Nn5+M3qMb5WezYVw@mail.gmail.com>
In-Reply-To: <CAP8tz2+cJ4E+Nv_dHuY-8-DoGj7_nP1=98Nn5+M3qMb5WezYVw@mail.gmail.com>
From: =?UTF-8?B?5LqV5LiK5Y+4?= <inoue.tsukasa.4@gmail.com>
Date: Sun, 8 Nov 2026 21:54:03 +0900
X-Gm-Features: AclHuK8e-3Mx1anG-ofeyA8yzJZANCncl3A4vm7EM4-kKMhMO6iGqpLnSuWbURA
Message-ID: <CAP8tz2K2u4yuNE5ck777JVAgCk0-4yoToc1RNaFwMDKVH4zabA@mail.gmail.com>
Subject: Re: switch/checkout stops halfway when it fails to write tracking config
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
Patrick Steinhardt <ps@pks.im>
Subject: Re: switch/checkout stops halfway when it fails to write
tracking config
In-Reply-To: <xmqqecdjsryk.fsf@gitster.g>

Junio C Hamano <gitster@pobox.com> writes:

> > ... and to leave full atomicity as a separate topic.
>
> Sounds like a good direction to go.

Thanks for merging ti/checkout-track-failure, and thanks to Ben for the
questions in this thread.

I'd like to work on the all-or-none switch now. Today switch_branches()
updates the worktree first, then creates the branch ref, writes the
tracking config and updates HEAD, so a failure after the first step
leaves the worktree switched. I looked at two ways to fix this:

A. Put the branch ref and HEAD in one transaction, prepare it before
   merge_working_tree(), and commit or abort it afterwards.

B. Prepare that transaction only as a check and abort it, then do the
   real updates after the worktree update, as today.

I tried both with "git update-ref --stdin" on current master, files and
reftable:

 - In both, a stale branch lock or a reference-transaction hook rejecting
   at "prepared" stops the switch before the worktree changes.
 - With A, every other ref update in a reftable repository fails while
   the transaction is held, and with files a commit from another process
   fails on HEAD.lock. The -m autostash steps fail too, because they
   update HEAD.
 - A also has to put the branch and HEAD in one transaction, which runs
   into a reftable reflog bug I reported separately:
   https://lore.kernel.org/git/CAP8tz2L3Dfhd+ec4+SFkZgXmzQnBg+3Y0REAV+1Hf5X415qnfw@mail.gmail.com/
 - With B nothing is locked during the worktree update, so -m and other
   processes work as before. A branch created by another process between
   the check and the commit still leaves the switch halfway, and hooks see
   the check as "prepared" followed by "aborted".

So I'd like to go with B. The tracking config would be written before the
worktree update and removed if a later step fails. For -C on the current
branch HEAD does not change, so it would be left out of the check.

Does B sound acceptable, given that it does not cover the race with
another process?

Thanks,
Tsukasa
