Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A62B81FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 18:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757890AbdJKSMh (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 14:12:37 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32919 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757712AbdJKSMg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 14:12:36 -0400
Received: by mail-pf0-f193.google.com with SMTP id m28so2936230pfi.0
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8grjelapKbodnFDJy4F216KTU7UdQ3lWqmLKfMgN460=;
        b=JBmetfFnpC3zdd9hFq3vXf0nBUBkzxeXr/kCjunXba13RiLpB9aYx4pSVfY6ia7fJz
         EfAg0/l/95xp8QYd/3G40LuZ8Bv3pXYE+vtf4YMI6XuH0T7drJNJwnUu8NxYR/zSDclk
         RmG7AYtbuxQ60+aoVY0QPF668Mg+RAadGk1MZ2geQyXfelRs75etdA8RmI68eyBeSAKh
         sjUx57vK+EsGr0F7zyqvfrTPZA8Vv87aG+HWOOF/0VLpgAcEy+ijInBH7x6MkmIgf1oh
         jZz2+8K5SYS9HAF1E3yje5IKimGjBQN5d7ZGAiFFW7OQsPeaWX1NH6HekDPnOZ1lwBde
         vyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8grjelapKbodnFDJy4F216KTU7UdQ3lWqmLKfMgN460=;
        b=JYX2WY0WLhey2+4EC1+GvtotjBTUlPAV+pKZn6YJ1kco9aSuD0Gen5tBecH12X1+fM
         WBhdWcBAAjhbZmriJnYQTA/uQm0shyIJ8lLtnK2wcLgYG88fbhDBWSttAUra3sBZ18dx
         nBsIxbEXukeK1zZkY2uD6JARgz8UWtJA6Co7niPq02a4Rt7h1rXj4PI0HlUm9zCLkTkH
         hM2aBknsHe/o8RBU8pfvl1YyVaBDlYRL2KGP30cGEMkZyb9m2wGxC8HyTUBQdx90laVu
         sg6dm9S9y4FJBLDoRhF4zArRCZFPuwTC+zgBAx0i/trclo0fPq5HuqlVT3MVXqNYxXTx
         kT2w==
X-Gm-Message-State: AMCzsaWrw1gzurzxeV1tvMjTusmFgLOsQM8Mc7SM5NoJFeSwnA8jJz7s
        C/LoaCgZWT18QG946gyv4xIgySNx03vSsaGFp1bxF9JO
X-Google-Smtp-Source: AOwi7QDV0Duh5IyyblpE929lbT+EkLt0Mb51yoMAoF1WGsMbGnkZkHloLFe2ohFsU5mWmKcSr5jOIfzjPTUO9xJrYXI=
X-Received: by 10.159.198.131 with SMTP id g3mr328112plo.337.1507745556135;
 Wed, 11 Oct 2017 11:12:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Wed, 11 Oct 2017 11:12:35 -0700 (PDT)
In-Reply-To: <20171011172310.2932-1-me@ikke.info>
References: <20171009214543.12986-1-me@ikke.info> <20171011172310.2932-1-me@ikke.info>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 11 Oct 2017 20:12:35 +0200
Message-ID: <CAN0heSqbD8TJu+_d11gj2eftG3gR+n0j621q_uSnuLQc9t_pbQ@mail.gmail.com>
Subject: Re: [PATCH] column: show auto columns when pager is active
To:     Kevin Daudt <me@ikke.info>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 October 2017 at 19:23, Kevin Daudt <me@ikke.info> wrote:
> finalize_colopts in column.c only checks whether the output is a TTY to
> determine if columns should be enabled with columns set to auto. Also che=
ck
> if the pager is active.

Maybe you could say something about the difficulties of writing a test
for `git column` proper. Something like this perhaps:

  Adding a test for git column is possible but requires some care to
  work around a race on stdin. See commit 18d8c2693 (test_terminal:
  redirect child process' stdin to a pty, 2015-08-04). Test git tag
  instead, since that does not involve stdin, and since that was the
  original motivation for this patch.

> Helped-by: Rafael Ascens=C3=A3o <rafa.almas@gmail.com>
> Signed-off-by: Kevin Daudt <me@ikke.info>
> ---
>  column.c         |  3 ++-
>  t/t7006-pager.sh | 14 ++++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)

Does the documentation on `column.ui` need to be updated? It talks about
"if the output is to the terminal". That's similar to the documentation
on the various `color.*`, so we should be fine, and arguably it's even
better not to say anything since that makes it consistent.

> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> index f0f1abd1c..44c2ca5d3 100755
> --- a/t/t7006-pager.sh
> +++ b/t/t7006-pager.sh
> @@ -570,4 +570,18 @@ test_expect_success 'command with underscores does n=
ot complain' '
>         test_cmp expect actual
>  '
>
> +test_expect_success TTY 'git tag with auto-columns ' '
> +       test_commit one &&
> +       test_commit two &&
> +       test_commit three &&
> +       test_commit four &&
> +       test_commit five &&
> +       cat >expected <<\EOF &&
> +initial  one      two      three    four     five
> +EOF
> +       test_terminal env PAGER=3D"cat >actual.tag" COLUMNS=3D80 \
> +               git -p -c column.ui=3Dauto tag --sort=3Dauthordate &&
> +       test_cmp expected actual.tag
> +'
> +
>  test_done

Since `git tag` pages when it's listing, you don't need the `-p`. But
it's not like it hurts to have it. Yeah, I know, you needed it with `git
column`. :-)

I wonder if it's useful to set COLUMNS a bit lower so that this has to
split across more than one line (but not six), i.e., to do something
non-trivial. I suppose that might lower the chances of some weird
breakage slipping through.

This test uses "actual.tag" while most (all?) others in this file use
"actual". Maybe you worry about checking the "wrong" file, e.g., in case
the pager doesn't kick in. You could do `rm -f actual` before the
`test_terminal`-invocation to protect against that.

These were just the thoughts that occurred to me, not sure if any of
them is particularly significant. Thanks for cleaning up after me.

Martin
