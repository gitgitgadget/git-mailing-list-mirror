Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E37DC20756
	for <e@80x24.org>; Wed,  4 Jan 2017 17:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965174AbdADR4O (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 12:56:14 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35059 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761405AbdADR4L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 12:56:11 -0500
Received: by mail-pg0-f51.google.com with SMTP id i5so164918196pgh.2
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 09:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZBrX6tF/fvNpMHKdqOmjPSarFhGyGQzGHA6BrIdR66s=;
        b=bcmluqrDjJaRjvZYNMvBNFIuYb55/mLgiNQLgRWRnkDSPlNApPh039FdKNMOBqV8BQ
         51E/ZnwYiEbONe2qXUUS0zRQewv0dbI4N47Ma4WKY2gjeQf2yuGUe91n5IOvbVeavTKl
         LD49/J/Lctoye+jotqpJUEvPVIwm0Cvq2uVjPmI9G3m41upfnU6XvJUFejDDXHSIPB1r
         bbfBcy/Xph0RX0PzALnPudJO90kTS9xWRPsaY9lm6qTWkla+3tyZlwxwP6PK78LKtJ5U
         a5JEhji6wxghb82hd3Dv0yLKIdijuYDCR15qwEByrLgA5q4Z+SE3la36ZI9nKuXK8b8Z
         OQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZBrX6tF/fvNpMHKdqOmjPSarFhGyGQzGHA6BrIdR66s=;
        b=gSvQ91WagtfI5TMwp+GXM5DMu8EPaS0stcV4Lvcy86Ju6Wqy0qKdtCJ89j+yQ9H+S2
         RSLY1B7iCzVstDZuR5radREA6SlM4jA/BCD4j9mKN87fhX4ZePJxvQWe7jQ4BW0WJDXb
         0qM0NTmjzrYEmUVz19JobMonlwO5JYye5Mpfftsa23vv1bSnCOJm18o0aP21gr2Dus7l
         vMCxwu0QuEVa0n2fSd5C1C0x/7YLcQUhaxFfyKSAFntxzYWxca9rHh9/AGN2vV96zdsI
         8yaaxTOytbW0TUldEmTPQil2Lx4tOUsOuAvSlGEEDpYyDYfgVGzDndj7nCh3nY8ah5SG
         lL8Q==
X-Gm-Message-State: AIkVDXKDw1s6w+2zWV5V0PbEyDZ6LZ6Qi0BCe80P9dtuHmtXXLBsCOQIlGsEvksF2gPcVWFy
X-Received: by 10.99.138.68 with SMTP id y65mr125689939pgd.117.1483552570465;
        Wed, 04 Jan 2017 09:56:10 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1930:3cb0:6c91:e070])
        by smtp.gmail.com with ESMTPSA id m67sm900626pfc.64.2017.01.04.09.56.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 09:56:09 -0800 (PST)
Date:   Wed, 4 Jan 2017 09:56:08 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/16] pathspec cleanup
Message-ID: <20170104175608.GB69227@google.com>
References: <1481670870-66754-1-git-send-email-bmwill@google.com>
 <20170103184241.128409-1-bmwill@google.com>
 <CACsJy8C=SC+gE1HQeGdE5z3+S8RHwiM-4ZXBzuwvN=+COUGNzg@mail.gmail.com>
 <20170104175347.GA69227@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170104175347.GA69227@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/04, Brandon Williams wrote:
> On 01/04, Duy Nguyen wrote:
> > On Wed, Jan 4, 2017 at 1:42 AM, Brandon Williams <bmwill@google.com> wrote:
> > > diff --git a/dir.c b/dir.c
> > > index 15f7c9993..e8ddd7f8a 100644
> > > --- a/dir.c
> > > +++ b/dir.c
> > > @@ -1353,6 +1353,15 @@ static int simplify_away(const char *path, int pathlen,
> > >  {
> > >         int i;
> > >
> > > +       if (pathspec)
> > > +               guard_pathspec(pathspec,
> > > +                              pathspec_fromtop |
> > > +                              pathspec_maxdepth |
> > > +                              pathspec_literal |
> > > +                              pathspec_glob |
> > > +                              pathspec_icase |
> > > +                              pathspec_exclude);
> > 
> > You have done some magic (or your MTA/editor did) to lower case
> > GUARD_PATHSPEC and all the flags. The real patch looks good though, so
> > no problem.
> 
> That's really odd, I was sure I just did a cut and paste.  I'll fix that
> :)

So it looks like what ever I did to insert this into the cover letter
made everything lower case.  The actual patch itself looks fine.

-- 
Brandon Williams
