Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410902;
	b=O2bEX8WvGjfBPOmtNUmZ1QoxKWWRiPgoKoraya9L0iSO0iGgYgz9NRWf/ZAkytQJw/BQ
	 6DdD11riiTd4wu7ZcM9kMP/7Clt8+2zVyhftBBKCDlPEcIxhDI7uo/e1x3gzKp0W0FULh
	 +w0gQnd2D4T0guKqnl6m5h5X+7WODMcM9JEX9Y7JIKRVudM/9ufr4SaPgvjaiinRIE+x8
	 1TfwJbjiBqyShZz5VWFpUd7MViTkfRnDaNB3ovRMDHeH/UZLqeOjEqCaDcqd37YGo5k12
	 70yK9rip3wZ2dF50twisjdfY3OF9cN6CzuhFwiJCVxl5uV73TZcOBQnT6BQQyGIlaGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ha1iS5MVJtTrl7n+2rsqliKQJHQul1FVZ/YwsQu8eSc=;
	b=HrttNxjSghLcsCCvW7+kN4OSlS5P9FCx2Ngi11gT/9B3/g/9oi/9gn+vOilvSvNFAM6+
	 B6TeypFFoRknbwu8EdIKrMBayGMirptb6rdj1o8eGJoktpEOTnI0iotA5n59RkGg3baEa
	 GQc0HJYVcGTjRA7gzvnK9ZTOiQSAFVovnDLTI04SFXQBNmrgwDYkTDZCB1f3tZTeWM4P2
	 sW3HycG1lALF/eQ2i46XLJxqBLfDTsKk07QzhqMvAEsytbTDnwJHREdNqjVxIv6AcbyS4
	 NNkfBk0SB4YZ9PwyIp+2vOGI5LTUco/vtQ/jPfFVMvUmeXuFnKFID44e7AGi3U5yI6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=iQU30j9x;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C6C606A891
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 15:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6C6C606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=iQU30j9x
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53665358476so31995161cf.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1794410901; x=1795015701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ha1iS5MVJtTrl7n+2rsqliKQJHQul1FVZ/YwsQu8eSc=;
        b=iQU30j9xTCreI6W7LmNMJUndABwBb0+pPwp3FIYn80fmbnZ5GvHqjeWpjZzBKUBPOU
         TPGxq0+4c062NrSzfUMz75kZ0PFvY5lJF84rC5ZsePr5DXgKK7ZeTuXRyZdB1R+1e6tF
         V1LawdDxDaSumNSdWrCQyjE4BBLZ0sWStMeuji16tyZVQn+5+MLrd+gKqnWXXaiwoCHv
         zUJphqoDkAlqzdIUKJHBPAJe0dGCOczNXywBR1bZgXiYXAYzl2JI8dDCgeOrwF2mjPaF
         sVa4K0duji7TMo49k+hNF+TVMxA7bDb8D6FFQ2VGZqB00rkpK1cAt1u8V2+QDYIe+Tmy
         2kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410901; x=1795015701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ha1iS5MVJtTrl7n+2rsqliKQJHQul1FVZ/YwsQu8eSc=;
        b=sbWOXxRiZUUSdYQEM4N2yueLffdKcTu9jrYZNdVXhFMwG2bscCAbYkvXUMfDGUQs1g
         lYLx90UIj0CssKrQxeQP3+Figen+VvqA0/f37jdVh5yIPiD1HfzHdCuTwFKQYZaws0v7
         OBPOOHDP47vFQb5+Rwu6NCwt/KDiINgvjURYkpM9gaf5YFaxXYy8Ch7c43Yspe1/7OJw
         Z1mHSyd3FUIUf+y2NU4XfBnhb6gSdaE8SEIIqSZKFZHnBz4Y8V84cryRHfpoRlNCdkzW
         EfJGuggOVWtNSeAA773wRDLSSmLvxbJDhz6ZOMyRkMVZuDREW220n1fQWnIr5+rTiCA6
         VOiw==
X-Gm-Message-State: APuU4Z/eQl2mAbrt9uDW6ZDNvBufzPoO7ClpkaP18VvYriGFy5gjXCAG
	GbHcJU7aecphMRxlv2O1rqPBKkeC0L6GYgRX7NmPqqMQeqYv1BO/DW3jas8bjWz/L20/WL/jNbd
	3MDqfzC5X2PfKJDgV0HMX1N29FMlYLsdLHrKSAyJ71rqn+ZWGGYTHm+vtACWW/avepvakRUL1cB
	YkKWtw6Cor3BY0Ot4XXCEWcTsS9CX9KoB/ZDZXh6CmFoSJbQ5s5d0mtCwODTfAPkbdJV+aBKMGY
	zP3HRs1EpewuGPovLIAzXtFiurre/xPJ5H3ewY27Ck=
X-Gm-Gg: AYBFou1W88glV5mEQ9egYkrJ+zzZlktsq6vEvxjDkZ6x390pQPSCEAXvdQ/PGtvhzSK
	zlXmveg4uxtkAJtqTb2ciZXRhCpg48HPVFEWmSVD526pysIBGoZF6R+ePsCHzyLvBuIHer1FjqK
	yyv3ITIgkuTgJtNDJILjCXFHCRNaD+JKxz9VxXANfAkB1Bjh09paxxY+XvlERmr3Zip2NTXXkVV
	+O05e4bL58x+ofRkgYnwajppIbDtfzzhqNkvO6Zp3AYdA8q4TupyH9w5j1DFWjUBwDgVLIuSNir
	q+XePnv6JDp8ZCUY7F72lTi5udiknkid7V2fdp6o+K1ugx1VQDcHZlInQ+arYzXyUh8bc5qIAp7
	4p9qn9QbLXaeA49PXGfjUTS7GHtGCAWEjIGuq3YujKGtaeN6+MvhPU1C47XKcrbgBYuSFNzl7p9
	aqRHKFnMFh+b0sVIZhb5fCbh6SR9MSUZ+l6WrbJEvQB1CqAtsaNblJB8go/FhKsMgKvSggZwRup
	WfYXM3cI16o+TP41C6iAxP5+2aKViEQrB63ZThrv0CBUuT+R6MQ6zRCanQ2+lY1F3Ypri4jj6KW
	ydiFvbWBvmi1y07NEbsJnytgWbeka0ONTjodcaBuJchjNotN54NzVHVHBx2Z48vjvE05vor0HCQ
	V8tTshFNA9n6m/nQPFpwM8J4UqQkAQKo4psMus0cNvozBMkCIupr5i1ISKAHEcut510AXPLs3+L
	UYQwkqvSjD3aH+3bqCAD+T4idfMTFluoN2ugaT0yODChAoJE+adcqa7v1GVr9IINKL0IW1fe1sb
	gMUw3HuLFaRv5AbN7aWOUZVNZMUwvdOE7UQ0SQn7QwpWkUtc5DRPy+XXYbVCfJ53T+mh+7zihg=
X-Received: by 2002:a05:622a:a13:b0:536:51d2:1e44 with SMTP id d75a77b69052e-556bf740b8cmr38634031cf.22.1794410900573;
        Wed, 11 Nov 2026 07:28:20 -0800 (PST)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.88.101])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f04c2b8bfsm21341136d6.22.2026.11.11.07.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:28:19 -0800 (PST)
From: Jasper Mayone <me@jaspermayone.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	haraldnordgren@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: [PATCH v5 2/5] doc: for-each-ref: say how to read %(worktreepath) safely
Date: Wed, 11 Nov 2026 10:28:07 -0500
Message-ID: <20261111152811.99986-3-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111152811.99986-1-me@jaspermayone.com>
References: <20261102182930.3511-1-me@jaspermayone.com>
 <20261111152811.99986-1-me@jaspermayone.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The path that %(worktreepath) gives can contain a newline, which
breaks a script that reads one record per line. Say how to avoid
that: use a quoting option, or end the atom with %00 and look for the
NUL before the LF that ends the record.

Also say that only one worktree is shown when a branch is checked out
in more than one worktree.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Jasper Mayone <me@jaspermayone.com>
---
 Documentation/git-for-each-ref.adoc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
index a7b31e8aaf..9247737aa7 100644
--- a/Documentation/git-for-each-ref.adoc
+++ b/Documentation/git-for-each-ref.adoc
@@ -183,7 +183,12 @@ but if used together the last option is selected.
 `worktreepath`::
 	The absolute path to the worktree in which the ref is checked
 	out, if it is checked out in any linked worktree. Empty string
-	otherwise.
+	otherwise. If the ref is checked out in more than one worktree,
+	only one of them is shown. The path can contain a newline, so
+	use one of the quoting options such as `--shell`, or follow
+	`%(worktreepath)` with `%00` and parse the output by looking for
+	the `NUL` after the path and then for the `LF` that ends each
+	record.
 
 `ahead-behind:<commit-ish>`::
 	Two integers, separated by a space, demonstrating the number of
-- 
2.56.0

