Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21E4A1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 23:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755856AbcLAX07 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 18:26:59 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33178 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753463AbcLAX07 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 18:26:59 -0500
Received: by mail-pg0-f53.google.com with SMTP id 3so100081406pgd.0
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 15:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LvpZxrT9icCE3AUMLDgczYCGCr/VdvyXbGRD4YP4wL8=;
        b=PyPn+/+KjNM4vdtOgSum/vc91zsImkCWoGcQfQCOjy/g1KUc5RbfHrfopDDBH1uA0g
         ps2Om6PQWibRgodoLqYnlqpS6EKcqXX9E+lRDp7SRVzEzRM76Iw0IdR1xeyJ4P2jBsEk
         owNG3D0mkJ66XxFCEwXziR3wZlpPvsrHTMNYjf8SVNBi6ZMbPcaHpEBPEZRv5vPSQiPt
         gOfLgxpwDlTBOJUhZ+wv3cGkMeaDsz3FGZ56PGQQe1+axS6lWqsDfa1k5wHalYhZqrW9
         xdMK5YVwPKkEjCE+7Ys4EOrxLrDoTfJYAEwyBLwjd2w4fwOgnq3HCiSMX94Tf6wc8FcB
         2eHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LvpZxrT9icCE3AUMLDgczYCGCr/VdvyXbGRD4YP4wL8=;
        b=FWecC8bDGmQ2TBmoQQBERjt5sa1NOhlTZ+4zDmgicegSECczwbhLYFMdv4XAbYessW
         n/2pEIqoWJGohgar6bJKiqm2V8oN/QAg22AQ6+vKdhKeG+6IgwR0FiiftssE2wEGo6No
         KuHMWAzQ6JR/nK3Rwjhg0OJPe8DHUgUX7jwQ9ero7To4fSjLsufGknXFqAvAiPZWXdPC
         9o1r+UHQDjZSoCnOcvCvQPiwDOF2chnv/I86bXMEQIcFkKs0y3M5R8cpr3vNPIi7/sVE
         25OisOjtUGXh7Oe7NDCJU83FcfW9g4Laj/konqmuVrei4rEf/6/01DWMxaFC6quxK8fd
         2t2Q==
X-Gm-Message-State: AKaTC01Bhm4wsOMosdLxuopKd98PtO1hlBAZ2ktIRfENnSiNB4CMYFW6FLXqASHI3KV2bXm3
X-Received: by 10.99.145.74 with SMTP id l71mr73223632pge.128.1480634818060;
        Thu, 01 Dec 2016 15:26:58 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:2ce9:cac6:1258:bbf3])
        by smtp.gmail.com with ESMTPSA id z9sm2573043pfd.29.2016.12.01.15.26.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 15:26:57 -0800 (PST)
Date:   Thu, 1 Dec 2016 15:26:56 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v7 4/4] transport: add from_user parameter to
 is_transport_allowed
Message-ID: <20161201232656.GK54082@google.com>
References: <1480621447-52399-1-git-send-email-bmwill@google.com>
 <1480623959-126129-1-git-send-email-bmwill@google.com>
 <1480623959-126129-5-git-send-email-bmwill@google.com>
 <20161201214004.3qujo5sfdn3y6c5u@sigill.intra.peff.net>
 <20161201230738.GJ54082@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161201230738.GJ54082@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01, Brandon Williams wrote:
> On 12/01, Jeff King wrote:
> > On Thu, Dec 01, 2016 at 12:25:59PM -0800, Brandon Williams wrote:
> > 
> > > Add the from_user parameter to the 'is_transport_allowed' function.
> > > This allows callers to query if a transport protocol is allowed, given
> > > that the caller knows that the protocol is coming from the user (1) or
> > > not from the user (0), such as redirects in libcurl.  If unknown, a -1
> > > should be provided which falls back to reading `GIT_PROTOCOL_FROM_USER`
> > > to determine if the protocol came from the user.
> > 
> > Patches 3 and 4 look good to me (1 and 2 are unchanged, right? They are
> > already in 'next' anyway, though I guess we are due for a post-release
> > reset of 'next').
> > 
> > > diff --git a/http.c b/http.c
> > > index fee128b..e74c0f0 100644
> > > --- a/http.c
> > > +++ b/http.c
> > > @@ -725,13 +725,13 @@ static CURL *get_curl_handle(void)
> > >  	curl_easy_setopt(result, CURLOPT_POST301, 1);
> > >  #endif
> > >  #if LIBCURL_VERSION_NUM >= 0x071304
> > > -	if (is_transport_allowed("http"))
> > > +	if (is_transport_allowed("http", 0))
> > >  		allowed_protocols |= CURLPROTO_HTTP;
> > > -	if (is_transport_allowed("https"))
> > > +	if (is_transport_allowed("https", 0))
> > >  		allowed_protocols |= CURLPROTO_HTTPS;
> > > -	if (is_transport_allowed("ftp"))
> > > +	if (is_transport_allowed("ftp", 0))
> > >  		allowed_protocols |= CURLPROTO_FTP;
> > > -	if (is_transport_allowed("ftps"))
> > > +	if (is_transport_allowed("ftps", 0))
> > >  		allowed_protocols |= CURLPROTO_FTPS;
> > >  	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS, allowed_protocols);
> > >  #else
> > 
> > This is better, but I think we still need to deal with http-alternates
> > on top.
> > 
> > I think we'd need to move this allowed_protocols setup into a function
> > like:
> > 
> >   int generate_allowed_protocols(int from_user)
> >   {
> > 	int ret;
> > 	if (is_transport_allowed("http", from_user))
> > 		ret |= CURLPROTO_HTTP;
> > 	... etc ...
> > 	return ret;
> >   }
> > 
> > and then create a protocol list for each situation:
> > 
> >   allowed_protocols = generate_allowed_protocols(-1);
> >   allowed_redir_protocols = generate_allowed_protocols(0);
> > 
> > and then we know we can always set up the redir protocols:
> > 
> >   curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS, allowed_redir_protocols);
> > 
> > and which we feed for CURLOPT_PROTOCOLS depends on whether we are
> > following an http-alternates redirect or not. But I suspect it will be a
> > nasty change to plumb through the idea of "this request is on behalf of
> > an http-alternates redirect".
> > 
> > Given how few people probably care, I'm tempted to document it as a
> > quirk and direct people to the upcoming http.followRedirects. The newly
> > proposed default value of that disables http-alternates entirely anyway.
> > 
> > -Peff
> 
> I started taking a look at your http redirect series (I really should
> have taking a look at it sooner) and I see exactly what you're talking
> about.  We can easily move this logic into a function to make it easier
> to generate the two whitelists.

Thinking about this some more...I was told that having http redirect to
file:// could be scary.  The way the new protocol configuration is setup
we have file:// as a default known-safe protocol.  Do we need to worry
about this or can we leave this be since this can be overridden by the
user?

-- 
Brandon Williams
