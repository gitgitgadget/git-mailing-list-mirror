Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793797088;
	b=MUiCuXrrh4cV4DW5chx40+eDsjUEFUN6MTn3B7sxQqjVSYQB0n3/ipz9UVEBvC1R3bxx
	 agzV7P0TCp78fgJtt5Fi7zgNxQgULR94bTLJ0rPHFGe5vrQENdMjDtix7QdiNvi51oWcG
	 5/e9tgDrjT6Pb7aPCokRsI4VYJS3F9UQaJZxxx+erEnjK1sYFxFVWJRilkc1Wo3SD0LAF
	 Y+EcEqcfoOdagkDKKbCjoEodte/8MD5GiFAUIHQdycOJoULeJsgXq3TVoQ7hGhFvk4zjt
	 lAuw+SJ5ks9Mfw8woYDe1xaV1gbNMpqq0KjuE8ZW8eGK9NDcXvGWf5A/7e1a40QuE0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=3ddbAYmhZ2FK4w5P5gZOk3DpE4JySSsaPnGq3rviY2c=;
	b=I0JqpQZceLpc/zgoIajUi6nJS5CJ6xz9wvp/qfW7wOGm/4oPBCswmtnFF6MzFLBSuhhJ
	 oeUjKv4aC0ztWEW2+81ofOP0fZnpiS0t+2VjxWP25ViGW4f4djwgByAs8EdcWhPLYXVge
	 Y0qaVY51wSdZXC6w1vu1jgcLv+OxLEXyv/vSutPsSGyZ52yFe/fse0MgeytbtWedSzCZR
	 N7Fgqgr3oB968mROZrs8G18HqHM60GzYnKoyUcjCK7xIXzk1PphS8cluVZYeIJzsDcdvv
	 68GFxg3WOZ+paT3DpLk9rZHkWIgV/Qellmnbv/Zefk1+zYie73bRpZnqNVMoXZt4ceg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b="WD/qG3yt";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7D6606A328
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 12:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF7D6606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=WD/qG3yt
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b1aa2848d2so959363a12.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 04:58:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793797085; cv=none;
        d=google.com; s=arc-20260327;
        b=WWJOYtnByxQdsKqz7qszszFBfoQf3ieJtrlEaCAdYpIf6+f02Sg8XTz2t331ldAEga
         YSvBo0G+X0oSftv2NuncShYWKXJtCJ8P6GU/WfmPUQt2lUcf3THpSgJ8RGHWuoIQEIo6
         B6Wwm2EOyjGhtfvOtGvvPLfn6J8Oy27gI8CQga6JFHtSYKstqxtYmXm5035TziZ9OmfC
         53T8Qdi2eAZxZisllksfer47gt1lyY5hn7/sGq7exRBktjK5EJhUMVxox5Pzt8eqaZir
         BdfCHDBuptgwK7N2MUasoXeBnBjAMap4mAKubRMRvTUnhSeqwSiowcD1kEBK1k5/sSqc
         PLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3ddbAYmhZ2FK4w5P5gZOk3DpE4JySSsaPnGq3rviY2c=;
        fh=O5WN4cEyQhmTo+Y7uDEGu9W/+9VS7mb19bCDwTbx2NE=;
        b=DuFbSqbi+Lnvuk4c0WN5HD7rNGBOCC8nE5piHHR1f4NSVp2qope1YpeX5FWpGK56lS
         4VMYg55o5WNidV0HvgyhhUNpcPSQ7K4H0k3QWJN78EecSzjt3MyJCQc5Wx0NB+9CG1py
         ahTeh1Tzv2ZXQkr2L87d3SjZwdNUnT+R3XT6N97QgmhlhgrwqSREHf4624uppAEjMf/2
         kZuGbYmSFmjeMT0Gn75pEdwNWnBXJOqQpP3AYVXzirYe02RAQyVustc3WRgZq+VehrJr
         J9z7AfYNd7V6gDZmf3Fd6aH2exZuf16mQGus040mgkIFemw3F1Evg9+iJ8WY1XUOjXjJ
         crgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1793797085; x=1794401885; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ddbAYmhZ2FK4w5P5gZOk3DpE4JySSsaPnGq3rviY2c=;
        b=WD/qG3ytvkGsqo0+LecNTfOe24OSztE/7vE8mGDmP//Br7rDX1RNoHtEWzINcrUI86
         NOQwokFD9ZEPWjns6beWu37Bh6dX+Hv4B2SY3qJ787am7ImWwEG92i/nqKlLsfmIdt4C
         0rIGIywFVVgAiK7l7yiuS6CE9SaKSZQUAyAIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793797085; x=1794401885;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3ddbAYmhZ2FK4w5P5gZOk3DpE4JySSsaPnGq3rviY2c=;
        b=nUWUGMrT6Rm/zRg5CZOMVlPegzoqiFbw+gKWiJ2MBHoXl5KH5Ib8qdVTQ4wlnIg2fw
         AKBCLm4jFGloc7w8aX0/CB38oCS3blD+Wz1kTdCGZGVrjf6XbAb+iHRYvi4wH0JnYNC0
         +rVnAAidKyaeWmD/FHooLva50kmHF/02inoAkoVOJNVPpdKTxSJNuHhWrCdUeWBvUFjr
         n31rF/quU3/Mt8ZMRpu8KHfWDsl1Qr+SYDw0NFPr12PIp9jdqzr7/fbRn9DVBcRCaYmw
         +/KvEuaOPNzZ1zmCW/sN0/VBbXZIQidVJzj8aLgA6MsEFikU/bSakkp6E217PyTzRall
         A31w==
X-Gm-Message-State: APuU4Z8X0RfMoKbHGpbA8mqMBBo8deY11D6YjBb6K2l2pvDBFZdPmiqa
	36fYPlQl0E+48XweGvnxw0Nwu8Yu/ULXkQmqK/fgUIVBBIO4NEO/nrnvJ7vOyAosnzd4K3+1vFm
	yZUT5Dna01yJpEjcmTEs2OTCU7g3sC5TJEN+7bV0FmtxprxgF0hi+Q5oG5Q==
X-Gm-Gg: AYBFou2WH169jAGTi4YmD59xKOnUUcZg6Xts01NsPTVPL5ZxYNtjUgpg6ETmBjRt9+2
	a7174xa3661OqrizFtlcNzC+dSvIwXASe5iBEOHSEFw1zsYyOwBewIbBA8G+F8WIgyF9FL9HeLd
	wv+M3EfleqXQKulsB1W8fug8WVelyqjJmakAevZBudoNadmJfegdJvkSiouidJMKuE1O0raTn/z
	L0hGyH3taGKnB8prebVhbElQzUbqQA7I9E6IIQJQjd5rfrCc76MiU9dP/kYDBvte77xFrqHEMjw
	LSEbCcABAmCZ7dH+yEl4Q1GtTTYWmGjIEvmIW6VU2Xw3qWzTkSBRSv1M5OXUz22ONtbTag/ubYp
	/OmAD9mMdBzsuUyP7fiq7Jrfc/likSgojHKoKtg==
X-Received: by 2002:a05:6402:5007:b0:6b4:9919:b54 with SMTP id
 4fb4d7f45d1cf-6b4d5ce4182mr12969858a12.42.1793797085409; Wed, 04 Nov 2026
 04:58:05 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>
In-Reply-To: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 4 Nov 2026 13:57:52 +0100
X-Gm-Features: AclHuK_ioRK_OOKLF6j5f-5q-ij0Opqq1GA32Dt5sv3wCSX5Hq_fSgJxqnkvw5c
Message-ID: <CAL71e4ONN4OQUZ2S==0TRWqZgA8ogT0smRL3Rk46voTm+0Tihw@mail.gmail.com>
Subject: Re: [PATCH 0/2] odb/source-loose: fix failing existence checks caused
 by stale cache
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Patrick Ohly <patrick.ohly@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 13:17, Patrick Steinhardt <ps@pks.im> wrote:
>
> Hi,
>
> this small patch series fixes the bug reported in [1].
>
> In summary, when git-merge(1) writes merged blobs it may be unable to
> read them back because the loose object cache does not get updated.
> Consequently, we may think that the blobs do not exist locally, and thus
> in a promisor remote we may perform a backfill fetch. But as the remote
> doesn't know those objects we'll fail.
>
> Thanks!
>
> Patrick

The fix looks good to me, and I verified that the test fails
without it. My own local fix is logically equivalent,
which is a good sign, though perhaps that biased my review.

Thanks,
Kristofer
