Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7751B94D
	for <git@vger.kernel.org>; Sun, 28 Apr 2024 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714343470; cv=none; b=vGLGk412KstCRHXjApufmZ/NwTFKxDLqvfMTtBJfL0jilXvW5B1fmEKaZ3GfNeoeBL3KLYEi74EKTmINAy0frliGI5Iuf8Lb963t/TfC/sIxCe+XySfJQ/GEQq2pAfw6JQ7J0APET7cMh1CHWXoO+HiGyZDJnWlz2fD8YqJgEbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714343470; c=relaxed/simple;
	bh=6P//f8JMEH8kLtXWu/dfRvih0SIvjcrQJAOjp3bWXIQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=t0vWRsaFIBo2tdFPAY+MCxwOLMt2Idsti3MyssuZTkxLHXjmpi9OpI2pWpITmvmepGP76qdiKX6AS4+0YigHXp9W8sz9C1ZPS5pH0/fP4H1rksYd/E6xu4osDL9kFSzJSwk13pC827CglxyrWsXd8vY+LTf8vNEQwznaOkXoUqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmUMT5+w; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmUMT5+w"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41c011bb920so3945045e9.1
        for <git@vger.kernel.org>; Sun, 28 Apr 2024 15:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714343466; x=1714948266; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RX1x/NHM/U5P1n5FRlp0kF2LnyrqYseRMqXH2pCSpk=;
        b=nmUMT5+wK1orS/3d60q91DVw02ezV5zZ9CF7IegYRFzm9KZQcLGW9RksiXTL6Z1w6Y
         aSD3quMbczfYj5HIGJKSOWRJbGAnP9iE8IkXFgCw84bhaBasvBq+ZqYKrmQ3E2bK84BE
         96fRg65HJq43M563xfwExnWj6vTcCIGOc1RjPmG01+27XUuuBgLYIqPJIGDsTBwinQQp
         V5AwcIZ0BKdOGNxA/JYa+uKzmcN1m+U1cI3Cuv/ly84ALPB7BJXaFhb7FsAVw7yc8S6h
         F7nAby60ziBHZFbX4v4WHxdyHu1eHJQVR13+NfCrPTytqurYco55Ka0kMNy/87XX9uXg
         Np0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714343466; x=1714948266;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RX1x/NHM/U5P1n5FRlp0kF2LnyrqYseRMqXH2pCSpk=;
        b=CYaTistU9adUbf75r2IrIU3DIg5V3MasDmMZMS2d1BozPjX/43z0hAHVhnrr3vneBk
         ebqiYdQBSnWoBABnXII6mp1rkz/gOXKOgj+Xe/r1cfaRgHjiLDzTA+silvM3Sfk25P3l
         3sYeELxdkmdyjoyzq6Nh9zzFrHcJmnfQumtos4X3T0FiUUFAhiIKlhwN8mI+DEQGZQmw
         iY4t2mSxAfc8pTo2SSGQaYI9ZEndYphW//czr3vZ5/+fJ1MGM84/HtdfDwRlIbIUtr1V
         c2eaDNFYD39xqRkCIyjVUwUi37G9fLFWjTzhkhcSyDpXpS62xNWcCaWEMUFxC9sj5U6G
         OVcw==
X-Gm-Message-State: AOJu0YzEBXthH+2RBwihnro5J5PSt2YFKtCUiF1XOTAEReGM0OFzyvK5
	AtUi+K5bqJGYb8WYapbZ5Fphlo79n+paPshcJnynlBZIqOYAlz5bcrQXFA==
X-Google-Smtp-Source: AGHT+IEDyLnVRFpzLC5sfEyJt3W9ytdLIappAdHPBj+62/9X5woj/iftbRdSsfskxx8E1aIz9uvDDg==
X-Received: by 2002:a05:600c:1c26:b0:41a:56b7:eb37 with SMTP id j38-20020a05600c1c2600b0041a56b7eb37mr6724368wms.20.1714343466009;
        Sun, 28 Apr 2024 15:31:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c4f1000b0041a1fee2854sm28364198wmq.17.2024.04.28.15.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 15:31:05 -0700 (PDT)
Message-Id: <1e0895651cb77759e983b365eda0e7546bf7453d.1714343461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Apr 2024 22:30:52 +0000
Subject: [PATCH 04/13] url-parse: add URL parsing helper function
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Matheus Moreira <matheus.a.m.moreira@gmail.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

This function either successfully parses an URL
or dies with an error message. Since this is a
plumbing command, the error message is not translated.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 builtin/url-parse.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin/url-parse.c b/builtin/url-parse.c
index 994ccec4b2e..933e63aaa0a 100644
--- a/builtin/url-parse.c
+++ b/builtin/url-parse.c
@@ -11,6 +11,16 @@
 
 #include "builtin.h"
 #include "gettext.h"
+#include "urlmatch.h"
+
+static void parse_or_die(const char *url, struct url_info *info)
+{
+	if (url_parse(url, info)) {
+		return;
+	} else {
+		die("invalid git URL '%s', %s", url, info->err);
+	}
+}
 
 int cmd_url_parse(int argc, const char **argv, const char *prefix)
 {
-- 
gitgitgadget

