Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7643E1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 23:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeHUCsH (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 22:48:07 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44960 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeHUCsH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 22:48:07 -0400
Received: by mail-oi0-f67.google.com with SMTP id s198-v6so28916937oih.11
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 16:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4C3ueZpuI20PI+tQW4t174ls/rRkL10p+C/vnetgPpU=;
        b=ZDTTtlk86dlx8+oOWETAnJ75WyJ+E83KVcnJqgNTdXddUSlOLDR16KW+sMvZZEOgNp
         wuCzMRYTznP8Il1R146+i57wR6Jec8XHTnjCpgwcn5eMdmfJpurouWA+5dTklkckUKHo
         tek8mQrjQjUGXVpjQDIDYv4a+Ks5S2TqcbPx2MqfnU8kKHJwwL+yVFN/ecAA4H2qNZ0q
         bbHP3SxPNpZRSICqcR6TZ5JF5RAIkcrTaNi+6WLdyVE/MCO8XT2GVGSrGRUDJtub/9Lx
         T6Zf9Ync6Jpqce2uJM1cqaNsYOUFUR9a25WIiObFRTHFRWNu9iOQLcRRU1cHVsKv8V8V
         3rxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4C3ueZpuI20PI+tQW4t174ls/rRkL10p+C/vnetgPpU=;
        b=IVrIOqX+RYBmJMkE1Z84x50fBf9nn68xDe+dN1vLe4/1GcVcfjoSHz2wM6L2ATHTyF
         KgBCwPgq+AgKRL+2pAc28PXgaEgov0uNNXMGDBLuu0WQttY4sIv6cdBaAIchHlxkPPmX
         awmKupd1cjAIgkdh+TqQPSSV+Z3aGCa6A9aR5nKHEVoQXsXgKZjPCt31HeocDrrXPY6w
         aHFhZDacf1ySXJE/iMpGmvoYIzZCKUv2w1boN96EYM3m1xk/pLxsocgwEUT5+oXxkgVk
         +qdUmEyz18Oe3LqgHaOL2SLNJvCsUZuds2KrwUdc1k9QOQYBKBR5Xx5eFeSOUrxM/Lvw
         BmWg==
X-Gm-Message-State: AOUpUlGNWF7Gme5qH+Y5eoTDo6pRffOxTs1HOIHVe5J0fV9dnvFP3pxs
        eirtVUfUj+OEjoTUIuJ1/TlDQXuKqSUrepti+c/fkA7VnbiI
X-Google-Smtp-Source: AA+uWPwtfgzhHZz01ybmfk4WRFrlJQ+eV/5yRLgP4mkhfvNZu0dBlxpbvdnQu1ul18dmqPFId8p+Ouoq29LKhjVWXW8=
X-Received: by 2002:aca:3507:: with SMTP id c7-v6mr17670498oia.46.1534807827330;
 Mon, 20 Aug 2018 16:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1534374650.git.matvore@google.com>
 <5d3b4e4acb73009e4cefecd0965fe5dd371efea1.1534374650.git.matvore@google.com>
 <CAGZ79kaWcGbyc2S5gOCU7NdvT4fN46jq4xK9MvTLAFBGhyuo2A@mail.gmail.com>
 <CAMfpvhK3ouxa5H1ZWy_ZrQBjSq_qwavOtLe98SshaUmjTyBQXw@mail.gmail.com> <CAGZ79kb3W6fNkqNemcdziXBB_cDmd3ngBU_0tdS_32rUhAW4dA@mail.gmail.com>
In-Reply-To: <CAGZ79kb3W6fNkqNemcdziXBB_cDmd3ngBU_0tdS_32rUhAW4dA@mail.gmail.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Mon, 20 Aug 2018 16:30:15 -0700
Message-ID: <CAMfpvhKPJijO_E2FRh-UtrOthEc2YTaG0=1ToYy3akjzWUZWiw@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] list-objects-filter: implement filter tree:0
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 3:28 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Fri, Aug 17, 2018 at 3:20 PM Matthew DeVore <matvore@google.com> wrote:
> >
> > On Fri, Aug 17, 2018 at 2:42 PM Stefan Beller <sbeller@google.com> wrote:
> > >
> > > On Wed, Aug 15, 2018 at 4:23 PM Matthew DeVore <matvore@google.com> wrote:
> > > >
> > > > Teach list-objects the "tree:0" filter which allows for filtering
> > > > out all tree and blob objects (unless other objects are explicitly
> > > > specified by the user). The purpose of this patch is to allow smaller
> > > > partial clones.
> > > >
> > > > The name of this filter - tree:0 - does not explicitly specify that
> > > > it also filters out all blobs, but this should not cause much confusion
> > > > because blobs are not at all useful without the trees that refer to
> > > > them.
> > > >
> > > > I also consider only:commits as a name, but this is inaccurate because
> > > > it suggests that annotated tags are omitted, but actually they are
> > > > included.
> > >
> > > Speaking of tag objects, it is possible to tag anything, including blobs.
> > > Would a blob that is tagged (hence reachable without a tree) be not
> > > filtered by tree:0 (or in the future any deeper depth) ?
> > I think so. If I try to fetch a tagged tree or blob, it should fetch
> > that object itself, since I'm referring to it explicitly in the git
> > pack-objects arguments (I mention fetch since git rev-list apparently
> > doesn't support specifying non-commits on the command line). This is
> > similar to how I can fetch a commit that would otherwise be filtered
> > *if* I specify it explicitly (rather than a child commit).
> >
> > If you're fetching a tagged tree, then for depth=0, it will fetch the
> > given tree only, and not fetch any referents of an explicitly-given
> > tree. For depth=1, it will fetch all direct referents.
> >
> > If you're fetching a commit, then for depth=0, you will not get any
> > tree objects, and for depth=1, you'll get only the root tree object
> > and none of its referrents. So the commit itself is like a "layer" in
> > the depth count.
>
> That seems smart. Thanks!
>
> >
> > >
> > > I found this series a good read, despite my unfamiliarity of the
> > > partial cloning.
> > >
> > > One situation where I scratched my head for a second were previous patches
> > > that  use "test_line_count = 0 rev_list_err" whereas using test_must_be_empty
> > > would be an equally good choice (I am more used to the latter than the former)
> >
> > Done. Here is an interdiff (sorry, the tab characters are not
> > maintained by my mail client):
>
> heh. Thanks for switching the style; I should have emphasized that
> (after reflection) I found them equally good, I am used to one
> over the other more.
It seems marginally better to me. I also noticed a clean-up patch
going by that aggressively switched to test_must_be_empty wherever
possible: https://public-inbox.org/git/20180819215725.29001-1-szeder.dev@gmail.com/

OTOH, if it were up to me I would have just gotten rid of
test_must_be_empty and used an existing function with the right
argument, like `test_cmp /dev/null` - but using some form consistently
is the most important, whatever it is.

>
> So if that is the only issue brought up, I would not even ask for a resend.
>
> Thanks,
> Stefan
