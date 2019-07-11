Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC4561F461
	for <e@80x24.org>; Thu, 11 Jul 2019 19:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfGKTch (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 15:32:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46918 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfGKTcf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 15:32:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id c2so3516750plz.13
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 12:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxJ3nfJd7dAM8CdxKICMInEp9FtNU9RJTuDWRigC6oo=;
        b=mQghdzq8mHuPru3PGqBh16yuwoX0eJzXlKAGZH4KpvIjkJLRy6rX8I9XjqwhvXryg9
         uYhREEITFencBCKN/jTgg+DCTliK4Zy5GLD04PQ2JvwE1v3N2CYc/0zDYiidqABOnMfg
         o3amCLyW8JIjrafuy5hMnDvXoZoKaWyy2eummnrHSN5X3iWja4W7VGW3BmaS7afdiHTy
         RYWRnpGvqpkMuRmDcB47QZKHjstrffSHVQ7DoNjAod6zh5KY6i3UamAarJiIHXfE5pqA
         dmNgXOc5xzVPJpImC091tur7rtjAji9V7s1mEj02KgkDifa9/tPn15BQ3iITpOgH/ow1
         QDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxJ3nfJd7dAM8CdxKICMInEp9FtNU9RJTuDWRigC6oo=;
        b=WtGgVbYzhfGZgJpA8BafcOxvUxEAQVFnCjDdWTPhjUivmQkiTvEOZvVvTv6/IPz9ZL
         IXx+3CM9HJoBCHbOlDskBBDeMolbhHr/2ARAR6Xudpu/sN9xgVJDMBkh1Wg+vUrExDim
         N0BqIDGRZiKRLuCctkRVGokZdxjLsPRq0UtKGVTwM031GLJ1Hr9+pJXRKMcazOoYK2Pl
         nZkCr1xlfABg7WM9fRbFIK7HhXhb+9qT9IAtUsiWNpneTzqMP+hYFaxjlwNaKoyXvVta
         7V6tOpO6EbroHXXbh7iyo75ta5e0EsdDKFtTPByDfdmMTwpCliAxENiMbyYy4UFB5Ukl
         B1iA==
X-Gm-Message-State: APjAAAXl9ZbARfl0ZBOdANrNth8rTETksSN91hYRydY4HaR0+8+kK0kv
        Q7HjSNzmR9KgVrIsz0OMgV1qTLcextxFHjwAkVs=
X-Google-Smtp-Source: APXvYqxWSRW6KrwrrTaUwqiNPGd6WrxQX5KPw+pCA9FCZjhFTeBsTL5W8RrSmb8tcmT3fkZZ/wR/3BYKmIIdqBvDmVY=
X-Received: by 2002:a17:902:8509:: with SMTP id bj9mr6565892plb.79.1562873554782;
 Thu, 11 Jul 2019 12:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190711183727.8058-1-ariadne@dereferenced.org> <20190711183727.8058-4-ariadne@dereferenced.org>
In-Reply-To: <20190711183727.8058-4-ariadne@dereferenced.org>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 11 Jul 2019 21:32:23 +0200
Message-ID: <CAN0heSqQTVzqceJTma4KJ28KLGk6Z0+2uheVPpQjRqc0YvWnFQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] tests: rework mailmap tests for git log
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 11 Jul 2019 at 20:39, Ariadne Conill <ariadne@dereferenced.org> wrote:
>
> In order to prove that the --no-use-mailmap option works as expected,
> we add a test for it which runs with -c log.mailmap=true to ensure that
> the option successfully negates the configured default.

I believe that testing with `-c log.mailmap=true` is not doing much --
if we ignored that config entirely, we would still produce the wanted
result. I think it's more important to test with "...=false". (Testing
something like `-c log.mailmap=false -c log.mailmap=true` would
basically just test our config-parsing in general, and we don't need to
do that here -- there are other tests for that. Anyway, I digress.)

You or others might very well disagree with me, so feel free to wait
for a while to see if others chime in. Just so you don't have to change
back and forth due to my whims.

> Additionally, since --use-mailmap is now the default behaviour, we
> remove mentions of --use-mailmap from the tests, since they are
> redundant.  We also rework some tests to explicitly define the
> log.mailmap variable in both true and false states.
>
> Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
> ---
>  t/t4203-mailmap.sh | 49 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 41 insertions(+), 8 deletions(-)
>
> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index 43b1522ea2..3d6086ff96 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -422,8 +422,8 @@ Author: Some Dude <some@dude.xx>
>  Author: A U Thor <author@example.com>
>  EOF
>
> -test_expect_success 'Log output with --use-mailmap' '
> -       git log --use-mailmap | grep Author >actual &&
> +test_expect_success 'Log output with mailmap enabled (default)' '
> +       git log | grep Author >actual &&
>         test_cmp expect actual
>  '

It's a bit unfortunate that we're ignoring the exit status of `git log`
since that is the exact command we want to test here. I know you're just
following suit here, but if you're touching this line /anyway/, it might
make sense to rewrite this into

  git log ... >out &&
  grep Author out >actual &&
  ...

> -test_expect_success 'Log output with log.mailmap' '
> +test_expect_success 'Log output with log.mailmap enabled in config' '
>         git -c log.mailmap=True log | grep Author >actual &&
>         test_cmp expect actual
>  '

Then the question is if you should change this line "while at it", or
start with a preparatory patch to first just convert all these "git log
| grep" to the pattern I showed above, then have a patch 2/2 with the
actual change you want to make. I'm sure there are different opinions
here about what is right and not. Anyway, I'm not the one to complain if
you just ignore all of these "not so optimal" lines that you're not
touching anyway.

BTW, this is a test where I wonder if it's really worth running. We
basically just check that we won't choke completely on this redundant
config.

> +cat >expect <<\EOF
> +Author: CTO <cto@coompany.xx>
> +Author: claus <me@company.xx>
> +Author: santa <me@company.xx>
> +Author: nick2 <nick2@company.xx>
> +Author: nick2 <bugs@company.xx>
> +Author: nick1 <bugs@company.xx>
> +Author: A U Thor <author@example.com>
> +EOF
> +
> +test_expect_success 'Log output with log.mailmap disabled in config' '
> +       git -c log.mailmap=False log | grep Author >actual &&
> +       test_cmp expect actual
> +'

Now this test, on the other hand, I really like having!

Again, you're just following suit: Nowadays, we try to run things like
"cat ...>expect ..." as part of a "test_expect_success" block. Same
question about how maybe one should first convert all existing
instances. And again, IMHO it's perfectly fine if you ignore the
existing ones, but do it the "correct" way for the ones you're adding.

> +
>  cat >expect <<\EOF
>  Author: Santa Claus <santa.claus@northpole.xx>
>  Author: Santa Claus <santa.claus@northpole.xx>
>  EOF
>
> -test_expect_success 'Grep author with --use-mailmap' '
> -       git log --use-mailmap --author Santa | grep Author >actual &&
> +test_expect_success 'Grep author with mailmap enabled (default)' '
> +       git log --author Santa | grep Author >actual &&
>         test_cmp expect actual
>  '
>  cat >expect <<\EOF
> @@ -456,16 +471,34 @@ Author: Santa Claus <santa.claus@northpole.xx>
>  Author: Santa Claus <santa.claus@northpole.xx>
>  EOF
>
> -test_expect_success 'Grep author with log.mailmap' '
> +test_expect_success 'Grep author with log.mailmap enabled' '
>         git -c log.mailmap=True log --author Santa | grep Author >actual &&
>         test_cmp expect actual
>  '

(Again, I kind of wonder what this buys us.)

> -test_expect_success 'Only grep replaced author with --use-mailmap' '
> -       git log --use-mailmap --author "<cto@coompany.xx>" >actual &&
> +test_expect_success 'Grep author with log.mailmap disabled' '
> +       git -c log.mailmap=False log --author "<santa.claus@northpole.xx>" >actual &&
> +       test_must_be_empty actual
> +'

Nice.

> +test_expect_success 'Grep author with --no-use-mailmap' '
> +       git log --no-use-mailmap --author "<santa.claus@northpole.xx>" >actual &&
>         test_must_be_empty actual
>  '

Nice.

> +test_expect_success 'Only grep replaced author with mailmap enabled' '
> +       git log --author "<cto@coompany.xx>" >actual &&
> +       test_must_be_empty actual
> +'
> +cat >expect <<\EOF
> +Author: santa <me@company.xx>
> +EOF
> +
> +test_expect_success 'Grep author with --no-use-mailmap + log.mailmap=True' '
> +       git -c log.mailmap=True log --no-use-mailmap --author santa | grep Author >actual &&
> +       test_cmp expect actual
> +'

It should be possible to drop "-c log.mailmap=true" from this.

I think you could just squash these three commits into one. It would
tell a consistent story about how the specification changes, and the
tests and the implementation follow suit.

One last thing: I'm kind of assuming this change of default is something
that is actually wanted. I don't have strong opinions there, and maybe
others disagree. I know something like this has been discussed before,
and I kind of suspect the reason it hasn't been done before is that
nobody has done it -- not that it isn't wanted. You could probably find
more in the archives, e.g., at public-inbox.org/git.

Martin
