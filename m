Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ADB21F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 10:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390739AbeKVUz3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 15:55:29 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38721 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390716AbeKVUz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 15:55:29 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so7250470ede.5
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 02:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=J4kARfu4WDH7y4mJPgATOgRCyhI8rjGmaoqVhNan/1o=;
        b=Mum+Ks7p08txj3NmkWoesSX2A21iivbNhCyXwmuWOv0Vh3TQypinO7vUC6GcF/pIsk
         qZQ/qAGPU0eC7f4/Zn508yo6J7oX5bdAD4EPZ8vbUG4HMD/okX2xVTPkTjjxu7m+XzxM
         s/rlKX0vifdJp10jatczYD7zgPy/Qs6c3jzUOr8qFrKIM9efDOqBj6XYa6TYdPIt8+S+
         p9T51HeXKT5gpK+Rov7eFgEvYp7VTcF04ocj+g8o98XbEJJgf+W859pfQzrcIHosFBPv
         zOEuRXwu8Au2rjvN0eb/NbTapd9Lzq1tkFsIzH2TwmoPwsI1Yq9a+XKbgxD3fMHqrinY
         1nHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=J4kARfu4WDH7y4mJPgATOgRCyhI8rjGmaoqVhNan/1o=;
        b=J8YcTpdT4KQqCGXl3VcDEQGDzflLHjmBPYqhaC6DWW3Zex6pxdEU8N3jzIWIxFZEgV
         9jkV7escAM03pY8jMXCiBVVTIx5gLHQLn4514aGPSgCMVMy2uXsC50TiI2c7iocmhRcL
         lK2DPJX26YZCZ99b3CxkAF5U3mz1rdjOsCWstlCer2JoamPOTwHhMUhPbeEN/BAKKcDL
         UkWGi9gELQAZ8umGKBab25SzqUNJ+ahoLOfJKnHBfKKKE83j0GtiuebQqIquTzrWw/ef
         Kzf4OGTtVqeB4URarnBH2SXjbPpKkATTxp9DaGs4dbyyI9JKoPbu/3O+d54IwP06ZSsQ
         O+YA==
X-Gm-Message-State: AA+aEWYTFgwkH7ECBd+Po4jc3JhyYtI/n+p3cror9j2eJsjY5WBnM74k
        IA5hrZpciMEixfH8th8Zxos=
X-Google-Smtp-Source: AFSGD/XZEIdnc/uY3XdI8LonTbAPnOmSMeruB84QAzMhRoC8J0nqYVczaU6qPvbN27wB62gW8lWqjg==
X-Received: by 2002:a50:b881:: with SMTP id l1mr8804757ede.167.1542881800417;
        Thu, 22 Nov 2018 02:16:40 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id f6sm6843514ede.53.2018.11.22.02.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 02:16:39 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v1 1/2] log -G: Ignore binary files
References: <cover.1542831544.git.thomas.braun@virtuell-zuhause.de> <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
Date:   Thu, 22 Nov 2018 11:16:38 +0100
Message-ID: <87k1l5zabd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
On Wed, Nov 21 2018, Thomas Braun wrote:

> The -G <regex> option of log looks for the differences whose patch text
> contains added/removed lines that match regex.
>
> The concept of differences only makes sense for text files, therefore
> we need to ignore binary files when searching with -G <regex> as well.
>
> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> ---
>  Documentation/gitdiffcore.txt |  2 +-
>  diffcore-pickaxe.c            |  5 +++++
>  t/t4209-log-pickaxe.sh        | 22 ++++++++++++++++++++++
>  3 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
> index c0a60f3158..059ddd3431 100644
> --- a/Documentation/gitdiffcore.txt
> +++ b/Documentation/gitdiffcore.txt
> @@ -242,7 +242,7 @@ textual diff has an added or a deleted line that matches the given
>  regular expression.  This means that it will detect in-file (or what
>  rename-detection considers the same file) moves, which is noise.  The
>  implementation runs diff twice and greps, and this can be quite
> -expensive.
> +expensive.  Binary files without textconv filter are ignored.
>
>  When `-S` or `-G` are used without `--pickaxe-all`, only filepairs
>  that match their respective criterion are kept in the output.  When
> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index 69fc55ea1e..8c2558b07d 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -144,6 +144,11 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
>  		textconv_two = get_textconv(o->repo->index, p->two);
>  	}
>
> +	if ((o->pickaxe_opts & DIFF_PICKAXE_KIND_G) &&
> +	    ((!textconv_one && diff_filespec_is_binary(o->repo, p->one)) ||
> +	     (!textconv_two && diff_filespec_is_binary(o->repo, p->two))))
> +		return 0;
> +
>  	/*
>  	 * If we have an unmodified pair, we know that the count will be the
>  	 * same and don't even have to load the blobs. Unless textconv is in
> diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
> index 844df760f7..42cc8afd8b 100755
> --- a/t/t4209-log-pickaxe.sh
> +++ b/t/t4209-log-pickaxe.sh
> @@ -106,4 +106,26 @@ test_expect_success 'log -S --no-textconv (missing textconv tool)' '
>  	rm .gitattributes
>  '
>
> +test_expect_success 'log -G ignores binary files' '
> +	rm -rf .git &&
> +	git init &&
> +	printf "a\0b" >data.bin &&
> +	git add data.bin &&
> +	git commit -m "message" &&
> +	git log -G a >result &&

Would be less confusing as "-Ga" since that's the invocation we
document, even though I see (but wasn't aware that...) "-G a" works too.

> +	test_must_be_empty result
> +'
> +
> +test_expect_success 'log -G looks into binary files with textconv filter' '
> +	rm -rf .git &&
> +	git init &&
> +	echo "* diff=bin" > .gitattributes &&
> +	printf "a\0b" >data.bin &&
> +	git add data.bin &&
> +	git commit -m "message" &&
> +	git -c diff.bin.textconv=cat log -G a >actual &&
> +	git log >expected &&
> +	test_cmp actual expected
> +'
> +
>  test_done

This patch seems like the wrong direction to me. In particular the
assertion that "the concept of differences only makes sense for text
files". That's just not true. This patch breaks this:

    (
        rm -rf /tmp/g-test &&
        git init /tmp/g-test &&
        cd /tmp/g-test &&
        for i in {1..10}; do
            echo "Always matching thensome 5" >file &&
            printf "a thensome %d binary \0" $i >>file &&
            git add file &&
            git commit -m"Bump $i"
        done &&
        git log -Gthensome.*5
    )

Right now this will emit 3/10 patches, and the right ones! I.e. "Bump
[156]". The 1st one because it introduces the "Always matching thensome
5". Then 5/6 because the add/remove the string "a thensome 5 binary",
respectively. Which matches /thensome.*5/.

I.e. in the first one we do a regex match against the content here
because we don't have both sides:
https://github.com/git/git/blob/v2.19.2/diffcore-pickaxe.c#L48-L53

And then for the later ones where we have both sides we end up in
diffgrep_consume():
https://github.com/git/git/blob/v2.19.2/diffcore-pickaxe.c#L27-L36

I think there may be a real issue here to address, which might be some
combination of:

 a) Even though the diffcore can do a binary diff internally, this is
    not what it exposes with "-p", we just say "Binary files differ".

    I don't know how to emit the raw version we'll end up passing to
    diffgrep_consume() in this case. Is it just --binary without the
    encoding? I don't know...

 b) Your test case shows that you're matching a string at a \0
    boundary. Is this perhaps something you ran into? I.e. that we don't
    have some -F version of -G so we can't supply regexes that match
    past a \0? I had some related work on grep for this that hasn't been
    carried over to the diffcore:

        git log --grep='grep:.*\\0' --author=Ævar

 c) Is this binary diff we end up matching against just bad in some
    cases? I haven't dug but that wouldn't surprise me, i.e. that it's
    trying to be line-based so we'll overmatch in many cases.

So maybe this is something that should be passed down as a flag? See a
recent discussion at
https://public-inbox.org/git/87lg77cmr1.fsf@evledraar.gmail.com/ for how
that could be done.

Also if we don't have some tests already that were failing with this
patch we really should have those as "let's test the current behavior
first". Unfortunately tests in this area are really lacking, see
e.g. my:

    git log --author=Junio --min-parents=2 --grep=ab/.*grep

For some series of patches to grep where to get one patch in I needed to
often lead with 5-10 test patches to convince reviewers that I knew what
I was changing, and also to be comfortable that I'd covered all the edge
cases we currently supported, but weren't testing for.
