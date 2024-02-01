Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45630442A
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 01:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706751490; cv=none; b=dcOYU0Kscg0aW42XonFs8jPLCNjB37gwlQaOnq72r2FtSmCiJUFG5lu46LF/Kq8zfiaa7KQEfpjyhbO02C7pKBuftq9oD+gSRVGyiLOJTJGmB2kGKBnpQgqNxHEWuID5JAjWrg9P/Pm1QrtG8t3IOULlejCTZwAGr+OsrOciYOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706751490; c=relaxed/simple;
	bh=6f3ymxW7go7bTXLUj3ASGa9fCnHupGQjdk3TttkOwqI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mh+0F7yJ0c2uyIQj66IqRoxagsDeZCc0NHOD0WozhHv5Xr34kDeV0hSU8iUAD/dVCKkmwpKsSAaymauhj4r4CxES/ybXezSebkJsqhrCAnZoOoDeCT+lnmP07zCpCNs5sv2nZRu3qyoybrdT6F81YHQwXN8fH+Ba2fZjJhsoPI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZCc0hmw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZCc0hmw"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so3782855e9.1
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 17:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706751486; x=1707356286; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xVEioQQprtkdsv60zjjAfM3AVj5k/Vci4ZMkyUX2is=;
        b=EZCc0hmwC82hAyhqRcf55bhc96fV0UEj4E1GY1oEKc8T1BZJUpmAG182vdfPp8OMZi
         rmCGz9ghxgDZHuFEBzrslfvYaeXClJDQBX0t2Cg7t4HtfndXgXBV5gWFbYyA7s7SFdkd
         GRn74LFqH5tvQYIRXhaJUVxNOGgtFQsimerIyQf77UsSfaN8AGCEGq0d67HOqPowry4I
         NNwUkXlq0Wnv71lEsT8i4SBS8wDl+MiKMAZlYvFue4mcV6t/Co09iGiHziC8VVuQ1kUv
         JlZXyI39WWtNJd0CF88lvWwKdB1TA0RXDvz4+4tNMerfjIMaYRaqlBarEqoG0BLGgsTB
         oE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706751486; x=1707356286;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xVEioQQprtkdsv60zjjAfM3AVj5k/Vci4ZMkyUX2is=;
        b=djh+lKSol78iLrQk7jVl61ObFN4eTLtnr9StvWJ9XnGcxAzHoDbbnNukM7/zgqI6sH
         KP710rqZqdc/Gs10VUVbo3Drmpl9OUuiRj03dxsPn53kdYkhxCXPh5ED/Yrrt6/r3Xm4
         wTzNvR1T7SDrpocP+iN1uLRSjOpcbPmG21kwz5P/0ewLIVp6uoD3HRlR7+4zhtBmP4ha
         auz4JSbOvTo9naUvl1L1S+h+oWjaNXHCafqWdTteaOz83cr2W2DaBH483IaIKXmhLRHR
         W93jZ9YGi9Qpa+5XHC3iZj9JvglT8VuYcSx6ITzUlmquYIdezHohspReiRckt8mv9yNM
         XCuw==
X-Gm-Message-State: AOJu0YwSgiI69wfVlQsgEZRx++gVCKTyfultH25sScpeNEpyZYTL1ALp
	dOSEgM2jdCr/4gNrUVB/zR7BePy8tqJnATo4wMHDQ9lxIxbK+KAl6lryKpsc
X-Google-Smtp-Source: AGHT+IHBxJxuHyQJbqNPiic1qVmu32v2N6q6xTw2y8ATkW9DZ3fZjLt4yNOXo/QU1Y0KWTRPtOXYBQ==
X-Received: by 2002:a05:600c:3b96:b0:40e:b17d:2f56 with SMTP id n22-20020a05600c3b9600b0040eb17d2f56mr2249588wms.23.1706751485824;
        Wed, 31 Jan 2024 17:38:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWUq0hLBfvqqZguxkQQdDgCm3jf9sfRDPSG1KUdh3XgzMXxhBUNSVOnS3ji36znBZSpMXxkfurt3yw3mhQnGvThWCEVFSeRqRJOHDJ1wEY=
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c3-20020a05600c0a4300b0040e541ddcb1sm2971510wmq.33.2024.01.31.17.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 17:38:05 -0800 (PST)
Message-ID: <f29ab9136fb4c23c5700a73731a5e220f92b7c30.1706751483.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1658.v4.git.git.1706751483.gitgitgadget@gmail.com>
References: <pull.1658.v3.git.git.1706302749.gitgitgadget@gmail.com>
	<pull.1658.v4.git.git.1706751483.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 01 Feb 2024 01:38:02 +0000
Subject: [PATCH v4 2/2] index-pack: --fsck-objects to take an optional
 argument for fsck msgs
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

git-index-pack has a --strict option that can take an optional argument
to provide a list of fsck issues to change their severity.
--fsck-objects does not have such a utility, which would be useful if
one would like to be more lenient or strict on data integrity in a
repository.

Like --strict, allow --fsck-objects to also take a list of fsck msgs to
change the severity.

Remove the "For internal use only" note for --fsck-objects, and document
the option. This won't often be used by the normal end user, but it
turns out it is useful for Git forges like GitLab.

Reviewed-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/git-index-pack.txt | 17 +++++++++++------
 builtin/index-pack.c             |  5 +++--
 t/t5300-pack-object.sh           | 29 ++++++++++++++++++++++++-----
 3 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 694bb9409bf..5a20deefd5f 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -96,13 +96,18 @@ default and "Indexing objects" when `--stdin` is specified.
 --check-self-contained-and-connected::
 	Die if the pack contains broken links. For internal use only.
 
---fsck-objects::
-	For internal use only.
+--fsck-objects[=<msg-id>=<severity>...]::
+	Die if the pack contains broken objects, but unlike `--strict`, don't
+	choke on broken links. If the pack contains a tree pointing to a
+	.gitmodules blob that does not exist, prints the hash of that blob
+	(for the caller to check) after the hash that goes into the name of the
+	pack/idx file (see "Notes").
 +
-Die if the pack contains broken objects. If the pack contains a tree
-pointing to a .gitmodules blob that does not exist, prints the hash of
-that blob (for the caller to check) after the hash that goes into the
-name of the pack/idx file (see "Notes").
+An optional comma-separated list of `<msg-id>=<severity>` can be passed to
+change the severity of some possible issues, e.g.,
+`--fsck-objects="missingEmail=ignore,badTagName=ignore"`. See the entry for the
+`fsck.<msg-id>` configuration options in linkgit:git-fsck[1] for more
+information on the possible values of `<msg-id>` and `<severity>`.
 
 --threads=<n>::
 	Specifies the number of threads to spawn when resolving
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 240c7021168..a3a37bd215d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -24,7 +24,7 @@
 #include "setup.h"
 
 static const char index_pack_usage[] =
-"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-id>=<severity>...]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
+"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-id>=<severity>...]] [--fsck-objects[=<msg-id>=<severity>...]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
 
 struct object_entry {
 	struct pack_idx_entry idx;
@@ -1785,8 +1785,9 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 			} else if (!strcmp(arg, "--check-self-contained-and-connected")) {
 				strict = 1;
 				check_self_contained_and_connected = 1;
-			} else if (!strcmp(arg, "--fsck-objects")) {
+			} else if (skip_to_optional_arg(arg, "--fsck-objects", &arg)) {
 				do_fsck_object = 1;
+				fsck_set_msg_types(&fsck_options, arg);
 			} else if (!strcmp(arg, "--verify")) {
 				verify = 1;
 			} else if (!strcmp(arg, "--verify-stat")) {
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 496fffa0f8a..a58f91035d1 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -441,8 +441,7 @@ test_expect_success 'index-pack with --strict' '
 	)
 '
 
-test_expect_success 'index-pack with --strict downgrading fsck msgs' '
-	test_when_finished rm -rf strict &&
+test_expect_success 'setup for --strict and --fsck-objects downgrading fsck msgs' '
 	git init strict &&
 	(
 		cd strict &&
@@ -457,12 +456,32 @@ test_expect_success 'index-pack with --strict downgrading fsck msgs' '
 
 		EOF
 		git hash-object --literally -t commit -w --stdin <commit >commit_list &&
-		PACK=$(git pack-objects test <commit_list) &&
-		test_must_fail git index-pack --strict "test-$PACK.pack" &&
-		git index-pack --strict="missingEmail=ignore" "test-$PACK.pack"
+		git pack-objects test <commit_list >pack-name
 	)
 '
 
+test_with_bad_commit () {
+	must_fail_arg="$1" &&
+	must_pass_arg="$2" &&
+	(
+		cd strict &&
+		test_expect_fail git index-pack "$must_fail_arg" "test-$(cat pack-name).pack"
+		git index-pack "$must_pass_arg" "test-$(cat pack-name).pack"
+	)
+}
+
+test_expect_success 'index-pack with --strict downgrading fsck msgs' '
+	test_with_bad_commit --strict --strict="missingEmail=ignore"
+'
+
+test_expect_success 'index-pack with --fsck-objects downgrading fsck msgs' '
+	test_with_bad_commit --fsck-objects --fsck-objects="missingEmail=ignore"
+'
+
+test_expect_success 'cleanup for --strict and --fsck-objects downgrading fsck msgs' '
+	rm -rf strict
+'
+
 test_expect_success 'honor pack.packSizeLimit' '
 	git config pack.packSizeLimit 3m &&
 	packname_10=$(git pack-objects test-10 <obj-list) &&
-- 
gitgitgadget
