Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 121A81F453
	for <e@80x24.org>; Fri, 28 Sep 2018 02:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeI1JAa (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 05:00:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46832 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbeI1JAa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 05:00:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id b129-v6so3284060pga.13
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 19:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rJSUDXn4DUbBa6DRGtXY06kfKOno1ynxe2Wl5caHJq8=;
        b=KhzPWtSyI8Zf38JQY0qKg3RVyUMQF81VVhPWbd3S4G8g7owTQb5JT27QRP/KvtZDQ6
         Rgj/vIo1sAK53C/KzRZzCpMLhudtIqWavx4V2E5ibCuSUW8guQj1Dau2d2IqxKcdTSPw
         /96Bil3oDf3EB1nZtStO0L0BJ0KDoVXK3QcGRPC4CDE/exi9kMjfrAM8yEoCksa1/Lxn
         hpSeJmjm4m/jN9T0X3mo4t9aJhP4J3lUdw+gKGJj7SaVLelrb2scsAXnsEiJEtg2PpAe
         Ib0J98QrmLksPv1ptysYfjwTgJLTB+aIf/f/uQvw0/M06Gam+fX3P7IHFFIvZiwgT253
         y/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rJSUDXn4DUbBa6DRGtXY06kfKOno1ynxe2Wl5caHJq8=;
        b=Nx/v55FFM3/HgHj3G9RcVvsOvLd35u8zkJVdXcjRRRvq+lSstm0l7hcQDddMS5cnd5
         9TEs0gxYybooll90f4hffoyOn4O67LlZRDTNjLYXG/QWPGYMySAl670pytZAMwRphAty
         VLavQCLNql0L2RZuzxpKzhDt6GGf3oPN0SRbARl3vLXQWBrYEkfe81qYdEGFBLKhmDEn
         YG8ZIUHKDY8qBJAV8tuyYVqh9GUzygFTp3rTX0lJQqnYIyFAcdMIrH1kaefZKHWc3G8u
         2yF0spiCMb71tRBR/AIuFPA8vbNJaFN1WlksUDyn0jq1Ku6u+6QoZuMiG7ywZvCOWMI/
         DuDw==
X-Gm-Message-State: ABuFfohU25SMWPzZA9jvDQS7KH+aHvvvpJIiOhvGe/idrdd9cLHWpDqD
        yIIialp2+XtxkCXRK0n3IiyZbA==
X-Google-Smtp-Source: ACcGV61VVMC2R/v4wKUbczurKS4LC1IdfAg6iDEVgF9hIfHwMePIm1DkFXuBwGZGcjh8a/Mz3heuwA==
X-Received: by 2002:a63:e318:: with SMTP id f24-v6mr12751362pgh.175.1538102343627;
        Thu, 27 Sep 2018 19:39:03 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:1924:afac:8279:2210])
        by smtp.gmail.com with ESMTPSA id x20-v6sm7515360pfe.131.2018.09.27.19.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 19:39:02 -0700 (PDT)
Date:   Thu, 27 Sep 2018 19:39:01 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: Re: [PATCH v2 2/3] transport.c: introduce core.alternateRefsCommand
Message-ID: <20180928023901.GB89283@syl>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1537555544.git.me@ttaylorr.com>
 <9797f525517142b3494cfbd17a10dfeb3bf586e2.1537555544.git.me@ttaylorr.com>
 <20180922180231.GD432229@genre.crustytoothpaste.net>
 <20180922195258.GA20983@sigill.intra.peff.net>
 <20180926010935.GK4364@syl>
 <20180926033337.GC32064@sigill.intra.peff.net>
 <20180926133956.GA25697@syl>
 <20180926183853.GB30680@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926183853.GB30680@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 02:38:53PM -0400, Jeff King wrote:
> On Wed, Sep 26, 2018 at 06:39:56AM -0700, Taylor Blau wrote:
>
> > > A perl tangent if you're interested:
> > [...]
> >
> > To be clear, we ought to leave this function as:
> >
> >   extract_haves () {
> >     depacketize | perl -lne '/^(\S+) \.have/ and print $1'
> >   }
>
> Yes, I agree. You cannot do the "$@" there because it relies on
> depacketize, which only handles stdin.
>
> > Or are you suggesting that we change it to:
> >
> >   extract_haves () {
> >     perl -lne '/^(\S+) \.have/ and print $1'
> >   }
>
> No, sorry. I just used the ".have" snippet as filler text, but I see
> that muddied my meaning considerably. This really was just a tangent for
> the future. What you've written above is the best thing for this case.

I see, and I had assumed that you meant the later, not that including
" .have" was a good way to go forward. So I think that we're in
agreement here.

> > And call it as:
> >
> >   printf "0000" | git receive-pack fork >actual &&
> >   depacketize <actual >actual.packets
> >   extract_haves <actual.packets >actual.haves &&
> >
> > Frankly, (and I think that this is what you're getting at in your reply
> > above), I think that the former (e.g., calling 'depacketize()' in
> > 'extract_haves()') is cleaner. This approach leaves us with "actual" and
> > "actual.haves", and obviates the need for another intermediary,
> > "actual.packets".
>
> Yeah. I have no problem with the three-liner you wrote above, but I do
> not see any particular reason for it.

Good. That's the version that I'll send shortly, then.

Thanks,
Taylor
