Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EED261F42D
	for <e@80x24.org>; Thu, 31 May 2018 03:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932705AbeEaDYX (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 23:24:23 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38160 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932637AbeEaDYW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 23:24:22 -0400
Received: by mail-pf0-f196.google.com with SMTP id b74-v6so6584299pfl.5
        for <git@vger.kernel.org>; Wed, 30 May 2018 20:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CnkNP+9UoUEUInO2aI5NNchwkwpv0B1viJ8NZGNJj5U=;
        b=SrbfVMQDgNnGRs6mWVrSoolvYpbnHBPOlWhytDxNlwyIKGU00JHrrzHWcmuw/dP4ev
         VOp0C/ggAqyp+HYB/8YsQpruskuZd3xBJyybZzF234A/2jDXJthuRcjrZeYKx7/Bie9B
         j/5yA2AoObDvgz+Bk8UGRlA/71byOpLMwdxEhp4ZXU25KaXonLLlHvg1NKI8IAUYnEwG
         HMBM/ywulJrkQ4FTZwVBn8h0yjoWrk+MM5UJikUNRIWYTtwUNdZDDAlSi17mxFNEfe2f
         w/uSZP+zU5rXc3gTmVP2BCTwGeCJsTjd5AJP9Yka3x6b4UJf9K/zxaHEtV9s6N3C8eOm
         KI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CnkNP+9UoUEUInO2aI5NNchwkwpv0B1viJ8NZGNJj5U=;
        b=BcxiQOJsLBscSu5b2YDRG4nzdLENyX3KWaDvLnylyRE5DjCOiHJNyJM1vaJznOC928
         D+/+vjlu514x2hqhl1MBkd1lfOXs6vuO6/lfjkGb4m/qZmK0+3cCkd3fcn31Nw89LOou
         ycJI/i71vIL2I4c9tPpVGSUyQTCd3mS0/XABQ7FqzZL9V9pt+so5+Co3WtKF7Jk7ISPM
         3AmS9B7fn8xfK2kEqgzerLu9uIidcqcMVOYDyl6hP6M7TBwzLLq9FnRukwMk4Knt4XHa
         OpyfxCMZ9XLrQDaJ8JhknWoEvqQNJGsmAVHcybBYIhOq+NMyu8M0WkHFWbGs2ReQUM70
         9izQ==
X-Gm-Message-State: ALKqPwc2oAZkGXO/aQLkyo3gaA+iXCZutYP9r4OSGozVY7sMkpHRgPPe
        asAlgXWy5ANSqszIUZKvWu6y9Q==
X-Google-Smtp-Source: ADUXVKJ6Qgr+tEniWF6HAc7KVZLLs996jeyAMvJR1BkaJZNCJ8cTkJSTDkDi6IrQSdEMYqE16uMQ/w==
X-Received: by 2002:a62:b909:: with SMTP id z9-v6mr5228062pfe.254.1527737062129;
        Wed, 30 May 2018 20:24:22 -0700 (PDT)
Received: from localhost.localdomain (108-244-97-212.lightspeed.sntcca.sbcglobal.net. [108.244.97.212])
        by smtp.gmail.com with ESMTPSA id n10-v6sm82430289pfj.68.2018.05.30.20.24.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 May 2018 20:24:21 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH] RelNotes: remove duplicate release note
Date:   Wed, 30 May 2018 20:24:14 -0700
Message-Id: <20180531032414.20506-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the 2.18 cycle, directory rename detection was merged, then reverted,
then reworked in such a way to fix another prominent bug in addition to
the original problem causing it to be reverted.  When the reworked series
was merged, we ended up with two nearly duplicate release notes.  Remove
the second copy, but preserve the information about the extra bug fix.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/RelNotes/2.18.0.txt | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/Documentation/RelNotes/2.18.0.txt b/Documentation/RelNotes/2.18.0.txt
index c9e2e19721..fd5aecf8e9 100644
--- a/Documentation/RelNotes/2.18.0.txt
+++ b/Documentation/RelNotes/2.18.0.txt
@@ -12,7 +12,9 @@ UI, Workflows & Features
    want to move to z/d by taking the hint that the entire directory
    'x' moved to 'z'.  A bug causing dirty files involved in a rename
    to be overwritten during merge has also been fixed as part of this
-   work.
+   work.  Incidentally, this also avoids updating a file in the
+   working tree after a (non-trivial) merge whose result matches what
+   our side originally had.
 
  * "git filter-branch" learned to use a different exit code to allow
    the callers to tell the case where there was no new commits to
@@ -256,16 +258,6 @@ Performance, Internal Implementation, Development Support etc.
    repository object (which in turn tells the API which object store
    the objects are to be located).
 
- * Rename detection logic in "diff" family that is used in "merge" has
-   learned to guess when all of x/a, x/b and x/c have moved to z/a,
-   z/b and z/c, it is likely that x/d added in the meantime would also
-   want to move to z/d by taking the hint that the entire directory
-   'x' moved to 'z'.  A bug causing dirty files involved in a rename
-   to be overwritten during merge has also been fixed as part of this
-   work.  Incidentally, this also avoids updating a file in the
-   working tree after a (non-trivial) merge whose result matches what
-   our side originally had.
-
  * "git pack-objects" needs to allocate tons of "struct object_entry"
    while doing its work, and shrinking its size helps the performance
    quite a bit.
-- 
2.18.0.rc0

