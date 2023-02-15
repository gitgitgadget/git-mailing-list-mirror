Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE06C05027
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 02:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjBOCgY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 21:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjBOCgX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 21:36:23 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD7730E9F
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 18:36:22 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id w11so25906580lfu.11
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 18:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D6t2ykmmBRcHLLMkqB3fzKtsJ52BbmNOVnHopN+6LZ4=;
        b=Gz9J2lGRoH3HZ2Q8xCTOAwMw58bmL/71h4lu60bjfHqA9NCD/PW0PHSIrM6RwQvI2L
         eI4BpMUnml2BmUmVwwo1A4foLb6T5+i2EJ8NGvCWx4Ap77ck3o0HzDjUC5e+WKkEYC1V
         lFuiHcGiJOXr/HBU1KhTRZAGkoTcgK975xcrRp/lLH0jOn3fXI/mbY7emt14PxLM0c2O
         7oNsGH6GLuU/enoUf4DkXPdXohurC87VRyYGX1mPsXf4UGgo2A95M1pg4cE5fFiG7i6Y
         9I6YBWPMd1ISq4maNNo+SSZAu/H0ZiPBMwt3jiJFsMY8C+/Mq8kKYEOjFGAIM/z0vNEa
         dmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6t2ykmmBRcHLLMkqB3fzKtsJ52BbmNOVnHopN+6LZ4=;
        b=5yw4Sc/S546igaQfZkjD7/8v0rlWHXNKqmabv48OS/CEsr6VVdbJFGnQUY1vY8Prl0
         Tf8QRrxbZScJEBlu8n4GNGYyhVtGwR580WDbjzwPSY/jMQrEncAsryKtRLPhgYKTM3W+
         haXmWetJTQ7oHBomBE7i0K7D75qkZryobmWUXaOT0QdhYFL6oqSLsOOP+BPVFQbV+Nls
         cWyqb0C2PRcVmg07Us9bftReMrTOvSPE2zv9WHPC1gEpXS0UBkqtR4eVqzgPPg36GomH
         Qpci8r2iZkUoPZZ1yG8LRycgBg/Q/MWiu6BGl00S43EC8wISqlbSy0BESw2krs6ALtk8
         VOVw==
X-Gm-Message-State: AO0yUKUX905Fe/8vNPV9NpP7P9QsCgSg2hlg4MXTc2pzar1qyjDrhxWG
        8JqD95lkCR9OaPuPR1WfHjdJgcglGlYKqfFpPeA=
X-Google-Smtp-Source: AK7set8hLTJvG2liHcKOWi7FSIl7WOaJlZ3b0aHr+ugIGyE+neI7dR34kdTXllOZA4zKkTwMBr+MaVouZTOhjPTMMOA=
X-Received: by 2002:ac2:5382:0:b0:4d5:ca32:7bbb with SMTP id
 g2-20020ac25382000000b004d5ca327bbbmr73673lfh.2.1676428579985; Tue, 14 Feb
 2023 18:36:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <230206.865yce7n1w.gmgdl@evledraar.gmail.com> <B544D9E8-13C4-4682-9BDA-D6E19B51C91D@gmail.com>
 <d18a5c32-2f15-93ad-ccbf-e8f048edb311@dunelm.org.uk> <65129323-326F-4E4A-B6F8-06DC3BBE7B58@gmail.com>
 <CABPp-BHhhUhRqn=kKcDiV3EMckBSk2EE8TKZ-PoeqTsKWuvAng@mail.gmail.com>
 <1ddac91b-7552-3e1e-9888-9e21e808104d@dunelm.org.uk> <Y+b2l4Le2gTxGwO8@coredump.intra.peff.net>
In-Reply-To: <Y+b2l4Le2gTxGwO8@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 14 Feb 2023 18:35:00 -0800
Message-ID: <CABPp-BFnCzWH6Aai0ZYv1fR7GMfXqiAE3n8q1Gcrhh-Zv_wTjA@mail.gmail.com>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
To:     Jeff King <peff@peff.net>
Cc:     phillip.wood@dunelm.org.uk, John Cai <johncai86@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 10, 2023 at 5:59 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Feb 09, 2023 at 02:44:15PM +0000, Phillip Wood wrote:
>
> > To see the differences between the output of patience and histogram
> > algorithms I diffed the output of "git log -p --no-merges
> > --diff-algorithm=patience" and "git log -p --no-merges
> > --diff-algorithm=histogram". The first three differences are
> >
> > - 6c065f72b8 (http: support CURLOPT_PROTOCOLS_STR, 2023-01-16)
> >   In get_curl_allowed_protocols() the patience algorithm shows the
> >   change in the return statement more clearly
> >
> > - 47cfc9bd7d (attr: add flag `--source` to work with tree-ish, 2023-01-14)
> >    The histogram algorithm shows read_attr_from_index() being moved
> >    whereas the patience algorithm does not making the diff easier to
> >    follow.
> >
> > - b0226007f0 (fsmonitor: eliminate call to deprecated FSEventStream
> > function, 2022-12-14)
> >   In fsm_listen__stop_async() the histogram algorithm shows
> >   data->shutdown_style = SHUTDOWN_EVENT;
> >   being moved, which is not as clear as the patience output which
> >   shows it as a context line.
>
> Just a small counter-point, since I happened to be looking at myers vs
> patience for something elsewhere in the thread, but:
>
>   git show 35bd13fcd2caa4185bf3729655ca20b6a5fe9b6f builtin/add.c

"fatal: bad object 35bd13fcd2caa4185bf3729655ca20b6a5fe9b6f"

Is that a local commit of yours?

> looks slightly better to me with myers, even though it is 2 lines
> longer. The issue is that patience and histogram are very eager to use
> blank lines as anchor points, so a diff like:
>
>   -some words
>   -
>   -and some more
>   +unrelated content
>   +
>   +but it happens to also be two paragraphs
>
> in myers becomes:
>
>   -some words
>   +unrelated content
>
>   -and some more
>   +but it happens to also be two paragraphs
>
> in patience (here I'm using single lines, but in practice these may be
> paragraphs, or stanzas of code). I think that's also the _strength_ of
> patience in many cases, but it really depends on the content. Replacing
> a multi-stanza block with another one may be the best explanation for
> what happened. Or the two stanzas may be independent, and showing the
> change for each one may be better.
>
> I'm not sure which one happens more often. And you'd probably want to
> weight it by how good/bad the change is. In the example I showed I don't
> find patience very much worse, since it's already a pretty ugly diff.
> But in cases where patience shines, it may be making things
> significantly more readable.
>
> I don't have a super strong opinion, but I just wanted to chime in that
> it is not clear to me that patience/histogram is always a win over myers
> (yes, I know your examples were comparing patience vs histogram, but the
> larger thread is discussing the other).

Oh, I agree histogram is not always a win over myers.  I just feel it
is the majority of the time.  But if you want more than "feels",
here's some solid data to back that up...

I found a study on the subject over at
https://link.springer.com/article/10.1007/s10664-019-09772-z.  They
were particularly interested in whether other academic studies could
have been affected by git's different diff algorithms, and came away
with the answer that it did.  They looked at a few hundred thousand
commits across two dozen different repositories and found (note that
they only looked at myers and histogram, ignoring patience and
minimal):

   * 92.4% - 98.6% of the diffs (depending on repo) are identical
whether you use myers or histogram
   * 93.8% - 99.2% of the diffs (depending on repo) have the same
number of added/deleted lines with myers and histogram
   * Of the >20k diffs that were not the identical, they selected a
random sample of 377 diffs (taking care to make sure they were
statistically representative)
   * They divided the 377 diffs into "code" and "non-code" diffs, i.e.
those modifying source code and those modifying other textual files
   * They had two people annotating the diffs and independently
scoring them, and then checked for agreement between their answers
afterwards.  (No, they didn't always agree, but they did have
substantial agreement.)

For the (again, non-identical) diffs modifying non-code, they found
(see table 11) that:
   * 14.9% of the myers diffs are better
   * 13.4% of the histogram diffs are better
   * 71.6% of the diffs have equal quality

For the (non-identical) diffs modifying code, they found (again, see
table 11) that:
   * 16.9% of the myers diffs are better
   * 62.6% of the histogram diffs are better
   * 20.6% of the diffs have equal quality

A ratio of 4 to 1 for histogram being better on code diffs is pretty
weighty to me.

It's possible these results would have been even better were it not
for a couple of bugs in the histogram code (ported from the original
in jgit).  Phillip pointed me to a problematic testcase that Stefan
Beller found, and in attempting to fix it (I'm on fix #4 or so), I
believe I found another issue.  However, I don't want to go into too
much detail yet, as I found problems with some of my previous fixes
and already invalidated things I told Phillip just last week.
