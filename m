Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DE3E1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 19:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390901AbfIPTXP (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 15:23:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37132 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387404AbfIPTXP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 15:23:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id y5so514460pfo.4
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 12:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e71ybhHoPK04Nfvs6CCQzaqR3M9qnWtFSaTnfWjml6U=;
        b=Ihxy8aP+6DuB1w+EhVwuKgTwQD+TBv07F5uB0k92jL6VbSRF7C4AuH4WgYti2pTmoF
         Nt+iRpDkG5TCfpiuZdJnDa0+P5CZR5zAN2mnkkmpazOmutjPH4rF8XCk2gDzm18j/fVj
         +v2rSUAqQMrJK6Qif/37hDFk/aR+C1Ht0DWWAMUJpNmqpc2+h1irZ09LqLMHzsEualQc
         0Uz6b2VAASgyXrh0TgDbc5W16cg3i3+rFwUMciNvoFVYS32MEszNEoEuw12BIkWr/ZL4
         izKpsh1GFJ6WeNgOLu7OOyckigkuAJR7qW3H8jEzM6IwGgeS4sHB7ehzC9HSRabNy9Tt
         4KvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e71ybhHoPK04Nfvs6CCQzaqR3M9qnWtFSaTnfWjml6U=;
        b=os3SRM3ZTvonH+YYROHXMRkOfI6Z3liFUjRjVGfp/p1VawZmbQecYo2cwVgOSbxAaQ
         Ff6DTpM9NfwJJVnmuWDf6ILumERqxP3Rp9gUrTVnt2+DKQ4+MZbNJOhkC9bJ/IiPruWD
         1pbN4p8FmxlsmDa8q5wwmAfF881XglJPLY//Iw0R8vHTU3szTJsJtUZeo6ylRHrt++vy
         Kgnqyf1VvZU3b2ObX+reLYOCiQ/V3YeYsS3j7cb9Q08Rz9im8SlngRypEB6WwJ4qBhiW
         LeECpOWNA8C6dqGnA2FsqIb6L6o98F2Tg5U1iEyqz0yafd91RNFDXt2DnjQdDvkLcOeo
         jYFw==
X-Gm-Message-State: APjAAAWvMa+CAqUtppxOuv+sVc1md7eAZhANTkO2MREFfJ+NVm0iqlvb
        4rmmrCKW7tp4o7SVrgKHBvhH+Qkzrbg=
X-Google-Smtp-Source: APXvYqzEeXUT3AVNacfRa3WS24GF6SyhkIYJE/UbNMleOoUS71ODe8mIhqOztYe1hvP//WthDywngQ==
X-Received: by 2002:a63:29c7:: with SMTP id p190mr711144pgp.124.1568661793840;
        Mon, 16 Sep 2019 12:23:13 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id v10sm362009pjk.23.2019.09.16.12.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 12:23:12 -0700 (PDT)
Date:   Mon, 16 Sep 2019 12:23:11 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/4] Makefile: define THIRD_PARTY_SOURCES
Message-ID: <a7c855a973db9067c2e30569d86f9b2b2147c6b3.1568661443.git.liu.denton@gmail.com>
References: <cover.1568309119.git.liu.denton@gmail.com>
 <cover.1568661443.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568661443.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some files in our codebase are borrowed from other projects, and
minimally updated to suit our own needs. We'd sometimes need to tell
our own sources and these third-party sources apart for management
purposes (e.g. we may want to be less strict about coding style and
other issues on third-party files).

Define the $(MAKE) variable THIRD_PARTY_SOURCES that can be used to
match names of third-party sources.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Makefile | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Makefile b/Makefile
index ea77198247..49839579ec 100644
--- a/Makefile
+++ b/Makefile
@@ -598,6 +598,7 @@ SCRIPT_SH =
 SCRIPT_LIB =
 TEST_BUILTINS_OBJS =
 TEST_PROGRAMS_NEED_X =
+THIRD_PARTY_SOURCES =
 
 # Having this variable in your environment would break pipelines because
 # you cause "cd" to echo its destination to stdout.  It can also take
@@ -1146,6 +1147,17 @@ BUILTIN_OBJS += builtin/verify-tag.o
 BUILTIN_OBJS += builtin/worktree.o
 BUILTIN_OBJS += builtin/write-tree.o
 
+# THIRD_PARTY_SOURCES is a list of patterns compatible with
+# the $(filter) and $(filter-out) family of functions
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
2.23.0

