Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F410319F130
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646656; cv=none; b=nEZuz8ZyRleE1ltepEMK8ml+w6LZfM6yky1jDDn71xzNspNwSUZ3URBW0fTFvsn6HU9tjL3HtD8NhWZp/abz7ll4SR6t2NCsTyjmLPjAfsm7OXJKzHYcKfkeH052m2wG+Q0V62PoUxJ0U1LObN7zJt8vppqAMkftepIeWGgAOY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646656; c=relaxed/simple;
	bh=cJki+j/PM6d0h/t6RqZdzvZ7IFfQm56URuQ75LPsIP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVdjsETb355lfLuMnsUvSn47nli/uLW1csOOqcEMNEekoMf5WB51ZLGhDMObjDF2pc7hYQDSwU0VKg3zh5JQxStOAOBUPWChrOUTZo74Fb06W7V/3bGsbZYVmvna94CkZukD/RoiVohQxAX4ClmahqwSs8ncG2+/D34aqE2yL9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYzjy64M; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYzjy64M"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-399737f4fa4so2615773f8f.0
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 09:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744646653; x=1745251453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bY2/TrYxCDoPnvu+GiF+SznZ3h0aSdSueR8XVgFz3KU=;
        b=gYzjy64MOfRzH/X6fRoDrOc6dtbvY/yxSvSGCIFecOdDQMV093RqDxoKfkITAHBOS9
         BSKMpF24jVT2OrRWAwOGhToIRPIbBtFALqksTkKgW0v3cnIJyWmIQA0IwNScpjDBsSB4
         h+uSV2o1N3NEAP2i2px1fk+hLh2VqWazCZ7CwVAr/+hkGMLXA5Gmn48b888iLq+abhKN
         wiKAAv15coKx12CCfWX3mNAzWAUzeVjay+IFsYXq6S/KCHdxWMoHTNcBv2+I8JxWxlvE
         GFXurqAM+r3AFezTUXavdFhRU2+yP2ItIBIux1lExu1p1JRx/pqgv/k5p2EgJD+h/uVf
         oRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744646653; x=1745251453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bY2/TrYxCDoPnvu+GiF+SznZ3h0aSdSueR8XVgFz3KU=;
        b=bYzyWjGPZrGmF4076PvjNz8x2XSPCvg0j0WS4GHu6C0TyuCgKC63fOwdbGQncrRRtd
         28W7RlI+D+i/t1jeEncsCeAjX0WA9xQcvP/VwGqS40r3NsqnntHDIsLfLo9FajOxpJRW
         k7gXmZAbnAMBzZEbymiX7fbMZm2Q518VO6K4Jjzw36SPuPCac9wwawbsqiscXL2hgDw0
         lxgYhDhncsjRo3o5zSMB/KnU2ZQ4OirVvCPdMRzsC5XTBBHKMKs91rUUWGeegQUbh/DU
         xJ8rQG1tpdtuEzvHLVbic/9V3jxHUMOVPT6ms64dCJm3WotFk4VnVKTnkEXrnQ+77HIG
         3ecQ==
X-Gm-Message-State: AOJu0YwpWskqlRBN63gEwA9xYzB/1U4lWAkaJaDR5SXzEUjo1z/R1DUD
	el+bQ3Z1jVzhKryMk/htHhbiey0mHGpahHeHpQ0r0HOht5yWkH3VmUWSlg==
X-Gm-Gg: ASbGncvBVEIgAbLcU77dgMpYjpemppjohYcfDKnkExqtQtqshG0eEcb+K/Gc6R09PxQ
	SVoXXGdgUOxAOFJRa5LLb6khfF9DDzYi9vP4fmIfbJvajoongCnf+HtPNBEyO635NhW1Jy3SBJS
	Ohj8eP6ka8Wo1AoSGA4TRm38nSEjLgAX9HtxShV7C54XCYlXbE/5Q9eUtYW1pFh1j/kSJzH1yUP
	SWzee9xnyi8G1zE+ThXMYEiPi/DIzAi8q0yx5ySKZmnIjsMTZ3KMrjo0Wpn8K+xUuexJx0Z4NMU
	VzAVjEh68cGMrsWhXF86wLNOOuAeSN+eOgoqUbpiP02Uwqut3NuVQKRWSaKfnrKz8j0MutqgaDc
	=
X-Google-Smtp-Source: AGHT+IEUBzSyv7IFjEpyl6ls/S4RJ7hIBzRR78cZiasQxU9CTSkH5Q4l78hIWn02XVQrqL6aw8Pdgg==
X-Received: by 2002:a05:6000:1788:b0:39c:12ce:6a0 with SMTP id ffacd0b85a97d-39ea520373amr10470188f8f.21.1744646650610;
        Mon, 14 Apr 2025 09:04:10 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:a9d4:af7b:bb5c:77e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae977513sm11258029f8f.42.2025.04.14.09.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:04:09 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/4] config: move is_config_key_char() to "config.h"
Date: Mon, 14 Apr 2025 18:03:40 +0200
Message-ID: <20250414160343.2216312-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.158.gd3b09c1afe
In-Reply-To: <20250414160343.2216312-1-christian.couder@gmail.com>
References: <20250414160343.2216312-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iskeychar() function in "config.c" checks if a character is valid
for the section or variable name part of a config key.

In a follow up commit we will want to check outside "config.c" if a
string can be a valid variable name of a config key, so will will want
to reuse that fonction.

Let's then move it from "config.c" to "config.h", and, while at it,
let's rename it to is_config_key_char().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 config.c | 11 +++--------
 config.h |  9 +++++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/config.c b/config.c
index e127afaa8f..f529cb4cbe 100644
--- a/config.c
+++ b/config.c
@@ -531,11 +531,6 @@ void git_config_push_env(const char *spec)
 	free(key);
 }
 
-static inline int iskeychar(int c)
-{
-	return isalnum(c) || c == '-';
-}
-
 /*
  * Auxiliary function to sanity-check and split the key into the section
  * identifier and variable name.
@@ -585,7 +580,7 @@ int git_config_parse_key(const char *key, char **store_key, size_t *baselen_)
 			dot = 1;
 		/* Leave the extended basename untouched.. */
 		if (!dot || i > baselen) {
-			if (!iskeychar(c) ||
+			if (!is_config_key_char(c) ||
 			    (i == baselen + 1 && !isalpha(c))) {
 				error(_("invalid key: %s"), key);
 				goto out_free_ret_1;
@@ -906,7 +901,7 @@ static int get_value(struct config_source *cs, struct key_value_info *kvi,
 		c = get_next_char(cs);
 		if (cs->eof)
 			break;
-		if (!iskeychar(c))
+		if (!is_config_key_char(c))
 			break;
 		strbuf_addch(name, tolower(c));
 	}
@@ -984,7 +979,7 @@ static int get_base_var(struct config_source *cs, struct strbuf *name)
 			return 0;
 		if (isspace(c))
 			return get_extended_base_var(cs, name, c);
-		if (!iskeychar(c) && c != '.')
+		if (!is_config_key_char(c) && c != '.')
 			return -1;
 		strbuf_addch(name, tolower(c));
 	}
diff --git a/config.h b/config.h
index 29a0277483..16df47f446 100644
--- a/config.h
+++ b/config.h
@@ -340,6 +340,15 @@ int repo_config_set_worktree_gently(struct repository *, const char *, const cha
  */
 void repo_config_set(struct repository *, const char *, const char *);
 
+/**
+ * Is this char a valid char for the section or variable name part of
+ * a config key?
+ */
+static inline int is_config_key_char(int c)
+{
+	return isalnum(c) || c == '-';
+}
+
 int git_config_parse_key(const char *, char **, size_t *);
 
 /*
-- 
2.49.0.158.g6ac6832dc3.dirty

