Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99C9520193
	for <e@80x24.org>; Wed,  2 Nov 2016 23:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756605AbcKBXqR (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 19:46:17 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:32826 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756336AbcKBXqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 19:46:16 -0400
Received: by mail-pf0-f174.google.com with SMTP id d2so20033004pfd.0
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 16:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ayEdR3z3aF1kK+/PgoggDr1ghh00CjpHwod9ID2bJsk=;
        b=HKISsRHXFXxz/ZdN3x/9ds2J561ymg/zXCA4XGj1foJtlIjtPGWs8AFU7vnclDamk6
         Eg7YPYqGDOXh6GxdYOP6tTIJxyCccPZEXc9R33rFF1y9BIVnEZUOZCY1fUtZdUtX0IbH
         aXqh6Ywqb6/g6R99b1ds6cfdclWjmFYU5jXqNyliVPP7VyF0XZpiU7dFV7JxakqssJow
         /PHOdFMbG355d+tKBOKD1mAaGz/5T2kNiyN55ZJ7czN7WTckSo6UVQy0/v2hzW2PbQKx
         GaK/eirXXOg5TMT0eH1fy7dOHBd4NoQKFtS367fd+jJjuJNuv43cM0X8FHqb7I2sw5yP
         bntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ayEdR3z3aF1kK+/PgoggDr1ghh00CjpHwod9ID2bJsk=;
        b=FVaHmI5fx3ctwu3q6GG/PhGul9xblvL2aIRho7u0FxlagulAKbfxh2rqp8xaVF7ZLA
         ai1VohJWl4bLKfshEx/h5Q42uA+abkQ4ULAC7CQMsznc+H1DpJvfm1dbUdO+U3TVrkt7
         j5sVZWlVgA39OmbDWENFYgQuDvSqyYUgXCH8YxxC72aeF7dZajcak7PFu1VTQpkD184Y
         mtk+e+VY4eLKJdQ2dZch98G2QFcFQCYOD5Cjm2Ctot2/G6PlwbCqpmnRtruixD/UKw9a
         vp38H3JUrKZV8NnlnXAdkJMi7RJLQJvsJiz/0lr+2MAEtfuAZvnSixAEAPaOgutAYvW9
         aMPw==
X-Gm-Message-State: ABUngvdmPSjOoq4TxDuF9su7se2AWr1/c2jS0bB5XRVTQj431UKfJcN4Vok0dNbbMfOrFg1A
X-Received: by 10.98.81.129 with SMTP id f123mr11594476pfb.36.1478130375514;
        Wed, 02 Nov 2016 16:46:15 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:8080:eeb8:e27c:9538])
        by smtp.gmail.com with ESMTPSA id v84sm7251871pfd.91.2016.11.02.16.46.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Nov 2016 16:46:14 -0700 (PDT)
Date:   Wed, 2 Nov 2016 16:46:13 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH] transport: add core.allowProtocol config option
Message-ID: <20161102234613.GD183367@google.com>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <20161102230538.jx3jwa4hqgrrltno@sigill.intra.peff.net>
 <20161102233304.GB183367@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161102233304.GB183367@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > > diff --git a/transport.c b/transport.c
> > > index d57e8de..b1098cd 100644
> > > --- a/transport.c
> > > +++ b/transport.c
> > > @@ -652,7 +652,7 @@ static const struct string_list *protocol_whitelist(void)
> > >  
> > >  	if (enabled < 0) {
> > >  		const char *v = getenv("GIT_ALLOW_PROTOCOL");
> > > -		if (v) {
> > > +		if (v || !git_config_get_value("core.allowProtocol", &v)) {
> > >  			string_list_split(&allowed, v, ':', -1);
> > >  			string_list_sort(&allowed);
> > >  			enabled = 1;
> > 
> > I thought at first we'd have to deal with leaking "v", but "get_value"
> > is the "raw" version that gives you the uninterpreted value. I think
> > that means it may give you NULL, though if we see an implicit bool like:
> > 
> >   [core]
> >   allowProtocol
> > 
> > That's nonsense, of course, but we would still segfault. I
> > think the easiest way to test is:
> > 
> >   git -c core.allowProtocol fetch
> > 
> > which seems to segfault for me with this patch.
> 
> what is the desired behavior when a user provides a config in a way that
> isn't intended?

oh...I can just drop in git_config_get_string_const() instead.

-- 
Brandon Williams
