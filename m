Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85BFC1F42D
	for <e@80x24.org>; Fri, 25 May 2018 16:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753648AbeEYQ7d (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 12:59:33 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40450 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751509AbeEYQ7c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 12:59:32 -0400
Received: by mail-oi0-f66.google.com with SMTP id c203-v6so5152367oib.7
        for <git@vger.kernel.org>; Fri, 25 May 2018 09:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p2Af3g2Foz5cXP5MoCt6zsu2dyhsBWPRyxbttCUhmGU=;
        b=jRC1j1lZMtoJZMUCs+vPDBYbrfagEtg4p1XSpt++UE6WZJGNPCd51INqi3g696Lvj4
         0Mj0X64Tg4m1Qx3BbACf1/+ExY+rUEv66lhXcOHRu69KnCixm0Im05iatfxS4Ln87Cxa
         EsAeNKW2rKQCy6P8EDDe7g+rBb1Fkvr0SRlEtGShz4FJPbrGQI8jCunaIPfYraLUcuSb
         1lr3fDVQju3q3Z35wyRldySr2Y++IRvDPmebv54ukm+9rafld19DXr4DNr0vXB+scn8b
         oLzJCJE7vHNPBTNxXItFADEgmk/oebc2UEuz/dfMyGHWMFpW3qZ2QLWUwrzuwVQkyQbl
         r7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p2Af3g2Foz5cXP5MoCt6zsu2dyhsBWPRyxbttCUhmGU=;
        b=sYWSbgz3BUXdDXU9uHe98UpmM3OWwixCswffL6rIwl2cLF5mth0DCvaRpKAKhbhqOx
         ds/SBoAdZa7FK5qbz3yH3/eSsAtg8gzgBdvTY2Kej5M2lhBOymm5ot2cNgJddcBunix8
         6M1dzmfUANeUpM76q7JV/KGbex64fphgpIfVXDtjV/wm7WiGy3JIeCzATS/kJnsW5BSm
         zKp1rbCtg34OGdsgfbnvmjmzKKZIVTbm7jrg0d3BQw7PAYaPkyKOYELvjFwGLh+n4oxx
         41Stngi7Ehh43Te1pESrZmkrOebjnMPL2skig52Fpvt1lnGSE5ZwG0PUlpbSbcPBfPqH
         yAhA==
X-Gm-Message-State: ALKqPwcfWcApTAKF/IsCv7Kzwf/lZzAQV54h2WWreXlNZcqc6u3T+8cn
        OBazropu/Bn01OG5SoABxQ/ZijHZ7b2F26YyAcQ=
X-Google-Smtp-Source: AB8JxZrLdJ7WAhpBl6BjeSu1L/cmhsGnv2g6Z3HV/FPix2KHb5qIgjU3YcZ3RGGCYd0Ks1PL/AnkQ8f2UYWhr3rN+E4=
X-Received: by 2002:aca:1904:: with SMTP id l4-v6mr1862812oii.216.1527267571704;
 Fri, 25 May 2018 09:59:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Fri, 25 May 2018 09:59:01
 -0700 (PDT)
In-Reply-To: <20180525164351.GA192362@aiede.svl.corp.google.com>
References: <20180513175438.32152-1-pclouds@gmail.com> <20180525033942.GA234191@aiede.svl.corp.google.com>
 <20180525143042.GA10607@duynguyen.home> <20180525164351.GA192362@aiede.svl.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 25 May 2018 18:59:01 +0200
Message-ID: <CACsJy8Bit2QcVMTnKfSuUjXbxnjHMLLd5LjV36zbnQyc=7c8Wg@mail.gmail.com>
Subject: Re: [PATCH 1/2] diff: turn --ita-invisible-in-index on by default
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 25, 2018 at 6:43 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> I think it should be reverted from 'next' because of the unintended
> change to the behavior of "git diff HEAD".

Ah. That is indeed unintended. I still don't know how this change
affects that (but that's probably why it slipped through in the first
place). While there, perhaps you could add a test in t2203 just to
make sure I will not break it again in the next attempt?

I agree that it should be reverted. Or if it's possible to eject it
from next, then it's even better since I will need to fix up the
second patch in that series anyway. Junio?

> Here is what I have applied internally.
>
> -- >8 --
> Subject: Revert "diff: turn --ita-invisible-in-index on by default"
>
> This reverts commit 992118dd95b052bc82a795fd3a8978bea0fe5c0e.  That
> change is promising, since it improves the behavior of "git diff" and
> "git diff --cached" by correctly showing an intent-to-add entry as no
> file.  Unfortunately, though, it breaks "git diff HEAD" in the
> process:
>
>         echo hi >new-file
>         git add -N new-file
>         git diff HEAD
>
> Before: shows addition of the new file
> After: shows no change
>
> Noticed because the new --ita-invisible-in-index default broke a
> script using "git diff --name-only --diff-filter=A master" to get a
> list of added files.  Arguably that script should use diff-index
> instead, which would have sidestepped the issue, but the new behavior
> is unexpected in interactive use as well.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  builtin/diff.c          |  7 -------
>  t/t2203-add-intent.sh   | 40 ++++++++--------------------------------
>  t/t4011-diff-symlink.sh | 10 ++++------
>  3 files changed, 12 insertions(+), 45 deletions(-)
>
> diff --git a/builtin/diff.c b/builtin/diff.c
> index b709b6e984..bfefff3a84 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -352,13 +352,6 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>         rev.diffopt.flags.allow_external = 1;
>         rev.diffopt.flags.allow_textconv = 1;
>
> -       /*
> -        * Default to intent-to-add entries invisible in the
> -        * index. This makes them show up as new files in diff-files
> -        * and not at all in diff-cached.
> -        */
> -       rev.diffopt.ita_invisible_in_index = 1;
> -
>         if (nongit)
>                 die(_("Not a git repository"));
>         argc = setup_revisions(argc, argv, &rev, NULL);
> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
> index 1d640a33f0..d9fb151d52 100755
> --- a/t/t2203-add-intent.sh
> +++ b/t/t2203-add-intent.sh
> @@ -69,9 +69,9 @@ test_expect_success 'i-t-a entry is simply ignored' '
>         git add -N nitfol &&
>         git commit -m second &&
>         test $(git ls-tree HEAD -- nitfol | wc -l) = 0 &&
> -       test $(git diff --name-only --ita-visible-in-index HEAD -- nitfol | wc -l) = 1 &&
> -       test $(git diff --name-only HEAD -- nitfol | wc -l) = 0 &&
> -       test $(git diff --name-only -- nitfol | wc -l) = 1
> +       test $(git diff --name-only HEAD -- nitfol | wc -l) = 1 &&
> +       test $(git diff --name-only --ita-invisible-in-index HEAD -- nitfol | wc -l) = 0 &&
> +       test $(git diff --name-only --ita-invisible-in-index -- nitfol | wc -l) = 1
>  '
>
>  test_expect_success 'can commit with an unrelated i-t-a entry in index' '
> @@ -99,13 +99,13 @@ test_expect_success 'cache-tree invalidates i-t-a paths' '
>
>         : >dir/bar &&
>         git add -N dir/bar &&
> -       git diff --name-only >actual &&
> +       git diff --cached --name-only >actual &&
>         echo dir/bar >expect &&
>         test_cmp expect actual &&
>
>         git write-tree >/dev/null &&
>
> -       git diff --name-only >actual &&
> +       git diff --cached --name-only >actual &&
>         echo dir/bar >expect &&
>         test_cmp expect actual
>  '
> @@ -186,19 +186,7 @@ test_expect_success 'rename detection finds the right names' '
>                 cat >expected.3 <<-EOF &&
>                 2 .R N... 100644 100644 100644 $hash $hash R100 third   first
>                 EOF
> -               test_cmp expected.3 actual.3 &&
> -
> -               git diff --stat >actual.4 &&
> -               cat >expected.4 <<-EOF &&
> -                first => third | 0
> -                1 file changed, 0 insertions(+), 0 deletions(-)
> -               EOF
> -               test_cmp expected.4 actual.4 &&
> -
> -               git diff --cached --stat >actual.5 &&
> -               : >expected.5 &&
> -               test_cmp expected.5 actual.5
> -
> +               test_cmp expected.3 actual.3
>         )
>  '
>
> @@ -234,27 +222,15 @@ test_expect_success 'double rename detection in status' '
>         )
>  '
>
> -test_expect_success 'diff-files/diff-cached shows ita as new/not-new files' '
> -       git reset --hard &&
> -       echo new >new-ita &&
> -       git add -N new-ita &&
> -       git diff --summary >actual &&
> -       echo " create mode 100644 new-ita" >expected &&
> -       test_cmp expected actual &&
> -       git diff --cached --summary >actual2 &&
> -       : >expected2 &&
> -       test_cmp expected2 actual2
> -'
> -
>  test_expect_success 'apply --intent-to-add' '
>         git reset --hard &&
>         echo new >new-ita &&
>         git add -N new-ita &&
> -       git diff >expected &&
> +       git diff --ita-invisible-in-index >expected &&
>         grep "new file" expected &&
>         git reset --hard &&
>         git apply --intent-to-add expected &&
> -       git diff >actual &&
> +       git diff --ita-invisible-in-index >actual &&
>         test_cmp expected actual
>  '
>
> diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
> index 108c012a3a..cf0f3a1ee7 100755
> --- a/t/t4011-diff-symlink.sh
> +++ b/t/t4011-diff-symlink.sh
> @@ -139,13 +139,11 @@ test_expect_success SYMLINKS 'setup symlinks with attributes' '
>  test_expect_success SYMLINKS 'symlinks do not respect userdiff config by path' '
>         cat >expect <<-\EOF &&
>         diff --git a/file.bin b/file.bin
> -       new file mode 100644
> -       index 0000000..d95f3ad
> -       Binary files /dev/null and b/file.bin differ
> +       index e69de29..d95f3ad 100644
> +       Binary files a/file.bin and b/file.bin differ
>         diff --git a/link.bin b/link.bin
> -       new file mode 120000
> -       index 0000000..dce41ec
> -       --- /dev/null
> +       index e69de29..dce41ec 120000
> +       --- a/link.bin
>         +++ b/link.bin
>         @@ -0,0 +1 @@
>         +file.bin
> --
> 2.17.0.921.gf22659ad46
-- 
Duy
