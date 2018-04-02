Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59B421F404
	for <e@80x24.org>; Mon,  2 Apr 2018 03:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754095AbeDBDV5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Apr 2018 23:21:57 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37430 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754048AbeDBDV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Apr 2018 23:21:56 -0400
Received: by mail-wm0-f53.google.com with SMTP id r131so24643668wmb.2
        for <git@vger.kernel.org>; Sun, 01 Apr 2018 20:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FWh4U5Xy+bKntV3wgxlNhYqwMskphaD3nqqhLVyJeQ4=;
        b=s1XaALawfm1iEgwXimak+BSKjjAQS3XReEpS+eo6QMuRyZcB2sjmYZp3txGEfe5fHh
         PO5q+fQ+3i9q/a1Eg8uJ3DfXKd/NXf60OdoYbEc+hw5yiHSK8slTXWSjJw3eRHq1KCRD
         /2kQteH6J0dbam933oj1lCEb2035x+LlNG5uYyTdfHvt0NHWlaiOl6uJwvcPr3zZ7j8R
         ERDsOvU9fUj3UulZ+E/MXzoP3vuivqAz80BNuk0VskpyVQEjogwSKEuXQcluT1+KtqnG
         QUOOQXB+0CWrslMUlZwOD/xE6gHtnGgU6ZrDHlk7VU99tY1M1tD+duAktkTH+iv9Iawx
         /Eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FWh4U5Xy+bKntV3wgxlNhYqwMskphaD3nqqhLVyJeQ4=;
        b=hcUboNQvHbohf5wuilGzvOugLv+IMdoUO4OsFnhQ03R9S30nR1XcQNheSqHTyyeCNG
         dySP/XwT/QOcByvemYr3ImyIOugQM7EZBwkXNCf3JL0qRyEvBXlDJSkOxkh1bIHBUVIv
         2DssWskHnN1xxMqH6aaCGBcjsR7AJ29hlX9mfTvQMDuB4inxKstOvXX2bJNALuVTjy1c
         yx1ZchwHLL8S90Zg4+TDhBizTVN/rnpTLuvmN+WBUpmS5pU5PerW8l8AfMrIvQ+smeUG
         9Wd6XlACJWAbMe5fFfnZOjvxsC5zTgPajtaL9HS8L29XVphtSsJYumNgsmWCTX0aMNi2
         SEWQ==
X-Gm-Message-State: AElRT7GrnfwnWP/erUhqRS42hfnVnpi5tllEQtHp76dV9Qf0H0kyu8u6
        dVgxo7689Pdb1OaA4GQ7bHQ=
X-Google-Smtp-Source: AIpwx49jAZ7fBeZhGcwsd7w6sjzLMiUbGpCDWK8au1YDwJhCZUPYUbq41xBDyrtFEhyNUvZvbFByIA==
X-Received: by 10.28.20.140 with SMTP id 134mr7290673wmu.87.1522639315227;
        Sun, 01 Apr 2018 20:21:55 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 80sm17749394wmk.46.2018.04.01.20.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Apr 2018 20:21:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yubin Ruan <ablacktshirt@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] git clone add option to track all remote branches
References: <20180402015035.mzgye6apwn3igch5@HP>
        <xmqqwoxqz56y.fsf@gitster-ct.c.googlers.com>
Date:   Sun, 01 Apr 2018 20:21:52 -0700
In-Reply-To: <xmqqwoxqz56y.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 01 Apr 2018 19:56:53 -0700")
Message-ID: <xmqqsh8ez41b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If you are really doing your own development, then you would have
> some topic branches of your own, with forks of some (but most likely
> not all, especiallyi when there are many branches at the upstream)
> branches you got from the upstream, and "git branch --list" that
> shows only your own and what you are interested in (i.e. those that
> you actually bothered to "git checkout <branchname>") without
> showing random other branches that exist at the remote but do not
> interest you is a feature.  Your hypothetical "clone" that
> indiscriminatedly forks all branches at remote locally will destroy
> the usefulness of it.

Related to this, a feature I have long thought we wished to have is
complete opposite of this.  After creating and working on a local
topic branch and then concluding the work on it, a user would "git
push" the branch out to a remote, and then check out a different
branch (e.g. the 'master' branch).  I wish we had a mode that would
automatically *delete* the local topic branch that has already been
pushed out (and more importantly, a branch that I have *done* with,
at least for now), to unclutter my local branch namespace.  When I
want to further work on it, I can ask "git checkout" to dwim to
recreate one on demand.

Of course, there are some wrinkles due to pesky impleemntation
details (e.g. the "autonuke-and-recreate" would lose reflog), but I
do not think it is fundamental hurdle.


