Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 535522036D
	for <e@80x24.org>; Wed, 22 Nov 2017 04:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbdKVEh5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 23:37:57 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34849 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbdKVEh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 23:37:56 -0500
Received: by mail-qk0-f193.google.com with SMTP id p19so15139986qke.2
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 20:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9ic86kcPMntfdUPFpv0WyaAJHPGuJ38yPFkqY3EUFas=;
        b=W+KClQC4RwyxCbK4CSeMAudASbJl2YVTUameQ8zMfXlr7KT4XSJgJoDEpoGrhzUfC5
         RFLbfuzO8fEEFEzJD06vge97Go/WZYqS7UmYPow94LrPKZOn00CUcnzTNPMYXD/8BL9E
         b0Dl7HvFiWUIxJc1uvY3Uu2rMeuZ2FvKSdY1K600oAEu1ix7fvWBgQ41D1gIWi5ypScb
         Zf9FIHR0EOiWqxkSqL637FYJlaOHVNHn32UbGkxYwru63V7acan+8dso1TM/NHkXPHuC
         HTo0EbATFEDRrGIKAZJ0VtAXutljyGXkaw27IF+JAr8+Tai8FwWWdvsx6vQ+Ghfui6nG
         9qoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9ic86kcPMntfdUPFpv0WyaAJHPGuJ38yPFkqY3EUFas=;
        b=k3VOWb9e3It2pJaIE65WOuqEL81UsUCCAY/871NGnmfazo3EbWwjCSMRnQnTNMdGyc
         jyM3/rX8iak7lx/R1FDDeKWunjJd7vs889VMaFBM7feaMj+cxn3XuCe87C2ckSFfvaW/
         l6MMcykDlkKfb0jhHs0yUMs2ivGoCmCBUdrPnppPfn1IJypL90zyYu63bnZORWBTrczq
         OThN2TeDqL/eqx7iV2DAB2J7KY1+JzhIXqF7H3OXMYq/IbFjNph3q4PBL2nwH6g9u03i
         2clnOkgUJX7hpSrvO7JQPcRdBnRWW0BH4yCJ9znY7LJ3dip6iTXdHIuQcxKOkIK/H2LF
         6qoA==
X-Gm-Message-State: AJaThX73oJBRtSvsaijobvw+QbN6gPPjZ5bAJ50sK7iDuWygwQL9gwUB
        2LVkhtVIh26OIpD/rmsW8jLGMcUYyyxtc3aFhpE=
X-Google-Smtp-Source: AGs4zMbW8WtTOhZvAyI/YXPqlTKEYio5jj71/iYiQ35wBfWR5ompO2zJFRACl4S/MwxoJRkkYUtt4ZBnpYFlK5KvEYQ=
X-Received: by 10.55.130.194 with SMTP id e185mr29344426qkd.357.1511325475817;
 Tue, 21 Nov 2017 20:37:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Tue, 21 Nov 2017 20:37:55 -0800 (PST)
In-Reply-To: <xmqqvai3ufu9.fsf@gitster.mtv.corp.google.com>
References: <20171121150954.3227-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQrC1MiPrwwPqtdX2tzj1ntFHxO28uqnMBcmVpPPrc_Rg@mail.gmail.com>
 <xmqqa7zfxdru.fsf@gitster.mtv.corp.google.com> <CAPig+cTux4dfBsX3DD=5TbM-p4-t66WX3+sufi39-W5Dw+ZvOw@mail.gmail.com>
 <CAPig+cStgFaeWoNVcwaJVtNnYeLQ2LfS9xXF7uM3Py17HUaFFw@mail.gmail.com> <xmqqvai3ufu9.fsf@gitster.mtv.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 21 Nov 2017 23:37:55 -0500
X-Google-Sender-Auth: tQt_aDqD_tZ1_xmxLvM7OqJ1YCU
Message-ID: <CAPig+cQ1D+MFZkEX5yQ-DXu_CPf4oa507ChNjYqA=vG1CdZ4SQ@mail.gmail.com>
Subject: Re: [RFC PATCH] builtin/worktree: enhance worktree removal
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 10:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> OK, so the proposed log message was a bit confusing for those who
> are *not* the person who wrote it (who knew why existing behaviour
> was inadequate and did not describe how "worktree remove" would fail
> under such a scenario to illustrate it, incorrectly assuming that
> everybody who reads the proposed log message already *knows* how it
> would fail).

Correct. The log message is confusing, enough so that my knee-jerk
reaction was that the patch was trying to re-invent 'git worktree
prune'. That seemed odd, so I spent extra time trying to figure out
what it really meant, which led to my rather lengthy response asking
if I was understanding the situation correctly.

>         "git worktree remove" removes both the named worktree
>         directory and the administrative information for it after
>         checking that there is no local modifications that would be
>         lost (which is a handy safety measure).  It however refuses
>         to work if the worktree directory is _already_ removed.

The "refusal" is by accident, so perhaps phrase it like this:

    However, due to an oversight, it aborts with an error if the
    worktree directory is _already_ removed.

or something.

>         The user could use "git worktree prune" after seeing the
>         error and realizing the situation, but at that point, there
>         is nothing gained by leaving only the administrative data
>         behind.  Teach "git worktree remove" to go ahead and remove
>         the trace of the worktree in such a case.
>
> or soemthing like that?

Yes, I quite like it; it conveys the information necessary to
understand the issue.

Kaartic: Regarding the actual patch, rather than silencing
validate_worktree() (which seems an unfortunate thing to do), isn't it
possible simply to do a quick test to see if the worktree directory
exists before calling validate_worktree()? If it doesn't exist, then
just skip down to the part of the code which does the 'prune'
operation.
