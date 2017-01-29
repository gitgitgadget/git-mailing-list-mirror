Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85EFD1F6DC
	for <e@80x24.org>; Sun, 29 Jan 2017 13:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751176AbdA2NiL (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jan 2017 08:38:11 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36318 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbdA2NiK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2017 08:38:10 -0500
Received: by mail-wm0-f65.google.com with SMTP id r126so70796238wmr.3
        for <git@vger.kernel.org>; Sun, 29 Jan 2017 05:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ARtG78sB0UMOzdKxDX+pHinLZJAoNyjR1w91/Vq+9yg=;
        b=r5eLqBzbYK0rD33SYP2Cq6CGUp6f2n2XG3c8Z9o/Qu5UW67K+7q2yjlIqgvfNX8omm
         57PQUglHDKJNVMnP7yOjvj9lUDFXzQ2yUp/Gq63eIoGtz2TUbGSzL4eW4j9O7wSVuZt5
         llj5KuRzfn5RbahpnATM8MPNGQxoBIZXXtPy790r7zEWfzkEV6dCvaHmuBvPW721+D2t
         C3u2QMC4r/zoh3VDZyrsQCs8UUuv2D/H+4yTURrMenzl5ObIx7dQ7uG+MH2r847ZtHmE
         KR0GdJ7bioe8ghaCYyyXumH+kYepTQXK79tePDltZ8Np2jf8RVzPPb5J2GBPPGyTj8CO
         poJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ARtG78sB0UMOzdKxDX+pHinLZJAoNyjR1w91/Vq+9yg=;
        b=rKQ/h+RoQYtNkOd9HreSgLVC3OmJqYO846hOwMawt46ERf9Baq5We7Evi7M9rg0301
         lFZKUWFHnEFffmnFNqu74wnQyNspcYeuWqRgZmAG8J/oBWWfdEeaVVxYLyedUCOwu9+n
         AwwJqHUcrP6gtHexwj2r9Iq/FboZrNlccvkCyo8fZGkylGc/iYb4D3ZyS8o5qEP5SZpO
         lGTmF+U0j1FA0BEQaA37ALJ9uIQwzN8hrs//LI7gUcUodee4OwPCJSw7vnysh1H+5te0
         bFmOAB7+TV1hZKdfB8UysO4K4ASaF2ExqKQn/Y0xkQNwgI3CdstHf0gsEq3O6x0X2hBL
         rqGg==
X-Gm-Message-State: AIkVDXJ7FZ0I3kiOHt4czQPwJkLmppViEHKfGLFPK+gcCoOk9fBddnOq1nU683FDmGmPWw==
X-Received: by 10.28.222.11 with SMTP id v11mr9978789wmg.1.1485696546082;
        Sun, 29 Jan 2017 05:29:06 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id e14sm13678084wmd.14.2017.01.29.05.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jan 2017 05:29:05 -0800 (PST)
Date:   Sun, 29 Jan 2017 13:29:26 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] stash: support filename argument
Message-ID: <20170129132926.GD31189@hank>
References: <20170121200804.19009-1-t.gummerer@gmail.com>
 <20170121200804.19009-4-t.gummerer@gmail.com>
 <xmqqinp5sj98.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqinp5sj98.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/23, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > diff --git a/git-stash.sh b/git-stash.sh
> > index d6b4ae3290..7dcce629bd 100755
> > --- a/git-stash.sh
> > +++ b/git-stash.sh
> > @@ -41,7 +41,7 @@ no_changes () {
> >  untracked_files () {
> >  	excl_opt=--exclude-standard
> >  	test "$untracked" = "all" && excl_opt=
> > -	git ls-files -o -z $excl_opt
> > +	git ls-files -o -z $excl_opt -- $1
> 
> Does $1 need to be quoted to prevent it from split at $IFS?

Not sure, I'll check and add a test for the re-roll.

> > @@ -56,6 +56,23 @@ clear_stash () {
> >  }
> >  
> >  create_stash () {
> > +	files=
> > +	while test $# != 0
> > +	do
> > +		case "$1" in
> > +		--)
> > +			shift
> > +			break
> > +			;;
> > +		--files)
> > +			;;
> > +		*)
> > +			files="$1 $files"
> > +			;;
> 
> Hmph.  What is this "no-op" option about?  Did you mean to say
> something like this instead?
> 
> 	case "$1" in
> 	...
> 	--file)
> 		case $# in
> 		1)
> 			die "--file needs a pathspec" ;;
> 		*)
> 			shift
> 			files="$files$1 " ;;
> 		esac
> 		;;
>

Hmm that would require multiple --file arguments to create_stash,
which I wanted to avoid.  But probably the correct solution is to
introduce a new format for create_stash, which allows a -m before the
message, and uses -- to disambiguate before the file name arguments.

This would be similar to what Johannes suggested in [1], deprecating
the old syntax in git stash create.  While this didn't work in git
stash save, it would work in git stash create, as "--" isn't used to
disambiguate anything there yet.

> Another thing I noticed.  We won't support filenames with embedded
> $IFS characters at all?
> 
> I somehow had an impression that the script was carefully done
> (e.g. by using -z option where appropriate) to add such a
> limitation.
> 
> Perhaps we have broken it over time and it no longer matters
> (i.e. there already may be existing breakages), but this troubles
> me somehow.

Good point, I didn't think about $IFS characters.  Fill fix in the
next round.

> By the way, in addition to "push" thing that corrects the argument
> convention by requiring "-m" before the message, we need to correct
> create_stash that is used internally from "stash push" somehow?

Yeah, I think that would make sense, see above.

[1]: http://public-inbox.org/git/alpine.DEB.2.20.1701241148300.3469@virtualbox/
