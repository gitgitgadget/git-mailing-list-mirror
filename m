Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40D9820281
	for <e@80x24.org>; Mon,  2 Oct 2017 16:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbdJBQug (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 12:50:36 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:54405 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbdJBQue (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 12:50:34 -0400
Received: by mail-pf0-f173.google.com with SMTP id d187so3157478pfg.11
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 09:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=59qBFs54NuXHRyJJUCbCjv5GeDZKm7JL/68i5mk7w+w=;
        b=ovFVuP6Wyit5mMy360gzKT4Urj928ajDhiRFYH6XRyRxcwREGpmwP7LP63EcUGH6Eg
         a7hg40yAtjwd+rwRcrIavGAeekiBnSX/R6hFKCwt8JZtTyJTMc7W/5bcju5ZrsNcxxIq
         b4vcCOCfGbVQbZUyMh3DUzYtVOm8iLS8XIXL2yAPuA4/B6X8R8qbZO+pKydy6Lgd4Br1
         SzfFkX0m+M5wpg2FvV3vTdTzlL7ESbslcd8U0+GU9j2QNL5PlOQmj9V4vkJDWtv34Nq3
         b3PlTU3nC/z8YuYM3ERn+5Wq+OWRfA+/V64/unluy2Z2YoYmjWnYcve8JdHLKz9VmpTw
         eMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=59qBFs54NuXHRyJJUCbCjv5GeDZKm7JL/68i5mk7w+w=;
        b=EqpoTgagMGjuqbDn38IT7KBrPe9LQyqQ+lC48tgaUUHDM3NpHL1wKMVMoLWCr0ImGH
         NKt4F2ZeO+dZtrTB9bvrBs6BTAJApEgAp+maNOq8hF8zgVXxXTuUH9SDR2nIn3bI5Qz6
         tzq1yNasImL42PVGBnmXK0xXp2iibFQgxs7Zoqf0tihan5o35k0Dct3mHFuxeDkRq60w
         zMCSHMj+1CGpbYAJBF4X9FpkgR/gc2Q6YNEhjeRTyS8qh9sZVquKjylBF434huEaOt6c
         WG67N/gM3TsXA/UUFUhnHrtS/R9NQQr0kxSNnAjE3H+2/EJ9sSGIQrecd43JeHcCju/B
         2ezg==
X-Gm-Message-State: AHPjjUigp8RZhRbKJfs2SbFS7S1is21IRCk/MxbUUNrQdGG9HJDCoUUa
        aDPhYsuPIQffjZBlirCpA9hfxQ==
X-Google-Smtp-Source: AOwi7QAJJbjba6+Sf845gMj9E5Llipr3jZzLt9jTIwv0OgmmMcetRkldrRvgHOPm4SyiNNEHFugXtQ==
X-Received: by 10.84.177.129 with SMTP id x1mr14880945plb.161.1506963033638;
        Mon, 02 Oct 2017 09:50:33 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:dd1e:eb8d:bfc3:ce25])
        by smtp.gmail.com with ESMTPSA id i12sm16186397pgr.21.2017.10.02.09.50.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 02 Oct 2017 09:50:32 -0700 (PDT)
Date:   Mon, 2 Oct 2017 09:50:30 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jason Cooper <jason@lakedaemon.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        demerphq <demerphq@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
Message-ID: <20171002165030.GA5189@google.com>
References: <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com>
 <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
 <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com>
 <CA+55aFwUn0KibpDQK2ZrxzXKOk8-aAub2nJZQqKCpq1ddhDcMQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1709142037490.4132@virtualbox>
 <20170926170502.GY31762@io.lakedaemon.net>
 <alpine.DEB.2.21.1.1709262356360.40514@virtualbox>
 <20170926235158.GD19555@aiede.mtv.corp.google.com>
 <20171002145400.GF31762@io.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171002145400.GF31762@io.lakedaemon.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/02, Jason Cooper wrote:
> Hi Jonathan,
> 
> On Tue, Sep 26, 2017 at 04:51:58PM -0700, Jonathan Nieder wrote:
> > Johannes Schindelin wrote:
> > > On Tue, 26 Sep 2017, Jason Cooper wrote:
> > >> For my use cases, as a user of git, I have a plan to maintain provable
> > >> integrity of existing objects stored in git under sha1 while migrating
> > >> away from sha1.  The same plan works for migrating away from SHA2 or
> > >> SHA3 when the time comes.
> > >
> > > Please do not make the mistake of taking your use case to be a template
> > > for everybody's use case.
> > 
> > That said, I'm curious at what plan you are alluding to.  Is it
> > something that could benefit others on the list?
> 
> Well, it's just a plan at this point.  As there's a lot of other work to
> do in the mean-time, and there's no possibility of transitioning until
> the dust has settled on NEWHASH.  :-)
> 
> Given an existing repository that needs to migrate from SHA1 to NEWHASH,
> and maintain backwards compatibility with clients that haven't migrated
> yet, how do we
> 
>   a) perform that migration,
>   b) allow non-updated clients to use the data prior to the switch, and
>   c) maintain provable integrity of the old objects as well as the new.
> 
> The primary method is counter-hashing, which re-uses the blobs, and
> creates parallel, deterministic tree, commit, and tag objects using
> NEWHASH for everything up to flag day.  post-flag-day only uses NEWHASH.
> A PGP "transition" key is used to counter-sign the NEWHASH version of
> the old signed tags.  The transition key is not required to be different
> than the existing maintainers key.
> 
> A critical feature is the ability of entities other than the maintainer
> to migrate to NEWHASH.  For example, let's say that git has fully
> implemented and tested NEWHASH.  linux.git intends to migrate, but it's
> going to take several months (get all the developers herded up).
> 
> In the interim, a security company, relying on Linux for it's products
> can counter-hash Linus' repo, and continue to do so every time he
> updates his tree.  This shrinks the attack window for an entity (with an
> undisclosed break of SHA1) down to a few minutes to an hour.  Otherwise,
> a check of the counter hashes in the future would reveal the
> substitution.
> 
> The deterministic feature is critical here because there is valuable
> integrity and trust built by counter-hashing quickly after publication.
> So once Linux migrates to NEWHASH, the hashes calculated by the security
> company should be identical.  IOW, use the timestamps that are in the
> SHA1 commit objects for the NEWHASH objects.  Which should be obvious,
> but it's worth explicitly mentioning that determinism provides great
> value.
> 
> We're in the process of writing this up formally, which will provide a
> lot more detail and rationale that this quick stream of thought.  :-)
> 
> I'm sure a lot of this has already been discussed on the list.  If so, I
> apologize for being repetitive.  Unfortunately, I'm not able to keep up
> with the MLs like I used to.
> 
> thx,
> 
> Jason.

Given the interests that you've expressed here I'd recommend taking a
look at
https://public-inbox.org/git/20170928044320.GA84719@aiede.mtv.corp.google.com/
which is the current version of the transition plan that the community
has settled on
(https://public-inbox.org/git/xmqqlgkyxgvq.fsf@gitster.mtv.corp.google.com/
shows that it should be merged to 'next' soon).  Once neat aspect of
this transition plan is that it doesn't require a flag day but rather
anyone can migrate to the new hash function and still interact with
repositories (via the wire) which are still running SHA1.

-- 
Brandon Williams
