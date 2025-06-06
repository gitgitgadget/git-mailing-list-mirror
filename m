Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466F027F732
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749213120; cv=none; b=QQCHUibiH+yy+klqy8AIo69TqX4YoQmqc/kMXmtdIMAqnTFjMBZud7aT4rtzdoafY476rLC4aW90uS9UiGhsES8zTuNgwSpuIal9f465+y0xL9y3kOqcjimqu4j4vLCAH+kqPPBA/G5GHhrWZ0qF3GVtxzQ0p9CzMYmBhp/Mx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749213120; c=relaxed/simple;
	bh=ltZQVJGFC/+qEkSURmtDon0Tfc04JwIjL0LLVAIBN0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ViWFS+KDR4OYqIKM+S5iASLMfa1GMf5lhkvosULaOUNTZ0O8usl0i23eI0UvhvwZahUGlsxXLA3YiKNOQat1wtgXlmmLh1FQBftYuTEcbaLs2weN9ubMyIiDYkVVhwZhd4b2b+6OvGfEsdZGXlDsb39rQ55/MluPnNUmVivjzDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQB4mtPk; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQB4mtPk"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5535e35b059so1992640e87.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2025 05:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749213117; x=1749817917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KnFoUOKmEmEG8jfh9JjNcj/eFo/LkQoP/eNWrex+sks=;
        b=AQB4mtPkYaIHPaKlWdlcUJxH6C5mCEOWYh1MVNMY1466iCtXHNQfSmcm+CO9s9soui
         Kpxwgj5tIF7kQD0Jttt8JN0rPEewZduRJkXyKdJEBzJwWoqhbliDttLSX/2ZddkqQ1zC
         KzkT4d6cWj26ONIb+SS2QafPmcA2CbynGdb31FwLm5Rem8EjZoHrYHsIoV12tDQmqH+B
         GkvlaWv3B1BNq5QNZr19Il6QFU4wL/uiJhCa6h2vSsN7UEDPFLsk6TiC9n0qcCcxtf0Q
         /Mw2PgZRcHVIhrpzXvGxFJ22DEqtGOMpzzfJSz5vsEgdJ6qOy/QXUrY6IiiYzGzPKFph
         ercg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749213117; x=1749817917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KnFoUOKmEmEG8jfh9JjNcj/eFo/LkQoP/eNWrex+sks=;
        b=ehitBTr6GRUPTowaM2Ivm3i/eFm8TWFCmIirs8AoGj/MJyluVdn1Og0jUN5q6TZfME
         Vb1a+DYdERYePcZ5PCueiOIFWZFVtmQMCBLYy1sqOrAAzQLD1Rv6F/262m7aYEEf/1HX
         E7yulUWvcnl6ZXcJn3dSJgSLyaDgGwiIawJeOw33y8BzjNldwWGRPL50cm5Jm9GC0caU
         TLOl6OePCuTA32s52UggahfeFyOh1tQRqMpSGeWG41gdxk9db06tHZOMDw8cjXq4WY3P
         Q0jB1mBHvQcoG6RKTuiPw1qe1g8qAeHHltZ6dzMijtmaj5vEi3K3I20jSKJtsWO2dS4K
         kCeQ==
X-Gm-Message-State: AOJu0YyXMydxw6ChNV2OZ+RKiLC0saDS3jdqkn2eCaMFtVvp3HRP9MP4
	HfqHJYKHZhSb+8rh1ofV/L8n+zyMCAaj37CecQw8Qaem/rgrFsDDL9LTV0GJbw==
X-Gm-Gg: ASbGncu7nJplzTisLGTeb8PsUSdaSgjz3u9OKlGgu8MA7p/kETc7JHh9vIu0aTwcH9y
	AZoB3mbUvXJA6dJMQhIZacYa71XArc8TgLc6+/WYJKJ7aFMmstn7EWItlQ70H9rEZ6aKFbREGLV
	ezjXLkgTZsv1V6Yl4VG7DKabgRso07fdB/bveDOU8INst/vUJZqkroKBb2PT3ryqN0uMyY88XL/
	3rf9MjnftZBKJEmK6Rt606D/COfR39JhMz031TiopK8fGtI8/6/Fs0keNGlcbUB2pJCZQI8J5Ex
	wt6bWSW8kGdBOjFW9njNpvqyFsp83IqudK4Yy8pQQsvmVNemi+KHLwQ1G/Ib4/+q7KM/sgTRRjz
	BFBAGEqmHPgI=
X-Google-Smtp-Source: AGHT+IFiCXhT0hNmxKKU51wnkXZg8FKd3XK79ZyjU+JDhhKJJTMp3lPd4eKh5hkiQESeWW0oJp7M6Q==
X-Received: by 2002:a05:6512:2255:b0:553:51a2:440a with SMTP id 2adb3069b0e04-55366c38a41mr785527e87.23.1749213116454;
        Fri, 06 Jun 2025 05:31:56 -0700 (PDT)
Received: from kalkyl (h-98-128-167-109.NA.cust.bahnhof.se. [98.128.167.109])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553676d758asm170340e87.55.2025.06.06.05.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 05:31:55 -0700 (PDT)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH] diff-generate-patch.adoc: drop spurious backticks
Date: Fri,  6 Jun 2025 14:31:36 +0200
Message-ID: <20250606123138.566178-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.50.0.rc1.729.gfc6ec28a5d
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 0b080a70ab (doc: git-diff: apply format changes to
diff-generate-patch, 2024-11-18) wrapped the ".." in

  mode <mode>,<mode>..<mode>

in backticks. Note how the line before is quite similar,

  index <hash>,<hash>..<hash>

but did not get any backticks. Remove the backticks, since they confuse
Asciidoctor.

The exact failure mode changed with c87b2b3a6f (doc: fix asciidoctor
synopsis processing of triple-dots, 2025-04-12), and arguably to the
better. But Asciidoctor (2.0.18) still ends up confused by these
backticks and leaves the manpage rendering as

  index <hash>,<hash>..<hash>
  mode <mode>,<mode>`..__<mode>__
  {empty}`new file mode <mode>

Drop the backticks. This is a no-op with asciidoc (10.2.0).

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 The error mode changes between 2.49.0 and 2.50.0-rc0, causing this to
 stand out in "doc-diff". But this is strictly speaking not a regression
 fix for 2.50.

 Documentation/diff-generate-patch.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/diff-generate-patch.adoc b/Documentation/diff-generate-patch.adoc
index e5c813c96f..7b6cdd1980 100644
--- a/Documentation/diff-generate-patch.adoc
+++ b/Documentation/diff-generate-patch.adoc
@@ -138,7 +138,7 @@ or like this (when the `--cc` option is used):
 +
 [synopsis]
 index <hash>,<hash>..<hash>
-mode <mode>,<mode>`..`<mode>
+mode <mode>,<mode>..<mode>
 new file mode <mode>
 deleted file mode <mode>,<mode>
 +
-- 
2.50.0.rc1.729.gfc6ec28a5d

