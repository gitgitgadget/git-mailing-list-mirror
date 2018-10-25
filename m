Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DFCF1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 19:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeJZD7n (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 23:59:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37030 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbeJZD7n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 23:59:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id c15-v6so9550472eds.4
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 12:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P8mbdFzDETTDjufoJtfb9GDuF1II+zOuNY83ePiIZmc=;
        b=J3sKvyi6PB4iaTzJaeEwuC/hoUh1d0/MMXMJwRrEUohgbtN9AMbXwpuspMrtryir8a
         mSvy3wWArXRspwaoUO+KnGCUe6AMGPJ3VcEQmSRWEenTst/tu+MZaXNBY+/OVHerI6FC
         ww6oXKCcQmM619kVaEyzMir0Zz8Xonf4LhnB3eLycsd2LIrwn2SoMZrFDOkFyUUlxNGN
         XLwxYANeM9zs7pf+lolFjTzr+XbCfivOoDxk5JI6PqP08CokCNhT17iYwbOTytfM30R7
         MDhVeH7eRcBDMcbkdtgbiOR2ZCIdaGyrQDMUCnEyEnzhj7LKPyXJ+ayxfvS8SPjfEXX/
         B8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P8mbdFzDETTDjufoJtfb9GDuF1II+zOuNY83ePiIZmc=;
        b=ADVdkLhELNYV/o/vmxJCTHoCkQH3xcCdIvn+QkNs4rjAHjZKHIgBzxfiqX83wpuv4B
         L/BGUYnZjcw4niYBNN8HY8StOx97f7bJgI9vxhQQt2MC7Yo++hUtUP72WgRKlrIlDExr
         TIqb6wyk6lqyDBnVwG7y0EIfm9YAQ63JIMNmbUuUfEdE6EZWCnh+1gTT67eJ3W7BiSa+
         PoUMVlOhbsRzJVITrHaUK594tv+0y1cMlhLEoZIYovrObCzcv65N5KBt/S8l2muf80G3
         +QBZxXfWhvvR3ZXWZMbxYyGzZ7MmIFyj81Gh00jLHdw0iCI1dY93qDKRdGodqTwfLsDh
         I0Ig==
X-Gm-Message-State: AGRZ1gJYnzGyIYFBLX/cXDvVygIxe9TW0QavwNttIhm5gE+eh2KiQyWA
        2mOAjSxS+POIVNUrzE5Agg1xQKXCbjj03875OHB2bzomd9SzUg==
X-Google-Smtp-Source: AJdET5c90v2IW+V3MDvkfHMeKHm9R3NHicFfhdCQWdExescSzFxXg9BhkT+ffRPjhrUW5Q2uLFZAfCGPK8VRB573ILw=
X-Received: by 2002:aa7:df09:: with SMTP id c9-v6mr365333edy.85.1540495538285;
 Thu, 25 Oct 2018 12:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com> <20181022173935.GG30222@szeder.dev>
 <CAGZ79kboyakR=dARH60ZJmyN=kT+-X0SSDjgz3aswpkUd+bZmg@mail.gmail.com> <20181025015910.GJ30222@szeder.dev>
In-Reply-To: <20181025015910.GJ30222@szeder.dev>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 25 Oct 2018 12:25:27 -0700
Message-ID: <CAGZ79kZySpSZC47U2DmP9ia+a-gNw=4MsdkDGGxO0nio9Eo90Q@mail.gmail.com>
Subject: Re: New semantic patches vs. in-flight topics [was: Re: [PATCH 00/19]
 Bring more repository handles into our code base]
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 24, 2018 at 6:59 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Mon, Oct 22, 2018 at 11:54:06AM -0700, Stefan Beller wrote:
>
> > For the sake of a good history, I would think running 'make coccicheck'
> > and applying the resulting patches would be best as part of the (dirty)
> > merge of any topic that proposes new semantic patches, but that would
> > add load to Junio as it would be an extra step during the merge.
> >
> > One could argue that the step of applying such transformations into
> > the dirty merge is cheaper than resolving merge conflicts that are
> > had when the topic includes the transformation.
>
> Please consider that merge commits' have uglier diffs than regular
> commits, and that merge commits cause additional complications when
> 'git bisect' points the finger at them, both of which are exacerbated
> by additional changes squeezed into evil merges.
>
> > >     Consequently, 'make coccicheck' won't run clean and the
> > >     static analysis build job will fail until all those topics reach
> > >     'master', and the remaining transformations are applied on top.
> > >
> > >     This was (and still is!) an issue with the hasheq()/oideq() serie=
s
> > >     as well: that series was added on 2018-08-28, and the static
> > >     analysis build job is red on 'pu' ever since.  See the follow-up
> > >     patch e43d2dcce1 (more oideq/hasheq conversions, 2018-10-02), and
> > >     one more follow-up will be necessary after the builtin stash topi=
c
> > >     is merged to 'master'.
> >
> > In my understanding this follow up is a feature, as it helps to avoid
> > merge conflicts with other topics in flight.
>
> I don't see how such a follow up patch helps to avoid merge conflicts.

Well, you merge first (the new topic and the cocci patches), and then
do the transformation. But that is putting a lot more work on Junio
as the way to integrate is not just merge a new topic into the pile of
topics (whether it is pu/next/master), but to first perform a merge
of the topic and the coccinelle patches, apply the transformation
and then merge to the pile, assuming the pile is already transformed
(as it happened in "treewide: apply cocci patch" in next/pu).

> > as 'make coccicheck' is an integral part of your review?
>
> Erm, right, "review" was not the right word here.  Anyway, as it is,
> 'make coccicheck' is an integral part of our automated tests, not only
> on Travis CI but on the upcoming Azure thing as well.  I just try to
> pay attention to its results and the results of a bunch of my
> additional builds, and complain or even send a fix when something goes
> reproducibly wrong.  This has certainly became more cumbersome with
> the permanently failing static analysis build job in the last couple
> of weeks.

I seem to not pay as much attention as I should to these,
mostly because they are unreliable  on the aggregate level (a failure
there most likely means another topic than the one I am interested
broke; except in this case, where we discuss the fallout there via
this topic.)

> > I like the approach of having separate classes of semantic patches:
> > (a) the regular "we need to keep checking these" as they address
> >     undesirable code patterns, which is what we currently have,
> >     and what 'make coccicheck' would complain about.
> > (b) The pending patches as you propose. However I would
> >     argue that we'd not want to include the transformation into
> >     the same patch as then the patch will have merge conflicts.
>
> Since we have a lot of parallel running topics, merge conflicts are
> basically unavoidable anyway.  If the conflicts from the
> transformation are really that severe, then perhaps the whole series
> should be postponed to a calmer, more suitable time.

Merge conflicts of this kind could be avoided, by running the
transformation on both sides before merging (or not running them
on both sides, but only after merging).

So maybe for these larger 'the_repository.pending.cocci' patches
we could get them into the tree and wait until all (most) of the topics
are including that semantic patch in their base, such that application
of the patch is easy whether before or after writing a series
(as the semantic patch is in its base).

Another short term plan would be renaming the_repository.cocci
such that it would break the 'make coccicheck'

> In the case of 'the_repository.cocci', merging its transformations
> into 'pu' resulted in only four conflicts, and I found all four on the
> easy side to resolve.  I don't think it's worth waiting with the
> transformations in this particular case.

I am not worried about the current conflicts, but about those to come
in new series.

>
> >     Ideally we'd have an automated process/bot that would apply
> >     all pending semantic patches onto master and then checks for
> >     conflicts in HEAD..pu, and only sends off the non-conflicting
> >     diffs as a topic.
>
> New semantic patches didn't pop up all that frequently in the past, so
> I'm not sure it's worth investing in such an automation.  Of course
> they can become more frequent in the future, and in that case we might
> want to reconsider it.  Unfortunately, however, Coccinelle's results
> can't be completely trusted, either because our semantic patches or
> because Coccinelle itself are buggy...

For the first, we could just be become better at reviewing the Cocci
patch. ;-) (Well, they are harder to review than usual patches, so
this doesn't surprise me. Also not fully understanding the whole
tool may have impact on reviewability)

>
> >     Then after a couple integration cycles we'd have all pending
> >     changes in, with no conflicts on Junios side.
> >
> > So I think we should add a patch like you post, but we would
> > need to discuss the exact approach how to deal with pending
> > patches. Is it the original dev who should push forward on their
> > own pending patches, or does it become a pooled effort?
>
> Well, it makes sense to me that whoever proposes a change with an
> accompanying new semantic patch should also deal with the necessary
> followups.  However, it doesn't really matter who deals with them, as
> long as somebody deals with them.  I don't think it's much different
> from e.g. sending a followup bugfix to someone else's patch series.

Ok, I plan on resending these patches after I get
origin/sb/submodule-recursive-fetch-gets-the-tip going
resent.

Stefan
