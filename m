Received: from mail-vs1-f67.google.com (mail-vs1-f67.google.com [209.85.217.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BEB3EBF02
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771449622; cv=none; b=u+r+RVI3y0LGzkI7d+iz/bBB2UX3NNRzXoPJFjOWtjqFPtcmqLefaXr0r6zxBfGQ9/NS+WWSVxAh6IUUL+0PSGxSTdVFs7C/warAmS85AQtCyZ2YM5si/UGctnNEANsJ5JZtS4aOP1gjt9r3eQqv0v2p7GOVk/o5hSXxLewtL28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771449622; c=relaxed/simple;
	bh=Zbixd4cWOi79zJj5Z5gKHOK5kM4B8QWTsH/fNyVd5Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExA3lb0w1bal6QwfrbPTRBl+9/Pn4EqUAmw4QbY8iq2pp4qYks4Pp85KEFKbWmdvuleozsyWmq8PoXsyg/X/nDoMy3k10M7NgL7p0UMAzyBM1NgSvYjuftWxn+blJAXTGDvS8iTIwfRRtvyMXIBsAOGFZ0I9SRw/AnYIQREmPEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buV9jza9; arc=none smtp.client-ip=209.85.217.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buV9jza9"
Received: by mail-vs1-f67.google.com with SMTP id ada2fe7eead31-5fdf71f3327so885198137.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 13:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771449620; x=1772054420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnUeiFhoTHduwHjgu2hhVKAc5fEPnG0IVlbrM1G5vDo=;
        b=buV9jza9pB7oAMCXMv95LJOIc1FLSJ/inqmj1jr2/SK3lc9vlmsbZQTSbxTuexQGDd
         OEIkQ1xsI4V+VS9bgS1/PG9inTCK7sF9iFciQwcWnAYdzlFpcuyPSQNId0k/cCzjlGX6
         9I9F066L1zxUYp+aHKOMcG6t+6lNRtajbW9UmaBgqqd55qpe3Ba4s+nnfrVKpnihdBE8
         geL+M9y0+wc+QhZA1IoLDQ8mkM5Az3XpVb8QCEE2PwgMIcURDlCxN4y38CYZ2qX7g1xp
         WeCDrTIUbSWUkGqbx1ptrl6utFwGGWSF6+2l+BcVKwVMjP3/mdGQM6zAqwb3dCfiY2pK
         gung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771449620; x=1772054420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YnUeiFhoTHduwHjgu2hhVKAc5fEPnG0IVlbrM1G5vDo=;
        b=jeeV87y0nxmuOnyNLgwMjsXslhzDEc+vjFSBJX2HOF6vDtt4xMEFOuovtEsv+bTYfv
         gOTM9e9RvjZNfzb0wlb4164HCZ/6stLgNVWwQbpftJh4fsmH+MdW62j8E28GpXnjWaWT
         Q3qqTJRdqGaWgta1FM28A+lGO2Kj8kvWYPK11UCuKhmd+jovXowOMfuAGq9ghu8n5hSn
         Z2NrT9soFlB6TtdDYPOXyapQZO2mUY73tEZO0SFIEWvZNeK/q0bDID8z1FGcAk8r9eZm
         1TTazkGMTDNY/SK+64KRZvZ3/01OmdNpdQKjTyGHVk1Fmu59ui5LsdRhGKKevUoygPDa
         RJrg==
X-Gm-Message-State: AOJu0YzANy6zvVTWbkxwhd2pxXhUGre6bk/AaHFSN5LT4XJW6//c1sLE
	zsIQ56M9aRzryf5rQLD/19I7f/quwGK2d2E36bulaacmkdtjsmkeN/ct43W7OYFh
X-Gm-Gg: AZuq6aJSSo5PAC5JlSjQ8kuTf1WPCP/0NsYCIeZjJAg7NJoM7y1nFuBoMthSp/MlOHY
	yVscPtX6n7mQ4x1vMYIXpalQQml2NkibD3PySnxYA/4X8dm+rfOZ5CQ8vRVWzFiRBDqbeE/5wz3
	pn4fdDry6La/OeJMs5zXe/YTpWa8Tgolzt8oxpTNYDw2s/lsmRa5eKcYAF0nWE0OD8A88rXiTzt
	c0A2/KoK0TCwDcahUzunvewbRk8efztX/5kkgZ3sPS3opXdrDSCI7HCF+U2I7sY3l7/9182hURe
	QWZzwZfsdaAzKgSIaStqnsZccYnI/ucUi3TFTobPqXwEow8E9aQft9ZCpQzUNxv8Irrnmx++OkX
	5WB3+jLdVhJpx/PJZqvhHQYTaFX6S4n+/Pujil7Zed0vDypIU6YGjjrLJU99updTbenleTJbl8T
	sSyKKjzuOo+uIXkmUw6fvVM6fBOTTPdzi5LvduIG3MXZ/FUsMAfD4prLXLd+NsgRgZPw==
X-Received: by 2002:a05:6102:1621:b0:5f1:b59d:a824 with SMTP id ada2fe7eead31-5fe7f2f9133mr1701254137.10.1771449619960;
        Wed, 18 Feb 2026 13:20:19 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:c4:89c7:a068:d017:8d32:248])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afcdc345asm12326301241.0.2026.02.18.13.20.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Feb 2026 13:20:19 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH 8/8] Documentation/git-repo: capitalize format descriptions
Date: Wed, 18 Feb 2026 18:08:44 -0300
Message-ID: <20260218211845.96009-9-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The descriptions for the git-repo output formats are in lowercase.
Capitalize these descriptions, making them consistent with the rest of
the documentation.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index f76f579b20..5e2968b707 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -33,13 +33,13 @@ supported:
 +
 
 `lines`:::
-	output key-value pairs one per line using the `=` character as
+	Output key-value pairs one per line using the `=` character as
 	the delimiter between the key and the value. Values containing "unusual"
 	characters are quoted as explained for the configuration variable
 	`core.quotePath` (see linkgit:git-config[1]). This is the default.
 
 `nul`:::
-	similar to `lines`, but using a newline character as the delimiter
+	Similar to `lines`, but using a newline character as the delimiter
 	between the key and the value and using a _NUL_ character after each value.
 	This format is better suited for being parsed by another applications than
 	`lines`. Unlike in the `lines` format, the values are never quoted.
-- 
2.50.1 (Apple Git-155)

