Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0E40207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 18:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754783AbcIPSrk (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 14:47:40 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38138 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753255AbcIPSrj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 14:47:39 -0400
Received: by mail-wm0-f52.google.com with SMTP id 1so57514668wmz.1
        for <git@vger.kernel.org>; Fri, 16 Sep 2016 11:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0T3YLC9rniJ8mlw2fRR40UZqXoX54Zcui3ThjizPHVk=;
        b=KbIPbRfM4f+mcQG1+Wj3evSBonBFxPuZZ1CxBhA1u57kVbdlYTcebyhwlem3fHiRbL
         VQjuPAsBxUdFyvsMHzEBBDkSeWrOPsIBjW4XgXYwpm8AH7pSYCpQw6VXEGn6jb4PnGhj
         CBI/T9jjqCdptkhq5v83n5szficGRH1wgY7xeL8tCxbMfIufCYluOlQ/FeU4PT1VIuXf
         1hZawN73N6YteuQC9w1Ay1CcAKczCGsQYhZFudIivqe+Dgb5nmRIWwbcX34L83FV6P+k
         Zobh1GPfJpFzXeyf1qFSNK/AKNyz7PmT90+z2jEgh5gzUSA5UwaDoIibgdWPC7qLv9rJ
         eegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0T3YLC9rniJ8mlw2fRR40UZqXoX54Zcui3ThjizPHVk=;
        b=aAtC40pvKdp3EGHQV/1PeT+usZjjIF3003UB+B+PWKnBOrVP8H0HC4o8V44tZS7K6K
         hg2JQQCpo00v4YVS5wYM5xlVmYKn5Fu4ANoMj7v2UKXsmcAwB/5eZAmcmoHgCTo2IHZE
         XqCNzrwzr4mhcBmUucrO2fL4u4YO7rfqIzkkk76t/O21uArx48IhaSsXsjqNMbRnUC6K
         XtSL7W4FwQgMx6qROZrtVEcV/V2N+EAVBAP6qLewPHrxagrPnjL2PxtSsaC94Ggt/S5z
         2t97Gvz2tm2gYF2t0fCSyF3kSxbCRxio9/JFOjxANGws8nJSLilfsht+n6VQc0qOl9hu
         MTfA==
X-Gm-Message-State: AE9vXwOHgoZdo+ssUuSjJ0W5B4UhWnWQh7xG7zJJ1hZrIC7ZepRpslMnywDIhHcsMBFciO7sPzJRtLK3ys/IIUnX
X-Received: by 10.28.22.6 with SMTP id 6mr9637511wmw.55.1474051227066; Fri, 16
 Sep 2016 11:40:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.69.25 with HTTP; Fri, 16 Sep 2016 11:40:26 -0700 (PDT)
In-Reply-To: <20160916093456.GA1488@book.hvoigt.net>
References: <1473897473-154528-1-git-send-email-bmwill@google.com>
 <20160915115752.GA37903@book.hvoigt.net> <CAKoko1rtEydwbWoEq9MBW41qqa10Bm+x0d6zS+Bptk51RjMOMA@mail.gmail.com>
 <xmqqr38klst6.fsf@gitster.mtv.corp.google.com> <CAGZ79kZJUQhY_bEi1G3zMYR2iGq5gosfVsBP_CFoaMydXP6QUw@mail.gmail.com>
 <20160916093456.GA1488@book.hvoigt.net>
From:   Brandon Williams <bmwill@google.com>
Date:   Fri, 16 Sep 2016 11:40:26 -0700
Message-ID: <CAKoko1pewoxD4=_9M45pchdDg03K8fc73raJOsf4A+=KKw_EMw@mail.gmail.com>
Subject: Re: [RFC] extending pathspec support to submodules
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Jens Lehmann <jens.lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 15, 2016 at 3:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>  * Your program that runs in the top-level superproject still needs
>    to be able to say "this pathspec from the top cannot possibly
>    match anything in the submodule, so let's not even bother
>    descending into it".
>

Yes, we would need to first check if the submodule is a prefix match to the
pathspec.  ie a submodule 'sub' would need to match the pathspec 'sub/somedir'
or '*.txt' but not the pathspecs 'subdirectory' or 'otherdir'

> > >    So we may have to rethink what this option name should be.  "You
> > >    are running in a repository that is used as a submodule in a
> > >    larger context, which has the submodule at this path" is what the
> > >    option tells the command; if any existing command already has
> > >    such an option, we should use it.  If we are inventing one,
> > >    perhaps "--submodule-path" (I didn't check if there are existing
> > >    options that sound similar to it and mean completely different
> > >    things, in which case that name is not usable)?
> >
> > Would it make sense to add the '--submodule-path' to a more generic
> > part of the code? It's not just ls-files/grep that have to solve exactly this
> > problem. Up to now we just did not go for those commands, though.
>
> Yes I think so, since it should also handle starting from a submodule
> with a pathspec to the superproject or other submodule. In case we
> go with my above suggestion I would suggest a more generic name since
> the option could also be passed to processes handling the superproject.
> E.g. something like --module-prefix or --repository-prefix comes to my
> mind, not checked though.

Yeah we may want to come up with a more descriptive option name now which can
be generally applied, especially if we are going to continue adding submodule
support for other commands.

-Brandon
