Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D73421FAED
	for <e@80x24.org>; Wed,  7 Jun 2017 20:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbdFGUli (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 16:41:38 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:34417 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbdFGUlh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 16:41:37 -0400
Received: by mail-io0-f171.google.com with SMTP id i7so12163076ioe.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 13:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QEjyrkqX8Qw0wNcnA6JPjebCUKPMKjyWBwTcSJfr36M=;
        b=FrJ+QorJka7kL6cfRafxKp+zrAokwD2w3SukpB+ejj/R8CMcbx7NqauGQEeb5eo2WD
         fRlF6eDC72NZ4KaMrDhf/hN4KxeCkbWbFJmwhe7fsyoL2CBfjH+zuLFRD+Tk7mR0dl65
         40bxha4LpoKCH558hCGXQMYZfgv6wteFDIu6g3zE5vTyG8XdbkGVPwnGuj9KqbzgvdEk
         fGSfEaXjbf3896Aw07AJt4GsTnw2pHN04XsIclrpujFXjhC+fvV6hWsqbUDccXuiNJYh
         iGCiG+f2VU01KfKKHxhdVKYdkaYSnPvEWHYGy33kJE4nFtxyaqj0oXauk1jjnVPFVU8z
         nvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QEjyrkqX8Qw0wNcnA6JPjebCUKPMKjyWBwTcSJfr36M=;
        b=L1LNa/jccOVNiwEkGipGknZm9CQAHC9cKZLC1KT3D4v9a85qlmA/kkVM57OWKlYSab
         pMTC5ylbWE0XjUsil89ridYJVo9MIwjKGSW3hRizMLGCk/HFxwkMHMTKnUOe1DyLhXiN
         4HRpUoN5pw9uVXSjxEPGNwrMgW2Ap8fSifMhAzE0ledsfvIAoz7pbO00baH+R9FUIz5l
         7wlDEuJm69Q+lG6hTKmA/BEsRTOqWfxQvJPQ3t5n5o2/9QBso5awPaGJ5klPw4Zsd1B7
         gW89MulU37Darosbk6MWkhez5lyiWX6GLOVPc8apuZzwhrC82DVCo7td/yoNI5EOY34U
         faRg==
X-Gm-Message-State: AKS2vOzlwdp4Oj3nbCzACH4qB/TccJyrTeZSL4vYN6sjWT5HYxaGwmYF
        0+KVntcWERtMEx8RrDS1tZU2rr6ats++
X-Received: by 10.107.19.17 with SMTP id b17mr13418546ioj.51.1496868096656;
 Wed, 07 Jun 2017 13:41:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.196.142 with HTTP; Wed, 7 Jun 2017 13:41:36 -0700 (PDT)
In-Reply-To: <CAPMsMoCi4JRB7e6DLLOx+i-Gbfeh=EXeytWPn0WruOPJQZ0vow@mail.gmail.com>
References: <CAPMsMoAYpS8QMrfyed5=XPWJLbV6=kMg5gp-2a75kWMpVD3D1A@mail.gmail.com>
 <20170607103326.GB27719@alpha.vpn.ikke.info> <CAPMsMoCi4JRB7e6DLLOx+i-Gbfeh=EXeytWPn0WruOPJQZ0vow@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 7 Jun 2017 13:41:36 -0700
Message-ID: <CAGyf7-GGo7VQX3pNVSOg6ZVOfipynxpHvHKWNfgvfDQ5ODcCtQ@mail.gmail.com>
Subject: Re: [BUG] Failed to sign commit
To:     pedro rijo <pedrorijo91@gmail.com>
Cc:     Kevin Daudt <me@ikke.info>, Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> $ GIT_TRACE=1 git commit --allow-empty -v -m "lol"
> 11:37:24.594795 git.c:369               trace: built-in: git 'commit'
> '--allow-empty' '-v' '-m' 'lol'
> 11:37:24.605842 run-command.c:369       trace: run_command: 'gpg'
> '--status-fd=2' '-bsau' '8AEC0DB537A9FC7E'
> error: gpg failed to sign the data
> fatal: failed to write commit object
>
> It seems more a gpg problem no? something not well configured after
> the update perhaps?

Have you tried running `export GPG_TTY=$(tty)` before running `git
commit`? I had a similar gpg error that was solved by that.
