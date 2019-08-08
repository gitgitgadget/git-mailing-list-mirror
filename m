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
	by dcvr.yhbt.net (Postfix) with ESMTP id 160421F731
	for <e@80x24.org>; Thu,  8 Aug 2019 20:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404545AbfHHUb4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 16:31:56 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46835 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404270AbfHHUb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 16:31:56 -0400
Received: by mail-ua1-f67.google.com with SMTP id o19so36925158uap.13
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 13:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p8R9bKyCWHiK+qbjSd0faudl1WhfDbCqt3P8fpKdIU4=;
        b=iQlymHOnMv67OiNdEsDypijzJBIkbxOmCcd55ipXPkN0ACPjiUe/W23rpYIUCaAlpk
         GawRZA574m1wF+9XCrbZ8uAwk++1zfE0i6jjITqFOGqhoqhD9o46/4gCtPaezVZrsnOv
         b/Q1Sgbi6fACG6akV00LX9nsisN7JxsfDVSxjoGiwVLZwyFH+iMIerFGQ2ErPtUnCqR0
         I1+leZnQlNvRMmCkAf9zxUyvV0ZbLFdwa0NTyPnxUKfqaJl0m0XJrOzRxnRfBhD2WD81
         FhDzlu+/1EIqPOw4WcfNPBEZpnsPRXFeo2oBfCeZNPfRnIo3duz4VIcLyf21xHiPHiVM
         V7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8R9bKyCWHiK+qbjSd0faudl1WhfDbCqt3P8fpKdIU4=;
        b=EBlpYsmfXFmv5OBJjLEEYgEQ7eZ75G8HQzrL5sXm0MFiu5ZHZrON2oASCB22m/th/p
         D8PIWhdRt77ipldfyWd6a9teXv4HuNi83pci5bajb3GAn+vtoAgqjwiR6jvfAkyg3rFq
         0xqus55W3d/FJuiNDBfLwZkdniPFht+YonpHDgqXHFPxU7xFYvokxAuAjPY8sShMW6RN
         yuXXtwgfLXSU6tQgUD8FXCWVLX25IJhmJFrkKZoTrmyUFYa2fDraozv7JwoQYGEPqU+K
         j+pFIT8xTwSRYElkqdgcfkZJFtXKJg93vej5PKatVQdTovB3AhxTqASNyR/y8Y8eYCFl
         Gd2A==
X-Gm-Message-State: APjAAAUy7GvfEsMy0Q0d3D8J4gVpXsH16vWLapB0agDgQrjVYQOO71T8
        i1nlrBEWh2AZH8/ZC/8YZydRQsWLehD2un/elr8=
X-Google-Smtp-Source: APXvYqy/KCTHxWt/ZDrHpIgDO9QG+hj49VgY1galpvv9sRTjqRriahhUbYMVxU/nA7a8I2bWdu1978kiYaOuNYb89tM=
X-Received: by 2002:ab0:6911:: with SMTP id b17mr11021503uas.18.1565296314960;
 Thu, 08 Aug 2019 13:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.292.v2.git.gitgitgadget@gmail.com> <pull.292.v3.git.gitgitgadget@gmail.com>
 <2e153fac22dc5c27fc85efc802785edc0c9d78ad.1564515324.git.gitgitgadget@gmail.com>
 <CABPp-BGppXSt9i4SXTizgPXap-YgHBwHTVrvwDpg98zvpYRwcQ@mail.gmail.com>
 <xmqqd0hffpoz.fsf@gitster-ct.c.googlers.com> <4fe2cb63-2d6c-d8d5-5531-9ea6d624a85a@gmail.com>
In-Reply-To: <4fe2cb63-2d6c-d8d5-5531-9ea6d624a85a@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 8 Aug 2019 13:31:43 -0700
Message-ID: <CABPp-BGo5spDbk34YwAPGqT1Xgsr1dHm6OhxY1xKFQxQaotBig@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] repo-settings: create feature.experimental setting
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        carenas@gmail.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 8, 2019 at 12:12 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/8/2019 2:59 PM, Junio C Hamano wrote:
> > Elijah Newren <newren@gmail.com> writes:
> >
> >>> --- a/Documentation/config/merge.txt
> >>> +++ b/Documentation/config/merge.txt
> >>> @@ -54,7 +54,8 @@ merge.directoryRenames::
> >>>         moved into the new directory.  If set to "conflict", a conflict
> >>>         will be reported for such paths.  If merge.renames is false,
> >>>         merge.directoryRenames is ignored and treated as false.  Defaults
> >>> -       to "conflict".
> >>> +       to "conflict" unless `feature.experimental` is enabled and the
> >>> +       default is "true".
> >>
> >> I have a hard time parsing that changed sentence.  Perhaps something like:
> >>    ...unless `feature.experimental` is enabled in which case the
> >> default is "true".
> >> ?
> >
> > That reads better.
> >
> > But I am not sure about the wisdom of controlling between conflict
> > and true with this feature macro in the first place.
> >
> > Between "conflict" and "true", the former forces the end user to
> > verify (or allows the end user to veto) the auto resolution by the
> > heuristics and is always a safer if more cumbersome option.  It's
> > not like blindly trusting the directory rename heuristics is the
> > bright future for all users, is it?
> >
> > I would not set rerere.autoUpdate to true when feature.experimental
> > is set; for exactly the same reason, I do not find it reasonable to
> > set this to true with feature.experimental macro.
>
> OK. I can remove it from the feature.experimental variable.
>
> Shall I keep the enum logic and the use of repo-settings.c? I can split
> them out into a separate patch.

Good question.  In part, I was looking at this ds/feature-macros
series because my cleanup-merge-api series[1] has some minor conflicts
with it.  I'm a little unsure what route I should take with my series
now.  Some choices:
  * keep this logic in your series in a separate patch, and have me
rebase my series on yours.
  * drop this logic from your series since it may not be needed
anymore, making our two series independent again.
  * move this logic into a separate patch of yours but making that
patch part of my series instead; that'd be easy with the enum logic,
but the repo-settings.c stuff appears to depend on your other
patches...

Thoughts or preferences?

[1] https://public-inbox.org/git/20190726155258.28561-1-newren@gmail.com/
