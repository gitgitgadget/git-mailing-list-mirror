Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B98E20970
	for <e@80x24.org>; Mon, 10 Apr 2017 12:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753289AbdDJMBc (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 08:01:32 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33632 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752955AbdDJMBb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 08:01:31 -0400
Received: by mail-oi0-f49.google.com with SMTP id b187so144897521oif.0
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 05:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5q6NGTLeEwl0nbsI7jsCVQjhvE9w5ySufKoGft/extQ=;
        b=LMPAizrK3HbXlkkzSPmPbkxKwgKN8Gc78yeicJzGewgV7E7XH89lptfszyEz9bVQ2p
         /N8sdjN0OK2UO4SgOmqsizIK7Z8gTLgbV/fnD0oLSbH9dsMp/W7S8nL1OyorrtYwYxjw
         LV1XxcuN+qB5aS5nnH4Tng5bcRG9DFvo+RSc1uQMy2qMQSTv+Y9PI3D/ZIVEYojKF/TL
         YpdBeX1zxEgeiha0j1n2lFCiqLRJ5oeukjuf5jGsjqgP5BAMv+n0R5ADBesWt32gFyfM
         S/dbK9og03nk/fcJMjv+vbh/3JsyhSKAJMb7VdOlJ8r0kqLYq8FWcE0Gw4xGnSdwET6S
         EuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5q6NGTLeEwl0nbsI7jsCVQjhvE9w5ySufKoGft/extQ=;
        b=gj+tg9Okd7Jm3RplB/zMkHIbE5w5UymTL8iLWbxspDcWjfpgK0VCG9gsZygtQ1JfoN
         WW6uwsiCNja4VMbwpnN5mS/kZHTzfUvaKySsPVT5QsZ/+ZBXlRVWX6ih9X7qISTNddh0
         SUy62iFHra7lDJFxOW0PLhPCEjYEBsE1wLxrVuCOcziU+z6HMmf7SiQbhozmzeQMRaIB
         XtJ037hdM2N4IgKcFvt/7J+GIo0MrkdWB9KtpUZfHjyPDcJ6f+HPEeHGlem3ldT3nyQF
         2/pMZB2c8yCz2P2NWVIV8qHX9st2iCiK/JuYM2mNyWewH6lKk6gEAZ4y2p+AC6wyjLii
         ECQQ==
X-Gm-Message-State: AN3rC/6mQW45nO+EWpEZ1eVU3AuGH1vwecnCtp4IMUoZhU9pigoSSN0poU6opY742iuB8cDTLSD3ykrgdIsIcQ==
X-Received: by 10.202.214.141 with SMTP id n135mr2182754oig.186.1491825690798;
 Mon, 10 Apr 2017 05:01:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Mon, 10 Apr 2017 05:01:00 -0700 (PDT)
In-Reply-To: <xmqqvaqdqfhe.fsf@gitster.mtv.corp.google.com>
References: <20170409022128.21337-1-danny@dannysauer.com> <alpine.DEB.2.20.1704091238560.4268@virtualbox>
 <413a1456-cac6-56c8-ea45-38f14cf958ae@dannysauer.com> <xmqqvaqdqfhe.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 10 Apr 2017 19:01:00 +0700
Message-ID: <CACsJy8CLBY22j3EjR4PW3n+K6PWUzb-HCgxTVeCGpwtApZF-6g@mail.gmail.com>
Subject: Re: [PATCH] Make git log work for git CWD outside of work tree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Danny Sauer <danny@dannysauer.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2017 at 7:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> If your arrangement is even more exotic, e.g. you have these two
> variables set, and then are running from OUTSIDE the working tree,
> my knee-jerk reaction is that you should get your head examined, as
> it is totally unclear what "git add foo" would mean if you did this:
>
>     $ export GIT_DIR=~/myproject/.git GIT_WORK_TREE=~/myproject
>     $ cd ~/myproject/../somewhere/else
>     $ git add foo
>
> But it should still "work" in the sense that the above command
> should notice that you are trying to add "../somewhere/else/foo" to
> the index, which is obviously nonsense, and die with a message.
>
> Similarly, if you replace "git add foo" with "git log", it still
> should work in the above, i.e.
>
>     $ export GIT_DIR=~/myproject/.git GIT_WORK_TREE=~/myproject
>     $ cd ~/myproject/../somewhere/else
>     $ git log
>
> If Git is not chdir(2)ing to ~/myproject before calling cmd_log()
> in the above (again, this is my down week so I didn't and will not
> check with the code myself), we may want to call that a bug and fix
> it, so that you do not have to do anything special to get to the
> path of ".mailmap" that is at the top-level.

The behavior is "documented" in t1510 since f3bb8b4b84 (Merge branch
'nd/setup' - 2010-12-28)

"11. When user's cwd is outside worktree, cwd remains unchanged,
    prefix is NULL."

This behavior probably started long before my topic though, mine was
more of documentation, making worktree detection more consistent. It's
the same case with defining GIT_DIR without GIT_WORK_TREE, I think:
scripts started to depend on a behavior that we did not clearly
define, by the time we knew what we wanted and we kept the old
behavior forever.

I think it's just safer to go with Johannes' suggestion.

An alternative is, when you have found out you need to read .mailmap,
you call setup_work_tree() then, which prepares the worktree for you
(including moving back to cwd) or dies if worktree does not exist, or
no-op if worktree has already been asked by somebody. Many commands do
lazy worktree initialization this way.
-- 
Duy
