Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D940CC7EE29
	for <git@archiver.kernel.org>; Thu,  4 May 2023 16:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjEDQeb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 12:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjEDQe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 12:34:28 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2128A1FDF
        for <git@vger.kernel.org>; Thu,  4 May 2023 09:34:27 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-18ef8aa1576so627527fac.0
        for <git@vger.kernel.org>; Thu, 04 May 2023 09:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683218066; x=1685810066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBorYkw+4/6DCTg4EQdM48+wnN8B8jV4BTq/cwLzgKk=;
        b=R1zMmKOIDdt4xHJyuzn3/QeZrMaJhNwP0wtcy03WbgE0Ama2L37gWcpT89TQOOnnS0
         hhAyzsyGzzl6/PgKE6Zad/01jAUCP0y9fKoNwPbEdWMkj41BfRIYcKPokrIY0+WVDXlG
         fUoXSzLkCMrtqmTh1xC63b/InqbF39musonSgYE6ZtpT8BFZMbNxFHOQB1lNQ7ZR/iiH
         dQRInQ+DKbaZpeTg9c8I+4XzxsnLZ3lx5v/jUSnLsuLje4yORckwg7LDSXj0Tx5WhXfB
         /8zKcrBafhKbRqRjfi9I6/M/05Y3cw2rnbjFblWSBlajW9dkyvaUWryy46cYatHE6All
         tthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683218066; x=1685810066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBorYkw+4/6DCTg4EQdM48+wnN8B8jV4BTq/cwLzgKk=;
        b=LisO5P5cSfKiWcxHUGPj3v5Lfck8ocp4UheDj69xJcwBRnGLoPsmi+X64wB9n1kY9f
         vDXUrRrpR7NGPt4buMJtqQcmLvoGOUTC8Tcla6r38AIRBhRvUrpQn0TJSn+S6iYRzACK
         R523M5+5Q5is9jc28vX+F2Ez6VkMXW8GEG207FR6CKVPAV5OFuq4oZUBLEgxMnusZXEJ
         GPCEZjK9U/8bLzOQoGrGX1HTb85UiYKFPCz1wkLDEP/DnQs1Uht5lToaT/9ADUzxUVh7
         dnIXScMInVMqWffplbwh5vKrbia3a+t7Z//4UiZL/vccWgASgYFCcfk0Iu9lPQheJGoz
         TTEQ==
X-Gm-Message-State: AC+VfDzYa2pH+WjWoIgykeSDxx7l24MnfwvK51CjxISW8p/81V6/YdZ8
        t7Hs/6i2jRj3uUw8kIqnHB/PV5vEgTM=
X-Google-Smtp-Source: ACHHUZ4+aAOxeF3oR4bvadINmN61F0PaqXhr0459zSdZcMXlbZSsyHyG1ffekv3WWqSfnjPqS5nOSg==
X-Received: by 2002:a05:6870:9186:b0:177:9753:f82b with SMTP id b6-20020a056870918600b001779753f82bmr1391985oaf.5.1683218066458;
        Thu, 04 May 2023 09:34:26 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id k5-20020a056870a4c500b001805a3e722csm811682oal.19.2023.05.04.09.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 09:34:25 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] doc: revisions: add a bunch of missing quotes
Date:   Thu,  4 May 2023 10:34:21 -0600
Message-Id: <20230504163421.100400-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230504163421.100400-1-felipe.contreras@gmail.com>
References: <20230504163421.100400-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/revisions.txt | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index af764de153..bc1c6e5979 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -97,10 +97,10 @@ some output processing may assume ref names in UTF-8.
   before the current one.
 
 '[<branchname>]@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
-  A branch B may be set up to build on top of a branch X (configured with
-  `branch.<name>.merge`) at a remote R (configured with
-  `branch.<name>.remote`). B@\{u} refers to the remote-tracking branch for
-  the branch X taken from remote R, typically found at `refs/remotes/R/X`.
+  A branch 'B' may be set up to build on top of a branch 'X' (configured with
+  `branch.<name>.merge`) at a remote 'R' (configured with
+  `branch.<name>.remote`). 'B@\{u}' refers to the remote-tracking branch for
+  the branch 'X' taken from remote 'R', typically found at `refs/remotes/R/X`.
 
 '[<branchname>]@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
   The suffix '@\{push}' reports the branch "where we would push to" if
@@ -129,7 +129,7 @@ from one location and push to another. In a non-triangular workflow,
 This suffix is also accepted when spelled in uppercase, and means the same
 thing no matter the case.
 
-'<rev>{caret}[<n>]', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
+'<rev>{caret}[<n>]', e.g. 'HEAD{caret}', 'v1.5.1{caret}0'::
   A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
   '<rev>{caret}'
@@ -137,7 +137,7 @@ thing no matter the case.
   '<rev>{caret}0' means the commit itself and is used when '<rev>' is the
   object name of a tag object that refers to a commit object.
 
-'<rev>{tilde}[<n>]', e.g. 'HEAD{tilde}, master{tilde}3'::
+'<rev>{tilde}[<n>]', e.g. 'HEAD{tilde}', 'master{tilde}3'::
   A suffix '{tilde}' to a revision parameter means the first parent of
   that commit object.
   A suffix '{tilde}<n>' to a revision parameter means the commit
@@ -278,8 +278,8 @@ The '..' (two-dot) Range Notation::
  The '{caret}r1 r2' set operation appears so often that there is a shorthand
  for it.  When you have two commits 'r1' and 'r2' (named according
  to the syntax explained in SPECIFYING REVISIONS above), you can ask
- for commits that are reachable from r2 excluding those that are reachable
- from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.
+ for commits that are reachable from 'r2' excluding those that are reachable
+ from 'r1' by '{caret}r1 r2' and it can be written as 'r1..r2'.
 
 The '\...' (three-dot) Symmetric Difference Notation::
  A similar notation 'r1\...r2' is called symmetric difference
@@ -288,7 +288,7 @@ The '\...' (three-dot) Symmetric Difference Notation::
  It is the set of commits that are reachable from either one of
  'r1' (left side) or 'r2' (right side) but not from both.
 
-In these two shorthand notations, you can omit one end and let it default to HEAD.
+In these two shorthand notations, you can omit one end and let it default to `HEAD`.
 For example, 'origin..' is a shorthand for 'origin..HEAD' and asks "What
 did I do since I forked from the origin branch?"  Similarly, '..origin'
 is a shorthand for 'HEAD..origin' and asks "What did the origin do since
@@ -340,22 +340,22 @@ Revision Range Summary
 ----------------------
 
 '<rev>'::
-	Include commits that are reachable from <rev> (i.e. <rev> and its
+	Include commits that are reachable from '<rev>' (i.e. '<rev>' and its
 	ancestors).
 
 '{caret}<rev>'::
-	Exclude commits that are reachable from <rev> (i.e. <rev> and its
+	Exclude commits that are reachable from '<rev>' (i.e. '<rev>' and its
 	ancestors).
 
 '<rev1>..<rev2>'::
-	Include commits that are reachable from <rev2> but exclude
-	those that are reachable from <rev1>.  When either <rev1> or
-	<rev2> is omitted, it defaults to `HEAD`.
+	Include commits that are reachable from '<rev2>' but exclude
+	those that are reachable from '<rev1>'.  When either '<rev1>' or
+	'<rev2>' is omitted, it defaults to `HEAD`.
 
 '<rev1>\...<rev2>'::
-	Include commits that are reachable from either <rev1> or
-	<rev2> but exclude those that are reachable from both.  When
-	either <rev1> or <rev2> is omitted, it defaults to `HEAD`.
+	Include commits that are reachable from either '<rev1>' or
+	'<rev2>' but exclude those that are reachable from both.  When
+	either '<rev1>' or '<rev2>' is omitted, it defaults to `HEAD`.
 
 '<rev>{caret}@', e.g. 'HEAD{caret}@'::
   A suffix '{caret}' followed by an at sign is the same as listing
@@ -367,7 +367,7 @@ Revision Range Summary
   as giving commit '<rev>' and all its parents prefixed with
   '{caret}' to exclude them (and their ancestors).
 
-'<rev>{caret}-<n>', e.g. 'HEAD{caret}-, HEAD{caret}-2'::
+'<rev>{caret}-<n>', e.g. 'HEAD{caret}-', 'HEAD{caret}-2'::
 	Equivalent to '<rev>{caret}<n>..<rev>', with '<n>' = 1 if not
 	given.
 
-- 
2.40.0+fc1

