Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABFE15098A
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 06:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738995435; cv=none; b=GcZQstNiG+pwEqh950Cgt2X3Dh/aosZSSYBSe9pHK2d7Or6mZ3CJM7IaUunv7aoBdIhOEddbTDvt3x7g1hJDsn0BpR9HzCvatE8/HA8f41k9ei1ED4C7FwD7J0OyeuD97Y3ApIpzVFRxB6bXIq1R9SafEDw/6eFDH2UxvNVHHEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738995435; c=relaxed/simple;
	bh=kTGI9yXjJwKs9N6AyDQ+0oTfMsxjZYbZSEp7jCMQwX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DiDqDgF+DL92z+myj5zLGgtg0TiLXim8/ysJ53IpqLP97+JsIzM3jWn4PYt1dTKHjrGMJpwnECsqXkp5xWbamGxSzxm0DqkxIQxHD/Mo6IEY1HZLryEjJSr62S6asKcfhiZKmaN36U2NmEulu1rHWmlfbBjfrS5ktp/lou+eTZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5K7XYtN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5K7XYtN"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f40f2bafdso33158965ad.3
        for <git@vger.kernel.org>; Fri, 07 Feb 2025 22:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738995433; x=1739600233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v6OHz98FhZfJZPOZHWSgPd7qxU3wcHRo1PvQvZ7YjwQ=;
        b=f5K7XYtNXeALPpMm81xK/7hFnQXikj8KIhCkV2084B0wScYWxy74YpIYYRoq8faT44
         W5C5MjZxCFW+cgL/NFIsxgp2d8INIOZjqh9DSX+uD6qTu+W+afw13iORGbRchlBDnW0d
         fbIViWoEnMKdot7SW7pMAZohnQhjskkADC57P1Kl3ZsT/O72NvWqRugqmv3wBp1b3RG+
         xi9IvDLbh3+NZYuxkNyKVsOe27GDBaa3YcgaSnq34NdwuKlI2RaCIFplBXhH+1QWe3Zy
         6DINTihIwXnSHPzP/PsQRTYoY+ns/pFQarsq7TpclR3ecOefILl/559pp41XMJ0o+bew
         GomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738995433; x=1739600233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6OHz98FhZfJZPOZHWSgPd7qxU3wcHRo1PvQvZ7YjwQ=;
        b=ojyj1urzKo73DX6+Jo3UmYUaemBdV9uQjCCG4owxrmv5sv5cTVN2syM8FxT1PMwtIL
         S6o19SxLnz0lrpwdD0DB2uwP7X3LmmGzS+enkm7QLdyQ1G7QF9rYBvp5yadH3kpPt0ua
         KQoae7nDrqwBWmimR1PCbl9DszVOMTO3ix8lw/HK4p9LT5+UXIfamJ5r4XT60MrC8Iuy
         /MwgU8YYSJcg9428P1VfQmn3ZLuhAiuIbdJTXrFQS+nvYKBzqvu21psG+1S6cKN6b4yW
         ylngHyxxH8+exYPg7p3Gj5HPYV/ZwJGgMGOgEhcuQx6Yr/SetN4HGm5IfB3yk9OtU18w
         JSHw==
X-Gm-Message-State: AOJu0Yz5XgOmMmwGLs1gKLKHw5VW8DN+z4/udJ8gljLQ1T5noKALdVoy
	u+egPw8iHADh30cL9hNUHtkqiSyNxcOfGgwtlzYJ/d/xjuXJ6+hiUU6Hsw==
X-Gm-Gg: ASbGncu4/4LWjrvp8qXCEN2eFw+68bWZETlfUwGORI1w/tES+QRbqVPo4DxqzOEei3Y
	o2MjdCoSQr8Q3ORpvJj1Xo/M//9zBNCSvWAOjsVmN9xszNdAomU0Io6NQ5PybnMdLekIAlXds4d
	DA06vroNsPX3A99coIiy6gg7xi1YGMNC+uNwosqLeiPTp7hAy3KqF2N4ZnBLFVuEwdqrdN2wQMn
	Z5bwEciDuzNYOzVBYZyNKIjlN1//sE5OHLQfpG3vg0MAxgbpFX0WF159m6U5Q/XNTeM88ZmTSQC
	laKYf1L3C86G8HuQVoXhySYsISNRSmHAklxQQ36OaivYKw==
X-Google-Smtp-Source: AGHT+IE5gf7Shyc1b1A9LpL0HaYKTVXzWP2U3kzx/VWgP0ldqXw9ZKPx1dMgcc8dTItl/dxKrCUuTQ==
X-Received: by 2002:a17:903:2309:b0:20d:cb6:11e with SMTP id d9443c01a7336-21f4e700863mr98153845ad.26.1738995433149;
        Fri, 07 Feb 2025 22:17:13 -0800 (PST)
Received: from localhost.localdomain ([2001:569:5254:8400:f8d7:c9fc:3743:17e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650ce16sm40616765ad.9.2025.02.07.22.17.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Feb 2025 22:17:12 -0800 (PST)
From: Emily M Klassen <forivall@gmail.com>
To: git@vger.kernel.org
Cc: Emily M Klassen <forivall@gmail.com>
Subject: [PATCH] revision: fix missing null for freed memory
Date: Fri,  7 Feb 2025 22:17:02 -0800
Message-ID: <20250208061702.88469-1-forivall@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git log --graph --no-graph" missed cleaning up the output_prefix and
output_prefix_data pointers. This resulted in a segfault when using "--patch",
"--name-status" or "--name-only", as the output_prefix_data continued to be in
use after free()

Signed-off-by: Emily M Klassen <forivall@gmail.com>
---
I previously reported this a few hours ago, and ended up digging in and figuring
it out. I'll make sure to bottom reply in the follow ups to this patch.

 revision.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/revision.c b/revision.c
index 474fa1e767..84cb028e11 100644
--- a/revision.c
+++ b/revision.c
@@ -2615,6 +2615,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		graph_clear(revs->graph);
 		revs->graph = graph_init(revs);
 	} else if (!strcmp(arg, "--no-graph")) {
+		revs->diffopt.output_prefix = NULL;
+		revs->diffopt.output_prefix_data = NULL;
 		graph_clear(revs->graph);
 		revs->graph = NULL;
 	} else if (!strcmp(arg, "--encode-email-headers")) {
-- 
2.48.1

