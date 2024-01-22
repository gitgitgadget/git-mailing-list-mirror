Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB3B3DB86
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705954483; cv=none; b=IhgOS01YbQhcc3Qw65Xf8zi1HB0V5By901srSmS7ft7co/g2ctMgsBzlYUGuZPVIKlSiJ/M61xuciMhNsm/NCEuH2Wmh6rwvp4VZy/1mSnfgX2izuJ+Jv5jP7KpV/EeQDAwkUybrtPDPQto4sTsyIbU94bIvTSqoYUiT3QmEGQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705954483; c=relaxed/simple;
	bh=zaiWNeDS1/Kpk2j7h+r4aonJE48JhYe8x69iy4dO9cs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bQDZPGIkpZEu1TgvNCFkDLrObsVe3Zf+C8XHW9zgbWy0piaQC6rnX5RS+eRQK+hkgZ9wnJX4BQuboaon01StKK7C3DpWgTk9PCo7nDqi51rNIij1j85oolGF+mJP3SEMaDp5sIwjpYcwwlFOeUTWFIckA37YTEvZsOEVP/JWWjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSs7LuEV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSs7LuEV"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d76671e5a4so4419345ad.0
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 12:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705954481; x=1706559281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NuzGMixCeprKUIwVmfM1xwF7KgqbXdIGnof8OhU1GLY=;
        b=iSs7LuEVty7p7sUGHiWuv9Hv3F2D63yf143YmsRTGsqeksVZjQe/lOlTaUIx3049+4
         5SYo0hLgS+KJB8FFM7oaWUq87gamL+a0v+QQ+lao9LqXH9ITdLb9/96WNB1Ao27Bcx1p
         7RJ9eWNWr4WETw3o2pnWvYCbQsMR4JGCyc7qEZvrQ6dIM6Pe9cTOozcan+OBy3WR51Qk
         byZ2DP6of4LI4J5A6CxdFAMrW+3hQFboZTDwOfKFy4tYx+waVxFRV691bt5HSFPvAyzm
         kR+X2GPAKRskf4ldDu+sg/g8KeNXKwDq8bSpA9d7Zaxt1WPbh0sWO2UDzEDjYUX4kI0o
         EDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705954481; x=1706559281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NuzGMixCeprKUIwVmfM1xwF7KgqbXdIGnof8OhU1GLY=;
        b=qtp21E/03jmCXNHIIhDic0LcfmTIRc61LWc6ra1hT5LTyB9y8nHt41nrYoUdy47UHp
         eoEVVJYTPrM7r0IiDvAwloiZyfyalqhEz2LCCq0EQOeut8jNpXQQASMt3N4Id3Z2Rljh
         nT8W+hh4x/n/KITQKyOM07BdbY1KFERI4eqC9RChtnXEVU6Lp+OF/edQi8rqNqd+/AS+
         sTYjBx/TKeqgSfMN1Kt8RuIPBpcSlmYNoDRKqXqbqjLhYKhpOGjXO+DmUpx6p656851A
         bn0svWoJLlSmVPMWiWMtL4i+ZXObIg9zBYYhida/pMJjeQlRJUq2eao7P+51tx0U3LaC
         90Og==
X-Gm-Message-State: AOJu0YyMAZZQyPb2TmJ8/tNPJ6fDsmRgm93BjVDJaMxhuCwuWLnnUWsN
	W+gYCYsY7QBv7OAc+tqbWQ3CFLA7ef2M0yqmwRHWRgWl7lJVIrSGiYL10sFc
X-Google-Smtp-Source: AGHT+IFJ0XY1AmBDQdESrNEbxtM/V0JSuFXXkelbILavFv9k5umSN17y8p1+8k+zH6bF51qturmRjA==
X-Received: by 2002:a17:902:cec3:b0:1d7:5d46:aef3 with SMTP id d3-20020a170902cec300b001d75d46aef3mr1740187plg.10.1705954480661;
        Mon, 22 Jan 2024 12:14:40 -0800 (PST)
Received: from localhost.localdomain ([2601:640:8e80:1270:78ff:d00:873:b982])
        by smtp.gmail.com with ESMTPSA id w19-20020a170903311300b001d7214a1044sm5671471plc.43.2024.01.22.12.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 12:14:40 -0800 (PST)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [RFC PATCH] editorconfig: limit code lines to 80 characters
Date: Mon, 22 Jan 2024 12:14:20 -0800
Message-Id: <20240122201420.72802-1-carenas@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 6f9beef335 (editorconfig: provide editor settings for Git developers,
2018-10-08) a multi editor/IDE configuration file has been provided to help
developers follow Documentation/CodingGuidelines.

The settings are also supposed to mirror what is found in .clang-format, but
the "ColumnLimit: 80" setting wasn't included, so correct that.
---
 .editorconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.editorconfig b/.editorconfig
index f9d819623d..c6d7815c80 100644
--- a/.editorconfig
+++ b/.editorconfig
@@ -7,6 +7,7 @@ insert_final_newline = true
 [*.{c,h,sh,perl,pl,pm,txt}]
 indent_style = tab
 tab_width = 8
+max_line_length = 80
 
 [*.py]
 indent_style = space
-- 
2.39.3 (Apple Git-145)

