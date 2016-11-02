Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45AC420193
	for <e@80x24.org>; Wed,  2 Nov 2016 23:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932221AbcKBXdI (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 19:33:08 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35225 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756299AbcKBXdH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 19:33:07 -0400
Received: by mail-pf0-f170.google.com with SMTP id i88so19714226pfk.2
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 16:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ktt9B/bCIfQsANK/VAqB/uFz84cLCOxDKknJeOSc1wU=;
        b=dGWg6wBjt1EvUt4nCwHlS3CAbhm3DS8ObMTU/Qm10mRTFxc4gyj3aVmK9+Xi2zsvId
         5z0a1zQJfGPArxmLHXuw+shUt/NyqVLYgSVtyvfjKwR3XJ8tVKu7UHyh/Yl+k7r4dscn
         R/yjTt6FTfryTxDAzxLcTMHY8xUNRpjabv8w3IKoZcggThhv3a+JGeTkuNooGoLYJi2d
         h9LuIYd4hfVQdGyp8H1qMhdD/kN0PB/vkz63uehRc7t9k/bMVBKDKLh+a+OxtHj6T2Np
         j5a4RyKzM4aPxKl+XuGubX9OJEJjrxawjq72Tr6SF8wD8iBnttJLGMnlTqNyv//jnqnf
         2l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ktt9B/bCIfQsANK/VAqB/uFz84cLCOxDKknJeOSc1wU=;
        b=YW9TnIJh3jemhVbEanlEVVFgleid2B8xWcE3DXOULiRfzm9vRKQrKKMXMxsP1/a6zi
         LYP8Nlmy8A9VMfH+981tksQUAaj9K2HWbjxGXfsqk1HOrNMnbdSYjFqBmPctgDBbBojt
         sIXY4+dZvjNqoACtghwjQKOhC3aTlJINtpHXvi45pkQpHjcY6A4ckRWtRjyufybsI608
         Ehwc/gFL4pQNB64BOLXGMH4HhzPpLVDNQlQDpLMP5awn2zcPLgt0OkdQ2JJE1OFyegmV
         aIYxkjhxLI9UhweTO7V3IG5RM1Ep+MBu/6oo54/ylPtdjfdVhuyJyxCbl3tjnouzP+MX
         ghJA==
X-Gm-Message-State: ABUngveqUYEn/+yS9toifSjE3tERTpPnQin0/PCbnO6+25nNjNOGiIIuwc6+1XxeHewzJeOG
X-Received: by 10.99.112.5 with SMTP id l5mr9549091pgc.40.1478129586262;
        Wed, 02 Nov 2016 16:33:06 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:8080:eeb8:e27c:9538])
        by smtp.gmail.com with ESMTPSA id a7sm7270947pan.34.2016.11.02.16.33.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Nov 2016 16:33:05 -0700 (PDT)
Date:   Wed, 2 Nov 2016 16:33:04 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH] transport: add core.allowProtocol config option
Message-ID: <20161102233304.GB183367@google.com>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <20161102230538.jx3jwa4hqgrrltno@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161102230538.jx3jwa4hqgrrltno@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/02, Jeff King wrote:
> On Wed, Nov 02, 2016 at 03:20:47PM -0700, Brandon Williams wrote:
> 
> > Add configuration option 'core.allowProtocol' to allow users to create a
> > whitelist of allowed protocols for fetch/push/clone in their gitconfig.
> > 
> > For git-submodule.sh, fallback to default whitelist only if the user
> > hasn't explicitly set `GIT_ALLOW_PROTOCOL` or doesn't have a whitelist
> > in their gitconfig.
> 
> This says "what", but not "why". What's the use case?
> 
> I can see somebody wanting to pare down the whitelist further (e.g.,
> because they are carrying ssh credentials that they don't want to use on
> behalf of a malicious repo). But in general I'd expect this setting to
> be a function of the environment you're operating in, and not the
> on-disk config.
> 
> Or is the intent to broaden it for cases where you have a clone that
> uses some non-standard protocol, and you want it to Just Work on
> subsequent recursive fetches?
> 
> > +core.allowProtocol::
> > +	Provide a colon-separated list of protocols which are allowed to be
> > +	used with fetch/push/clone. This is useful to restrict recursive
> > +	submodule initialization from an untrusted repository. Any protocol not
> > +	mentioned will be disallowed (i.e., this is a whitelist, not a
> > +	blacklist). If the variable is not set at all, all protocols are
> > +	enabled. If the `GIT_ALLOW_PROTOCOL` enviornment variable is set, it is
> > +	used as the protocol whitelist instead of this config option.
> 
> The "not set at all, all protocols are enabled" bit is not quite
> correct, is it? It is true for a top-level fetch, but not for submodule
> recursion (and especially since you are talking about submodule
> recursion immediately before, it is rather confusing).

Yeah stefan mentioned this to me.  I simply copied the documentaion from
GIT_ALLOW_PROTOCOL, perhaps that should be updated as well?

> 
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -27,7 +27,8 @@ cd_to_toplevel
> >  #
> >  # If the user has already specified a set of allowed protocols,
> >  # we assume they know what they're doing and use that instead.
> > -: ${GIT_ALLOW_PROTOCOL=file:git:http:https:ssh}
> > +config_whitelist=$(git config core.allowProtocol)
> > +: ${GIT_ALLOW_PROTOCOL=${config_whitelist:-file:git:http:https:ssh}}
> 
> The original uses "=" without a ":" so that an empty variable takes
> precedence over the stock list (i.e., allowing nothing). Would you want
> the same behavior for the config variable? I.e.:
> 
>   # this should probably allow nothing, right?
>   git config core.allowProtocol ""
> 
> I think you'd have to check the return code of "git config" to
> distinguish those cases.

Oh, I didn't think of that case.  That can be done easy enough, just
makes the code a bit more verbose.

> 
> > diff --git a/transport.c b/transport.c
> > index d57e8de..b1098cd 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -652,7 +652,7 @@ static const struct string_list *protocol_whitelist(void)
> >  
> >  	if (enabled < 0) {
> >  		const char *v = getenv("GIT_ALLOW_PROTOCOL");
> > -		if (v) {
> > +		if (v || !git_config_get_value("core.allowProtocol", &v)) {
> >  			string_list_split(&allowed, v, ':', -1);
> >  			string_list_sort(&allowed);
> >  			enabled = 1;
> 
> I thought at first we'd have to deal with leaking "v", but "get_value"
> is the "raw" version that gives you the uninterpreted value. I think
> that means it may give you NULL, though if we see an implicit bool like:
> 
>   [core]
>   allowProtocol
> 
> That's nonsense, of course, but we would still segfault. I
> think the easiest way to test is:
> 
>   git -c core.allowProtocol fetch
> 
> which seems to segfault for me with this patch.

what is the desired behavior when a user provides a config in a way that
isn't intended?

-- 
Brandon Williams
