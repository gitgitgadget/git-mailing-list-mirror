Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5F718DB35
	for <git@vger.kernel.org>; Fri, 16 May 2025 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402920; cv=none; b=T3Y4B1Hp/Hre7Er4X4oA9Vr3mu1+jtXzzdG6R8guHFg3ylXsy881W353tvK8ZYwz88ZUhd7gRLeTPA/jBS7q64g+dKRXHxbaCQpRqqbjIDE4jT8NZj1nRzjtwXAuqKq88DykmirSZlg2tKC0MxR/F6c5B5inRhFT7xVGZdnFfww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402920; c=relaxed/simple;
	bh=Gb7b4E3ee415fpSc8t5CeGPvWY7t7Y6umGtmiQ8CkSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hoTRsiZTgGRXqKQ2q8DiGRkmElzrKipV6Fvsepst5k77k4km2r3MaW9Vtn7yUOuVdh4J9eZ9BlyUtT/p9fK7iNdYeTL18QA2cgwGWhSfLPH2/gBves+ppRKWIDNBj4XE7jBtkZaqhEQU+80Lgpke5ctq9GNkNSxy7kXHvSNXeSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5Q+iLvU; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5Q+iLvU"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a0ba0b6b76so1879839f8f.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 06:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747402917; x=1748007717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dUwC2J49Q/rUU3H0W5olyEJnNG4g2d7iyPr5FCte6g=;
        b=c5Q+iLvU06A7pNV7tCr9naEQrW/g4cg+BLOqOKKTlOmJd9U6zXbC2F09uTwf0bQlO/
         kdCA9wQ3desdXwycx/L39p1pF8IgqQfTTV9Xorx/f/vUezPojZqB1bj5EP+YYMDFYfBA
         rDm+cBcyWDkYIzEnJBaHveyLwvPuY7ORDhNdW1Eu0hkFobV3L9lnEPLEHmCAroQQaS7y
         lRSDG3yW5kcdVUCyC2HSmz+1cFGFFBnnTYVVq5UI0L6xpyZmZU6w77gpX2QBV596BE9c
         suMp5cxPO3qQ451uCAX/0nbTWZp74n5MGCwuth5nyk+jFdatValXDZWoYBeM4HqKiF5M
         Ez+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747402917; x=1748007717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dUwC2J49Q/rUU3H0W5olyEJnNG4g2d7iyPr5FCte6g=;
        b=QgliZPivC5YfdKyf5imoDa/sBDwkUn8SihKZeuArduwliTJtvGfwTGu38NI1P8BBbH
         KTh/G+O25bmQUdKIrl0T6+GYQd+YKqyhVgbqONu+jHV9VCibwPlwffrXlfVwSzQgDvDZ
         vrDSFTC9y5kiShih9d3MD1U7DzTfOk1rgNscmWeE/+A6Mb9/vLwc5P3gM2JxsfBIcAdG
         r21FH5bGMZ0gfckXC4O87PzAaXJIs3469KM2hrTvtQO8xVMC1YrgNGc9nmqxY72OVKm8
         fEJKLPDuGblni3WbnFcROregL3490/5h+Jo3WyNl6ZLAn0yOLZwiYOUjT36ourCsKk5+
         TZpA==
X-Gm-Message-State: AOJu0YzrjaxIxKJTUUxK1QhRSUjXsCFwUAAUDBQIvF5nls68mr5RdHf8
	MMATObTfMzktcud8E0meZJuxUF3m3S67REgTbXnrdH2StFHMGVyR/2j0
X-Gm-Gg: ASbGnct4/LMW7gb+dXpXBFrHaCJoV7l4RlrIMSPz8+lqMzf/sUEtXcDBobbNDaIUJEb
	ul9c79E8M+sBUcgne9aAPEJZ/fynJvSlcdFBw9TYR7VldRtRzdesW3h2re9cRZsvzqol3bQ/de9
	jNf5kVnBrEuWv3r/3EHgR0HyYBMjKUqKehXwnv5kCZFpqwfbxWRGDypvmascdbKkwq+rg7DktUN
	TgxdEI2/xLqzD/8Dz0xJfmf3oPLVmnH4B++3L8bZgi/IGfWT+J/lIyJyrsYvOGvG9eCPw9EPKDP
	zjNriF+USDMVkFpx8IB0XN7TdeE8MbWCkfT9phTSOoW0aitKXxcjGbtG2V9PlLWrqsQ=
X-Google-Smtp-Source: AGHT+IH0VbKM6jYrFl7NXecOP3H9f4eMrGJscbg6eFzl6cqbCaeU+DZPG8Soup2u0xLTQJ8DJDgwxg==
X-Received: by 2002:a05:6000:1862:b0:3a1:f69f:3341 with SMTP id ffacd0b85a97d-3a35fe929c0mr2172154f8f.26.1747402915849;
        Fri, 16 May 2025 06:41:55 -0700 (PDT)
Received: from berwick.broadband ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca62b5dsm2932643f8f.55.2025.05.16.06.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 06:41:54 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: phillip.wood123@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	johannes.schindelin@gmx.de,
	peff@peff.net
Subject: Re: [PATCH 10/11] bundle-uri: avoid using undefined output of `sscanf()`
Date: Fri, 16 May 2025 14:40:54 +0100
Message-ID: <20250516134054.217202-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <694d8e62-486b-43d4-966c-4fa1e5a95061@crinan.ddns.net>
References: <694d8e62-486b-43d4-966c-4fa1e5a95061@crinan.ddns.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 16/05/2025 11:11, Phillip Wood wrote:

> I had a similar thought, though to make sure that we parsed 64 bit 
> values correctly on windows so we'd need something based on strtoumax() 
> I think.

Perhaps something like the diff below which adds strtoul_u64() in a
similar vein to strtoul_ui(). I think it's debatable whether we really
want to skip leading whitespace so we could perhaps tighten things up
by replacing "if (strchr(s, '-'))" with "if (!isdigit(*s))" though
that would mean this function would behave slightly differently to
strtoul_ui().

Best Wishes

Phillip

---- >8 ----
diff --git a/bundle-uri.c b/bundle-uri.c
index 96d2ba726d9..9dff7a1c09d 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -214,7 +214,7 @@ static int bundle_list_update(const char *key, const char *value,
 	}
 
 	if (!strcmp(subkey, "creationtoken")) {
-		if (sscanf(value, "%"PRIu64, &bundle->creationToken) != 1)
+		if (strtoul_u64(value, 10, &bundle->creationToken))
 			warning(_("could not parse bundle list key %s with value '%s'"),
 				"creationToken", value);
 		return 0;
@@ -533,7 +533,7 @@ static int fetch_bundles_by_token(struct repository *r,
 	if (!repo_config_get_value(r,
 				   "fetch.bundlecreationtoken",
 				   &creationTokenStr) &&
-	    sscanf(creationTokenStr, "%"PRIu64, &maxCreationToken) == 1 &&
+	    strtoul_u64(creationTokenStr,10, &maxCreationToken) &&
 	    bundles.items[0]->creationToken <= maxCreationToken) {
 		free(bundles.items);
 		return 0;
diff --git a/git-compat-util.h b/git-compat-util.h
index 36b9577c8d4..d34d07fce1e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -939,6 +939,22 @@ static inline int strtol_i(char const *s, int base, int *result)
 	return 0;
 }
 
+static inline int strtoul_u64(char const *s, int base, uint64_t *result)
+{
+	uintmax_t ul;
+	char *p;
+
+	errno = 0;
+	/* negative values would be accepted by strtoumax */
+	if (strchr(s, '-'))
+		return -1;
+	ul = strtoumax(s, &p, base);
+	if (errno || *p || p == s || (uint64_t) ul != ul)
+		return -1;
+	*result = ul;
+	return 0;
+}
+
 #ifndef REG_STARTEND
 #error "Git requires REG_STARTEND support. Compile with NO_REGEX=NeedsStartEnd"
 #endif
-- 
2.49.0.897.gfad3eb7d210

