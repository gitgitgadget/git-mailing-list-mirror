Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67772F3C37
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183117; cv=none; b=r1mapVt9/JAGSCjcrbORniZTs4IKO0kGyNab5wkDtHdB8PI8mDQuVFFD+7KzXSrt0DCeoo4JprXSIHxl1SlP+CBoMc5kSZgPOdchvuaNPqrTNIH7pr5nAxG/qbfEUkQd2OjSVaLF1ImunXZqC2apQOZYzyPQNQ2rMieM/um3PCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183117; c=relaxed/simple;
	bh=8pu02Pbs69YrtElU9PJNvgsE2tA96Td/IGEF0c8v3IQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A5SnjiCPnP+cfByWkmZ47xwJphBAqituCTkwEEorsbZnMWVrE15aZsPkXibs3YmhNn1KCvWtfnUec18+ZmGhn5+NN9/anpYMXYSUTOsnBDld5abAT9qqSXhYre9tm3dSAk6aUc1AkFCQH1REsfZfCBZ/Ft156psyy9PXpGmaw+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLaDLHhT; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLaDLHhT"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62f1987d49fso950734a12.2
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 01:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758183114; x=1758787914; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djy2wyY3fAXCCEAcu6XnkFcXVHHN28jteNj/JmHlLMw=;
        b=FLaDLHhTcbfSZJ8fnIcvifuafab3yg03hWm+lvsD+O/fLQG9DzgaY1jAQMhY98jq5T
         a5aoVk+ooN9SrGBn8QcAsDgeJRLhOF/Matcn1vYYqZSpWhB0YRH2hLRHLOhuaqr6B1pH
         jrgUMs0Boy27fL5UvGqrrKc9983Ge4pb0uO8Vy4XxUZf9MFhfiUfyVpo01MVLLF6vnOM
         FRBfL3gtEBvsRg4OEI3XN/KJBE+E5TcdtFSpgV0hPBz5DroKNrnLS9wE2Q5hL2YaEKkB
         WTwj43fOuog6jbVKbz0FldpQN2YI0t9kaHKNl6avQcPuT7MOQqzwmlRrVGU/xVrsNjXA
         JRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758183114; x=1758787914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djy2wyY3fAXCCEAcu6XnkFcXVHHN28jteNj/JmHlLMw=;
        b=vWDplZztG4CFMfZvnOKVVIKFm4NZkjSsw9uR7rZKgCKa1ChfJ15tsSlD0UjhIQceo8
         DhXGaH7rC28XrZk4lgTttlDfXmzOiskl3kq8OruBC0uWGbPw3ORUaKfOrOQA+Uylk3ew
         3qvZ76C+AZDEQKBQvsCMAsq/WCz7eyOIatrdsD4gRysxHHzvlh0/0K4yTPN+KjDioxZ5
         8N4ioyWHo0WmMvgtKHxMtcgaT/JVUqpvVQaN1mliI7nePtzoI6LUBgFbKC2DSlseaF+X
         ui9yN6qeKsRql8zsNkka8zN+vnawzrIZKqp2V4TLVKiWQ55L0vEJjP+yCFB5yFU2nBfY
         86tQ==
X-Gm-Message-State: AOJu0Ywo9n2uviYGdgENCakE10VO65zT7EM+gvRq3adVShh3Yl5FwtnA
	TwqNKtAJWBBoxeEVf4hSRC5TLgD5nwfR+DOucj4qiwVVgkhqsLrW+YlY
X-Gm-Gg: ASbGncsP/VxMBoaCqpfAD1vGIh/RtNNB0eWguPK5WEE8P5AR2KewMCdatJM7BG0MhVX
	Ko/nRpsSp60RDBI6MXgpvU8veKnAe1030Q+TbOn2DMsISZAobECBtohjCBtFigJbY6AzEzIdZen
	6oPfI2/8F6YJOPfxLH40fliqCzPxbPPi2UDg6CEuZJH3kRGJ8iuJmQttTuk6+nvKyXQEBnYwG/s
	IdXjjVUg899WjestoBG/UeRSJ5PQhkOK+HWRLpMX5+zWnEZ8Oa42zd34LCPUdc4TyHtxt97IRwg
	WdPW7A1O1lo4dApPLVJz7hB92qAY7PBUiTV+nL1ttVUraMXcKzoilzDaoiNj44IxPp4SdZ82wVj
	B4mLXxFm10+7lOPa3Cjzgp+f2tFcIurrfEsGlHQPMXoYC+Rw=
X-Google-Smtp-Source: AGHT+IHrtrrBGoEFzF5acQzuZ3gaZgxXJjK0DKKbLec8pShosY6KkIZm7ek8RZriE6bTMS2SBo1YTg==
X-Received: by 2002:a17:907:3d86:b0:b04:85bc:a90c with SMTP id a640c23a62f3a-b1bbc544ff0mr609698166b.48.1758183113773;
        Thu, 18 Sep 2025 01:11:53 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:2802:b9c0:7d04:71e9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd2ce20f4sm139986566b.111.2025.09.18.01.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:11:53 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 18 Sep 2025 10:11:47 +0200
Subject: [PATCH v3 6/8] fsck: order 'fsck_msg_type' alphabetically
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-228-reftable-introduce-consistency-checks-v3-6-271af03eb34d@gmail.com>
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
In-Reply-To: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, shejialuo@gmail.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3085; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=8pu02Pbs69YrtElU9PJNvgsE2tA96Td/IGEF0c8v3IQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjLvsNvRK4LNSEsMqDxnPEEjZr9c84yS3lKF
 QwHtz+51pWgf4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoy77DAAoJED7VnySO
 Rox/LjEL/0+fZRuPmcxfGhaR4gc14xf20I9wIubRBUoxXWVlecCv5IHl+5Z7gQSLy9BaC7oq8Nw
 q/vfT7f7NVBOxr50o6a8Fs0UJ5tlOwuNJscKb8UgnSMhjir4lfD0Oi1+bEOFHBWIwqzKt2Sji4d
 xVs0BmiGCw7AmTSLYLvLeJDbBnkS693FGeeUE8ZTR4KWzDRW99tg4SpwZQEr9KbzO2pE5bkDw84
 uFWI06dYCkvMjZ96WmuvhR18MVhSkIUjY+w2sGYX4ywe5qPmsC0fJVu4fkAo24yn6nwQnXOAYQH
 qHmSvu4KvRzlLsb30UPwf/uLVebv69ftUv7sxIoFRHG6TvDZVKUfsaKvNNQ9I9e2VX4eTD3VZjQ
 AbVNa181x+g5mu7uiO/d6BBhrUmINz9Gd7VuW9Wcc+116QSaBZ1P+nCgejYsPRs2A05yaKCCNbV
 AknlBwxN/q+lHjasZ1GtqREeSFhnv+ZjXjJUXay8DHR0asZz7YZstM0uSJXT4EKnEfufh/IrgA6
 9s=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The list of 'fsck_msg_type' seem to be alphabetically ordered, but there
are a few small misses. Fix this by sorting the sub-sections of the
list to maintain alphabetical ordering.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 fsck.h | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/fsck.h b/fsck.h
index dd7df3d5b3..6b0db235e0 100644
--- a/fsck.h
+++ b/fsck.h
@@ -33,15 +33,27 @@ enum fsck_msg_type {
 	FUNC(BAD_PACKED_REF_ENTRY, ERROR) \
 	FUNC(BAD_PACKED_REF_HEADER, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
+	FUNC(BAD_REFERENT_NAME, ERROR) \
 	FUNC(BAD_REF_CONTENT, ERROR) \
 	FUNC(BAD_REF_FILETYPE, ERROR) \
 	FUNC(BAD_REF_NAME, ERROR) \
-	FUNC(BAD_REFERENT_NAME, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
 	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
 	FUNC(BAD_TYPE, ERROR) \
 	FUNC(DUPLICATE_ENTRIES, ERROR) \
+	FUNC(GITATTRIBUTES_BLOB, ERROR) \
+	FUNC(GITATTRIBUTES_LARGE, ERROR) \
+	FUNC(GITATTRIBUTES_LINE_LENGTH, ERROR) \
+	FUNC(GITATTRIBUTES_MISSING, ERROR) \
+	FUNC(GITMODULES_BLOB, ERROR) \
+	FUNC(GITMODULES_LARGE, ERROR) \
+	FUNC(GITMODULES_MISSING, ERROR) \
+	FUNC(GITMODULES_NAME, ERROR) \
+	FUNC(GITMODULES_PATH, ERROR) \
+	FUNC(GITMODULES_SYMLINK, ERROR) \
+	FUNC(GITMODULES_UPDATE, ERROR) \
+	FUNC(GITMODULES_URL, ERROR) \
 	FUNC(MISSING_AUTHOR, ERROR) \
 	FUNC(MISSING_COMMITTER, ERROR) \
 	FUNC(MISSING_EMAIL, ERROR) \
@@ -60,39 +72,27 @@ enum fsck_msg_type {
 	FUNC(TREE_NOT_SORTED, ERROR) \
 	FUNC(UNKNOWN_TYPE, ERROR) \
 	FUNC(ZERO_PADDED_DATE, ERROR) \
-	FUNC(GITMODULES_MISSING, ERROR) \
-	FUNC(GITMODULES_BLOB, ERROR) \
-	FUNC(GITMODULES_LARGE, ERROR) \
-	FUNC(GITMODULES_NAME, ERROR) \
-	FUNC(GITMODULES_SYMLINK, ERROR) \
-	FUNC(GITMODULES_URL, ERROR) \
-	FUNC(GITMODULES_PATH, ERROR) \
-	FUNC(GITMODULES_UPDATE, ERROR) \
-	FUNC(GITATTRIBUTES_MISSING, ERROR) \
-	FUNC(GITATTRIBUTES_LARGE, ERROR) \
-	FUNC(GITATTRIBUTES_LINE_LENGTH, ERROR) \
-	FUNC(GITATTRIBUTES_BLOB, ERROR) \
 	/* warnings */ \
 	FUNC(EMPTY_NAME, WARN) \
 	FUNC(FULL_PATHNAME, WARN) \
 	FUNC(HAS_DOT, WARN) \
 	FUNC(HAS_DOTDOT, WARN) \
 	FUNC(HAS_DOTGIT, WARN) \
+	FUNC(LARGE_PATHNAME, WARN) \
 	FUNC(NULL_SHA1, WARN) \
-	FUNC(ZERO_PADDED_FILEMODE, WARN) \
 	FUNC(NUL_IN_COMMIT, WARN) \
-	FUNC(LARGE_PATHNAME, WARN) \
+	FUNC(ZERO_PADDED_FILEMODE, WARN) \
 	/* infos (reported as warnings, but ignored by default) */ \
 	FUNC(BAD_FILEMODE, INFO) \
+	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(EMPTY_PACKED_REFS_FILE, INFO) \
-	FUNC(GITMODULES_PARSE, INFO) \
-	FUNC(GITIGNORE_SYMLINK, INFO) \
 	FUNC(GITATTRIBUTES_SYMLINK, INFO) \
+	FUNC(GITIGNORE_SYMLINK, INFO) \
+	FUNC(GITMODULES_PARSE, INFO) \
 	FUNC(MAILMAP_SYMLINK, INFO) \
-	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO) \
-	FUNC(SYMLINK_REF, INFO) \
 	FUNC(REF_MISSING_NEWLINE, INFO) \
+	FUNC(SYMLINK_REF, INFO) \
 	FUNC(SYMREF_TARGET_IS_NOT_A_REF, INFO) \
 	FUNC(TRAILING_REF_CONTENT, INFO) \
 	/* ignored (elevated when requested) */ \

-- 
2.51.0

