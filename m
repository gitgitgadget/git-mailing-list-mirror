Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269FBC38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 03:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiJYDRz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 23:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiJYDRt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 23:17:49 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC77987FAA
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 20:17:48 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v11so7522181wmd.1
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 20:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXAbPnpG9/e7RPm2f7J+QrCtJK4rPtZwk5sbBdfnomw=;
        b=ietbcc+MfDeezRVo68ZaNABwSELBeMLO7QRFojt0GTcphfdLApjkXt4chP0JqQSM3V
         H8gthk6Zqc0g+n33Hq6r7Sh/BovWD5Io7FwMoc2YpjQFFAmTgmt8j6WSq+h4HecVlTem
         5qdgTxqEz6SLZG4etJ4ZmYhtH8kL3ciXsyUCpGUD9ElOjt2OaY9yiVyCEJPQgSibEsqI
         h395kdPLDJ52619MfAboh4J9+WUpdGY80Q2drEOVZsum8SgWAXajAht8F8LtJlBw40YQ
         mkVXEdtlTXbtkbC/h6tewDyi5GcXvQMSnF2vpWhokbdb9XWtj7Mg4sjukMYsssKcABAU
         tkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXAbPnpG9/e7RPm2f7J+QrCtJK4rPtZwk5sbBdfnomw=;
        b=tnPkGNdNx1ywdUdWLfuNfUCz1mrGsdaeJMos/fi9u5YJ8diLUpuLNUcAqVP8S9TpKk
         Wtpflegiz5VNUSXKryEjjCF2m/W3t82n8UJ/JClHSQ3udF/NclSRw2UndzBp4u4/fMPT
         VgmUoP0sxd6/pnA3ib4gHs2wjrUC5M7sznL8YGOrPcpVzduY1WXqhWdqdZQolsq8Wmfp
         S1QSdmw1n4qbT9x9S894MNMpfas+2Ax8gj9g2tYmBEhn8ssdiOwCtBaFXBjczt4yMG4J
         fZ615cphGFTre0hsaX8Qj7pVunEVzqNMujtVKLNtCfXDwNEunGkdhT+5jYw/fHOjAxzD
         9/sQ==
X-Gm-Message-State: ACrzQf2B45Dd0OMEOb+aP6hayGzKKB2/+ofYy5XrXPmoH0jUWcyVoDgV
        r+BaIWN/L+yh0z699r970bEnSd5tO6o=
X-Google-Smtp-Source: AMsMyM4J+rFRzZKSJX+1Dy0l7EnYTO+oEmzQpnzb/w2vDrf8H1F0v3xZQ3fkR6idFPjfJUgO2/+q7A==
X-Received: by 2002:a05:600c:88a:b0:3c6:cc34:abf with SMTP id l10-20020a05600c088a00b003c6cc340abfmr43226681wmp.147.1666667867182;
        Mon, 24 Oct 2022 20:17:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h6-20020adfa4c6000000b002206203ed3dsm1265319wrb.29.2022.10.24.20.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 20:17:46 -0700 (PDT)
Message-Id: <ad43adab435e9fadd7b896928e234a38c9bb16a6.1666667864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
References: <pull.1369.git.git.1666623639.gitgitgadget@gmail.com>
        <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Oct 2022 03:17:44 +0000
Subject: [PATCH v2 2/2] fsck: document msg-id
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
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
Helped-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/fsck.txt |   4 +
 Documentation/fsck-msgids.txt | 149 ++++++++++++++++++++++++++++++++++
 Documentation/git-fsck.txt    |  12 +++
 fsck.h                        |   6 ++
 4 files changed, 171 insertions(+)
 create mode 100644 Documentation/fsck-msgids.txt

diff --git a/Documentation/config/fsck.txt b/Documentation/config/fsck.txt
index 450e8c38e34..a3c865df567 100644
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
index 00000000000..08e19bac8ad
--- /dev/null
+++ b/Documentation/fsck-msgids.txt
@@ -0,0 +1,149 @@
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
+`fullPathName`::
+	(WARN) A path contains the full path starting with "/".
+
+`gitAttributesSymlink`::
+	(INFO) `.gitattributes` is a symlink.
+
+`gitignoreSymlink`::
+	(INFO) `.gitignore` is a symlink.
+
+`gitmodulesBlob`::
+	(ERROR) A non-blob found at `.gitmodules`.
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
+`nulInSha1`::
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
+`zeroPaddingDate`::
+	(ERROR) Found a zero padded date in an author/commiter line.
+
+`zeroPaddedFilemode`::
+	(WARN) Found a zero padded filemode in a tree.
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 29318ea957e..b6a0f8a085c 100644
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
index 7d99f6ea337..8355fd4c8f5 100644
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
gitgitgadget
