Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FE871F42D
	for <e@80x24.org>; Sun, 27 May 2018 12:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032644AbeE0M2x (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 08:28:53 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:30201 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030283AbeE0M2w (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 08:28:52 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id Mun2fZV2nbZX5Mun2fQVRA; Sun, 27 May 2018 13:28:50 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=Kb-62-Ow0rOoadUCKW0A:9 a=QEXdDO2ut3YA:10
Message-ID: <1EAAF778D73B4AA689ADB5AE2EE9D1DD@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     =?UTF-8?Q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
        <git@vger.kernel.org>
References: <CAAUqJDu_3DTyd1cFKaNRKOzo3AHosfxP1jjWpa=HGtyAyitTeA@mail.gmail.com> <CAAUqJDvsRBJWZh5_A2e2x-CqgXi5gLSjo6-P2sYxsKz3qfidSw@mail.gmail.com>
Subject: Re: git rebase -i --exec and changing directory
Date:   Sun, 27 May 2018 13:28:50 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180527-0, 27/05/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfPudDE0MO3WvtWZPapr8Hwm9+rGMNlanphNL5TVT4WMEgru0CbCIl1wkqJs9kLrUY2ERk6JmIwuxBFoOobjVN2gBld7O3q4+vaIjZ9rTbXrKjRPCrAaU
 qDvrNxJszuGn6JMkdY1NgSCMQ8XD3uP0iY9QroAYqWaN7uHdt8OeSW0BC6dmPUqcO14gfgoZ0zdLCgkIDe2S54wR4q8dXHWjSMU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You may need to give a bit more background of things that seem obvious to 
you.
So where is the src directory you are cd'ing to relative to the 
directory/repository you are creating?
What is [the name of] the directory you are currently in, etc. ?

Philip
--

From: "Ondrej Mosnáček" <omosnacek@gmail.com>
Bump? Has anyone had time to look at this?

2018-05-19 18:38 GMT+02:00 Ondrej Mosnáček <omosnacek@gmail.com>:
> Hello,
>
> I am trying to run a script to edit multiple commits using 'git rebase
> -i --exec ...' and I ran into a strange behavior when I run 'cd'
> inside the --exec command and subsequently run a git command. For
> example, if the command is 'cd src && git status', then git status
> reports as if all files in the repository are deleted.
>
> Example command sequence to reproduce the problem:
>
>     # Setup:
>     touch a
>     mkdir dir
>     touch dir/x
>
>     git init .
>     git add --all
>     git commit -m commit1
>     git tag base
>     touch b
>     git add --all
>     git commit -m commit2
>
>     # Here we go:
>     git rebase -i --exec 'cd dir && git status' base
>
>     # Spawning a sub-shell doesn't help:
>     git rebase -i --exec '(cd dir && git status)' base
>
> Is this expected behavior or did I found a bug? Is there any
> workaround, other than cd'ing to the toplevel directory every time I
> want to run a git command when I am inside a subdirectory?
>
> $ git --version
> git version 2.17.0
>
> Thanks,
>
> Ondrej Mosnacek

