Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63702F83A2
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960580; cv=none; b=ZmNk4rDlP0go5XrBhAX2/udsoUlJWpMl/nbeUuHCzJaKSgNHGg43dtQtoEyL2tadEPSHf6J17zdi4x915LU6L8/UR2G5U7/NsvC26XY7f4axhQVcFN9J/2S5olFuvBkTAq4UpDDj292iN3X1RCzHefGtNgvNirMPXw55SH4qjrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960580; c=relaxed/simple;
	bh=PGJRJYScMMTciNNZfBi65v4ibJMcxajhKMG2kBfT8LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9GnJG/G/W7CTdCQBDCG7hk4W0H7wUX53Ic2TXpkJ4Ku9B1YXrmxjdUwNJLUeOxdz9EitwPbLj8JbxbCUfNBDs7j1zGnHfVoEtrAdmDqC3aMBYkj9AxBdaNCXBxKoHqKGlaXCsrPu+4zIqhmll8wuIaqbZ4RbpjaGRfLCrABfh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oSmRMUAQ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSmRMUAQ"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79a7109f568so83350797b3.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 09:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776960578; x=1777565378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu/taWFXD5hfAnkHsx27mAexNm7U2f5uQRlTaz7e0t4=;
        b=oSmRMUAQMmh8MNB1eUQ06+UJSCFb0ojRqPDfpUju8fSu8ApkyMfLpwWgpH4qnEOQdv
         dsQYoTZxwnv9x/qFKaLSfgjdO3IYQGQtRGckUdHsZs8bXjyYbfuCTPKVoK677w3K87mY
         Ul9J6PvHzkUqpCrr69oXIChqCuTVb6dvffq6tD8yB5QwIV1kLSc7L/EOpz03cIZJyE3F
         tvFeYeuoGEpyk1JuOUwos/jQSmUtKRuip497brlR6wC36DD86NZNl4E4dmc1W20eqho8
         9jjbntoOGO5Jhp5FlGm4vUncRGnN/JuOld9BXigwR9+fnbLzan9uC0q8GZUS0ytE1nm2
         PGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960578; x=1777565378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vu/taWFXD5hfAnkHsx27mAexNm7U2f5uQRlTaz7e0t4=;
        b=bwwYwdxY7t0e8Vc1QREnMB07SFRj6Y1MvnYu6BoWfXnjdYwAcVDtrLzJqc4TzcOEUJ
         4p+R+gXOZUxtg91i61llaLGVuUQAAnVobG42YAhCm0aNutFFAiPELfl+YtaivWHrT3KC
         5sojOSseSkBjl+tVEiAZFuKvV2B/JRF8nYV0oQOUP7nlFNys50hC/UIaR7AimFf62Dxe
         cNjQ3VpSqksIJYKZVH3C5NGT3b/NStsc7vqAkXzMssc0cju/bwolfHBrhhJnxkq/gFWe
         VwLqilBITdOHPzqqLSzWBXjFel2XFnTd6hWEfeoWT5scYLYeGXkkw7B4N4LMLlEu8IUM
         TwYQ==
X-Gm-Message-State: AOJu0Yw+gZPqd75jQJ3qLbrOXL8Yp1TqBuZooQsWitZ3d4s7RBD4G+aQ
	SzFIry+Z/xhxOIfiUFHgencPmRw6N+b4aQ9e88oKxc9sUEz0pEK9zPZt3fsb89S5
X-Gm-Gg: AeBDieuKcWjpJGouokXN+RouwXgGAkT4moGJpQr2znNS/7oXCvZmK5DD7BXN6ShH+GI
	/vbXsTGJjG7EER5METd9EXEm2hrsImeMgTCO/dbhuRPX5IA3JMczHmizc/4nonJR9D7VeCecuss
	3kTcF4TGQhCevtmvw6DPblz9Y/GmDQwKvKWAN3HQ+FK1sq1tb62FGLBA+3prDf2v3Q04YUMzcok
	mFVYFdW/JmqDfM18qJ2LuMHMa/9/M7Cc3Tvb9FOu2Nc+26s9h9aOgHD0vngz4nQp92nK6Pcf/5v
	yeT0jX97Tkk5W/yestHwo1WBoIakaK9snXca47dxFwBhSB+L0DO8LbNCa+wWW35OYAG0dDaCvgz
	h54TP30Rz0M2oQm6RgBMA+glTfQ9G5Mj5TPBkvDN4RwaEY7IeEXeqAyrpTizESpjBbBb0id6KYu
	o/9BIG4KqPftdJy77E87fuliA95lsk2+OqrQL5gZUmYbE/k5bZcDVbQ43DUTMIaMq7Gzk+/w==
X-Received: by 2002:a05:690c:7283:b0:7b2:bf20:cdc3 with SMTP id 00721157ae682-7b9eccee0a5mr290940567b3.0.1776960578311;
        Thu, 23 Apr 2026 09:09:38 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:737e:f405:338f:9bbf])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7baeeaa2cb5sm51083997b3.21.2026.04.23.09.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 09:09:37 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3 4/8] doc: am: correct to full --no-message-id
Date: Thu, 23 Apr 2026 17:08:28 +0100
Message-ID: <20260423160832.114816-5-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260423160832.114816-1-belkid98@gmail.com>
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
 <20260423160832.114816-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-am.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
index 14f83a8920..ab71ab7490 100644
--- a/Documentation/git-am.adoc
+++ b/Documentation/git-am.adoc
@@ -91,7 +91,7 @@ OPTIONS
 
 --no-message-id::
 	Do not add the Message-ID header to the commit message.
-	`no-message-id` is useful to override `am.messageid`.
+	`--no-message-id` is useful to override `am.messageid`.
 
 -q::
 --quiet::
-- 
2.53.0.155.g9f36b15afa

