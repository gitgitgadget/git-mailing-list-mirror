Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB8AC433E0
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDC9206D8
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgGZTpb convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 26 Jul 2020 15:45:31 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:45685 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgGZTpb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 15:45:31 -0400
X-Originating-IP: 209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (Authenticated sender: maxime@saumon.io)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 432821C0004
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 19:45:29 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id b30so7826086lfj.12
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 12:45:28 -0700 (PDT)
X-Gm-Message-State: AOAM53382hLEbp7HefrzBvdCrIXlBr0zx85RBQnvmKBjMQd05aZQmRDw
        eYSlanJstdct14viIbzQt+67hv8qZRAEO6WGzBA=
X-Google-Smtp-Source: ABdhPJxH6uYHbqW+tN13d5mGX8K5tqKU9RvQwImuWZb/L3iSDgCh+kwmJX7LF/gT4gE6VnPYFioNYZWuCmiDQFuGzPc=
X-Received: by 2002:a19:224e:: with SMTP id i75mr10137828lfi.58.1595792728496;
 Sun, 26 Jul 2020 12:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <CADv3qkGq3jA8iXsjhrqfsUX=gW+KOuLyeVgDzmku1tUpsMdvtw@mail.gmail.com>
 <xmqqr1sziqrm.fsf@gitster.c.googlers.com> <xmqqk0yripca.fsf@gitster.c.googlers.com>
 <a8c19b13-3f8c-6602-24dd-ef58af70d702@web.de>
In-Reply-To: <a8c19b13-3f8c-6602-24dd-ef58af70d702@web.de>
From:   Maxime Louet <maxime@saumon.io>
Date:   Sun, 26 Jul 2020 21:45:02 +0200
X-Gmail-Original-Message-ID: <CADv3qkHK_JO6v_jM1A3kXGnKZweJme53Eq3mSjkX0P3UEO7WqA@mail.gmail.com>
Message-ID: <CADv3qkHK_JO6v_jM1A3kXGnKZweJme53Eq3mSjkX0P3UEO7WqA@mail.gmail.com>
Subject: Re: Verbose commit message diff not showing changes from pre-commit hook
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> So, in short, it is not "undefined", but rather it seems to be a
> designed behaviour that we are seeing.

Thank you for your response and the technical explanation.

René Scharfe <l.s.r@web.de> writes:

> Committers review and sign off changes.  Hiding machine-made extra
> changes from them, that they then implicitly also accept responsibility
> for sounds questionable to me.  The prepare-commit-msg hook might be
> a place for such filtering.  But git commit showing the full extent of
> changes (incl. those made by the pre-commit hook) would be a better
> default, wouldn't it?

I second this. For me, the commit diff should include the "real"/full
commit diff. Even if the user didn't actually make some changes, the
commit they're about to make will include them, so it's completely
relevant to show these changes.
That's the behaviour I was expecting, and I was confused that Git
didn't behave that way.
To me, Git shouldn't really care where changes come from; they are
part of the commit so must logically be shown in the commit diff while
committing.

Thank you,

--
Maxime Louet
