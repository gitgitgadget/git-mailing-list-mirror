Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5908A20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 06:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbeLKGMX (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 01:12:23 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35665 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbeLKGMW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 01:12:22 -0500
Received: by mail-vs1-f67.google.com with SMTP id e7so8214955vsc.2
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 22:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/WvfoTP0PeyDaQvHbq78fV+QUczjL1W3Qomj96LgEA=;
        b=lK2TklUiaiMp14ONEKC5mBHhCZo/7W5eY4VV+o56c43rOBrQ1W8cRLEbrm/q+JEwuf
         4rzZ46wHRJFYC2fIoPCTS9P8YqEnOx3FddJvVw62q3uP9NoVAJzVwJM7yobwUQDL4qjt
         oLmEaFcgPrhAMPMl2eAzzcl13uP72V5AYovg3mxug2tWPIBlv/Ym5HhQEG9Y9QO6lBDY
         larNW69mJgbqzoTabg4Q56ssjMxTBY6me0wecy3GXmYOl5cdUPByBVh2eHvp4Ed5u5Lz
         L2XSt5wmI5aTEiB2P/XCClm11yPPGvWGnYX7ZgDOrUixHtsRBJNUZAoL6Cp/obOwJ0Ko
         19Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/WvfoTP0PeyDaQvHbq78fV+QUczjL1W3Qomj96LgEA=;
        b=LFsm2LohjGjmg72O5AP4//E7mVAFu/f05EVbM5bIezsLRSzIs5W9UeUixJqHkT4VPT
         l0/lBn8MPgE5kjMAuctQ7mP6Q3TMgQcJtFILGR5zU/9yBE2t3sIFCUR/UdCfdSEH4nbj
         Red8mOcoorm4Vfa6tDlLnV9ELdFC+A3owvaMw0s7uBsJgPYMDQzkKX7v0Nc0AMuEUEb8
         TbJXGb1yzp5aWz2yyeRaJUrT1sSy7oSohtAQHaf140+cxpH6XwC1cXraUmEjrrzCKGD/
         6APrFtJIrC8+OpHVGocMBQlN0DeFHmJioRIHGaWr/EomaTvrBXO7xC23ncMU3UJh1pPw
         VtPg==
X-Gm-Message-State: AA+aEWbeaxT6FbKbrvf4x14WiP9dTHy3qIYhGximv0OiACSTXNU2Ftqm
        mSxnjGuDBfplMMC4Gdd185ywHNU+Bearv9qhkg0=
X-Google-Smtp-Source: AFSGD/XgCA/j/VpYb53/LzWIyeqWpKdJSwT0ns5PltBwVjCr2LoixU8u1dSe8sPsHzndp0Wt0GPKIWT+s6xn95w1qkU=
X-Received: by 2002:a67:f696:: with SMTP id n22mr6769023vso.175.1544508740723;
 Mon, 10 Dec 2018 22:12:20 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-7-t.gummerer@gmail.com>
 <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com> <xmqqva40lps2.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqva40lps2.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Dec 2018 22:12:09 -0800
Message-ID: <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
Subject: Re: [PATCH 6/8] checkout: add --cached option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 7:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > Elijah wanted another mode (and I agree) that modifies worktree but
> > leaves the index alone. This is most useful (or least confusing) when
> > used with <tree-ish> and would be default in restore-files. I'm not
> > saying you have to implement it, but how do the new command line
> > options are designed to make sense?
>
> I'd model it after "git apply", i.e.
>
>         git restore-files [--tree=<treeish>] <pathspec>
>
> would work only on the working tree files,
>
>         git restore-files --tree=<treeish> --cached <pathspec>
>
> would match the entries in the index that match pathspec to the
> given treeish without touching the working tree, and
>
>         git restore-files --tree=<treeish> --index <pathspec>
>
> would be both.
>
> I have never been happy with the phraso, the (arbitrary) distinction
> between --cached/--index we use, so in the very longer term (like,
> introducing synonym at 3.0 boundary and deprecating older ones at
> 4.0 boundary), it may not be a bad idea to rename "--index" to
> "--index-and-working-tree" and "--cached" to "--index-only".
>
> But until that happens, it would be better to use these two
> consistently.

I agree that consistency is important, but trying to distinguish
between "--cached" and "--index" is _extremely_ painful.  I still
can't keep the distinction straight and have to look it up every time
I want to use either.  I don't know how to possibly teach users the
meaning.  Could we introduce synonyms earlier at least, and make the
synonyms more prominent than the "--cached" and "--index" terms in the
documentation?
