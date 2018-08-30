Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 343FD1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 16:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeH3UaI (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 16:30:08 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37179 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeH3UaI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 16:30:08 -0400
Received: by mail-ua1-f66.google.com with SMTP id y10-v6so6013982uao.4
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 09:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i23X4IbTx/3Y/M/OwZR1IyIv5q2joIHXajbgqnHS6B4=;
        b=pXlV/LbP+nfkMQyWHNKpwbQZkgMttYLjVmEN4IvuJdHdCKbD0khEgRzxCPvBi4bMLI
         8Vk+kbuZv30PnZvIstgxpshSNBxbDj8C1fDliXHHshCdJFQiHss6kQE+yzKADmeTVGFX
         wfqBRC789JyxiH3/Ygc07gEY5/lJ6LU8Iwemzx9Kg6/hpXJIsf0Wr+p3LvBcYokjJaAp
         73djC8oIqqtuO5CmmUUBo6Nl/ghRKMnCxkRkqRPhhdjz450tzkRNC+flv0o7Xr7K1eRY
         LWVHmr9tgV/HCf6htiYMJE8VEfC5dxDoj5cBb2PPc7F72bYIUg/XVrZcDXwItIAlsnh0
         smgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i23X4IbTx/3Y/M/OwZR1IyIv5q2joIHXajbgqnHS6B4=;
        b=ZrerOaE4+jJs+iGYuUjqee4WQM9KzMvk0QQJGwKZjG+NjQaLskq6DQ0TtMmjq6l2tG
         yBIqE6ZpAHiB4kBZK7D5Gof02H44lLc0A5/Ky+zBmS8J/tTH32bmLEWl/4c2iYn/PY5O
         yfV2sZRONFu9PJRc3o8DR6WjqcVow3uoS1uogVg0wol7/Qg45fz7s8N839bIMnGej36O
         SLB9Tu2SUQTk9iDoy89g51PJ/VP03eI7MN8gxGNv3o6486IUqEYnP3vap1BgjNJsyY7t
         tny8K5f+9Oe8ZByyktMIng2NGpqfogizQwLFyysMugYWwbnzXlEpjxbZPd/Bdfu84Dhy
         AtPg==
X-Gm-Message-State: APzg51B2WWlOT/wuGCAqVBJrOr8C/LbsTafm2crtMKhuClL5wTho1In2
        KLbY9Rcz9BQSMqczNqY68hg9lsnsfxt3TE4341o=
X-Google-Smtp-Source: ANB0Vdaatzi5KGc6O/xuOjebJUY9K3RIB7N02ggRxpdmUvYP3apsf5tEGWnqw0pD5gB90frHbnJY5Vv2rz3zkwkxLwo=
X-Received: by 2002:ab0:52a4:: with SMTP id v33-v6mr7744100uav.32.1535646431150;
 Thu, 30 Aug 2018 09:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com> <20180829070613.11793-1-newren@gmail.com>
 <20180829070613.11793-2-newren@gmail.com> <xmqqo9dkakl0.fsf@gitster-ct.c.googlers.com>
 <CABPp-BFYhw9iU=jxt-1uY75GSt-_JtLnYQFf0kfjbqtK--xi3w@mail.gmail.com> <xmqqlg8n6dy4.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg8n6dy4.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Aug 2018 09:26:59 -0700
Message-ID: <CABPp-BErSY+284vqD6xiLrcsbMOghzM7vSp6THXkYuCbymUqKA@mail.gmail.com>
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

On Thu, Aug 30, 2018 at 9:01 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> Is this a single-shot environment assignment?  That would have been
> >> caught with the test linter.
> >
> > Ugh, yes.  Sorry.
> >
> > I was trying to allow backporting to 2.18, so tried to build my series
> > on that...but moved forward slightly to en/rebase-consistency in order
> > to re-use the same testfile (as mentioned in my cover letter).  But
> > that meant my branch was missing a0a630192dca
> > ("t/check-non-portable-shell: detect "FOO=bar shell_func"",
> > 2018-07-13), so the test-linter couldn't catch this for me.
>
> True, I also only caught this during my integration cycle, not
> during the review of the patches.
>
> >> Perhaps squashing this in would be sufficient fix?
> >
> > Thanks for fixing it up.  That works...although now I've spotted
> > another minor issue.  The FAKE_LINES setting is only needed for the
> > interactive rebase case and can be removed for the other two.  Oops.
> > It doesn't hurt, but might confuse readers of the testcase.
>
> Ah, OK.  So the squashable fix would now become like this, all
> fixing the ones from the first patch.
>
> > Would you like me to resend a fixup on top of your fixup, resend the
> > whole series with the fixes squashed, or just ignore this final
> > (cosmetic) issue since it doesn't affect correctness and I've caused
> > you enough extra work already?
>
> No worries.  This is what the maintainer does (when s/he is not
> playing other roles like a reviewer or an individual contributor).
>
> I'll squash in the following to the 1/3 patch and queue the topic
> with the other two patches.

Thanks, looks great.


> diff --git a/t/t3401-rebase-and-am-rename.sh b/t/t3401-rebase-and-am-rename.sh
> index 94bdfbd69c..e0b5111993 100755
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
> +               test_must_fail git rebase A &&
>
>                 git ls-files -s >out &&
>                 test_line_count = 6 out &&
> @@ -179,7 +179,7 @@ test_expect_success 'rebase --merge: NO directory rename' '
>                 git checkout B^0 &&
>
>                 set_fake_editor &&
> -               FAKE_LINES="1" test_must_fail git rebase --merge A &&
> +               test_must_fail git rebase --merge A &&
>
>                 git ls-files -s >out &&
>                 test_line_count = 6 out &&
