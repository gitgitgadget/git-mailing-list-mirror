Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B01EA20281
	for <e@80x24.org>; Mon,  2 Oct 2017 15:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751773AbdJBPKM (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 11:10:12 -0400
Received: from outbound1a.ore.mailhop.org ([54.213.22.21]:14170 "EHLO
        outbound1a.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751667AbdJBPKK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Oct 2017 11:10:10 -0400
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Oct 2017 11:10:09 EDT
X-MHO-User: 8b1b00bf-a781-11e7-a937-4f970e858fdb
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 74.98.178.3
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [74.98.178.3])
        by outbound1.ore.mailhop.org (Halon) with ESMTPSA
        id 8b1b00bf-a781-11e7-a937-4f970e858fdb;
        Mon, 02 Oct 2017 14:54:09 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id F0AC08015F;
        Mon,  2 Oct 2017 14:54:00 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io F0AC08015F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1506956041;
        bh=QxDf+uM+M6aw5y6sHHMGJpVrxfDDqu3yLM+ZeIyIJeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=UPg1RydbJ1q+CDI9/tskkslVqkFvSeegMr4myIXM0x8ey/lFJIfWdaGYRxBYzuaGx
         fj9trNwUPN7z8YMNfg+sB+gjX2tYsc9un6TfnLIgwMcLz2wmnNhOFv+zwJNj9Nk0S5
         iIV8nmhchZ1YiYMmlBcY/tn7KHn6ZoQIkWYMN+5UkgDbwnluWPEp977yz/+H7tnjTl
         /zJNpr6kgbep4KYDSXB4/SqUTaEWa3TA4FzvDkKsaSad4VTuLrKVx8nyq+rrwG3eh7
         u2GAYH0s8vAlj3H2Voahv+bjHlQDgNjU+JKcoVoXCGvKo2F+RNpFKONLpxFb2xiQZk
         5IUrIOQprsl2A==
Date:   Mon, 2 Oct 2017 14:54:00 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
Message-ID: <20171002145400.GF31762@io.lakedaemon.net>
References: <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
 <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com>
 <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
 <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com>
 <CA+55aFwUn0KibpDQK2ZrxzXKOk8-aAub2nJZQqKCpq1ddhDcMQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1709142037490.4132@virtualbox>
 <20170926170502.GY31762@io.lakedaemon.net>
 <alpine.DEB.2.21.1.1709262356360.40514@virtualbox>
 <20170926235158.GD19555@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170926235158.GD19555@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Tue, Sep 26, 2017 at 04:51:58PM -0700, Jonathan Nieder wrote:
> Johannes Schindelin wrote:
> > On Tue, 26 Sep 2017, Jason Cooper wrote:
> >> For my use cases, as a user of git, I have a plan to maintain provable
> >> integrity of existing objects stored in git under sha1 while migrating
> >> away from sha1.  The same plan works for migrating away from SHA2 or
> >> SHA3 when the time comes.
> >
> > Please do not make the mistake of taking your use case to be a template
> > for everybody's use case.
> 
> That said, I'm curious at what plan you are alluding to.  Is it
> something that could benefit others on the list?

Well, it's just a plan at this point.  As there's a lot of other work to
do in the mean-time, and there's no possibility of transitioning until
the dust has settled on NEWHASH.  :-)

Given an existing repository that needs to migrate from SHA1 to NEWHASH,
and maintain backwards compatibility with clients that haven't migrated
yet, how do we

  a) perform that migration,
  b) allow non-updated clients to use the data prior to the switch, and
  c) maintain provable integrity of the old objects as well as the new.

The primary method is counter-hashing, which re-uses the blobs, and
creates parallel, deterministic tree, commit, and tag objects using
NEWHASH for everything up to flag day.  post-flag-day only uses NEWHASH.
A PGP "transition" key is used to counter-sign the NEWHASH version of
the old signed tags.  The transition key is not required to be different
than the existing maintainers key.

A critical feature is the ability of entities other than the maintainer
to migrate to NEWHASH.  For example, let's say that git has fully
implemented and tested NEWHASH.  linux.git intends to migrate, but it's
going to take several months (get all the developers herded up).

In the interim, a security company, relying on Linux for it's products
can counter-hash Linus' repo, and continue to do so every time he
updates his tree.  This shrinks the attack window for an entity (with an
undisclosed break of SHA1) down to a few minutes to an hour.  Otherwise,
a check of the counter hashes in the future would reveal the
substitution.

The deterministic feature is critical here because there is valuable
integrity and trust built by counter-hashing quickly after publication.
So once Linux migrates to NEWHASH, the hashes calculated by the security
company should be identical.  IOW, use the timestamps that are in the
SHA1 commit objects for the NEWHASH objects.  Which should be obvious,
but it's worth explicitly mentioning that determinism provides great
value.

We're in the process of writing this up formally, which will provide a
lot more detail and rationale that this quick stream of thought.  :-)

I'm sure a lot of this has already been discussed on the list.  If so, I
apologize for being repetitive.  Unfortunately, I'm not able to keep up
with the MLs like I used to.

thx,

Jason.
