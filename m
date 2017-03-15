Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57314202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 23:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753797AbdCOX01 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 19:26:27 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33216 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdCOXZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 19:25:56 -0400
Received: by mail-pf0-f174.google.com with SMTP id w189so15375029pfb.0
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 16:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VT5pjnWf+bnj/D6oIppCLp1FkwBAvZtxuTRiwYATx2Y=;
        b=or5WCB9vSHDz4AzulXB7qt1+ULzJZKAHkNey2/9rRcH6KY8dC9T7hRIa2faqEKb4sH
         cvPGhYlSf9e39SsdPQAbSrqfsO82KEDqLNHnBpA2c9x8hKd86ytquOmB6tgwHFYVqds1
         pYGjJ7F2MjJbp94JdVHOLgsfalRVgxI8DQpap5Rv5XcPtXuf53AtOg1DM+KwDeT0qGX1
         P0ZeG0a8C10yq1/ibejKmB5TT+0qf0Q7Aert8jwxxQulx2EPbC2r4us5MIRBWLb3ccr6
         uWVIoZmcsHYj8EpM6s2pfOA/UgzVWNN11lU3VSHR65DKKbORcnkhj4ohrOQbvWyynZL/
         cNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VT5pjnWf+bnj/D6oIppCLp1FkwBAvZtxuTRiwYATx2Y=;
        b=TJXUIw1gfQ0m7GZGr9oOO/KLCsviXw7RuaUEvmBTP2sGpUrY9SBL32DV66Eb4ciLbv
         vfR5fM4nUAPNmScTzBMEHFfDIXpPR4TOpd9/BzqH3/5OMYymak8DYW/TAdNIZBxc/Ffl
         KIjAK431lHoum36ZFXzzpPAlVkqQ8z0kyiYGuWp5pm9tBVvutXbmn/GLdnNcayVMx7Um
         jFkaPZ8Y/igPLwteliuxStsNkTYyc2Jezt5PlSGZI1FHhao5+d7weBvby4kpNcMWrKjV
         oV0oGPbFj0Jq8VecMtMVRincj7+h3OewBY52+wNxDJ5fmRRaXn2D+NYV6LVpA78YjpuT
         M90w==
X-Gm-Message-State: AFeK/H1+XEYZgEGxf59ARZWltNFSGCuFlUrY9COcvAB6v61fs42FFBQgxEtv98Xm8e4szTyLy0Z3kL44sVdX9ZsF
X-Received: by 10.84.195.129 with SMTP id j1mr7867010pld.88.1489620355391;
 Wed, 15 Mar 2017 16:25:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Wed, 15 Mar 2017 16:25:54 -0700 (PDT)
In-Reply-To: <20170315230834.GH159137@google.com>
References: <20170309012345.180702-1-bmwill@google.com> <20170313214341.172676-1-bmwill@google.com>
 <20170313214341.172676-8-bmwill@google.com> <xmqqmvcnir8m.fsf@gitster.mtv.corp.google.com>
 <20170315230834.GH159137@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Mar 2017 16:25:54 -0700
Message-ID: <CAGZ79kbqcGe30-FO4jAzx1wmJBF1dg5O5zYAK5mOFOfQk3PULQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] clone: add --submodule-spec=<pathspec> switch
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2017 at 4:08 PM, Brandon Williams <bmwill@google.com> wrote:
> On 03/14, Junio C Hamano wrote:
>> Brandon Williams <bmwill@google.com> writes:
>>
>> > The new switch passes the pathspec to `git submodule update
>> > --init-active` which is called after the actual clone is done.
>> >
>> > Additionally this configures the submodule.active option to
>> > be the given pathspec, such that any future invocation of
>> > `git submodule update --init-active` will keep up
>> > with the pathspec.
>> >
>> > Based on a patch by Stefan Beller <sbeller@google.com>
>> >
>> > Signed-off-by: Brandon Williams <bmwill@google.com>
>> > ---
>> >  Documentation/git-clone.txt | 23 ++++++++++-----
>> >  builtin/clone.c             | 36 +++++++++++++++++++++--
>> >  t/t7400-submodule-basic.sh  | 70 +++++++++++++++++++++++++++++++++++++++++++++
>> >  3 files changed, 120 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
>> > index 35cc34b2f..9692eab30 100644
>> > --- a/Documentation/git-clone.txt
>> > +++ b/Documentation/git-clone.txt
>> > @@ -15,7 +15,8 @@ SYNOPSIS
>> >       [--dissociate] [--separate-git-dir <git dir>]
>> >       [--depth <depth>] [--[no-]single-branch]
>> >       [--recursive | --recurse-submodules] [--[no-]shallow-submodules]
>> > -     [--jobs <n>] [--] <repository> [<directory>]
>> > +     [--submodule-spec <pathspec>] [--jobs <n>] [--]
>> > +     <repository> [<directory>]
>>
>> Hmph.  Can we then make "--recurse-submodules" an obsolete way to
>> spell "--submodule-spec ."?  I am not actively suggesting to
>> deprecate it; I am trying to see if there are semantic differences
>> between the two.
>
> We can if you think that would be better.  That way if at clone time you
> say "I want the submodules too" that your default config tracks all
> submodules even new ones yet to be added.
>
>>
>> I am also wondering "--recurse-submodules=<pathspec>" would be a
>> better UI, instead of introducing yet another option.
>
> Yeah we could do that, have --recurse-submodules be a repeated option
> and if you don't specify a value it defaults to "."
>
> Any thoughts on this Stefan?

I think when I first tried to tackle this problem, I realized that the recursing
beyond the first level is orthogonal to the selection of submodules in the
first level.

Consider the following submodules

    /sub1
    /sub1/nestedA
    /sub2
    /sub2/nestedB

To select sub1
  git clone --submodule-spec=sub1

To select sub1 +nestedA
  git clone --submodule-spec=sub1 --recurse-submodules

To select sub1+sub2
  git clone --submodule-spec=. --no-recurse-submodules

How to select sub1+nestedA+sub2, but not nestedB
  not possible in one command

I wonder if we want to be able to differentiate these cases at all,
I guess if you want sub1, you also care about nestedB ?

(Or is there any way to recurse pathspecs,
which could be gitattributes)

That said, I optimized for the complex case, which we might not have
and a combination into one switch makes sense, such that
  git clone --recurse-submodules=<pathspec>
is sufficient and turns on recursion beyond the first level.

Thanks,
Stefan
