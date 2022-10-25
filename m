Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1382FC67871
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 03:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiJYDRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 23:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiJYDRs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 23:17:48 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D4B264AF
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 20:17:47 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so7638772wmb.3
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 20:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0N7CCM5MGTQ8cfs9f997k0J8XvlrH85K6A2p12DiZo=;
        b=OcxO5mmdkHH+8zyKYE2HWXwiOO/Etb7I9cTQPeuiHgYYIU61GSPxlDZRRWJ2+8G5/F
         YiQHmwNYYGui5Zwcu529qdYk6K7+KCy0qu5+BCZ5O5D8L/pzTOBPts3LrxCVpToUwRdg
         9uh1n+lASZrrsp7a81M6PllQdgB0Wo5sGH8NCjZbVrZfac1hhowyaKKdUYvbn4P9cmHL
         ZOw8294CdzfhauSefhSq6Xrpgv0wFgWgP0S8RYtsWYn+kyYuLxLuR2snleHCCrBRr46r
         CyJi5CKEK8HXFQcsUiZZ6QJnYSNzTeilK8x7cpOybC0/QmUY7xmA0fiwPzgE28rbZSLb
         nlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0N7CCM5MGTQ8cfs9f997k0J8XvlrH85K6A2p12DiZo=;
        b=rH2joxxg5AoGDVE39zxIiPm1Q9Rlw4FZ9wLAkmbBo7fl+q1E2DbwVk54LLNr5xRqXY
         ZQOkbunAd6fngbbWf1VU62lkGVLwCjxk2x3obzx1/Xfr8BRcW4prkPDRvNfxsv2oJc0X
         /QCzdtoO+XXBowjQOhwP4YAxKZYWEdxeKo5/8scypRU1Ws+FvJXeTOEeoWQAAkhi7qbO
         kD0UHRN78i3JOl8Qby+sSC4h6SyvVUV8Zw7zOt8nCMek0PbeWuSvGQI5LfwqF9NvgzQk
         /VdE/obnlibnHId7BZsx+wvxwqbyVXER+jOGEEuXDKZZdkSq1GOI07hJvOtqDZduItx9
         dfqQ==
X-Gm-Message-State: ACrzQf0PcsTTeu648TS4IW9M19M/1g7dVC1KbmFG6Cu86MZR2kyf9VAu
        ZM/zaEunAwY4vlKHAViP5RGHhD3su+o=
X-Google-Smtp-Source: AMsMyM6DFY7olNCVAcStCERHxdeXvBbtLSGLGy3aXgQN4D85xpLQeQbp6MH78chNmxIGITEjCbtOtA==
X-Received: by 2002:a05:600c:4187:b0:3c6:fe18:b2a with SMTP id p7-20020a05600c418700b003c6fe180b2amr24749066wmh.41.1666667865374;
        Mon, 24 Oct 2022 20:17:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r29-20020adfa15d000000b002365f326037sm1465411wrr.63.2022.10.24.20.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 20:17:45 -0700 (PDT)
Message-Id: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
In-Reply-To: <pull.1369.git.git.1666623639.gitgitgadget@gmail.com>
References: <pull.1369.git.git.1666623639.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Oct 2022 03:17:42 +0000
Subject: [PATCH v2 0/2] Document fsck msg ids
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fsck does a number of checks, and prints warning or error messages based on
the type of check. The only place the config values that control whether to
ignore these checks are documented is through git-help(1). However, often
times peoples' first instinct to look for a list of valid config values is
in the documentation page for git-config(1). These fsck. configuration
values can be hard to find.

Document these so that both git-config and git-fsck documentation has a list
of valid s.

Patch [1/2] removes an unused msg-id BAD_TAG_OBJECT Patch [2/2] adds a
fsck-msgids.txt that lists msg-ids that fsck checks for

Since v1:

 * provided a full list of error messages along with corresponding default
   severity
 * no longer including the whole list in git-config
 * add a comment in fsck.h to remind developers to keep the documentation
   accurate when making changes to the list of error messages

John Cai (2):
  fsck: remove the unused BAD_TAG_OBJECT
  fsck: document msg-id

 Documentation/config/fsck.txt |   4 +
 Documentation/fsck-msgids.txt | 149 ++++++++++++++++++++++++++++++++++
 Documentation/git-fsck.txt    |  12 +++
 fsck.h                        |   7 +-
 4 files changed, 171 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/fsck-msgids.txt


base-commit: 45c9f05c44b1cb6bd2d6cb95a22cf5e3d21d5b63
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1369%2Fjohn-cai%2Fjc%2Fdocument-fsck-msg-id-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1369/john-cai/jc/document-fsck-msg-id-v2
Pull-Request: https://github.com/git/git/pull/1369

Range-diff vs v1:

 1:  f32ff5dc4ee ! 1:  797c6251671 fsck: remove the unused BAD_TAG_OBJECT
     @@ Metadata
       ## Commit message ##
          fsck: remove the unused BAD_TAG_OBJECT
      
     -    The BAD_TAG_OBJECT msg-id is not being used anymore, so we can remove
     -    it.
     +    2175a0c6 (fsck: stop checking tag->tagged, 2019-10-18) stopped
     +    checking the tagged object referred to by a tag object, which is what the
     +    error message BAD_TAG_OBJECT was for. Since then the BAD_TAG_OBJECT
     +    message is no longer used anywhere.
     +
     +    Remove the BAD_TAG_OBJECT msg-id.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
     +    Reviewed-by: Junio C Hamano <gitster@pobox.com>
      
       ## fsck.h ##
      @@ fsck.h: enum fsck_msg_type {
 2:  3aec3d2c9ca ! 2:  ad43adab435 fsck: document msg-id
     @@ Metadata
       ## Commit message ##
          fsck: document msg-id
      
     -    The git-config documentation lacks mention of specific <msg-id> that
     -    are supported. While git-help --config will display a list of these options,
     -    often developers' first instinct is to consult the git docs to find valid
     +    The documentation lacks mention of specific <msg-id> that are supported.
     +    While git-help --config will display a list of these options, often
     +    developers' first instinct is to consult the git docs to find valid
          config values.
      
     -    Add a section under the docs for fsck.<msg-id> with the msg-ids that
     -    git-fsck recognizes.
     +    Add a list of fsck error messages, and link to it from the git-fsck
     +    documentation.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
      
       ## Documentation/config/fsck.txt ##
      @@ Documentation/config/fsck.txt: allow new instances of the same breakages go unnoticed.
     @@ Documentation/config/fsck.txt: allow new instances of the same breakages go unno
       doing the same for `receive.fsck.<msg-id>` and `fetch.fsck.<msg-id>`
       will only cause git to warn.
      ++
     -+The following `<msg-id>` are supported:
     -++
     ++See `Fsck Messages` section of linkgit:git-fsck[1] for supported
     ++values of `<msg-id>`.
      +
     -+include::../fsck-msgids.txt[]
       
       fsck.skipList::
       	The path to a list of object names (i.e. one unabbreviated SHA-1 per
      
       ## Documentation/fsck-msgids.txt (new) ##
      @@
     -+--
     -+`badDate`;;
     -+	Invalid date format in an author/committer line.
     ++`badDate`::
     ++	(ERROR) Invalid date format in an author/committer line.
     ++
     ++`badDateOverflow`::
     ++	(ERROR) Invalid date value in an author/committer line.
     ++
     ++`badEmail`::
     ++	(ERROR) Invalid email format in an author/committer line.
      +
     -+`badEmail`;;
     -+	Invalid email format in an author/committer line.
     ++`badFilemode`::
     ++	(INFO) A tree contains a bad filemode entry.
      +
     -+`badFilemode`;;
     -+	A tree contains a bad filemode entry.
     ++`badName`::
     ++	(ERROR) An author/committer name is empty.
      +
     -+`badName`;;
     -+	An author/committer name is empty.
     ++`badObjectSha1`::
     ++	(ERROR) An object has a bad sha1.
      +
     -+`badObjectSha1`;;
     -+	An object has a bad sha1.
     ++`badParentSha1`::
     ++	(ERROR) A commit object has a bad parent sha1.
      +
     -+`badParentSha1`;;
     -+	A commit object has a bad parent sha1.
     ++`badTagName`::
     ++	(INFO) A tag has an invalid format.
      +
     -+`badTagName`;;
     -+	A tag has an invalid format.
     ++`badTimezone`::
     ++	(ERROR) Found an invalid time zone in an author/committer line.
      +
     -+`badTimezone`;;
     -+	Found an invalid time zone in an author/committer line.
     ++`badTree`::
     ++	(ERROR) A tree cannot be parsed.
      +
     -+`badTree`;;
     -+	A tree cannot be parsed.
     ++`badTreeSha1`::
     ++	(ERROR) A tree has an invalid format.
      +
     -+`badTreeSha1`;;
     -+	A tree has an invalid format.
     ++`badType`::
     ++	(ERROR) Found an invalid object type.
      +
     -+`badType`;;
     -+	Found an invalid object type.
     ++`duplicateEntries`::
     ++	(ERROR) A tree contains duplicate file entries.
      +
     -+`duplicateEntries`;;
     -+	A tree contains duplicate file entries.
     ++`emptyName`::
     ++	(WARN) A path contains an empty name.
      +
     -+`emptyName`;;
     -+	A path contains an empty name.
     ++`extraHeaderEntry`::
     ++	(IGNORE) Extra headers found after `tagger`.
      +
     -+`fullPathName`;;
     -+	A path contains the full path starting with "/".
     ++`fullPathName`::
     ++	(WARN) A path contains the full path starting with "/".
      +
     -+`gitAttributesSymlink`;;
     -+	`.gitattributes` is a symlink.
     ++`gitAttributesSymlink`::
     ++	(INFO) `.gitattributes` is a symlink.
      +
     -+`gitignoreSymlink`;;
     -+	`.gitignore` is a symlink.
     ++`gitignoreSymlink`::
     ++	(INFO) `.gitignore` is a symlink.
      +
     -+`gitmodulesBlob`;;
     -+	A non-blob found at `.gitmodules`.
     ++`gitmodulesBlob`::
     ++	(ERROR) A non-blob found at `.gitmodules`.
      +
     -+`gitmodulesMissing`;;
     -+	Unable to read `.gitmodules` blob.
     ++`gitmodulesMissing`::
     ++	(ERROR) Unable to read `.gitmodules` blob.
      +
     -+`gitmodulesName`;;
     -+	A submodule name is invalid.
     ++`gitmodulesName`::
     ++	(ERROR) A submodule name is invalid.
      +
     -+`gitmodulesParse`;;
     -+	Could not parse `.gitmodules` blob.
     ++`gitmodulesParse`::
     ++	(INFO) Could not parse `.gitmodules` blob.
      +
      +`gitmodulesLarge`;
     -+	`.gitmodules` blob is too large to parse.
     ++	(ERROR) `.gitmodules` blob is too large to parse.
     ++
     ++`gitmodulesPath`::
     ++	(ERROR) `.gitmodules` path is invalid.
     ++
     ++`gitmodulesSymlink`::
     ++	(ERROR) `.gitmodules` is a symlink.
      +
     -+`gitmodulesPath`;;
     -+	`.gitmodules` path is invalid.
     ++`gitmodulesUpdate`::
     ++	(ERROR) Found an invalid submodule update setting.
      +
     -+`gitmodulesSymlink`;;
     -+	`.gitmodules` is a symlink.
     ++`gitmodulesUrl`::
     ++	(ERROR) Found an invalid submodule url.
      +
     -+`gitmodulesUpdate`;;
     -+	Found an invalid submodule update setting.
     ++`hasDot`::
     ++	(WARN) A tree contains an entry named `.`.
      +
     -+`gitmodulesUrl`;;
     -+	Found an invalid submodule url.
     ++`hasDotdot`::
     ++	(WARN) A tree contains an entry named `..`.
      +
     -+`hasDot`;;
     -+	A tree contains an entry named `.`.
     ++`hasDotgit`::
     ++	(WARN) A tree contains an entry named `.git`.
      +
     -+`hasDotdot`;;
     -+	A tree contains an entry named `..`.
     ++`mailmapSymlink`::
     ++	(INFO) `.mailmap` is a symlink.
      +
     -+`hasDotgit`;;
     -+	A tree contains an entry named `.git`.
     ++`missingAuthor`::
     ++	(ERROR) Author is missing.
      +
     -+`mailmapSymlink`;;
     -+	`.mailmap` is a symlink.
     ++`missingCommitter`::
     ++	(ERROR) Committer is missing.
      +
     -+`missingAuthor`;;
     -+	Author is missing.
     ++`missingEmail`::
     ++	(ERROR) Email is missing in an author/committer line.
      +
     -+`missingCommitter`;;
     -+	Committer is missing.
     ++`missingNameBeforeEmail`::
     ++	(ERROR) Missing name before an email in an author/committer line.
      +
     -+`missingEmail`;;
     -+	Email is missing in an author/committer line.
     ++`missingObject`::
     ++	(ERROR) Missing `object` line in tag object.
      +
     -+`missingNameBeforeEmail`;;
     -+	Missing space before an email in an author/committer line.
     ++`missingSpaceBeforeDate`::
     ++	(ERROR) Missing space before date in an author/committer line.
      +
     -+`missingObject`;;
     -+	Missing `object` line in tag object.
     ++`missingSpaceBeforeEmail`::
     ++	(ERROR) Missing space before the email in author/committer line.
      +
     -+`missingSpaceBeforeDate`;;
     -+	Missing space before date in an author/committer line.
     ++`missingTag`::
     ++	(ERROR) Unexpected end after `type` line in a tag object.
      +
     -+`missingSpaceBeforeEmail`;;
     -+	Missing space before the email in author/committer line.
     ++`missingTagEntry`::
     ++	(ERROR) Missing `tag` line in a tag object.
      +
     -+`missingTag`;;
     -+	Unexpected end after `type` line in a tag object.
     ++`missingTypeEntry`::
     ++	(ERROR) Missing `type` line in a tag object.
      +
     -+`missingTypeEntry`;;
     -+	Missing `type` line in a tag object.
     ++`multipleAuthors`::
     ++	(ERROR) Multiple author lines found in a commit.
      +
     -+`multipleAuthors`;;`
     -+	Multiple author lines found in a commit.
     ++`nulInCommit`::
     ++	(WARN) Found a NUL byte in the commit object body.
      +
     -+`nulInCommit`;;
     -+	Found a NUL byte in the commit object body.
     ++`nulInHeader`::
     ++	(FATAL) NUL byte exists in the object header.
      +
     -+`treeNotSorted`;;
     -+	A tree is not properly sorted.
     ++`nulInSha1`::
     ++	(WARN) Tree contains entries pointing to a null sha1.
      +
     -+`unknownType`;;
     -+	Found an unknown object type.
     ++`treeNotSorted`::
     ++	(ERROR) A tree is not properly sorted.
      +
     -+`zeroPaddingDate`;;
     -+	Found a zero padded date in an author/commiter line.
     ++`unknownType`::
     ++	(ERROR) Found an unknown object type.
      +
     -+`zeroPaddedFilemode`;;
     -+	Found a zero padded filemode in a tree.
     -+--
     ++`unterminatedHeader`::
     ++	(FATAL) Missing end-of-line in the object header.
     ++
     ++`zeroPaddingDate`::
     ++	(ERROR) Found a zero padded date in an author/commiter line.
     ++
     ++`zeroPaddedFilemode`::
     ++	(WARN) Found a zero padded filemode in a tree.
     +
     + ## Documentation/git-fsck.txt ##
     +@@ Documentation/git-fsck.txt: hash mismatch <object>::
     + 	object database value.
     + 	This indicates a serious data integrity problem.
     + 
     ++
     ++FSCK MESSAGES
     ++-------------
     ++
     ++The following lists the types of errors `git fsck` detects and what
     ++each error means, with their default severity.  The severity of the
     ++error, other than those that are marked as "(FATAL)", can be tweaked
     ++by setting the corresponding `fsck.<msg-id>` configuration variable.
     ++
     ++include::fsck-msgids.txt[]
     ++
     ++
     + Environment Variables
     + ---------------------
     + 
     +
     + ## fsck.h ##
     +@@ fsck.h: enum fsck_msg_type {
     + 	FSCK_WARN,
     + };
     + 
     ++/*
     ++ * Documentation/fsck-msgids.txt documents these; when
     ++ * modifying this list in any way, make sure to keep the
     ++ * two in sync.
     ++ */
     ++
     + #define FOREACH_FSCK_MSG_ID(FUNC) \
     + 	/* fatal errors */ \
     + 	FUNC(NUL_IN_HEADER, FATAL) \

-- 
gitgitgadget
