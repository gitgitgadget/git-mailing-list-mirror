Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 988E5200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeEDPRx (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:17:53 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40638 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeEDPRv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:17:51 -0400
Received: by mail-lf0-f67.google.com with SMTP id j16-v6so31456176lfb.7
        for <git@vger.kernel.org>; Fri, 04 May 2018 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i05y8h8lX8GtSPuqY7BaTibRmbwReWsnkCs/Q1R29Dg=;
        b=o/3QXvxno/I32ycJhdnYnvIkSnR+Z9getB48U++7w8AW5FDEhpMYnDwtl9Ouqgry7e
         +HUOoEWiZdR5R3AJrB0sYDdgQhRtH5Z3dCaawN/A/NDIt9xQsMVfIhVpgx1Q4SgEXw1p
         06WN4lAr7+DBZVEJPYsMxUepOF1G1iQOMjkGrZXTE6O2/mvIbtVWhIGSOproy5Yq9pRZ
         L/z5YEegWR1Cmib45HQiSDWrBIf9kqzwiCAk9mMfb+yXxKrUadFfxbiRm/YNOwkVH351
         RzwcklIl+6YmYY4A31G2VTqEj6nPQbOBZ/ctW4sHBGsECAEreLM1TeohQHjuxrdSh8qU
         B1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i05y8h8lX8GtSPuqY7BaTibRmbwReWsnkCs/Q1R29Dg=;
        b=pogIqzkW4tmXXKY14roFjD5DPNgAfj4YMaXSmQUxrkgfV1Awq3i5u2kLIouqKLEBXc
         N9SaShTezB+d1Mn2jdquSmlqmd1h1g4ABzbKApXj4UypoJOS1i2DScEM5NdpWk0pvbqC
         fXCMP0CjlSPKkNxJ7gl6H7Vsl4hLODYP7JGKZi1Ho884Z/xWYqXmczoSol53omNZG6X8
         AHkiitQuQ0+rZI4FdOP9gnJ9eZrYAdL475dh6luteqyPpin/+BqGOddQW6A6muPKMpwZ
         VXXWyz6mllkVmZiaN5Pev7R1ppQY2LGcnywr1FC+LY0/cntVKIXj51mlK1gCmFL5jKch
         a3ig==
X-Gm-Message-State: ALQs6tBLtQ65cOKuE2ynV7ckJs48hOb1cNq2gU9XWyfc4bG9uhtQXysM
        nRirzKpPRp+9X8vYlHXnazRjUQ==
X-Google-Smtp-Source: AB8JxZqLjFPIc/XNNW7e4PaEmZ7u8K6IKy31QRvshJWLUUcIrfZJ9atxdiusXk0QGwCBMTzbiRFcaw==
X-Received: by 2002:a19:8e8e:: with SMTP id a14-v6mr18097932lfl.145.1525447069529;
        Fri, 04 May 2018 08:17:49 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x67-v6sm2096879lfd.11.2018.05.04.08.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 08:17:48 -0700 (PDT)
Date:   Fri, 4 May 2018 17:17:46 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
Message-ID: <20180504151746.GA4921@duynguyen.home>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de>
 <CACsJy8DF8twvST0tcHfFqYWaV_0dVRCfJj-QuuCK=0h+gjJ0wQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1805032229050.77@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1805032232080.77@tvgsbejvaqbjf.bet>
 <CACsJy8CRCb2go5qUBOdiSNvvAShotD=e4Cm3Jo1OxNk212YtCA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1805040919400.77@tvgsbejvaqbjf.bet>
 <CACsJy8AnWC8bLfhj25quzHokber-wrWdSsJiCDra=Ymr++0-nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8AnWC8bLfhj25quzHokber-wrWdSsJiCDra=Ymr++0-nQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 04, 2018 at 04:44:49PM +0200, Duy Nguyen wrote:
> On Fri, May 4, 2018 at 9:23 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Oh, okay. It was not at all clear to me what the exact format and role of
> > these lines are...
> 
> Noted. I'm making more updates in this file in another topic and will
> add some explanation so the next guy will be less confused.

This is what I will include (but in a separate topic). I will not CC
you there to keep your inbox slightly less full. I hope this helps
understand what command-list.txt is for.

diff --git a/command-list.txt b/command-list.txt
index 40776b9587..929d8f0ea0 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -1,3 +1,47 @@
+# Command classification list
+# ---------------------------
+# All supported commands, builtin or external, must be described in
+# here. This info is used to list commands in various places. Each
+# command is on one line followed by one or more attributes.
+#
+# The first attribute group is mandatory and indicates the command
+# type. This group includes:
+#
+#   mainporcelain
+#   ancillarymanipulators
+#   ancillaryinterrogators
+#   foreignscminterface
+#   plumbingmanipulators
+#   plumbinginterrogators
+#   synchingrepositories
+#   synchelpers
+#   purehelpers
+#
+# the type names are self explanatory. But if you want to see what
+# command belongs to what group to get a better idea, have a look at
+# "git" man page, "GIT COMMANDS" section.
+#
+# Commands of type mainporcelain can also optionally have one of these
+# attributes:
+#
+#   init
+#   worktree
+#   info
+#   history
+#   remote
+#
+# These commands are considered "common" and will show up in "git
+# help" output in groups. Uncommon porcelain commands must not
+# specify any of these attributes.
+#
+# "complete" attribute is used to mark that the command should be
+# completable by git-completion.bash. Note that by default,
+# mainporcelain commands are completable and you don't need this
+# attribute.
+#
+# While not true commands, guides are also specified here, which can
+# only have "guide" attribute and nothing else.
+#
 ### command list (do not change this line, also do not change alignment)
 # command name                          category [category] [category]
 git-add                                 mainporcelain           worktree
