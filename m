Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF94C1F453
	for <e@80x24.org>; Mon, 11 Feb 2019 22:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfBKWEy (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 17:04:54 -0500
Received: from forward500j.mail.yandex.net ([5.45.198.250]:36556 "EHLO
        forward500j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726358AbfBKWEy (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 17:04:54 -0500
Received: from mxback14g.mail.yandex.net (mxback14g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:93])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id A1A3E11C1C46;
        Tue, 12 Feb 2019 01:04:51 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback14g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id eyQ28hv1WD-4p8CgqKo;
        Tue, 12 Feb 2019 01:04:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1549922691;
        bh=qJ0Dm51Kj73HGGbmetWvQ9QAnEhkwMWQmBpFb3ZQkF8=;
        h=From:To:References:Subject:Date:Message-Id;
        b=wnamvaz4LK4anN1zcRGKjrKSLfmz77YWiu+F9f9DPLxkfkiXrWnCA/StJmwAxNePc
         T9ASv50T7xDvKdkmjw6i53LfaWc8dYAnVv++vMDnUgkny4cUmO1yPjRmHF5bikQtCF
         jCcPCm5lhFH21UtBUjuxiWXc/0YrdRTeJJg/yBmw=
Authentication-Results: mxback14g.mail.yandex.net; dkim=pass header.i=@ya.ru
Received: by sas1-d856b3d759c7.qloud-c.yandex.net with HTTP;
        Tue, 12 Feb 2019 01:04:51 +0300
From:   Sergey Lukashev <lukashev.s@ya.ru>
Envelope-From: lukashev-s@yandex.ru
To:     Fernando Chorney <djsbx@djsbx.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CANFDZM6PikancjUdm+HYgGknD0dPhzxU6yOYFLZpcnCmg8JKdA@mail.gmail.com>
         <CANFDZM7fsbwwqhyWTzfivm4L=GgtCMfCi+DekZurs+SFGqaOjw@mail.gmail.com> <CANFDZM5=ffu-=H=vrO3Kr0t2km-3Zg4=msYUWqqJQKGxGojnqA@mail.gmail.com>
Subject: Re: git commit --verbose shows incorrect diff when pre-commit hook is used to modify files
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 12 Feb 2019 01:04:51 +0300
Message-Id: <31924311549922691@sas1-d856b3d759c7.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the time you see the diff the committing of changes has not yet been initiated. It's only after you type in the message that the ACTUAL committing starts and the hook runs.

You can print the diff of what your hook has changed by running "git diff" in it before adding changes.

12.02.2019, 00:28, "Fernando Chorney" <djsbx@djsbx.com>:
> Hi,
>
> I am trying to use a pre-commit hook to modify files before they are
> to be committed. The problem I am running into is that if I use "git
> commit --verbose", which I often do so that I can see the diff, the
> diff it displays in the editor is the diff before the pre-commit hook
> was run rather than what the diff would be after the pre-commit was
> run.
>
> I would like to note, that the pre-commit hook is definitely running,
> but when git grabs the diff seems to be in the wrong place.
>
> I have set up a simple example on my github to show the problem.
> https://github.com/fchorney/pre-commit-example
>
> Is this intended behaviour, or perhaps an issue?
>
>  Thanks,
>  Fernando Chorney

