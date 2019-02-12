Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8380F1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 23:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbfBLXSm (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 18:18:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35094 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731567AbfBLXSm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 18:18:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id t18so431301wrx.2
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 15:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HPvUIXl0fchhBo7+XGj/dHFwOsnU8sp3mPIq6aEwzL4=;
        b=fRQOuLb4Y6lnAlBffiGKgfyCV+HLgV6Uz3o40Hpd/jA6vLmxl5Cyidw7SDqSQx73D5
         36emNzgrjAF+2UD+iHcfXwpBmaLp5suq++aUQe+fzKjmPs6cfKaN+KLWxy57j0ghRZEo
         XUZ7SbDn/+Bph1oRte4aMiMoNxGRjPZtigH3Av4/sSglM9daHxn4Lr/8/HFihJJZaG6v
         TiX3jeu/ENkTXrgZOe6eyXK6KdqD8fvCZu4iZ+GxKaIfDGYOPnPODXuAUiDhpdCIYflL
         K/rGhCznDLg5Bc32w1nww3G8fcNrLxQoMfkDmQLzUTgSL1W2D9jMAZON8a80DIbzGWFT
         EhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HPvUIXl0fchhBo7+XGj/dHFwOsnU8sp3mPIq6aEwzL4=;
        b=Xf9/+3lNXWOFcYpxo9r3FTCGpemcPT2gOwrNNZSoZCElg271HLBY6MbLIxFAANNCUe
         RwyYVMiFh1PliG1gYtKynxmZxROpYfVu1MvZK0VmdLwH8zJGdpDWbD2vFyVtFtJfD8VR
         z/ABbccseLElfyagWFVheOEgdr2GaXMnPJncOo+IKKXpaQGZZ6WTUu9iWuJMJl4jOzjG
         YE+ySq0/uJhIGfGBkPBEl6uH4uNuTSDw0d8JrQn9epE4ZzujQw/faSYgP5X/w/ibtXEt
         WYwoZfQ7cPRGmJL38Oj4BRXnbMhmkOa08qOFKiAnMV3K4c+Hg5nio+O3T/Hby7sSo4sL
         aJMg==
X-Gm-Message-State: AHQUAuZBsWPLtrWQtLGvzp6kVzJebnu5xXgdrWQj3H4uShVuGVmNInnO
        BxT/CKJJnkNCbrbo33xR7qs=
X-Google-Smtp-Source: AHgI3IZl4Eq1wcCuedHLUkP8wQH8QSaLZ9YRWkBea5c7cnlQX07gDeVfaveuU7WT0Vn+V5/xEYjEJA==
X-Received: by 2002:adf:f101:: with SMTP id r1mr4829499wro.32.1550013520375;
        Tue, 12 Feb 2019 15:18:40 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id o18sm26590734wrg.40.2019.02.12.15.18.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 12 Feb 2019 15:18:38 -0800 (PST)
Date:   Tue, 12 Feb 2019 23:18:37 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v12 18/26] stash: convert push to builtin
Message-ID: <20190212231837.GI6085@hank.intra.tgummerer.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
 <a6692eef2ca7c9d9e4701f087269d537248a4941.1545331726.git.ungureanupaulsebastian@gmail.com>
 <20190208113059.GV10587@szeder.dev>
 <20190210221712.GA9241@hank.intra.tgummerer.com>
 <20190211011306.GA31807@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190211011306.GA31807@szeder.dev>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/11, SZEDER Gábor wrote:
> On Sun, Feb 10, 2019 at 10:17:12PM +0000, Thomas Gummerer wrote:
> > On 02/08, SZEDER Gábor wrote:
> > > On Thu, Dec 20, 2018 at 09:44:34PM +0200, Paul-Sebastian Ungureanu wrote:
> > > > Add stash push to the helper.
> > > > 
> > > > Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> > > 
> > > This patch causes rare failures in 't3903-stash.sh', I've seen it
> > > break for the first time today in a Travis CI build:
> > 
> > Thanks for reporting this.  I was going to take a look at it, but
> > unfortunately I can't seem to reproduce the issue even with --stress
> > (I let it run for ~1000 repetitions and then aborted it).
> > 
> > Which platform did you see/test this on, and which compile options did
> > you use?  I went through a failures on
> > https://travis-ci.org/git/git/builds, but couldn't find this
> > particular one.  Could you point me at the failed run?
> 
> It was in a Linux build job in one of my custom CI builds [1]:
> 
>   https://travis-ci.org/szeder/git-cooking-topics-for-travis-ci/jobs/490420713#L3401
> 
> and I tested it locally on Linux as well.  I don't think there are any
> unusual compiler options.  I run it with --stress on Travis CI's macOS
> as well, but couldn't trigger a failure there.

Thanks.  I still didn't manage to reproduce it locally, but I was now
able to test it on Travis CI.

The diff below fixes the issue, but I still need to spend some time to
better understand why it does.  I'll hopefully be in a position to
send a patch with a proper log message why this is the right fix in
the next couple of days.

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index c77f62c895..3dab488bd6 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -231,6 +231,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	struct tree *tree;
 	struct lock_file lock_file = LOCK_INIT;
 
+	discard_cache();
 	read_cache_preload(NULL);
 	if (refresh_cache(REFRESH_QUIET))
 		return -1;


> [1] That build log doesn't include the trash dir of the failed test
>     in the log, most likely because of a faulty merge conflict
>     resolution on my part, but you can find a failed trash dir
>     embedded here:
> 
>       https://travis-ci.org/szeder/git/jobs/491401882#L2309
> 
