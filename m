Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED45ECDFA1
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 22:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiJYWml (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 18:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiJYWma (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 18:42:30 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B435D7E0D
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 15:42:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p3so11331626pld.10
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 15:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RljBwXtF7Sb8gh1+Zp4MIm8uU1ZGXUTHKwENgJQROtw=;
        b=BrBGcA7bmDl30fBxPZ9l3rJrjpUEA/knvZzsRHwzYadslNFSDp1C8amqwl/y8Mz2Aa
         GdzLgJMcheQeqFH6Aww0nfDMjHuhYnNn+LzhmQfkMfvZc8bVmM4rvzrwwVUhqETBDmv6
         6628OPc87OGRsv/QBGQevE3ml7GeR37iyAIXtr8qQ7z79ApFjDxwoeGY5KY6WfGX2jdl
         jucHZwmBgbv0n0HlsFVMyXgNnWHVNQFSlkbT16kLwNAjrb2hs7+nUu3/Zm6oFDIHf7up
         +P2rzIBjx/kDtFVNtNHLl6bDSLW7xSUHqG1Y2V5JsA2YQBjbQkUdJKYw7SsIvI8LYiZo
         PsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RljBwXtF7Sb8gh1+Zp4MIm8uU1ZGXUTHKwENgJQROtw=;
        b=4ZIqNYrrmG1Q3gwQWlsOOhA7BCD/AWNzoz18Z4rtqzbTgTIuusydyhKeSuzZcbX/pF
         BXw/Iba4xzYKD5b7K1hzGmairEuMAS2nqnjZF6bLBVm88gfi+DNSeZ5wrOMt11wGmBMj
         5JVvNaEs42ncq0KXZ4w+2mWCUdHxUDc7tDOY2XMHpUojaTkGK73kAF4+V5e2USDsYQnn
         TVSC9W4mS0GjdwQd+KaCajbrzhvde9zIzJ7xSvueJtqz2Ry82jxb6tXVT0Pexg+TmBVr
         R/zxSEGYxbBjzp+ZCDIHYaK/j2K6B8MPyMOToxuhhzp4uJ6Drn2uWt5dcxZX9Zd0Uols
         UrjQ==
X-Gm-Message-State: ACrzQf13PFoYMZvuGFEkUBsVpwcCEaIpMTlDU1EI1b5R3BL2HNVsQV3y
        uO1B2BSD6wzFzZ3ZiHNoQvHeqyEDckY=
X-Google-Smtp-Source: AMsMyM4RJJnwLQCyNmwXJ4gljgwZ4w54IK9GVpjk4dulxX+2M04rnwol+xNkUcXWMnpo0BGUf8VoTg==
X-Received: by 2002:a17:902:e843:b0:186:b180:3c3a with SMTP id t3-20020a170902e84300b00186b1803c3amr10232299plg.66.1666737748230;
        Tue, 25 Oct 2022 15:42:28 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902ced100b00186ae540083sm1665107plg.91.2022.10.25.15.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:42:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Subject: [PATCH v3 3/4] fsck: document msg-id
Date:   Tue, 25 Oct 2022 15:42:23 -0700
Message-Id: <20221025224224.2352979-4-gitster@pobox.com>
X-Mailer: git-send-email 2.38.1-359-g84c4c6d5a5
In-Reply-To: <20221025224224.2352979-1-gitster@pobox.com>
References: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
 <20221025224224.2352979-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

The documentation lacks mention of specific <msg-id> that are supported.
While git-help --config will display a list of these options, often
developers' first instinct is to consult the git docs to find valid
config values.

Add a list of fsck error messages, and link to it from the git-fsck
documentation.

Signed-off-by: John Cai <johncai86@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/fsck.txt |   4 +
 Documentation/fsck-msgids.txt | 161 ++++++++++++++++++++++++++++++++++
 Documentation/git-fsck.txt    |  12 +++
 fsck.h                        |   6 ++
 4 files changed, 183 insertions(+)
 create mode 100644 Documentation/fsck-msgids.txt

diff --git a/Documentation/config/fsck.txt b/Documentation/config/fsck.txt
index 450e8c38e3..a3c865df56 100644
--- a/Documentation/config/fsck.txt
+++ b/Documentation/config/fsck.txt
@@ -35,6 +35,10 @@ allow new instances of the same breakages go unnoticed.
 Setting an unknown `fsck.<msg-id>` value will cause fsck to die, but
 doing the same for `receive.fsck.<msg-id>` and `fetch.fsck.<msg-id>`
 will only cause git to warn.
++
+See `Fsck Messages` section of linkgit:git-fsck[1] for supported
+values of `<msg-id>`.
+
 
 fsck.skipList::
 	The path to a list of object names (i.e. one unabbreviated SHA-1 per
diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
new file mode 100644
index 0000000000..7af76ff99a
--- /dev/null
+++ b/Documentation/fsck-msgids.txt
@@ -0,0 +1,161 @@
+`badDate`::
+	(ERROR) Invalid date format in an author/committer line.
+
+`badDateOverflow`::
+	(ERROR) Invalid date value in an author/committer line.
+
+`badEmail`::
+	(ERROR) Invalid email format in an author/committer line.
+
+`badFilemode`::
+	(INFO) A tree contains a bad filemode entry.
+
+`badName`::
+	(ERROR) An author/committer name is empty.
+
+`badObjectSha1`::
+	(ERROR) An object has a bad sha1.
+
+`badParentSha1`::
+	(ERROR) A commit object has a bad parent sha1.
+
+`badTagName`::
+	(INFO) A tag has an invalid format.
+
+`badTimezone`::
+	(ERROR) Found an invalid time zone in an author/committer line.
+
+`badTree`::
+	(ERROR) A tree cannot be parsed.
+
+`badTreeSha1`::
+	(ERROR) A tree has an invalid format.
+
+`badType`::
+	(ERROR) Found an invalid object type.
+
+`duplicateEntries`::
+	(ERROR) A tree contains duplicate file entries.
+
+`emptyName`::
+	(WARN) A path contains an empty name.
+
+`extraHeaderEntry`::
+	(IGNORE) Extra headers found after `tagger`.
+
+`fullPathname`::
+	(WARN) A path contains the full path starting with "/".
+
+`gitattributesSymlink`::
+	(INFO) `.gitattributes` is a symlink.
+
+`gitignoreSymlink`::
+	(INFO) `.gitignore` is a symlink.
+
+`gitmodulesBlob`::
+	(ERROR) A non-blob found at `.gitmodules`.
+
+`gitmodulesLarge`::
+	(ERROR) The `.gitmodules` file is too large to parse.
+
+`gitmodulesMissing`::
+	(ERROR) Unable to read `.gitmodules` blob.
+
+`gitmodulesName`::
+	(ERROR) A submodule name is invalid.
+
+`gitmodulesParse`::
+	(INFO) Could not parse `.gitmodules` blob.
+
+`gitmodulesLarge`;
+	(ERROR) `.gitmodules` blob is too large to parse.
+
+`gitmodulesPath`::
+	(ERROR) `.gitmodules` path is invalid.
+
+`gitmodulesSymlink`::
+	(ERROR) `.gitmodules` is a symlink.
+
+`gitmodulesUpdate`::
+	(ERROR) Found an invalid submodule update setting.
+
+`gitmodulesUrl`::
+	(ERROR) Found an invalid submodule url.
+
+`hasDot`::
+	(WARN) A tree contains an entry named `.`.
+
+`hasDotdot`::
+	(WARN) A tree contains an entry named `..`.
+
+`hasDotgit`::
+	(WARN) A tree contains an entry named `.git`.
+
+`mailmapSymlink`::
+	(INFO) `.mailmap` is a symlink.
+
+`missingAuthor`::
+	(ERROR) Author is missing.
+
+`missingCommitter`::
+	(ERROR) Committer is missing.
+
+`missingEmail`::
+	(ERROR) Email is missing in an author/committer line.
+
+`missingNameBeforeEmail`::
+	(ERROR) Missing name before an email in an author/committer line.
+
+`missingObject`::
+	(ERROR) Missing `object` line in tag object.
+
+`missingSpaceBeforeDate`::
+	(ERROR) Missing space before date in an author/committer line.
+
+`missingSpaceBeforeEmail`::
+	(ERROR) Missing space before the email in author/committer line.
+
+`missingTag`::
+	(ERROR) Unexpected end after `type` line in a tag object.
+
+`missingTagEntry`::
+	(ERROR) Missing `tag` line in a tag object.
+
+`missingTaggerEntry`::
+	(INFO) Missing `tagger` line in a tag object.
+
+`missingTree`::
+	(ERROR) Missing `tree` line in a commit object.
+
+`missingType`::
+	(ERROR) Invalid type value on the `type` line in a tag object.
+
+`missingTypeEntry`::
+	(ERROR) Missing `type` line in a tag object.
+
+`multipleAuthors`::
+	(ERROR) Multiple author lines found in a commit.
+
+`nulInCommit`::
+	(WARN) Found a NUL byte in the commit object body.
+
+`nulInHeader`::
+	(FATAL) NUL byte exists in the object header.
+
+`nullSha1`::
+	(WARN) Tree contains entries pointing to a null sha1.
+
+`treeNotSorted`::
+	(ERROR) A tree is not properly sorted.
+
+`unknownType`::
+	(ERROR) Found an unknown object type.
+
+`unterminatedHeader`::
+	(FATAL) Missing end-of-line in the object header.
+
+`zeroPaddedDate`::
+	(ERROR) Found a zero padded date in an author/commiter line.
+
+`zeroPaddedFilemode`::
+	(WARN) Found a zero padded filemode in a tree.
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 29318ea957..b6a0f8a085 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -152,6 +152,18 @@ hash mismatch <object>::
 	object database value.
 	This indicates a serious data integrity problem.
 
+
+FSCK MESSAGES
+-------------
+
+The following lists the types of errors `git fsck` detects and what
+each error means, with their default severity.  The severity of the
+error, other than those that are marked as "(FATAL)", can be tweaked
+by setting the corresponding `fsck.<msg-id>` configuration variable.
+
+include::fsck-msgids.txt[]
+
+
 Environment Variables
 ---------------------
 
diff --git a/fsck.h b/fsck.h
index 1d7c38f268..6fbce68ad6 100644
--- a/fsck.h
+++ b/fsck.h
@@ -13,6 +13,12 @@ enum fsck_msg_type {
 	FSCK_WARN,
 };
 
+/*
+ * Documentation/fsck-msgids.txt documents these; when
+ * modifying this list in any way, make sure to keep the
+ * two in sync.
+ */
+
 #define FOREACH_FSCK_MSG_ID(FUNC) \
 	/* fatal errors */ \
 	FUNC(NUL_IN_HEADER, FATAL) \
-- 
2.38.1-359-g84c4c6d5a5

