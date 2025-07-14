Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418FA42065
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499648; cv=none; b=taoGLUAzdNFgIOwwiPp3HXlU80w+7C4t1sWPnrU6Mtp+aCBpbjWJwqGXosiGzCN3zq2rT5HG3KZqppIdWolnICGtiEkfKnEhMEC6W3txv5EK5vIgQliHryYEdmUQq5NoK0gz6QJ1J+jkSgJpwOJ+P2oA4XVRjOQ0lm+urskUe/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499648; c=relaxed/simple;
	bh=a6KaXBTremdGWUtYAAD8ddJc7lr+xBd71GezDTs+zCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUrxnK1oZvCVLyKs00wW2/Kpw4n5YBEdY6rCxNtGHjR6KOFizVzb2iWEiriJ/37JynlV/Ho9n4oN5TLf6R8qi6l1aL3wzt6DmpcTmQaGcyHHOPaQ0PDAztbYS5f5gBDWcHDq+cQWSNPUNFWFjXBmV32iIYMjUsWgjDN2lUcokXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2+FuSGW; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2+FuSGW"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a6e2d85705so2499578f8f.0
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 06:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752499645; x=1753104445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RID4KGBlDrKiiaezDhkDFV6vZnEma+TKoXvlSeyv0EY=;
        b=P2+FuSGWtNES2a6g5e6MOZcr1Pi3W2bdXMUDRINrRIS6GEVJQ3aMytRIjkUMC6qyRZ
         JKSFn8/gsxEuAOQOHHqErOXfovgoOzNOjROH+3zq6KBhBdZx2r87o4t/KSpPN7JOSeEo
         D6K9DwAiSR3hPEUn6GWqnkvxneTDaYVNUWJ5NyOyVXO9q5m2GroeeSKQFJm/IEmz508n
         SXgQI9w8vi4Y4uo0bXCSUBexWN/JYaYNvI716hbbu5A820LYkJ+ribGy4fQ60/j/rOa5
         b4/zUI1+e6QbmQEbFwqpSJynblixviZC3ZGLG+54YMd1j8Ru9d0Y197WdhvwNDTkUR36
         M3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752499645; x=1753104445;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RID4KGBlDrKiiaezDhkDFV6vZnEma+TKoXvlSeyv0EY=;
        b=qUFBCaCXONoFyW34rXyX+mH0Ose/ta0hmTANtdsHahfr/v7yboB8S7TnL86ybhaaJl
         qnDrEfF1RCr6dO+nFGzInmnNHG2CHl6PWQvIbpERLn2omkvaKACP+iYXbPOPMzwa1mTC
         UWPL2x4Fk61I7WCoBYiY41DK8gS5ZxpHK3O7U0wfy+JdijZCac0NYlPu/M9I4x9CaJDf
         +ul1FSY5Fdy7y0uJsL+KFSaLvKpVXbzIDXHtjsT8dRlNJaLCpWcaJRNoox9D1uSrWWt8
         /go9zmRa1eRTp9KQHqB8R7lkf7c0NZcHFOjaJO+NLhjcQiIVK8GIgeABIydwIsFyQLdl
         bdCA==
X-Gm-Message-State: AOJu0Yxx/oj1JoHkyi8zSZOrX6e8yID86fo76jJPfFm8NANyL7o0DV++
	+0gIbNL6ap27UWKR9Ci+qocMiBTsHPMqC+w4jDgv05pk3WGKtBQ+HOQle3lKuQ==
X-Gm-Gg: ASbGncsdly/JQ1L9FKnbH5Yk11GZwbBS4EsZkDBYDrjZfMOkqI9jeRkl22Sy0pbjd2m
	J0HN8As78bDPsWAKiDM/gn949sxBqxxtj4taNCNHTswa5MNCqIntHx2pejMeahlWIs6VqNR3NoE
	ssiJOSrEXLAO1/uSb4z07pRAQTpWeBM6Thjz6eASJyuvHndP5o4IG8L+RMliVXCB1x0Me+MT4MC
	RG8brSBBCsrR+Fd7gYvDH8mCS/p1elrqT1Q7xZvzyGUmtaLg0pe90pddgZ6SSXivjTMmmGE2FCE
	obfqkAUj40afEmWCJX7MP7J91I5Nc8QosH2YLOzpYzkk8SAJXepdK0GRYfODUnp03BK+rfxea8U
	9isYgwZ7Bd1Vsf6ENOV+LSTNN3v1hrrGz5WZ2TD9vNUHw
X-Google-Smtp-Source: AGHT+IGZYIILz4PxonowwZsnUsH4S5cZPYCHpRWkdDodGo7x63BUyX91pxe5O2XPHPmd4SyFwDmyeg==
X-Received: by 2002:a05:6000:290b:b0:3b3:9c75:acc6 with SMTP id ffacd0b85a97d-3b5f359d08dmr9550947f8f.59.1752499645366;
        Mon, 14 Jul 2025 06:27:25 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d867sm12616750f8f.61.2025.07.14.06.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:27:24 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/3] CodingGuildlines: allow the use of bool
Date: Mon, 14 Jul 2025 14:27:00 +0100
Message-ID: <352f80c49b74053d611e7d64991fed1c16d857a4.1752499610.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

We have had a test balloon for C99's bool type since 8277dbe987
(git-compat-util: convert skip_{prefix,suffix}{,_mem} to bool,
2023-12-16). As we've had it over 18 months without any complaints
let's declare it a success.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/CodingGuidelines | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 6350949f2ef..528b42d1dd1 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -298,6 +298,9 @@ For C programs:
    . since late 2021 with 44ba10d6, we have had variables declared in
      the for loop "for (int i = 0; i < 10; i++)".
 
+   . since late 2023 with 8277dbe987 we have been using the bool type
+     from <stdbool.h>.
+
    New C99 features that we cannot use yet:
 
    . %z and %zu as a printf() argument for a size_t (the %z being for
-- 
2.49.0.897.gfad3eb7d210

