Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE33B1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 19:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936265AbeFRTWk (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 15:22:40 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:35323 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936232AbeFRTWj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 15:22:39 -0400
Received: by mail-yb0-f196.google.com with SMTP id a16-v6so3547279ybm.2
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 12:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bVEFb0o0Cjiq93TjOKQye+HV0VSfJkyEyXbT3BgGLng=;
        b=rK7K0ACNjOw33RwM5WKEwy6Lvztbmpfc6zaiiCZGMRttSHwDuPR3uOQwGXk+YKb0/2
         oXV2jIZfaPmqrn4lAbDi7EGPUUaWGdeKKOPrTlDAQ2uwahyWaO9I7LiytPI+J+yBYli+
         Et86ATt/t79DjvKhGtomKnIrQ3UtHpv9WmYW24O2A7mwLxB+KzcjdZRPtVKOUjP9Wluy
         2YZOq7K4E4lW7A+G/SHalbN7VSr3QJ97uq433N4cr6dDCxMsypjcYkDlZLcdvKojrRBM
         F6NSPbkwXiy3Gs8G3Nv1hH3EwLu9Xwti2+m7aJUk63WbGU0QvL8FemEzJRvBbdeM9FoU
         rTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bVEFb0o0Cjiq93TjOKQye+HV0VSfJkyEyXbT3BgGLng=;
        b=YMWALMcXSqj2/5N72SwrNkaO6iz7QdwVMQpabAA/UYDGPh8tzLO87rMDqjoHmd2j+U
         UqmuYbyF2ZUiFfrXPA2mhKeKYin0iz0KnZV1spnPskK4ell0+s4a0xPW91/3VkdHd8ua
         I1WBpHdqGs3LdPmxeASBN1A4jxZ3HPctYmDgMLyRFmXTms+lisrW305Juf1irZudLXh0
         mKkKLwo2gkLGKSmrf+YdnKBi3U3JZGOtISIrJfWp8jjKZgOAsOcckpDF2mtV68ZAYAsL
         eRQO6aJoeyDpUBbz2C6fdIyKqxmWSYLv2tENG6W8P5UpMxMu3ZHWt86+I7DFh+HOntmF
         1zBg==
X-Gm-Message-State: APt69E14e7uS8FlzUNdB8kT33h9tB6pv2YEyAHr73tbovURDXHytuIrA
        TM/naWvpZAW+vFbpDu+ru4Js8LRG8xfD/zgKF0eGvQ==
X-Google-Smtp-Source: ADUXVKIVHjbV+0yjAyEK9qmD39jszDhTG7nIO+Wpe+yRrHM97DLNFW420Hu5vEOFgdHB/qieLJTS2CmqGhJT8zA9kMU=
X-Received: by 2002:a25:dcc4:: with SMTP id y187-v6mr4293530ybe.515.1529349758496;
 Mon, 18 Jun 2018 12:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1528233146.git.jonathantanmy@google.com>
 <cover.1528234587.git.jonathantanmy@google.com> <c6910161aab1f383b5721bdc91969baad8c10a66.1528234587.git.jonathantanmy@google.com>
In-Reply-To: <c6910161aab1f383b5721bdc91969baad8c10a66.1528234587.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 18 Jun 2018 12:22:27 -0700
Message-ID: <CAGZ79kbB0Tv8wb_7j0=OdQqGU78KHp3JzuCeD01JTF4EHwOH0w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fetch: send "refs/tags/" prefix upon CLI refspecs
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 5, 2018 at 2:41 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> When performing tag following, in addition to using the server's
> "include-tag" capability to send tag objects (and emulating it if the
> server does not support that capability), "git fetch" relies upon the
> presence of refs/tags/* entries in the initial ref advertisement to
> locally create refs pointing to the aforementioned tag objects. When
> using protocol v2, refs/tags/* entries in the initial ref advertisement
> may be suppressed by a ref-prefix argument, leading to the tag object
> being downloaded, but the ref not being created.
>
> Commit dcc73cf7ff ("fetch: generate ref-prefixes when using a configured
> refspec", 2018-05-18) ensured that "refs/tags/" is always sent as a ref
> prefix when "git fetch" is invoked with no refspecs, but not when "git
> fetch" is invoked with refspecs. Extend that functionality to make it
> work in both situations.

okay. Thinking long term, we may want to introduce a capability that
can filter the tag space, e.g. "want-refs-since <date> refs/tags/*"
as a client directive as then the client only asks for new (newly
created/appearing) tags instead of all tags.

> This also necessitates a change another test which tested ref
> advertisement filtering using tag refs -

sounds plausible.

>  since tag refs are sent by
> default now, the test has been switched to using branch refs instead.

That mismatches what I would expect to read below.
I would expect the client to always ask for refs/tags/* now and
instead of the server just giving them.

Oh, the problem is in that other test to restrict the refs/tags
to *not* be sent?

Maybe we can only ask for refs/tags/* if we do not have any
"refs/tags/" on the CLI: if I invoke "git fetch refs/tags/v1"
I would not get an advertisement for refs/tags/v2 but if I omit
all tags from  the refspec, I'd get all its advertisements (v1+v2)



> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/fetch.c        |  2 +-
>  t/t5702-protocol-v2.sh | 24 +++++++++++++++++++++---
>  2 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index ea5b9669a..1f447f1e8 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -359,7 +359,7 @@ static struct ref *get_ref_map(struct transport *transport,
>                 refspec_ref_prefixes(&transport->remote->fetch, &ref_prefixes);
>
>         if (ref_prefixes.argc &&
> -           (tags == TAGS_SET || (tags == TAGS_DEFAULT && !rs->nr))) {
> +           (tags == TAGS_SET || tags == TAGS_DEFAULT)) {

Oh, I see. This always asks for refs/tags/ whereas before we only
asked for them if there were *no* refspec given. Maybe we can
change this to

    refspec_any_item_contains("refs/tags/")

instead of always asking for the tags?
(that function would need to be written; I guess for a short term bugfix
this is good enough)

How is the tag following documented (i.e. when is the user least
surprised that we do not tag-follow all and unconditionally)?


>                 argv_array_push(&ref_prefixes, "refs/tags/");
>         }
>
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 261e82b0f..b31b6d8d3 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -204,6 +204,7 @@ test_expect_success 'ref advertisment is filtered during fetch using protocol v2
>         test_when_finished "rm -f log" &&
>
>         test_commit -C file_parent three &&
> +       git -C file_parent branch unwanted-branch three &&
>
>         GIT_TRACE_PACKET="$(pwd)/log" git -C file_child -c protocol.version=2 \
>                 fetch origin master &&
> @@ -212,9 +213,8 @@ test_expect_success 'ref advertisment is filtered during fetch using protocol v2
>         git -C file_parent log -1 --format=%s >expect &&
>         test_cmp expect actual &&
>
> -       ! grep "refs/tags/one" log &&
> -       ! grep "refs/tags/two" log &&
> -       ! grep "refs/tags/three" log
> +       grep "refs/heads/master" log &&
> +       ! grep "refs/heads/unwanted-branch" log
>  '

That makes sense so far.

>
>  test_expect_success 'server-options are sent when fetching' '
> @@ -406,6 +406,24 @@ test_expect_success 'fetch supports various ways of have lines' '
>                 $(git -C server rev-parse completely-unrelated)
>  '
>
> +test_expect_success 'fetch supports include-tag and tag following' '
> +       rm -rf server client trace &&

test_when_finished ;)

> +       git init server &&
> +
> +       test_commit -C server to_fetch &&
> +       git -C server tag -a annotated_tag -m message &&
> +
> +       git init client &&
> +       GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
> +               fetch "$(pwd)/server" to_fetch:to_fetch &&
> +
> +       grep "fetch> ref-prefix to_fetch" trace &&
> +       grep "fetch> ref-prefix refs/tags/" trace &&
> +       grep "fetch> include-tag" trace &&
> +
> +       git -C client cat-file -e $(git -C client rev-parse annotated_tag)
> +'

Makes sense.

Thanks,
Stefan
