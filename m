Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9132753E8
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508100; cv=none; b=dBYnbo0lnCzMA7GaW4HvTiDBLyd5R629T63I3XRpiKJVIj3tMB97BF+Vtk5vFFcvY9Q7Qwiwhn9U1PocFGbUFBDZkSR2RtjTyEBPKNC+VccxHFdWaH52yro3aUiZfA5NsRqnRcH3EdFW0hFLIa7iultOGry/YBS9CZn+y244e6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508100; c=relaxed/simple;
	bh=V8mGPS/ZBsxelMKIjDLXofsUz30r9/luGQSztZPGSDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZLpsOuoQRwyCbBp92ywQzng0qmbrwvyE+ftbb2PfSxjoFO5q/iTejEd0Mt9L0sRdroQyKnJigMWDQol4MUej4lr3rFXNu2KtCWN84q7tEtse2frCHFYKwic3ceyGBHz6tU01+C/ZuwHuvPgsAon9Je5C6GFChBBlnMph098fqAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnBRGQov; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnBRGQov"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fc042c9290so2667888a91.0
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 20:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739508098; x=1740112898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mnhd8o+8SelZVUEMQ6vs3sA29vLnDZQBpYCXt8nNARI=;
        b=BnBRGQovB6Nt0GtTQ47YCC0ewodrZIUXfMmHojBJ3YkDxP96Puca9XxJi3Hc1USXA/
         oOIhrj60FlQIBAFye/vce2t01s8a2RfT9xPPYfO14QyVfdmlduoxI4PF28vo3aMXk5Gw
         e/Ib9NV5hqaKGiHnDIEusRg4KDaHetFqGsSgrb3f2uwKt1G1sj1y9HHiGziIIN/lYVKH
         tT5i69Q1O0w/TbxvryGNo0xR2w45TXsdU14cUzPgC+Gi2CDtnMdsCg1JuOrOfBf4LVJU
         D2SMX73kjltDEy5mnsDefqBBU/IQqSKPs3ExDI8GICU7DvhxyLETjBM8M96qS3+O6Eyl
         xMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508098; x=1740112898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mnhd8o+8SelZVUEMQ6vs3sA29vLnDZQBpYCXt8nNARI=;
        b=dwTKw353sXWtJhS7oxSflTIABa4qjV7hQ8W7vZMgsWBanmyRwukkWFuZiFjT3MwKqZ
         Ke4cLYIHg6lWeOom/9z2035rWprRDXxp0DtQymrW2tk1goEVaxW5Pm2v2aJrs4USNC7E
         YxosN34kxW+I3427nUCYwkTb2QwJFewi+CLLfAdSz+iRfBMWhvn9tDZ6RcozZOKyzVD0
         XmVXD3WXFRNtCjz0ghigHxhU7+eejGtaI6mIPJpYqYDEntkW3xOSnRUzeFIGuoxipb4W
         lMOSWJkAam60HH02Onml9j3sKdEa62PxJVxS7ArKhYbZjIpFHnk9ESAsXuPFFPZNX/h+
         rGNw==
X-Gm-Message-State: AOJu0YzdlQdC/BYjtl3ZU00dsIeBIDqrUFn3dkrMhCZ2rpwDVj8KPGs1
	xzXNXNQl5ISeyDcl4Omdhj1pf2WEDS1dKRtVhc0ZYhPTKi5VAqaRveKuWg==
X-Gm-Gg: ASbGncsnr5e10vlMkEiQb8bdDo8OjYhD/oCwmMW0LKmNlHJWdvE/px97VJDCB3xm+op
	WhuhFa7moOHoYXXgszcruChxofCSRI8x/RaMMttx+Lmg4iGmJeDu+GrtMxAOvBM28zCZMyfRGyA
	I0DTkd9V+Y6tiWm6OchmFvLWEfzK2danQq4Nh9VN8DV0d6c3ZZWwk46GY3Om45UGA/n8+iKBrmS
	64gk19dAxlY0uClIvP25AXbM99/DH3BDbz2wtF7H4NezkefLt8V2sRL+gDEGLXYej6pQNwanZou
	5tRBSXnwAB4P1g==
X-Google-Smtp-Source: AGHT+IHhXop908Z/dGC607jmEkM3WDzcFyRlOGL0fJ3qKH3uQAF5tDsUxE14BK6DsytExPiDeCznPg==
X-Received: by 2002:a05:6a21:700d:b0:1ee:68e2:8d7c with SMTP id adf61e73a8af0-1ee68e28ec5mr14048439637.25.1739508097653;
        Thu, 13 Feb 2025 20:41:37 -0800 (PST)
Received: from meet.. ([103.240.170.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb57c5e01asm2008367a12.1.2025.02.13.20.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 20:41:37 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net,
	Meet Soni <meetsoni3017@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [GSoC][PATCH v2] merge-recursive: optimize time complexity for process_renames
Date: Fri, 14 Feb 2025 10:11:29 +0530
Message-Id: <20250214044129.15282-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213090040.16133-1-meetsoni3017@gmail.com>
References: <20250213090040.16133-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid O(n^2) complexity in `process_renames()` when building a sorted
`string_list` by constructing it unsorted and sorting it afterward,
reducing the complexity to O(n log n).

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
Range-diff against v1:
1:  c7dca6e971 = 1:  c7dca6e971 merge-recursive: optimize time complexity for process_renames
2:  78a007be7d < -:  ---------- merge-recursive: optimize time complexity for get_unmerged

 merge-recursive.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5dfaf32b2c..884ccf99a5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2758,23 +2758,22 @@ static int process_renames(struct merge_options *opt,
 	const struct rename *sre;
 
 	/*
-	 * FIXME: As string-list.h notes, it's O(n^2) to build a sorted
-	 * string_list one-by-one, but O(n log n) to build it unsorted and
-	 * then sort it.  Note that as we build the list, we do not need to
-	 * check if the existing destination path is already in the list,
-	 * because the structure of diffcore_rename guarantees we won't
-	 * have duplicates.
+	 * Note that as we build the list, we do not need to check if the
+	 * existing destination path is already in the list, because the
+	 * structure of diffcore_rename guarantees we won't have duplicates.
 	 */
 	for (i = 0; i < a_renames->nr; i++) {
 		sre = a_renames->items[i].util;
-		string_list_insert(&a_by_dst, sre->pair->two->path)->util
+		string_list_append(&a_by_dst, sre->pair->two->path)->util
 			= (void *)sre;
 	}
 	for (i = 0; i < b_renames->nr; i++) {
 		sre = b_renames->items[i].util;
-		string_list_insert(&b_by_dst, sre->pair->two->path)->util
+		string_list_append(&b_by_dst, sre->pair->two->path)->util
 			= (void *)sre;
 	}
+	string_list_sort(&a_by_dst);
+	string_list_sort(&b_by_dst);
 
 	for (i = 0, j = 0; i < a_renames->nr || j < b_renames->nr;) {
 		struct string_list *renames1, *renames2Dst;
-- 
2.34.1

