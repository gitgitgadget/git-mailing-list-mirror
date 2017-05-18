Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FA35201A7
	for <e@80x24.org>; Thu, 18 May 2017 00:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753501AbdERAL4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 20:11:56 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34336 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752852AbdERALz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 20:11:55 -0400
Received: by mail-pg0-f45.google.com with SMTP id u28so14274760pgn.1
        for <git@vger.kernel.org>; Wed, 17 May 2017 17:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jOqFVClMyrYc38Aql78qPsdEAYRHTLzKUM0PUCdUum8=;
        b=miigQ1zjahh/6A44aU+8lkmyulq61PJrJnZzBAA7ZcsQsVdustJouz4eQh9sXYzLnq
         ODSUWBAss60HXt3fgFYqkCPxuibaFbsYdj8QHj/NPdlmKm494QFG3hF9CI1BUPFU/14m
         Hg9K0390AbyvPudyE1OQNgmGhzhGWnZo0tpKi+HimlCBIPXU72z6A6w6B65dE2y3UDUx
         kjSgFtxNWf4GmLsKxKaTft15cpJK88AcvQMmj8qRv0ScfmiLNKSwDMZxOb5AIwZKLOFc
         7HcFysvMO7+yy1TVTlb86SCr0A4WxUGVeDA3V86QnBcZYJJLaeM2uJ1qTTq5t9ZvTetR
         G2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jOqFVClMyrYc38Aql78qPsdEAYRHTLzKUM0PUCdUum8=;
        b=qoLp0483F8+mZeoXar/lJh6DA9M0OvFPowGUpaWJ2JqOstdrE3JvlK57U6TXaL9E6V
         KGqcitm0ToTL2Ll6qDDBAoZH1Gwy0U1H1yedOGeQOWrrDESma1zb5jOht+cEBkmo64Nj
         Vovhku7o9UrXlDThDZyvcTm4+5RRxr2lUcU7aYjXtnXiSoR2+Datk5n+0XAced5xLrQA
         Pe2A+K9uFl6Jrp6my+QR5MRUbiAw8QSUMHt/8EQJRAF0x8VqRgfFwHyeG3qlyEg5mO49
         QUM0t0OjqOo+wtVsTwmfjqmg51/bEDLepll/6x8ugg7/HReVzHp0dCFzrm/RToCVJ9ea
         /55w==
X-Gm-Message-State: AODbwcAx/ApukTey3IYjLMOTukuV5oguoDggucrBLSqC/au4QL7DHSS6
        loUaibWscJsswMXw
X-Received: by 10.99.122.21 with SMTP id v21mr1362028pgc.98.1495066314467;
        Wed, 17 May 2017 17:11:54 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:1838:1185:c4dc:8c8d])
        by smtp.gmail.com with ESMTPSA id o89sm6276160pfj.88.2017.05.17.17.11.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 17:11:53 -0700 (PDT)
Date:   Wed, 17 May 2017 17:11:52 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/3] Use sha1collisiondetection as a submodule
Message-ID: <20170518001152.GE185461@google.com>
References: <xmqqk25gvu12.fsf@gitster.mtv.corp.google.com>
 <20170517113824.31700-1-avarab@gmail.com>
 <CAGZ79kZC98CxA69QjmX2s_SU6z1CSgKgwZeqvwiMRAQc6+S3xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGZ79kZC98CxA69QjmX2s_SU6z1CSgKgwZeqvwiMRAQc6+S3xg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17, Stefan Beller wrote:
> On Wed, May 17, 2017 at 4:38 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> > On Wed, May 17, 2017 at 9:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> >>
> >>> On Wed, May 17, 2017 at 7:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >>>> From: Marc Stevens <marc@marc-stevens.nl>
> >>>>
> >>>> Some big-endian platforms define _BIG_ENDIAN, which the test at the
> >>>> beginning of file has missed.  Also, when the input is not aligned,
> >>>> some platforms trigger SIGBUS.
> >>>>
> >>>> This change corresponds to 33a694a9 ("Fix issues with a big endian
> >>>> platform", 2017-05-15) in the history of the upstream repository
> >>>> https://github.com/cr-marcstevens/sha1collisiondetection
> >>>
> >>> Then why not just update sha1dc from upstream instead of
> >>> cherry-picking one patch from them?
> >>
> >> See the original message upthread.  I did the cherry-pick simply
> >> because that was what Marc instructed the patch recipient to do ;-).
> >
> > Since that patch is now in Marc's upstream code we can just update to
> > that.
> >
> > While we're at it let's see if Marc will take a patch so that we can
> > use his code as-is with some Makefile trickery of our own, instead of
> > having to solve merge conflicts each time we update from him. I'll
> > submit a pull request for that shortly.
> >
> > And since if and when that pull request gets accepted we're at the
> > point of being able to use the upstream code as-is & don't need to
> > locally modify it, we can just use a submodule to track it.
> 
> As someone who works on submodules: YAY! This sounds
> wonderful in the sense that more git developers experience the
> sharp edges (if any) of submodules and would fix them.

Haha, I wish I had your enthusiasm for this.  That is a good argument
for us to include them in git.git, but I still feel apprehensive.  There
is still so much to do in submodule land!  We'll make them great though!

> 
> With the reset work on submodules (checkout, reset,
> ls-files, grep) and more in the works (better push/pull)
> we may be close to prime time.
> 
> However we do distribute tarballs (well, Junio does),
> which is not yet supported to include submodules.
> 
> I did follow the SHA1DC discussion just from the sideline,
> how crucial is that library for us?
> 
> Also now that we discuss having submodules:
> Would we just point the submodule URL to github\
> and call it a day?
> 
> We could make a friendly fork of it and put it next to all the repositories
> of https://git-blame.blogspot.com/p/git-public-repositories.html
> and then use relative URLs in the .gitmodules file.
> 
> On a tangent, in an off-list discussion we discussed having
> the git-annex tests as an optional submodule instead of an
> "external" test, but in conclusion we considered that idea not
> ideal to implement (because our tests are like contracts, we should
> actually write our own tests and not rely on downstream to write
> tests for us)
> 
> looking forward for a discussion here,
> Stefan

-- 
Brandon Williams
