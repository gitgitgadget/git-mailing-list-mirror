Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2513211B5
	for <e@80x24.org>; Fri,  1 Feb 2019 09:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfBAJ1H (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 04:27:07 -0500
Received: from mail-vs1-f41.google.com ([209.85.217.41]:34341 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfBAJ1H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 04:27:07 -0500
Received: by mail-vs1-f41.google.com with SMTP id y27so3800797vsi.1
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 01:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r87wL8ZP+roX2pNjrHTuBFsYFPL0GcnBtfjeSNl7ALw=;
        b=ldu5nu8Nniejcy1uVJWQQyFAcsvmkuE+fVmDtFG4l+Hog8AKHRkzJzAmOH9shde32V
         j95oFP95RPBpCOPdKfCDHJbOxs90DbUm1BmC5PxKqXuAppgIpJLyqPkQ/LeUahw+wZ5s
         AAJO7FZDj5aLI+kgOR1FLfbl5P13Qz0ldGadz+6wni0wvvGw/lAMwVbfmqgAijHGAkwF
         367ypPfvIa7WfMpnJszSfvUd1klOLIh22unYuecNtS7RhPgJO4BJz5sFHXaLf2rykQLC
         cAR0oBEjh+uDh2i2zxidjhkpl4BGR0qcPjh/QJLhr5++fodSXlPqWHbXUFDPEWc2tZmY
         bTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r87wL8ZP+roX2pNjrHTuBFsYFPL0GcnBtfjeSNl7ALw=;
        b=lKKW+ExoF4AchwgLLVrjUVkqDEgB44FgEy5TZzFRoI1bAooRQhelMnc674j2MGbYE2
         YNLwnO94kQta/JlXJN7qaSbAdkpka270K8y9yhOWbN91dgq+cpoeIpdwZh+oLVGfmGFB
         ZFqF6J1fFFYB9Iad5vQop9cMm/m14viDDr2KtJU/bT315uMWaBMjKKCIc6MZcoLUKcI5
         c5JdWjLCJsvQ6NJWj9tVylLiriWSEx99pigREik57PJAu7b7CzysdV8KUOvFHBsiMnar
         tY+dwQ9fF27y+W1/M3k89MbwHT4t/HJIKKM2OkHMFeL7lbm2D6WMqx33FEoluWFAjaJm
         7jRw==
X-Gm-Message-State: AJcUukckr1fGjsDgm7AEMme67k+t7sayut6nrItL875oEaXJ+1iECNZj
        7sLV/uAJwdGpfhdbPyoRfeVL3wCe7ApFAsPwkaWYH7qZzHA=
X-Google-Smtp-Source: ALg8bN6Ek37Oqx4XVvueSmG5682Z9kXRl06S9st1SqfiQKN6VPHmRDpGCI+Uc9CtPtJQLr/vPG+Q8ZwysyLHqvLyrD8=
X-Received: by 2002:a67:f696:: with SMTP id n22mr17351594vso.175.1549013225700;
 Fri, 01 Feb 2019 01:27:05 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.1901312310280.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1901312310280.41@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 1 Feb 2019 01:26:53 -0800
Message-ID: <CABPp-BF=ev03WgODk6TMQmuNoatg2kiEe5DR__gJ0OTVqHSnfQ@mail.gmail.com>
Subject: Re: Comparing rebase --am with --interactive via p3400
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Jan 31, 2019 at 10:04 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> as discussed at the Contributors' Summit, I ran p3400 as-is (i.e. with the
> --am backend) and then with --keep-empty to force the interactive backend
> to be used. Here are the best of 10, on my relatively powerful Windows 10
> laptop, with current `master`.
>
> With regular rebase --am:
>
> 3400.2: rebase on top of a lot of unrelated changes             5.32(0.06+0.15)
> 3400.4: rebase a lot of unrelated changes without split-index   33.08(0.04+0.18)
> 3400.6: rebase a lot of unrelated changes with split-index      30.29(0.03+0.18)
>
> with --keep-empty to force the interactive backend:
>
> 3400.2: rebase on top of a lot of unrelated changes             3.92(0.03+0.18)
> 3400.4: rebase a lot of unrelated changes without split-index   33.92(0.03+0.22)
> 3400.6: rebase a lot of unrelated changes with split-index      38.82(0.03+0.16)

Awesome, thanks for checking that out.  I ran on both linux and mac
and saw similar relative performances.  Comparing am-based rebase to
an implied-interactive rebase on both linux and mac (with a version of
git including en/rebase-merge-on-sequencer so that -m gives the same
performance that you'd see with --keep-empty), I saw:

On Linux:

am-based rebase (without -m):

3400.2: rebase on top of a lot of unrelated changes             1.87(1.64+0.21)
3400.4: rebase a lot of unrelated changes without split-index   7.87(6.24+1.00)
3400.6: rebase a lot of unrelated changes with split-index      5.99(5.05+0.67)

interactive-machinery rebase (with -m):

3400.2: rebase on top of a lot of unrelated changes             1.80(1.60+0.19)
3400.4: rebase a lot of unrelated changes without split-index   6.78(5.70+0.91)
3400.6: rebase a lot of unrelated changes with split-index      6.92(5.70+0.89)


On Mac:

am-based rebase (without -m):

Test                                                            this tree
-------------------------------------------------------------------------------
3400.2: rebase on top of a lot of unrelated changes             2.68(1.68+0.68)
3400.4: rebase a lot of unrelated changes without split-index   8.89(5.86+2.94)
3400.6: rebase a lot of unrelated changes with split-index      7.87(5.35+2.51)


interactive-machinery rebase (with -m):

Test                                                            this tree
-------------------------------------------------------------------------------
3400.2: rebase on top of a lot of unrelated changes             1.99(1.61+0.77)
3400.4: rebase a lot of unrelated changes without split-index   8.63(5.38+3.38)
3400.6: rebase a lot of unrelated changes with split-index      9.36(5.53+3.95)

> I then changed it to -m to test the current scripted version, trying to
> let it run overnight, but my laptop eventually went to sleep and the tests
> were not even done. I'll let them continue and report back.
>
> My conclusion after seeing these numbers is: the interactive rebase is
> really close to the performance of the --am backend. So to me, it makes a
> total lot of sense to switch --merge over to it, and to make --merge the
> default. We still should investigate why the split-index performance is so
> significantly worse, though.

Cool, I'll update my patches to make --merge the default (building on
top of en/rebase-merge-on-sequencer) and post it as an RFC.  But yeah,
we should also check into why the split-index performance becomes a
bit worse with such a change.

Thanks,
Elijah
