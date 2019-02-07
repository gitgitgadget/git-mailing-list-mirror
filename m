Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1FF1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 22:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfBGWKl (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 17:10:41 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41000 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGWKl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 17:10:41 -0500
Received: by mail-vs1-f65.google.com with SMTP id t17so937376vsc.8
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 14:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4lHnYCz3RLghtP9lco467nF6wPPcugfAelJ0VTQcGyY=;
        b=ERdXeKLN3qPQXJSHHEvsrGAW1ZNWBes98UVHsgHkt/BN3LkZ7JyQU9yyRauFcDe42i
         Uv88t7G5ceDyCM1uJ8efGWZKsAhP1CZGvgyols7wsg3Fz6EcPyD3paRiplUkLD7GivJO
         ZAKYdvZDlrmSN37B25GMQETvtA4BVhj3tHkMn44wx0S6bdH/z4ZLcgxX/GNetGYriouI
         Oybx3BtGmcUmeaeF9CwQXld4XS/98sBu2hwmUNn3BfbyDxgHnNJZVHNAJOXJ7Fv4dmT3
         UY1GsYJWz4u467uBeshN0JAeMFF2Mcki/wgrcdsOchZZ2UB7BIZ6MgDjRp5OaTN87G+m
         r+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4lHnYCz3RLghtP9lco467nF6wPPcugfAelJ0VTQcGyY=;
        b=saxBg9X1pVs2j9b0coRrRAf6bX/9umi06z3Mo0EM0BrIeECovitH801PmPB9KOXpS4
         R9iZcqP8IL+ZsL9LgTjsLUiu75eClokURS/WxB6weLFuaTLW5LM0kD86h84pKGFivHFq
         4RBbVN6zZdOe3CZbC6MH+FRO8EBKJtrbgHZRsT++eq0f7ncTVNqNvRPubkOPqdZxGgcQ
         iMwx0MahaORICNDN8Sqiy9oLlZkb2vzwg+DPMwR2WHMn8mqbNTlvxPyTeaJukGTnQt7w
         dnPTunRa28ZCZa7J5yzYLSiQnoAO6+/Tld1nP/LacLJrajoNEdBto+KW9sdrCYUEbfG3
         fLsw==
X-Gm-Message-State: AHQUAub6M4NWEltDPjQtcqmzuaXlGUofyRgM4OOlUASazKIZh4NLfiwF
        6ZPlhgCEYITTEk6Pupb4uSFYRQCvQwMTi/lyQ9c=
X-Google-Smtp-Source: AHgI3Ib+JWyJX2HwjsdO8YHpNOI0zzXseXyU7NmM3iYIJOT/bjSlXY68rjsA3HBTUI/YNCIZxyej057QW6GsHpAD6BQ=
X-Received: by 2002:a67:fbd2:: with SMTP id o18mr2509009vsr.117.1549577439841;
 Thu, 07 Feb 2019 14:10:39 -0800 (PST)
MIME-Version: 1.0
References: <20190126221811.20241-1-newren@gmail.com> <20190204200754.16413-1-newren@gmail.com>
 <xmqqlg2vtfmo.fsf@gitster-ct.c.googlers.com> <CABPp-BGyL5BAejK-P-EdscFdH3C6uR7e6CbgNe-9doy-mkw-vg@mail.gmail.com>
 <xmqqa7jarmvo.fsf@gitster-ct.c.googlers.com> <CABPp-BG4WftXZgbzN48zSo1Z5BcWYjdbz+8hGSGBNJbSsYUzAA@mail.gmail.com>
 <xmqqimxvny6s.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimxvny6s.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 7 Feb 2019 14:10:26 -0800
Message-ID: <CABPp-BHyLFNcdh+=hf=R5xhUoNAQHPophxgc5e2HRqgeTU4e8Q@mail.gmail.com>
Subject: Re: [PATCH v4] log,diff-tree: add --combined-all-names option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 7, 2019 at 12:25 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > I think "copy from" and "rename from" should be relatively
> > straightforward.  However, in a combined diff, we could have both a
> > modified status, a renamed status, and a copied status, meaning that
> > we'll need an array of both similarity and dissimilarity indexes...and
> > trying to present that to the user in a way that makes sense seems
> > like a lost cause to me.  Does anyone else know how to represent that?
> >  I'm inclined to just leave it out.
> >
> > Also, I'm afraid "copy to" and "rename to" could be confusing if both
> > appeared, since there's only one "to" path.  If there is both a copy
> > and a rename involved relative to different parents, should these be
> > coalesced into a "copy/rename to" line?
>
> There are three possible labels (i.e. 'in-place modification',
> 'rename from elsewhere' and 'copy from elsewhere'), and you can say
> "this commit created file F by renaming from X (or by copying X)"
> only when you know path F did not exist _immediately before_ this
> commit.  The distinction between rename and copy is whether the path
> X remains in the resulting commit (i.e. if there is no X, the commit
> created path F by moving X; if there is X, the commit copied the
> contents of X into a new path F).
>
> So telling renames and copies apart is probably straight-forward (if
> you have sufficient information---I am not sure if you do in this
> codepath offhand); as long as you know what pathname each preimage
> (i.e. parent of the perge) tree had and if that pathname is missing
> in the postimage (luckily there is only one---the merge result), it
> was renamed, and otherwise it was copied.

We have change status, M, C, A, R, D, etc.  So, R vs. C tells us
renamed or copied.  We also have the original filename.

> But telling in-place modification and other two might be
> trickier. In one parent path F may be missing but in the other
> parent path F may exist, and the result of the merge is made by
> merging the contents of path X in the first parent and the contents
> of path F in the second parent.  From the view of the transition
> between the first parent to the merge result, we moved the path X to
> path F and made some modifications (i.e. renamed).  From the view of
> the transition from the other branch, we kept the contents in path F
> during the transition and there is no renames or copies involved.
>
> Actually what I had in mind when I mentioned the extended headers
> the first time in this discussion was that we would have "rename
> from", "copy from", etc. separately for each parent, as the contents
> may have come from different paths in these parents.  And that was
> where my earlier "... might only become waste of the screen real
> estate" comes from.

I think I'm with you on everything you said here, but perhaps not
since I can't see an answer to my question.  Maybe an example will
help:

Let's say we have an octopus merge.  Parent 1 had file F.  Parent 2
had file X.  Parent 3 had file Y.  The octopus has two files: F' and
X, with F' being very similar to F, X, and Y.

There's no "modified from" header; it's not needed (unless we want to
add a new kind of noise header?)
We could emit a "copied from X" header, due to parent 2.
We could emit a "renamed from Y" header, due to parent 3.

Now, the question: In addition to the two "from" headers, how many
"to" headers do we emit?  In particular, do we emit both a "copied to
F" and a "renamed to F" header, or just a combined "renamed/copied to
F" header?  I'm inclined to go with the latter, to avoid giving the
idea that there are multiple targets, but maybe folks expect there to
be one "rename to" and "copy to" for each "rename from" or "copy from"
that appeared.

> So, again, do not spend too much effort to emit these textual info
> that can be easily seen with the N+1 plus/minus header lines.
