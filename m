Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0C741F403
	for <e@80x24.org>; Mon, 11 Jun 2018 15:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932941AbeFKPtR (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 11:49:17 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34713 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932914AbeFKPtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 11:49:16 -0400
Received: by mail-ua0-f196.google.com with SMTP id 74-v6so13863903uav.1
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 08:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MUXkqO+K3h9hZ98U3wpewU98aghsIyAI1AJJb8IdRPE=;
        b=FrOlpCOjU5bi/Kbi2o7YOSQrii5de5ochxQulXnCuA2JVP17AIyEvEbnwlIwNSb8tr
         v1Z3kDT5OT9OpFOSks//Fi8MYI//ruJT31MctORhuEC/A0FlbpleQdpOcKeStgp1sSPd
         7zIDOA2jx/qX2ULSXH6/ozuvWqsCYzd2f5CfnaUeOt/WwmM9N8BVqEdD8P+WczC6+qaU
         IosNQnZTYS4p6FQfKt3buwGcAO3PcJG0F9VKJXjYtg6idUEVFQILngZ/EGGYnsUb0ITK
         wIj1Eyk/MD/EEUFe9c160UhcY+r2NjpKN3V441oMJSJ/aOAhBnUQZna7po8EJOAZ+eMa
         3MvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MUXkqO+K3h9hZ98U3wpewU98aghsIyAI1AJJb8IdRPE=;
        b=Ro57oYg8Ef0iVwWe6gckfTrD7AMDe+otjExGKaSO3g6PS3T6n1ZlWN4K7esS9m+9N5
         2pyAU17PqHQ2CuHnxTvwa23me4LrOkG9OEnhaSAOkI2BaTVKzDmdKuLUvfKKcDo4nXW6
         bZ/5aMbZMlvHdOXyRy6tAW7iQZ0AwgbzJP8qrekRixrFD2Byl+VrRHiRVLLoMR+H6Dvk
         MwLUDvni32JkAmHj/1GvIju0LxCoRsO3mFKQIXNTErNU28dFTZwvKYb912eJa7AMtPKS
         JCyvbUMBAzpJWV5rmoIJ1B9i4+FGdpKf58g+Atm0TdZ7iDaUrz5/312gZ3yrD0clhx1h
         boEw==
X-Gm-Message-State: APt69E3s20kyGqZMBVPsFKIZ19SrpOiH9N1umYTQZ8QELdDFRAUHq9uk
        5tbLqT40wjT12r1KdNWqcMEsQtITXn/e8NbrlpLJgA==
X-Google-Smtp-Source: ADUXVKIUHeg7f/EpyJPxMv/qhnVpxpZUYhbrnmgjB6sgcpVs8a2Jy/WcQoPVUnSxTBoT62If5ASKWxybFjPo1sYFo/c=
X-Received: by 2002:ab0:596f:: with SMTP id o44-v6mr11701870uad.29.1528732155213;
 Mon, 11 Jun 2018 08:49:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 08:49:14
 -0700 (PDT)
In-Reply-To: <cec770a8-28ee-d546-8c27-905d2fcdb0c8@talktalk.net>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607050654.19663-1-newren@gmail.com> <20180607050654.19663-2-newren@gmail.com>
 <cec770a8-28ee-d546-8c27-905d2fcdb0c8@talktalk.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Jun 2018 08:49:14 -0700
Message-ID: <CABPp-BF6HapQ=tcWu4j=L-sjgTRbdLnhYXBWwdWm+oThav_zJw@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-rebase: error out when incompatible options passed
To:     phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Another thing I missed...

On Sun, Jun 10, 2018 at 12:40 PM, Phillip Wood
<phillip.wood@talktalk.net> wrote:
> On 07/06/18 06:06, Elijah Newren wrote:

>> Some exceptions I left out:
>>
>>    * --merge and --interactive are technically incompatible since they are
>>      supposed to run different underlying scripts, but with a few small
>>      changes, --interactive can do everything that --merge can.  In fact,
>>      I'll shortly be sending another patch to remove git-rebase--merge and
>>      reimplement it on top of git-rebase--interactive.
>
> Excellent I've wondered about doing that but never got round to it. One
> thing I was slightly concerned about was that someone maybe parsing the
> output of git-rebase--merge and they'll get a nasty shock when that output
> changes as a result of using the sequencer.

I can see the minor worry, but I think upon inspection it's not
something that concerns me, for a few reasons:

In terms of use, given that rebase --merge was introduced to handle
renames in mid-2006, but plain rebase has been able to handle them
since late 2008 (though directory renames changes that again), the
utility of rebase --merge has been somewhat limited.  I think that
limits the exposure.  But to address the 'break' more directly...

If we were to agree that we needed to support folks parsing rebase
output, that would be a really strict requirement that I think would
prevent lots of fixes.  And if so, it's one we've violated a number of
times.  For example, I certainly wasn't thinking about rebase when I
modified messages in merge-recursive.c over the years, but they'd leak
through for rebase --merge.  (Those messages would not leak through to
rebase --interactive as much, since the sequencer sets o.buffer_output
and then only conditionally shows the output.)  Also, changes that
have occurred in the past, like adding 'git gc --auto' to rebase,
modifying error messages directly found in git-rebase--merge.sh would
have been considered breaks.

Finally, looking over all the differences in output while fixing up
testcases makes me think we've done much less around designing the
output based on what we want the user to see, and more around what
minimal fixups can we do to these lower level commands that provide
useful functionality to the user?  We linearize history differently
for different rebase modes, have different entries in the reflog
depending on which mode, and we often times implement features for
just one mode and then sometimes add it to others.  In fact, I think
the primary reason that am-based and merge-based rebases had a --quiet
option and the interactive rebases didn't, is mostly attributable to
the defaults of the lower level commands these three were built on top
of (git-am vs. git-merge-recursive vs. git-cherry-pick).  The noiser
two merited a quiet option, and the option was never added for the
last one.

Anyway, that's my rationale.  I'm curious to hear if folks disagree or
see things I'm overlooking or have reasons I might be weighting
tradeoffs less than optimally.
