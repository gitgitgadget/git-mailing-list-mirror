Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF7F29ACD0
	for <git@vger.kernel.org>; Thu, 15 May 2025 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314724; cv=none; b=WdNk8IP/jpkdhU4PIOesXeMR5C8KZEqFnJh7sTl61GbEqQ3PxBnZf9Zh072gqUAoDPfq+d9OkxnnvIr+f8GI2CS7RPohO5hsp7KBKUXPGKRuXet6hC+bKjeQLJmeYs1PHuQhuH3/7lx4hVphsZYoft9iKxp32G4tLr8ggO/7+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314724; c=relaxed/simple;
	bh=Gx9rTyfZx6EN6AXxgdNiyEv3OGgY9g/B6zwSKEkv6Vs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qpt6jg2ZfR6p7ZxdgY77QxS1tGCTdvVejUgyXHBd5XGtCd6Aw8mfe4HxOrsVES7WWcqZUOteK6pXtflHDvIIx4ehKv0Z4rkQoHbG0TnCgQ0mi6VFNSG38XQmpfpKYWha0F21bUfOWItCrAHdB+oVGjd5JsL5azl8XRHaV9xFY4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Do1KGEZm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do1KGEZm"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0618746bso7278105e9.2
        for <git@vger.kernel.org>; Thu, 15 May 2025 06:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314721; x=1747919521; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iv4XYHJ4JGt0QCNNV2wtmmY9RIZk+WhcWi0gTmAUVDU=;
        b=Do1KGEZmEG++BIvErAILz3602hv18bQbVRXdLq1mrCWy56y6NyVhKiS8nBt/y40CQr
         12cYAOBLlpbmRY1KlndoJwHRQjR7OALH3lox33u5wa7EDQgtLnjeNOWA+4xnFrD29tGc
         h/ZWdXmS+IcQRKVoTWAe5OL/+siv9p1UtWN28KJPgZnCqpL9DQQmrOGxKCwdE109x/FF
         P4YfoLO8f4/OZ8vVELac67nu0+nBc+qmlMTUgkKzJOPLLUoK7wHqyMfAI7Y7YEbrhy6y
         6t0wfSUmNOIwrq1iscqxByngl8BVfdBt/pUEMYW8sn8MdupAcP3I63o7j2wXYoTY0UUs
         tF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314721; x=1747919521;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iv4XYHJ4JGt0QCNNV2wtmmY9RIZk+WhcWi0gTmAUVDU=;
        b=xEA+fjeXuIq8RmtPiAGV/Zo6yUuQiMmEUQuYW3A67sE7FovKoxGnfxXyy+8e1Y+knF
         BvZpq5pnDmo7uqnJsR0RE4sNn+oR8FnWZ0/DxkBgusxhb8UN0zumadg1YnECjr0NqMjC
         NIbsN4Z0VPx5RPp/x+5byKwhATiPVaL7TwFNQ5H3zTOus8xesYQqN9r3vdnJlQx3/G+o
         e+Sao6i+R1hIvwJw77//WnJcDgJc7loOkZ1E1wxrPJH4hg9+hQ7kmBND6DWM8/46CK0I
         mHZVGKaavZZ0qJqPNzQrLKHuHr7V1awY9e2YzAXzuzMUQQUmP2nbnuchlmpu8FNrFezE
         pCPg==
X-Gm-Message-State: AOJu0YxW9evp7DyOQlk9USKQ2QxhA3B0H0K7SEG9iFoSQGJ4kqAN89ss
	OTnBdDs9whixBcf82QwvArtqWIT7NT4juOM5H57rRyXgKstRY9B8Nky/0A==
X-Gm-Gg: ASbGncuvI9/d1qkRLKhtxWolwBJGvv7r6CpANFO1iJsASrxt8reF2tcJy7npTvUJK3w
	PDgIuhiEAfVJ4b6y2FmoO0th+tIGED40YTxOQpcUe2ayPp9we1QesAuA6bV38tm3eVOFLZjtSZY
	Ia61K6wDljxFG5QRr3/qH3VdkZ4lSRC1wIwiprrG4x0Twr5W1gQby4AH5SesXD1RbY/f9viRfgD
	CxO9DcPg8Jn1VbHXwNZD5GZmlbsQN3dao7dhK66Wef0vt9cq22Hl7d1MEWaA0wiKeOkerJNDu0q
	R5aHwXuxDcESMyoSFjj2u7Y9+X41adg0TaT7yV3bxI7+I2Aaxy+9
X-Google-Smtp-Source: AGHT+IE2GDvZmK5Bd+Rte9pbXGFby1q/aIA8iq942II+TlB/IZz/2Uwc1tYIPrUn//JG/FYLxVzL7w==
X-Received: by 2002:a05:600c:3d9a:b0:43c:fffc:7886 with SMTP id 5b1f17b1804b1-442f96e9564mr24318605e9.8.1747314720538;
        Thu, 15 May 2025 06:12:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442eb85a3b1sm64676545e9.0.2025.05.15.06.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:12:00 -0700 (PDT)
Message-Id: <4dc3e2335afb42e5006ead7b9b18d33bdae7238f.1747314709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 13:11:48 +0000
Subject: [PATCH 10/11] bundle-uri: avoid using undefined output of `sscanf()`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In c429bed102 (bundle-uri: store fetch.bundleCreationToken, 2023-01-31)
code was introduced that assumes that an `sscanf()` call leaves its
output variables unchanged unless the return value indicates success.

However, the POSIX documentation makes no such guarantee:
https://pubs.opengroup.org/onlinepubs/9699919799/functions/sscanf.html

So let's make sure that the output variable `maxCreationToken` is
always well-defined.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 bundle-uri.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 96d2ba726d99..13a42f92387e 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -532,11 +532,13 @@ static int fetch_bundles_by_token(struct repository *r,
 	 */
 	if (!repo_config_get_value(r,
 				   "fetch.bundlecreationtoken",
-				   &creationTokenStr) &&
-	    sscanf(creationTokenStr, "%"PRIu64, &maxCreationToken) == 1 &&
-	    bundles.items[0]->creationToken <= maxCreationToken) {
-		free(bundles.items);
-		return 0;
+				   &creationTokenStr)) {
+		if (sscanf(creationTokenStr, "%"PRIu64, &maxCreationToken) != 1)
+			maxCreationToken = 0;
+		if (bundles.items[0]->creationToken <= maxCreationToken) {
+			free(bundles.items);
+			return 0;
+		}
 	}
 
 	/*
-- 
gitgitgadget

