Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F390FC6FD1F
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 11:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjCLLzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 07:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCLLzW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 07:55:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8B342BEB
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 04:55:19 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j2so8872843wrh.9
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 04:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678622117;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZqmFS909uKO3FSrV4MwHdB31W1Viorkni4RqiLuv6c=;
        b=HK8XE/JjoOej2mhi9g/kh6upGXY/8fRG+fzJF7xQlvbqD/mzAHBlhzJ8H0e7qbCPWO
         BDGefu2Svk+iPx6Y8tr0X38JGedIgykDQPP4zUPs676xT9wnXIQ30e6LIeVfjqAZe1gd
         g/PzfBVVwKvFseQuxQ4HhnLHgGsj8UolN8P8VDah63pSJh3nRudpom/gEFmQtwXHS8af
         mBeym7mEfXy+tpZLaINAZGLPHqOyf+0qNp4j+wYlbPgTDNiISmRnXOyzDVYdaLT2Qtg5
         jBglKZgdjaIIQ5L+w83/JWGC6G3EJygxLSnLbfsGJXhISV7nACH7AKJVa0UiP3M/ir0O
         RNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678622117;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZqmFS909uKO3FSrV4MwHdB31W1Viorkni4RqiLuv6c=;
        b=fNHUzek6FsLuiGiewgssWNhIb9yZgcZWdqU+zrflqDd45Cr5mfW51Z6PSmI6nwAAfG
         dn/detKp7I648s+V0WRQrNkltztjytLynWawnD6Yy7afzQbZ1XnNzCIjN1CzT0uh08/R
         yJgt2kVIcSzSq7xzWOA5qw0ZL1ADaQdmSSTjhs2Smh9H4eBtvv21Fr1CkuBBh/VGC3xh
         IaWhHEWfGsDhAe+zNiTTLX/tFazs6U5WpRcG1ow1AARiqQ7SbpLSSlL0g6d0zvPnGQdO
         jE/+UQ9SiuiwPgFM/33hAMRbCEiT+5bgWABp7oZwkYG4WGdT0EomNyafCG/9Cg6bjJwp
         dFUA==
X-Gm-Message-State: AO0yUKWIy5FHda3ENrrc960bUtRU7ZSrUHC2sFUsg5ac/fT5Sxp1JqbF
        2e3JdofD/0rAiWyfb603GqpqPKXTnBo=
X-Google-Smtp-Source: AK7set9KMCiTz4bUvDvXHSNFhyP37aYmehddwpc1+pOt5ETfSwW+Hiikq8Uw3vYDpRG0pTVT6NM4kQ==
X-Received: by 2002:adf:e8cd:0:b0:2cb:3660:44e with SMTP id k13-20020adfe8cd000000b002cb3660044emr19926625wrn.66.1678622117460;
        Sun, 12 Mar 2023 04:55:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14-20020a5d40ce000000b002c5539171d1sm4993890wrq.41.2023.03.12.04.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 04:55:17 -0700 (PDT)
Message-Id: <pull.1466.v2.git.git.1678622116232.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.git.git.1678526355280.gitgitgadget@gmail.com>
References: <pull.1466.git.git.1678526355280.gitgitgadget@gmail.com>
From:   "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 12 Mar 2023 11:55:16 +0000
Subject: [PATCH v2] ls-files: document that pathspecs are supported
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Adam Johnson <me@adamj.eu>,
        Adam Johnson <me@adamj.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Adam Johnson <me@adamj.eu>

The command has taken pathspecs, not just filenames, since at least 56fc5108
([PATCH] git-ls-files: generalized pathspecs, 2005-08-21).

Signed-off-by: Adam Johnson <me@adamj.eu>
---
    ls-files: document that pathspecs are supported
    
    The command has taken pathspecs, not just filenames, since f0096c06bcd
    (Convert read_tree{,_recursive} to support struct pathspec, 2011-03-25).
    
    Signed-off-by: Adam Johnson me@adamj.eu

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1466%2Fadamchainz%2Fdoc-ls-files-pathspecs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1466/adamchainz/doc-ls-files-pathspecs-v2
Pull-Request: https://github.com/git/git/pull/1466

Range-diff vs v1:

 1:  4a0417ba8e5 ! 1:  7c95f4f5a7d ls-files: document that pathspecs are supported
     @@ Metadata
       ## Commit message ##
          ls-files: document that pathspecs are supported
      
     -    The command has taken pathspecs, not just filenames, since f0096c06bcd
     -    (Convert read_tree{,_recursive} to support struct pathspec, 2011-03-25).
     +    The command has taken pathspecs, not just filenames, since at least 56fc5108
     +    ([PATCH] git-ls-files: generalized pathspecs, 2005-08-21).
      
          Signed-off-by: Adam Johnson <me@adamj.eu>
      
     @@ Documentation/git-ls-files.txt: OPTIONS
       
       --error-unmatch::
      -	If any <file> does not appear in the index, treat this as an
     -+	If any <pathspec> does not appear in the index, treat this as an
     - 	error (return 1).
     +-	error (return 1).
     ++	If no path that matches <pathspec> appears in the index, treat this as
     ++	an error (return 1).
       
       --with-tree=<tree-ish>::
       	When using --error-unmatch to expand the user supplied
     @@ Documentation/git-ls-files.txt: followed by the  ("attr/<eolattr>").
       	Do not interpret any more arguments as options.
       
      -<file>::
     +-	Files to show. If no files are given all files which match the other
      +<pathspec>::
     - 	Files to show. If no files are given all files which match the other
     ++	Limits the files to show to only those that match any of the given
     ++	pathspecs. If no pathspecs are given, all files which match the other
       	specified criteria are shown.
      ++
      +For details on the <pathspec> syntax, see the 'pathspec' entry in


 Documentation/git-ls-files.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 1abdd3c21c5..d69a46f8a56 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -21,7 +21,7 @@ SYNOPSIS
 		[--exclude-standard]
 		[--error-unmatch] [--with-tree=<tree-ish>]
 		[--full-name] [--recurse-submodules]
-		[--abbrev[=<n>]] [--format=<format>] [--] [<file>...]
+		[--abbrev[=<n>]] [--format=<format>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -127,12 +127,12 @@ OPTIONS
 	in each directory, and the user's global exclusion file.
 
 --error-unmatch::
-	If any <file> does not appear in the index, treat this as an
-	error (return 1).
+	If no path that matches <pathspec> appears in the index, treat this as
+	an error (return 1).
 
 --with-tree=<tree-ish>::
 	When using --error-unmatch to expand the user supplied
-	<file> (i.e. path pattern) arguments to paths, pretend
+	<pathspec> (i.e. path pattern) arguments to paths, pretend
 	that paths which were removed in the index since the
 	named <tree-ish> are still present.  Using this option
 	with `-s` or `-u` options does not make any sense.
@@ -225,9 +225,13 @@ followed by the  ("attr/<eolattr>").
 \--::
 	Do not interpret any more arguments as options.
 
-<file>::
-	Files to show. If no files are given all files which match the other
+<pathspec>::
+	Limits the files to show to only those that match any of the given
+	pathspecs. If no pathspecs are given, all files which match the other
 	specified criteria are shown.
++
+For details on the <pathspec> syntax, see the 'pathspec' entry in
+linkgit:gitglossary[7].
 
 OUTPUT
 ------

base-commit: 725f57037d81e24eacfda6e59a19c60c0b4c8062
-- 
gitgitgadget
