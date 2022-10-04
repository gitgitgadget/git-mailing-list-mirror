Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4839EC433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 11:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJDLVf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 07:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiJDLVc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 07:21:32 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4DE252AF
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 04:21:31 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 8B258240104
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 13:21:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1664882489; bh=Vynlf7Tw63DTfajW4hBqQVGlJEG9ZPXUz/aTfD/ACrQ=;
        h=From:To:Subject:Cc:Date:From;
        b=atp+gldsSduzhqesfooGRfc6fUnAsHph3iwiSG3sEpDGKhuPXzp/ZMF/F4ufHdXpr
         B5VxEel86Cs/BI4jPGjv14uwLIxYz468b3+pZle1viUWHKFoq6jjqw5ll9cA3EMs0X
         ykmJjQLfjhq9HOS2MjKWtswofNSsnfvR1mwDPOJ5JHhngS7xS/psjb/J2BpszuYrj9
         MoDc62jZCecdIcIfab2tyQYaC1ZAla1DRbdIHCntQvHkWHhmfSpO5O2RPAefAnX138
         J+q4RqpP7vrDK0vWiRn+dXHICqPHFEyXBqE82n9ua4w6hVis1QtqNA/yyNmVNG+B3Y
         Vs3OThR+KTkxA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4MhZyw01S8z9rxR;
        Tue,  4 Oct 2022 13:21:27 +0200 (CEST)
From:   "Tim Jaacks" <timjaacks@posteo.de>
To:     "Jeff King" <peff@peff.net>,
        =?utf-8?q?SZEDER=20G=c3=a1bor?= <szeder.dev@gmail.com>
Subject: Re: Bash completion for git aliases containing nested subcommands
Cc:     git@vger.kernel.org
Date:   Tue, 04 Oct 2022 11:21:11 +0000
Message-Id: <em34822e40-c62f-43aa-bc9b-2a87e9033ee8@acer-switch-tim>
In-Reply-To: <YzthDLdqeQx6bEcj@coredump.intra.peff.net>
References: <em8d7ca854-51a3-4cb5-aaf9-30ed37b4194b@acer-switch-tim>
 <20221003142437.GB7659@szeder.dev> <YzthDLdqeQx6bEcj@coredump.intra.peff.net>
Reply-To: "Tim Jaacks" <timjaacks@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

thanks a lot for your reply.

 > It feels like this ought to be able to work, for the same reason that
 > "git stash show <TAB>" works. In the non-aliased case, we call into
 > _git_stash(), and it sees that "show" is already there on the command
 > line. But in the aliased case, we know "show" is part of the alias but
 > throw away that information completely, and never feed it to
 > _git_stash() at all.

I actually got the same impression when looking into the=20
__git_aliased_command implementation. I just wasn't familiar enough with=20
the code to actually come up with a solution. So thanks for your patch,=20
that makes my use-case work indeed! Do you think there's a chance to get=20
this upstream?

Best wishes,
Tim

