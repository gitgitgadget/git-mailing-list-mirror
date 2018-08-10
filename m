Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C4131F404
	for <e@80x24.org>; Fri, 10 Aug 2018 23:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbeHKCL2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 22:11:28 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42265 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbeHKCL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 22:11:28 -0400
Received: by mail-yw1-f67.google.com with SMTP id y203-v6so9812031ywd.9
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 16:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0uXPtK+I6qhh3pKGotkX3LNxNMshMBpBGjF64PlmQfg=;
        b=ZjhCbrTvsCbjxHLUU05/W7hxDbAPwqsYoipF9H5+0khy+eExOMazIf2zqcSjdLd8nI
         h438Ix+N3FRt/MZvo5YsP9YPCwH+IKlGA1Zs3NSCTeJe2yieSp3PBjDefUJzmjs1BbB+
         dKK3xhWSp17fBFMTcjfc2K4XGc6yPs1hadbRKuqkPJg8LZEchvQsGHrR84H09QK6wzLo
         2PTE9E1VvhLAzUuoyLLoEe+UKIAeIa+fKgzkyAxGX5WzutWntKO9Gi8lh/Qxl9CWvv6S
         /+gzm8ttbABLqDF8QdgogGJ8czsqPODzCGnUA+tT11yZn/53+USoD1ep4IvucEa4mF0w
         3HaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0uXPtK+I6qhh3pKGotkX3LNxNMshMBpBGjF64PlmQfg=;
        b=l2oB4j9x0fNx1xUikWxfcaZicIt86ZN6ccUr3+hnzaNiJmvaokBAfZ3TPWcmzzbixz
         /6vDJ54PtDuyowfc9MQ6/JhcuJI57P70u/1R4qFP3sPlen8fQmmAl3Sq7jNAcLnh3WVE
         tIDCGmZkj5qrfcVjW/xGk82qTpjmDTGx4jpTekpLOt5rv6HclZ6bR1G/+purlS0ADEcj
         HnBhS65mG6rz/Gmnz9ottdGEE1bmuiAYntS063FEJxLD4Y4cAt3uVbqLKlNaISWQrpcA
         /5XZb3AyNTeu6zVUhkJcWXenIVxeujMBNe0sXSAk22tdh+1PGs/8R15vTlpCPHpgHWrp
         dnyg==
X-Gm-Message-State: AOUpUlGhJ/IBD6mvby0wY2bvmfhmEtltnp7zmmrRwiZnNBxESCTAb6U3
        ndkkj/TpecEuxJgtIN7xa5k45l/P5N2i1rf7oD8alUPZBGU=
X-Google-Smtp-Source: AA+uWPxHn26Fk8ljwkLUjIQmjpMZRNMATYZ87jbAZRB9iVQevACSbGMBVFQGRYqzyga+Hu605K00GC4H6oWu6hHnum0=
X-Received: by 2002:a25:af08:: with SMTP id a8-v6mr2177759ybh.167.1533944365877;
 Fri, 10 Aug 2018 16:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180810230729.GA19090@sigill.intra.peff.net> <20180810230906.GA19875@sigill.intra.peff.net>
 <CAGZ79kYStPNCodJBqZ-ELh2oEhEyQFFjr0SVn0Bn+gtAspbZiA@mail.gmail.com>
 <20180810233133.GA30076@sigill.intra.peff.net> <20180810233347.GA30479@sigill.intra.peff.net>
In-Reply-To: <20180810233347.GA30479@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 10 Aug 2018 16:39:14 -0700
Message-ID: <CAGZ79kZ0eN5eaBM8HjLVFpW8-ph3g0ym=-4ONTA7pgV=k3oz-Q@mail.gmail.com>
Subject: Re: [PATCH 1/7] for_each_*_object: store flag definitions in a single location
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 10, 2018 at 4:33 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Aug 10, 2018 at 07:31:33PM -0400, Jeff King wrote:
>
> > On Fri, Aug 10, 2018 at 04:27:25PM -0700, Stefan Beller wrote:
> >
> > > >  cache.h    | 13 ++++++++++++-
> > > >  packfile.h |  8 ++------
> > > >  2 files changed, 14 insertions(+), 7 deletions(-)
> > >
> > > rubs me the wrong way. ;-)
> > >
> > > cache.h is such a misnomer of a name, and a kitchen sink
> > > of a file in the Git project that in an ideal world it would
> > > be way smaller and contain only things related to some
> > > caching related code.
> > >
> > > I would suggest object.h or object-store.h instead.
> > > Probably the object-store as that will be the only external
> > > exposure and hopefully we'd get the objects in a similar
> > > shape as the refs subsystem eventually?
> >
> > Yes, for_each_loose_object() ought to be in loose.h to match packfile.h,
> > or the whole thing should go into object-store.h.
>
> Heh, I thought you were making up a hypothetical object-store.h, but I
> see it has already come to pass.
>
> IMHO the whole for_each_*_object() interface should go in there (it even
> has packed_git defined there already!). I think I'd still just as soon
> do it on top of this series, but it might not be too bad to do as part
> of a re-roll.

Yeah, I realize that I distracted myself and ranted about a different thing
other than the quality of this patch. (We had a couple of internal discussions
about project velocity and contributor happiness and I personally think this
derailing is some sort of anti pattern as fixing things like these is easy
as compared to user visible things such as file formats or configs.
Sorry for that.)

Stefan
