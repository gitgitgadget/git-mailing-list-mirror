Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2585F442C
	for <git@vger.kernel.org>; Sun, 18 Aug 2024 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723993258; cv=none; b=KFdJUGX5O0XJIvRtc/3Gmi4sqQXw/8idKd+FMqCU+dneH+p2RptHv1vJONcFopQ3cBGNTWAhRnNoPoex8Zybw09/QxeKoOU/S3L5ThmR9sNDTue4U+vl1IYapHhIzrLmSZhH5Ytomm4DR2Rp3Rk3LWkHx+9NhIi9r6pQZ5cosJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723993258; c=relaxed/simple;
	bh=oc3J+x3Cb4etv0CKFpLB1eyBt0mOWkPLxfTUX7SDKJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itTQw/USrwRSVclNGxUBR/dm3KQ70KwobAG65oz/4FbvY3RSQk82l9/oOyKQCDCq2hMPqBYItRwwg1jYErppIfv60bwUgLEh6Fi6bTMUeaNMvhZze5VR8OyjwwxrppUZS5vjrxRDYM0TNrXFr/6WwBv18B/nyGuDQKT1Wkr7n68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfYKOYt4; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfYKOYt4"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-710e39961f4so2287786b3a.3
        for <git@vger.kernel.org>; Sun, 18 Aug 2024 08:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723993256; x=1724598056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VW8oDhZXfBP7ucD9l6y2jGB3MYaxB0TVGcGEZ01xKRk=;
        b=hfYKOYt4lFOTqtgoKA8e2djGarEXbR3KkGlAzid9aZaUdJ7a/Pw/U1kguWfEkeXRQ5
         P3vFBV8gnS37g/yFG7FzHN0VJiQy7kcmXMV6DeOB5IBm7NwTKSm0OI4BvXBCeOAcTYJO
         nVu9uZJLZ5m8wDvTY599P8pLLAs1YsLI8AzQOI/wxKTpIXk6DLPE9M6JRZZSKI2nFPBM
         zJWnFMTVNsI+je89PbL2FEpq7ZVeiGGNdRtpQC90aVwbYaq9PkI2XOCn6xM8mQp31HVw
         jkE7WueMum0uqEm47zKHpewzT9/yanzKncnr2orSOJIOhnYY26l/vW9qS+yGzG0jJ2uL
         H0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723993256; x=1724598056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VW8oDhZXfBP7ucD9l6y2jGB3MYaxB0TVGcGEZ01xKRk=;
        b=lz+TeEEaWLaMYR4Gio7haxHTIMQ5Rnqytu/+eIYr5kUd1TLXkMmi88dP4hXjY+mIhf
         MOj5HF74aZFzlqvLTPIYu1TaVLjV1PCRNVszp+ReIB9UmM5Kfiqdn7Sy20mUiRlYtMsT
         mqquZ+pSgzLA64t1KKNEGqtctLQq+g0TviQbaxDE03dENqzeADMZ0qU2hmC/Q3528SzW
         21icO1yczsVZu12bJbzF2oNDstx/CfwJfktBjyRf2/CQv8MwF1fFJjW2dkyQn/g4hz4R
         eDfNA6MngEaTY0moG5f4Ip3DDPx5boEOp52sdoQtj6r2xMGDA+E532qG2RFw5u3QLgBV
         23Og==
X-Gm-Message-State: AOJu0YxlcuySt6Bs3ehYzYHV7d8ZYVj0QZvJEVGJbAE2AsP3zLn/7JrR
	2DaGVP3wj+PdC1pS3unrAX1iYSDTlJbLiD86Jl0krx7Ls+b9rrWxFaMFvA==
X-Google-Smtp-Source: AGHT+IEFVDOh4QdoOG4W8In9acnhVahLLZ2pbr+TJmu6Dihp5MvganS2z8spy2UL8yzmVk+vKNcFZA==
X-Received: by 2002:a05:6a21:3a81:b0:1c4:a2a7:b18e with SMTP id adf61e73a8af0-1c904fb5106mr8277618637.30.1723993255630;
        Sun, 18 Aug 2024 08:00:55 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3171bd3sm5601976a91.31.2024.08.18.08.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 08:00:55 -0700 (PDT)
Date: Sun, 18 Aug 2024 23:01:36 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v1 1/4] fsck: introduce "FSCK_REF_REPORT_DEFAULT" macro
Message-ID: <ZsIM0L72bei9Fudt@ArchLinux>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsIMc6cJ-kzMzW_8@ArchLinux>

In "fsck.c::fsck_refs_error_function", we need to tell whether "oid" and
"referent" is NULL. So, we need to always initialize these parameters to
NULL instead of letting them point to anywhere when creating a new
"fsck_ref_report" structure.

In order to conveniently create a new "fsck_ref_report", add a new macro
"FSCK_REF_REPORT_DEFAULT".

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.h               | 6 ++++++
 refs/files-backend.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fsck.h b/fsck.h
index 500b4c04d2..8894394d16 100644
--- a/fsck.h
+++ b/fsck.h
@@ -152,6 +152,12 @@ struct fsck_ref_report {
 	const char *referent;
 };
 
+#define FSCK_REF_REPORT_DEFAULT { \
+	.path = NULL, \
+	.oid = NULL, \
+	.referent = NULL, \
+}
+
 struct fsck_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8d6ec9458d..725a4f52e3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3446,7 +3446,7 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 		goto cleanup;
 
 	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
-		struct fsck_ref_report report = { .path = NULL };
+		struct fsck_ref_report report = FSCK_REF_REPORT_DEFAULT;
 
 		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
 		report.path = sb.buf;
-- 
2.46.0

