Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFDCD20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 20:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932069AbdK0UzX (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 15:55:23 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:39102 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753233AbdK0UzW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 15:55:22 -0500
Received: by mail-wm0-f50.google.com with SMTP id x63so37564360wmf.4
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 12:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PtLV3dvyj3r+ONHY4C0ETRFOYVKXrPOw+GLhzaRaiFo=;
        b=pgxLIMYobmiQR4ZukfAOFRoOsC7OpVAAbzuchZ26+mdk9BZuoKY8ekx52GQC9oz6Ik
         uw+8t/t6vOs0GTU3R/cvIcwVwaxZ3NT7yMTEZtF6Ev3SmYwRwaQjdsB+R62PaY67MTM7
         ZSIdXN4PbB2V9OZPZWBFqwCMfWpcz0RtAlpAVUahrNlaeJV3ke/k1o5cXSoKqRE41eiR
         Vfqquv3UqTWalnkppnACxDwHtIORjTxcev7SqY0DbNV1lUNngnuvQ7Sn9tEv1t/ePM2C
         ABp+YDqWkakajP5MfH8QpGji7nbHonVX1DOabF+wluDCPJlo87KMSu9tbm8tt5sqk7AB
         n55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PtLV3dvyj3r+ONHY4C0ETRFOYVKXrPOw+GLhzaRaiFo=;
        b=YvpfYvSXu6udey7NIGd6GAMKciT2wuwvHa9yLlA++gCWZ1fjF/3/N6l0DxJKtox6pz
         ZP0WSgAXU95GP4FRXnJQ2YKgx/OWgEbYi6AepT71Sgz0TDjM5UtYfNqhYl6RiFZyGHWN
         JgYd45C6kW4SKBYlz+z/zmwVb34J01qTZrLpPm4BQ2jtTwbXB5fT0NFTO6ArqJrbTD2G
         +HqBOX54HG5kFFN4Bn8pZZrOlktg6tN/euFF2p0ypw0gAKIz4qp0LvPVij7GPzvU+NCI
         t96cwmwEbFYMP2LJScY8bE1AK7ud3Kh3oHz4JT3Pz+5c+MGPajLzZEZwDA328yOMLj7g
         bqWQ==
X-Gm-Message-State: AJaThX5m/fWQwYw889dUgcvRy//FtfcS30E1qq6eFbY9SBaYJRALZBzm
        bCRypu60X8C7tAqpxAjm6xr0eUQE
X-Google-Smtp-Source: AGs4zMayQ+V1eG4R0BuAdTtgsk4dX56WqHaevXxXkEVgceBvKRrht5SEhrxedrTs4QEw1h0TambXIg==
X-Received: by 10.28.206.8 with SMTP id e8mr16743627wmg.80.1511816121122;
        Mon, 27 Nov 2017 12:55:21 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id l3sm10343227wml.38.2017.11.27.12.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Nov 2017 12:55:20 -0800 (PST)
Date:   Mon, 27 Nov 2017 20:56:53 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Paul Smith <paul@mad-scientist.net>
Subject: Re: [PATCH v5 5/6] worktree: add --guess-remote flag to add
 subcommand
Message-ID: <20171127205653.GA32057@hank>
References: <20171122223020.2780-1-t.gummerer@gmail.com>
 <20171126194356.16187-1-t.gummerer@gmail.com>
 <20171126194356.16187-6-t.gummerer@gmail.com>
 <xmqqd144cjnw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd144cjnw.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/27, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Currently 'git worktree add <path>' creates a new branch named after the
> > basename of the <path>, that matches the HEAD of whichever worktree we
> > were on when calling "git worktree add <path>".
> >
> > It's sometimes useful to have 'git worktree add <path> behave more like
> > the dwim machinery in 'git checkout <new-branch>', i.e. check if the new
> > branch name uniquely matches the branch name of a remote-tracking
> > branch, and if so check out that branch and set the upstream to the
> > remote-tracking branch.
> 
> This paragraph was a bit hard to sympathize because it was not
> obvious that the new feature still assumes how <path> is used to
> compute the name of the new branch.  Perhaps if it were written like
> so:
> 
> 	check if the new branch name, derived from the basename of
> 	the <path>, uniquely matches the branch name of ...
> 
> I would not have had to read it twice to understand what was going
> on.

Sorry about that, will re-phrase.

> > +--[no-]guess-remote::
> > +	With `add`, instead of creating a new branch from HEAD when
> > +	`<commit-ish>` is not given, if there exists a tracking branch
> > +	in exactly one remote matching the basename of the path, base
> > +	the new branch on the remote-tracking branch, and mark the
> > +	remote-tracking branch as "upstream" from the new branch.
> > +
> 
> Would
> 
> 	git worktree add --guess-remote <path> <branch>
> 
> be an error?  It is allowed as long as <branch> and the basename of
> the <path> matches?  The option is silently ignored?  Something
> else?
> 
> I am reacting to "with `add`" part of this desciption.  I wouldn't
> be asking if it said "With `worktree add <path>` without <branch>",
> as that would make the scenario I am wondering about automatically
> "undefined".  Yes, we should strive for leaving things undefined as
> little as practically possible, but at least saying something like
> "without <branch>" explicitly there would make sure that readers
> know in what scenario this option is meant to be used a bit better.

As you mentioned below it's silently ignored.  The main reason for not
erroring out is that it would get a little bit (although not too much)
more annoying once the config variable is introduced.  If it's
strongly preferred to error out when <branch> is given I can change it
to that.

Either way I'll update the documentation.

Thanks!

> > @@ -389,6 +392,13 @@ static int add(int ac, const char **av, const char *prefix)
> >  		int n;
> >  		const char *s = worktree_basename(path, &n);
> >  		opts.new_branch = xstrndup(s, n);
> > +		if (guess_remote) {
> > +			struct object_id oid;
> > +			const char *remote =
> > +				unique_tracking_name(opts.new_branch, &oid);
> > +			if (remote)
> > +				branch = remote;
> > +		}
> >  	}
> 
> I think the answer is "silently ignored", as the above hunk is
> inside "if (ac < 2 && !opts.new_branch && !opts.detach)".
> 
