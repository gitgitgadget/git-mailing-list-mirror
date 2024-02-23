Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEFF63A1
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720262; cv=none; b=mEg5dgP52vAauYWiC8tjgiV6qYWi8ey8eOO1YublHkkzwOYPZd0ZKGobnw4XiP438P1weJwBoEXAk9TBkISXmgPCt21IIeFIuVU/jaxVh+JSz4qTUJTfArCN2F481hMQIkwIn2jIJ7cTurfJGYxYbaBc9jO5cyFWhqWPvMLa6no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720262; c=relaxed/simple;
	bh=Z8WS43NJCXwKsntoM82u31Ss5X0TU4bSRcfC4PSMtuM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RWvohFzmVVig3WVKni2mjYPiVA6itqL2O8BugFIXJECooruY2k+0OTFOqHYHjHyUk/aiYois1jW5SRlKRw9nJ5lTICFMyY8fWztYm+GOd2s8lIUw7ZcfBn8B0VQo8Y0WmYdfEZ70QAiv4QqhwbgXYMW0+vLa9bkHG8HGfRkR5/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=JYS7mBBM; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="JYS7mBBM"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-365337ad3e7so3572995ab.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 12:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1708720259; x=1709325059; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RXp5Sh0zW4qwHKOwcVjd8pTwlOfcyBs3U9fczsV37XI=;
        b=JYS7mBBM4J5H/onrtb25+s32QHUVNZ4AaaniQ88avk48WRG5fQpT/ENJ/KjYEBUU2d
         SWG6apmUreQGuwwGWvJEOJEnHG4NRijaNi6xRwCDdN6h9ZYbNZ+kDuYXMN02jKwMlv3x
         KHnaBVTqE7qaBC+idduqRef8yvwOyYgsh2csdvvBpPdniQ2Wob8CnH6Dv+w7Kn09kyuv
         zMuJ3GUng7zeCp+fFji1IUMDUoMGUIUPKT3hxcOPk4DPhmpvPd9ZawsV/LFHCTIp2/u4
         1kofq7rQFsyUHY9Hh4nx5J9cbWhsElYkaooSY16v6g7cZ1gglVeZuapqGifLojEuggac
         QHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708720259; x=1709325059;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RXp5Sh0zW4qwHKOwcVjd8pTwlOfcyBs3U9fczsV37XI=;
        b=T6peeDpNgU+e6QzLgWmp27Pe8x1Nf4u6UpQmp1DbBioGodYYExKiffEfrA0wa4LrQl
         LwhfSjumxnu3htnaxO0RLQ1fBKMLvy83LPQgdGvznWVmeV6BuicnLifYWuMdKVLIfLBM
         pYS9AqEX5H/KHuut5aaUR3y+PBI1xpKwDpGK2+77EPpf1EYp08l9Dq8t1dK0u6tdgMoo
         08qvow/y8ye0Ljsy6TSXIM1vex/BgE+ue7Z058/iOwx/EhxdI2WW0dbyvaVmvU8Tuvza
         wjFRtGZO5XhYEKumjsNWlEIXjKyPnIgAr2/AhjMVh5i9jbJ20noTutCGSW7n3pqN/EBy
         2jPw==
X-Gm-Message-State: AOJu0YylomxUHGJsAEMgtAQK6XU14+9o7vUx0kdqvM1RfpAWecpJ9/Cm
	12p8KsOMPilrvsCNldX+M61PfHEoz9stHhV10fquknvOD+FOxirMlN7XadXIiWhwmLfaAOkbNNs
	Wm6o=
X-Google-Smtp-Source: AGHT+IGWxnDyoncLw0QUytGML1cwlS6L5/ka73ApClmvG7wHATf4MDMwWHZ9duuMJK17YA/oT5fK2A==
X-Received: by 2002:a92:c904:0:b0:363:9b16:ba64 with SMTP id t4-20020a92c904000000b003639b16ba64mr982362ilp.28.1708720259603;
        Fri, 23 Feb 2024 12:30:59 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id db15-20020a056214170f00b0068fa7e73367sm3667948qvb.42.2024.02.23.12.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 12:30:59 -0800 (PST)
Date: Fri, 23 Feb 2024 15:30:58 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Documentation/config/pack.txt: fix broken AsciiDoc
Message-ID: <72bb58e5f3b8a5a622394c5ff40426156e122580.1708720255.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

In af626ac0e0 (pack-bitmap: enable reuse from all bitmapped packs,
2023-12-14), the documentation for `pack.allowPackReuse` was amended to
include its effect when set to "multi".

This split the documentation into two paragraphs, but did not de-dent
the second paragraph on the right-hand side of a line-continuation
marker. This causes the rendered documentation to appear oddly, where
the second paragraph is treated as a <pre> block when rendered as HTML.

Fix this by correctly removing the indentation on the second paragraph.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/pack.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index 9c630863e6..da527377fa 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -34,11 +34,10 @@ pack.allowPackReuse::
 	reachability bitmap is available, pack-objects will try to send
 	parts of all packs in the MIDX.
 +
-	If only a single pack bitmap is available, and
-	`pack.allowPackReuse` is set to "multi", reuse parts of just the
-	bitmapped packfile. This can reduce memory and CPU usage to
-	serve fetches, but might result in sending a slightly larger
-	pack. Defaults to true.
+If only a single pack bitmap is available, and `pack.allowPackReuse`
+is set to "multi", reuse parts of just the bitmapped packfile. This
+can reduce memory and CPU usage to serve fetches, but might result in
+sending a slightly larger pack. Defaults to true.
 
 pack.island::
 	An extended regular expression configuring a set of delta
-- 
2.44.0.rc2.25.g54c9b1361db
