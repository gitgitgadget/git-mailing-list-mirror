Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F54120437
	for <e@80x24.org>; Tue, 10 Oct 2017 21:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933427AbdJJVAz (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 17:00:55 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:49691 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933327AbdJJVAw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 17:00:52 -0400
Received: by mail-pf0-f180.google.com with SMTP id l188so18509653pfc.6
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 14:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=s18nRPNz1AuIYoPXAb2Iob6vWeUcHuYnQphRDlyGLKM=;
        b=Z+hBkHlCn1umjI4Sea1VnxnOg372Rw1oZu/ispnyGQbElK7E/n2O1uHkXKge4XSOrV
         7MMoayZyGAZmz1RNctBbUzaOXMlg/JTpiQC1So3wAWrEl4E6DOgyyFaub/eGpcv8gmy5
         fZ5pXiWjZs5upLf/8kV1YBRT5yrdG581/gvFdu9KugIO4p92pA+emUMLZBgj0v4xth8W
         RA8QMmIXvcBZE9NdqEY98FUyVciLcO5ZLy9k1aQfer3+MHdn5cwobAlOWl/NcfHOfyYf
         VFkaokbWbhuXj29OfrlYmQYhnEL4VVs0EaXVZfiwK63NRza12FSlNPgvUTwPYrOLNof+
         0F/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s18nRPNz1AuIYoPXAb2Iob6vWeUcHuYnQphRDlyGLKM=;
        b=LO1FLD5s4LbgInGE2c0zHNvDdx5x8uiwEMVHqA4EUCBTrVBLIPQNFs185w5mDPjYcu
         hn5y4n0aiAGN5foJ3o1G/d4Bkm9sjxFMiXK0TMVwesj2IhcqDjUVxkzD3wMMddlFK27c
         nohE6N14/1WWiRPvztrxw/nMWL68/z2e//T+MziDEM3rJPfoPKfzff27TVvQKk7f9+7s
         6FfcOLaQRoyTg1R2vgKRlwY6zV3OdYNv4NKWnpi2cP43RsAOiPJgK04EhvhsMK9NnFo6
         8uBLIxbAOIIfIKuDe2twpmDcws4i31MFGPe+5SUZHkgsMVMCejRG1SoZQLjic6HbiN3O
         c69Q==
X-Gm-Message-State: AMCzsaWH8AXuVQxtvMCixQqap415LXzKveGVBFafAFlBHo1dt2eT8ztK
        gonRDuxDGANV6ZhyqQO4gB+avg==
X-Google-Smtp-Source: AOwi7QB0rw+zwtXarwR4BUPkCOZT+jsVbfJnf123ZaAVsFtb8wyCsO6MIoOLOuI/KVkLtrvsHlnM2A==
X-Received: by 10.98.222.2 with SMTP id h2mr14887015pfg.165.1507669251667;
        Tue, 10 Oct 2017 14:00:51 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:1c07:9c28:117f:bb59])
        by smtp.gmail.com with ESMTPSA id l3sm20586906pgn.36.2017.10.10.14.00.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 10 Oct 2017 14:00:50 -0700 (PDT)
Date:   Tue, 10 Oct 2017 14:00:49 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Simon Ruderich <simon@ruderich.org>,
        Git Mailing List <git@vger.kernel.org>,
        bturner@atlassian.com, Jeff Hostetler <git@jeffhostetler.com>,
        jonathantanmy@google.com, Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 03/10] protocol: introduce protocol extention
 mechanisms
Message-ID: <20171010210049.GA77383@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-4-bmwill@google.com>
 <20171006090907.gbsgygulzj3bgqrg@ruderich.org>
 <xmqq4lrcwr5c.fsf@gitster.mtv.corp.google.com>
 <CAN0heSrWekXdzqzhL3Lk37YOGPHUdKCDU85t3hJgqK7PSVBZ_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSrWekXdzqzhL3Lk37YOGPHUdKCDU85t3hJgqK7PSVBZ_g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/06, Martin Ågren wrote:
> On 6 October 2017 at 11:40, Junio C Hamano <gitster@pobox.com> wrote:
> > Simon Ruderich <simon@ruderich.org> writes:
> >
> >> Did you consider Stefan Beller's suggestion regarding a
> >> (white)list of allowed versions?
> >>
> >> On Mon, Sep 18, 2017 at 01:06:59PM -0700, Stefan Beller wrote:
> >>> Thinking about this, how about:
> >>>
> >>>   If not configured, we do as we want. (i.e. Git has full control over
> >>>   it's decision making process, which for now is "favor v0 over v1 as
> >>>   we are experimenting with v1". This strategy may change in the future
> >>>   to "prefer highest version number that both client and server can speak".)
> >>>
> >>>   If it is configured, "use highest configured number from the given set".
> >>>
> >>> ?
> >>
> >> It would also allow the server operator to configure only a
> >> specific set of versions (to handle the "version x is
> >> insecure/slow"-issue raised by Stefan Beller). The current code
> >> always uses the latest protocol supported by the git binary.
> >
> > If we do anything less trivial than "highest supported by both" (and
> > I suspect we want to in the final production version), I'd prefer
> > the configuration to list versions one side supports in decreasing
> > order of preference (e.g. "v3 v0 v2"), and take the earliest from
> > this list that both sides know how to talk, so that we can skip
> > insecure versions altogether by omitting, and we can express that we
> > would rather avoid talking expensive versions unless there is no
> > other version that is understood by the other side.
> 
> Maybe I'm missing something Git-specific, but isn't the only thing that
> needs to be done now, to document/specify that 1) the client should send
> its list ordered by preference, 2) how preference is signalled, and 3)
> that the server gets to choose?
> 
> Why would a server operator with only v0 and v1 at their disposal want
> to choose v0 instead of v1, considering that -- as far as I understand
> -- they are in fact the same?
> 
> Different server implementations and different server configurations
> will be able to apply whatever rules they want in order to decide which
> version to use. (It's not like the client can verify the choice that the
> server makes.) And Brandon's "pick the highest number" will do for now.
> 
> There are many possible rules that the server could apply and they
> shouldn't affect other servers or what the client does. For example, the
> server can go "You seem to know lots of versions, including X and Y.
> Those are the two that I really prefer, but between those two I'm not
> picky, so I'll use whichever of X and Y that you seem to prefer." Unless
> I've missed something, we'll never need to implement -- nor specify --
> anything like that before we have learned both v2 and v3.
> 
> I guess my thinking is, there's a difference between the protocol and
> the implementation.

I've been busy the last week or so and I probably wont get much more
time to go into more detail on this until the end of the week, so sorry
for not being super active on this thread in the past couple of days.

One of the key things about this transition is ensuring that we get it
right, because if we get it wrong and find out years later we'll have
to live with it.  So I'm excited and happy that people are taking a
close look at this.

That being said I don't think we need to worry too much about how one
version of the protocol is selected over another.  I fully expect this
to change based on many different factors.  Maybe one particular server
implementation favors v4 over v5, or another serve has no preference at
all.  We may learn something later on, based on security or other
reasons, that we want to prefer one version or another.  Because of that
(and because I'm hoping that once we have a v2 built that we don't have
to move to another protocol version any time soon) I think it would be a
mistake to hard-code or design in inherent preferences that a client
expresses that servers are 'required' to respect.

So I agree with Martin here that if more complicated use cases arise we
can design in a preference system for them at a later time.

Given some of this discussion though, maybe we want to change the
semantics of 'protocol.version' so that both servers and clients respect
it.  As of right now, these patches have the server always allow
protocol v0 and v1?  Though that doesn't do much right now since v1 is
the same as v0.

One other considerations that I should probably handle is that a client
doesn't do any verification right now to ensure that the protocol
version the server selects was indeed the protocol that the client
requested.  Is that something you think we need to check for?

-- 
Brandon Williams
