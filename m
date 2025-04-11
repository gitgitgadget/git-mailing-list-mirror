Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADD52BEC2F
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 23:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744414002; cv=none; b=LbhHJMkmdjla0cWXMF8iVTC2K4GyELTzHr2pekZS4jl6KzSg7lTnY5FjII+zzsA1UAulD6RQ6BMcMEsrzv1iqMF112cWsr0eqXrJcMnu7fikiyxUGv5pT0T8ynIvsCUh5jJNdHWM2b3B9HLGazRunYQPbzrzRiZAOJtwdO8tHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744414002; c=relaxed/simple;
	bh=uOjyfBEFUgbsE82MMrqan29h4MUfesQlHI344S4+POU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzP2wCvatOBEcexVBKjulOORbiXjhNWc4E0nkVa5SgeExsifUCUmXU/tpUS580Qv/b08P0iBSmIf0mOIvXcvilttg59WkerLjdNa4XV7M9J/7XmlBH3U6+gAnFek8nWm86Jbh0DRO7EdRbhlj+mhst4Rciax0wdA1ZWmgIlubZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=N5W4MUNW; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="N5W4MUNW"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6ecfa716ec1so23525356d6.2
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 16:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744414000; x=1745018800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q+ZuHGNzHCOrF3eSw6ZAuxYMp6vmVpe8Kpb1d1Bd1Ko=;
        b=N5W4MUNW18H5mtTMu+fHXQTW7GahVG1ZXgJnKqyWq7xoPEF2wM1vkKmPSyUVr4ujbh
         r2hJPrKb4Vaeb21Hpuem5kHLdfp/2l2i8RJkYo5oxnnhvRHLIs7gHFrN9aQ8YJhWWbnf
         avtfYmFPT89J0Csh4HFdNT9s4iOyua/yDeX816UbIvghdFUKFGrctRo66Krnyn8jBx3j
         eqA9o/9xE/KQrfrH2R9dVK8o/TlYvzXk4Omwl01qNWx5VmNoBJlxrLHpWxzUk8PuTZiX
         q4zpYTefB/hekkIj3G9GAsAjJ8lKq0Iwwcu4In6xU/Oo1rNy6sLb6Mwhe3jaZQRYQ11j
         CNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744414000; x=1745018800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+ZuHGNzHCOrF3eSw6ZAuxYMp6vmVpe8Kpb1d1Bd1Ko=;
        b=XdcY2USJvKsvrbUrS4KVO1Xeo/VdzUbNEE9HGAHXf1Pz2VawbZgqWDoS4zLcsqJbVF
         bKQRa8nS3g7hl01iacHhhheKgVAYoJXXQ9G00BGcO60J3ObhlpLPc/jyiKUi0Kha8DVI
         hLo4yHdlXbilH39RQl7/FtYQUBQqf9Mvn3wCtmiKasohi9UCSAm8Nv6wskTqPKjGMVNP
         VO2Rrf/ily6BXo+tNaG/u8u8zJ6PK8XdRJMvQihGQ9ekPYRuCdybzSKEBADf85zKozxf
         4erDDGarfBPYFwTsIAFYx7KzrwNOxGOvu9cdkcNhT1zSGRQQhenrTYLnO0U3oeFw0obG
         FI9A==
X-Gm-Message-State: AOJu0YyDVK5J5er89fcFBtS9omqyCbytaJUSi6J4kapMAos7jLCO1Rvh
	oWHdrYYxRQeH0kj06feC4QmmV1W6bG9XP0Q5jd3LnDnIdYzULv/gMKIlfEV3w+lMUxHry2ZX03A
	0btg=
X-Gm-Gg: ASbGncunwI5wQYFN4T7rXQ/1+hgrp+XKCwMZpUjRNjMU3LaTa+tvavJkhH5YUfm1Wk1
	sQrS1wT9PFqhUlmBLJhEyA3pQrijb/xssOLB8pwfthPmPgwLBGu6vPy1pUCe3GGU0NDZKpIda4x
	5lNM3KvC+S2djW6aL5tR+4q/SK3+kWciwlS1HRQB2wQmenFRwXWQcvSgSr/yA1p17FDqhUuWflM
	I5PEl/4C1oUZeyyPptCMnCk2FO2eyudcEHmHaKKjPWxltNxhLRvfeVxoOFWhC+pquvRAqFeYDva
	rYMNTBN4F/+FqvDeGAebzaEUfB1l5wOFqXzqZYIgdQ8H/x/sYANecD2SCkDvXR4oetnItaBMwtQ
	HTeAI1omGOifY
X-Google-Smtp-Source: AGHT+IEKcIyRJNhqvNzarB2VNv3vaaok28U8O82rpkzVrRP1W5vsct636sPYVhhKT9I8ZsDcKcEQlw==
X-Received: by 2002:a05:6214:226d:b0:6e6:6103:f708 with SMTP id 6a1803df08f44-6f23f13ae3amr77797766d6.38.1744413999601;
        Fri, 11 Apr 2025 16:26:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0dea215adsm43005696d6.120.2025.04.11.16.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 16:26:39 -0700 (PDT)
Date: Fri, 11 Apr 2025 19:26:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 7/8] repack: keep track of existing MIDX'd packs
Message-ID: <ef0bc38cf0bfa056421e2288641f585a40a44ab0.1744413969.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744413969.git.me@ttaylorr.com>

The following commit will want to condition whether or not it generates
a pack during geometric repacking with '--stdin-packs=follow' based on
whether or not the existing MIDX has a cruft pack in it.

Keep track of that in the 'existing_packs' struct by adding an
additional flag bit to denote which packs appear in a MIDX.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index f3330ade7b..bc47bede7b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -31,6 +31,7 @@
 
 #define DELETE_PACK 1
 #define RETAIN_PACK 2
+#define PACK_IN_MIDX 4
 
 static int pack_everything;
 static int delta_base_offset = 1;
@@ -161,6 +162,11 @@ static int pack_is_retained(struct string_list_item *item)
 	return (uintptr_t)item->util & RETAIN_PACK;
 }
 
+static void pack_mark_in_midx(struct string_list_item *item)
+{
+	item->util = (void*)((uintptr_t)item->util | PACK_IN_MIDX);
+}
+
 static void mark_packs_for_deletion_1(struct string_list *names,
 				      struct string_list *list)
 {
@@ -264,6 +270,7 @@ static void collect_pack_filenames(struct existing_packs *existing,
 	for (p = get_all_packs(the_repository); p; p = p->next) {
 		int i;
 		const char *base;
+		struct string_list_item *item;
 
 		if (!p->pack_local)
 			continue;
@@ -279,11 +286,17 @@ static void collect_pack_filenames(struct existing_packs *existing,
 		strbuf_strip_suffix(&buf, ".pack");
 
 		if ((extra_keep->nr > 0 && i < extra_keep->nr) || p->pack_keep)
-			string_list_append(&existing->kept_packs, buf.buf);
+			item = string_list_append(&existing->kept_packs,
+						  buf.buf);
 		else if (p->is_cruft)
-			string_list_append(&existing->cruft_packs, buf.buf);
+			item = string_list_append(&existing->cruft_packs,
+						  buf.buf);
 		else
-			string_list_append(&existing->non_kept_packs, buf.buf);
+			item = string_list_append(&existing->non_kept_packs,
+						  buf.buf);
+
+		if (p->multi_pack_index)
+			pack_mark_in_midx(item);
 	}
 
 	string_list_sort(&existing->kept_packs);
-- 
2.49.0.229.g19b69c1246

