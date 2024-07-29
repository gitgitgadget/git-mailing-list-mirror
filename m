Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FAD3C24
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722259562; cv=none; b=V3TLHZWGrx6O8WXNNAKb4WbNibGMyIKCWnMZaH8/zZlTxSiyEOkyQXbWrNf97OlPhKPWr3XJPui4MBsN6+INxWD8Zl3hzh9ZerR5M3TPcmqeFaubuYqFg4Q9wjUbZdpDR0HfQVG4CfIEomU1X394Br1cPKRatcBDgGzSEMjzWB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722259562; c=relaxed/simple;
	bh=4S/eeYa3WSAOASAvQOCp2KZZaz7om+5BeG3DmzjcW/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHVbMJmdpBmWpmMCZTZjoTAQ28T9O/ufXAqmGszfAvUU9IzXjkz96UV2sYiS+LLdFR7JNxDfEusp7v0dk5fiTCWGwMzWcdbxqXfFfOQQClYiH4PG1XNUdRAykN8E16W+cwI8tqwHiJNC+zQGurYiHotN6o2gMeA/9zg3zfyYkqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATL/BnyL; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATL/BnyL"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70930972e19so747375a34.3
        for <git@vger.kernel.org>; Mon, 29 Jul 2024 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722259560; x=1722864360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UDRGCnen2eMRIWeoclWfDlQnsmaMv5ILJOERPNxlb4=;
        b=ATL/BnyLrAQIbxXEW6HEI/+Qlq2DRCUMLPC9jACfBLZabnWBv0u96BJfOx8cHjxvEj
         Tre1FJkpK3iapyg4FiGRbwIThsb8DLQEowttYXFOB8w23LQSk4b4ysGdiyfwuhlcR5tM
         ws6pOXi7/KkMHEVo9/0M8xyzeV81Eaylpq/WqRlrdNyMeelg/WOVP+nC/welVEegj4UJ
         YGsmH+YF+jwqvhKNRsbqZUfiwCsPfVIQ98TN3gl2EMxo1RGuMinz55XquY8I3Io36mpb
         PR2q2IoWLeWL/smftgRelO0zPArJMOqCF98lhVlKoSZRdp32K6pRo8H4b0MYYRCrXEXj
         F56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722259560; x=1722864360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UDRGCnen2eMRIWeoclWfDlQnsmaMv5ILJOERPNxlb4=;
        b=Dt1YxVqFoKKXcWDo2zJ9OX6R1/VIFILmsG7gLWz5KJl7cBReH4mIsYez4+993/SO0K
         MFoj9i3SLsB4wLQw6hLt8KWSJcbM2wryXWXVEc8KR0Z+TvN/l7sVTvY+Bdanm/ROxA0j
         RJAdLNUBE05AvLX4ztWI5ffyWdDq5G5S4VDQHwgNDdgmmxE7mmedphoydk0e87puOTu7
         IoAbFFw9glaohw+20TwswFCrVFfltT1+X4oaQMfwaFyhRvHEJRzdm72Sciv5VwPIEtxY
         DjZdHAB/dh8HhqITmHpQX5CjPo/h3zLTJNVs+HvrUu7nl6IQZYLHqNRuwik5dP9jmkDJ
         IP6w==
X-Gm-Message-State: AOJu0YwxIiVVJ4RJ417vT3+RuXeFWORKXcCav1o3fgy7/tQtIKHtCHkT
	g5ik3xrNg6V5HKNyrfLvRmSDVjCU6Se+K30Jfqvzc2D7Xf8g5+4eNzJPDg==
X-Google-Smtp-Source: AGHT+IGdt2RxScNE5xWqvCUSN+92F3pzBysr5f2Lf64zen4QXMBPRbQrMUvkMBdwH7YAYCw1+RUH5w==
X-Received: by 2002:a05:6870:392b:b0:24f:c715:a4d4 with SMTP id 586e51a60fabf-267d4eebaf4mr10817872fac.40.1722259559560;
        Mon, 29 Jul 2024 06:25:59 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e13f9sm6800576b3a.21.2024.07.29.06.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 06:25:59 -0700 (PDT)
Date: Mon, 29 Jul 2024 21:26:20 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v13 01/10] fsck: rename "skiplist" to "skip_oids"
Message-ID: <ZqeYfASSt-sdXuKv@ArchLinux>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqeXrPROpEg_pRS2@ArchLinux>

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

