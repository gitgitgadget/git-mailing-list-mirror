Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D6C020A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 01:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbeLKBfm (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 20:35:42 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46026 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbeLKBfm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 20:35:42 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so11128598edb.12
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 17:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3aIMKVBu/SoGAWf0H+KZv4meQvGU8xKMYOwBMSm3qhQ=;
        b=QpMJOACEfbak4ibKLrBUj9eZHZVmxupjKht409rLpMC6L93+yQh6dWF3rp2B4YjlnO
         e7CyCRONMzBCrqE5Xa0wWGlr/EAV41hau84b3ZlOWC4XMUewwKg+dbBTlarIpZa37ApM
         24FCWxhU4LAl3EacfDgGpn8k9veJ/8J2iWFmD41gv3yfWaw4wj+Uhe1SM1orGzhF5ub/
         VdvTHxZHPyFSuJwCF1pBuk7ILcwCnKXxlD8jDvvnmtfI4iIXL9udS3c6uEgtM3Ffi5Gh
         teIrJ2qURZEhI7Usk7HyEOlshWIw0K0p9lkObLsnEYGemGTjSBRIxuvEpZVcMcgqBw3r
         SzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3aIMKVBu/SoGAWf0H+KZv4meQvGU8xKMYOwBMSm3qhQ=;
        b=UHfrsstjgANSrgQU3SGMgEs/FfzDGiTImqlPvIaUoXLpJdCwVYQC9fCrfAGzh6D/4u
         E2vtWfoqeQ4akBQ3pYfTQuSGX3liClB6H+xjKjy2Km7ELrdGzq2GHelFsfsYeWFIhrUT
         Kb+NL2wvOxRpzEDgFKormwKDlv6HHHQ4u4uS/w3oOOhSE0ew54zUbUU81cTDdNBENtDa
         lajdB5VuBIc2AwD6dKp/BLC+CXEUiV1TZU76mKzAKHTViEPnzgfQWPXadLnoMomNJL+6
         399b92o09QdH6fgDHrsJ7pQEJYQ5GQhT1wmQHaoPA8Vl+/mbmo3L9H7GWz0Zw6OduWCP
         shqA==
X-Gm-Message-State: AA+aEWbPRXxRjtZhSleR/CDtEH3cmaGHZncus6W/qZNUMeFE1PHEaIsd
        b82oaewd5iiWcw7h9aztjVM1+fCCz4bzXifJdq8MBw==
X-Google-Smtp-Source: AFSGD/XE2suqZ+J6+EUloWV5iHxiSo1z1tr5CFeZNXtXeUzAO6zZXMnXsmXdMKkRhnP5QvHInFNjE3VRmBQ8S72DMw8=
X-Received: by 2002:a17:906:45d8:: with SMTP id z24-v6mr10943690ejq.19.1544492139491;
 Mon, 10 Dec 2018 17:35:39 -0800 (PST)
MIME-Version: 1.0
References: <pull.92.git.gitgitgadget@gmail.com> <1e34b48a2051089052c0b53b0059576b5ace45de.1544465177.git.gitgitgadget@gmail.com>
In-Reply-To: <1e34b48a2051089052c0b53b0059576b5ace45de.1544465177.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Dec 2018 17:35:28 -0800
Message-ID: <CAGZ79kYeHgCdzNNXUnp1NaokT=Vpj4mUVt1bZb5c+EkgO2z-4w@mail.gmail.com>
Subject: Re: [PATCH 1/5] multi-pack-index: prepare for 'expire' verb
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 10:06 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The multi-pack-index tracks objects in a collection of pack-files.
> Only one copy of each object is indexed, using the modified time
> of the pack-files to determine tie-breakers. It is possible to
> have a pack-file with no referenced objects because all objects
> have a duplicate in a newer pack-file.
>
> Introduce a new 'expire' verb to the multi-pack-index builtin.
> This verb will delete these unused pack-files and rewrite the
> multi-pack-index to no longer refer to those files. More details
> about the specifics will follow as the method is implemented.
>
> Add a test that verifies the 'expire' verb is correctly wired,
> but will still be valid when the verb is implemented. Specifically,
> create a set of packs that should all have referenced objects and
> should not be removed during an 'expire' operation.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-multi-pack-index.txt |  8 +++++
>  builtin/multi-pack-index.c             |  4 ++-
>  midx.c                                 |  5 +++
>  midx.h                                 |  1 +
>  t/t5319-multi-pack-index.sh            | 47 ++++++++++++++++++++++++++
>  5 files changed, 64 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
> index f7778a2c85..822d83c845 100644
> --- a/Documentation/git-multi-pack-index.txt
> +++ b/Documentation/git-multi-pack-index.txt
> @@ -31,6 +31,14 @@ verify::
>         When given as the verb, verify the contents of the MIDX file
>         at `<dir>/packs/multi-pack-index`.
>
> +expire::
> +       When given as the verb,

Can it be given in another way? Or rather "if the verb is expire",
then ...
(I just checked the current man page, and both write and verify use
this pattern as well. I find it strange as this first part of the sentence
conveys little information, but is repeated 3 times now (once for
each verb)).

Maybe we can restructure the man page to have it more like

    The following verbs are available:
    +write::
    +    create a new MIDX file, writing to <dir>/packs/multi-pack-index.
    +
    +verify::
    +    verify the contents ...

>               delete the pack-files that are tracked
> +       by the MIDX file at `<dir>/packs/multi-pack-index`

We're mentioning the location a lot. Could we keep a more detailed
note in --object-dir and not go into such detail in the verbs section?
(Then the paragraph here would be more concise. That makes it
easier to understand)

>              but have
> +       no objects referenced by the MIDX. All objects in these pack-
> +       files have another copy in a more-recently modified pack-file.

The second sentence reads like a reason on why the first is a good
thing to have, so maybe use some subordinating conjunction adverb
("because") to make tell the reader

> +       Rewrite the MIDX file afterward to remove all references to
> +       these pack-files.

Makes sense.


>
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 70926b5bc0..948effc1ee 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -348,4 +348,51 @@ test_expect_success 'verify incorrect 64-bit offset' '
>                 "incorrect object offset"
>  '
>
> +test_expect_success 'setup expire tests' '
> +       mkdir dup &&
> +       (
> +               cd dup &&
> +               git init &&
> +               for i in $(test_seq 1 20)
> +               do
> +                       test_commit $i
> +               done &&
> +               git branch A HEAD &&
> +               git branch B HEAD~8 &&
> +               git branch C HEAD~13 &&
> +               git branch D HEAD~16 &&
> +               git branch E HEAD~18 &&
> +               git pack-objects --revs .git/objects/pack/pack-E <<-EOF &&
> +               refs/heads/E
> +               EOF
> +               git pack-objects --revs .git/objects/pack/pack-D <<-EOF &&
> +               refs/heads/D
> +               ^refs/heads/E
> +               EOF
> +               git pack-objects --revs .git/objects/pack/pack-C <<-EOF &&
> +               refs/heads/C
> +               ^refs/heads/D
> +               EOF
> +               git pack-objects --revs .git/objects/pack/pack-B <<-EOF &&
> +               refs/heads/B
> +               ^refs/heads/C
> +               EOF
> +               git pack-objects --revs .git/objects/pack/pack-A <<-EOF &&
> +               refs/heads/A
> +               ^refs/heads/B
> +               EOF
> +               git multi-pack-index write
> +       )
> +'
> +
> +test_expect_success 'expire does not remove any packs' '

With the clever setup, this test is already correctly testing
what the docs claims it should do, despite having
no implementation. Nice.
Although the core issue is that the packs are disjunct sets
of objects, so maybe /s/any packs/required packs/ or such?
