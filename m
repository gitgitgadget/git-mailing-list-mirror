Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08AD2874E4
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758749075; cv=none; b=HyUDeKB6cHpMtTzPQkmdHiTMbXyMwi7ldLiuBLPPVLOumHBbXhSsaNX2dygOzwCsS6AybNYyWlmRH9OwEGpSveOgCHH3387QSem3poqFIKmVu7KV0Rxh4saC8nMINVL50b6OHtB9QXrxUISHRxhHNw1DpIQQZxf7LVsfu4Zp9HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758749075; c=relaxed/simple;
	bh=/1SnD3WYBHp1TwPoq1VIuriILgy4qstGvpGLP8cKBOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5q1maMExN+AZ9x7cDugZ7ym/mmVrcUWYgUmdDPd9WpYumxUsicunKtxicm5Uo00mIBzY5K2iRXTHUcGsN2wzRdKzi+3tyWW+kqdJefIGbh01mzhlUx5RL1qiOx5+Zjf8viCphAhxT+sxUjCKgUYcu8u8zV9gUxQP3+uzNuZaZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqSi6uyk; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqSi6uyk"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-62ea23446f4so74114eaf.3
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 14:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758749072; x=1759353872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hY2YdpRXIoSdDtOeSL1Fzj0grP/ivSC2SYohVHa3Vss=;
        b=EqSi6uykMLvM5yH0DQu7Ye/mto670UFqXr12i9pLqY51fg6yOXljpKfvmmhtZof53Q
         IVukM9fj3ZuPrWqYR8WcSD0X6qhQIC0C9tbLlaPgcp9Q1gEhfGNERNwOdfPDa+xl8FVt
         px9R7PJmHmKJOrd2L3PX780O45To3AdZZT6ro5yM7ZZSsVLhB3ywa4E+abI2TmjKTkzA
         XzZsOmelNZFeo/FY6Tf3IUMDViTxYD2J4gKKKORr/Uxq0FM3fqqFTCJuOhSukN0wCexR
         n0Vt/NIOlYuK89o5UZIytf02VUixFznSV6m1QnCu+QexPkgeYA2zQM4TCXJbNGvdkUKY
         /HXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758749072; x=1759353872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hY2YdpRXIoSdDtOeSL1Fzj0grP/ivSC2SYohVHa3Vss=;
        b=DbXAhy0k/xCsjSZ6GN4bejGBiVAQy8QuhtcZ9IiYl4cBqHHIpTDmX3NvsiyHdfvQy2
         6VeQKmEHmvefqsVEBMdeMyJINelo/JY+L91POKMH7fuNFe33UHj4Wd/tv/Pd7DEPQDAH
         9e8/MgRaKOrAuzZ4JeKPEjaA01pro7qgCqZpyjaZiqqGXzXxIDY3ZpvvaGvagRyswks4
         8nPW0ilvGJtNmkng8qMLTeaIAzyAdGxWnLE5t/QX9d0aC9HIz3S/bgDj4S9e88HHq2VO
         hiLXtiHit+5MxfaZphbzEgciyJHXo8GXPN+NwJjuRWL0MgEfdzeGMr0FFvtytuvOMT5p
         Zemg==
X-Gm-Message-State: AOJu0Yzyid2ne2nvPSY8pYZVkeKC0SgtXkqHp2X+eiLyxi74ZgJQKatg
	p3Y2NavcRZkieObosssxfqWiTU53BQg/gXuQct3e7rtNU4YBsmzc/yRvpcQQaw==
X-Gm-Gg: ASbGncvHMIz0HlUiaVK+3loT6Ty8QdT5xEDWcsbrfP1IB8hcWcIDWHAYiGS+9yDQgc5
	0AXsOPs8v1T7Y0/iT3oxVsGqf4FxsA3SaYHw7Gw3WVWvaTMZ/N294Kc2IsB0E85AkFYdnWB/R35
	juLGfae3EG+xH73ld29vH/HR1rZCXetssJIqKfQfA1/FuMivwk0Bjgtf0YZfhgjlSL+5Mcb9YcG
	G+caWiaT/d3wBrXcpKzlCD3rFExxJyxSyC4md3d/CsuP70mKGQTaOLpMoJLNoL1w+/dVpBfTalw
	g1QvHXmhiFWrvkvL78ysda5iqXOXfoEYcmbPgcFMBRQQrOtlHzpXwokFbCHXHcyqOK8FsmJG1n9
	YXcNzJtjT853WV3Uy/1iAGvG+x13qzYQ=
X-Google-Smtp-Source: AGHT+IH15HnPdY7eZxlPtvzSkuiHrAXtXD1FmEYtbA7Hy0Hby1R8xez0z6dKtJkmdRRvgwnyFB1GUg==
X-Received: by 2002:a05:6808:191a:b0:43f:4ad3:df17 with SMTP id 5614622812f47-43f4ce9d01bmr914129b6e.35.1758749072442;
        Wed, 24 Sep 2025 14:24:32 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f46f5dbdcsm400117b6e.12.2025.09.24.14.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 14:24:32 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/6] ref-filter: allow NULL filter pattern
Date: Wed, 24 Sep 2025 16:24:22 -0500
Message-ID: <20250924212426.2930029-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250924212426.2930029-1-jltobler@gmail.com>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250924212426.2930029-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting up `struct ref_filter` for filter_refs(), the
`name_patterns` field must point to an array of pattern strings even if
no patterns are required. To improve this interface, treat a NULL
`name_patterns` field the same as when it points to an empty array.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 ref-filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 520d2539c9..2cb5a166d6 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2664,7 +2664,7 @@ static int match_name_as_path(const char **pattern, const char *refname,
 /* Return 1 if the refname matches one of the patterns, otherwise 0. */
 static int filter_pattern_match(struct ref_filter *filter, const char *refname)
 {
-	if (!*filter->name_patterns)
+	if (!filter->name_patterns || !*filter->name_patterns)
 		return 1; /* No pattern always matches */
 	if (filter->match_as_path)
 		return match_name_as_path(filter->name_patterns, refname,
@@ -2751,7 +2751,7 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 		return for_each_fullref_with_seek(filter, cb, cb_data, 0);
 	}
 
-	if (!filter->name_patterns[0]) {
+	if (!filter->name_patterns || !filter->name_patterns[0]) {
 		/* no patterns; we have to look at everything */
 		return for_each_fullref_with_seek(filter, cb, cb_data, 0);
 	}
-- 
2.51.0.193.g4975ec3473b

