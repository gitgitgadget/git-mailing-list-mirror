Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FC3A1F461
	for <e@80x24.org>; Thu, 16 May 2019 21:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfEPVGF (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 17:06:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45238 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfEPVGF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 17:06:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id i21so2134276pgi.12
        for <git@vger.kernel.org>; Thu, 16 May 2019 14:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XQ9LXzMD1rqsHBhDBACt9knvR9VvhGq8n+y+JXCvquU=;
        b=PsxdkVFG+nbCfj2YfOlCDbKILr7qLFjmg3suZUGJe+qwIxkYiKMpwDxC9zW0WsRLoB
         V1foHBFrvbw9ICCnyv8IDj0RPmEoODoDI8hVQ7doqqjPx3ULEz/Rbv9t0tUZr8Qf5gHv
         AjkQAbNjLR+lYUyIUMQDkGXV/6LKLCnBM5MZ2bjnubPoJUv9zS/7wQuHUavFgq9CYUYS
         Vq0bRFg9MAUu3PWGuNdsGqg1Vc5V9qeFkEw9hc1RrAdblO2o45Z7duAbCd8EyBLokTA5
         onVliv8feApXLonbN/PBjDxRS+HoFihOZdaQBdDdN9Y3/TngdMR904XErKUQbGmuFrH6
         O/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XQ9LXzMD1rqsHBhDBACt9knvR9VvhGq8n+y+JXCvquU=;
        b=k+tEaoeZJcUMrRfhP3IpQZr9srWuyrajHgu02l7r3xkRnsw6hu7gzEO6RAckbCWOED
         WRaUoc4z0kJ4NTyApxVgXNzQWs9M7qh465rVMC4Wzl4B8xbexSxyaljTxpWejCSGla/X
         tJiFbH4S//nOAE2me/HTWTDGJCzwdFEfF0dXuQmAEBZdcTL/w/Go08uOjqQFMGrjYjKm
         Q4NkGd7KyP2PEDN4sEXqfeqmaeyAWnBSwjf0l2CUqFviyBZKujhzL8S8DpPD1RbeKXGt
         gHfr1ohN1C8upIgLeLgfBpkKwa4RY2vCHSgeAdXmUUUS1MlYDIW4xrjZti6pJyJ+ejOY
         +yNQ==
X-Gm-Message-State: APjAAAUmDxAVcsZoGzBXnhVDiFWPZnpsACHRGGToznxVHYeKaAzcLqPa
        AnquyWu+/jeijF0xOq8fIWteUy8c/EetLA==
X-Google-Smtp-Source: APXvYqxaQGrh/vjSkifZb1vFkbhQ3fhXxi572HqAU/uSsLEozAiyYc+pHaRxkv4HaSd7YQmoi+YXgw==
X-Received: by 2002:a63:6ac1:: with SMTP id f184mr53509338pgc.25.1558040763861;
        Thu, 16 May 2019 14:06:03 -0700 (PDT)
Received: from google.com ([2620:0:100e:903:92a9:af1c:1897:8241])
        by smtp.gmail.com with ESMTPSA id q5sm8115723pfb.51.2019.05.16.14.06.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 14:06:03 -0700 (PDT)
Date:   Thu, 16 May 2019 14:05:58 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] grep: provide sane default to grep_source struct
Message-ID: <20190516210558.GB138048@google.com>
References: <20190516020023.61161-1-emilyshaffer@google.com>
 <20190516022911.GA135875@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516022911.GA135875@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 15, 2019 at 08:11:52PM -0700, Jonathan Nieder wrote:
> Hi,
> 
> Emily Shaffer wrote:
> 
> > grep_buffer creates a struct grep_source gs and calls grep_source()
> > with it. However, gs.name is null, which eventually produces a
> > segmentation fault in
> > grep_source()->grep_source_1()->show_line() when grep_opt.status_only is
> > not set.
> 
> Thanks for catching it.  Taking a step back, I think the problem is in
> the definition of "struct grep_source":
> 
> 	struct grep_source {
> 		char *name;
> 
> 		enum grep_source_type {
> 			GREP_SOURCE_OID,
> 			GREP_SOURCE_FILE,
> 			GREP_SOURCE_BUF,
> 		} type;
> 		void *identifier;
> 
> 		...
> 	};
> 
> What is the difference between a 'name' and an 'identifier'?  Who is
> responsible for free()ing them?  Can they be NULL?  This is pretty
> underdocumented for a public type.
> 
> If we take the point of view that 'name' should always be non-NULL,
> then I wonder:
> 
> - can we document that?
> - can grep_source_init enforce that?

Today grep_source_init() defaults to NULL. So if we decide that 'name'
should be non-NULL it will be somewhat changing the intent.

	void grep_source_init(struct grep_source *gs, enum grep_source_type type,        
	                      const char *name, const char *path,                        
	                      const void *identifier)                                    
	{                                                                                
	        gs->type = type;                                                         
	        gs->name = xstrdup_or_null(name); 
	...

> - can we take advantage of that in grep_source as well, as a sanity
>   check that the grep_source has been initialized?
> - while we're here, can we describe what the field is used for
>   (prefixing output with context before a ":", I believe)?

In general the documentation for grep.[ch] is pretty light. There aren't
any header comments and `Documentation/technical/api-grep.txt` is a
todo. So I agree that we should document it anywhere we can.

> > Jonathan Nieder proposed alternatively adding some check to grep_source()
> > to ensure that if opt->status_only is unset, gs->name must be non-NULL
> > (and yell about it if not), as well as some extra comments indicating
> > what assumptions are made about the data coming into functions like
> > grep_source(). I'm fine with that as well (although I'm not sure it
> > makes sense semantically to require a name which the user probably can't
> > easily set, or else ban the user from printing LOC during grep). Mostly
> > I'm happy with any solution besides a segfault with no error logging :)
> 
> Let's compare the two possibilities.
> 
> The advantage of "(in memory)" is that it Just Works, which should
> make a nicer development experience with getting a new caller mostly
> working on the way to getting them working just the way you want.
> 
> The disadvantage is that if we start outputting that in production, we
> and static analyzers are less likely to notice.  In other words,
> printing "(in memory)" is leaking details to the end user that do not
> match what the end user asked for.  NULL would instead produce a
> crash, prompting the author of the caller to fix it.
> 
> What was particularly pernicious about this example is that the NULL
> dereference only occurs if the grep has a match.  So I suppose I'm
> leaning toward (in addition to adding some comments to document the
> struct) adding a check like
> 
> 	if (!gs->name && !opt->status_only)
> 		BUG("grep calls that could print name require name");
> 
> to grep_source.

Why not both? :)

But seriously, I am planning to push a second patch with both, per
Junio's reply.

I'll consider the documentation out of scope for now since I'm not sure
I know enough about grep.[ch]'s intent or history to document anything
yet. :)

> 
> That would also sidestep the question of whether this debugging aid
> should be translated. :)
> 
> Sensible?
> 
> Thanks,
> Jonathan
