Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B20CA2022A
	for <e@80x24.org>; Mon,  7 Nov 2016 19:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933181AbcKGTR6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 14:17:58 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33844 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933013AbcKGTR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 14:17:57 -0500
Received: by mail-pf0-f172.google.com with SMTP id n85so94776958pfi.1
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 11:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bvlvFEhXsxVaHfdiaTfri++GNEHCvLPpJjUIiT2f6CE=;
        b=A7my9FSCecT7v/jORMyb/KTTVoKQS9ah3DeAIcQ3raLZNxHPu6oCCgdt7bgYYp10BW
         0o4BSB1wTF4svsoyFxRniLFEYWKXwqJRH1Sypm+KXsVXw4D9S2wndB3sUy/B3jsG3OrN
         /ikvjHhLoiazar08BYnSNCJtDaE6OHo28q5Kh7WwRpCu3GHfmqgqZt4HQonyW6we1oDk
         aBw5pwBvQjO5eLajAwJhLNbSvJClMaZ/Wv5KvOfYzoTuQyjkjgBCcnGMJ07d9vC1SRmP
         e57+zLBoAwLcVfgWFzJQh5teNc5OGFp+u9WJJ3BShhP3wWSh2TSgZ8Eea9iQJRL0g2Vd
         +GNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bvlvFEhXsxVaHfdiaTfri++GNEHCvLPpJjUIiT2f6CE=;
        b=TQ2QRm1y28pzlg7gqqiLfIZNAMaF9/dUZ65V0679dulvrfUq071/ZwV0esQxxzMXMQ
         FJ38jnIO1qUnSxhA8Tr0vuTrKNIDMBJs/6uHAw3wUAGvElzTXT3djc+C7mge8HoDGo/f
         V1t9iqrihu6HF5T5JyBXaOMA6ThokSM8z62MIAhexMcWLXn4RUy0xVxmjxjnUYQFJ8yg
         6sr/6lAuLGP8strsSco+7RnBExJpk95p4Gldg/ostICsRljwDupy/ho4rdvFbf5fmapT
         Um6iL2cz6i39L8SA4fCOsmiKLHJhn/g1fvXtIt9NGEZ7HOPEDKEkEF7jqNCwvx1+evKc
         fzWA==
X-Gm-Message-State: ABUngvfw27igNHTZ0HV2nXbVLKS0PqQt1tyhu4SGA22AGNCSxeOdE7brsKe/X28jr6BCsdnH
X-Received: by 10.98.211.67 with SMTP id q64mr15999631pfg.173.1478546276254;
        Mon, 07 Nov 2016 11:17:56 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:bd82:3124:1b9:77b4])
        by smtp.gmail.com with ESMTPSA id e1sm42480901pap.11.2016.11.07.11.17.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 07 Nov 2016 11:17:55 -0800 (PST)
Date:   Mon, 7 Nov 2016 11:17:54 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v3] transport: add protocol policy config option
Message-ID: <20161107191754.GB143723@google.com>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <1478292933-7873-1-git-send-email-bmwill@google.com>
 <20161104230613.epbziphiqyl57bcn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161104230613.epbziphiqyl57bcn@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/04, Jeff King wrote:
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 27069ac..5d845c4 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -2308,6 +2308,31 @@ pretty.<name>::
> >  	Note that an alias with the same name as a built-in format
> >  	will be silently ignored.
> >  
> > +protocol.allow::
> > +	If set, provide a user defined default policy for all protocols which
> > +	don't explicitly have a policy (protocol.<name>.allow).  By default,
> > +	if unset, known-safe protocols (http, https, git, ssh, file) have a
> > +	default policy of `always`, known-dangerous protocols (ext) have a
> > +	default policy of `never`, and all other protocols have a default policy
> > +	of `user`.  Supported policies:
> > ++
> > +--
> > +
> > +* `always` - protocol is always able to be used.
> > +
> > +* `never` - protocol is never able to be used.
> > +
> > +* `user` - protocol is only able to be used when `GIT_PROTOCOL_FROM_USER` is
> > +  either unset or has a value of 1.  This policy should be used when you want a
> > +  protocol to be usable by the user but don't want it used by commands which
> > +  execute clone/fetch/pull commands without user input, e.g. recursive
> > +  submodule initialization.
> 
> Makes sense. I wonder if it would be good to emphasize _directly_ usable
> here. I.e., "...when you want a protocol to be directly usable by the
> user but don't want...".
> 
> Should clone/fetch/pull also include push?

You're right, that should really have been clone/fetch/push.

> 
> > +protocol.<name>.allow::
> > +	Set a policy to be used by protocol <name> with clone/fetch/pull commands.
> > +
> 
> Nice that this matches protocol.allow, so we don't need to re-explain
> that.
> 
> Should the list of protocols be here? I know they're covered under
> GIT_ALLOW_PROTOCOL already, but if this is the preferred system, we
> should probably explain them here, and then just have GIT_ALLOW_PROTOCOL
> refer the user.

Right now the list of protocols under GIT_ALLOW_PROTOCOL looks like it
has a bit more documentation with how the colon list works.  The
protocols are also mentioned above with their default behaviour.

> 
> > diff --git a/Documentation/git.txt b/Documentation/git.txt
> > index ab7215e..ab25580 100644
> > --- a/Documentation/git.txt
> > +++ b/Documentation/git.txt
> > @@ -1150,13 +1150,13 @@ of clones and fetches.
> >  	cloning a repository to make a backup).
> >  
> >  `GIT_ALLOW_PROTOCOL`::
> > -	If set, provide a colon-separated list of protocols which are
> > -	allowed to be used with fetch/push/clone. This is useful to
> > -	restrict recursive submodule initialization from an untrusted
> > -	repository. Any protocol not mentioned will be disallowed (i.e.,
> > -	this is a whitelist, not a blacklist). If the variable is not
> > -	set at all, all protocols are enabled.  The protocol names
> > -	currently used by git are:
> > +	The new way to configure allowed protocols is done through the config
> > +	interface, though this setting takes precedences.  See
> > +	linkgit:git-config[1] for more details.  If set, provide a
> > +	colon-separated list of protocols which are allowed to be used with
> > +	fetch/push/clone.  Any protocol not mentioned will be disallowed (i.e.,
> > +	this is a whitelist, not a blacklist).  The protocol names currently
> > +	used by git are:
> 
> I wonder if we can explain this in terms of the config system. Something
> like:
> 
>   If set to a colon-separated list of zero or more protocols, behave as
>   if `protocol.allow` is set to `never`, and each of the listed
>   protocols has `protocol.$protocol.allow` set to `always`.

Yeah that makes sense.

> 
> > +`GIT_PROTOCOL_FROM_USER`::
> > +	Set to 0 to prevent protocols used by fetch/push/clone which are
> > +	configured to the `user` state.  This is useful to restrict recursive
> > +	submodule initialization from an untrusted repository.  See
> > +	linkgit:git-config[1] for more details.
> 
> Under "this is useful", it may make sense to make it clear that external
> programs can use this, too. Something like:
> 
>   It may also be useful for programs which feed potentially-untrusted
>   URLs to git commands.

I'll put that in too.

> 
> > diff --git a/t/lib-proto-disable.sh b/t/lib-proto-disable.sh
> > index b0917d9..5950fbf 100644
> > --- a/t/lib-proto-disable.sh
> > +++ b/t/lib-proto-disable.sh
> > @@ -1,15 +1,12 @@
> >  # Test routines for checking protocol disabling.
> >  
> > -# test cloning a particular protocol
> > -#   $1 - description of the protocol
> > -#   $2 - machine-readable name of the protocol
> > -#   $3 - the URL to try cloning
> > -test_proto () {
> > +# Test clone/fetch/push with GIT_ALLOW_PROTOCOL whitelist
> > +test_whitelist () {
> >  	desc=$1
> >  	proto=$2
> >  	url=$3
> >  
> > -	test_expect_success "clone $1 (enabled)" '
> > +	test_expect_success "clone $desc (enabled)" '
> 
> Yeah, this should have been $desc all along. It makes the diff really
> noisy, though. Should it be split out into a preparatory change?

I'll pull it out to make the patch a bit cleaner.

-- 
Brandon Williams
