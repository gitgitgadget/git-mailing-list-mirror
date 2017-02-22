Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AA81201A9
	for <e@80x24.org>; Wed, 22 Feb 2017 00:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753471AbdBVAHj (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 19:07:39 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:36481 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753454AbdBVAHi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 19:07:38 -0500
Received: by mail-it0-f54.google.com with SMTP id h10so121749986ith.1
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 16:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CDKWIb4IsOjRCTdT5yGlaYvkAnh8nE3i8PimdYj0ON0=;
        b=Nyvk9/vJGnFVCyBBrLUtpGPiPmyYOx3PnhHlsoA95kDyrApWrb8IUhnPJ5pS+dlWVT
         ZGGA7xKHwQQ9mRLeikHc23VZlgDCy3l+7LGk7gqZ4BXRkpeXZ3R8bzFFJkufZ+wcQRgH
         l4AD7JZFKGVbrDaitJ6gHUMdRcuWUAEUtWUmliF/NqzgZ5hD4SlMV6/mVowlnFcc9z00
         5YjWE6ElS9+JBh3ZA8qBpvsRIzcPteCsfJ0al1tAy9xTQbb/i2ZGx63ZWHO8UnxieHBF
         9m4amw4wGxDS2vJEVJAUhMWZhxcpED2j05iqd7899cknR0RLHdjhn/ESiCSJHTYhw894
         mNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CDKWIb4IsOjRCTdT5yGlaYvkAnh8nE3i8PimdYj0ON0=;
        b=IWyecxLGa1ZsvVNBhwyNXCycerd/MXQprCROFLrO2zvAZ7MKchi+4PJhXZyWxjFa2R
         HJBRblvMmkR0+SmGw0T9mzLCtyoB42w1/glxYdeItE074jdwUFLL998flFt/EwqGE3rs
         ghyOk/JRklRVd5keU+6YtgNdhYcS8Iz5roc36lSSQc9SPkTdWK1fhORLRFq29ddouHqE
         lR3itAZ0QSVwhaanUo+oGF+Ba32mLvk0WxSLsrm4X8Ns+kr8dYmGS2trYlm3VAzu4RJS
         Q3g+LRmN9wAxyV84symLu3sHEO+UOdDs4Wgvk8qX2B3r9YtRJASBEQDDZDGJC4rj+FL0
         DcgQ==
X-Gm-Message-State: AMke39nCW6W9oJN1xyS7as23o2cfIF94MpL4Z4gIIVWmbEyN8qI167ER3By8tDNA54lRdOPWoq7WGiEG0eaoAJm1
X-Received: by 10.36.65.4 with SMTP id x4mr31021139ita.69.1487722057045; Tue,
 21 Feb 2017 16:07:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Tue, 21 Feb 2017 16:07:36 -0800 (PST)
In-Reply-To: <xmqqo9xvdsji.fsf@gitster.mtv.corp.google.com>
References: <84fcb0bd-85dc-0142-dd58-47a04eaa7c2b@durchholz.org>
 <20170220090115.6kfzwl62opj4q7k7@sigill.intra.peff.net> <404d109f-e5a7-85a3-e64c-ab1b21c3045d@durchholz.org>
 <20170220205243.lynnmxouwq7jelld@sigill.intra.peff.net> <28fb85d4-89cd-1f32-3063-2f48d8b935be@durchholz.org>
 <20170221070653.65ho2anbp55uzjeu@sigill.intra.peff.net> <CAGZ79kZgMbEZy7hoA+VxsKdKBavt59SmC1c6FpDdgrW2GKMHvQ@mail.gmail.com>
 <20170221230029.cs36tjwpsw2opuwp@sigill.intra.peff.net> <CAGZ79kby-UhUqci9Mgdhw+wvS5Y39=Q7AmCrWaTMWbcZPNT6Dw@mail.gmail.com>
 <xmqqo9xvdsji.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Feb 2017 16:07:36 -0800
Message-ID: <CAGZ79ka2S=V1x2fSQq+E-yE0Ao36-4tuTvnD6uXpPXJPLFN3JA@mail.gmail.com>
Subject: Re: url.<base>.insteadOf vs. submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Toolforger <toolforger@durchholz.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2017 at 3:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Tue, Feb 21, 2017 at 3:00 PM, Jeff King <peff@peff.net> wrote:
>> ...
>>> I guess one answer is that this is the wrong approach entirely, and the
>>> right one is something like: submodules should understand that they are
>>> part of a superproject, and respect some whitelisted set of config from
>>> the superproject .git/config file.
>>
>> This would break one of the core assumptions that submodules
>> are "independent" repos.
>>
>> The way of action is a one way street:
>> * The superproject is aware of the submodule and when you invoke a
>> command on the superproject, you may mess around with the submodule,
>> e.g. update/remove it; absorb its git directory.
>> * The submodule is "just" a repository with weird .git link file and a
>>   respective core.worktree setup. Currently it doesn't know if it is
>>   guided by a superproject.
>
> While that is a good discipline to follow, I think you need to
> differenciate the project that is bound as a submodule to a
> superproject, and a specific instance of a submodule repository,
> i.e. a clone of such a project.
>
> It is true that the Linux kernel project should *NEVER* know your
> appliance project only because you happen to use it as a component
> of your appliance that happens to use the kernel as one of its
> submodules.  But that does not mean your copy of the kernel that
> sits in your recursive checkout of your appliance project should
> not know anything about your superproject.

Oh, I see.  For this use case as well as the prompt indicator that
I mentioned in the previous email, the most basic question is
* Do we have a superproject? [yes/no]
The next level of awareness would be
* Where is the superproject? [ <relative path?>]

These questions may not be interesting for a user (they ought to know
about that appliance;) ), but rather for scripted usage, which I think
hints at the lack of a submodule plumbing command.

Currently we only have git-submodule that is a helper used to somehow
cope with submodules. It is used by humans directly and it is listed
under "Main porcelain commands" in our man page.

Probably we'd also do not want to cram this stuff into the already bloated
rev-parse (that has --show-toplevel, which has nothing to do with
parsing revs, but as Jeff put it it is the kitchen sink of Git).

>
> This is true even without any submodules.  The Git project itself
> does not even care you are Stefan, but you still can and do add
> [user] name = "Stefan Beller" to .git/config of your clone of the
> Git project.  A clone of the project may want to know more than the
> data project itself keeps track of to describe the context in which
> the particular clone is being used.  And .git/config is a good place
> to keep such pieces of information.

This analogy is less clear to me than the kernel& appliance.
When applying it to you (user.name=Junio) that has write powers
over the blessed repository, the project cares a lot about you. ;)

> So I would think it is entirely reasonable if "git submodule init
> sub" that is run in the superproject to initialize "sub" writes
> something in "sub/.git" to tell that "sub" is used in the context of
> that particular toplevel superproject and customize its behavour
> accordingly.  Perhaps it may want to add the url.*.insteadOf that is
> useful for updating the submodule repository when it does "submodule
> init", for example.

Do we want to invent a special value for url.*.insteadOf to mean
  "look up in superproject, so I don't have to keep
  a copy that may get stale" ?
