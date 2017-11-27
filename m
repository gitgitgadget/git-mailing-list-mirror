Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E68120C11
	for <e@80x24.org>; Mon, 27 Nov 2017 20:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753248AbdK0U5s (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 15:57:48 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:34604 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753166AbdK0U5r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 15:57:47 -0500
Received: by mail-wr0-f177.google.com with SMTP id k18so22833669wre.1
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 12:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IyN1lz5Ph0xdaV7rlUaukA7KVAgy0rXHBbKejanlr2Y=;
        b=mGKbsOnGWQeVdoGGTrNR9m7/Ese2p3N5sZxGXEyNxvbrmZH5Jq9il7dJgG24G9RvMQ
         qvlu8p9txmRY/c962rLSB9dmzAGXB4fED3leXgGPc8n4G/6mlTJhKBW2qO9RQIRa28Gu
         RisZPEb1PfalYmkt8rLjzYakyWNmQwRPlPMaS5JXNi1RxTWVoSXeFrXIZSVwtUyOe7zZ
         fB0+6uyaQ97Tt5eNlWrMHluRJI7/9Qoo4F04+jMB70qFF4SSE8ekS3wWV1RlyxoxA7xS
         UB//kZRfLJd8oM/g6pQ8hhyyDtrEVlJQ+G/50+FDmBHigFtYNTdw0I5o/6Xc6JCpRfnh
         5/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IyN1lz5Ph0xdaV7rlUaukA7KVAgy0rXHBbKejanlr2Y=;
        b=sDrO5suc56EeRC8PkdmdipWZwxIVvaiAZ5bO8kb8MBWeujmN1oYfUXDLYs48rOmn8c
         +GprbCA0jDw3NDWelKzptrtsv+rVl90XwhJuQaVhD4Fnvd1Yz/hL+dfjrTKMdKvzGbB5
         RPF+rQKh4u9Mj4m66Gs9yEpEI467jEzVLLSgFICWa3pokxa22MHASDAOpTpovNSFUvpY
         8ytIMf0YmxuQ4BQMzSL9ZVRh90WRtdJ2dDBaFYtMa40NVoK0p4nI0jxb6uAOxqjnlc7l
         KaINTaIZhrV4Erq/wYleHvOadmlLXob1zA+xpuw3wm8in4axJGDEb7DniMSsUl9p78F6
         rvGA==
X-Gm-Message-State: AJaThX5WXfBfbxqYEDH7w2UjuN95kJGbOcZFIR/kgVihuthyL9XLqd0Q
        gjIpVNj9zkuDYInYNyYZVlrflRhy
X-Google-Smtp-Source: AGs4zMYtpl3uFkMHH7DGGxEld4JeccstPHL5JqY8cY18JOypPL9++GclXYcTPq1aAJy1IwXTpGE7nA==
X-Received: by 10.223.150.163 with SMTP id u32mr33313634wrb.157.1511816266366;
        Mon, 27 Nov 2017 12:57:46 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id j10sm15509669wrh.32.2017.11.27.12.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Nov 2017 12:57:45 -0800 (PST)
Date:   Mon, 27 Nov 2017 20:59:18 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Paul Smith <paul@mad-scientist.net>
Subject: Re: [PATCH v5 6/6] add worktree.guessRemote config option
Message-ID: <20171127205918.GB32057@hank>
References: <20171122223020.2780-1-t.gummerer@gmail.com>
 <20171126194356.16187-1-t.gummerer@gmail.com>
 <20171126194356.16187-7-t.gummerer@gmail.com>
 <xmqq8tescj9p.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8tescj9p.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/27, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > +worktree.guessRemote::
> > +	With `add`, if no branch argument, and neither of `-b` nor
> > +	`-B` nor `--detach` are given, the command defaults to
> > +	creating a new branch from HEAD.  If `worktree.guessRemote` is
> > +	set to true, `worktree add` tries to find a remote-tracking
> > +	branch whose name uniquely matches the new branch name.  If
> > +	such a branch exists, it is checked out and set as "upstream"
> > +	for the new branch.  If no such match can be found, it falls
> > +	back to creating a new branch from the current HEAD.
> 
> Unlike the part I commented on in the previous step, this one is
> clear that the feature only kicks in for 'add <path>' without
> anything else, which is good.
> 
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > index 15cb1600ee..426aea8761 100644
> > --- a/builtin/worktree.c
> > +++ b/builtin/worktree.c
> > @@ -33,8 +33,19 @@ struct add_opts {
> >  
> >  static int show_only;
> >  static int verbose;
> > +static int guess_remote;
> >  static timestamp_t expire;
> >  
> > +static int git_worktree_config(const char *var, const char *value, void *cb)
> > +{
> > +	if (!strcmp(var, "worktree.guessremote")) {
> > +		guess_remote = git_config_bool(var, value);
> > +		return 0;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> 
> It is a lot more consistent with the established practice if this
> function had
> 
> 	return git_default_config(var, value, cb);
> 
> instead of "return 0" at the end, and then have the call to
> 
> 	git_config(git_default_config, NULL);
> 
> we have in cmd_worktree() replaced with
> 
> 	git_config(git_worktree_config, NULL);
> 
> That would avoid having to scan the entire set of config keys once
> in cmd_worktree() and then again in add(), the latter one only
> looking for a single variable.

Makes sense, I missed that.  I'll fix it in the re-roll.  I'll wait a
few days to see if there are any more comments on the series and then
re-roll it with the suggested changes.

Thanks for the review!
