Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 411D41F453
	for <e@80x24.org>; Wed, 26 Sep 2018 13:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeIZT5c (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 15:57:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36556 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeIZT5c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 15:57:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id b7-v6so6058583pfo.3
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 06:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XijGWUJ2nLE9p7rPq+IVcGg9OH66sCsiKu1AW1ADbXw=;
        b=qZfNTw76OgGLTWUxUi1e6LsBwglqohhQVkJ9mv05HxXEqxVYQSW3ghhiFK6uFThc0G
         t403Wx6xmbH+2U4Vg162s4ji3NWnTRirnxOzEgOK23GuZT0CjJQi6YrqnLRe+t+0jK/J
         eNXS2XSkXdesEVX+lFXgirDtO7GyHrerU7xIYuGiZR973q1hRDBGwHbUiKSldOYE6gal
         /cuWQXSbKx5x400TV1QwWARTr1FqRR8sT3IsVreiJyV75H/Cy/8lVH2fs6M1Au6Utv8n
         Fcdu8fFgHus72hXS5Vh8RWZBR8gyA8GH1qpzrThWWulYrhDRmpze9kQL1P7IYPBT7HhT
         RU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XijGWUJ2nLE9p7rPq+IVcGg9OH66sCsiKu1AW1ADbXw=;
        b=hwIhbAMEs01ExqXqhgeerjPFFraFmHqhs1d1Wz/R6H8NRX23O96o0uldzsynfr7RxJ
         floJF8pI4yX2BFT3MyuzDIRTmW4sjiJ7jWcLJS2vOoHKyVt7eLrx5wqrTBRSe1x4+xKE
         QmG+rpm5OfScNGyWc5pBRscv6ePvFyVHbQpNFmU8zNsZqF4UIeZBOlT8p3F+A+hLIRFW
         u0Q4/RDE0Axl3hjUlLYjBWTdYuncNWkO+lGXELGaRte0h1duxeYFSkc+MENv+VNOKGki
         wLauHqyrz4LjWh2NDHu9Oikmx+bfcLdfoeCoFtD4/ojcBRLrdbQUmJwdANNZ1wwvxvuB
         jp9w==
X-Gm-Message-State: ABuFfohD3B8jCYaeKliCU2QkPvwOXNEufkSoxowCtpbWU21WynPEWEJM
        11TA15F7iFFwYef99wuuIKE06Q==
X-Google-Smtp-Source: ACcGV629jUa+9ugdVOYy3uPq011p6YzGr0UYr6CbliGweP4/vIktinRjVeYS2ImzUY9JOMFpOAS+MQ==
X-Received: by 2002:a63:5a0d:: with SMTP id o13-v6mr5833554pgb.267.1537969467603;
        Wed, 26 Sep 2018 06:44:27 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:d190:33d6:11d2:d23b])
        by smtp.gmail.com with ESMTPSA id n80-v6sm10295116pfh.166.2018.09.26.06.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 06:44:26 -0700 (PDT)
Date:   Wed, 26 Sep 2018 06:44:24 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>, Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v4 9/9] Documentation/config: add
 odb.<name>.promisorRemote
Message-ID: <20180926134424.GB25697@syl>
References: <20180802061505.2983-1-chriscool@tuxfamily.org>
 <20180802061505.2983-10-chriscool@tuxfamily.org>
 <CAGZ79kYPik87zvLUPPKFzcATFUdBFcXrAkTYxpxvAQy6w1CcUw@mail.gmail.com>
 <CAP8UFD1ia1xWk9pjfTUQ3zD7=dP=8UjKzf=G0ptsz=qRH8_X+Q@mail.gmail.com>
 <xmqqd0t1nr93.fsf@gitster-ct.c.googlers.com>
 <20180926041222.GA743@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926041222.GA743@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 12:12:22AM -0400, Jeff King wrote:
> On Tue, Sep 25, 2018 at 03:31:36PM -0700, Junio C Hamano wrote:
>
> > Christian Couder <christian.couder@gmail.com> writes:
> >
> > > The main issue that this patch series tries to solve is that
> > > extensions.partialclone config option limits the partial clone and
> > > promisor features to only one remote. One related issue is that it
> > > also prevents to have other kind of promisor/partial clone/odb
> > > remotes. By other kind I mean remotes that would not necessarily be
> > > git repos, but that could store objects (that's where ODB, for Object
> > > DataBase, comes from) and could provide those objects to Git through a
> > > helper (or driver) script or program.
> >
> > I do not think "sources that are not git repositories" is all that
> > interesting, unless they can also serve as the source for ext::
> > remote helper.  And if they can serve "git fetch ext::...", I think
> > they can be treated just like a normal Git repository by the
> > backfill code that needs to lazily populate the partial clone.
>
> I don't know about that. Imagine I had a regular Git repo with a bunch
> of large blobs, and then I also stored those large blobs in something
> like S3 that provides caching, geographic locality, and resumable
> transfers.
>
> [ ... ]
>
> Now if you are arguing that the interface to the external-odb helper
> script should be that it _looks_ like upload-pack, but simply advertises
> no refs and will let you fetch any object, that makes more sense to me.
> It's not something you could "git clone", but you can "git fetch" from
> it.
>
> However, that may be an overly constricting interface for the helper.
> E.g., we might want to be able to issue several requests and have them
> transfer in parallel. But I suppose we could teach that trick to
> upload-pack in the long run, as it may be applicable even to fetching
> from "real" git repos.
>
> Hmm. Actually, I kind of like that direction the more I think about it.

Yes, this is an important design decision for Git LFS, which I believe
is important to this series. Git LFS allows the caller to issue `n`
parallel object transfers (uploads or downloads) at a time, which is
useful when, say, checking out a repository that has many large objects.

We do this trick with 'filter.lfs.process', where we accumulate many Git
LFS objects that we wish to tell Git about so that it can check them out
into the working copy, and then promise that we will provide the
contents later (e.g., by sending status=delayed).

We then "batch" up all of those requests, issue them all at once (after
which the LFS API will tell us the URLs of where to upload/download each
item), and then we open "N" threads to do that work.

After all of that, we respond back with all of the objects that we had
to download, and close the process filter.

Thanks,
Taylor
