Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08C2C20188
	for <e@80x24.org>; Mon,  8 May 2017 00:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751111AbdEHAzS (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 20:55:18 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36827 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbdEHAzR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 20:55:17 -0400
Received: by mail-pg0-f66.google.com with SMTP id 64so648375pgb.3
        for <git@vger.kernel.org>; Sun, 07 May 2017 17:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=D36Dd9mhvs7mz6j/Z5C//qJG7ZHBKcfI1WAzl94YDlM=;
        b=BLmpaNYfwmInDz+RcPs4A/AuvrK4rISLx8WX1vo/LWFGFfIX9jlubsM00812vUAccM
         uLnCKSE3CjbUTS8qN2fWU+6CU5LbP062mB3XyjeCQ6NtU5I2He6ba7xau0FC/5nf/yXD
         JfjfUKoXz9x1dqnYRpQdbdIGGONOO3+6PLermtY4CB83S8H87udAsX4Yv34cPZEvjWWb
         viI+dNRNBR7VmpdVKqTY5fzjt+uDiN9BRxlUir5V47wzjAtLUsBMKuH2CSGrGqHzAbOB
         WnQbAy/g6qgfE9WfDClafaXr7nB5SGYZapBMl/ygD4SByGMHelFUE2Pl8s3WmAM2AK9g
         XY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=D36Dd9mhvs7mz6j/Z5C//qJG7ZHBKcfI1WAzl94YDlM=;
        b=WMhCZq/cHyLtxJvDgZn9wdwdZoiujQT3s1s+rtaxQdgo5CZ2ejNMw8O+9RHMr97QCx
         E0aITwXU6zwr2dR3zbTBROIcGSjzBdwlAisSXz3KvxPHErvf/TQ/mzErMcnLbJHiVJL8
         czvYPRTXUkts5k3eik+0AVuMnrS+U/MNLOqfeV/JgPTYpFTT/h/S0haBf/0zVIXzo/ww
         faPLUQWNPfGK958QNZ6CSaZD3IbP1ztiQ8hPQiVz42HvTn5lwGbjjkm+f3dA1paUJ8zP
         aUNPu3TncCnBp/ezi7Id1sNspPQMY5MAjekbrY2FeOCz/VcJarDBu8DFjPocAerEueis
         +XKg==
X-Gm-Message-State: AN3rC/4lRW57uAISJyNyE26BGYrISgPRhJSb21wwlwXuE+2CThJdtYNL
        Sy1V4rl3k7c2KdTGMoM=
X-Received: by 10.98.94.69 with SMTP id s66mr29231009pfb.116.1494204916836;
        Sun, 07 May 2017 17:55:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id v45sm14783946pgn.56.2017.05.07.17.55.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 17:55:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefano Lattarini <stefano.lattarini@gmail.com>,
        =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>,
        "Arnold D . Robbins" <arnold@skeeve.com>
Subject: Re: [PATCH 0/7] Update the compat/regex engine from upstream
References: <20170504220043.25702-1-avarab@gmail.com>
Date:   Mon, 08 May 2017 09:55:15 +0900
In-Reply-To: <20170504220043.25702-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 4 May 2017 22:00:36 +0000")
Message-ID: <xmqq8tm8cglo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> See the first patch for motivation & why.

I do not think it quite explains the motivation, though.  "Doing
this way, we can keep in sync with the upstream more easily"?  Or is
there anything more to it, e.g. "and we need to update from the
upstream now to fix this and that issues"?

Having these "fixup!" as separate patches on the list makes them
smaller and easier to understand.  What do we want to do with them
once they are applied?  Squash them all up, because these do not
have their own explanations in their log message and it is not worth
keeping them separate?

> The only reason this has a cover letter is to explain the !fixup
> commits. IIRC the mailing list has a 100K limit, which this series
> would violate, so I split up the second commit.
>
> Consider all these !fixup commits to have by Signed-off-by, easier to
> say that here than to modify them all.
>
> Ævar Arnfjörð Bjarmason (7):
>   compat/regex: add a README with a maintenance guide
>   compat/regex: update the gawk regex engine from upstream
>   fixup! compat/regex: update the gawk regex engine from upstream
>   fixup! compat/regex: update the gawk regex engine from upstream
>   fixup! compat/regex: update the gawk regex engine from upstream
>   fixup! compat/regex: update the gawk regex engine from upstream
>   fixup! compat/regex: update the gawk regex engine from upstream
>
>  Makefile                                           |   8 +-
>  compat/regex/README                                |  21 +
>  compat/regex/intprops.h                            | 448 +++++++++++++++++++++
>  .../0001-Add-notice-at-top-of-copied-files.patch   | 120 ++++++
>  .../0002-Remove-verify.h-use-from-intprops.h.patch |  41 ++
>  compat/regex/regcomp.c                             | 356 +++++++++-------
>  compat/regex/regex.c                               |  32 +-
>  compat/regex/regex.h                               | 120 +++---
>  compat/regex/regex_internal.c                      | 118 +++---
>  compat/regex/regex_internal.h                      | 118 +++---
>  compat/regex/regexec.c                             | 242 +++++------
>  compat/regex/verify.h                              | 286 +++++++++++++
>  12 files changed, 1487 insertions(+), 423 deletions(-)
>  create mode 100644 compat/regex/README
>  create mode 100644 compat/regex/intprops.h
>  create mode 100644 compat/regex/patches/0001-Add-notice-at-top-of-copied-files.patch
>  create mode 100644 compat/regex/patches/0002-Remove-verify.h-use-from-intprops.h.patch
>  create mode 100644 compat/regex/verify.h
