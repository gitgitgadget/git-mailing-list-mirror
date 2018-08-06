Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FFCF208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 08:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeHFLG5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 07:06:57 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43477 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbeHFLG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 07:06:57 -0400
Received: by mail-oi0-f66.google.com with SMTP id b15-v6so20815716oib.10
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 01:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WPD0B1m4eO74zyoIuC51UIRIehPAQL07rEIr8Rl7naI=;
        b=NMN11WqHLCqtR/zExBdtrQ6Q9ij3WUapSxLhSpQ8NpJGUhpt5LIFHUg8Soh9ypVQCU
         DmWt/A6lAZ9F4AGc5xLsXg/t5m0Va1MI7Etmbv+iEzT3HWUelBOSANx7vhctIUBCqh/g
         nZkA19/uUBxWHISQJRaa6oj/VYgeiWSFDYrPoKwb/7GZmWPwalz0ZMQueNDTZ1YQAQ4M
         fpBI18f/y7O67vx6FfGdHPkrCbhlQk4ntOdCE1RyYH1/leghurl+X064VF8jVORiA3Xy
         1c30dbvLuaV18YkyNVqEMz5dya6TjRCl88+hpyOB/bkCqOQHRapjEzu8iDQIjlm6efch
         //QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WPD0B1m4eO74zyoIuC51UIRIehPAQL07rEIr8Rl7naI=;
        b=WdINPt+mcAwLas89QdJH368DEW9LCUW4W7CrK5mDBVmKfZT+olYAnK0RTuxoOvmG3w
         QNtnfNF499ByMCyH8kcN0lzZxjBCPBuPAeMdJCVsBKydJ5rATsHg8E/ANuq9EsfXryzn
         MNWD+nOCKTFSyMt0Mtb94mYzJ3TOGtl0UxiYPqUJA8Zq/SrSQJNvQVkIchPcLYvV4lYs
         rfHyXfEj7eOgVutEX+zm8WBb8nzhIocArK9Xq0J/rV2SgnqLmDOQzx45jVSbpOv7ouhK
         RLKiBBp6Shpfbg8amufxeV1XZKRbzDGuQrfl62+rAZg4j42V3kku1SdjEn3BWLfhtLA+
         FRjQ==
X-Gm-Message-State: AOUpUlHunRRraFV+56CgEpbLwoWpvJEOQ30oPVW3eTrNSNJ0A3xdbL18
        Pe76WiB/26nNgoLPNaWXHfvwHaEcOsxtgDHBXdM=
X-Google-Smtp-Source: AAOMgpeTg8iVokdNDmTxBxNsZJiIyVoUFeuju7ooCivzXuA2aywkii31ZhjfOht6L12zAokC73Jom7sWM7jmrASou5M=
X-Received: by 2002:aca:ce0f:: with SMTP id e15-v6mr14368241oig.13.1533545933484;
 Mon, 06 Aug 2018 01:58:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:12f6:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 01:58:52 -0700 (PDT)
In-Reply-To: <bea0e5d0-d944-ddd8-c3ab-a95355352b47@gmail.com>
References: <f91c7393-4f1b-1cf5-b870-f42e9bd18d64@gmail.com>
 <8f69d82b-0f35-754f-0096-853d6b463db7@gmail.com> <bea0e5d0-d944-ddd8-c3ab-a95355352b47@gmail.com>
From:   Paul Tan <pyokagan@gmail.com>
Date:   Mon, 6 Aug 2018 16:58:52 +0800
Message-ID: <CACRoPnTWxYvGfqgGt2r5ETOhfJZnqr1fTO9Fzwp-u25XbMGPPQ@mail.gmail.com>
Subject: Re: [PATCH v2] t4150: fix broken test for am --scissors
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've taken a look at the original test, and it is pretty broken. My
deepest apologies for this mess.

On Sun, Aug 5, 2018 at 2:10 AM, Andrei Rybak <rybak.a.v@gmail.com> wrote:
> Tests for "git am --[no-]scissors" [1] work in the following way:
>
>  1. Create files with commit messages
>  2. Use these files to create expected commits
>  3. Generate eml file with patch from expected commits
>  4. Create commits using git am with these eml files
>  5. Compare these commits with expected
>
> The test for "git am --scissors" is supposed to take a message with a
> scissors line and demonstrate that the subject line from the e-mail
> itself is overridden by the in-body "Subject:" header and that only text
> below the scissors line is included in the commit message of the commit
> created by the invocation of "git am --scissors". However, the setup of
> the test incorrectly uses a commit without the scissors line and in-body
> "Subject:" header in the commit message, and thus, creates eml file not
> suitable for testing of "git am --scissors".

I think what really happened was that I simply forgot that the first
line of the commit message would be pulled out into the formatted
patch's "Subject" header, and would thus not be affected by the
scissors line :-S.

> This can be checked by intentionally breaking is_scissors_line function
> in mailinfo.c, for example, by changing string ">8", which is used by
> the test. With such change the test should fail, but does not.

The main reason why the test still passes even with a broken
is_scissors_line() would be because it uses the wrong patch to pass to
"git am --scissors" -- it uses the patch _without_ a scissors line
rather than the patch _with_ the scissors line.

However, after fixing this problem, which I'll call problem (1), the
test will actually fail, due to:

(2) The trees of the commits `scissors` and `no-scissors` not being
identical, thus making test_cmp_rev fail even though the commit
messages of the commits are identical.

(3) As mentioned above, the test not accounting for the first line of
the commit message being used as the "Subject" header and thus not
affected by the scissors line.

So, there are 3 problems that will need to be fixed.

>
> Fix broken test by generating eml file with scissors line and in-body
> header "Subject:". Since the two tests for --scissors and --no-scissors
> options are there to test cutting or keeping the commit message, update
> both tests to change the test file in the same way, which allows us to
> generate only one eml file to be passed to git am. To clarify the
> intention of the test, give files and tags more explicit names.
>
> [1]: introduced in bf72ac17d (t4150: tests for am --[no-]scissors,
>      2015-07-19)
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>  t/t4150-am.sh | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
>
> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index e9b6f8158..bb2d951a7 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -67,13 +67,15 @@ test_expect_success 'setup: messages' '
>
>         EOF
>
> -       cat >scissors-msg <<-\EOF &&
> -       Test git-am with scissors line
> +       cat >msg-without-scissors-line <<-\EOF &&
> +       Test that git-am --scissors cuts at the scissors line
>
>         This line should be included in the commit message.
>         EOF
>
> -       cat - scissors-msg >no-scissors-msg <<-\EOF &&
> +       printf "Subject: " >subject-prefix &&
> +
> +       cat - subject-prefix msg-without-scissors-line >msg-with-scissors-line <<-\EOF &&
>         This line should not be included in the commit message with --scissors enabled.
>
>          - - >8 - - remove everything above this line - - >8 - -

This fixes problem (3) by using an in-body header.

> @@ -150,18 +152,17 @@ test_expect_success setup '
>         } >patch1-hg.eml &&
>
>
> -       echo scissors-file >scissors-file &&
> -       git add scissors-file &&
> -       git commit -F scissors-msg &&
> -       git tag scissors &&
> -       git format-patch --stdout scissors^ >scissors-patch.eml &&
> +       echo file >file &&
> +       git add file &&

This fixes the first half of problem (2) by making the naming of the
files the same.

> +       git commit -F msg-without-scissors-line &&
> +       git tag scissors-used &&

Nit: I'm not quite sure about naming the tag "scissors-used" though,
since this commit was not created from the output of "git am
--scissors". Maybe it should be named `commit-without-scissors-line`
or something?

This hunk removes the line:

    git format-patch --stdout scissors^ >scissors-patch.eml &&

without a corresponding replacement, but that is fine because the test
should not be using a patch without a scissors line.

>         git reset --hard HEAD^ &&
>
> -       echo no-scissors-file >no-scissors-file &&
> -       git add no-scissors-file &&
> -       git commit -F no-scissors-msg &&
> -       git tag no-scissors &&
> -       git format-patch --stdout no-scissors^ >no-scissors-patch.eml &&
> +       echo file >file &&
> +       git add file &&

This fixes the other half of problem (2) by making the naming of the
files the same.

> +       git commit -F msg-with-scissors-line &&
> +       git tag scissors-not-used &&

Nit: Likewise, perhaps this tag could be named `commit-with-scissors-line`?

> +       git format-patch --stdout scissors-not-used^ >patch-with-scissors-line.eml &&
>         git reset --hard HEAD^ &&
>
>         sed -n -e "3,\$p" msg >file &&
> @@ -418,10 +419,10 @@ test_expect_success 'am --scissors cuts the message at the scissors line' '
>         rm -fr .git/rebase-apply &&
>         git reset --hard &&
>         git checkout second &&
> -       git am --scissors scissors-patch.eml &&
> +       git am --scissors patch-with-scissors-line.eml &&

This fixes problem (1) by using the correct patch, where the commit
message has a scissors line.

>         test_path_is_missing .git/rebase-apply &&
> -       git diff --exit-code scissors &&
> -       test_cmp_rev scissors HEAD
> +       git diff --exit-code scissors-used &&
> +       test_cmp_rev scissors-used HEAD
>  '
>
>  test_expect_success 'am --no-scissors overrides mailinfo.scissors' '
> @@ -429,10 +430,10 @@ test_expect_success 'am --no-scissors overrides mailinfo.scissors' '
>         git reset --hard &&
>         git checkout second &&
>         test_config mailinfo.scissors true &&
> -       git am --no-scissors no-scissors-patch.eml &&
> +       git am --no-scissors patch-with-scissors-line.eml &&
>         test_path_is_missing .git/rebase-apply &&
> -       git diff --exit-code no-scissors &&
> -       test_cmp_rev no-scissors HEAD
> +       git diff --exit-code scissors-not-used &&
> +       test_cmp_rev scissors-not-used HEAD
>  '
>
>  test_expect_success 'setup: new author and committer' '
> --
> 2.18.0
>

So, this patch fixes the 3 problems with the tests, and so looks correct to me.

Thanks,
Paul
