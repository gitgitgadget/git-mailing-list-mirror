Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0BC91F405
	for <e@80x24.org>; Sat, 29 Dec 2018 04:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeL2EWs (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 23:22:48 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:55460 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbeL2EWr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 23:22:47 -0500
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Dec 2018 23:22:47 EST
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 81BCF1F405;
        Sat, 29 Dec 2018 04:16:15 +0000 (UTC)
Date:   Sat, 29 Dec 2018 04:16:15 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?6IKW5bu65pm2?= <06271023@bjtu.edu.cn>
Cc:     git@vger.kernel.org
Subject: Re: a git svn bug
Message-ID: <20181229041615.ay7pazjqozbvz7qz@dcvr>
References: <650358a3.8395.167f09e21b6.Coremail.06271023@bjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <650358a3.8395.167f09e21b6.Coremail.06271023@bjtu.edu.cn>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

肖建晶 <06271023@bjtu.edu.cn> wrote:
> hi,
>    git developers. I found a bug when i want to convert webkit to git
>    there are some branch named safari... in webkit svn repo.
>    when i want to convert them to branch in git. a problem happen.
> 
>    if you want to reproduce the problem, just follow the guide below.
>    1. git svn clone -s https://svn.webkit.org/......

Do you mean  https://svn.webkit.org/repository/webkit ?

>    2. when it runs to about r13800, stop it and rerun the above command

So running "clone" again?  Normally, I'd run "git svn fetch" if
I stopped and want to resume (or my Internet connection drops,
which happens a lot).

>    3. the git client will check the refs it already found, and
>    if it met a ~ in the branch name. it will failed to
>    proceed. error is git thinks it an invalid ref name
>j
>    i digged into it, and found a solution in
>    git/perl/git/svn.pm. I mod this file and bypass the
>    problem.

Can you show us what you did to perl/Git/SVN.pm?

the "refname" sub in perl/Git/SVN.pm already escapes "~",
it seems.

>    plean be kind to fix the problem and remind me the fix
>    commit, and i will update to a new version.

We'll try, but I think we need more information.  Thanks.
