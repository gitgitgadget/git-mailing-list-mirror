Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E64C433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 17:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17DB322288
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 17:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgLXRQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 12:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgLXRQY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 12:16:24 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F02FC061573
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 09:15:44 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id i24so2602732edj.8
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 09:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dbDmL994Vhe0hXjxzaEanvZdXD0IdPbePe09QjRulZg=;
        b=ULGNfBoDPA6JDTYQwNlL7Q7p55veK2SFD1YBXqRhK3iI3fxdPQfDc/b3REPZeU/aew
         YzlZ/SIsI+dOLt3uKskqJPbLXouYwT2EHyNZyDBwvzhci1nrLg2z3nmODZNmHQGT9E/k
         gaNcNQGrMnWUmQeDb8xqhvWVKBn71SNY6AyPWPhz0YCe3DqmFX1L88juh/osaJxX1HRJ
         5O2xHWFrueJ3PbzTiBBpjJIozVAKeOcGQ2ntBTJEDI+PkDshRWxWebM0zjW6EQYv2zDd
         CpL0HnWbQcUVphM1Sk7Uvkeor51FmZEwKrenEKi5eZQQ9Y0OG0r+NUBY3p/rwyjdfwHm
         dqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dbDmL994Vhe0hXjxzaEanvZdXD0IdPbePe09QjRulZg=;
        b=capxjERZctDif19FYbgkaqPgMEzMtkcEtpMdKTa8Apyu7kF07uFl0kgGMubWR2xQZn
         8CQkCoaU/Y0Uz6m/4EVqtZjwq/qppauFWC9N1QCkrnnvP2bTw8jewLSscwhzJJ246KrZ
         /hlXDSXiI1O7G34XUzBX4Vx3tQoebqCtTlESMBWkIZD82jwHO2u3qVrw3UKfyXd2Fzog
         gjvMGhQmiz+OwLHo0AwPAklYVTijWRMu4flzsWBLHXIzLmcbIzSvH1UQ8ayaZ861GCbx
         G0ht0hogVZrML9LhI4XnbEdcAbqk6DkIBIfUzDt0r10fiCDRshA7hp/Adj4xfA9po5a8
         5hsA==
X-Gm-Message-State: AOAM5320yU/9s9IgqgeLRVdtSCdzVkhbeGXwNCLSFWXeRTO/4QYVvebF
        4Wi5L7cZXHKebkxcyW2YGfvZcPlQJRrsfeHfiHYqC0bOSTAZnA==
X-Google-Smtp-Source: ABdhPJwOqeuO2jVdVy5jKXW2Ol1FNCOKt0JVTD0NsGqZ4EyRhyPRj6ud4pOlJGMHTWGsbfu2KNGpfnyHT5En0O3Epqg=
X-Received: by 2002:a05:6402:3049:: with SMTP id bu9mr29390765edb.127.1608830142897;
 Thu, 24 Dec 2020 09:15:42 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 24 Dec 2020 18:15:31 +0100
Message-ID: <CAP8UFD0uKV+PK6wkyyNV=--SBFOE8MGZRUdXCmMeGD4x3emOug@mail.gmail.com>
Subject: Draft of Git Rev News edition 70
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Sangeeta NB <sangunb09@gmail.com>,
        Charvi Mendiratta <charvi077@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Joey Salazar <jgsal@protonmail.com>,
        Sangeeta Bhandari <bhandarisangeeta0909@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-70.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/468

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and me plan to publish this edition on Saturday
December 26th.

Thanks,
Christian.
