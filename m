Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FBA8665A
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972353; cv=none; b=gvUBdbUFwcznLJkk4xvcqZIpkjGyp4oqG9eE8uZZ582nA7r78WdlbWErtPMM2hapNjpjYsDJ21ypa4ebjCWjDWb1kTkxnLXYxuq56MfAjqWJjtVZSqyJQ2N4BcyRQqVOoD4iWNUqW9W6wfaYLidU/0s5Qa7m2PmCMJkxo/4TBj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972353; c=relaxed/simple;
	bh=SjEM7ajDVP32iB2JQg8l89qX9zrDrdYGlXdCHf8bgOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAIGrZVInl4Yp15f4iMhrQ7suZvFkx3Dc9t7Lxv3Cm3K357GJv1ROgFOwdxwoXgoJ76cVv50G+c3OuagaMOhRwV4pKoYyT+KXkzt/hRh94UElF4+67Bb6qPSDBZ0+EHGkAc7/Z9GtZ/Wsrz3nSJb5mzY3dYUD2jqVxwQBRDMFwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=k4HlN6PK; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="k4HlN6PK"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-430c63d4da9so2354281cf.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972351; x=1711577151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+yzlGzgl5SgHehfth0gTlFAAejNUnU0g/Yw2kPx8pQ=;
        b=k4HlN6PKWeh7flqd9D60hTHe4oW0ZnSosOnMSe+i1sVfcvCgvTGCa9jP+YWaR2mzcB
         8S/rdHMEqQROaPIEVdg/egRrE+x26wt8ADtBw5eAHrrMkIQ7kScUhOePmz1ncSkzs9U8
         SiW1YXCp5NIbncC9kWUowPcB2gFjwHU0vcpKh81n5/dDYYCGSICSiblVApNYF39vrfel
         Hz0j4lpZNhgEaX0A1k3IxOVvkGK37Iqb/LSoeglgjrOXDlnBwMOP9lkDw01Vcd8Cjk7s
         PsWgrsburHFS3oYdgWDCCHewstGqq1C4KLT9lLucj4TRsPfP0qknWPg8/o2BvjnvimkP
         jPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972351; x=1711577151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+yzlGzgl5SgHehfth0gTlFAAejNUnU0g/Yw2kPx8pQ=;
        b=hgVwsByWu+FXvgsnZHkv8LpbXSCBAQxeYOOboCc8D5AqEoZH0oUEU1fbv8x0syASN0
         v9paBxLk0TR7nGGxNa5pdW6NVv7Rr4NFd8PClfmGzZatucmnMMzH2jK/dANRe/HR4JIL
         cSwB29xHbZ++ewVV9qRMGc0xZnXe7GZIoBlhORge49ZSwWkHv0cyyCY7rOAulsIJudC2
         5pZc9JAvLIq2XIxx3yTEJ/YebxpVTleNsuBbo6U1Zup/kW9cm+MOZP9sk8pJfTBxwc88
         UEmm4I+XtM2uf6ff3hWeWx7hISCE3Jcp12mvMnWxvX9HNmhEC1QozvnByZaB70Xlq9BL
         au3w==
X-Gm-Message-State: AOJu0YxmWg9lZuz1w99XZpGvbWz9wM0kLTWLDZmXmcM6XP6ohy041Rp4
	ryOncBBjSsfnxJiQfz+gdObJ8zmI8kYQvuFqbPr7GVdDwwZYQDV4aU2ebs8dhglu/xPlsH4KNCj
	CIZQ=
X-Google-Smtp-Source: AGHT+IH6F8AwTaBlVHLbLp0R5cYz301I2wcJGsGEyM5HZbBkezRu43UKYHsaNOYVXcHbeu6xJtvtfw==
X-Received: by 2002:a0c:8e0c:0:b0:691:59ad:ff46 with SMTP id v12-20020a0c8e0c000000b0069159adff46mr17709599qvb.30.1710972351124;
        Wed, 20 Mar 2024 15:05:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id kj25-20020a056214529900b0069183a8de64sm6494675qvb.75.2024.03.20.15.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:05:50 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:05:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 17/24] ewah: implement `ewah_bitmap_popcount()`
Message-ID: <8fb7f7ab37b467bb5026296e9c7ae10632163525.1710972293.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1710972293.git.me@ttaylorr.com>

Some of the pseudo-merge test helpers (which will be introduced in the
following commit) will want to indicate the total number of commits in
or objects reachable from a pseudo-merge.

Implement a popcount() function that operates on EWAH bitmaps to quickly
determine how many bits are set in each of the respective bitmaps.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 14 ++++++++++++++
 ewah/ewok.h   |  1 +
 2 files changed, 15 insertions(+)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 5bdae3fb07b..a41fa152cbd 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -212,6 +212,20 @@ size_t bitmap_popcount(struct bitmap *self)
 	return count;
 }
 
+size_t ewah_bitmap_popcount(struct ewah_bitmap *self)
+{
+	struct ewah_iterator it;
+	eword_t word;
+	size_t count = 0;
+
+	ewah_iterator_init(&it, self);
+
+	while (ewah_iterator_next(&word, &it))
+		count += ewah_bit_popcount64(word);
+
+	return count;
+}
+
 int bitmap_is_empty(struct bitmap *self)
 {
 	size_t i;
diff --git a/ewah/ewok.h b/ewah/ewok.h
index c334833b201..d7e9fb67715 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -190,6 +190,7 @@ void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other);
 void bitmap_or(struct bitmap *self, const struct bitmap *other);
 
 size_t bitmap_popcount(struct bitmap *self);
+size_t ewah_bitmap_popcount(struct ewah_bitmap *self);
 int bitmap_is_empty(struct bitmap *self);
 
 #endif
-- 
2.44.0.303.g1dc5e5b124c

