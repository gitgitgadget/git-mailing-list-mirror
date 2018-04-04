Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C05BB1F404
	for <e@80x24.org>; Wed,  4 Apr 2018 17:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751179AbeDDRTY (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 13:19:24 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35633 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeDDRTX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 13:19:23 -0400
Received: by mail-oi0-f46.google.com with SMTP id z8-v6so19965340oix.2
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 10:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2UftOkMbien6OlXRwd21mBbh5aClVLy5Itu7OBur614=;
        b=TZ48nI5Eliq3vLwikT8oO7e4BkW/6BMoomvB9xuh8qxXe5ym6SGsMP3vPHnew5tYJN
         clZlyeKpnBLpIV4WNQRN3LgwuYfspJEEbMyLNP3nwlV6EqEu9URfNOcUVsGnFXjoamtY
         CZ8KY9ot4gN3mEaXSaE8zfS+S/w4WuH8ocSyZxWT0tisUcmYTQAPUu1syjli7aCfHMlW
         hFPJCeMew9P4ma18qsYGJOwHPA0c5T/wnQdcGzM/pGlhYSUM7iUWiKQQp5WvimmLwNzs
         e6equiWXLgKC/A7qgrA1Rs3NNdicBejFDecF+j4MSH7JxyWklJI7TL0cgfKNUxU3GBut
         FfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2UftOkMbien6OlXRwd21mBbh5aClVLy5Itu7OBur614=;
        b=KZomTbEMxb2jZ8rA3Oxmdxhk1BxE+5j1n/YvP7wZobjD8CZaO/w43kXl7x5fQYKxIO
         oVk4ACqK5ukqRe+txTmeo6scRnZ0wYLFM3Caawstyb+EWbow7TDHVJLF5l68YXFVuI0r
         o06wqbo2V9iwhMeOMHl8suf2pTNMVU6P9cySTBjDkpQ402aUfIN89vzxK1elEZp4UKL7
         bx/oJ37HDeyEqyFdxbfOGbK2ho86xp5z4NaS8NmFNZTNCuvsFzMhoMLzq/3jArieqiN4
         JGasrwmwFqAZ/9usm7ZSBTohxWF72OYRnO2swpo81R4WG1tpp8cWHCUPmLj7wqAz0Anx
         0joA==
X-Gm-Message-State: ALQs6tAc+9nHpUU8A9AS7sIx84r1kGqfnOInKw26gjwWR6hAIYob+k6O
        Yzmp41friZivocZ3PKmQrPro17QW7btaMZIGr8mnI2Y6
X-Google-Smtp-Source: AIpwx4/LgRUilkeZvU1Y2Z+FYXpR48Wut3hhM1J+pKSvar90KaMoGNHACEZ+APdYlngeGixLkzRwq5KmQ4KfFPD7jx8=
X-Received: by 2002:aca:f13:: with SMTP id 19-v6mr10950507oip.298.1522862362928;
 Wed, 04 Apr 2018 10:19:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.68.194 with HTTP; Wed, 4 Apr 2018 10:18:42 -0700 (PDT)
In-Reply-To: <20180404171153.4126-1-haraldnordgren@gmail.com>
References: <20180402005248.52418-1-haraldnordgren@gmail.com> <20180404171153.4126-1-haraldnordgren@gmail.com>
From:   Harald Nordgren <haraldnordgren@gmail.com>
Date:   Wed, 4 Apr 2018 19:18:42 +0200
Message-ID: <CAHwyqnXtc-WgynCmE+EEVYtg6RRVweK8vwfBQS5VL4ygaFumKQ@mail.gmail.com>
Subject: Re: [PATCH v7] ls-remote: create '--sort' option
To:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I updated the code to use 'ALLOC_GROW'. I makes sense, I now I realize
why array.alloc is there ;)

Jeff, you are right that 'git ls-remote --sort=committerdate' will not
work. Do you think we need to do something about this, or it's fine
that it fails the way you showed?

On Wed, Apr 4, 2018 at 7:11 PM, Harald Nordgren
<haraldnordgren@gmail.com> wrote:
> Create a '--sort' option for ls-remote, based on the one from
> for-each-ref. This e.g. allows ref names to be sorted by version
> semantics, so that v1.2 is sorted before v1.10.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>
> Notes:
>     Started using 'ALLOC_GROW'
>
>  Documentation/git-ls-remote.txt | 12 +++++++++++-
>  builtin/ls-remote.c             | 27 +++++++++++++++++++++++++--
>  t/t5512-ls-remote.sh            | 41 ++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 76 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> index 5f2628c8f..17fae7218 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git ls-remote' [--heads] [--tags] [--refs] [--upload-pack=<exec>]
> -             [-q | --quiet] [--exit-code] [--get-url]
> +             [-q | --quiet] [--exit-code] [--get-url] [--sort=<key>]
>               [--symref] [<repository> [<refs>...]]
>
>  DESCRIPTION
> @@ -60,6 +60,16 @@ OPTIONS
>         upload-pack only shows the symref HEAD, so it will be the only
>         one shown by ls-remote.
>
> +--sort=<key>::
> +       Sort based on the key given.  Prefix `-` to sort in
> +       descending order of the value. You may use the --sort=<key> option
> +       multiple times, in which case the last key becomes the primary
> +       key. Also supports "version:refname" or "v:refname" (tag
> +       names are treated as versions). The "version:refname" sort
> +       order can also be affected by the "versionsort.suffix"
> +       configuration variable.
> +       The keys supported are the same as those in `git for-each-ref`.
> +
>  <repository>::
>         The "remote" repository to query.  This parameter can be
>         either a URL or the name of a remote (see the GIT URLS and
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index 540d56429..5bb8ee68a 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -1,6 +1,7 @@
>  #include "builtin.h"
>  #include "cache.h"
>  #include "transport.h"
> +#include "ref-filter.h"
>  #include "remote.h"
>
>  static const char * const ls_remote_usage[] = {
> @@ -43,10 +44,13 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>         int show_symref_target = 0;
>         const char *uploadpack = NULL;
>         const char **pattern = NULL;
> +       int i;
>
>         struct remote *remote;
>         struct transport *transport;
>         const struct ref *ref;
> +       struct ref_array array;
> +       static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
>
>         struct option options[] = {
>                 OPT__QUIET(&quiet, N_("do not print remote URL")),
> @@ -60,6 +64,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>                 OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
>                 OPT_BOOL(0, "get-url", &get_url,
>                          N_("take url.<base>.insteadOf into account")),
> +               OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
> +                            N_("field name to sort on"), &parse_opt_ref_sorting),
>                 OPT_SET_INT_F(0, "exit-code", &status,
>                               N_("exit with exit code 2 if no matching refs are found"),
>                               2, PARSE_OPT_NOCOMPLETE),
> @@ -68,6 +74,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>                 OPT_END()
>         };
>
> +       memset(&array, 0, sizeof(array));
> +
>         argc = parse_options(argc, argv, prefix, options, ls_remote_usage,
>                              PARSE_OPT_STOP_AT_NON_OPTION);
>         dest = argv[0];
> @@ -104,13 +112,28 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>         if (!dest && !quiet)
>                 fprintf(stderr, "From %s\n", *remote->url);
>         for ( ; ref; ref = ref->next) {
> +               struct ref_array_item *item;
>                 if (!check_ref_type(ref, flags))
>                         continue;
>                 if (!tail_match(pattern, ref->name))
>                         continue;
> +
> +               FLEX_ALLOC_MEM(item, refname, ref->name, strlen(ref->name));
> +               item->symref = ref->symref;
> +               item->objectname = ref->old_oid;
> +
> +               ALLOC_GROW(array.items, array.nr + 1, array.alloc);
> +               array.items[array.nr++] = item;
> +       }
> +
> +       if (sorting)
> +               ref_array_sort(sorting, &array);
> +
> +       for (i = 0; i < array.nr; i++) {
> +               const struct ref_array_item *ref = array.items[i];
>                 if (show_symref_target && ref->symref)
> -                       printf("ref: %s\t%s\n", ref->symref, ref->name);
> -               printf("%s\t%s\n", oid_to_hex(&ref->old_oid), ref->name);
> +                       printf("ref: %s\t%s\n", ref->symref, ref->refname);
> +               printf("%s\t%s\n", oid_to_hex(&ref->objectname), ref->refname);
>                 status = 0; /* we found something */
>         }
>         return status;
> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
> index 02106c922..66370cd88 100755
> --- a/t/t5512-ls-remote.sh
> +++ b/t/t5512-ls-remote.sh
> @@ -10,6 +10,9 @@ test_expect_success setup '
>         test_tick &&
>         git commit -m initial &&
>         git tag mark &&
> +       git tag mark1.1 &&
> +       git tag mark1.2 &&
> +       git tag mark1.10 &&
>         git show-ref --tags -d | sed -e "s/ /   /" >expected.tag &&
>         (
>                 echo "$(git rev-parse HEAD)     HEAD"
> @@ -39,6 +42,39 @@ test_expect_success 'ls-remote self' '
>         test_cmp expected.all actual
>  '
>
> +test_expect_success 'ls-remote --sort="version:refname" --tags self' '
> +       cat >expect <<-\EOF &&
> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark
> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.1
> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.2
> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.10
> +       EOF
> +       git ls-remote --sort="version:refname" --tags self >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'ls-remote --sort="-version:refname" --tags self' '
> +       cat >expect <<-\EOF &&
> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.10
> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.2
> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.1
> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark
> +       EOF
> +       git ls-remote --sort="-version:refname" --tags self >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'ls-remote --sort="-refname" --tags self' '
> +       cat >expect <<-\EOF &&
> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.2
> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.10
> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.1
> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark
> +       EOF
> +       git ls-remote --sort="-refname" --tags self >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_expect_success 'dies when no remote specified and no default remotes found' '
>         test_must_fail git ls-remote
>  '
> @@ -131,7 +167,7 @@ test_expect_success 'Report no-match with --exit-code' '
>
>  test_expect_success 'Report match with --exit-code' '
>         git ls-remote --exit-code other.git "refs/tags/*" >actual &&
> -       git ls-remote . tags/mark >expect &&
> +       git ls-remote . tags/mark* >expect &&
>         test_cmp expect actual
>  '
>
> @@ -178,6 +214,9 @@ test_expect_success 'ls-remote --symref' '
>         1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/remotes/origin/HEAD
>         1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/remotes/origin/master
>         1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark
> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.1
> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.10
> +       1bd44cb9d13204b0fe1958db0082f5028a16eb3a        refs/tags/mark1.2
>         EOF
>         git ls-remote --symref >actual &&
>         test_cmp expect actual
> --
> 2.14.3 (Apple Git-98)
>
