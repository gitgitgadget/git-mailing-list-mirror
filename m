Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D4BB676
	for <git@vger.kernel.org>; Sun, 28 Apr 2024 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714343471; cv=none; b=q5sXM1yptl7j+csLuUA0Qb5DWI1MsHlj5Wcvej4mk6I7SCa4x3RnKgE8tLkp3uHHONFkEB/kq/EGyCYQmcinXcuyTLMukmnyE/JMoBNNT3brH/8/h6wL4B2Umio8FXoNSHLxbNynNLjYiia1k99TS+ytaOdbYE+0SBuGg7MKPkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714343471; c=relaxed/simple;
	bh=VHI805M6NWFA8IDzt3PG+C/jJX8I7ahLOwXoCNyHpdE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UOPJIYbd3i3qYQ0ckkAUdVX4ZUMkmmsJOVWz2uXLp2k8T7o/o7Zllk93EmobcGJ0Eq1kvhoefyMX4U+46fCOqxUm8bd7mmr4PCeuvVR/aAc4YXcL7ly+Cnbun/woLvdVUbZdoM8gKS9VdZbHL3bs4g1c4NFXxCb/PJc1yWF5UYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2j23+dX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2j23+dX"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34cd9f50ffaso586283f8f.3
        for <git@vger.kernel.org>; Sun, 28 Apr 2024 15:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714343467; x=1714948267; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5tSEDb6eAbJWENaTudCJguvaLlO/g7f92082XapFMI=;
        b=l2j23+dXIFW6f5G9KK+8WVRluEjHlK6+tRVk6ousytY9er8fmYMRiI4qxMq7pY0Ahr
         LJcfElQPAR/XtuSQI1SbdZZfupKXpUp+LvcZdYGgdArpQ0StzOlehTp5zh8YMa+eUn2P
         BI/gEWVbcX5jg+JryBb2hb3HD5uJmmrEsFJALs4Fwyaq9UA0HTY/08UsHTm6w//tD0on
         LFslmxjdJvukABkX2THKqAeZlCD4THIxCLY17MPIcoEjdOqdC0wqq8WsWAoSbQCp9rvZ
         IQCV388MAzhKBT8lpCY2ArEhCKytGs1jow1HkRKSvEUS+Js+5ylIiGPclTbtZo4Nw9FI
         8X2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714343467; x=1714948267;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5tSEDb6eAbJWENaTudCJguvaLlO/g7f92082XapFMI=;
        b=ceiIIxkAaTkp7lDhMXcI3E3f+NgB4YezKBfQx2q28n+9cOAwS3ipI8L0a2bBzkV2IS
         riuDks+tBVqsvxhK6+AsOHm+PuWIYdfa0oac1dKe2InhIF9mjZ897N3qNSX1MBTe90fU
         tGka6HGPhikiNqpWWotze/OHgDRNhf+vQZOonfeowyo7GZkFAn0rRSgEoA5PwOrDoy4t
         5g9saQTieZ8xzISfon9ZDEol67Ne9FeCe2FDaInATo+OJWs6tUsbjVWd0eYNFSsBRV/B
         R+UwRYOZjYNK7qgQga3nLSf7vfGGFlH1J427Nrzw95tcPAw6qzFtoiWh7STR1fjuJVC2
         U42Q==
X-Gm-Message-State: AOJu0YznWs9sJYyNakeUuzyVFjQBbBsINgDJnAK1mEYFl5UnU5t9Kf19
	noZA81IiWxk1Xc1kMMGgF+KfF5J7I9mvxPCQQ/0rNTfpeA2JXgIFoz16iQ==
X-Google-Smtp-Source: AGHT+IE7TMz0sAGL1pq5EY+TIiC8Y7LRLIwtZnn7nDRhcybJ06NA17JysFGaUWHm4PL9v0VxEm5Bkw==
X-Received: by 2002:a5d:64c3:0:b0:34c:ca8d:ab94 with SMTP id f3-20020a5d64c3000000b0034cca8dab94mr2359577wri.23.1714343467616;
        Sun, 28 Apr 2024 15:31:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d1-20020adfef81000000b0034a7a95c8cfsm24210608wro.9.2024.04.28.15.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 15:31:06 -0700 (PDT)
Message-Id: <0bf83ee1228130df6069206190b97f1d0329794e.1714343461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Apr 2024 22:30:53 +0000
Subject: [PATCH 05/13] url-parse: enumerate possible URL components
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

Create an enumeration containing all possible git URL components
which may be selected by the user. The URL_NONE component is used
when the user did not request the parsing of any component.
In this case, the command will return successfully if the URL parses.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 builtin/url-parse.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin/url-parse.c b/builtin/url-parse.c
index 933e63aaa0a..d250338422e 100644
--- a/builtin/url-parse.c
+++ b/builtin/url-parse.c
@@ -13,6 +13,16 @@
 #include "gettext.h"
 #include "urlmatch.h"
 
+enum url_component {
+	URL_NONE = 0,
+	URL_PROTOCOL,
+	URL_USER,
+	URL_PASSWORD,
+	URL_HOST,
+	URL_PORT,
+	URL_PATH,
+};
+
 static void parse_or_die(const char *url, struct url_info *info)
 {
 	if (url_parse(url, info)) {
-- 
gitgitgadget

