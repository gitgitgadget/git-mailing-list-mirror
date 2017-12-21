Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 480DD1F424
	for <e@80x24.org>; Thu, 21 Dec 2017 18:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754124AbdLUSue (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 13:50:34 -0500
Received: from mail-ua0-f181.google.com ([209.85.217.181]:43705 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752678AbdLUSud (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 13:50:33 -0500
Received: by mail-ua0-f181.google.com with SMTP id g4so10808803ual.10
        for <git@vger.kernel.org>; Thu, 21 Dec 2017 10:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A0Kdm2El79omw+ZHQJzm2riJdvMZeWK+wMr7ozdmun0=;
        b=mVLAxgsV9PV6cZMN+cfGzL3cnkvKmSDTakMaac5TgztcG2gY1SCYOQuZIEQPBVU6Q7
         XRMs5MGN+46n2DDtOXhaEqrEUsuJR1jROhTgPiPOugMcRyeU7wOZvK9w4zV1JPn2v/sU
         GpsLiQesKo7qA+86XJ8eXKUfrbyMDKI3AgqayIQB48NLOJ7GDJY+mP8xA60jt7KCRo7x
         4PgPkp6Poy3P58ml6YWVvaf/MfXa5rw4Z3TXuPEcG4izok+rHsF4RvTGdFgjYXm39NkX
         nvrX8CoHY4fJoy9upyTb+X8ynbEz2NbUKIkBy2QuYmSDFrcg6iE5+VAZbx5pC5cB1HXW
         cEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A0Kdm2El79omw+ZHQJzm2riJdvMZeWK+wMr7ozdmun0=;
        b=BtcmXEkJI/fEBHBYDkswqKlSBaW4fU6WrVoJdkI/Psq+7NgLou4b8F9dLgd3qxmoNJ
         mrvXeFALu+gQrFh0qt0wQbdFByb6mAD9eh21zxl2NuPxOxKi7DRDy3SXkoc0jxnIE3lb
         iLCY/mIhbKzqcJgoKo6MkityNNuzHMnio+bWzfocMh5XBCtEM3FrcwIXWU4LSYrCXK0t
         ZDAKw/7qWOLn8v/y4jDlr3QSHKifBw2zB5D0EYmUqw1iMzEjXwNsCY6y75bQPTgCAeVh
         /eEjuOm/vvnwqF92Xgm6UQEXHU4inZjVf3NXvRQepGiRBArNyHzrlmKbBQ+7Y2jtl4GE
         AixA==
X-Gm-Message-State: AKGB3mIZtV/+5jh90tr3zeZ7qiAfgI/9GkOYMXUFRn88ejY3OsEihpYN
        Eo6ISQUYF+n7OsGV8CjBKsMw73h9MC8oUBal46A=
X-Google-Smtp-Source: ACJfBotsk/RvDFLhN8rjmj3xnvddhbqW5mbHljEdgTOpncMabw9FvwJmm4sy+weAEgmfDHKaP4aIou9vq05CbGOOpnY=
X-Received: by 10.159.59.234 with SMTP id y42mr7455648uah.123.1513882232436;
 Thu, 21 Dec 2017 10:50:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.82.5 with HTTP; Thu, 21 Dec 2017 10:50:31 -0800 (PST)
In-Reply-To: <20171220114310.GA2049@inner.h.apk.li>
References: <20171220114310.GA2049@inner.h.apk.li>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Dec 2017 10:50:31 -0800
Message-ID: <CABPp-BGy3_RyVQfCm+9O_AAfKA0_CZ5ajJE7NuLbToERWyWmqQ@mail.gmail.com>
Subject: Re: git merge commits staged files (when two trees are identical)
To:     Andreas Krey <a.krey@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 20, 2017 at 3:43 AM, Andreas Krey <a.krey@gmx.de> wrote:
> Hi everybody,
>
> we just stumbled over a situation in which a merge commits
> staged changes into the merge commit. This happens when the
> merged-in branch does have commits ('main') but has the same
> tree ('--allow-empty') as the merge base:
>
>     git init
>     echo eins >a
>     git add a
>     git commit -m initial
>     git branch sub
>     git commit -m main --allow-empty
>     git checkout sub
>     : two
>     echo zwei >>a
>     git add a
>     git commit -m underway
>     : three
>     echo drei >>a
>     git add a              # important
>     git status
>     git diff --cached
>     git merge master -m 'merge'
>     git status
>     git log --cc -1
>
> If the change isn't staged (comment out the '# important' line)
> the change survives as unstaged.
>
> That is a bug?

Yes, it's definitely a bug; thanks for reporting it.  We have a
specific set of tests for this type of situation in t6044, which was
intended to test all the merge strategies and ensure they didn't have
this class of bug.  It turns out that there is an additional codepath
within one of the strategies that wasn't tested, and which you've
tripped over.  I've got some patches to fix this up that I'll respond
with shortly.
