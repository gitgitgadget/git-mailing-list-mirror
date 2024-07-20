Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9297040847
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721467639; cv=none; b=VfiHb6pUcSrquaplOk7M10ArlJVV8MahANMkKrVj7VUlEEImXO2Zbgzo5woIsYoU7cJgwEXgVXvTMs6Tbe3L6OApu27duoKUypP0T5LTAQrsqnVyjy2X528bYQ68CHnWdLSY+nvmaCsUjbqbEXi5rc0/unmPkl3xK21q+Sfl5NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721467639; c=relaxed/simple;
	bh=4S/eeYa3WSAOASAvQOCp2KZZaz7om+5BeG3DmzjcW/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d59rI4aYUodM0O9w7XoG/7pQ15xlTNflMTBJAksqGBVlvA/qW90JN1HCuraUUuN0b1peonZGGJepJyWZlqlATRgzXyRDhZ7QuFYOMyPUrqohFS5Bxwh7uINPFkafkjJmD7rRW8F7IdryWnWOUmG8pzONZE6DF4EXNguQNG5+C8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWm0SBbr; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWm0SBbr"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d138e06e3so113101b3a.2
        for <git@vger.kernel.org>; Sat, 20 Jul 2024 02:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721467636; x=1722072436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UDRGCnen2eMRIWeoclWfDlQnsmaMv5ILJOERPNxlb4=;
        b=NWm0SBbrfTmq2ibuQNY2joP5n9hZNWwvoD+0nq5fdeqe+BQFOQL1y3/U//UaxNuvmy
         FJSsx1alfVD4z/71Rds0edTcYmgIjJSrM++3vglMfXEQD8wF5Zmg6pdKhSIzDHaEqytN
         8756teibpxBpSLo9dAEyGghc3EPd447AZbbgyQnWdNtx52ODSLjuSQUyNG7HwCu2wB0Y
         4Ol+JJ8Gi/rB8yS3P1MTeKRKFnqa0Ewe3ZyqRfyLulrgQT98CHLtZXgalffFVEMjNX1F
         NjFp+ExQ5LNN77J04ihxXM79gSPMSSpuML7g7URhYgSRhVTSAyGWwuoLZDXxjf/yCTVk
         RsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721467636; x=1722072436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UDRGCnen2eMRIWeoclWfDlQnsmaMv5ILJOERPNxlb4=;
        b=oUeeFgK7bMJM/AJzcfhv/WTG1HB1J77Su/KtvZZe8iqcvZq9zFOuouoDpEiUFQcafC
         iUMWdpS6mKr/vOlYpqKI0J23ptCX8TGtcXIfYjajwJQdEqBw9BkGjCaDqJ1ZPS6zsIUS
         qite/98I+xFK13M5r2AL3XxHq9cqidnHDlhK4RBUMny/lQaZeE6n5A7ItfhCny/FUDFC
         9tIrW+TwUtgSrgp2NlhkIAtjqnAZG2sDzb7eDbk1b2n+lIAgITBkwp5sV4Q6faz3H4n4
         9ABW67aPofC4Ey/sV0PXT7/5vXOPD4SM3TBSikplNMRd9pYtkHj+He4R7Vsfl2mGXbeR
         /KKw==
X-Gm-Message-State: AOJu0YzUvsWnpjgshEYUvG+TcaTj/UHaCu3ERD0CsN3Cv6nI/TVfeYEX
	Q4QQTGvrL/RVININRk5azKeNwV3ukKE2ksaxlaMZQId8io+QO1bHCpcjYQ==
X-Google-Smtp-Source: AGHT+IErD9zuXppNxQ3884OYJRe+gS/uapF5z/hQlfnhRJ3rGJSBkDD2dYsAMzQ/1B68gzUAEH4bvA==
X-Received: by 2002:a05:6a00:cc7:b0:706:62b6:cbd3 with SMTP id d2e1a72fcca58-70d08643bf0mr3088752b3a.26.1721467635815;
        Sat, 20 Jul 2024 02:27:15 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff552d8asm2335670b3a.132.2024.07.20.02.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 02:27:15 -0700 (PDT)
Date: Sat, 20 Jul 2024 17:27:26 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v12 01/10] fsck: rename "skiplist" to "skip_oids"
Message-ID: <ZpuC_vtbiqWWhK_B@ArchLinux>
References: <ZpuCg1GL1YE_sJBP@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpuCg1GL1YE_sJBP@ArchLinux>

The "skiplist" field in "fsck_options" is related to objects. Because we
are going to introduce ref consistency check, the "skiplist" name is too
general which will make the caller think "skiplist" is related to both
the refs and objects.

It may seem that for both refs and objects, we should provide a general
"skiplist" here. However, the type for "skiplist" is `struct oidset`
which is totally unsuitable for refs.

To avoid above ambiguity, rename "skiplist" to "skip_oids".

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 4 ++--
 fsck.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index eea7145470..3f32441492 100644
--- a/fsck.c
+++ b/fsck.c
@@ -205,7 +205,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 		if (!strcmp(buf, "skiplist")) {
 			if (equal == len)
 				die("skiplist requires a path");
-			oidset_parse_file(&options->skiplist, buf + equal + 1,
+			oidset_parse_file(&options->skip_oids, buf + equal + 1,
 					  the_repository->hash_algo);
 			buf += len + 1;
 			continue;
@@ -223,7 +223,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 static int object_on_skiplist(struct fsck_options *opts,
 			      const struct object_id *oid)
 {
-	return opts && oid && oidset_contains(&opts->skiplist, oid);
+	return opts && oid && oidset_contains(&opts->skip_oids, oid);
 }
 
 __attribute__((format (printf, 5, 6)))
diff --git a/fsck.h b/fsck.h
index 6085a384f6..bcfb2e34cd 100644
--- a/fsck.h
+++ b/fsck.h
@@ -136,7 +136,7 @@ struct fsck_options {
 	fsck_error error_func;
 	unsigned strict:1;
 	enum fsck_msg_type *msg_type;
-	struct oidset skiplist;
+	struct oidset skip_oids;
 	struct oidset gitmodules_found;
 	struct oidset gitmodules_done;
 	struct oidset gitattributes_found;
@@ -145,7 +145,7 @@ struct fsck_options {
 };
 
 #define FSCK_OPTIONS_DEFAULT { \
-	.skiplist = OIDSET_INIT, \
+	.skip_oids = OIDSET_INIT, \
 	.gitmodules_found = OIDSET_INIT, \
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
-- 
2.45.2

