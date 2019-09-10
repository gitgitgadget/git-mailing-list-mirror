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
	by dcvr.yhbt.net (Postfix) with ESMTP id AC62C1F463
	for <e@80x24.org>; Tue, 10 Sep 2019 07:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388993AbfIJHod (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 03:44:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35573 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfIJHod (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 03:44:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17so3241062plp.2
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 00:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S4NG5j9KAcaoM1VFVBcKFQar2bebZwV/TLyADZSdvVw=;
        b=AMx20FdFkJkr6bm+z7fUi3KL9aKyyj3B4eKT3KyLVHKCPAN2hmip042FAQU4VTOFnF
         3NaKwG+wb/jWnUt1g7p7DslEKzb0N4c27HCryJ3k7mg7RugZ1bn3GepAnb+p4uR2j+0V
         gAQBKOkNFCEoNUU+dBKseuD8N1yTqGA4npwQYdb0lH2JJKXzRBbo5N5N3OBpaUgjVsm9
         nvpALkqS9AfB/wP/qK0lz2HGX6IhOD2UOewV3zo98iSKNLLgK1tsFKfzcrpLiUAt46Ug
         IQwYbfYRo532jmNzKu3QaXz3mMAdVfp77cz21qlWibLIv62QMG22Iax82RpXqPJFhfzf
         dVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S4NG5j9KAcaoM1VFVBcKFQar2bebZwV/TLyADZSdvVw=;
        b=j+3DeT03Lj0qyhuI5uziOFwkx3+1SYxqeoDJsBblByxfVfG1zvW3g72W2Jk2hrR3qn
         BO8B02UETK1hI6MDx1YSzNHOvUfMDsgPyf38Zmt3KjddGyE04BJV+941H5WvmFJYhd/E
         dbxta/xaeAWnTqWN6+MBUQDi8HyIVqO47HKC0cLF3xt8yI9n+dNLt+JNI0TQdFoDVX6M
         frchoNRM+Bg6Y1VoEeKLaX4fBs/F5qwnZ4CF6fjWCC8OIw4Wv+F0qFcAOyswrD+yDjLi
         ugK0AhBeQReRO/3Gbo/EL7lRIYTv/88W5miQdyLRhP1gq1Uef9gsjs7bLS6xXjJrgaLk
         33Tg==
X-Gm-Message-State: APjAAAXsMDTqcL4UnjOB3orU5EI6ioN+vOIT596ckFwwYbHZp4WEhlb4
        VPulDHY15dhZ7r/ICW9tiRqaDZSG9lw=
X-Google-Smtp-Source: APXvYqzFSNDkWIk089Jkg3fqmk/I4AMfzkKZAHT29d7Ff4XtfD7Kh0Ry2yvmCXsHtcLIobemgqrr1g==
X-Received: by 2002:a17:902:b48f:: with SMTP id y15mr16310739plr.100.1568101470933;
        Tue, 10 Sep 2019 00:44:30 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id s186sm23167975pfb.126.2019.09.10.00.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 00:44:30 -0700 (PDT)
Date:   Tue, 10 Sep 2019 00:44:28 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] Makefile: define UPSTREAM_SOURCES
Message-ID: <bc3cd4637a52183fe9878b13ed761380cde76232.1568101393.git.liu.denton@gmail.com>
References: <cover.1568101393.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568101393.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After looking through the source files in compat/ and investigating the
files' content and/or its Git history, I've determined the list of files
that were copied from an upstream. Place the names of these files into
the UPSTREAM_SOURCES variable in the Makefile.

In addition, add the sha1collisiondetection/ and sha1dc/ sources as well
since they are also imported from upstream.

In a future commit, this variable will be used to determine which files
are excluded when running the "coccicheck" target.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index ad71ae1219..708df2c289 100644
--- a/Makefile
+++ b/Makefile
@@ -598,6 +598,7 @@ SCRIPT_SH =
 SCRIPT_LIB =
 TEST_BUILTINS_OBJS =
 TEST_PROGRAMS_NEED_X =
+UPSTREAM_SOURCES =
 
 # Having this variable in your environment would break pipelines because
 # you cause "cd" to echo its destination to stdout.  It can also take
@@ -1146,6 +1147,15 @@ BUILTIN_OBJS += builtin/verify-tag.o
 BUILTIN_OBJS += builtin/worktree.o
 BUILTIN_OBJS += builtin/write-tree.o
 
+UPSTREAM_SOURCES += compat/inet_ntop.c
+UPSTREAM_SOURCES += compat/inet_pton.c
+UPSTREAM_SOURCES += compat/obstack.%
+UPSTREAM_SOURCES += compat/nedmalloc/%
+UPSTREAM_SOURCES += compat/poll/%
+UPSTREAM_SOURCES += compat/regex/%
+UPSTREAM_SOURCES += sha1collisiondetection/%
+UPSTREAM_SOURCES += sha1dc/%
+
 GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS =
 
-- 
2.23.0.248.g3a9dd8fb08

