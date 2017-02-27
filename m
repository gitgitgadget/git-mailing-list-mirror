Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6CDC1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 15:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbdB0PIj (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 10:08:39 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35212 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbdB0PIf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 10:08:35 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so13861988wmu.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 07:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BGdPOxsyidZssot5dsYRKJP+u90uYSmKmBsE9fpKn1A=;
        b=L/fAsfDZvbEzWYn9/5r9fvHDyeczw0CF0FO5XDMY0wYwiMCArNSDIj+Wl1Bn1xVRhw
         6hF1WWBI18WqRNKDfHG1Fq+n2tEjT2+8/EXJSQBGi3upvR56d/p6GwBE2J0ofJbRbdIg
         wma+AIL8HYC6eOJFnSBgxAOPe+ws7TqCS1UnaMrWneBr/10cvIsvoE+ASad9KGCO1veU
         CaY5E1Cr08XadtjDbGhNrvsi18KvQ2oJFGMfV+C0yxCmWB/GjzsyqwO6zVIA3WNj2p5R
         0gjk/zDK67T+/G7Lu66igPaKzf+q/mDe7uEjHPkBe44BW327XSCx6UEI6/UcM8R0gSM/
         x+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BGdPOxsyidZssot5dsYRKJP+u90uYSmKmBsE9fpKn1A=;
        b=SmYrgshpssY4LbdTt24hHqor12NLDVlIhgvkQBvZ+TqFq/vDypdqCFKMveq6TyX2I3
         GIo57lysaXNeAeRkKsUYDUDABjV4qAjPNfhiT3pWbIUCJbgxgOHCEdP4gp31esABlZ2y
         Bh9PoR8KNx4ysjVeE6ZTuMA8HckSi17GY72gpyeAefgV1NRaC+9v7OP/oA5W2cz7EOgi
         JHVeK4g45Z90c71eIiBnMyOBXGiSfoynrZlw3xsX3+RB/7mFRtVbN/Z9+PEmXZv4lkzz
         dOVqxgSymm4aDDA3SY/ps2/hmplb3bGd+glax1sLFRKhFVfb3zDSDpJFZFsu+mmOTj5n
         dfbg==
X-Gm-Message-State: AMke39miZJBtyI1hIoQv4wr31RDxr3JMLoAqZEZC4IhanO77RUe36FkEYW7ecPa929VWlQ==
X-Received: by 10.28.103.69 with SMTP id b66mr13805679wmc.73.1488208103654;
        Mon, 27 Feb 2017 07:08:23 -0800 (PST)
Received: from seahawk (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id m188sm14604133wma.27.2017.02.27.07.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Feb 2017 07:08:23 -0800 (PST)
Message-ID: <1488208102.10235.3.camel@kaarsemaker.net>
Subject: Re: [PATCH 4/4] ident: do not ignore empty config name/email
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     bs.x.ttp@recursor.net, git@vger.kernel.org
Date:   Mon, 27 Feb 2017 16:08:22 +0100
In-Reply-To: <20170224041807.5g3yogfnsoqegqkl@sigill.intra.peff.net>
References: <20170223081157.hwfn3msfux5udmng@sigill.intra.peff.net>
         <20170223081708.ge34zjkmpsolocqx@sigill.intra.peff.net>
         <xmqqfuj47hfk.fsf@gitster.mtv.corp.google.com>
         <20170224010823.my4wmdyezjuqajfx@sigill.intra.peff.net>
         <xmqqlgsw5iu8.fsf@gitster.mtv.corp.google.com>
         <20170224041807.5g3yogfnsoqegqkl@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.3-0ubuntu0.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-02-23 at 23:18 -0500, Jeff King wrote:
> On Thu, Feb 23, 2017 at 08:11:11PM -0800, Junio C Hamano wrote:
> 
> > > So I dunno. I could really go either way on it. Feel free to drop it, or
> > > even move it into a separate topic to be cooked longer.
> > 
> > If it were 5 years ago, it would have been different, but I do not
> > think cooking it longer in 'next' would smoke out breakages in
> > obscure scripts any longer.  Git is used by too many people who have
> > never seen its source these days.
> 
> Yeah, I have noticed that, too. I wonder if it would be interesting to
> cut "weeklies" or something of "master" or even "next" that people could
> install with a single click.
> 
> Of course it's not like we have a binary installer in the first place,
> so I guess that's a prerequisite.

I provide daily[*] snapshots of git's master and next tree as packages
for Ubuntu, Debian, Fedora and CentOS on launchpad and SuSE's
openbuildservice. If there's sufficient interest in this (I know of
only a few users), I can try to put more effort into this.

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net

[*]When the tooling isn't broken for some reason.
