Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B5641F404
	for <e@80x24.org>; Wed, 29 Aug 2018 23:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeH3Dq6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 23:46:58 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33578 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbeH3Dq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 23:46:58 -0400
Received: by mail-vk0-f41.google.com with SMTP id w187-v6so3444561vkw.0
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 16:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ZMULAlWSA701bLVn4+Cbx4jjo2c+Rgk5QDC3+qMuO0=;
        b=uSD7rh0xnPkxDg5M7p0ObQGHW0YVLrxOJmK3e+vWUmZ3BJIVfBDoAHIh+UPuRQhFr8
         axtvtTmkB4rLgxFCtj90/tJyGa9uHj6wVdW6feodrI/MJAwELRfVxn2u09ENjG896TG6
         xSN/vgWnnNy7Q27JzBwu3AVMtKR2utXeqikddSUo8B/FHDGET6MSdY5c6j16xefmN04g
         PKYIUa1XxV98CGwtFvTdzXz5fnnSfA2hDZ0YiKBPbESkXXDy1uyLWWNExYWjFI4HsJgJ
         Y3EdS4Dnxfp2KscHGNEAJsBBUK+OVKOo3sqYm0mGzUHnGzN7sq36oMRi7GLJdMtKdrIJ
         Oj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ZMULAlWSA701bLVn4+Cbx4jjo2c+Rgk5QDC3+qMuO0=;
        b=jj85TtJEHbkDlBHyq0pjoA2PVCcrh7b2cQdWl91V232XWZ6ewjH9MjPJ+7l2B7eEX8
         dgFQ/BIQtyVpskY3p/6YrvP96DzyXXZSD67WEwkIjOlK5dVs94gZWlfdt7zDj4ituoF9
         yGvYDQSnAV/AsOKeCy7W+0AF/QjRLzek+GNu62iMkzRJWMvITYzcWYvluJ0BtqkpBT8u
         JjBuNHJSI+NeRU6UlP1iqUSn6ip4HCxCwnC8Z2EpM0ow0j2CsoWOop2zmX5vHhrabEB9
         NAE5AuaoMyxL8F0IgV55h1pdJjVEqon0sg3gX/U7DqWeqsbThBX8y4WcVYzhxQQVct63
         EzfA==
X-Gm-Message-State: APzg51Df6DAW8h2r5P+wABCXKL1+kqKVU/hYkTOAwrTW/jg57rVHc0/C
        mXY09JVMiVlJ6MXgPhikI7yIbfF56xlELkNrihk=
X-Google-Smtp-Source: ANB0VdbK2j5uT8xSc5D3KrlW2lGRWZPPsYzTzoCIm2xX4saSt/6jiURl/oNc75H4BC84mOy6GNCYEfAVZix2f2h4VHI=
X-Received: by 2002:a1f:d945:: with SMTP id q66-v6mr5363581vkg.38.1535586458424;
 Wed, 29 Aug 2018 16:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com> <20180829070613.11793-1-newren@gmail.com>
 <20180829070613.11793-2-newren@gmail.com> <xmqqo9dkakl0.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo9dkakl0.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Aug 2018 16:47:26 -0700
Message-ID: <CABPp-BFYhw9iU=jxt-1uY75GSt-_JtLnYQFf0kfjbqtK--xi3w@mail.gmail.com>
Subject: Re: [PATCH 1/3] t3401: add another directory rename testcase for
 rebase and am
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, corrmage@gmail.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Aug 29, 2018 at 3:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > +test_expect_success 'rebase --interactive: NO directory rename' '
> > +     test_when_finished "git -C no-dir-rename rebase --abort" &&
> > +     (
> > +             cd no-dir-rename &&
> > +
> > +             git checkout B^0 &&
> > +
> > +             set_fake_editor &&
> > +             FAKE_LINES="1" test_must_fail git rebase --interactive A &&
>
> Is this a single-shot environment assignment?  That would have been
> caught with the test linter.

Ugh, yes.  Sorry.

I was trying to allow backporting to 2.18, so tried to build my series
on that...but moved forward slightly to en/rebase-consistency in order
to re-use the same testfile (as mentioned in my cover letter).  But
that meant my branch was missing a0a630192dca
("t/check-non-portable-shell: detect "FOO=bar shell_func"",
2018-07-13), so the test-linter couldn't catch this for me.

> Perhaps squashing this in would be sufficient fix?

Thanks for fixing it up.  That works...although now I've spotted
another minor issue.  The FAKE_LINES setting is only needed for the
interactive rebase case and can be removed for the other two.  Oops.
It doesn't hurt, but might confuse readers of the testcase.

Would you like me to resend a fixup on top of your fixup, resend the
whole series with the fixes squashed, or just ignore this final
(cosmetic) issue since it doesn't affect correctness and I've caused
you enough extra work already?

>  t/t3401-rebase-and-am-rename.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t3401-rebase-and-am-rename.sh b/t/t3401-rebase-and-am-rename.sh
> index 94bdfbd69c..13e09afec0 100755
> --- a/t/t3401-rebase-and-am-rename.sh
> +++ b/t/t3401-rebase-and-am-rename.sh
> @@ -141,7 +141,7 @@ test_expect_success 'rebase --interactive: NO directory rename' '
>                 git checkout B^0 &&
>
>                 set_fake_editor &&
> -               FAKE_LINES="1" test_must_fail git rebase --interactive A &&
> +               test_must_fail env FAKE_LINES="1" git rebase --interactive A &&
>
>                 git ls-files -s >out &&
>                 test_line_count = 6 out &&
> @@ -160,7 +160,7 @@ test_expect_success 'rebase (am): NO directory rename' '
>                 git checkout B^0 &&
>
>                 set_fake_editor &&
> -               FAKE_LINES="1" test_must_fail git rebase A &&
> +               test_must_fail env FAKE_LINES="1" git rebase A &&
>
>                 git ls-files -s >out &&
>                 test_line_count = 6 out &&
> @@ -179,7 +179,7 @@ test_expect_success 'rebase --merge: NO directory rename' '
>                 git checkout B^0 &&
>
>                 set_fake_editor &&
> -               FAKE_LINES="1" test_must_fail git rebase --merge A &&
> +               test_must_fail env FAKE_LINES="1" git rebase --merge A &&
>
>                 git ls-files -s >out &&
>                 test_line_count = 6 out &&
