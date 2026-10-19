Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A0549BD75
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399485; cv=none; b=B6LlRGjhlHTYkzky/y/BuXTq7y+3YxX149gkIL3ZxqJS7Tihdxkjk9xAAZ/kV4Z2JBlBG88z1VkhJuw+UpzeR+8YV4sZXQz3PF7B93hcbThasaQxiP5BwHIR/VrjyTHJJX2Pq2Ltg4njijZojW9L76/WmPb3s+fgcJautTW5u+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399485; c=relaxed/simple;
	bh=Bt+MELSvuxR1Dc6XElGfus01kM7nv65Vdd/VUBFnDak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5EE7dLdiux2VABTgaKiF8piNESy1Yq84G5IvS4eVsP1B0B9hhikHFbX1Bg2LTm3poQ3GNIKJlwNgjfbJVc5wamFoUxecZDIbIdZYUNMS+266Yog+OGHTYClM74pUfONfvweO2YLIDRtvvK7V3QO6WFMzlGtDwWSWnDNKMK7yt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEYI4yEw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEYI4yEw"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so12666185e9.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 01:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792399479; x=1793004279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4VfyHJoMQMFudgoqclu+6ApVTUqaM2l22KkaJGPaSSc=;
        b=PEYI4yEw0aL5MIkwAcq9fBH6nxWONrASTSbItVXG4f9zqbz9ktqgNZ3zdI/enbsLfR
         8+uxjrekFg2E5Hka1o25+hn04aq70i1I32YIaPKYcAzH2Z3Xogbexeb6glJqFO8JyYP3
         TGUFrWFztHpxVoYU9Q7RUUCWOUdyKD1GnC0ENN4kCUYBYS48CrJv4c2A8+dLldkWon/g
         capDn0wcNRvMBoGjmcHuupnaQVxXYxiEmOjplX4pf1Zv/bGCKVsQJJ8otpK3Y4DtJSz7
         YchuUuJQO+7C1Qe5RpqLnVqdwhQ/BGfzjOuChzaGDRYIn+IHQCrBppbA+DC3PNjCXUqT
         vtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792399479; x=1793004279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4VfyHJoMQMFudgoqclu+6ApVTUqaM2l22KkaJGPaSSc=;
        b=G2tT+lEH6jDQkLf3F5LX84rEbFk4J3hvuUPcnz4IEp6MCOulDElIhxUTPEkUEj6hch
         xu0xa2X3HNDdQZZI+c2cxD9x266yyTgppseuOXRiuxb5k2ubGb7U+LhVT9aeEdSuv5Rb
         bTccpDU/BrJpRk5PGVxv6Zm17oHOziG6A9FpwOmHNU/RozCULrCn3I8dbWKGgfgWLaI3
         Xy7GAbGMT6/7cCivIp/Q2YzeBXcdIm8eFBr496iVeOqhrhmk5yOa7l0nK+V/z4JLlbsB
         M0D7mXmUTLju+A/njB/Q/n7OiitgscSYAliw+K/Qkx0CJl6YF3AQmjU65sZB+YatVOv2
         xvOw==
X-Gm-Message-State: AFq9FYK2C6F1kGrbeOTWo0wgi2ljkUu4V4NbGtHM1O+TFo8vtLTr96ZC
	gWSZlRuA4WKChFsJFE1v19Sw/2U8Jeuuaavk+mn2qcMPjad+Y06snhjt9JeNbb8b
X-Gm-Gg: AYBFou3wVAWHaQXI+4a/5cXUcJkCYByOfQk2pKeqcL1/gDchWLtsC1AFRFPPQEuf3uu
	ZFZUrADaTHlJBy40G/Fe0VWN4AMJv/HYrOV7joZLcsy0w3MaE6f3821hd5mfGWB3LbFdueyB2zn
	h429A2xonUTWTzMYxkOvcfNfr8KUV+nF0vRFaO3b7xqCW8tAju89aAX/yUm1jnsg5mEO2pcNZmr
	+0tnw/8FTYRcHhcKuOl+oC/WQFgH6c7dDnLcuwAwdPGUl3cJ+K+bU9MdGv8xUg59YCueRBsZVUD
	sBN8t5lUMgfQsYX8j+RPzzIJZthKqZUMGyM8oaBp7bZv97VwoxqIiwf4LpYOBJFQLZB45l7ZXG6
	XTwf9+jkbAj2rJkT/GX4ZUl3ZaebecLzG71ggTp7DSlDpf4NTKJCTqDIOLL7MEo6983BFqcdpbI
	B1/ooWanZ76UNjef+5/sJqOx70KbLX6gm25cC7E7x+Fjca7YwIGNL9neAgAAul+SfBLwIu7vdEO
	1QyuBNqcfSY/1Scwze2TDkGmHiLFW8oBA==
X-Received: by 2002:a05:600c:3e85:b0:4a1:813f:2a5b with SMTP id 5b1f17b1804b1-4a1d75f8352mr139943735e9.14.1792399478442;
        Mon, 19 Oct 2026 01:44:38 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b303csm342426325e9.8.2026.10.19.01.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:44:37 -0700 (PDT)
From: kerylefondji7@gmail.com
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	christiancouder@gmail.com,
	siddharthasthana31@gmail.com,
	Keryle Fondji <kerylefondji7@gmail.com>
Subject: [PATCH] archive-zip: refactor 'path too long' error message to use Q_()
Date: Mon, 19 Oct 2026 09:44:27 +0100
Message-ID: <20261019084427.1879-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Keryle Fondji <kerylefondji7@gmail.com>

The error message used "chars" even when pathlen was 1.

Replace _() with Q_() to handle both singular and plural forms
correctly depending on the value of pathlen.

Signed-off-by: Keryle Fondji <kerylefondji7@gmail.com>
---
 archive-zip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/archive-zip.c b/archive-zip.c
index 6f73ca6d58..e4f8ef5a36 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -328,7 +328,7 @@ static int write_zip_entry(struct archiver_args *args,
 	}
 
 	if (pathlen > 0xffff) {
-		return error(_("path too long (%d chars, SHA1: %s): %s"),
+		return error(Q_("path too long (%d char, SHA1: %s): %s", "path too long (%d chars, SHA1: %s): %s", pathlen),
 				(int)pathlen, oid_to_hex(oid), path);
 	}
 
-- 
2.53.0

