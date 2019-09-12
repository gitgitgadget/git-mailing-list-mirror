Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41EEC1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 17:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbfILR2d (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 13:28:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40155 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387579AbfILR2d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 13:28:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id y10so12059308pll.7
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sAGPaTh0cc/ltSqbUUXYjoEwLo6rRaBsI863xINLDUg=;
        b=HiIf8clKuELO0rhQKDK8bZ/mfnQUXY2K5YcuTvWCZhvTlLw/apoImYJy+6GA2NYbi2
         BrrITRLKudijn1Hwx8l9QVCmWziQCqlrIaSrrcNUh4rYI65xmRczvuKpgKWB3KthFh58
         RRZ8nxh34PpkH61SfpR+XL+M1Zdcte34IJlTfx3y+u5Hgg1LaKHSLivmHuwoMRunccL4
         b/aTFmP5eBBOOIF7aJxU8pU87mKvFSLNBX0AnP755fMr3BUHv7c1dlRkC7AhOlXFdkQV
         o/L09+xmhcD8NWnEUfB8otxhBkpVRmjIB4zu/K4Wh6aPeCwbS7DDkVzuatboWJVqM2AA
         qNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sAGPaTh0cc/ltSqbUUXYjoEwLo6rRaBsI863xINLDUg=;
        b=oRYjZ6r2BNWhhpiHuzW6G/ziweNW8ts0W7yqI/XaSpQJaRENynNSzaVL3m2TvLDYa/
         +tEVucD4HasaP7zIe4DfFrWHuA1zVRWqGenGCfIy2s9yrejeMcxWrqYc1wibBxcFCM11
         RFBtVKlKWMMzyUBhmYDist5DmVf9NyfQBJ+D44FUhD0JVXI2sWcU5KndFlLBeoMdFVIn
         jS9uQTBXhCo4L6/ckrL6xIyJsy13SmdmNMFba7/LzQCRIdf3MsvZKQX8D0ZKHhABPNeQ
         y2gQ474m/KYmWgGI538pG0fS5dMDB4DXjnp0ru1ZfQ4kAwSlSzKtAT0UmAX3Egrz8ncQ
         JCJg==
X-Gm-Message-State: APjAAAVqqPyy6Q2AqxgqNtIffvRnkOXMNISKpi5xrm7NyCAcKUfDdE15
        Me87reCBuv4d2dYNQqK+/VYXgOm5Nbk=
X-Google-Smtp-Source: APXvYqwLXgnkeTW4nv6yws2lzAFNIuJernJzDOoxoBY9JX4+FKusR4QP1oYonWgeN8h0Zck46VVylQ==
X-Received: by 2002:a17:902:d201:: with SMTP id t1mr31340213ply.278.1568309312141;
        Thu, 12 Sep 2019 10:28:32 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.55])
        by smtp.gmail.com with ESMTPSA id t5sm557326pjw.15.2019.09.12.10.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 10:28:31 -0700 (PDT)
Date:   Thu, 12 Sep 2019 10:28:30 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] Makefile: define THIRD_PARTY_SOURCES
Message-ID: <3878cb2598c677d139c8734b61772d0cdcfdb935.1568309119.git.liu.denton@gmail.com>
References: <cover.1568101393.git.liu.denton@gmail.com>
 <cover.1568309119.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568309119.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After looking through the source files in compat/ and investigating the
files' content and/or its Git history, I've determined the list of files
that were copied from a third-party source. Place the names of these
files into the THIRD_PARTY_SOURCES variable in the Makefile.

In addition, add the sha1collisiondetection/ and sha1dc/ sources as well
since they are also imported from a third-party source.

In a future commit, this variable will be used to determine which files
are excluded when running the "coccicheck" target.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index ad71ae1219..b88b42d7ed 100644
--- a/Makefile
+++ b/Makefile
@@ -598,6 +598,7 @@ SCRIPT_SH =
 SCRIPT_LIB =
 TEST_BUILTINS_OBJS =
 TEST_PROGRAMS_NEED_X =
+THIRD_PARTY_SOURCES =
 
 # Having this variable in your environment would break pipelines because
 # you cause "cd" to echo its destination to stdout.  It can also take
@@ -1146,6 +1147,15 @@ BUILTIN_OBJS += builtin/verify-tag.o
 BUILTIN_OBJS += builtin/worktree.o
 BUILTIN_OBJS += builtin/write-tree.o
 
+THIRD_PARTY_SOURCES += compat/inet_ntop.c
+THIRD_PARTY_SOURCES += compat/inet_pton.c
+THIRD_PARTY_SOURCES += compat/obstack.%
+THIRD_PARTY_SOURCES += compat/nedmalloc/%
+THIRD_PARTY_SOURCES += compat/poll/%
+THIRD_PARTY_SOURCES += compat/regex/%
+THIRD_PARTY_SOURCES += sha1collisiondetection/%
+THIRD_PARTY_SOURCES += sha1dc/%
+
 GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS =
 
-- 
2.23.0.37.g745f681289

