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
	by dcvr.yhbt.net (Postfix) with ESMTP id BC9391F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 20:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388161AbfJRUkh (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 16:40:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54962 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbfJRUkh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 16:40:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so7439835wmp.4
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 13:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SzZ5jbF/C6mwCk8IXlPf1nZQCM6HV7ZpBEu4kSILnvY=;
        b=gHpfouxedore8JQh8R6iwJleFikGpWvijLxZuiv+JZnrr6Z/5oS5I8SDyAOHE+Hzll
         a/qAuciTMXfo8Y/5KsIqyrb+q//8mm+LCo6wLEu9nGm+x5ouyTtlXW2Y+g8JL7IT9o+O
         iobO4XV/X3ZJe9zh1OPeh+wKwA9QKfXQ84bX+HD4lPH/p+QEcaQ0VHrIl9cRSsKdaXf0
         4/55tfasdFUY0zpXs8PyBu1a+5/GRPEb5c68wRvsYDAMrp6gXX3N9klv6mXcxEeNo1ks
         Cse0TY304EKp/fueDCqSgmWph2QvgEcl4xMVX0i6RTHJGr5Mk1hN3Al4HgoNZKsI1WsY
         UB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SzZ5jbF/C6mwCk8IXlPf1nZQCM6HV7ZpBEu4kSILnvY=;
        b=XCaQ2gGaDk8HB7uDssOvOwbtI+68ah4EnDZkBPeSH5BlNdV028hFyozx0EdCgZer8f
         QrSqsW0jE8yy1y7d8LngLIKVkPMQ9n4Gnpj/bIx4m53JQOZv+/ef2yP/j3PCOMOp9BUE
         IcvjXfs/GcmHBLor33EwtU/6G0z6hqLC2Oe2BU5qfmqhEk+TXa3CB2/YlDOtz6DWJkS2
         WPXsopF1MArvLV0G+lQ9PEynZyL6iOClmzjSZXO1dKHAM4kodyxUcKp+YTN3G8fs6kgB
         rmm9etlt9DiBrIWKgRqv/+fl5GqBYgJhwDa59KURU9tQgHKHZZvjqehQCwPMzGwdpqiP
         N/nQ==
X-Gm-Message-State: APjAAAWfvTaFu7UkawHo37l70lvoMK3MrWH1e53XcmnPjES5rtkVtdpW
        Vw8aqjAoNx+e/5TxyONTAZ8=
X-Google-Smtp-Source: APXvYqyn11mzVZiT7cRj8Yk2Zp3tBky7p982MRYBwSYkgSL6ToJT0m2ynIczb2y1t8FB5wIbdtq//Q==
X-Received: by 2002:a1c:4386:: with SMTP id q128mr9605445wma.39.1571431235606;
        Fri, 18 Oct 2019 13:40:35 -0700 (PDT)
Received: from szeder.dev (x4dbd7267.dyn.telefonica.de. [77.189.114.103])
        by smtp.gmail.com with ESMTPSA id p68sm3902680wme.0.2019.10.18.13.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 13:40:34 -0700 (PDT)
Date:   Fri, 18 Oct 2019 22:40:32 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 15/17] sparse-checkout: update working directory
 in-process
Message-ID: <20191018204032.GK29845@szeder.dev>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
 <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <9ccec3ca9a1efe038da6d69f076f32cc407bcf9f.1571147765.git.gitgitgadget@gmail.com>
 <20191018202421.GJ29845@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018202421.GJ29845@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 18, 2019 at 10:24:21PM +0200, SZEDER Gábor wrote:
> On Tue, Oct 15, 2019 at 01:56:02PM +0000, Derrick Stolee via GitGitGadget wrote:
> > From: Derrick Stolee <dstolee@microsoft.com>
> > 
> > The sparse-checkout builtin used 'git read-tree -mu HEAD' to update the
> > skip-worktree bits in the index and to update the working directory.
> > This extra process is overly complex, and prone to failure. It also
> > requires that we write our changes to the sparse-checkout file before
> > trying to update the index.
> > 
> > Remove this extra process call by creating a direct call to
> > unpack_trees() in the same way 'git read-tree -mu HEAD' does. In
> > addition, provide an in-memory list of patterns so we can avoid
> > reading from the sparse-checkout file. This allows us to test a
> > proposed change to the file before writing to it.
> 
> Starting with this patch there is an issue with locking the index:
> 
>   $ git init
>   Initialized empty Git repository in /home/szeder/src/git/tmp/SC/.git/
>   $ >file

  $ git add file

Forgot to copy that command...

>   $ git commit -m initial
>   [master (root-commit) 5d80b9c] initial
>    1 file changed, 0 insertions(+), 0 deletions(-)
>    create mode 100644 file
>   $ ls .git/index.lock
>   ls: cannot access '.git/index.lock': No such file or directory
>   $ git sparse-checkout set nope
>   warning: core.sparseCheckout is disabled, so changes to the sparse-checkout file will have no effect
>   warning: run 'git sparse-checkout init' to enable the sparse-checkout feature
>   error: Sparse checkout leaves no entry on working directory
>   fatal: Unable to create '/home/szeder/src/git/tmp/SC/.git/index.lock':
>   File exists.
> 
>   Another git process seems to be running in this repository, e.g.
>   an editor opened by 'git commit'. Please make sure all processes
>   are terminated then try again. If it still fails, a git process
>   may have crashed in this repository earlier:
>   remove the file manually to continue.
>   $ ls .git/index.lock
>   ls: cannot access '.git/index.lock': No such file or directory

I would add that building the previous patch and running the same
sequence of commands works, in the sense that 'git sparse-checkout
set' writes the non-existing filename to the 'sparse-checkout' file
and it prints the same two warnings, and doesn't (seem to) attempt to
update the working tree and the index.

