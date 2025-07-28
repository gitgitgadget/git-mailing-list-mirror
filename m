Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9856D213E85
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734057; cv=none; b=oIQUHz02vSKU8nw9HrocuyWs2G5KU95CxEiPnTDQte5Nf84DUndA2NhZgzOTl/IyCuqxs8BlIDQgRlzY/rJSKj97IfWQ2yZzMiR4OmBb4mtK7DJokKED1CSgY4n341yYh+sfm6wFZSd1HtlDbSYQU+Dtd4L7lgRnLNTtXv6shLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734057; c=relaxed/simple;
	bh=Je33pJnXZ3Z6jKsRqmsojgxb7QjQXWZ7irL+9Cys3mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p4L112HUOTcaUcMOrIwZT1zis9GxtELUkcBcgXJPhKNBJhTWa+jmLp2GbuFFpAmIXap8dpZz4gaUvDZD+4I09D5x+PkRpy/IhoUDPCqaGgQNJ1fYv2p7PAEpnxBuR3jIxs9331yni+FAgPkckqMvDpwezX1Jd0XSGV3HC2PM2Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjy9XcQE; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjy9XcQE"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6152faff57eso2708743a12.1
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 13:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753734054; x=1754338854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVwb4/gQ3MRXzq/X9HC+YmRv683vK4qBhyFxCM6QNZs=;
        b=bjy9XcQEC73u8McO5voAvPwMpZz/1QwHwBh+PfHmn8xHFfohnS962NWai2sYIj8igc
         ltL8dDeoi6zFnDb5D+PfhqEgkAK07gbPeSN0GbVLTdYkaKQbnr4SS764IvepFkbOmb1E
         v/AkhPvENV3h5obLFa0S37l6flRG1n59InWE277ufbTN6nwhQinLoLAKuG1dM0g+6RTt
         Oj4oRMXujvhAqIBvcvsdqCgJPUQdvKBy1+TWlc/hvUk0eao55WGHFwShVlXhenb/3IHo
         /rTpkInzTgb0/F9krxh5mgI8yrSro4gLnRoWtMA8cgkPDQRYHrTxxeE4ORqRhJKn+jfC
         aAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734054; x=1754338854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVwb4/gQ3MRXzq/X9HC+YmRv683vK4qBhyFxCM6QNZs=;
        b=pwKpYGxNKLeMwNx9a+QLbiMBaVwrKGlhpye3h5SPqAV/IFOe7b7nLr42I1Q1ByWpBO
         YrCImHpNxWLWj/W0RAxA9S0PltM9foOB3jL6BGE2AqJdl8MC0blrb1iOv2T61z8E/S2O
         B3sBtahF7aHIulJ+RhMuJXBAXtAjuq81NeN8rN4AdDEV+6m595E4AAd0dM9sEQZHkFoT
         Dx21TBJx7CqY3fx8AEmQEBRdYLoudJVYMP9/Ui/yfODzIXRMRaIxFsEqpWtz/+P1uG87
         l0cp0VUFEA3iVWZnPRW+t+4B8tzkPTODad1T5V5jZ00PZtJDsAtP1hQjyCOO6N26FNBW
         UfnA==
X-Gm-Message-State: AOJu0YzqUHnmpJ6rMPn4okl8nMfXd5Zn5IZmCYGitgc1OFA4k7YK8nWw
	XNYtrK6K00bC1x1rWFWvVHwrMFlZ8capAuLz3vmSSlQHjyLou1osxg7d/c8Moge6
X-Gm-Gg: ASbGnctPNubq1Uzh0gcetdGouwt0EmifB45Idyhj6YsQ/R7f0qhIoO33dS2GD1fXgrL
	s+0EevL0k+rFOns8WBRk8h5HGcK8jOZBWoLCfJtOef0M55RVff8qV9axJHk+NUq/vg399FJCA75
	VD45UKHjMGZjHgZoLPvR0vFVNC0+GSJ2rH+FfyEsBktnj2K/gaHGT0ppxFEqj4LiOk2k5N/Zqzk
	kQhH8KJqY2mo+U1aaxTaVIp8d2bSGtDe1bm4lfGW27YjHHJDvLpbpK1AV1flnplvi9GBrlBsreu
	rPuevBSQSGeTYb4N97bDfolWu8wGaeFuArMjZAnjl8IYgOdG8mlUIpIoMG2mlMROGZgFvw3Ub9q
	ucy4guORm20Gk2Yd129JZDyrw2luP
X-Google-Smtp-Source: AGHT+IGGFn5hMs6PyV8as10iqdnX+lYbAvCFFxrhcRUEaC9qPyc1imSIH7XOZIe0FAxCmd1TpDTkRQ==
X-Received: by 2002:a17:907:7283:b0:ae0:a483:7b29 with SMTP id a640c23a62f3a-af619c0d81emr1567472266b.49.1753734053360;
        Mon, 28 Jul 2025 13:20:53 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:9706:c2d9:b21a:2042])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a62ab9sm475376266b.86.2025.07.28.13.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:20:53 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 28 Jul 2025 22:20:47 +0200
Subject: [PATCH v2 2/5] for-each-ref: fix documentation argument ordering
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-kn-small-cleanups-v2-2-d3021c8bf471@gmail.com>
References: <20250728-kn-small-cleanups-v2-0-d3021c8bf471@gmail.com>
In-Reply-To: <20250728-kn-small-cleanups-v2-0-d3021c8bf471@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1612; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Je33pJnXZ3Z6jKsRqmsojgxb7QjQXWZ7irL+9Cys3mk=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGiH26Jgcm6CuooHnfiMT7WL8vPzKcHENE1QK
 c5lPnQjHC8WEYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoh9uiAAoJED7VnySO
 Rox/HlIMAJ9G2VRlhiehO5IXCZvNM6LZvDbEIHd4I4fUAlBx8ozEs1Oyp5LvSHNiq+J1He+nt9u
 U2WcRy/GGbd3nleDFp8xk16hRh1WXwzaz/nq7tqr9qOuOO1hHaTjYSVrMSaY8x6QGVf/Gt48knp
 e/nwfXtTCeE2vdnf+eXUOu/hXCEGE74CThotWAbZd2YIgjAoxRfWIl+LV+FNcl3aeexdQP9DD7M
 uDVG/HTOmzpu5s8TPzGR5EXbswFymdJRreg/EkGdkhW4KhvwCfjDEt73fVjTeWWA5AQFVnsvYj8
 80bxsXASHr6CgjqhQijMYStcOR4z8gJV2tG3FI28UQtwNvy9KsI4wmfEvxcW5PHtWNWPJdvQz6d
 2QJMlv9kyv3cxUY5n7RDF7tpUy1dZrP2A2+8MqgUwNosjvwjOrSnj+LabW98YEP/KfRJkDsMzdN
 /MWGgSZFh8Ncaa7Oec4LZbTMxp9CG7rIPUmUpgytiJqPf2DbZIXBzXSfXmgYVlChuIyz02c5yz8
 ls=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Improve the 'git-for-each-ref(1)' documentation with two corrections:

1. Add parentheses around `--exclude=<pattern>` to indicate this option
   can be repeated as a complete unit.

2. Move `--stdin | <pattern> ...` to the end, after all flags, since
   `<pattern>` is a positional argument that should appear last in the
   argument list.

While here, change to using the synopsis block which will automatically
format placeholders in italics and keywords in monospace.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.adoc | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
index ae61ba642a..ec3b10e14a 100644
--- a/Documentation/git-for-each-ref.adoc
+++ b/Documentation/git-for-each-ref.adoc
@@ -7,14 +7,14 @@ git-for-each-ref - Output information on each ref
 
 SYNOPSIS
 --------
-[verse]
-'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
+[synopsis]
+git for-each-ref [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>]
-		   [--include-root-refs] [ --stdin | <pattern>... ]
-		   [--points-at=<object>]
+		   [--include-root-refs] [--points-at=<object>]
 		   [--merged[=<object>]] [--no-merged[=<object>]]
 		   [--contains[=<object>]] [--no-contains[=<object>]]
-		   [--exclude=<pattern> ...] [--start-after=<marker>]
+		   [(--exclude=<pattern>)...] [--start-after=<marker>]
+		   [ --stdin | <pattern>... ]
 
 DESCRIPTION
 -----------

-- 
2.50.0

