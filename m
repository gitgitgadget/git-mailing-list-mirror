Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 800121F453
	for <e@80x24.org>; Wed, 26 Sep 2018 18:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeI0AXX (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 20:23:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40350 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbeI0AXX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 20:23:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id s5-v6so6065787pfj.7
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 11:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rY7oqdbhKhFlmkPGbAz7HEnD3L3bZz1/Pc3lpYjN2mM=;
        b=GeYXJhlTX/Jrn/pLfh99nr/KzEX/0u59JgdIHh0zpspNnTKqh4lLCcAzm7WHxqVFS5
         1YIK0DjWihzrOvh1EWdYbkbi1sG/WhZDPAIl18V5xXQAwuXfCp1GMg+8oXN64twZ7rg5
         Z5cwjVMn7vCLoJRTrDcn6AWREYwFG76GtKLKHkHx9K/Ri4M5iK/6YYYtXfYjP/+84aTA
         CQbmx69GjO5ta7dZ1o7ZrarQMPKfeHbNLQsJ0zHlQzWinDzaTFhc70jAI9E8Tut4AfCo
         r/ZD/Sur4v5D5IyXifxh3VcLpM62VrG7KmPL5gVUkYvOfkt9AwIJ/9JEEH+rEm8y7ILb
         BSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rY7oqdbhKhFlmkPGbAz7HEnD3L3bZz1/Pc3lpYjN2mM=;
        b=jBI3jrXdhxFQjKbEymPGuJgmXzn70sR59KspYFSIq8xHxMbRwvoKD4vJK9u+cY8xuA
         H4UV2Ub08H/M88bcb+ZXrTcNzPVuyy+21SELnt87x8rZQOyYKPcXuNNhCHBSGLrksI3g
         954TY02Lz69ml/rCy05p+T+Fh1SWliqbxqeXd7wI8LPRsVb6EaSe3njEVgORUD9b+aGW
         qLkiIwroPMT2niCrbDhx8BcPR9nAl1isD5Bf+lsQXHwHo0wZjiCanDVoy+nIYVwlW8JP
         s/zhJgmiLrshDqgyRcEfl1bQB9+D8zviNDkpVbFE5ZFiCTUPiHnGiO2SITsara8nuhRc
         /T1Q==
X-Gm-Message-State: ABuFfogMT+Ychjdq+rF5NdeLxsVPA2HaAHdMbxyY5dmtNq7Dbf8fo4OO
        3D4KmXCPeS87HBj1jqD/qshM2PGWcANcGw==
X-Google-Smtp-Source: ACcGV61Bk+9FZohDxh2O/9EbvYY+RnNzoep4KpSgtgD6KTuCC+39iucikf5A6btjwpSxnt/vzs3Ujg==
X-Received: by 2002:a62:8d84:: with SMTP id p4-v6mr7420933pfk.251.1537985353648;
        Wed, 26 Sep 2018 11:09:13 -0700 (PDT)
Received: from localhost ([205.175.107.36])
        by smtp.gmail.com with ESMTPSA id g6-v6sm8274732pfb.11.2018.09.26.11.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 11:09:12 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Wed, 26 Sep 2018 11:09:11 -0700
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>, git@vger.kernel.org
Subject: Re: [PATCH] help: allow redirecting to help for aliased command
Message-ID: <20180926180911.GA63889@syl>
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
 <20180926143708.GD25697@syl>
 <xmqqtvmcmg2v.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtvmcmg2v.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 08:30:32AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> +help.followAlias::
> >> +	When requesting help for an alias, git prints a line of the
> >> +	form "'<alias>' is aliased to '<string>'". If this option is
> >> +	set to a positive integer, git proceeds to show the help for
> >
> > With regard to "set to a positive integer", I'm not sure why this is the
> > way that it is. I see below you used 'git_config_int()', but I think
> > that 'git_config_bool()' would be more appropriate.
> >
> > The later understands strings like "yes", "on" or "true", which I think
> > is more of what I would expect from a configuration setting such as
> > this.
>
> That is, as you read in the next paragraph, because it gives the
> number of deciseconds to show a prompt before showing the manpage.
>
> Not that I think this configuration is a good idea (see my review).
>
> >> +	the first word of <string> after the given number of
> >> +	deciseconds. If the value of this option is negative, the
> >> +	redirect happens immediately. If the value is 0 (which is the
> >> +	default), or <string> begins with an exclamation point, no
> >> +	redirect takes place.
> >
> > It was unclear to my originlly why this was given as a configuration
> > knob, but my understanding after reading the patch is that this is to do
> > _additional_ things besides printing what is aliased to what.
> >
> > Could you perhaps note this in the documentation?
>
> It may be that the description for the "execute the likely typoed
> command" configuration is poorly written and this merely copied the
> badness from it.  Over there the prompt gives a chance to ^C out,
> which serves useful purpose, and if that is not documented, we should.
>
> On the other hand, I'd rather see this prompt in the new code
> removed, because I do not think the prompt given in the new code
> here is all that useful.
>
> >> @@ -415,9 +420,34 @@ static const char *check_git_cmd(const char* cmd)
> >>
> >>  	alias = alias_lookup(cmd);
> >>  	if (alias) {
> >> -		printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
> >> -		free(alias);
> >> -		exit(0);
> >> +		const char **argv;
> >> +		int count;
> >> +
> >> +		if (!follow_alias || alias[0] == '!') {
> >> +			printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
> >> +			free(alias);
> >> +			exit(0);
> >> +		}
> >> +		fprintf_ln(stderr, _("'%s' is aliased to '%s'"), cmd, alias);
> >
> > OK, I think that this is a sensible decision: print to STDERR when
> > that's not the main purpose of what're doing (e.g., we're going to
> > follow the alias momentarily), and STDOUT when it's the only thing we're
> > doing.
>
> > Potentially we could call 'fprintf_ln()' only once, and track an `int
> > fd` at the top of this block.
>
> I actually think this should always give the output to standard output.
>
> >> +
> >> +		/*
> >> +		 * We use split_cmdline() to get the first word of the
> >> +		 * alias, to ensure that we use the same rules as when
> >> +		 * the alias is actually used. split_cmdline()
> >> +		 * modifies alias in-place.
> >> +		 */
> >> +		count = split_cmdline(alias, &argv);
> >> +		if (count < 0)
> >> +			die("Bad alias.%s string: %s", cmd,
> >> +			    split_cmdline_strerror(count));
> >
> > Please wrap this in _() so that translators can translate it.
> >
> >> +		if (follow_alias > 0) {
> >> +			fprintf_ln(stderr,
> >> +				   _("Continuing to help for %s in %0.1f seconds."),
> >> +				   alias, follow_alias/10.0);
> >> +			sleep_millisec(follow_alias * 100);
> >> +		}
> >> +		return alias;
> >
> > I'm not sure that this notification is necessary, but I'll defer to the
> > judgement of others on this one.
>
> I didn't bother to check the original but this is mimicking an
> existing code that lets configuration to be set to num-deciseconds
> to pause and give chance to ^C out, and also allows it to be set to
> negative to immediately go ahead.  follow-alias at this point cannot
> be zero in the codeflow, but it still can be negative.

I think that this is the most compelling argument _for_ the configuration
that you are not in favor of. I understood your previous review as "I
know that 'git cp' is a synonym of 'git cherry-pick', but I want to use
'git co --help' for when I don't remember what 'git co' is a synonym
of."

This pause (though I'm a little surprised by it when reviewing the
code), I think strikes a good balance between the two, i.e., that you
can get help for whatever it is aliased to, and see what that alias is.

Thanks,
Taylor
