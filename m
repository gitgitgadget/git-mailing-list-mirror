Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6F1C07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 02:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5889061374
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 02:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbhGNCT6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 22:19:58 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:38467 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbhGNCT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 22:19:58 -0400
Received: by mail-ed1-f51.google.com with SMTP id ee25so922966edb.5
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 19:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vlh9/I+ygok+2BQ7VSILq310XF+JEjjrQn/K5WnQ4nk=;
        b=pCw7hq0o7XNiFM4Hgs+rnha0oEyxK66oKg0v3fAOkwe5u1KPv47AeVjmW42FdVSXzX
         t9MzLYknwKw8oyv53LIL2CqWCD8yiqQtKC6VbtaGsuUnVRiytLeZDeV51E7GtgZD6dbR
         b6Tu4KOkxPCc9JvLWanql/1PeoHdTENx/au0wk0VpPFKM2b6yItVBxqF4/TJXp92l+hv
         NEPjMkZJJZHQPnglaFxsGaYOMQNhU05JjEtOOEal2NO29inERxsXoM9yukof/aZibGkK
         EUEZh0lh3+57I9KuZ28nASJ7ubgoW9nZE1RbDh8R+QELz4ra/V0aWzEs1zgsNmYL1HvO
         dolg==
X-Gm-Message-State: AOAM532J6bG4J0kGM3H7tNKfIXWaEsr1hUbw/Tv3Cc7R63Cs+0vw08ju
        fImtyHkNXYjTLVw67yeDWkrqWsTi+T7haTy/Aa8=
X-Google-Smtp-Source: ABdhPJxFAoj2mOASiqcdJfBwASz+W/shs3u3o1sdT00H9uDMVyf1YoWtMvWJCmUZ+U8tIJH5wwrD7dKzu8sxTDP09vE=
X-Received: by 2002:a05:6402:152:: with SMTP id s18mr9912186edu.221.1626229025497;
 Tue, 13 Jul 2021 19:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqmtqpzosf.fsf@gitster.g>
In-Reply-To: <xmqqmtqpzosf.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 13 Jul 2021 22:16:54 -0400
Message-ID: <CAPig+cQfsACHAQhCrXDs==18p1Ds8MtMRZDmSfso9HsO6dF-qg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Stephen Manz <smanz@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 13, 2021 at 9:07 PM Junio C Hamano <gitster@pobox.com> wrote:
> * sm/worktree-add-lock (2021-07-12) 3 commits
>  - worktree: teach `add` to accept --reason <string> with --lock
>  - worktree: mark lock strings with `_()` for translation
>  - t2400: clean up '"add" worktree with lock' test
>
>  "git worktree add --lock" learned to record why the worktree is
>  locked with a custom message.
>
>  Ready?

I think this series is ready and gave my Reviewed-by: here[1]. One of
the new tests contains an unnecessary but harmless `test -f`[2], but
it's such a minor nit that I doubt it's worth demanding a re-roll.

[1]: https://lore.kernel.org/git/CAPig+cSVsJ9AtAMqtRQpyuosCDCGi+mu2C1PJUK49WTb5KvcWQ@mail.gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cQVSUg1aqry_hMydJ=Uo=-VhOog6TUTpG=0on0LUcw8Dg@mail.gmail.com/
