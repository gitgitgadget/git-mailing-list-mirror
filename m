Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326C437C91E
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 21:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773609816; cv=none; b=ZgbeKzMOlupUiz+L7v2rnvgpcH7IWoVo72n+8QNteBd3vC3QmfXO8G5ZdbHlE+uik1c2753U+ZqUcSPa8mfQW+h8bjFSXv7o6k2vr7T3XhlhZrYu7R83Tc6ECWFNNzArdpWH6hkyH+J+SZwnJWvqRiR9RdHwQWmBY24wlP/cnug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773609816; c=relaxed/simple;
	bh=d12RclPW8UvoTtTfqnjQp99TKKCmWCXvuulu3964neo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HMhyuZkkI6LhnfAs1NG+y2+b0qBbNyejuYTzBxnYFRTT998UR+sXYHCLTzc1+oLIfvdnSKgmC/Jd2QcS2w2NuSdQ9VXIqDD/e+6JDgmSZgN5uXJ+BBg/cE7oJVVAW3rzEiNqA6gcZWZE0EAzAr7vchtMahf6E8Az8JkbGvmURkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=p1lTh6Sv; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="p1lTh6Sv"
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-64caaacb9bcso4060003d50.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 14:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1773609813; x=1774214613; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fPYVFQveTwzK4YfPtnwpo9qW8B7s92M4SuJLPh3fvWY=;
        b=p1lTh6SvXAjEc00d3cwUKADEObv7YgiC59HCabWoQv3B3ytMYSWxDJQg84160eYJ83
         QaOcP2SCM2NpsM4QX7T93Ybr9vunQrpoTidLBMV+cbZEVan5hIoMXVEe92tCNza+vuPM
         qvzW89R59pt4NeA9fgCp+zrKhXj/1rS1CVX/4k0vJl/mitEeD10ljfL64rJU6gLvAkiQ
         aJKytyg/JqeALozYIMUhQpY+Hsr+xhUz6FLj1Yjp03ZIHM0/1x7ZsUeUyzD1Q91kIyos
         nXl6wihG4LMm7ULfgClSDaR1RvNhhyMNr1E8SK4YssdkK50il5WihJBP01/vS39HTKo+
         cdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773609813; x=1774214613;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPYVFQveTwzK4YfPtnwpo9qW8B7s92M4SuJLPh3fvWY=;
        b=sIghEF8jxDlbOJ+gXfvseM1BuaF2gtu5MTZ1D9ycyLipTXn89kS0b0VLr13aboIC7P
         bi/5HLAzr3fCJRVQGFzmCOyOYutT5bVIQiw8ADmNaXsFL47ypvUR8YYrtLQQ9wtzY5Xr
         tI/1evgB7pBvzIteCAMYJHYRSLIOo4qhy3K8VaY9PlnI727Eqqq2mQuC+ghtw+yrfYCr
         IG3qFRBV4eLUSCy4TZyXlckkfoZVYMipmTDI6Y91rreGHU7vTWe3W3pPOLRYHCiQlQiT
         KLk02eYd100qYQ2g7HlMpSkxEHwjP1S0ARYNbPDMM7OxqaYz3OJPeBd9tCpeiZxNkRUK
         H8yg==
X-Gm-Message-State: AOJu0Yyzn9IOLjKuyGEgxsT9eb+BH6MHRFwyIivRTOgUWjb1S3Fqvl02
	8B+AEkyrgQ2RCjQv1b6ht+7DbjWYsY4NX5bkp+A6KWb7XLdVBeOJ3h1IKhsJC1YOIoRQefDsTId
	luZGzJYyFAsso
X-Gm-Gg: ATEYQzylKDqxqTsju2lVB99qggcujKLe3YlPaoiZvGFDu84dLjnBGGkUlRQOhi7vNRq
	wz/15r/aUumABFiaCB/Fo0GNoaNqhRgETF/Ivlsmslm4K0VRBw5QC0/TZWvjBWECDseBjOcdY+a
	DhVxhQSJ9m7HZ+TeA7Rx4NRMvDAr3pd6b7yLrycdu1rcTH6MyLpncSpJKQN+SYrMwOR8wW9gPl2
	YyvHc9QQFfbaiChmH6Ng6n0h279ebflamtj5iQAjloRnNOR1p3pdzv98F4QCojWeDbyAd/+r8EA
	eiCnJyFUhnzHfFBzuze3wNDQwe20fId8j88Rk1M1emxFsX/awyVgdAVK3Ul7xenmaoAtBfNY626
	wz36TDZmgglE8xyqO1fQPEYu99g4U4/SOYftf4LhFa7z86rlQJGBGQ8UTxghI/8OzrtYU5Qpf53
	ghK7kit5s4T2hNKto5KrPEkKz6tzTSh0s2VPOnJ9VLoJbQH7rjH9TEc5hKqEE/cj2bXT7PN5+b0
	rPap8tjevbnyYrTJK1aDj8kzHTOPof/BUjSoa0S
X-Received: by 2002:a05:690e:2c6:b0:64a:e7e0:a723 with SMTP id 956f58d0204a3-64e62f13453mr8038927d50.18.1773609812632;
        Sun, 15 Mar 2026 14:23:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e65b39917sm4634221d50.13.2026.03.15.14.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 14:23:32 -0700 (PDT)
Date: Sun, 15 Mar 2026 17:23:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] .editorconfig: separate tree-wide glob patterns
Message-ID: <518d71de9cdd71d0fc259740cf0da075bcf79746.1773609807.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

In 046e1117d5d (templates: add .gitattributes entry for sample hooks,
2026-02-13), we added a sub-directory specific pattern to our
.editorconfig's main section. Prior to 046e1117d5d, all glob patterns
within that section applied to files at any level in the tree (e.g., the
`*.c` rule matched both "pack-objects.c" and "builtin/pack-objects.c").

Ordinarily, we would expect that the change in 046e1117d5d would not
have an effect outside of applying our settings to
`templates/hooks/*.sample` in addition to the existing globs, that is
not the case.

The EditorConfig specification has a quirk[1] which changes the behavior
of globbed patterns when the section contains patterns which contain
path separators. Namely:

    If the glob contains a path separator (a / not inside square
    brackets), then the glob is relative to the directory level of the
    particular .editorconfig file itself. Otherwise the pattern may also
    match at any level below the .editorconfig level. [...]

While it seems like this should apply only within a particular glob
(e.g., in a section covering `{*.foo,bar/*.baz}` all `*.foo` files (at
any level of the tree) should match, but `*.baz` files match only when
they are within directory `bar`), it seems to apply to *all* globs
within that section's filter.

In practice, this means that a file like "builtin/pack-objects.c" would
have matched the rules in our main section until commit 046e1117d5d was
applied, but no longer afterwords.

(It's possible that this isn't what the specification intends and that
instead I'm observing implementation-specific quirks. I first saw this
in vim-editorconfig, which is quite popular, so perhaps this is part of
the de-facto specification.)

To ensure that these rules are applied in a pre-046e1117d5d fashion,
split this section in two: one for patterns that don't contain path
separators and another for ones that do. This restores the
pre-046e1117d5d behavior where, e.g., our `*.c` rule matches C files at
any level within the tree.

Add a brief note above this rule in an attempt to prevent similar
changes in the future.

[1]: https://spec.editorconfig.org/#glob-expressions

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 .editorconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/.editorconfig b/.editorconfig
index 6e4eaa8e955..d06f5c6100b 100644
--- a/.editorconfig
+++ b/.editorconfig
@@ -4,7 +4,14 @@ insert_final_newline = true
 
 # The settings for C (*.c and *.h) files are mirrored in .clang-format.  Keep
 # them in sync.
-[{*.{c,h,sh,bash,perl,pl,pm,txt,adoc},config.mak.*,Makefile,templates/hooks/*.sample}]
+#
+# Only list glob patterns intended to match throughout the entire tree. Create
+# new rules for files in specific sub-directories (as below), if needed.
+[{*.{c,h,sh,bash,perl,pl,pm,txt,adoc},config.mak.*,Makefile}]
+indent_style = tab
+tab_width = 8
+
+[templates/hooks/*.sample]
 indent_style = tab
 tab_width = 8
 

base-commit: dc6ecd5354dca88d51b6d6562777fc8fc10d77e1
-- 
2.53.0.308.g50d063e335a
