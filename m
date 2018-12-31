Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9791E1F770
	for <e@80x24.org>; Mon, 31 Dec 2018 11:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeLaLUd (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Dec 2018 06:20:33 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37465 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbeLaLUd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Dec 2018 06:20:33 -0500
Received: by mail-io1-f68.google.com with SMTP id g8so9794706iok.4
        for <git@vger.kernel.org>; Mon, 31 Dec 2018 03:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nB6QRHvpkJxbXknBYA3G8DX91SSbTwoDpxuJRHhFiYs=;
        b=fWxF2dxWM16F3MJrBfS3+Bmc+vKuQpiUVGVLR+C0lPpV7ZY10pAimT6UwsOe8DuLBz
         SOidqGS1Byj3VNz4YPaq8/dv4GqrxXSp6BHEnep1fexntPN+eFlsu8Zn4FTKkHQmTWfm
         mWC+rJZXmFfvwt+LvE7AXVs0FQdnu6rK3sOmFG29VZCpQ5tCcVaWoDWyEC/kt32cvQgp
         Jvk2PBRxo6wf4frSo5FqOO2+whfF57iu6T/CobcrVb9Q+yZStDLUCYaXhwVpsmVtedW/
         2Cd1LUSRYY/2BAFsjf7Ib0NVgG6Bl2NpHhR+oyG7XCIOITrKZIn8xJCzg9GfIrxwjkDX
         DuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nB6QRHvpkJxbXknBYA3G8DX91SSbTwoDpxuJRHhFiYs=;
        b=W+5K4EE1i2VX3C9BWCs13s34CU67S4dyaS7MWueCEVpFZZblyWUwM/oMTqHeR8XLHw
         fDusFuC9VF5XHR91Qg6srYWj3km7/OuZeFrDvZZ5bF5Y4+8z699D5Ui6V13U98QP/3RT
         DCrxyrw//FLZXVa2+vhIGXx+fpAZvBWo+/3jXDHM14pSGPXiDhpTYx+E20n0Sj5p+2rT
         MgFMdU/jUJklLBn+T6QPyrsjuhq4ylQC6WQ5jPvZMBK6VJd/A2JstJQ4iA3gbHzlvyjI
         pZ7S6a7Ji34XUfVw17DYtk4i5KvBoqE9iOTS/8EWP44w/VsErqvExeh7RvhSitaOAtHE
         4sdw==
X-Gm-Message-State: AJcUukcKwTJ6BuG/MQG1rIiks6NxYl4HiwPyeZrTiS0ih/C5Z5KHv0CY
        CZhZb7vjOPrmqDRrVww0m5nHoiSC+XjTHqokaec8r1sFRO+nhA==
X-Google-Smtp-Source: ALg8bN7kjLOcCl3UQskKMsVEaFbTmSepaeP7hjRNjvFhDVfWDdNpls1OgYGy62UypykY5d6MZ9sB5oHNUfHPbqnyCtY=
X-Received: by 2002:a6b:c544:: with SMTP id v65mr25872153iof.118.1546255232639;
 Mon, 31 Dec 2018 03:20:32 -0800 (PST)
MIME-Version: 1.0
References: <B81E8278-965A-4860-95E1-20ADCAB29BC9@msys.ch> <CACsJy8B7=xNBeyYYgMqh-aU_1-Rb8g5t5SwK5jvfbMw4ch-ZLQ@mail.gmail.com>
 <11AC6C27-4C74-43B1-89F6-98ABBFE74E0E@msys.ch>
In-Reply-To: <11AC6C27-4C74-43B1-89F6-98ABBFE74E0E@msys.ch>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 31 Dec 2018 18:20:06 +0700
Message-ID: <CACsJy8AQ1raB+2wjEBtDrAvJm0v-3exJ-FVB2ZyL6VpRFQkspQ@mail.gmail.com>
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after 315a84f9aa0e2e629b0680068646b0032518ebed
To:     Marc Balmer <marc@msys.ch>
Cc:     Git Mailing List <git@vger.kernel.org>, roger.strain@swri.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 31, 2018 at 6:13 PM Marc Balmer <marc@msys.ch> wrote:
>
>
>
> > Am 31.12.2018 um 11:51 schrieb Duy Nguyen <pclouds@gmail.com>:
> >
> > On Mon, Dec 31, 2018 at 5:44 PM Marc Balmer <marc@msys.ch> wrote:
> >>
> >> Hi
> >>
> >> One of the last three commits in git-subtree.sh introduced a regression leading to a segfault.
> >>
> >> Here is the error message when I try to split out my i18n files:
> >>
> >> $ git subtree split --prefix=i18n
> >> cache for e39a2a0c6431773a5d831eb3cb7f1cd40d0da623 already exists!
> >>   (Lots of output omitted)
> >> 436/627 (1819) [1455]       <- Stays at 436/ while the numbers in () and [] increase, then segfaults:
> >> /usr/libexec/git-core/git-subtree: line 751: 54693 Done                    eval "$grl"
> >>    54694 Segmentation fault      (core dumped) | while read rev parents; do
> >
> > Do you still have this core dump? Could you run it and see if it's
> > "git" that crashed (and where) or "sh"?
>
> It is /usr/bin/bash that segfaults.  My guess is, that it runs out of memory (as described above, git-subtree enters an infinite loop untils it segafults).

Ah that's better (I was worried about "git" crashing). The problematic
commit should be 19ad68d95d (subtree: performance improvement for
finding unexpected parent commits - 2018-10-12) then, although I can't
see why.

I don't think we have any release coming up soon, so maybe Roger can
still have some time to fix it instead of a just a revert.

>
> >
> >>   process_split_commit "$rev" "$parents" 0;
> >> done
> >>
> >> Please note that this regression can not easily be reproduced, normally a subtree split just works.
> >>
> >> Reverting the last three commits "fixes" the issue.  So I kindly ask the last three commits to be reverted.
> >
> > Please provide the SHA-1 of the "good" commit you tested.
>
> I reverted these three commits (actually the last three commits to contrib/subtree/git-subtree.sh):
>
> 19ad68d95d6f8104eca1e86f8d1dfae50c7fb268
> 68f8ff81513fb3599ef3dfc3dd11da36d868e91b
> 315a84f9aa0e2e629b0680068646b0032518ebed
>
> And then it worked.
>
> - Marc
>
> --
> > Duy
>


-- 
Duy
