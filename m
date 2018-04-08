Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB741F404
	for <e@80x24.org>; Sun,  8 Apr 2018 01:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbeDHBsN (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 21:48:13 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:47020 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752006AbeDHBsM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 21:48:12 -0400
Received: by mail-qk0-f175.google.com with SMTP id p67so5499209qke.13
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 18:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XqqDtclcHtjb+ZrxuBBebtaL8qYamCby6pUI7VMe9PA=;
        b=i4z0ynuc+KIlP8lyT72gEeYSbI31+qPjmUNacZttxXzRA5mhUjblOvAlPbq51pw03N
         GkqM7YDcumB4CsFS6x9VuMPcA9x6260rAxncadgt+nvOvp8EhsoOv524dB2hQTYBv5L+
         EMJ8j4IYeL/CqlcLbRZjeNu5jGw8L/hINJmOoNtvM2rIV2Qs6vjhDIQ1N8Q5NNKrBI7e
         Oj4cEtx5nPptSFdCbLDF+T9sNMXdvDt8gVGw9FkX+/pBOA+cJMjdTFTp1zo5zUFVEsPN
         KRPPk6ugmnmHpn4jdgyhrXQB6T+TNEs5m1wb8GnYCWACMDz5PhokCC+49s43QujWD0lH
         ZHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=XqqDtclcHtjb+ZrxuBBebtaL8qYamCby6pUI7VMe9PA=;
        b=eCFqgQDMpwjvwi5qOGKqIGxFz08N4+PGgH5Xi/Co67e4SdIFngpzqm82I7eTQW0RWo
         r6HJ0gaiK1fnz9doAtkvA8q31+yV5O89vCTzW0pAtE8Eo52NSaAt2utmI9zyUK8fPIbG
         Xj/QCS3hndt4zPZEiroPyw62iZGuvUxR3WRxDOuF9nGUt1Logo+kf3p5K6SunrStNZVX
         l1aTWk4g54zKuBi8sxuMBPX8ZcS8X62IY8iurE+1PrXyzXKZYHtwbJDq3R9hH3/KgCUf
         mJFEf9ZXbu6rPm/Mo9WUW2rK/xlreATAD4AeSih2D1UTRxjjkZhDHT64i5YO6i/Y3Tbr
         BI3A==
X-Gm-Message-State: ALQs6tC7xdUt8c7DnsyrsTpr5hdQMBK/7h1eORnMUGA3oJB7cjhLf0cs
        U/cSYxBtdXnTUCJKLqtlhvRx83FQ5B/UFhHnDSM=
X-Google-Smtp-Source: AIpwx4/37NjI7adA7Azt8xyklDMNzm6G6RDkBQnkq//QU2Eg5rdn+0oyrebPRbuAhduh5gD2sOYVAn7S8WedLFaVUBU=
X-Received: by 10.55.198.217 with SMTP id s86mr42626320qkl.153.1523152091334;
 Sat, 07 Apr 2018 18:48:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sat, 7 Apr 2018 18:48:10 -0700 (PDT)
In-Reply-To: <20180407164250.54303-4-haraldnordgren@gmail.com>
References: <20180402005248.52418-1-haraldnordgren@gmail.com>
 <20180407164250.54303-1-haraldnordgren@gmail.com> <20180407164250.54303-4-haraldnordgren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 7 Apr 2018 21:48:10 -0400
X-Google-Sender-Auth: s4je8ITete6T93oSKcWWEopkbKk
Message-ID: <CAPig+cQnkvs8uPU-=woEzYC=mu1Bbi2u_TgH60aVUyh+m3DKDA@mail.gmail.com>
Subject: Re: [PATCH v11 4/4] ls-remote: create '--sort' option
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 7, 2018 at 12:42 PM, Harald Nordgren
<haraldnordgren@gmail.com> wrote:
> Create a '--sort' option for ls-remote, based on the one from
> for-each-ref. This e.g. allows ref names to be sorted by version
> semantics, so that v1.2 is sorted before v1.10.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> @@ -60,6 +60,19 @@ OPTIONS
> +--sort=<key>::
> +       Sort based on the key given.  Prefix `-` to sort in
> +       descending order of the value. You may use the --sort=<key> option
> +       multiple times, in which case the last key becomes the primary

This "last becomes primary key" feels counterintuitive to me, however,
I see it mirrors precedence of other Git commands.

In what situations would it make sense to specify --sort= multiple
times in the context of ls-remote? If there are none, then I wonder if
this should instead be documented as "last wins"...

> +       key. Also supports "version:refname" or "v:refname" (tag

To what does "Also" refer?

> +       names are treated as versions). The "version:refname" sort
> +       order can also be affected by the "versionsort.suffix"
> +       configuration variable.
> +       The keys supported are the same as those in `git for-each-ref`,
> +       except that because `ls-remote` deals only with remotes, keys like
> +       `committerdate` that require access to the objects themselves will
> +       not work.

What does "not work" mean in this context? Will the command crash
outright? Will it emit a suitable error message or warning? Will the
sorting be somehow dysfunctional?

It seems like the sentence "The keys supported..." should go above the
"Also supports..." sentence for this explanation to be more cohesive.

Finally, how about adding a linkgit:git-for-each-ref[1] to give the
user an easy way to access the referenced documentation. For instance:

    The keys supported are the same as those accepted by the
    `--sort=` option of linkgit:git-for-each-ref[1], except...

> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> @@ -43,10 +44,13 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
> +       struct ref_array array;
> +       static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
> @@ -68,6 +74,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
> +       memset(&array, 0, sizeof(array));

Can we have a more meaningful name than 'array'? Even a name a simple
as 'refs' would convey more information.

> @@ -104,13 +112,23 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>         for ( ; ref; ref = ref->next) {
> +               struct ref_array_item *item;
>                 if (!check_ref_type(ref, flags))
>                         continue;
>                 if (!tail_match(pattern, ref->name))
>                         continue;
> +               item = ref_array_push(&array, ref->name, &ref->old_oid);
> +               item->symref = xstrdup_or_null(ref->symref);

Do we need to worry about freeing memory allocated by these two lines?

More generally, do we care that 'array' and 'sorting' are being
leaked? If not, perhaps they should be annotated by UNLEAK.

> +       }
> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
> @@ -39,6 +42,39 @@ test_expect_success 'ls-remote self' '
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

This test script is already filled with these hardcoded SHA-1's, so
this is not a new problem, but work is under way to make it possible
to replace SHA-1 with some other hashing algorithm. Test scripts are
being retrofitted to avoid hard-coding them; instead determining the
hash value dynamically (for example, [1]). It would be nice if the new
tests followed suit, thus saving someone else extra work down the
road. (This, itself, is not worth a re-roll, but something to consider
if you do re-roll.)

[1]: https://public-inbox.org/git/20180325192055.841459-10-sandals@crustytoothpaste.net/

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

Do we want a test verifying that multiple sort keys are respected? (Is
it even possible to construct such a test?)

> @@ -131,7 +167,7 @@ test_expect_success 'Report no-match with --exit-code' '
>  test_expect_success 'Report match with --exit-code' '
>         git ls-remote --exit-code other.git "refs/tags/*" >actual &&
> -       git ls-remote . tags/mark >expect &&
> +       git ls-remote . tags/mark* >expect &&
>         test_cmp expect actual
>  '

Why this change?
