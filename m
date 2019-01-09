Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4557A1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 19:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfAITUH (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 14:20:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46072 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfAITUG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 14:20:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so8785244wrr.12
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 11:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=h4VXjCT4Z7YBTnwhmeSAHQqNK5yzAYsgW4k4h2C5cWE=;
        b=se3cgmyfRAzvfI63CAQYe3Q1422VtqWp3bj7nfFS7LyRQYb/A9YWpFf9G9U3a5LzKY
         30hDXS03/+64wtTJ5n/Qe5IwymLSX4umFJkOrxDtZoixbZyeiB4HhjP+ONF/crfzwhQ+
         Rne8fa7MEgEYuym64rKH4ryQek/XVhF3/4Gg66K3wmYL1v4lpsCljNq+8zwnWI1buzB9
         jpd1EqQZWWlZ/4FNPIi3cY2yV6BwLNlMRHBv0vlZsdCfLunTBFHn/17M+pbXTQtG+8yD
         WbLmPQ9R3udzAWFQrACddN+PeRiH9xZJRUogerNiG0lJc1T+ka+A5SdCf1uHHc1L4zoi
         C7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=h4VXjCT4Z7YBTnwhmeSAHQqNK5yzAYsgW4k4h2C5cWE=;
        b=SUUrLZYKWpAQkzgDvgNnEYUFOek7yqqLQcNXpjhTX3g27G9lg8T3GZfRpa2NobUU2u
         xC78xM4ZjPQp5hzqYx+jOQQ33a/uL5LPfUm8k3ZksGivmghpNXuNjuiraQMA6kyhJVLz
         w7kRnQokmwHetxTvB8r7VsQ4WlRXwUblV6ulDZ14lw2N3fWOH5Y8BXXuKvnI9R92dVwL
         nMofBO5WEiWZxnTT2T9bimr6u+8QAzj/pnxbBja5HInuvO4QyE4qPO5DIby/E7/BiNqy
         jGkwU0EyBe+R7Uq/rlkvIjSUtMZJDjDE6/qmpgBM6kMoxxCKLelsIn9AknXVmdpMF2lY
         wV/g==
X-Gm-Message-State: AJcUukeFYvHMtj96ZRwccAf0zLxkx/igs6/xEFpyDY/RlQmPainEfuiP
        S+DNfLFRtCkz9Vw+/O1HZug=
X-Google-Smtp-Source: ALg8bN4u7ziyOLDi5paPggr1FtL66lTIEb/++wHVs24dEB8hPe9bl0ooVB9wGuuGLyv5ftQ4PZd1DA==
X-Received: by 2002:a5d:40c1:: with SMTP id b1mr6520647wrq.133.1547061604819;
        Wed, 09 Jan 2019 11:20:04 -0800 (PST)
Received: from szeder.dev (x4db906b6.dyn.telefonica.de. [77.185.6.182])
        by smtp.gmail.com with ESMTPSA id j3sm14485941wmb.39.2019.01.09.11.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 11:20:03 -0800 (PST)
Date:   Wed, 9 Jan 2019 20:20:01 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v2 1/1] filter-options: Expand abbreviated numbers
Message-ID: <20190109192001.GK4673@szeder.dev>
References: <cover.1545261186.git.steadmon@google.com>
 <cover.1546906008.git.steadmon@google.com>
 <d35827de35d2a158cd5325569eaaf355563bf028.1546906008.git.steadmon@google.com>
 <20190109122342.GF4673@szeder.dev>
 <20190109185543.GD54613@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190109185543.GD54613@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 09, 2019 at 10:55:43AM -0800, Josh Steadmon wrote:
> On 2019.01.09 13:23, SZEDER Gábor wrote:
> > On Mon, Jan 07, 2019 at 04:17:09PM -0800, Josh Steadmon wrote:
> > > diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> > > index 5285e7674d..9efb3e9902 100644
> > > --- a/list-objects-filter-options.c
> > > +++ b/list-objects-filter-options.c
> > 
> > > @@ -111,6 +112,21 @@ int opt_parse_list_objects_filter(const struct option *opt,
> > >  	return parse_list_objects_filter(filter_options, arg);
> > >  }
> > >  
> > > +void expand_list_objects_filter_spec(
> > > +	const struct list_objects_filter_options *filter,
> > > +	struct strbuf *expanded_spec)
> > > +{
> > > +	strbuf_init(expanded_spec, strlen(filter->filter_spec));
> > > +	if (filter->choice == LOFC_BLOB_LIMIT)
> > > +		strbuf_addf(expanded_spec, "blob:limit=%lu",
> > > +			    filter->blob_limit_value);
> > > +	else if (filter->choice == LOFC_TREE_DEPTH)
> > > +		strbuf_addf(expanded_spec, "tree:%lu",
> > > +			    filter->tree_exclude_depth);
> > > +	else
> > > +		strbuf_addstr(expanded_spec, filter->filter_spec);
> > > +}
> > > +
> > 
> > All compilers error out with something like this:
> > 
> >   list-objects-filter-options.c: In function
> >   ‘expand_list_objects_filter_spec’:
> >   list-objects-filter-options.c:124:29: error: ‘LOFC_TREE_DEPTH’ undeclared (first use in this function); did you mean ‘LOFC_TREE_NONE’?
> >     else if (filter->choice == LOFC_TREE_DEPTH)
> >                                ^~~~~~~~~~~~~~~
> >                                LOFC_TREE_NONE
> >   list-objects-filter-options.c:124:29: note: each undeclared identifier is reported only once for each function it appears in
> >   list-objects-filter-options.c:126:14: error: ‘const struct list_objects_filter_options’ has no member named ‘tree_exclude_depth’
> >           filter->tree_exclude_depth);
> >                 ^~
> >   make: *** [list-objects-filter-options.o] Error 1
> > 
> 
> Hmm, looks like you may not have applied this on top of
> md/list-objects-filter-by-depth? However, the most recent version of
> that branch has its own compilation errors at the moment.

Ah, OK.  I didn't actually apply this patch anywhere, I just tried to
test this topic as it is in 'pu', where it branches off from current
'master'.

