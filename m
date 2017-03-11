Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 518DD201C2
	for <e@80x24.org>; Sat, 11 Mar 2017 12:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755522AbdCKMPM (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Mar 2017 07:15:12 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:34429 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753959AbdCKMPK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2017 07:15:10 -0500
Received: by mail-io0-f173.google.com with SMTP id g6so62604931ioj.1
        for <git@vger.kernel.org>; Sat, 11 Mar 2017 04:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F3jdfvTrISml3orl7XIQRfITrZgh1bzZo1YEp75wvB0=;
        b=P5iqlMlkmzsKc4jtap/FfudHs9N0DQ9/TiRs/eoGLgacYl1Cz4b+RtBQOXeupbOlpC
         dL7KWW1kD1AVho3nzCnAs/jchHzkc3TFy3Jev5OASQ1eRGssskdgz1OHmJ1lE+rhfyXC
         G75qj0bt+VwRs7Ch1rkm41T+EGGI3Qqx9q6dOJeWOmZnhf4qoTF5wmstVcbLkH1vK4Pg
         eaX8QlXSpkwF/UaGGqppZFck2OMZWtf/8SlyMPBkftpKxf+AzPMcK0ThA5G31K170eP/
         mXkAXw08+lWS9VbBoOeM8GjkXA7dI3QiCSolMLNlRyon15iX38KxutIhQ5a40TgJoZtd
         zQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F3jdfvTrISml3orl7XIQRfITrZgh1bzZo1YEp75wvB0=;
        b=h7227vxdVKHUbsmM9xMl8Zif+4/1tjh7TKu2Nymx+40AzeffQc/k7xgfIi1R6nFnKE
         Hwi6XCvi7oynMaSscQPrg/5Jfm2ufwhDoM1wUL+gvuouRT3PSrtdD21pYyMUPgAKWiqF
         79cclIS0oIiugEdZtVksdK9iRliGKhPO5bNkfulkOBN/UVf3hpthE6Q/GJ9qZZexJJqe
         erxRtKt0d+fuiS20VqdHCyHUVA6+uTyBisZqX4nEoH0wmdN7U5YTq6XQk2TSz4nwwbCa
         DtOX3MKDahk4IGyd7Q9KNpkYPapIGbc6w7Wbsi3BmrQRUZwzREYQ0G7ycUB6B3zpi7Yo
         DPKw==
X-Gm-Message-State: AMke39nGrHQ58rJgy1DB8neoyKUtiXb1lYBWDv4LVLsCvbb2PGhSRI8RwQzaJZGYRHme8p8T9jTA/RlT8OE03A==
X-Received: by 10.107.200.139 with SMTP id y133mr22332520iof.147.1489234509210;
 Sat, 11 Mar 2017 04:15:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 11 Mar 2017 04:14:48 -0800 (PST)
In-Reply-To: <20170311120855.16756-1-avarab@gmail.com>
References: <20170310124247.jvrmmcz2pbv4qf3o@sigill.intra.peff.net> <20170311120855.16756-1-avarab@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 11 Mar 2017 13:14:48 +0100
Message-ID: <CACBZZX4AJqvtZQdZZFU8+1So5G9F11_SN4=za+8p=KYim9SFSQ@mail.gmail.com>
Subject: Re: [PATCH] tag: Implicitly supply --list given another list-like option
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jake Goulding <goulding@vivisimo.com>,
        Jeff King <peff@peff.net>, Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 11, 2017 at 1:08 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Change these invocations which currently error out without the -l, to
> behave as if though -l was provided:
>
>     git tag -l [--contains|--points-at|--[no-]merged] <commit>

Oops, this should be:

    git tag -l [--contains|--points-at|--[no-]merged] <commit> <pattern>

Will fix in v2 pending other comments.

> I ran into what turned out to be not-a-bug in "branch" where it,
> unlike "tag" before this patch, accepts input like:
>
>     git branch --contains v2.8.0 <pattern>
>
> Jeff King pointed out in
> <20170310124247.jvrmmcz2pbv4qf3o@sigill.intra.peff.net> in reply to
> that::
>
>     The difference between "branch" and "tag" here is that "branch
>     --contains" implies "--list" (and the argument becomes a pattern).
>     Whereas "tag --contains" just detects the situation and complains.
>
>     If anything, I'd think we would consider teaching "tag" to behave
>     more like "branch".
>
> I agree. This change does that, the only tests that broke as a result
> of this were tests that were explicitly checking that this
> "branch-like" usage wasn't permitted, i.e. no actual breakages
> occurred, and I can't imagine an invocation that would negatively
> impact backwards compatibility, i.e. these invocations all just
> errored out before.
>
> Spelunking through the history via:
>
>     git log --reverse -p -G'only allowed with' -- '*builtin*tag*c'
>
> Reveals that there was no good reason for this in the first place. The
> --contains option added in v1.6.1.1-243-g32c35cfb1e made this an
> error, and all the other subsequent options I'm changing here just
> copy/pasted its pattern.
>
> I've changed the failing tests to check that this invocation mode is
> permitted instead, and added extra tests for the list-like options we
> weren't testing.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>
> Junio: This will merge conflict with my in-flight --no-contains
> patch. I can re-send either one depending on which you want to accept
> first, this patch will need an additional test for --no-contains. I
> just wanted to get this on the ML for review before the --no-contains
> patch hit "master".
>
>  Documentation/git-tag.txt |  3 +++
>  builtin/tag.c             | 12 ++++++------
>  t/t7004-tag.sh            | 25 +++++++++++++++++++++----
>  3 files changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 525737a5d8..c80d9e11ba 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -94,6 +94,9 @@ OPTIONS
>         lists all tags. The pattern is a shell wildcard (i.e., matched
>         using fnmatch(3)).  Multiple patterns may be given; if any of
>         them matches, the tag is shown.
> ++
> +We supply this option implicitly if any other list-like option is
> +provided. E.g. `--contains`, `--points-at` etc.

The "this option" I'm referring to is --list, this is a patch to the
--list section in "git help tag".

>
>  --sort=3D<key>::
>         Sort based on the key given.  Prefix `-` to sort in
> diff --git a/builtin/tag.c b/builtin/tag.c
> index ad29be6923..6ab65bcf6b 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -454,6 +454,12 @@ int cmd_tag(int argc, const char **argv, const char =
*prefix)
>         }
>         create_tag_object =3D (opt.sign || annotate || msg.given || msgfi=
le);
>
> +       /* We implicitly supply --list with --contains, --points-at,
> +          --merged and --no-merged, just like git-branch */
> +       if (filter.with_commit || filter.points_at.nr || filter.merge_com=
mit)
> +               cmdmode =3D 'l';
> +
> +       /* Just plain "git tag" is like "git tag --list" */
>         if (argc =3D=3D 0 && !cmdmode)
>                 cmdmode =3D 'l';
>
> @@ -486,12 +492,6 @@ int cmd_tag(int argc, const char **argv, const char =
*prefix)
>         }
>         if (filter.lines !=3D -1)
>                 die(_("-n option is only allowed with -l."));
> -       if (filter.with_commit)
> -               die(_("--contains option is only allowed with -l."));
> -       if (filter.points_at.nr)
> -               die(_("--points-at option is only allowed with -l."));
> -       if (filter.merge_commit)
> -               die(_("--merged and --no-merged option are only allowed w=
ith -l"));
>         if (cmdmode =3D=3D 'd')
>                 return for_each_tag_name(argv, delete_tag, NULL);
>         if (cmdmode =3D=3D 'v') {
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index b4698ab5f5..e0306ee5a8 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1453,6 +1453,11 @@ test_expect_success 'checking that initial commit =
is in all tags' "
>         test_cmp expected actual
>  "
>
> +test_expect_success 'checking that --contains can be used in non-list mo=
de' '
> +       git tag --contains $hash1 v* >actual &&
> +       test_cmp expected actual
> +'
> +
>  # mixing modes and options:
>
>  test_expect_success 'mixing incompatibles modes and options is forbidden=
' '
> @@ -1466,8 +1471,10 @@ test_expect_success 'mixing incompatibles modes an=
d options is forbidden' '
>
>  # check points-at
>
> -test_expect_success '--points-at cannot be used in non-list mode' '
> -       test_must_fail git tag --points-at=3Dv4.0 foo
> +test_expect_success '--points-at can be used in non-list mode' '
> +       echo v4.0 >expect &&
> +       git tag --points-at=3Dv4.0 "v*" >actual &&
> +       test_cmp expect actual
>  '
>
>  test_expect_success '--points-at finds lightweight tags' '
> @@ -1744,8 +1751,13 @@ test_expect_success 'setup --merged test tags' '
>         git tag mergetest-3 HEAD
>  '
>
> -test_expect_success '--merged cannot be used in non-list mode' '
> -       test_must_fail git tag --merged=3Dmergetest-2 foo
> +test_expect_success '--merged can be used in non-list mode' '
> +       cat >expect <<-\EOF &&
> +       mergetest-1
> +       mergetest-2
> +       EOF
> +       git tag --merged=3Dmergetest-2 "mergetest*" >actual &&
> +       test_cmp expect actual
>  '
>
>  test_expect_success '--merged shows merged tags' '
> @@ -1765,6 +1777,11 @@ test_expect_success '--no-merged show unmerged tag=
s' '
>         test_cmp expect actual
>  '
>
> +test_expect_success '--no-merged can be used in non-list mode' '
> +       git tag --no-merged=3Dmergetest-2 mergetest-* >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_expect_success 'ambiguous branch/tags not marked' '
>         git tag ambiguous &&
>         git branch ambiguous &&
> --
> 2.11.0
>
