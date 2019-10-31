Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB4491F454
	for <e@80x24.org>; Thu, 31 Oct 2019 21:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfJaVEC (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 17:04:02 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:39600 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbfJaVEB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 17:04:01 -0400
Received: by mail-pg1-f202.google.com with SMTP id w17so210812pga.6
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 14:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Dni5XY8pxtVcu+n2TC86SgvVH1YNMutt4+PX2z8AVWQ=;
        b=ihVsQa+a9CUeWF48bhFJ+Sl6Wi1jmepAchk7pR6loRuz9y6hLt8c+7yPM7vwa/8Zw4
         ZCfNLQFaEO1KTDcZVfOmARnpL0A7aT3s8JUrFjy7atEF6663EWXwzJN+gbiJKVRnX/ea
         XbDhy9a/o+Uyg+urdKarhdw4gr8Ra66ISPwxAiM13oVxeMcIAvJ2yZeJtvV6S3Y/B/vi
         8qbJeH4S/zximRBm4dCZP3QFxVKNFaMV8Fiyf1cHgsNYk7WqLeetdl+Wkd0TzDYWscQK
         ksAB7wSnjpMwVdJQ8U2M7a5+eNjTsH+M45KgLq4/4Z2GhU5+F2vtHwVImdJBf9H192ov
         S7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Dni5XY8pxtVcu+n2TC86SgvVH1YNMutt4+PX2z8AVWQ=;
        b=LKfbarygd74tThqYpLOC29xs1mXbHHA/InHYJaynRq1OICaPmAVBFceqjcIKYjWWqJ
         54eiqsS8krzpCEGvn3Ek9hqohyC8IWCjNZ8vUcl+MxHaUuyOc4MVmQ/6p/J03ORztnao
         Wu/tDLfLbTeQogYC4D2kKq7nMBZuOI2ld71XpSb2Ib1VzsN5N09de0xYr5lj9fVJqHi/
         63NnhROLP+3IA2WUp8Dwe3zAYsPP4l7C2GHYbX7UTvPEMGlRGJVck+2P8pN0um1OImRB
         rFeqiuStwNQxl38g//j3OGJkyohdWjKly+GERV2bn1EqAU7/8bxivyHDyRE1P/gOFJZX
         2I6g==
X-Gm-Message-State: APjAAAXyqXRqUrgo1BNDSVW2p1EnNbUuVzliQ2QMcDUVJ51rUMpajAsl
        Cwo3cEPD7hga49bYGuQR1bF1pE9qjFsEyJy7wZsUFMUBUicJHNmlC0GpuCsHctyMUh+37n98Yr9
        QIDtLjCFCjJVZ1Qa4r+ydaqLGSmp2whpC+ei0eYwKVZuN8jTGc8JO7Sq+pm8TIXDC2XRAFnailw
        ==
X-Google-Smtp-Source: APXvYqyr3Iqmgo3YExxDiArQrQrMwZDAPgau/iG41prBbgTWO8U6EjSZWwElD3BvJvy09GWzK+PgfxFqlphMjIBGvq0=
X-Received: by 2002:a63:ab49:: with SMTP id k9mr8938094pgp.34.1572555840336;
 Thu, 31 Oct 2019 14:04:00 -0700 (PDT)
Date:   Thu, 31 Oct 2019 14:03:37 -0700
In-Reply-To: <20191031210338.152529-1-emilyshaffer@google.com>
Message-Id: <20191031210338.152529-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191031210338.152529-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v2 2/3] myfirstcontrib: add dependency installation step
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Indicate that the user needs some dependencies before the build will run
happily on their machine; this dependency list doesn't seem to be made
clear anywhere else in the project documentation. Then, so the user can
be certain any build failures are due to their code and not their
environment, perform a build on a clean checkout of 'master'. Also, move
the note about build parallelization up here, so that it appears next to
the very first build invocation in the tutorial.

Reported-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/MyFirstContribution.txt | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 12b7256454..5ce94e077c 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -38,6 +38,26 @@ $ git clone https://github.com/git/git git
 $ cd git
 ----
 
+[[dependencies]]
+=== Installing Dependencies
+
+To build Git from source, you need to have a handful of dependencies installed
+on your system. For a hint of what's needed, you can take a look at
+`INSTALL`, paying close attention to the section about Git's dependencies on
+external programs and libraries. That document mentions a way to "test-drive"
+our freshly built Git without installing; that's the method we'll be using in
+this tutorial.
+
+Make sure that your environment has everything you need by building your brand
+new clone of Git from the above step:
+
+----
+$ make
+----
+
+NOTE: The Git build is parallelizable. `-j#` is not included above but you can
+use it as you prefer, here and elsewhere.
+
 [[identify-problem]]
 === Identify Problem to Solve
 
@@ -138,9 +158,6 @@ NOTE: When you are developing the Git project, it's preferred that you use the
 `DEVELOPER` flag; if there's some reason it doesn't work for you, you can turn
 it off, but it's a good idea to mention the problem to the mailing list.
 
-NOTE: The Git build is parallelizable. `-j#` is not included above but you can
-use it as you prefer, here and elsewhere.
-
 Great, now your new command builds happily on its own. But nobody invokes it.
 Let's change that.
 
-- 
2.24.0.rc0.303.g954a862665-goog

