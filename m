Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063569;
	b=Yg/j84/2V4dKgm8r96w3jGPauW5T9a5i9hn0d+qoovF/CNVwFeQeYmdKTwQ6sZxYruo0
	 SEy4DuUd3q3uHC4XnXCjfEYZutzWoVWx4v8wUvfiG8qPhODyfMOlswan718tSLjwjyyFp
	 +F6Th498oA93AqOLM2dez7dFbgs3s4q2EQf9GvWXVdFUx3FBuXONZD/k6XUuGrT4g06uU
	 uEhlv/MpIIQbpnCr9LDJ7O6SSIom9U9bz+9CWfab5w/+CXskXt9uJgPSjF477LEqMESXc
	 JQFNEvgIA/po4p4g/n+cB+DK47DizF6xzS59eQ8ztZ2yhshHAvQofATZQlDAXoM6UCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=O4FHI/m0946JBVjMAL3yO5JWb/f/ZBGo/CHlaU4wzyA=;
	b=nYH0Ec9PIXil9c5jBXTRffEqqEHkv8GR0+K6tSAY4Z8uzaPqsUY7OgKROco6Zs6WXvU0
	 0MrwTNoYXRmPjzCckEUb3fDxho7Stix7dCrwEeVIe9WcPitd33vi7gn7VJc0M1mpeMay0
	 MFmflJZe0mQclcqbPx0mzTnFKIyhXiNYMD7sS3GAFfOYW3x+ZHlwkdW0goUd6OuZuRToy
	 LeSasysTYAUr/JkZ5GEhvSNumEf+V/xFIcgey4PUM782eZlRSerc/7/p8YLF3tappQFeS
	 JxIA5kJkbzX/I1vW+M5YGOK5R5E1eua766b6eeCOFa5k64T6mLF5kwcbYyV7Y1TNL0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TZ85Wvg3;
	arc=none smtp.remote-ip=209.85.167.172
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC47606D81B
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 14:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DC47606D81B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TZ85Wvg3
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4f55a53898cso818285b6e.3
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 06:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794063568; x=1794668368; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O4FHI/m0946JBVjMAL3yO5JWb/f/ZBGo/CHlaU4wzyA=;
        b=TZ85Wvg3QUyQoKjGHjNDSWmxcKTEuSWx3yIV4Fvb1DMmWCF/WHvveoFRJEIPfinRR7
         bLVTjisyiCROI+PzlD1q3CRrXq2ovnri8tpB46Mi52GQdIxwoYXtiI5k5DhnRRtZd2wX
         TOT7pfxsyoL9kJNlVDpVBmsjx5r5EfTpwUf2Az500zqMZCdz1HYFeXMqadHqTlpWbopf
         Y20eEWx4284NE1tLaqy6mI8UysREv7Z9jEQnAOM5zMwLOG3IzkxxTQFrovVYMHDLvKnM
         EA5XaUD812SEgY0cN9vfd6weTvm5hVKMY+T3i7++jZ1jnxv1IM0UvvDp/srS/P9l+mLK
         1GKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794063568; x=1794668368;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O4FHI/m0946JBVjMAL3yO5JWb/f/ZBGo/CHlaU4wzyA=;
        b=WM2rpnXwgnuJht2v0LeEAXlkBuJafsPI16HIaEhRNCJ02zllLtzUX6kHlZMbEnIFbS
         YMnXctrfiNYiJq6yABtvgxAEFgQbpOF18CcYirBZNzWcOLnxlCeu+KJH2vFlU7RHWVor
         GPDORk7WTzUdDUtzV61msikHyG2etotrZtxVhHAIzGFFJXb6NVw+jPQDm6Nu242mNYDO
         hDOBc7mafxReMfThEPYJ0GMJgaY9L58Y0G7S9+RZKkk/z2QxKaGC3ArVTlhFF/TE2ThA
         UVM5+Wv4SYOUelJvlS3bgiMho9fwqf0QZWhh+PO3Cnwgzq+0uyIM/yI+g/0Gm80gPpsa
         LDFQ==
X-Gm-Message-State: APuU4Z8ueaHZKkINRK6UEVOmus9yl9uu5nXTGZDdhOlWjSxf2tDl0ccP
	WqzAp04kZ9eEQL6HgkxYkpyPDT0MDPQyaxYldwuDg4H4rf4NzLM/0CFbxCYH+PzZ
X-Gm-Gg: AYBFou05yk/sfeBNqbq3ZVsX35tJzwMnmz2Q3KLjIMn3n+5ViasQrqMnmTuvf4mbM/1
	/t/LK8Bg9Rz/8SR2gAYH1JvQdtQOxyvDzEHVL+zAAThvvGd6V9N0rstWQ/4GI5Z0cb61VMX/bLa
	UyDN6tQjNhEfYCmVRGJGn620SGFMnzc6kAPMxCXcfYBIhSnlowwHwVYqrxHnw2hj0Lt2H9C+04Y
	gSIRn79rWntHyckV+aT57dhfzFQkgKxFh41dJwFEAFnyIY+zQFIINK68O73heLg7ARHPlT5OxNa
	udHwVgd3ht04T5lrCz6T8UnlG/ZxchbEHAICmuR366DBqp34aXgyhk7XtJddfrB9IBG8nQg7eS9
	42vwez8KEoCVxrSluZZQdOjbQnimkXJiqs3VOu4lRppDFkV3WUdQ+0dFevL8WcpaI3vj+5HxV18
	Vp2zPuiGAY/GmXqOK4Q+8dGP2Yb/nz0xuokexJuds1U/HWXChOSILO4WWChlW3KcgEkBmXpl8SI
	q1ZQaEHjcyCjODG0rpXAgtsb1sHvuBcwuNbTfGTS8O84OSdg21kx3REjn4pb6gjxilTduNKp0kD
	X07TabjqzGA2r7IdVuGlrpWyz6rt4Vo=
X-Received: by 2002:a05:6808:1509:b0:561:fa43:1b17 with SMTP id 5614622812f47-567e156641dmr4047859b6e.42.1794063568090;
        Sat, 07 Nov 2026 06:59:28 -0800 (PST)
Received: from [127.0.0.1] ([4.150.182.93])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ad97a37725sm4609815fac.11.2026.11.07.06.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:59:26 -0800 (PST)
Message-Id: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 14:59:22 +0000
Subject: [PATCH 0/3] t: add "test-tool genbytes" to avoid slow tr(1) on macOS
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>

While looking for slow tests in CI, t4205 stood out on macOS: its EXPENSIVE
tests take several times longer there than on Linux. A CI experiment showed
that much of the time was spent in tr(1), which is very slow on macOS for
the 2GB of data that t4205 generates.

Patch 1 renames test-genzeros.c so that the actual changes in patch 2 show
up as a regular diff. Patch 2 adds "genbytes" and uses it instead of
"genzeros | tr", which is where the speedup comes from.

Open question: is patch 3 wanted? It folds "genzeros" into "genbytes",
spelling the NUL byte as "NUL", so that there is a single command.
Alternatively, we could drop it and keep "genzeros" as a thin wrapper,
avoiding changes to its 10 call sites. I kept patch 3 separate so that it is
easy to drop, but it could also be squashed into patch 2.

Some other decisions that may be worth pointing out:

 * The buffer is no longer static: it used to be static so that it was
   zero-initialized for free, but now that it is filled with the requested
   byte on every call, a local buffer avoids shared state. It keeps its size
   of 256KB. Smaller buffers made no measurable difference in my tests, but
   there was no reason to change it.

 * Invalid counts are still silently treated as 0, as before. That could be
   tightened, but it is unrelated to this series.

Kristofer Karlsson (3):
  t/helper: rename test-genzeros.c to test-genbytes.c
  t: add "test-tool genbytes" to avoid slow tr(1) on macOS
  t: replace "test-tool genzeros" with "genbytes NUL"

 Makefile                          |  2 +-
 t/helper/meson.build              |  2 +-
 t/helper/test-genbytes.c          | 64 +++++++++++++++++++++++++++++++
 t/helper/test-genzeros.c          | 37 ------------------
 t/helper/test-tool.c              |  2 +-
 t/helper/test-tool.h              |  2 +-
 t/t0613-reftable-write-options.sh |  2 +-
 t/t1007-hash-object.sh            |  8 ++--
 t/t1051-large-conversion.sh       |  4 +-
 t/t1450-fsck.sh                   |  4 +-
 t/t4141-apply-too-large.sh        |  2 +-
 t/t4205-log-pretty-formats.sh     |  2 +-
 t/t5300-pack-object.sh            |  6 +--
 t/t5318-commit-graph.sh           |  2 +-
 t/t7006-pager.sh                  |  3 +-
 t/t9850-shell.sh                  |  2 +-
 16 files changed, 85 insertions(+), 59 deletions(-)
 create mode 100644 t/helper/test-genbytes.c
 delete mode 100644 t/helper/test-genzeros.c


base-commit: fb255012acbcbe81189cb8014da0280b09c66ecc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2301%2Fspkrka%2Ftest-tool-genbytes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2301/spkrka/test-tool-genbytes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2301
-- 
gitgitgadget
