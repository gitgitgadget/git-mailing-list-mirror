Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC311B969
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710602509; cv=none; b=BbKgky2ScDvCPVDT9JiR8zXzVjTCuHzrBYDNKT/AJeClLS55dBfFYoisCEE+01PJdeYcrsa2haoLvv+2IJPpXh8KuUAkzA2OBDBFLMnypDR+ucFvKF7L6fO9/Dca2p0MWHk4bHr2UJ0Ukl8SX83ueDeS1f8P1GUfZhq5XIgvCTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710602509; c=relaxed/simple;
	bh=41E4QcbIMCNqjbCbA/9iAzSoRB+C3SSxAwSBTWl97l8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=OGNs78nOCWvG+aAwO1oqbwpYgHjp0hB2maeGGkVVpKoCZe+eX3g4oByBlRT170+2WibaOQf4FCMZuBfgsH+Z8A9hC9C3dSsMGWFwzSR/hSYXfPOml03+o5wuVfOlPjRnfNYQoMvfFRMxQS5oww1yuq6GFsKqWBYu8Pma6XFTE10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEQ7PJVx; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEQ7PJVx"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34005b5927eso215781f8f.1
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 08:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710602505; x=1711207305; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHIJpNsetkU4Br0nlen2fLFiPkq+drfSjghprHfFI5Y=;
        b=gEQ7PJVxgfkoIor73nsMFjdVMZI+qcoAZxWlegFYPDUyi4kBjCMw5snRWCsKmAGQZ8
         lL6YKRjzYjo4DohmtDlwvlRu5R6b3+b4VET+GUgrrkxSWfXIGhkp2BwNwGtm569hh9By
         Dc9kMKwNwXrOe6A1uB+e1ILkTdZVxC48PnIeRqUH3lgXNp1yHXVrc2ZPvDljp/iz8g2o
         03PQjSEDJMq6QjGydcKDKyX6gs/0Iu2pgDypUjedEQiIWsuQjyaXX7HuVx+xb0l9spaO
         uJQFLXpeSfdpf2Q/L+rk93lPBcH+L9lO680PYbEn5I5ZfmAGxepG2aRzsdGRQePFvp8r
         VgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710602505; x=1711207305;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHIJpNsetkU4Br0nlen2fLFiPkq+drfSjghprHfFI5Y=;
        b=Y20qyk9Oy+VpgWrfMZOzdmSJkOxECu+Apflk3IHNqi2Xz+9hpvIRsVPX2rUsoc/LZ3
         GQOr/GgzzArmKuBZlA+REM+a438AlEfiHE3ScxIPm12LiLQ7ufNPekIRxyzA5rqHL3xA
         ZPrNTfJNBL/d0flF/SPNCgUMJ3eKJS3zT2BlGe62/mtZ4DWfYTwYf1FguiOhvnT/pzMO
         hbqLnDn1K7x/n5qDPlSkAyhi7lgMmlOQYkN40R6IuGyDlcc0Z6lJSsDzH+6Kgjhu9xX2
         w403NvXg23oXE8VGXqGfZSwWHYARsHnGeKcQlx7yg2kcZR84FIrlSlw3S6spnEWPIUeU
         oOrA==
X-Gm-Message-State: AOJu0Yzr1L+bW9Bp+P/fX/Lltdb3yGLTRYMlMqfvZ9+u8c5PfQg5Kp/n
	XiG374mKRJrwD5ye627CnNWfgdwsZeBib4SUyHArqhKNtbYvcablaPwVUYCm
X-Google-Smtp-Source: AGHT+IG3GLdlnmNPgI/7MPSV1QeGUM/FtLkyLiw8zWafA1LFYKMlRtbtblsu8S/hn2F9Od25pBE1Qg==
X-Received: by 2002:adf:f20f:0:b0:33e:c0db:441 with SMTP id p15-20020adff20f000000b0033ec0db0441mr5929106wro.7.1710602505467;
        Sat, 16 Mar 2024 08:21:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6-20020adff206000000b0033cf5094fcesm5615644wro.36.2024.03.16.08.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 08:21:43 -0700 (PDT)
Message-ID: <6f4e68170391cc123f77a2994f13cfb6e1c3dce3.1710602501.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1697.git.1710602501.gitgitgadget@gmail.com>
References: <pull.1697.git.1710602501.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 Mar 2024 15:21:41 +0000
Subject: [PATCH 2/2] doc: fix some placeholders formating
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-interpret-trailers.txt | 6 +++---
 Documentation/git.txt                    | 2 +-
 Documentation/rev-list-options.txt       | 6 +++---
 builtin/interpret-trailers.c             | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 418265f044d..d9dfb75fef5 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git interpret-trailers' [--in-place] [--trim-empty]
-			[(--trailer (<key>|<keyAlias>)[(=|:)<value>])...]
+			[(--trailer (<key>|<key-alias>)[(=|:)<value>])...]
 			[--parse] [<file>...]
 
 DESCRIPTION
@@ -67,9 +67,9 @@ key: value
 This means that the trimmed <key> and <value> will be separated by
 `': '` (one colon followed by one space).
 
-For convenience, a <keyAlias> can be configured to make using `--trailer`
+For convenience, a <key-alias> can be configured to make using `--trailer`
 shorter to type on the command line. This can be configured using the
-'trailer.<keyAlias>.key' configuration variable. The <keyAlias> must be a prefix
+'trailer.<key-alias>.key' configuration variable. The <keyAlias> must be a prefix
 of the full <key> string, although case sensitivity does not matter. For
 example, if you have
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index e6b766d5c3a..7a1b112a3e7 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -960,7 +960,7 @@ will never be returned from the commit-graph at the cost of performance.
 `GIT_PROTOCOL`::
 	For internal use only.  Used in handshaking the wire protocol.
 	Contains a colon ':' separated list of keys with optional values
-	'key[=value]'.  Presence of unknown keys and values must be
+	'<key>[=<value>]'.  Presence of unknown keys and values must be
 	ignored.
 +
 Note that servers may need to be configured to allow this variable to
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 408d9314d08..00ccf687441 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -316,12 +316,12 @@ list.
 With `--pretty` format other than `oneline` and `reference` (for obvious reasons),
 this causes the output to have two extra lines of information
 taken from the reflog.  The reflog designator in the output may be shown
-as `ref@{Nth}` (where `Nth` is the reverse-chronological index in the
-reflog) or as `ref@{timestamp}` (with the timestamp for that entry),
+as `ref@{<Nth>}` (where _<Nth>_ is the reverse-chronological index in the
+reflog) or as `ref@{<timestamp>}` (with the _<timestamp>_ for that entry),
 depending on a few rules:
 +
 --
-1. If the starting point is specified as `ref@{Nth}`, show the index
+1. If the starting point is specified as `ref@{<Nth>}`, show the index
    format.
 +
 2. If the starting point was specified as `ref@{now}`, show the
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 11f4ce9e4a2..8768bfea3c4 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -15,7 +15,7 @@
 
 static const char * const git_interpret_trailers_usage[] = {
 	N_("git interpret-trailers [--in-place] [--trim-empty]\n"
-	   "                       [(--trailer (<key>|<keyAlias>)[(=|:)<value>])...]\n"
+	   "                       [(--trailer (<key>|<key-alias>)[(=|:)<value>])...]\n"
 	   "                       [--parse] [<file>...]"),
 	NULL
 };
-- 
gitgitgadget
