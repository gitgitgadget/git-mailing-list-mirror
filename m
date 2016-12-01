Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7B9D1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 23:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759315AbcLAXHr (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 18:07:47 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34352 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757947AbcLAXHl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 18:07:41 -0500
Received: by mail-pg0-f50.google.com with SMTP id x23so99934526pgx.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 15:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z6m6Oo+UvK03661foNUSqL0PZmtki32PsiBNC4XB85o=;
        b=JMxof+Pk9ZQs9XaBL2DUwY1BSbQiK8M2AL0U9QrEX+hiaBGesPu9fDWu/7vSbZ6c2a
         a4peQ6pBZJ2CYv00ehyDE3qYmS8xBDin/juDGQ402eiH1PXDd2+m6wMf6221eskeDBcO
         3mNu3cSIwMnQ4Q2OSnUetJfLfnJl2tehJmLjlLEbbjqwgX3uFczRqv0AhGCD6mf65d0S
         oMh0hKX4EIYN93CqTiLvczDpVQh3P6w1fUB/5FJXD65316Kov2dpr2RcbuA9sbMqZKST
         Z5zGrcCNA/fxzC2RmL7Lv/BZZ8YM2kbMTrNhS9hcw7AsQVT8PuYAdSGQvce8cdy6EeUJ
         m/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z6m6Oo+UvK03661foNUSqL0PZmtki32PsiBNC4XB85o=;
        b=NxVcHVm6S67YT5ZZtL5vAV6ltE1pG612aRIDE9RYpJhn66LvKrRxLQehijp9PjDq/D
         7jx5FPsYMMmrSetLoFfudDKMP+ZI8IkJulSM1Rt4FiP4wSdycWncF+mMwSsJWLH8mhA7
         I/mv1nCHgy0/XUBXuATj8Kq1N51VF5jNR8SpBbZK3wI9q55FCI/ZR5LNhRUQICzYo1Dw
         VOFKS1uQmhSRtHA4dP/kk/lMoIQZK77J5AFeNPsucxfRSCr4z04iAD7T3mbrghrWyI40
         KFoKCGq+DDDDrFSEhhugrlZGtSTD9oWI02Zx8xQYiDOXR1D30jL357OsqykAI+zyU4jH
         x57g==
X-Gm-Message-State: AKaTC0359tPgoFqVTui+FbVv+YvYDcTmdhHJ5odVxVjsxneY4p36yAdarTh/s4KBcYr4EMqR
X-Received: by 10.98.138.72 with SMTP id y69mr41883682pfd.52.1480633660561;
        Thu, 01 Dec 2016 15:07:40 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:2ce9:cac6:1258:bbf3])
        by smtp.gmail.com with ESMTPSA id y200sm2566987pfb.16.2016.12.01.15.07.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 15:07:39 -0800 (PST)
Date:   Thu, 1 Dec 2016 15:07:38 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v7 4/4] transport: add from_user parameter to
 is_transport_allowed
Message-ID: <20161201230738.GJ54082@google.com>
References: <1480621447-52399-1-git-send-email-bmwill@google.com>
 <1480623959-126129-1-git-send-email-bmwill@google.com>
 <1480623959-126129-5-git-send-email-bmwill@google.com>
 <20161201214004.3qujo5sfdn3y6c5u@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161201214004.3qujo5sfdn3y6c5u@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01, Jeff King wrote:
> On Thu, Dec 01, 2016 at 12:25:59PM -0800, Brandon Williams wrote:
> 
> > Add the from_user parameter to the 'is_transport_allowed' function.
> > This allows callers to query if a transport protocol is allowed, given
> > that the caller knows that the protocol is coming from the user (1) or
> > not from the user (0), such as redirects in libcurl.  If unknown, a -1
> > should be provided which falls back to reading `GIT_PROTOCOL_FROM_USER`
> > to determine if the protocol came from the user.
> 
> Patches 3 and 4 look good to me (1 and 2 are unchanged, right? They are
> already in 'next' anyway, though I guess we are due for a post-release
> reset of 'next').
> 
> > diff --git a/http.c b/http.c
> > index fee128b..e74c0f0 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -725,13 +725,13 @@ static CURL *get_curl_handle(void)
> >  	curl_easy_setopt(result, CURLOPT_POST301, 1);
> >  #endif
> >  #if LIBCURL_VERSION_NUM >= 0x071304
> > -	if (is_transport_allowed("http"))
> > +	if (is_transport_allowed("http", 0))
> >  		allowed_protocols |= CURLPROTO_HTTP;
> > -	if (is_transport_allowed("https"))
> > +	if (is_transport_allowed("https", 0))
> >  		allowed_protocols |= CURLPROTO_HTTPS;
> > -	if (is_transport_allowed("ftp"))
> > +	if (is_transport_allowed("ftp", 0))
> >  		allowed_protocols |= CURLPROTO_FTP;
> > -	if (is_transport_allowed("ftps"))
> > +	if (is_transport_allowed("ftps", 0))
> >  		allowed_protocols |= CURLPROTO_FTPS;
> >  	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS, allowed_protocols);
> >  #else
> 
> This is better, but I think we still need to deal with http-alternates
> on top.
> 
> I think we'd need to move this allowed_protocols setup into a function
> like:
> 
>   int generate_allowed_protocols(int from_user)
>   {
> 	int ret;
> 	if (is_transport_allowed("http", from_user))
> 		ret |= CURLPROTO_HTTP;
> 	... etc ...
> 	return ret;
>   }
> 
> and then create a protocol list for each situation:
> 
>   allowed_protocols = generate_allowed_protocols(-1);
>   allowed_redir_protocols = generate_allowed_protocols(0);
> 
> and then we know we can always set up the redir protocols:
> 
>   curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS, allowed_redir_protocols);
> 
> and which we feed for CURLOPT_PROTOCOLS depends on whether we are
> following an http-alternates redirect or not. But I suspect it will be a
> nasty change to plumb through the idea of "this request is on behalf of
> an http-alternates redirect".
> 
> Given how few people probably care, I'm tempted to document it as a
> quirk and direct people to the upcoming http.followRedirects. The newly
> proposed default value of that disables http-alternates entirely anyway.
> 
> -Peff

I started taking a look at your http redirect series (I really should
have taking a look at it sooner) and I see exactly what you're talking
about.  We can easily move this logic into a function to make it easier
to generate the two whitelists.

-- 
Brandon Williams
