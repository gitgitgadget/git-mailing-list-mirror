Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0D7C48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 08:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD76461360
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 08:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhFNIFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 04:05:51 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:41522 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbhFNIFt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 04:05:49 -0400
Received: by mail-ej1-f42.google.com with SMTP id ho18so15099609ejc.8
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 01:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JaxRwd0UMYw3tF3uKM0ify989gCN0IXonRV+9BUorlc=;
        b=F3qDT/IIhSnKQU1vNLcXHd05DaQb+wQ1HL5ly9R0BK1t6c95h3SOxzvzIge/aZ6ajF
         JXOxiS+nPcnmUpEy/lNjx8jwWeyC+I/IkqJP9jdVV0k4NBwU+IAUjvjnRS+ytXlJ3vJL
         h2glD9ZVdaTLNCJgALkumUWSHSAqkltl2KO2TwgoXdyKZKPuOT81+1QbvmXfKXXl5goG
         J0nTCVXIEbA4PyEVWFS867IXkSx3JESXWevjtBEW5SUl5GJF8MHKJRqkLUtV7JZis0c6
         7hEM2VV5AfXt7VQkfuM35JlHIL1iFB8jz7OxZ/1qzIjHFojBFkUYXGaKM8T4O43gBEo3
         wtfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JaxRwd0UMYw3tF3uKM0ify989gCN0IXonRV+9BUorlc=;
        b=AOl2vTDgKib6ZFYk+MRGcwc+l2OYbVGhavn3UX3e2229WT9HLrhw4vGMe5KoirEm4D
         uH8uwfY3L9aJ5JzRlEnrCACAeXtZFmFRcOqMP3J7BREurhC9/KO/XftohcQjRpMWuRmA
         62PEi2IIv52ISLZ9tbBjDL1/8nodJrYji+QUTFNw6y354dX/KhI3ZVNg4yeUrw5YIJ7B
         FA0icNIFIjo8Y07D8xFBD6H+NiEVfUW13ZdS4KvOQH3C+CTNDB4uCq6a0f8p/8So2N0t
         ls5JSGuEe7h7m8nsWy+J5RU3+GfPJ/LITBpOel31tfAGFImew9rx8AY8ZKvaBP9sDZyG
         oLRw==
X-Gm-Message-State: AOAM53061Uw95QYGsQNFJ+1hSNKGwAzdU/UPfRqcsXAuIxeM07ShMhm5
        joyLukXFXQK0VJg6zVIhGbPwINbgoiGO9XXsi98=
X-Google-Smtp-Source: ABdhPJyYHyyBW6wCRzI5q4bGrjYZ78BFQu38f2pOMMiTHudje+gjXPAWRLJ6N893AXopiDjH4e+yYAlIl8LXXjt11Xs=
X-Received: by 2002:a17:906:ecb9:: with SMTP id qh25mr14327192ejb.283.1623657750358;
 Mon, 14 Jun 2021 01:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8QHL-6-DxoRKtx5cVp_DePxtWYU4CuBweYfCG1hGZZhaA@mail.gmail.com>
In-Reply-To: <CAOLTT8QHL-6-DxoRKtx5cVp_DePxtWYU4CuBweYfCG1hGZZhaA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 14 Jun 2021 10:02:19 +0200
Message-ID: <CAP8UFD0jiZuPvO-oYXw9PmVQ56tpYc9nxUxAjPQrc2f1qwEqUQ@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 4
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 13, 2021 at 4:17 PM ZheNing Hu <adlternative@gmail.com> wrote:

> In addition, some scripts like `printf "%b" "a\0b\0c" >blob1` will
> be truncated at the first NUL on a 32-bit machine, but it performs
> well on 64-bit machines, and NUL is normally stored in the file.
> This made me think that Git's file decompression had an error on
> a 32-bit machine before I used Ubuntu32's docker container to
> clone the git repository and In-depth analysis of bugs... In the end,
> I used `printf "a\0b\0c"` to make 32-bit machines not truncated
> in NUL. Is there a better way to write binary data onto a file than
> `printf` and `echo`?

You might want to take a look at t/t4058-diff-duplicates.sh which has
the following:

# make_tree_entry <mode> <mode> <sha1>
#
# We have to rely on perl here because not all printfs understand
# hex escapes (only octal), and xxd is not portable.
make_tree_entry () {
       printf '%s %s\0' "$1" "$2" &&
       perl -e 'print chr(hex($_)) for ($ARGV[0] =~ /../g)' "$3"
}

> Since I am a newbie to docker, I would like to know if there is any
> way to run the Git's Github CI program remotely or locally?

There are scripts in the ci/ directory, but yeah it could help if
there was a README there.

> In the second half of this week, I tried to make `cat-file` reuse the
> logic of `ref-filter`. I have to say that this is a very difficult process.
> "rebase -i" again and again to repair the content of previous commits.
> squeeze commits, split commits, modify commit messages... Finally, I
> submitted the patches to the Git mailing list in
> [[PATCH 0/8] [GSOC][RFC] cat-file: reuse `ref-filter`
> logic](https://lore.kernel.org/git/pull.980.git.1623496458.gitgitgadget@gmail.com/).
> Now `cat-file` has learned most of the atoms in `ref-filter`. I am very
> happy to be able to make git support richer functions through my own code.
>
> Regrettably, `git cat-file --batch --batch-all-objects` seems to take up
> a huge amount of memory on a large repo such as git.git, and it will
> be killed by Linux's oom.

In the cover letter of your patch series you say:

"There is still an unresolved issue: performance overhead is very large, so
that when we use:

git cat-file --batch --batch-all-objects >/dev/null

on git.git, it may fail."

Is this the same issue? Is it only a memory issue, or is your patch
series also making things slower?

> This is mainly because we will make a large
> number of copies of the object's raw data. The original `git cat-file`
> uses `read_object_file()` or `stream_blob()` to output the object's
> raw data, but in `ref-filter`, we have to use `v->s` to copy the object's
> data, it is difficult to eliminate `v->s` and print the output directly to the
> final output buffer. Because we may have atoms like `%(if)`, `%(else)`
> that need to use buffers on the stack to build the final output string
> layer by layer,

What does layer by layer mean here?

> or the `cmp_ref_sorting()` needs to use `v->s` to
> compare two refs. In short, it is very difficult for `ref-filter` to reduce
> copy overhead. I even thought about using the string pool API
> `memintern()` to replace `xmemdupz()`, but it seems that the effect
> is not obvious. A large number of objects' data will still reside in memory,
> so this may not be a good method.

Would it be possible to keep the data for a limited number of objects,
then print everything related to these objects, free their data and
start again with another limited number of objects?

> Anyway, stay confident. I can solve these difficult problems with
> the help of mentors and reviewers. `:)`

Sure :-)
