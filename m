Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 101FF2027C
	for <e@80x24.org>; Mon, 29 May 2017 10:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750903AbdE2KhJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 06:37:09 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33648 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbdE2KhI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 06:37:08 -0400
Received: by mail-oi0-f45.google.com with SMTP id w10so74597252oif.0
        for <git@vger.kernel.org>; Mon, 29 May 2017 03:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7n1FG/c2W/rnPFYRkslaR5cSY/FcRbIDbPIhJf/CJcs=;
        b=EPSX9h98d7Ld87kKWm0m4vL1jlYLG3BChKpNbsSJQEgW61+GvdsulUqRAKi0dfmhS1
         /+WUjrk5NLh0NaxkZgoQkjcvk7wkvmzxpmQMRrXzbbVyvQvTL2BCnGu8M4/qh24hUOQb
         YD2QnY7mbS5vUY9j0KauZ8J237Wsja/XkhiZgUvFcwk6B/N8Hoqq5pCNXyVWZQcsX+iZ
         BZrV6TDRUwpy68QvmSIeEqbCasv1zOw8XVvbxBfJcoewGhZLGlq6rh57PKE+0z0SWvy5
         jIDtFTAHHpCFfDdRKaC9dA+ACNeVIyzct70RyA+gBUwABkSufxzCvnZMxUVtkQZy/E34
         L8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7n1FG/c2W/rnPFYRkslaR5cSY/FcRbIDbPIhJf/CJcs=;
        b=i1OzbX4liz5P91bzv9I1pq3HEOisEv3oWo/6/pt80sU9ae6dOpwri4d2RtBK28tVWt
         fMlADlTc2jTzpl/y+J4CZU4TC0JfP1QjDyb4hGxpxXcCxR2b6hWdkEPmEZjcAlLmtX2D
         NGoNolvOSDxTiLt/G0yBs6UdntukQF28QESiZkmEJLxI48CFb4JTwsWet/dP45EfsHyS
         lKm0aSjtfIBjH4t5nRESEYhDFyzL+Tww3NOfz6r2uB4wS1x1Cbcx6Gmrhm/dHdOwL8O1
         Y1rh6P3kKM8bdxVZa0Fsh84oDRUKT957HWu+MZsWNh+qLYVDmBfJyonidpZYNW+gl80q
         IQ0g==
X-Gm-Message-State: AODbwcBmyVsh/RA3VKh6gb9kyxWiOmpIwJVJRhuhc5PtTdSuqVcxNw1k
        9cH6vnA1G5iZfyp2+f0dky3KFbmgsg==
X-Received: by 10.202.81.12 with SMTP id f12mr7236124oib.66.1496054227844;
 Mon, 29 May 2017 03:37:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.145.17 with HTTP; Mon, 29 May 2017 03:36:37 -0700 (PDT)
In-Reply-To: <20170522193535.7cgivd6pmmqhw7ze@sigill.intra.peff.net>
References: <20170518232134.163059-1-bmwill@google.com> <20170522193535.7cgivd6pmmqhw7ze@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 29 May 2017 17:36:37 +0700
Message-ID: <CACsJy8DmsG_+ASEkisUTLejVkiOmYytvTCTQs=RCH6q=BeDAhg@mail.gmail.com>
Subject: Re: [WIP/RFC 00/23] repository object
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 23, 2017 at 2:35 AM, Jeff King <peff@peff.net> wrote:
> On Thu, May 18, 2017 at 04:21:11PM -0700, Brandon Williams wrote:
>
>> When I first started working on the git project I found it very difficult to
>> understand parts of the code base because of the inherently global nature of
>> our code.  It also made working on submodules very difficult.  Since we can
>> only open up a single repository per process, you need to launch a child
>> process in order to process a submodule.  But you also need to be able to
>> communicate other stateful information to the children processes so that the
>> submodules know how best to format their output or match against a
>> pathspec...it ends up feeling like layering on hack after hack.  What I would
>> really like to do, is to have the ability to have a repository object so that I
>> can open a submodule in-process.
>
> We could always buy in fully to the multi-process model and just
> implement a generic RPC protocol between the parent and submodule gits.
> Does CORBA still exist?
>
> (No, I am not serious about any of that).

CORBA or not, submodule IPC is a real pain. That was what I felt
reading the super-prefix changes a few weeks ago. Some operations
might benefit from staying in the same process, but probably not all
(and we lose process protection, which sometimes is a good thing)

>> This is still very much in a WIP state, though it does pass all tests.  What
>> I'm hoping for here is to get a discussion started about the feasibility of a
>> change like this and hopefully to get the ball rolling.  Is this a direction we
>> want to move in?  Is it worth the pain?
>
> I think the really painful part is going to be all of the system calls
> that rely on global state provided by the OS. Like, say, every
> filesystem call that expects to find working tree files without
> prepending the working tree path.
>
> That said, even if we never reached the point where we could handle all
> submodule requests in-process, I think sticking the repo-related global
> state in a struct certainly could not hurt general readability. So it's
> a good direction regardless of whether we take it all the way.

I doubt we would reach the point where libgit.a can handle all
submodule operations in-process either. That would put libgit.a in a
direct competitor position with libgit2. I do hope though that having
clearer/modular data structure will improve readability, not hurt it
(e.g. you see the data model and could largely guess how the code
interacts before digging deep in).
-- 
Duy
