Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D57F20133
	for <e@80x24.org>; Mon,  6 Mar 2017 18:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753414AbdCFS3t (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 13:29:49 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33864 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753153AbdCFS3q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 13:29:46 -0500
Received: by mail-pg0-f44.google.com with SMTP id 77so24797401pgc.1
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 10:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iq+HKFrwPJVuLc2QNQ/9PYiC2i4PXyKItzMNCyYNrbY=;
        b=ClPZn5UkuUN7cCYsL7mWRodJIPRzcDH/a3B6j9/YEv1QHK2CaPJhHN7JM6RXBvbRld
         o13z99COg8RF19Zcsy81BcSqv0+/ieTtmNqnxa3aO+4q0I5Gf34hl8EPVslOgpXD6UN2
         lnmSDTW7+re4etpE4pvDN7lMpctIEvSP6JK03L3VQWpOTr/jdHnr2R8I3yHoIQIeHocq
         VC5NJvj+YEuwPmgxc9m+af7hjtb7unFRjABaeKOkTMBDiMWRFaKMrNLqEDw6tSD4AnZ6
         TKscD+l66kLmom3eKzvRaQT/1i061S0yEHeTgdtscREvUKnO13dyHpxl3ySSrrE17xE1
         oWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iq+HKFrwPJVuLc2QNQ/9PYiC2i4PXyKItzMNCyYNrbY=;
        b=D/7N2/6XrcoWCYJbPyYxtT9cfgCV5BjTarrTY+PKE6/gixwAL70QAjs1VSyu0NNmVn
         utTAXgCvC7UWIx2LWBmaBXjXGLn/d1n/X6xISKWXEZ/1UlbtREn7xQ9bRNm1TC46hzdW
         +ZYUPnd4itqu9/u2JLzUz+/3h1jeet1MU8jFiITU0YJJPYtdkeFExQ7HtP0/wUUMBZYo
         gKqATlT+1MuoVG6u5mxBwTZcXy8fuFRZfTFJehVCZEWKFyCbv5IDLuSPCEyMYGUrb7Gi
         UmMBmYNJbrJ5jnmotToec3mXkudlMzSOM9Af/So5mLKVzSuGNSdB9x/0G3npB3AQqzmv
         PZWg==
X-Gm-Message-State: AMke39n3Si2CBTUM8xpuONpgo8Ah/Kp0DywZA7v9J7/undbscuNRlxQhYM8Cs7gdcVnAb5bf
X-Received: by 10.99.36.7 with SMTP id k7mr21802904pgk.201.1488823384949;
        Mon, 06 Mar 2017 10:03:04 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:10a1:c255:c5bd:a65f])
        by smtp.gmail.com with ESMTPSA id e13sm41147330pgn.38.2017.03.06.10.03.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 10:03:03 -0800 (PST)
Date:   Mon, 6 Mar 2017 10:03:02 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
        Jann Horn <jannh@google.com>, git@vger.kernel.org,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH v2] http: inform about alternates-as-redirects behavior
Message-ID: <20170306180302.GA183239@google.com>
References: <20170304013504.GA27183@untitled>
 <20170304031314.32bta4prahf7pfp7@sigill.intra.peff.net>
 <20170304065548.GA20734@whir>
 <20170304074140.mzgs27jp2jer4mlv@sigill.intra.peff.net>
 <20170304083645.GA24694@whir>
 <20170304084547.4mg4beudseznaw72@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170304084547.4mg4beudseznaw72@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/04, Jeff King wrote:
> On Sat, Mar 04, 2017 at 08:36:45AM +0000, Eric Wong wrote:
> 
> > I also think the security implications for relative alternates
> > on the same host would not matter, since the smart HTTP will
> > take them into account on the server side.
> 
> It depends on the host whether all of the repos on it have the same
> security domain or not. A site like github.com hosts both public and
> private repositories, and you do not want a public repo redirecting to
> the private one to get objects.
> 
> Of course, that depends on untrusted users being able to configure
> server-side alternates, which GitHub certainly would not let you do. I
> would hope other multi-user hosting sites behave similarly (most hosting
> sites do not seem to allow dumb http at all).
> 
> > Perhaps we give http_follow_config ORable flags:
> > 
> > 	HTTP_FOLLOW_NONE = 0,
> > 	HTTP_FOLLOW_INITIAL = 0x1,
> > 	HTTP_FOLLOW_RELATIVE = 0x2,
> > 	HTTP_FOLLOW_ABSOLUTE = 0x4,
> > 	HTTP_FOLLOW_ALWAYS = 0x7,
> > 
> > With the default would being: HTTP_FOLLOW_INITIAL|HTTP_FOLLOW_RELATIVE
> > (but I suppose that's a patch for another time)
> 
> I don't have a real problem with breaking it down that way, if somebody
> wants to make a patch. Mostly the reason I didn't do so is that I don't
> think http-alternates are in common use these days, since smart-http is
> much more powerful.
> 
> > ----------8<-----------
> > From: Eric Wong <e@80x24.org>
> > Subject: [PATCH] http: inform about alternates-as-redirects behavior
> 
> This v2 looks fine to me.
> 
> -Peff

I know I'm a little late to the party but v2 looks good to me too.  I
like the change from v1 that only mentions the config option as opposed
to listing a value it should be set to.

-- 
Brandon Williams
