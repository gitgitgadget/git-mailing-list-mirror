Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE6531FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 17:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751040AbcLBRd4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 12:33:56 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36275 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbcLBRdy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 12:33:54 -0500
Received: by mail-pg0-f44.google.com with SMTP id f188so109155873pgc.3
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 09:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q9Ccof/WPJ4w3fBFeqOKyxgz4c/W/POTHBVPhctYmXg=;
        b=hOg9dm2OUYuHIHyWRg4BCteb5wnSwTLxr5La6LiIHFyCINSbCgY++d6lTT520X4uXs
         fpMTSJuOoFL5F1OkHoO2erQwbhB6tkE2L7NnMJsmNCB3kJvOgoBvzdSdD+M6K2WqSyeN
         q4NepRRkx/52UBRhMw+LxH3CrTfPf6VEh34n4YrYA5414xqIdvyORMWyUcvYrA/I+FLz
         vQroSGhabjfVfxLEqUbpquB0acT/xkLLswVcGftkJE8UTq+l4zmXK0hpdALywEb1zesT
         3TMhccdLgHucG/dMXi4Md+Is9CtLqvAqEn602X29qNDRWvZD5nUNfOmZbzjLzxLfwUWz
         74NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q9Ccof/WPJ4w3fBFeqOKyxgz4c/W/POTHBVPhctYmXg=;
        b=eiX96S9Qqnu4e5Q6Y+AmK9Kh5AmzM/VlFxH+vxmOziqeEatCSPleZUbEriPmSyu7TH
         eIwjdEb3yqXnO0CJIT4ASD2fCVv2mTs6y+8AAMM7tfTl1PKJ/fW8x8PcOoS8Kd6zvEb4
         iBfY4WedwQ/6TQ6tBsJKgeiXGZ5+KKMBhggMD6csRm07oE4/a/bEHehF6qMhDj/O59GY
         PvZhHJTrwMUcRDyd0CNXzHe6b1Krp00OeDhdBcFteS5253d8YXNfqjz1hN/v8OlbNxyH
         xNBOhN8741JpLIz+SjwM39krIKvfA94oF1CdGvxrCXJaMTcgzG1MYyGbAQwQo/R2Usel
         6Dhg==
X-Gm-Message-State: AKaTC03eHSCADC/Mp8lmKx+SofhtJ9xiXNMyD63reByiDpnRx23yfXzygRAUrkZ0z90bfOBZ
X-Received: by 10.84.218.13 with SMTP id q13mr98248044pli.168.1480700032542;
        Fri, 02 Dec 2016 09:33:52 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:217c:34ba:fcf8:d822])
        by smtp.gmail.com with ESMTPSA id b126sm9093816pfg.90.2016.12.02.09.33.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 09:33:51 -0800 (PST)
Date:   Fri, 2 Dec 2016 09:33:49 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v7 4/4] transport: add from_user parameter to
 is_transport_allowed
Message-ID: <20161202173349.GA117792@google.com>
References: <1480621447-52399-1-git-send-email-bmwill@google.com>
 <1480623959-126129-1-git-send-email-bmwill@google.com>
 <1480623959-126129-5-git-send-email-bmwill@google.com>
 <20161201214004.3qujo5sfdn3y6c5u@sigill.intra.peff.net>
 <20161201230738.GJ54082@google.com>
 <20161201232656.GK54082@google.com>
 <20161202001353.jiw4hjqg75dr6psw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161202001353.jiw4hjqg75dr6psw@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01, Jeff King wrote:
> On Thu, Dec 01, 2016 at 03:26:56PM -0800, Brandon Williams wrote:
> 
> > > I started taking a look at your http redirect series (I really should
> > > have taking a look at it sooner) and I see exactly what you're talking
> > > about.  We can easily move this logic into a function to make it easier
> > > to generate the two whitelists.
> > 
> > Thinking about this some more...I was told that having http redirect to
> > file:// could be scary.  The way the new protocol configuration is setup
> > we have file:// as a default known-safe protocol.  Do we need to worry
> > about this or can we leave this be since this can be overridden by the
> > user?
> 
> Hmm. I'm not sure if file:// should actually be USER_ONLY. The submodule
> code allows it, and it's certainly a convenience, but I guess you could
> do tricky things by probing somebody's filesystem with submodules URLs.
> On the other hand, if you are recursively cloning untrusted repos and
> have sensitive contents on disk, you really _should_ be setting up a
> protocol whitelist.
> 
> For HTTP redirects within curl, I think it's a non-issue; curl
> automatically disallows file:// for redirects, even without us telling
> it so.
> 
> For redirects via http-alternates, it's a bit more tricky, as we feed
> the URL to curl ourselves, so it can't tell the difference between
> trusted and untrusted input. The main protection provided by my series
> is "don't follow http-alternates at all". But assuming you did want to
> use them (by setting http.followRedirects to "true", at least for the
> server in question), we could then feed file:// directly to curl. But I
> think we are still OK, because the restricted CURLOPT_PROTOCOL setting
> would prevent that from working. I.e., git _never_ wants curl to handle
> file://, because it handles it without calling into remote-curl.c at
> all.
> 
> So arguably file:// should be USER_ONLY, but I'm not sure how much it
> matters in practice.

Ah ok thanks for the good explanation.  I was mostly interested in the
http redirect case which, as you said, becomes a non-issue due to how we
configure curl.

Thanks!
-- 
Brandon Williams
