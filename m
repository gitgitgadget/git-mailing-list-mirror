Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFCCA1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 14:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbeHEQ5s (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 12:57:48 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:39322 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbeHEQ5s (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 12:57:48 -0400
Received: by mail-wm0-f53.google.com with SMTP id q8-v6so11580241wmq.4
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oD7/H0T22KrgCpd7MxeH38Jwzx/r4xW1DpOmHup+Opk=;
        b=iyxciXah0My9XGHLaLeCUe1nsaeJQezGMpTkkcmSSMV3m/neZv5YP01hB4vtI/4Dpl
         VX/bsdLb7I2B6HuHHai4ilVpCzyexPJ8Wglf5UCU651/lgvBe+nJwLjWS2C4Kt9Nj5DF
         lVfTZ7SOuCFCvBLrGR3lBcPjrU7AZ75By4wwHuQt+bKrbIjAMfIdyCPJh9c7bJQvlpFV
         hQEiQJugW3SJAZyli+ro4xfQoCebPmgXeNrWXIpMuQQPjluhOWnYFMb0YhZjf8TPEl17
         LQvGR7bAtfVZxY/doyKFFCHBt2CVnjAikY11NYu54vauB+iOcUih3QYh+JuvtnefMsRr
         ircw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oD7/H0T22KrgCpd7MxeH38Jwzx/r4xW1DpOmHup+Opk=;
        b=Z7pUENPdFfiXA1ImCB9NbzN2KAPP0RCt6Iqg/3AXxyvjYAekM9bnFxMmSDndOH90Am
         AaK9RZoc3+lA/FdHzkjQJ8dVWO5vhMvrV+YRPGg1MwwOOUtvAgA4jmv0XPrX5T6MLfls
         O23tyIJjw0yEZTGSz9vQeTDkfQ6PZLAP6qzPq/HmddvL0b2AVX/3rXZTZ7bTnIjdzgMP
         FN3ijJkZiv2BK5gD65d9rHNmpUwyDEViF6iPKTlPPaCIritkX7KZFpvb/i3AKewNsK9m
         a7mQvS/mm8BLk1fzToVIpC1PKrqNpaIl4DPaGOI6/Ue4vMyuccWeUvQ0ADygLodmbojp
         nZWA==
X-Gm-Message-State: AOUpUlHZNsK6GiqB9KYCcKwkNHs5Po0OkhK+2tSFk8g7lCay3ghKRaSH
        n0KDwNPbDgy7BGkbjOf91Ck=
X-Google-Smtp-Source: AAOMgpfd+X1bG48d+L+koZcp2f4fa3OJcGrMLlZaxfCdShqDcPDFBlx7XWU0OjC6WKVMyn7iGdMqVA==
X-Received: by 2002:a1c:9e89:: with SMTP id h131-v6mr9055596wme.13.1533480776117;
        Sun, 05 Aug 2018 07:52:56 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id t6-v6sm5070648wmf.8.2018.08.05.07.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 07:52:55 -0700 (PDT)
Date:   Sun, 5 Aug 2018 15:52:54 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Karen Arutyunov <karen@codesynthesis.com>
Cc:     git@vger.kernel.org
Subject: Re: git worktree add prints to stdout
Message-ID: <20180805145254.GF2734@hank.intra.tgummerer.com>
References: <631ae70d-9b5f-613d-5b6f-5064d548a894@codesynthesis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <631ae70d-9b5f-613d-5b6f-5064d548a894@codesynthesis.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/05, Karen Arutyunov wrote:
> Hello,
> 
> The 'git worktree add' command prints to both standard streams. So in the
> following example the first line is printed to stderr and the second to
> stdout.

git 2.18.0 should print both of those lines to stdout.  This was done
to match where 'git reset --hard' prints the 'HEAD is now at...'
message. See also the thread at [1] where we did make that decision.

[1]: https://public-inbox.org/git/CAPig+cQ8VzDycUMo-QOexNDBgQGEGj2BPmPa-Y0vhGCt_brbhg@mail.gmail.com/

> $ git worktree add ../pub build2-control
> Preparing ../pub (identifier pub)
> HEAD is now at b03ea86 Update
> 
> This looks like a bug, as, for example, the checkout command prints 'HEAD is
> now at...' message to stderr.

I think eventually it would be nice to write all those messages to
'stderr', as I think they do make more sense there.  I said I may do
that at some point in [2], but never got around to it yet.  If you
want to take a stab at it, feel free :)

[2]: https://public-inbox.org/git/xmqq604rzytx.fsf@gitster-ct.c.googlers.com/

> Best regards,
> Karen
