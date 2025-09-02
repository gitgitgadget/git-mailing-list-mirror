Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF452E5B21
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756796740; cv=none; b=AmT8Pb7CvCHstvbk0UpOxgFo1GS81wPEZGl2y72VCW7d81gUeXckg0vl/C49RzAPqq9z3LjCum4nYb6Myiujvs9TyPUNtRTtfsrtuYCXEgH0bbEcBwE79GJilHkYRK1FQf2pGXucjAQLtknFTGGFshssf/8vA0q02MmWkwrlf3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756796740; c=relaxed/simple;
	bh=mdOVCnYhc8iRJZxX5nwUv2T6y7i0YUVzfGhVZ4wRL8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UpDUbeOeGkRpEKi3cA+iW51HhLxugAfJf1+ynm8Tjc0bMhybUMg84+gMA8mM8p4vDrJfwAfJyu1lkwLVN9YcKfc1Et9EMYbkf9GdoHSmQSCkTLh4bVl9z/vsHNnSm7q6i9gVlq2eoO43l5/525tq4fSGV+mhpwxFrbIN8JwaIUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HS7i+Cf5; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HS7i+Cf5"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aff0775410eso498846066b.0
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 00:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756796736; x=1757401536; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxKOV5fxUmFFpXzY9Tdv52EfPWvwJkJBQEXJshqhADQ=;
        b=HS7i+Cf53MwURdibuR6nBqzBgZe3S6dtQRp4H+obOXndzr9ul9apykewMYOZa1rSAw
         zDNZ61YVDNq8tsH5xuNWi2jbNe9f0wk3FZiYYjJ7a/mXq5G/42YLrPnHyQWtsd9hef4c
         1l/SHHoTcpDChJBWedrGJqyB0EizEhoKwWORqxIJe5yIKl9WAXCMJZHe7kSp6ZYsexXm
         2j/qB6c4L69T2pr6GVcC3803PPDe2uDlev9wS9ec7UUIjLAiqYzSMz7maAUKIAQwezw0
         ltCCj+CEtQaugtpWF0uJMNpXtGP9kvKalUnoVDZHDIt5Whp1zKFl0+WKE+9d128oxHhm
         S1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756796736; x=1757401536;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxKOV5fxUmFFpXzY9Tdv52EfPWvwJkJBQEXJshqhADQ=;
        b=AUz0wN2d3RuFwVBTwu1M9lDG8Teqp4ejXVz2hA9hlovmHplbaRc8lmqbuLTeO3ofE1
         ulE2QpM9rnF/XfiA0dhBgp8W2yvxftV3oS5XwBWihHFxI+DBrPR/6t41dkcysqie0Ugb
         bA22g6fvR7b34tx6h9kAPK5SW5ZlnRBQ9yLcJgenj3pNGx0ddC9FRE5GENA646X2SSvq
         AWgxGzvW+Zz1yeTTjiqnDxt72zL9tXZE3uZ7wVcsQ/qH9LV4L49UuIKh+Xb55p5ls3pX
         QNKYA3ZYEx8dlpIkpAJr3PCO0BeB6eu7OGfAEX/gj7aOlNEGG6zyXki+fxWceiJgtmt5
         WCJA==
X-Gm-Message-State: AOJu0YxCIcsJG7JM/MxoMPxh/Piz96QlG4JC/0XYJG148KQgzvUcwaT4
	SWQdpJ72al6p92rPMkhupllWFeQjSTv+931LPLqlwIMDGdlCvhz1rDWhZjfHLQ==
X-Gm-Gg: ASbGncv36nZSTLDl8h/hXjXhbDkXJkJ10iuDgyXNCcXDU/X9Up1HttzBUTHK+D9K8Gf
	5K2gcDquwFDYe9KofyT6rB2liDCk8jEqkZnJvXel4HP0EDL6EhIMSeC8htOxa8d2564Xd9BK1gf
	2JXE1c1YJqtMGWT/QS9Vcy5Np28JZlN2+T4O2HQOBhd1JwAu8RxTul7tDCzUYNaKg+uX9Ra5B8o
	6xrTdjMXD9bGcJB8on/5CuWNcJCpmk6zer61AKbQyEHtSanfSQsH+aVWCD26ouI+wPBgjcrRs2H
	msgwj2ORULm1ory2B989d9o5LCcAB27rlAYgixfb/S/4NIyoFMV16jKbE+SPb444Lc2zLJfeEv9
	DpLrGEgb8ZHOAW5mW93bJ2EbRQh1m
X-Google-Smtp-Source: AGHT+IGwIcTaDOh3pq7mLi0TIMy4pLQpYhzj3e4MFzL0sQocT2xoG8JXZbKh1Yqzm049ozTEiXWJGA==
X-Received: by 2002:a17:907:a48:b0:afe:8420:1152 with SMTP id a640c23a62f3a-b01082ae8c3mr927435766b.18.1756796736407;
        Tue, 02 Sep 2025 00:05:36 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:39c9:1f0d:23f0:502f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff9918dbd2sm821575866b.103.2025.09.02.00.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:05:36 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 02 Sep 2025 09:05:21 +0200
Subject: [PATCH v2 1/5] fsck: order 'fsck_msg_type' alphabetically
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-228-reftable-introduce-consistency-checks-v2-1-4f96b3834779@gmail.com>
References: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
In-Reply-To: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
 shejialuo@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8717; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=mdOVCnYhc8iRJZxX5nwUv2T6y7i0YUVzfGhVZ4wRL8c=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGi2lz2/CE8BVm10UjEjiTst7xdHfc2RELOQb
 FUgqRt5KFcsnYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJotpc9AAoJED7VnySO
 Rox/xEgL/32w4h7zGbiUVZaqshvIdRqLoMecg7q7QU/hHUDgdRsDvhToFYL2bkwz1dM+9gFBpdz
 IH5mBCWteD9Dcr0jCLflBNrkiBrKFkNebg87QXvQntRPy29ntPCsEo4ikhNsiOQsLt2T+5LpmEl
 GGofNbG1uMSDmzhJpLzAbkdbn5WtxjAkuZjzhCM0EVVcCGr2WFwJoaVC2S+RaUBMjhCdnzykuox
 4JQ3QM/pnZZxuFa0coGsbN9SPlWpmRIcvJKtlKP6EmGi0RTszZwP46iHQ/vGiU7aF1H00LpbKp2
 BjBNX88UEZd0zi8bjb6u838m3dg+GXPa2jPAjTECKJulYd38H+YKVvO6j+jGKQf8ffv2IkZiFla
 oS8N4UDvL76QMTolFgrSGYtsBc9w/UhoVAQz3PnuVLi94oyVJewTNtBFrfauUzAuzTVIzEB80mi
 yXnY792IyBNfKTEXSBvdKiAcRfw4Y8ChcvICMJ2UluNUfwI8QNYAFaFo9w56pQ3mDhtjj5MCCU3
 K4=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The list of 'fsck_msg_type' seem to be alphabetically ordered, but there
are a few small misses. Fix this by sorting the sub-sections of the
list to maintain alphabetical ordering. Also fix a clang-format issue
where the escaped newlines are not aligned.

While here, remove a duplicate instance of 'gitmodulesLarge' in the
'fsck-msgids' documentation.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/fsck-msgids.adoc |   3 -
 fsck.h                         | 150 ++++++++++++++++++++---------------------
 2 files changed, 75 insertions(+), 78 deletions(-)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index 0ba4f9a27e..1c912615f9 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -104,9 +104,6 @@
 `gitmodulesParse`::
 	(INFO) Could not parse `.gitmodules` blob.
 
-`gitmodulesLarge`;
-	(ERROR) `.gitmodules` blob is too large to parse.
-
 `gitmodulesPath`::
 	(ERROR) `.gitmodules` path is invalid.
 
diff --git a/fsck.h b/fsck.h
index dd7df3d5b3..559ad57807 100644
--- a/fsck.h
+++ b/fsck.h
@@ -20,82 +20,82 @@ enum fsck_msg_type {
  * two in sync.
  */
 
-#define FOREACH_FSCK_MSG_ID(FUNC) \
-	/* fatal errors */ \
-	FUNC(NUL_IN_HEADER, FATAL) \
-	FUNC(UNTERMINATED_HEADER, FATAL) \
-	/* errors */ \
-	FUNC(BAD_DATE, ERROR) \
-	FUNC(BAD_DATE_OVERFLOW, ERROR) \
-	FUNC(BAD_EMAIL, ERROR) \
-	FUNC(BAD_NAME, ERROR) \
-	FUNC(BAD_OBJECT_SHA1, ERROR) \
-	FUNC(BAD_PACKED_REF_ENTRY, ERROR) \
-	FUNC(BAD_PACKED_REF_HEADER, ERROR) \
-	FUNC(BAD_PARENT_SHA1, ERROR) \
-	FUNC(BAD_REF_CONTENT, ERROR) \
-	FUNC(BAD_REF_FILETYPE, ERROR) \
-	FUNC(BAD_REF_NAME, ERROR) \
-	FUNC(BAD_REFERENT_NAME, ERROR) \
-	FUNC(BAD_TIMEZONE, ERROR) \
-	FUNC(BAD_TREE, ERROR) \
-	FUNC(BAD_TREE_SHA1, ERROR) \
-	FUNC(BAD_TYPE, ERROR) \
-	FUNC(DUPLICATE_ENTRIES, ERROR) \
-	FUNC(MISSING_AUTHOR, ERROR) \
-	FUNC(MISSING_COMMITTER, ERROR) \
-	FUNC(MISSING_EMAIL, ERROR) \
-	FUNC(MISSING_NAME_BEFORE_EMAIL, ERROR) \
-	FUNC(MISSING_OBJECT, ERROR) \
-	FUNC(MISSING_SPACE_BEFORE_DATE, ERROR) \
-	FUNC(MISSING_SPACE_BEFORE_EMAIL, ERROR) \
-	FUNC(MISSING_TAG, ERROR) \
-	FUNC(MISSING_TAG_ENTRY, ERROR) \
-	FUNC(MISSING_TREE, ERROR) \
-	FUNC(MISSING_TYPE, ERROR) \
-	FUNC(MISSING_TYPE_ENTRY, ERROR) \
-	FUNC(MULTIPLE_AUTHORS, ERROR) \
-	FUNC(PACKED_REF_ENTRY_NOT_TERMINATED, ERROR) \
-	FUNC(PACKED_REF_UNSORTED, ERROR) \
-	FUNC(TREE_NOT_SORTED, ERROR) \
-	FUNC(UNKNOWN_TYPE, ERROR) \
-	FUNC(ZERO_PADDED_DATE, ERROR) \
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
-	/* warnings */ \
-	FUNC(EMPTY_NAME, WARN) \
-	FUNC(FULL_PATHNAME, WARN) \
-	FUNC(HAS_DOT, WARN) \
-	FUNC(HAS_DOTDOT, WARN) \
-	FUNC(HAS_DOTGIT, WARN) \
-	FUNC(NULL_SHA1, WARN) \
-	FUNC(ZERO_PADDED_FILEMODE, WARN) \
-	FUNC(NUL_IN_COMMIT, WARN) \
-	FUNC(LARGE_PATHNAME, WARN) \
+#define FOREACH_FSCK_MSG_ID(FUNC)                                  \
+	/* fatal errors */                                         \
+	FUNC(NUL_IN_HEADER, FATAL)                                 \
+	FUNC(UNTERMINATED_HEADER, FATAL)                           \
+	/* errors */                                               \
+	FUNC(BAD_DATE, ERROR)                                      \
+	FUNC(BAD_DATE_OVERFLOW, ERROR)                             \
+	FUNC(BAD_EMAIL, ERROR)                                     \
+	FUNC(BAD_NAME, ERROR)                                      \
+	FUNC(BAD_OBJECT_SHA1, ERROR)                               \
+	FUNC(BAD_PACKED_REF_ENTRY, ERROR)                          \
+	FUNC(BAD_PACKED_REF_HEADER, ERROR)                         \
+	FUNC(BAD_PARENT_SHA1, ERROR)                               \
+	FUNC(BAD_REFERENT_NAME, ERROR)                             \
+	FUNC(BAD_REF_CONTENT, ERROR)                               \
+	FUNC(BAD_REF_FILETYPE, ERROR)                              \
+	FUNC(BAD_REF_NAME, ERROR)                                  \
+	FUNC(BAD_TIMEZONE, ERROR)                                  \
+	FUNC(BAD_TREE, ERROR)                                      \
+	FUNC(BAD_TREE_SHA1, ERROR)                                 \
+	FUNC(BAD_TYPE, ERROR)                                      \
+	FUNC(DUPLICATE_ENTRIES, ERROR)                             \
+	FUNC(GITATTRIBUTES_BLOB, ERROR)                            \
+	FUNC(GITATTRIBUTES_LARGE, ERROR)                           \
+	FUNC(GITATTRIBUTES_LINE_LENGTH, ERROR)                     \
+	FUNC(GITATTRIBUTES_MISSING, ERROR)                         \
+	FUNC(GITMODULES_BLOB, ERROR)                               \
+	FUNC(GITMODULES_LARGE, ERROR)                              \
+	FUNC(GITMODULES_MISSING, ERROR)                            \
+	FUNC(GITMODULES_NAME, ERROR)                               \
+	FUNC(GITMODULES_PATH, ERROR)                               \
+	FUNC(GITMODULES_SYMLINK, ERROR)                            \
+	FUNC(GITMODULES_UPDATE, ERROR)                             \
+	FUNC(GITMODULES_URL, ERROR)                                \
+	FUNC(MISSING_AUTHOR, ERROR)                                \
+	FUNC(MISSING_COMMITTER, ERROR)                             \
+	FUNC(MISSING_EMAIL, ERROR)                                 \
+	FUNC(MISSING_NAME_BEFORE_EMAIL, ERROR)                     \
+	FUNC(MISSING_OBJECT, ERROR)                                \
+	FUNC(MISSING_SPACE_BEFORE_DATE, ERROR)                     \
+	FUNC(MISSING_SPACE_BEFORE_EMAIL, ERROR)                    \
+	FUNC(MISSING_TAG, ERROR)                                   \
+	FUNC(MISSING_TAG_ENTRY, ERROR)                             \
+	FUNC(MISSING_TREE, ERROR)                                  \
+	FUNC(MISSING_TYPE, ERROR)                                  \
+	FUNC(MISSING_TYPE_ENTRY, ERROR)                            \
+	FUNC(MULTIPLE_AUTHORS, ERROR)                              \
+	FUNC(PACKED_REF_ENTRY_NOT_TERMINATED, ERROR)               \
+	FUNC(PACKED_REF_UNSORTED, ERROR)                           \
+	FUNC(TREE_NOT_SORTED, ERROR)                               \
+	FUNC(UNKNOWN_TYPE, ERROR)                                  \
+	FUNC(ZERO_PADDED_DATE, ERROR)                              \
+	/* warnings */                                             \
+	FUNC(EMPTY_NAME, WARN)                                     \
+	FUNC(FULL_PATHNAME, WARN)                                  \
+	FUNC(HAS_DOT, WARN)                                        \
+	FUNC(HAS_DOTDOT, WARN)                                     \
+	FUNC(HAS_DOTGIT, WARN)                                     \
+	FUNC(LARGE_PATHNAME, WARN)                                 \
+	FUNC(NULL_SHA1, WARN)                                      \
+	FUNC(NUL_IN_COMMIT, WARN)                                  \
+	FUNC(ZERO_PADDED_FILEMODE, WARN)                           \
 	/* infos (reported as warnings, but ignored by default) */ \
-	FUNC(BAD_FILEMODE, INFO) \
-	FUNC(EMPTY_PACKED_REFS_FILE, INFO) \
-	FUNC(GITMODULES_PARSE, INFO) \
-	FUNC(GITIGNORE_SYMLINK, INFO) \
-	FUNC(GITATTRIBUTES_SYMLINK, INFO) \
-	FUNC(MAILMAP_SYMLINK, INFO) \
-	FUNC(BAD_TAG_NAME, INFO) \
-	FUNC(MISSING_TAGGER_ENTRY, INFO) \
-	FUNC(SYMLINK_REF, INFO) \
-	FUNC(REF_MISSING_NEWLINE, INFO) \
-	FUNC(SYMREF_TARGET_IS_NOT_A_REF, INFO) \
-	FUNC(TRAILING_REF_CONTENT, INFO) \
-	/* ignored (elevated when requested) */ \
+	FUNC(BAD_FILEMODE, INFO)                                   \
+	FUNC(BAD_TAG_NAME, INFO)                                   \
+	FUNC(EMPTY_PACKED_REFS_FILE, INFO)                         \
+	FUNC(GITATTRIBUTES_SYMLINK, INFO)                          \
+	FUNC(GITIGNORE_SYMLINK, INFO)                              \
+	FUNC(GITMODULES_PARSE, INFO)                               \
+	FUNC(MAILMAP_SYMLINK, INFO)                                \
+	FUNC(MISSING_TAGGER_ENTRY, INFO)                           \
+	FUNC(REF_MISSING_NEWLINE, INFO)                            \
+	FUNC(SYMLINK_REF, INFO)                                    \
+	FUNC(SYMREF_TARGET_IS_NOT_A_REF, INFO)                     \
+	FUNC(TRAILING_REF_CONTENT, INFO)                           \
+	/* ignored (elevated when requested) */                    \
 	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
 
 #define MSG_ID(id, msg_type) FSCK_MSG_##id,

-- 
2.50.1

