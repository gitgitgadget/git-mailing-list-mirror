Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7B251F462
	for <e@80x24.org>; Thu, 13 Jun 2019 16:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393157AbfFMQ6k (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 12:58:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38728 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393245AbfFMQ6h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 12:58:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so21559497wrs.5
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QICPNKRHZKGbRSxKunDkunQlIqyXoMFa3lNPMILh2tE=;
        b=Uf9dL/K4/FdI5W4rFeg/ahqj2oiinoicQ3k+m+GVhMSJ1203yoL24aoZele6iNm2/I
         EfelbwSt8VmuuzyMXHRjY0hR2fYZdYLOYn2+4rHKozH69UdEu7WJ696VvP1Xs9qtuvuU
         Qi2U3wd9my2PJGpU2Nm7RHtqqd0y3hOJHF6MqiRyr2zCKqlAn5Uce0B//rUzjZKPzwyM
         K4HJu5GiVFNAj5daZx0mFnFLGB0+BWH3shNr0n5G70S04lTUgbsCkBWbgpVXJpMQovVU
         7QshZADkrlT3rlZQ6KE3wfZ9Ch7YMk68ag+4PS1H7X2ZCPRB2FsIam9emnw3uVCCWaz9
         rFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QICPNKRHZKGbRSxKunDkunQlIqyXoMFa3lNPMILh2tE=;
        b=BdSLG1onL4IifJiD/wW461V263g+fU9G8VJQLaJg1hRFi4y9UnTHfEnf9PhNwP0wst
         uirzpopaYiRKpFR+SzwgPHbTz+oEce2cCCRUF3rF/3puSPPPH5hfyw82OKIL5MlxqFR1
         H56jrKSvdpBZ0FyYNOsGvIkmfXUIxGdKfGR1bNUleU8iq7YOKoXDuGD+9bR93Gbn7Hk1
         FSuzfB+kz3wN+lHmTTxmYIHE+rgXjqfkPsT7hte3Pm0ewr/4ZMOVaHZgFf2lbaoZhqmx
         R0RX8eUiw530jp14hl+D+6fZT0xtTCHr62GmmsTc03Raw6yPvgYX0bn/e3S/7HVFuayf
         z/Bw==
X-Gm-Message-State: APjAAAUoAj1gSFphwF7+LBDdmVDWN0Tu62B5nQDadcJ7SW/9yO5dew+l
        P8UI0xuryWKUaI2bDNbFo+I=
X-Google-Smtp-Source: APXvYqyxHQd+yfophz1qpOI4wCloCs5gebKrTwLqljUz/dLsfFnIisoRMVNQJg6CZOAYRsoM8WmXPA==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr30513603wrv.268.1560445115844;
        Thu, 13 Jun 2019 09:58:35 -0700 (PDT)
Received: from szeder.dev (x4dbd2f68.dyn.telefonica.de. [77.189.47.104])
        by smtp.gmail.com with ESMTPSA id x3sm120675wrp.78.2019.06.13.09.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 09:58:35 -0700 (PDT)
Date:   Thu, 13 Jun 2019 18:58:33 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     aleksandrs@ledovskis.lv,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Espen Antonsen <espen@inspired.no>, git@vger.kernel.org
Subject: Re: Git status parse error after v.2.22.0 upgrade
Message-ID: <20190613165833.GD31952@szeder.dev>
References: <3bc58c33-4268-4e7c-bf1a-fe349b3cb037@www.fastmail.com>
 <nycvar.QRO.7.76.6.1906112127420.789@QRFXGBC-DHN364S.ybpnyqbznva>
 <38b0f33a-1da1-4231-802e-ae14d9843ad2@www.fastmail.com>
 <nycvar.QRO.7.76.6.1906122046400.789@QRFXGBC-DHN364S.ybpnyqbznva>
 <20190613093023.GA3919@ariake.ledovskis.lv>
 <xmqqr27xwjwj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr27xwjwj.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 13, 2019 at 09:05:16AM -0700, Junio C Hamano wrote:
> aleksandrs@ledovskis.lv writes:
> 
> > My repo indeed contains a ".git/sequencer/todo" file which
> > contains references to commits long-gone (i.e., rebased).
> > Renaming or deleting this file stops whines about "error: could
> > not parse".
> 
> Interesting.  So in short, when the repository has leftover
> sequencer state file that is not in use, "git status parse" thing
> (whatever it is---are you getting it when you run "git status"
> command???)---is not careful enough to notice that it does not
> matter even if that leftover file is unusable.
> 
> Two issues "the sequencer" folks may want to address are
> 
>  (1) make the one that reads an irrelevant/stale 'todo' file more
>      careful to ignore errors in such a file;
> 
>  (2) make the sequencer machinery more careful to clean up after it
>      is done or it is aborted

It may or may not be related, but...  Some weeks (months?) ago I run
into a situation where 'git rebase' didn't clean up after itself
following a well-timed ctrl-C, and got confused to the point that not
even a subsequent 'git rebase --abort' was able to rectify the
situation.

So, I wanted to rebase just a couple of commits to somewhere else, but
messed up the command's parameters, and it then tried to rebase a
couple hundred commits.  Upon noticing the unexpectedly large numbers
in the "Generating patches" progress line I hit ctrl-C, and then the
aborting 'git rebase' apparently left an incomplete/corrupted
'.git/rebase-apply/' directory behind.  Unfortunately I didn't think
about saving the precious corrupted state, and deleted that dir right
away...  only saved the transcript from the terminal later:

  ~/src/git (test-atexit)$ git rebase js/test-atexit 
  First, rewinding head to replay your work on top of it...
  Generating patches: 100% (509/509), done.
  ^C
  ~/src/git ((42e6cb0046...)|REBASE 1/509)$ gitk js/test-atexit 
  ~/src/git ((42e6cb0046...)|REBASE 1/509)$ git rebase --abort 
  error: could not read '.git/rebase-apply/head-name': No such file or directory
  ~/src/git ((42e6cb0046...)|REBASE 1/509)$ git reset --hard
  HEAD is now at 42e6cb0046 git-p4: use `test_atexit` to kill the daemon
  ~/src/git ((42e6cb0046...)|REBASE 1/509)$ rm -rf .git/re
  rebase-apply/    rebased-patches  refs/            
  ~/src/git ((42e6cb0046...)|REBASE 1/509)$ rm -rf .git/rebase-apply/
  ~/src/git ((42e6cb0046...))$ git checkout -


