Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DD2D200B9
	for <e@80x24.org>; Mon, 21 May 2018 18:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751121AbeEUSuo (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 14:50:44 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41627 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeEUSun (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 14:50:43 -0400
Received: by mail-pg0-f67.google.com with SMTP id d14-v6so3148419pgv.8
        for <git@vger.kernel.org>; Mon, 21 May 2018 11:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nxlw4mgZY4LFPN1UfVt/SowC9ff2XnscVGRO5kuo1P8=;
        b=Tcekuo9lUX6cr8Gi2CfSTcVtoyPbMEUKnYXwFL4cLrhkvD5ARvcn9Rz8l/mjFu9Tv/
         7v5ch6wf2iPvdrU4UK+jtoWbIVmzssQ+evU1Obfhvsgym3VjmBdm5/EiPVxybe02EDT4
         LJ5/x7CCmfMp2KskYqUj+sL/9siwLOVnJjeZvziNEt0ass9nD/8mFpcTqme8o2A74hOu
         D5By3oBTuYkv3ph4e+WLpzQ4JPzqcqFydtTRfCT7XmsRMmf9hddKnymPdWrCGyKSQyM/
         +e96vmuuY3lT9syulfKoanymMLDwPxD110fWCkPC1c0e0bGnRgEdhSgfNgt1aRygW+mO
         lwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nxlw4mgZY4LFPN1UfVt/SowC9ff2XnscVGRO5kuo1P8=;
        b=gR/7VpJnIER5k5ork7qTRWx/WqN2zOFH0EDwHjqOIykMM6Dfe887Ni4CtfV9+JdFeL
         Nkm+/T4gw5wyZHUsPhQsi5moU5dQMiSuIjw5ndUxX1pil6TE5h3Z5H30kDi+5A59HRga
         hrA2+XRjeeLLlT7pGt4Svz6ssUZvMWPK1f/SCTuEEIIbut6Z7N86C/FXl+g/IoUKq7Zo
         jxnF107v7o915AMcIb9lEOQuaofRTgPA5+3sw8zmLnjRSge1LuGaeI51rEF6bdShZu7i
         fTvLB7B9THlM8yPul/F1mjDGR9z5X73FtBBpWEdtBzb9/ok5xYgFHr6TjPrV3rmn3z+L
         Bxig==
X-Gm-Message-State: ALKqPwdPBldjZ6p8kUUzt5lmKHW6+B5hEcTUl+zIv+BqpqDwVXpwKkzQ
        rbEoWPxcRR+nh2h5cBtudXOgJbFfkAM=
X-Google-Smtp-Source: AB8JxZrneNVBY7VHO7oAOeOo+Ngs1VDcG9kTjhU8jx1zJiwi5D96L+gaLvqaBDKZh6dJ7oW0vt3GGQ==
X-Received: by 2002:a65:45c1:: with SMTP id m1-v6mr16680358pgr.229.1526928642454;
        Mon, 21 May 2018 11:50:42 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id a7-v6sm22950777pgc.68.2018.05.21.11.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 May 2018 11:50:41 -0700 (PDT)
Date:   Mon, 21 May 2018 11:50:40 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Antonio Ospite <ao2@ao2.it>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/11] repository: introduce repo_read_index_or_die
Message-ID: <20180521185040.GA125693@google.com>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com>
 <20180516222118.233868-3-sbeller@google.com>
 <20180519063729.GA14755@duynguyen.home>
 <CAGZ79kbxptYvDoTqsVRe3KOA_--ja8UZir=MkMXw8_LxVXG_-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbxptYvDoTqsVRe3KOA_--ja8UZir=MkMXw8_LxVXG_-Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/21, Stefan Beller wrote:
> On Fri, May 18, 2018 at 11:37 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Wed, May 16, 2018 at 03:21:09PM -0700, Stefan Beller wrote:
> >> A common pattern with the repo_read_index function is to die if the return
> >> of repo_read_index is negative.  Move this pattern into a function.
> >>
> >> This patch replaces the calls of repo_read_index with its _or_die version,
> >> if the error message is exactly the same.
> >>
> >> Signed-off-by: Stefan Beller <sbeller@google.com>
> >> ---
> >>  builtin/add.c               | 3 +--
> >>  builtin/check-ignore.c      | 7 ++++---
> >>  builtin/clean.c             | 4 ++--
> >>  builtin/mv.c                | 3 +--
> >>  builtin/reset.c             | 3 +--
> >>  builtin/rm.c                | 3 +--
> >>  builtin/submodule--helper.c | 3 +--
> >
> > 'git grep -w -A3 read_cache' tells me you're missing (*)
> 
> > (*) yes yes you did mention "if the error message is exactly the
> > same". But these look like good candicates to convert anyway
> >
> > builtin/diff-tree.c:    if (read_cache() < 0)
> > builtin/diff-tree.c-            die(_("index file corrupt"));
> >
> 
> I would expect this to be covered in a follow up patch as I did look
> for (read_cache() < 0) specifically.
> 
> > builtin/merge-ours.c:   if (read_cache() < 0)
> > builtin/merge-ours.c:           die_errno("read_cache failed");
> >
> > builtin/update-index.c: entries = read_cache();
> > builtin/update-index.c- if (entries < 0)
> > builtin/update-index.c-         die("cache corrupted");
> >
> > merge-ours.c is interesting because it uses die_errno() version
> > instead. I think that might give inaccurate diagnostics because we do
> > not only fail when a libc/system call fails in read_cache(), so it
> > should be safe to just use die() here.
> >
> > update-index.c is also interesting because it actually saves the
> > return value. I don't think it's used anywhere, so you can just drop
> > that 'entries' variable. But perhaps it's good to make
> > repo_read_index_or_die() return the number of entries too.
> 
> Yeah this series left out all the interesting cases, as I just sent it out
> without much thought.
> 
> Returning the number of entries makes sense.
> 
> One of the reviewers of the series questioned the overall goal of the
> series as we want to move away from _die() in top level code but this
> series moves more towards it.

I've heard every once in a while that we want to move toward this but I
don't believe there is an actual effort along those lines just yet.  For
that to be the case we would need a clearly defined error handling
methodology (aside from the existing "die"ing behavior), which we don't
currently have.

> 
> I don't know.
> 
> Stefan

-- 
Brandon Williams
