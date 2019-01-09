Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95B371F803
	for <e@80x24.org>; Wed,  9 Jan 2019 18:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfAISzu (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 13:55:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34290 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfAISzu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 13:55:50 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so3995721plz.1
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 10:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EVfK52I7SXG25IvRcE3gtVPfAra1zI7INzwYCQwP7uk=;
        b=S5q7WLTyq7Bma0TJ77PYrXJAenAlCksdUF+6W5/N47eFTU/6TM3RGvIYVTNrx0H+oi
         pxXyvobqp7WNxjARyQW6VnnR9GcIOiHJZw42XlXT7TLh2YEQMT0r/psHMiQ2oGk2c6X0
         6lYjRjAwFSj3boLbsbmPw6aJSi9Ef15M3pxJyczDEDBvYk3hZG33pxCwe5s0lnIE4Ig2
         2IQUx2Wq1nw/ryZBgNC08H9W+LQoVdFRqLSURqEG2ipqiBWeTHd02ld0C+2oRi8GLxOv
         1mEpHxDCuGudK6QV68rhee2XFtTvPBiMp5nKCvlj65ClILTgPAgO0QIdh2mi5CgeKqOq
         KkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=EVfK52I7SXG25IvRcE3gtVPfAra1zI7INzwYCQwP7uk=;
        b=qTRDCRNZ7kAQMzWqJgXY9isYz/qfFAqJaT3CIpwvJ9fkIbc9OIEUFiKtY+7uIbIUCr
         P2PJtD2NZNnF4kYzQpywaT9Nxkpk1SvLqNfbOZ93oDaipkxdxvFaokLNugOVCmGBfBNL
         KXq7SM+TuCHkPICaMZ/OrO/1jwAlloWNW9aX6bC1EH5H2IhyzXHSZECV3gE+t1s7ghCJ
         qVZqubNwx3Zh/7WdS5HzOdofC4tWPjHjtZAWQTDrX9HXSI6JOva5hMpNRwb/DM7OTeT6
         /uCTS95r9qmxziGz8h314/eBrh9hs0fIZvFbkGqRpjQ0o7tjdC7IlYh9gv9kLrO4CJzb
         98yw==
X-Gm-Message-State: AJcUukfZOpiQ6u0FCF4ZhJydpAH7sHfDuGydEM0YLaeaMOP49OET0zER
        ELQDBPxnwS3AZECIaI8Oer3Igg==
X-Google-Smtp-Source: ALg8bN6PWX2yZH1aceb1KBo6beOt7jW83wNUZ+geRvbUbHQK9Mcy2WThsqYUMSXIucqMmxrYGUbDig==
X-Received: by 2002:a17:902:6946:: with SMTP id k6mr7332064plt.101.1547060149013;
        Wed, 09 Jan 2019 10:55:49 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id w23sm22226541pgc.72.2019.01.09.10.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 10:55:47 -0800 (PST)
Date:   Wed, 9 Jan 2019 10:55:43 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 1/1] filter-options: Expand abbreviated numbers
Message-ID: <20190109185543.GD54613@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com
References: <cover.1545261186.git.steadmon@google.com>
 <cover.1546906008.git.steadmon@google.com>
 <d35827de35d2a158cd5325569eaaf355563bf028.1546906008.git.steadmon@google.com>
 <20190109122342.GF4673@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190109122342.GF4673@szeder.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.01.09 13:23, SZEDER Gábor wrote:
> On Mon, Jan 07, 2019 at 04:17:09PM -0800, Josh Steadmon wrote:
> > diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> > index 5285e7674d..9efb3e9902 100644
> > --- a/list-objects-filter-options.c
> > +++ b/list-objects-filter-options.c
> 
> > @@ -111,6 +112,21 @@ int opt_parse_list_objects_filter(const struct option *opt,
> >  	return parse_list_objects_filter(filter_options, arg);
> >  }
> >  
> > +void expand_list_objects_filter_spec(
> > +	const struct list_objects_filter_options *filter,
> > +	struct strbuf *expanded_spec)
> > +{
> > +	strbuf_init(expanded_spec, strlen(filter->filter_spec));
> > +	if (filter->choice == LOFC_BLOB_LIMIT)
> > +		strbuf_addf(expanded_spec, "blob:limit=%lu",
> > +			    filter->blob_limit_value);
> > +	else if (filter->choice == LOFC_TREE_DEPTH)
> > +		strbuf_addf(expanded_spec, "tree:%lu",
> > +			    filter->tree_exclude_depth);
> > +	else
> > +		strbuf_addstr(expanded_spec, filter->filter_spec);
> > +}
> > +
> 
> All compilers error out with something like this:
> 
>   list-objects-filter-options.c: In function
>   ‘expand_list_objects_filter_spec’:
>   list-objects-filter-options.c:124:29: error: ‘LOFC_TREE_DEPTH’ undeclared (first use in this function); did you mean ‘LOFC_TREE_NONE’?
>     else if (filter->choice == LOFC_TREE_DEPTH)
>                                ^~~~~~~~~~~~~~~
>                                LOFC_TREE_NONE
>   list-objects-filter-options.c:124:29: note: each undeclared identifier is reported only once for each function it appears in
>   list-objects-filter-options.c:126:14: error: ‘const struct list_objects_filter_options’ has no member named ‘tree_exclude_depth’
>           filter->tree_exclude_depth);
>                 ^~
>   make: *** [list-objects-filter-options.o] Error 1
> 

Hmm, looks like you may not have applied this on top of
md/list-objects-filter-by-depth? However, the most recent version of
that branch has its own compilation errors at the moment.
