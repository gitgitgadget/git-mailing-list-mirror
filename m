Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6709F1F424
	for <e@80x24.org>; Thu, 26 Apr 2018 03:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeDZDvc (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 23:51:32 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41772 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751525AbeDZDvb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 23:51:31 -0400
Received: by mail-wr0-f196.google.com with SMTP id g21-v6so27747619wrb.8
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 20:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZE6NMIzGv+K2WK6Zd2U6LOwXY+w/3SQ5eqK3PxkmZuY=;
        b=VgUY2kcfHV9na5AKo1sRFVpbPoRQAwwS+xJnlYiXY04+gx6Xe26YIRhhw+wiksNJ7j
         bFRWedyzn6wGDLS5wd+R9aYu7kMC+iflBdjVqCcQdja5i70YbJToMot8285+JBBItqhv
         wqPLEuFaOsKID75bxPSRFMA2NIIGId7VqU4lnri5O8XIi3V6zdPhkoh8feq0QY09KFsu
         V7zLjV/ikQvjAYlNM/ifZjBHJ2F7063/0tvebM741YkhfJHQfi4jVQJiBb8lXjLoZm2v
         TVe5v0B/7boBVEzwrMgBDFT0nTGzYrEBVYplfvQ8cAIrUp1AtUwFT2VnK4yjN7Mm9kgI
         1EJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZE6NMIzGv+K2WK6Zd2U6LOwXY+w/3SQ5eqK3PxkmZuY=;
        b=tbEUGIuqdofXdmtIea9yawaScPyA4idbzMry+jiZuf/DZUuIGBA+xX8NpM2A0b493R
         vYge2j9oheJurskJWoFdOaNlAfkY5EJjBkLyYnF0LwQPkgzuMY60+xljQLOnd6Gsl6uL
         8q2sNK+vCSE6VVneIYSDLlOyyjd++rkZUXbaKUcD3rqcPrYdpirZdSZ7V+cPhOADKEPL
         gF3skY2l55en9qULQUU5Osi8DWSCYvjMTWUtzGp2ACjISNOVhLKn8JrPiTMylTNg9Rc0
         w7Js9RO6knYpJF2mbG098lmUvX1bGN4pcJmeXcgrAiDh+YCjglRM9UJwdWJJ5224taBC
         0wNw==
X-Gm-Message-State: ALQs6tAaf8Ipj4WVyhKciXntq3CHouUsSo3QWHYS3dOjdCY2KB3TMJBH
        cYRtqgkYjrwgmExLD/oZSYI=
X-Google-Smtp-Source: AIpwx49i2UoCg+nwpNT9PkCtRRS+eBbzPfMVSo8oo8gpBO/BsIzM+jZrbSKWk7IhWLoxYC6M3yO6Dw==
X-Received: by 2002:adf:b8eb:: with SMTP id c40-v6mr23177129wrg.170.1524714689715;
        Wed, 25 Apr 2018 20:51:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v75-v6sm35286698wrc.65.2018.04.25.20.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 20:51:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v9 00/17] rebase -i: offer to recreate commit topology by rebasing merges
References: <cover.1524306546.git.johannes.schindelin@gmx.de>
        <cover.1524659287.git.johannes.schindelin@gmx.de>
Date:   Thu, 26 Apr 2018 12:51:28 +0900
In-Reply-To: <cover.1524659287.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Wed, 25 Apr 2018 14:28:08 +0200")
Message-ID: <xmqqmuxq39rz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Changes since v8:
>
> - Disentangled the patch introducing `label`/`reset` from the one
>   introducing `merge` again (this was one stupid, tired `git commit
>   --amend` too many).
>
> - Augmented the commit message of "introduce the `merge` command" to
>   describe what the `label onto` is all about.
>
> - Fixed the error message when `reset` would overwrite untracked files to
>   actually say that a "reset" failed (not a "merge").
>
> - Clarified the rationale for `label onto` in the commit message of
>   "rebase-helper --make-script: introduce a flag to rebase merges".
>
> - Edited the description of `--rebase-merges` heavily, for clarity, in
>   "rebase: introduce the --rebase-merges option".
>
> - Edited the commit message of (and the documentation introduced by) " rebase
>   -i: introduce --rebase-merges=[no-]rebase-cousins" for clarity (also
>   mentioning the `--ancestry-path` option).
>
> - When run_git_commit() fails after a successful merge, we now take pains
>   not to reschedule the `merge` command.
>
> - Rebased the patch series on top of current `master`, i.e. both
>   `pw/rebase-keep-empty-fixes` and `pw/rebase-signoff`, to resolve merge
>   conflicts myself.

Good to see the last item, as this gave me a chance to make sure
that the conflict resolution I've been carrying matches how you
would have resolved as the original author.  Applying these on the
old base (with minor conflict resolution) to match the old iteration
and merging the result to the new base1f1cddd5 ("The fourth batch
for 2.18", 2018-04-25) resulted in the same tree as the tree that
results from applying these on top of the new base.

That was done only to validate the result of the past resolution
(and also seeing the interdiff from the old iteration).  There is no
reason to keep this series back-portable to older tip of 'master',
so I'll queue the result of applying the patches to the new base.

