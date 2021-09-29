Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C34FC433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 06:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F275613C8
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 06:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244354AbhI2G1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 02:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244007AbhI2G1N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 02:27:13 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1169C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 23:25:32 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id c6-20020a9d2786000000b005471981d559so1596436otb.5
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 23:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qNSSO5Ly14WZ4yIOi7E8RTtTS/rljQbftPO2pcC4Dic=;
        b=eyl36Qe1iDkAJYhyoLwmUm1ok0beV2kGXITgDSSw1W9ztI8qZ7NWcb4WVXvWo6LB/j
         YDfLaAcPBY2GLEkPtz+BepOzKLJ7Rl4jvT9qp0U7cW+i8QaO17wgN5gUeeLBGD6Q8JAH
         f5D7NGRSJYsUgJkV3LSzdvKoyeYXh82JYFI3MkNP9YmUTuq0mFOBROyuH7i/X2rNBKV1
         X16qNZjqeDjR1PAzleInVMAWuNZcZqcn0da6o0Hrv7MUjtxl8zNuxfZcf94lw7emWNZJ
         h1Iw+l9qdRdYhfopr3rC5ahzLOvIcK+kGWL52U4cEQthb+zBSN+jtWPT0M0zW15Y3agx
         6rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qNSSO5Ly14WZ4yIOi7E8RTtTS/rljQbftPO2pcC4Dic=;
        b=U8DzZPmj76nfnFbFoqRzcoRJwq+VsfvdbIluIlkU47V26GsF1LH/hs+LWfDuxVRsWE
         PULHecgzRxQ6QNgoCZJ1PEbiW2fATYsJf+Mbp4UsVv6W/4s7c461/2/k9CVzE9qed5ih
         LDfEScySBcmw/fPL45eG/hwlUpGRmc170awvb9tGHG3JCbEKY4vay+2PBTkcCkT4GPUs
         v+DbKZIDgbtq+PF7khXA1OvbicexEwKK79Ufmnx3dC56sEqCgrLVitbgyvOLP1xlXJqI
         z/OG6PH8CqR/8wj0RREc4zzygyZZFDtc6NTaS9I7mIL8LBdqaB7OjenqAfmQYbbe2MlV
         7KrQ==
X-Gm-Message-State: AOAM533lwEuH1eLQ1aSsbuZrZfespCrS/GavtBxzpQ9I4OrvMrCY2+Iw
        SrMwlPgh5Jqym+3lYT4bpKjjhsxGlfQFnu65anccVGMnE0k=
X-Google-Smtp-Source: ABdhPJyP+Q1k5Y3KflqXk3Sw1Sjc7Cq90bKyAesW3z5k/ISaLrv6bGlyTQzj97UeIPn1Uz8u0yJr4P5tnc+vGfeHjZg=
X-Received: by 2002:a9d:7751:: with SMTP id t17mr8673715otl.276.1632896732111;
 Tue, 28 Sep 2021 23:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <ed71913886e19ccc276b382de707b4bab7834d12.1630376800.git.gitgitgadget@gmail.com>
 <YVOXPTjsp9lrxmS6@coredump.intra.peff.net>
In-Reply-To: <YVOXPTjsp9lrxmS6@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 28 Sep 2021 23:25:20 -0700
Message-ID: <CABPp-BEioOUJRd6FSsmsDtYHhUy7xhr4YabdEmVKzkduo4g9TQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] merge-ort: add ability to record conflict messages in
 a file
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 3:29 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Aug 31, 2021 at 02:26:35AM +0000, Elijah Newren via GitGitGadget wrote:
>
> > There are several considerations here:
> >   * We have to pick file(s) where we write these conflict messages too
> >   * We want to make it as clear as possible that it's not a real file
> >     but a set of messages about another file
> >   * We want conflict messages about a file to appear near the file in
> >     question in a diff, preferably immediately preceding the file in
> >     question
> >   * Related to the above, per-file conflict messages are preferred
> >     over lumping all conflict messages into one big file
> >
> > To achive the above:
> >   * We put the conflict messages for $filename in
> >       $filename[0:-1] + " " + $filename[-1] + ".conflict_msg"
> >     or, in words, we insert a space before the final character of
> >     the filename and then also add ".conflict_msg" at the end.
>
> It took me a minute to understand the space thing. I thought at first it
> was about avoiding conflicts with existing names (and while it might
> help in practice, it's not a guarantee). But I think it's about the
> "appear preceding the file" goal. The space sorts before any other
> printable character in the final position.

Yeah, it's all about the ordering.  I guess it helps slightly with
conflict avoidance, but I cannot rely on it; I have to check for
colliding files and potentially tweak the filename further.

> That's...simultaneously clever and gross. My biggest complaint is that
> the space looks like a bug in the output.

Junio had basically the same reaction[*].  :-)

[*] https://lore.kernel.org/git/xmqqk0k0qkmv.fsf@gitster.g/

> Using another character like "." might not be too bad, as it's also
> fairly early in the ascii table. But it's really this "do it before the
> last character" thing that is key to getting the ordering right.
>
> Just brainstorming some alternatives:
>
>  - we have diff.orderFile, etc. Could we stuff this data into a less
>    confusing name (even just "$filename.conflict_msg"), and then provide
>    a custom ordering to the diff code? I think it could be done by
>    generating a static ordering ahead of time, but it might even just be
>    possible to tell diffcore_order() to take the ".conflict_msg"
>    extension into account in its comparison function.

I can't just go on the ".conflict_msg" extension.  As you noted above,
this scheme is not sufficient for avoiding collisions.  So I need to
append extra "cruft" to the name in the case of collisions -- meaning
we can't special case on just that extension.

I also don't like how diff.orderFile provides a global ordering of the
files listed, rather than providing some scheme for relative
orderings.  That'd either force me to precompute the diff to determine
all the files that were different so I can list _all_ of them, or put
up with the fact that the files with non-content conflicts will be
listed very first in the output, even if their name is
'zee-last-file.c' -- surprising users at the output ordering.

This also means that if the user had their own ordering defined, then
I'm overriding it and messing up their ordering, which might be
problematic.

So, I'm not so sure about this solution; it feels like it introduces
bigger holes than the ugly space character it is fixing.

>  - there can be other non-diff data between the individual segments. For
>    example, "patch" will skip over non-diff lines. And certainly in Git
>    we have our own custom headers. I'm wondering if we could attach
>    these annotations to the diff-pair somehow, and then show something
>    like:
>
>      diff --git a/foo.c b/foo.c
>      index 1234abcd..5678cdef 100644
>      conflict modify/delete foo.c

A couple things here...

First, I'm not so sure I like the abbreviation here.  Just knowing
"modify/delete" might be enough in some cases, but I'd rather have the
full messages that would have been printed to the console, e.g.:

CONFLICT (modify/delete): foo.c deleted in HASH1 (SHORT
SUMMARY1) and modified in HASH2 (SHORT SUMMARY 2).  Version HASH2
(SHORT SUMMARY2) of  foo.c left in tree.

because I think the commit references are useful context.  That extra
context might be of little use for many modify/delete conflicts, but
is much more important for conflicts involving renames; e.g.
"rename/rename" is much less useful than being able to know the
original name of the file and with which parent commit each filename
is associated.  So, that raises the question: could we pack all that
information from the full conflict notice into these conflict
header(s)?  (And do we have to special case the code to print it all
on one line when doing the remerge-diff since the diff output needs
them to be one-line headers?)

Second, what about when there are multiple non-content conflict types
for a single file, e.g. rename/delete + rename/add + modify/delete +
mode conflict + unmergeable binary?  (Yes, I think it's possible for
one path to have all five of those: (1) source file deleted on one
side, renamed on the other, (2) rename target on one side matches new
file added on other side of history, (3) renamed file also had its
contents modified, thus modify vs. delete, (4) added file on other
side of history had a different mode, (5) added file on other side of
history is a binary.)  Do we just use multiple conflict headers?

Third, what about the cases where there is no diff, just conflict
headers?  (I suspect many modify/delete or rename/delete or binary
files may end up in such a situation.)

I don't think any of those are deal breakers, but it means more work,
and maybe also other forms of ugliness.

>      --- a/foo.c
>      +++ b/foo.c
>      @@ some actual diff starts here @@
>
> Obviously such a thing can't really be applied. But then you wouldn't
> want to apply the addition of "my.file e.conflict_msg" either.

Nit: "my.fil e.conflict_msg", not "my.file e.conflict_msg" (the 'e' in
'file' is not repeated, otherwise the auxiliary file wouldn't sort
before its companion file)

> I dunno. The latter especially is definitely more work, and requires a
> bit more cooperation between the merge and diff code. In particular, you
> can't just feed a straight tree to the diff anymore. We have to hold
> back the annotations, and then apply them to the resulting diff. But I
> think the output is much more pleasing to the eye.

It's certainly an interesting idea.  It's a lot more work, it involves
the inability to feed a straight tree to a diff would require piping
things through several different layers (merge -> log -> diff, and
possible multiple diff layers), it may mean we need special handling
for when there are only conflict headers for a file with no file
differences, the length of the conflict headers could be comically
long, and it's all essentially for what is a rather uncommon case
anyway.  But, on the plus side, it does avoid the rather ugly space.

I'll have to think about it.
