Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A40A1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 11:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406095AbfJRLgD (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 07:36:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40199 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbfJRLgC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 07:36:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id o28so5885126wro.7
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 04:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2KjvHYAJ6rozB4J+i8f7Ucs+TVS90kSVPvEBNV8lgHE=;
        b=N0M5Bo7Npq0Dtxwxxa94wglAH/5WeqViVtb7eflIVKk3+fx2wpzVe4QRDVm8SsUIjj
         nQz00iP2iMGn6Z9ych9WHzLEr42DNqxpVLW6wixnLXWJ+7en9wDeq7QA9kdO/EErYusM
         nvNCtTxMCDrSnN76r6IOShHoby2/ijQyVY50oIWDYehjbUeBjtOVpQC79zqOYUwwxBKS
         eXpnCJNWJS8Mp1P28ckzW9gRMIt+bY/L0O2g4Gv7R/c3KR7V0sOXzS8pxGgQ8Dm+EXBy
         UleY75Bl6t4rjWqK/Zl3yUC1WE7yxA4Z1v0qzwpBGONVYiuJXlQJhbqg5cz/GV1w/jrk
         nXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2KjvHYAJ6rozB4J+i8f7Ucs+TVS90kSVPvEBNV8lgHE=;
        b=kKsRjJqlMa8nvcR07BgbDyDjpSBVbqWGS4mFxzbp9QlKxqekrMwqsk/lXDF8nNXZ3S
         wPCWuX/+VJ4syTU+PiSu29WRTWeFMJAlJLpneJLL/pjZ3yrxIdki+pe5rxCHx38qRMIS
         NUTOCsu+NPXqUpnmSg2CaiRf9ziQYOwWyLQ5bKcx6XAJaxkYLOnBcODMzFRR4Nz49Dn+
         OjnjqBoKwE0AfA+voP9Q1uL9tL82n+zvT94r/VkE7Y1L5k88+EsISR6mtSjrQD5JN69d
         xUcJWeLi5Ossfxts5gaP5UBWtTsvfMiMr3BhXzQ4bJqbunRxwxBf+YLk3pZvefTS1eie
         TgAQ==
X-Gm-Message-State: APjAAAUUcMBhVKk27/H3jG952DWaBaZ47N+Ba41uQS1KGOzeO78S6zSp
        4Qbg28BKn35Nnn0nz9SHMv4=
X-Google-Smtp-Source: APXvYqxBRNjG7lBeh0e6Jo9qdvNQ4YOgKL7VqwKpZpbdYmPbkV/roB/WsYRUdB12G3q5KULToUW17w==
X-Received: by 2002:adf:e78c:: with SMTP id n12mr7134077wrm.351.1571398560329;
        Fri, 18 Oct 2019 04:36:00 -0700 (PDT)
Received: from szeder.dev (x4dbd7267.dyn.telefonica.de. [77.189.114.103])
        by smtp.gmail.com with ESMTPSA id a14sm4482677wmm.44.2019.10.18.04.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 04:35:59 -0700 (PDT)
Date:   Fri, 18 Oct 2019 13:35:57 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git_path(): handle `.lock` files correctly
Message-ID: <20191018113557.GA29845@szeder.dev>
References: <pull.401.git.1571209637.gitgitgadget@gmail.com>
 <f08c90ea02f6811b310a01301acf46da133f38a9.1571209637.git.gitgitgadget@gmail.com>
 <20191016110440.GV29845@szeder.dev>
 <nycvar.QRO.7.76.6.1910172333360.46@tvgsbejvaqbjf.bet>
 <20191018110618.GZ29845@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018110618.GZ29845@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 18, 2019 at 01:06:18PM +0200, SZEDER Gábor wrote:
> > > On a related note, I'm not sure whether the path of the reflogs
> > > directory is right while in a different working tree...  Both with and
> > > without this patch I get a path pointing to the main working tree:
> > >
> > >   $ ./git -C WT/ rev-parse --git-path logs
> > >   /home/szeder/src/git/.git/logs
> > >
> > > However, I'm not sure what the right path should be in the first
> > > place, given that each working tree has its own 'logs' directory, but
> > > only for HEAD's reflog, while everything else goes to the main working
> > > tree's 'logs' directory.
> > 
> > It's like Junio said, the reflog for `HEAD` is special because `HEAD` is
> > special. Look for `common_list` in `path.c` (it is a bit confusing, I
> > admit, you have to look for the 3rd column of numbers: if it is a `1`,
> > then it is a worktree-specific path, if it is `0`, it is supposed to
> > live in the "commondir", i.e. in the gitdir of the main worktree).
> 
> OK, got it.
> 
> I didn't look yesterday at all, but now I did, and, unfortunately, see
> two more bugs, and one of them is a "proper" bug leading to bogus
> output:
> 
>   $ git -C WT/ rev-parse --git-path logs/refs --git-path logs/refs/
>   /home/szeder/src/git/.git/logs/refs
>   /home/szeder/src/git/.git/worktrees/WT/logs/refs/

This one-liner below fixes it, but I haven't yet made up my mind about
whether this is the right fix or whether there could be any fallout
(at least the test suite doesn't show any).

  $ ./git -C WT/ rev-parse --git-path logs/refs --git-path logs/refs/
  /home/szeder/src/git/.git/logs/refs
  /home/szeder/src/git/.git/logs/refs/


diff --git a/path.c b/path.c
index 04b69b9feb..9019169418 100644
--- a/path.c
+++ b/path.c
@@ -335,7 +335,7 @@ static int check_common(const char *unmatched, void *value, void *baton)
 	struct common_dir *dir = value;
 
 	if (!dir)
-		return 0;
+		return -1;
 
 	if (dir->is_dir && (unmatched[0] == 0 || unmatched[0] == '/'))
 		return !dir->exclude;

