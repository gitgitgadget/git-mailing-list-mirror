Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 301FC1F623
	for <e@80x24.org>; Thu, 29 Jun 2017 20:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752929AbdF2UDf (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 16:03:35 -0400
Received: from mail-ua0-f179.google.com ([209.85.217.179]:36423 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbdF2UDe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 16:03:34 -0400
Received: by mail-ua0-f179.google.com with SMTP id g40so63754896uaa.3
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 13:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=x2Ytj9FiG1b8e+f3iGpmBXRau2EoOtoGRiRx8W3+pQk=;
        b=jfw8aiZJheye5yJj7IdDrmBQ7T2Kf27nJJwGVAuld1v6U90ZGP/3U6jywJ2HGGUws5
         x17BFZBPNtlXUHpFM9rV1x4SYv2GTJZyEqQtJROoD+X8JbyYMt4K9MbjpgyiDlMepqCy
         1xnX+OmOGObOhnJyYDHkW6j7I7PZLgryauMnivXQlUZkwIQLeEuuZmMDsskrkYzxTXPL
         bjr3JpVzUS3phlqzkG0ov9TQtEF6nKj8gB3w2ZSByG3e9cLCdn1hoUHMOFc0AelOfLzc
         rdbomq/KTt3FY6yxzzRluzFzUruVpK25daf3uK9sII6sBYnbbaw564UeTQs2t4pVlzs9
         Bdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=x2Ytj9FiG1b8e+f3iGpmBXRau2EoOtoGRiRx8W3+pQk=;
        b=izy6fWaUTN3RFiygebXoAAclXi92B9Gvl6vmYZNUD62vHPkJXLIuaKO9lpSfQslKeC
         tE04U/o53CSqoD2icjSmYZpk7qSGTNJIAny3Dgbc8IIUHh7luLMu5ZlGHrKaPOb7h9Za
         LX7ykWaaPuB5boCEbvm+YmL3BnyRMaGLjbRf/6zN2hXYk3HpyEVPP7JAGhnzCRufcPyJ
         6SLUtKR+hkGIdbWnwsYetEXD4ZFts5mEq9DBjBz7bF3QDja6xmHvMBtWqqxVk8IPPpKT
         pslJDfIt4Hn+8kOsjQ2DIpdbCejb2si5kUSHUqoao3DRUgjCniL3qjewiNigLOP9V/cA
         fFng==
X-Gm-Message-State: AKS2vOxTFySKImaHQmCF4VqCSegiETAG+nMz4diICzMjjW4iJn6F1xAo
        Jv5BGC8ppv47aiNWhitieoFsR/ypKgBCOaA=
X-Received: by 10.176.95.220 with SMTP id g28mr8876790uaj.71.1498766613611;
 Thu, 29 Jun 2017 13:03:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.133.7 with HTTP; Thu, 29 Jun 2017 13:03:13 -0700 (PDT)
From:   Jason Karns <jason.karns@gmail.com>
Date:   Thu, 29 Jun 2017 16:03:13 -0400
Message-ID: <CAKNmmv16WG=8=66B8+paiRsjqFKjRKCLPyjEaHkNPsXaOhBCYQ@mail.gmail.com>
Subject: Re: [PATCH] completion: optionally disable checkout DWIM
To:     szeder.dev@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> We could discern between more than just empty vs. non-empty state of
> the environment variable, e.g.:
>
>  - if empty/unset, then include "DWIM" suggestions.
>  - if set to 'config', then query the 'completion.checkoutNoGuess'
>    configuration variable, and omit "DWIM" suggestions if its true.
>  - if set to something else, then omit "DWIM" suggestions.

> Then users can themselves decide, whether the per-repo configurability
> is worth the overhead of running 'git config'.

I would _definitely_ appreciate this feature. Firstly, thank you for
the addition of the environment variable. It is indeed much better
than the --no-guess flag.

However, I'm in a situation where I very much prefer the DWIM behavior
for nearly all of my repos. However, a very few repos have LOTS of
branches. And I only wish to disable DWIM in those few repos.

I attempted to create an alias (`git config alias.co 'checkout
--no-guess'`) in those specific repos. However, that turned out to be
foolish since I believe the alias parsing doesn't occur until _after_
the shell completion script runs (thus the --no-guess is not actually
present in the command parsed by the completion script).

So I'm back to very much wanting the ability to disable DWIM
repo-specific via git-config; and am willing to pay the git-config tax
as necessary.
