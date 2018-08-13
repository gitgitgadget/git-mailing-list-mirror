Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8EB21F404
	for <e@80x24.org>; Mon, 13 Aug 2018 17:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbeHMUA3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 16:00:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42850 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbeHMUA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 16:00:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so7948866pff.9
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 10:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kanbXicWxHD5TCrpnM8PRycPdY0xV7G1jMQ5dJDcgT4=;
        b=u8kNCCKfuvSEo0OiUZIzh9yeyRwwaIakkDmZ6rlt2pc2lPdsJL8zf7ZENUFTRZsrZ1
         XB0+NYRnXD+oNVQVyNx/GKlcmBFpXasJd0Hnc0eam6aRL4FncUJ8tjUmhKoFkbxqxljm
         QqI1zYFccnYrO2yEAtKJXoeAIU/aTtkl6mQ+844u2fo/ogRjAuvBKSzbmzZ6X84UIkVo
         tToeDWq2MDdqhs472q0kgE6fIg6WVp4HsXtyXMsCTdedVNcoIKCLLZhGgxQnfLHlEhYQ
         5khtfen7xY4A8KmmMbjKRLRaLNWXfPeSkfa1h1J5zmAhbwIrYuT0DnKnAAtwMREuHcnc
         aKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kanbXicWxHD5TCrpnM8PRycPdY0xV7G1jMQ5dJDcgT4=;
        b=aUp4/zS8lf5cqfXobTCEL5z17qUjYAJAbwSstqmEZU4fq+/8K73M54R7smpfh8BbWv
         Tm/709mCIMkbbp1Ek2L43tsyhBbuw80qJx+e1NO5gvWvTtFUWthOWH6FDXABoUhfwrdo
         AGzRnMzWJG/PcLOENSfSYfZ+a0d706Ruq99B3CHtVkXJSAyMNczT/Qf+1SKkGAxK718G
         5E7iYGVPWDqNhLpp1J0kgG1gcIJv9drl/G8J7c80kCGSsJa50hHNhbal2qLFTsoIaRT8
         uV9GvFqoBk1iTTeZFQ49paKWb65xJARj8fRSw1NUmG5k36TLRs9AFWABDBqZ9PUzMDL7
         Rerg==
X-Gm-Message-State: AOUpUlEe6upy8R9L68XsdMRBb6TkSRIzUN99DjYxvACAuZLzDbPf7dcV
        x8VlxIoB3eQhG7CaPh324ay3fA==
X-Google-Smtp-Source: AA+uWPytmWnHq03P4tIWA7RjtJPyScd6iYLWSsx1y8Elss/gDl3NVJaJUZX8FrK+jh8wIhJ+O1Ds7g==
X-Received: by 2002:a63:4d06:: with SMTP id a6-v6mr17637342pgb.408.1534180640911;
        Mon, 13 Aug 2018 10:17:20 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id t69-v6sm36558607pfj.7.2018.08.13.10.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 10:17:19 -0700 (PDT)
Date:   Mon, 13 Aug 2018 10:17:18 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 05/24] dir.c: remove an implicit dependency on the_index
 in pathspec code
Message-ID: <20180813171718.GB240194@google.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
 <20180813161441.16824-6-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180813161441.16824-6-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/13, Nguyễn Thái Ngọc Duy wrote:
> diff --git a/dir.c b/dir.c
> index 29fbbd48c8..e25aed013b 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -276,12 +276,13 @@ static int do_read_blob(const struct object_id *oid, struct oid_stat *oid_stat,
>  #define DO_MATCH_DIRECTORY (1<<1)
>  #define DO_MATCH_SUBMODULE (1<<2)
>  
> -static int match_attrs(const char *name, int namelen,
> +static int match_attrs(const struct index_state *istate,
> +		       const char *name, int namelen,
>  		       const struct pathspec_item *item)
>  {
>  	int i;
>  
> -	git_check_attr(&the_index, name, item->attr_check);
> +	git_check_attr(istate, name, item->attr_check);
>  	for (i = 0; i < item->attr_match_nr; i++) {
>  		const char *value;
>  		int matched;
> @@ -318,7 +319,8 @@ static int match_attrs(const char *name, int namelen,
>   *
>   * It returns 0 when there is no match.
>   */
> -static int match_pathspec_item(const struct pathspec_item *item, int prefix,
> +static int match_pathspec_item(const struct index_state *istate,
> +			       const struct pathspec_item *item, int prefix,
>  			       const char *name, int namelen, unsigned flags)
>  {
>  	/* name/namelen has prefix cut off by caller */
> @@ -358,7 +360,7 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
>  	    strncmp(item->match, name - prefix, item->prefix))
>  		return 0;
>  
> -	if (item->attr_match_nr && !match_attrs(name, namelen, item))
> +	if (item->attr_match_nr && !match_attrs(istate, name, namelen, item))
>  		return 0;

Yuck, all of this just because I added the ability to match against
attrs with pathspecs.  Part of me wonders if it would be better to put a
pointer to the needed istate in the pathspec struct...but then I can
think of a ton of reasons why that wouldn't be good either.

So yes I think this is probably the right approach, I'm just sorry I
made it this messy :/


-- 
Brandon Williams
