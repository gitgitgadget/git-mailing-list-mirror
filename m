Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBCEC282DD
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 21:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A2A20848
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 21:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgAJVps (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:45:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42753 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgAJVpq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 16:45:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so3154957wro.9
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 13:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GnK8h66sMk9yBcwFEtPTH+tFpp6cVdJ0B+m4tEj2IWM=;
        b=HWVsCZhT8z6ONHEfL0WiINYD2K+N1NP8+GJY0c6ujppwBbxSRC2UU+0PELaitgQcdm
         IP/io0BFq/+rdCFNpd4NP6bLbK6kJXOtGgkCbyIfiM6pEqz1ZBIqhxm7XYrU2p/qz9KJ
         +tON4oBsKpAShceQJsxcqgNe6SUvqxQTKVs3shgA6cOTxoo+uzjXL3EJTnR3ZFipg9nr
         ICADB+9WUkvpZyts8xc9/IKD9Z6YhHJwt+X8+DUrQpaCMsuQJzKrNYRc+6FoPc/Lvgtx
         CVOnzYC3XonvCcMZUCtyp8lODrEZRGtAsEQsfW83iJDWrWyifAzOAd9xmgc2BtBfN9Tr
         YTBQ==
X-Gm-Message-State: APjAAAXCEzLs9ZsuGhYJPwgWcz776a66nFoQWmKVB39gqHszgKGmwQ5R
        6MttVfHCHlnIv/3Y5gj7vbO/aZKjqSd9PZZt8pw=
X-Google-Smtp-Source: APXvYqwPPCcN+wfMCxLIP++O+Icdw3zJ8PxdE1ObhxmyKyyOcqqXlXXJj3VqMu4cPPPIbN98BloxwDfQdrT0zEgDMXs=
X-Received: by 2002:adf:b193:: with SMTP id q19mr5472906wra.78.1578692744761;
 Fri, 10 Jan 2020 13:45:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577454401.git.liu.denton@gmail.com> <cover.1578372682.git.liu.denton@gmail.com>
In-Reply-To: <cover.1578372682.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 10 Jan 2020 16:45:33 -0500
Message-ID: <CAPig+cT_riAaTqvdCbFim0BvCaz1aUoHiS9u6dUsDWe46ZVKAw@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] t: replace incorrect test_must_fail usage (part 2)
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jakub Narebski <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 6, 2020 at 11:53 PM Denton Liu <liu.denton@gmail.com> wrote:
> Changes since v1:
> * Clean up as suggested by Eric
> * Replace 12/16 with J6t's patch

In the future, please also provide a link in the mailing list archive
to the previous round (v1 [1], in this case) to help reviewers
understand what these bullet points mean since the points themselves
are quite lacking in detail. Pointing people at the previous round
helps not only those who reviewed that round -- who may have already
forgotten the details of their own and others' review comments -- but
will also help onboard people who start reviewing at this round.

> Range-diff against v1:
>  -:  ---------- >  3:  501eb147c3 t2018: improve style of if-statement
> 16:  31aa0c7d15 <  -:  ---------- t4124: let sed open its own files

Dropping patches when re-rolling is fine, but please do not sneak in
new patches unrelated to any of the original changes in this series.
Not only is it likely that such a patch will get overlooked by
reviewers, but even when it is noticed, reviewers have to spend extra
time and effort trying to understand why the patch was added in the
first place (especially since there is not even a mention of it in the
cover letter). After digging into it, I can see that this newly-added
patch (3/16) is an additional sensible style cleanup to the same test
script that many of the other patches are touching, so in some sense
one could argue that it's very vaguely related to v1, but please keep
in mind the potentially negative effect it can have on reviewers[2]
when new changes are added to a series, causing the series to diverge
rather than converge.

[1]: https://lore.kernel.org/git/cover.1577454401.git.liu.denton@gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cQqK-HiDjmnBFo-qeE6cZ73EveWg6Ygb-4BX3X_iPSJZA@mail.gmail.com/
