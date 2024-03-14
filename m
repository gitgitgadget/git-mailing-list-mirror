Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7175374297
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435916; cv=none; b=KUxC9kWzIM/gxcAvWEvFz9rpCfB3EKUswU8lSxs549/z9bwSmG1LtVImAv/Xv7o6ImmTex5z9KdfEhpj7j+EhqUI7TVj7n8boErecszHp9HhMhb7eh5dvMSNxozugIzw97NuKfunasHRHGV06D0UVZv+/sqFV7M5j0SiZzVkvO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435916; c=relaxed/simple;
	bh=f9NFde8Z1qTfaw5g+6TGmaUa2s6M4fDPLNPS4i0MrIw=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rbqRcz561m6U77PYqc60BoIMXF/90aKgGKVAEuD30UZhGH5UrPxEbJ140G38T5FyS4GLMi5XoQAJ0Cc04phZFkoNMfeh69guALijBLTaM8sasc+Bjpj1hiyiBWpCk4Mt9N77nhkZGMn3EKhyf+xfuDRh9jruJZ0qt2QAtDizh88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoNguy9e; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoNguy9e"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5139d80f8b6so1497928e87.1
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 10:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710435911; x=1711040711; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSwmr7ovvPdu+kupFLDP7pjC6YKlm+EgaOWuBbjSh34=;
        b=WoNguy9enieiEAMTy0O1JeB1heN5BXJZru6NXoJzhL1oLugDRbttPsCktJbLVw7cKk
         GAp9p4VbLTJB3UgBslVSPo2b3O6tOw88tnawhCBuD+UXf/QvvPIe2RmEF/Mu10Fl+iog
         0vCjumWV6ZrVSSMyUnL1tgFETy/xN/8CBFE1bzos7O+3kworgemr3nZ8oPuFa+etxWGb
         5xu53GImIjaLuArzZhvVJrMcbsYeNB69117CSqlBz8nije74tspQGDcuLEDMNZIwss4Z
         SHfwlCUxZtkb9pNrbR8vfnRzsl3pjHeBVemZzl8VGhCc+YU3gDt7Lbzw03hFkT5No9XQ
         87xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710435911; x=1711040711;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSwmr7ovvPdu+kupFLDP7pjC6YKlm+EgaOWuBbjSh34=;
        b=OKybHSa6/gGDm2cxqOeDxLib42WQIN+8ze14w0uTXsN1zIVOSrrDBVz3CCFvcwF+Qm
         xhB8c/I2eneAoWw55lIkQMQlLkJpIUiOL62vkPx04l9jiUW9bLcheOyVn/vOqfL41SmG
         jmrKO2bLoo1gl0DB1uXvZgrK+k454craAmg6427qAw0pgE822Ts81iYYmMZFdCkbmR9K
         2WyEf81TB1bPVSzJPLflK6h37lyphXfpikB+7JWMp8XTRnxffl4GQ0+TakRL/NnMC6al
         Uf6TE+wvsxYV+AUWeck1/0kKehXPfX2xC5M8WLUFzhIFp0G6nJtteGAypzgOp8LUt4DX
         msbQ==
X-Gm-Message-State: AOJu0YzA6mKrE3/klyZu4cTAiBSeep1QmPM11iqgqzsPj/bS7i5Vl7vB
	Go0X+W5dX1Eu5HONC7kIjmnRDsOzkszGJ3tVspSkWLa0gbjnzupm4CkFfRbs
X-Google-Smtp-Source: AGHT+IEthkjLU93ZRzDssZu3hv+DmZbTcDYPFrqjdA2mNSN+YA46Bor8eofumMjoaksQTMH4ybA9Ew==
X-Received: by 2002:a05:6512:3112:b0:513:c80a:3008 with SMTP id n18-20020a056512311200b00513c80a3008mr488057lfb.5.1710435910451;
        Thu, 14 Mar 2024 10:05:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b00412706c3ddasm6153282wmo.18.2024.03.14.10.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 10:05:09 -0700 (PDT)
Message-ID: <629e577879c550aafffeb0f75a64c9a2a95df512.1710435907.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1684.v2.git.1710435907.gitgitgadget@gmail.com>
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
	<pull.1684.v2.git.1710435907.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 Mar 2024 17:05:03 +0000
Subject: [PATCH v2 1/5] xdiff-interface: refactor parsing of
 merge.conflictstyle
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
Cc: Elijah Newren <newren@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Factor out the code that parses of conflict style name so it can be
reused in a later commit that wants to parse the name given on the
command line.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff-interface.c | 29 ++++++++++++++++++-----------
 xdiff-interface.h |  1 +
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 3162f517434..16ed8ac4928 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -305,6 +305,22 @@ int xdiff_compare_lines(const char *l1, long s1,
 	return xdl_recmatch(l1, s1, l2, s2, flags);
 }
 
+int parse_conflict_style_name(const char *value)
+{
+	if (!strcmp(value, "diff3"))
+		return XDL_MERGE_DIFF3;
+	else if (!strcmp(value, "zdiff3"))
+		return XDL_MERGE_ZEALOUS_DIFF3;
+	else if (!strcmp(value, "merge"))
+		return 0;
+	/*
+	 * Please update _git_checkout() in git-completion.bash when
+	 * you add new merge config
+	 */
+	else
+		return -1;
+}
+
 int git_xmerge_style = -1;
 
 int git_xmerge_config(const char *var, const char *value,
@@ -313,17 +329,8 @@ int git_xmerge_config(const char *var, const char *value,
 	if (!strcmp(var, "merge.conflictstyle")) {
 		if (!value)
 			return config_error_nonbool(var);
-		if (!strcmp(value, "diff3"))
-			git_xmerge_style = XDL_MERGE_DIFF3;
-		else if (!strcmp(value, "zdiff3"))
-			git_xmerge_style = XDL_MERGE_ZEALOUS_DIFF3;
-		else if (!strcmp(value, "merge"))
-			git_xmerge_style = 0;
-		/*
-		 * Please update _git_checkout() in
-		 * git-completion.bash when you add new merge config
-		 */
-		else
+		git_xmerge_style = parse_conflict_style_name(value);
+		if (git_xmerge_style == -1)
 			return error(_("unknown style '%s' given for '%s'"),
 				     value, var);
 		return 0;
diff --git a/xdiff-interface.h b/xdiff-interface.h
index e6f80df0462..38537169b72 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -51,6 +51,7 @@ int buffer_is_binary(const char *ptr, unsigned long size);
 void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
 void xdiff_clear_find_func(xdemitconf_t *xecfg);
 struct config_context;
+int parse_conflict_style_name(const char *value);
 int git_xmerge_config(const char *var, const char *value,
 		      const struct config_context *ctx, void *cb);
 extern int git_xmerge_style;
-- 
gitgitgadget

