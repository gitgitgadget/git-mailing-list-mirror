Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA0CE1F405
	for <e@80x24.org>; Tue, 18 Dec 2018 16:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbeLRQsu (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 11:48:50 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:40598 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeLRQsu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 11:48:50 -0500
Received: by mail-lf1-f43.google.com with SMTP id v5so12808990lfe.7
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 08:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VPdPZmJY7XEOO52WwYUWazJ97QL4Cz51yZv+nBSw4BY=;
        b=sHiS4oRNbb2rJf1gWesEXK69ppcN8KS6Ghzi/cc/Fc/9STCKS3J2DK3kQvzVs68Ou/
         cfc46ztWQxhVy3og6aGCadZOIFzSbCmKPCOpi8BRGQLNeVQ9NWbNa76raUvPI88Urjm9
         fxhZIy2tAF/juVjjavNn0whv61uMpeQq+I/r9XjxQjLabPKM7+v0C1W48DdLdFEC72I5
         gPXVunP2gc+yHo5fD20lgbvZFW+0J5GVN7hK6ctESmVJkUQqltS8WLqeeqYOjlpRl5ZH
         ynzIldfMKZYaUD5ZiqlaOW+PykFldGy3cOeC0FJeGqKEn/LqvLTRsHg5OIkVF+DWn8j5
         m3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPdPZmJY7XEOO52WwYUWazJ97QL4Cz51yZv+nBSw4BY=;
        b=f+dd0RcXHkuhgKSyI0WEuUcYPZlm/sEq1xAQWUdPSg53kij7cTAqrNPNBw13ccLD9M
         judI1GLzFUEDXZBWZGovFA0XlGBZZOiu5D0M6mwY7avICzT2ywrGDCjQHJS3bOtttj5c
         8NivMIidhzTS7VOiTM6ZoAfUVwpxCgxkfhA9pK94kDZgAM/efVR1xZZxF82TmWpUMp/U
         AvTTNS/8rmEIBvulsVYxFbITAIwQsBbmm9oycBF4NVRMaCGjKxIBOy4CQCkVj3beLksD
         u2Ad9SG0hizzT07m7Bb7jkYZ68ueTdF/EPvFktIGTBv+VuH+o61/qfPMF5KdS9EsrfAG
         gYJQ==
X-Gm-Message-State: AA+aEWbuc6sUsIzHldnDZIyX0BJzdOhEVGiR9On3M69CCAMMeSFJiVaL
        s+WJXp1b7sqAJNLD8cXVW4XpeAEF+Iaa//MS/a8J8A==
X-Google-Smtp-Source: AFSGD/WEK7lf60dk1UyMUsLj57iraxbiracq0oEbF9m6PNdlavNj+K4cEsQm8NnlHfVJ++W4Rpk/38V5lhauJKe3r2E=
X-Received: by 2002:a19:7352:: with SMTP id o79mr11110518lfc.104.1545151727793;
 Tue, 18 Dec 2018 08:48:47 -0800 (PST)
MIME-Version: 1.0
References: <20181211234909.2855638-1-tj@kernel.org> <xmqqo99rjjcu.fsf@gitster-ct.c.googlers.com>
 <20181212145456.GQ2509588@devbig004.ftw2.facebook.com> <xmqqefamgmey.fsf@gitster-ct.c.googlers.com>
 <xmqqa7lagm18.fsf@gitster-ct.c.googlers.com> <20181213034606.GS2509588@devbig004.ftw2.facebook.com>
 <CAPL8ZiuNgv4s1w-FKAznV5A9MKxSxW40fTPrF0Xt8Ywy6UOsVQ@mail.gmail.com>
In-Reply-To: <CAPL8ZiuNgv4s1w-FKAznV5A9MKxSxW40fTPrF0Xt8Ywy6UOsVQ@mail.gmail.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Tue, 18 Dec 2018 08:48:35 -0800
Message-ID: <CAPL8ZiuxzdUtkRxALBZ=LjTaKQ6d85BmB9nTQ0JPLnVRo91j8Q@mail.gmail.com>
Subject: Re: [PATCHSET] git-reverse-trailer-xrefs: Reverse map cherry-picks
 and other cross-references
To:     Tejun Heo <tj@kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've just uploaded a new evolve proposal that includes a spec for the
"hiddenmetas" namespace, where we can store historical cherry-pick
information.

On Tue, Dec 18, 2018 at 6:40 AM Stefan Xenos <sxenos@google.com> wrote:
>
> Heya, Tejun!
>
> Thanks for getting in touch. I agree with Junio that we probably
> shouldn't be tracking the same information in two ways if we can think
> of something that does both... so let's see if we can think of
> something! The evolve proposal suggests having a metas/ namespace to
> track ongoing changes is intended as a way to track the changes a user
> is actively working on. If we were to use it to retroactively store
> every historical cherry-pick in a large repository, I'm concerned it
> may get too cluttered to use for its originally-intended purpose. I'm
> also not sure how well things would perform with a huge number of
> refs. The remainder of the proposal (using metacommits to store the
> relationships) would work for the xref use-case, but we'd probably
> want to tweak the way we store the root refs in order to do a good job
> with the large number of inactive cherry-picks he probably wants. Any
> code that is looking for cross-reference metadata could look in both
> namespaces.
>
> Conversely, if we were to tweak the xrefs proposal by adding the
> obsolescence information that evolve needs, we'd be missing a place to
> store the user's ongoing changes, a way to push and pull specific
> changes, a way to describe alternate histories for a commit, and a
> mechanism for preventing the commits needed by evolve from getting
> garbage collected.
>
> All the problems with both approaches are solve-able, though.
>
> I spent a few hours discussing this with Stefan Beller last week and I
> think we've come up with a variation on the evolve proposal that would
> cover both our use-cases. Let me know what you think. To address the
> cluttering of the metas namespace, we could introduce a new
> "hiddenmetas" namespace. It would contain the same type of data
> recorded in the metas namespace, but it would normally be hidden from
> the user when they list their changes, etc. It would also be immune
> from the automatic deletions that are applied to the "metas"
> namespace. From your point of view, the critical bit is that it would
> contain information about cherry-picks. That would address the
> "user-visible clutter" problem. Utility methods that want to search
> for cherry-picks would iterate over both namespaces.
>
> For the performance problem, I think we could just live with it
> temporarily and wait for the currently-ongoing reftable work since the
> reftable proposal would address exactly this performance issue (by
> allowing us to store and manipulate large numbers of refs
> efficiently).
>
> A nice characteristic of this approach is that it would also address a
> problem with the evolve proposal that had concerned me: how to deal
> with the filter-branch command, which would have created pretty much
> the same problems regarding the large number of metadata refs for
> changes the user isn't actively working on.
>
> It might be nice to also consider and some alternatives, but I haven't
> had enough time to think up more of them (and I haven't digested the
> xrefs proposal sufficiently to suggest an enhanced version of it yet).
> If anyone else has ideas for combining the xrefs and evolve use-cases,
> having more alternatives to choose from is always better!
>
> If you're okay with the "hiddenmetas" approach in principle, I'll
> update the evolve proposal doc to include it. Once we work out how the
> storage format will work, we can coordinate our implementation work.
>
>   - Stefan
>
>
>
>
> On Wed, Dec 12, 2018 at 7:46 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello, Junio, Stefan.
> >
> > On Thu, Dec 13, 2018 at 12:09:39PM +0900, Junio C Hamano wrote:
> > > Please do not take the above as "don't do notes/xref-; instead read
> > > from the 'meta commits'".  I do not have a preference between the
> > > two proposed implementations.  The important thing is that we won't
> > > end up with having to maintain two separate mechanisms that want to
> > > keep track of essentially the same class of information.  FWIW I'd
> > > be perfectly fine if the unification goes the other way, as long as
> > > goals of both parties are met, and for that, I'd like to see you two
> > > work together, or at least be aware of what each other is doing and
> > > see if cross-pollination would result in a mutually better solution.
> >
> > So, from my POV, the only thing I want is being able to easily tell
> > which commit got cherry picked where.  I really don't care how that's
> > achieved.  Stefan, if there's anything I can do to push it forward,
> > let me know and if you see anything useful in my patchset, please feel
> > free to incorporate them in any way.
> >
> > Thanks.
> >
> > --
> > tejun
