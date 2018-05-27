Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 414031F42D
	for <e@80x24.org>; Sun, 27 May 2018 18:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032874AbeE0SE3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 14:04:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37573 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032846AbeE0SE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 14:04:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id l1-v6so26536244wmb.2
        for <git@vger.kernel.org>; Sun, 27 May 2018 11:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AgPTS0sweyPdVHAbMp4FYd0FXPqgVMjgbyO3aqoPAfk=;
        b=fNuKdQ2OmE3MUYvi4gtYC8lVEtv0SV0Q2z7SvyDn6IFywWeZWnwKfZ4C1gyLD3TDdd
         BIQPK1Vc33DWa38KxTRuEPIrSxAc/KpyQNHmhqZM7HoNRXLt6WOi6v1SiEsIYwJRtWkO
         3d+lXR42zg7+g1c4lULNticuS36Wbhdqs2OWNfF73jsGPx/IsysPhzOie8BsIYaYnywp
         5Bc8hgfSP5mDeec0YrWwMxp93bTpZzpSxrUlvkZ5KPv7JK0QqQMYf0DernIQQLmfsgPf
         Vkv4vY/V2GqhjHWsXMZBg5rC6oehOJRvZuPLUCa8oQWY3nGrEfW3knyptyFuFCxAN0tP
         ZVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=AgPTS0sweyPdVHAbMp4FYd0FXPqgVMjgbyO3aqoPAfk=;
        b=dghjWf2PTOaE9te4FTIFJuOS4as0XGmNLVc/GOFi7RIJSjFDjZOALkh6ksKVHP0yxs
         oqMpE38B1wIKkmG+6CaJOQ/yGRGrqRBV8kiuLu3DNOGqdbQp8TONrlUrmZZHmK6TXGtv
         PJ+lV8Vbc3T3jkBTt4H1GwvwsyWaZp/K91Z5OKv0UbfpZK8cTiGS+nNGgjsz/kdmdaOU
         0OI5f5MApcqMYx/FMhXwYJoiENJQyBSB76hhelrvn31wd8Mq77Y6ic7L5XWahBqTd8wt
         Um0CPOaqbzc0NcJ2NUARtd4t32uqKBohy2cnroz+gThPIu4DDZUDjxhRPxoDXvv7TAIB
         xoUw==
X-Gm-Message-State: ALKqPweytivOnIB4zaCh1o7+kNjQQbVnbfZ269/jIIXWgiRACYKUqWvX
        AXcPm+6CIh+SO3g23mhqW/xvG4cG
X-Google-Smtp-Source: AB8JxZof/T4lQFH67gDNCoqfc0h2sIWV/iw80zTYQIQce2BdEcXkuNf6X45OVG6K45SVccNzhtglSw==
X-Received: by 2002:a1c:3b87:: with SMTP id i129-v6mr7529910wma.51.1527444267500;
        Sun, 27 May 2018 11:04:27 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egb161.neoplus.adsl.tpnet.pl. [83.21.65.161])
        by smtp.gmail.com with ESMTPSA id 131-v6sm16226172wms.34.2018.05.27.11.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 May 2018 11:04:25 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 04/20] commit: force commit to parse from object database
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-5-dstolee@microsoft.com>
Date:   Sun, 27 May 2018 20:04:25 +0200
In-Reply-To: <20180524162504.158394-5-dstolee@microsoft.com> (Derrick Stolee's
        message of "Thu, 24 May 2018 16:25:33 +0000")
Message-ID: <86o9h1ynyu.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> In anticipation of verifying commit-graph file contents against the
> object database, create parse_commit_internal() to allow side-stepping
> the commit-graph file and parse directly from the object database.
>
> Due to the use of generation numbers, this method should not be called
> unless the intention is explicit in avoiding commits from the
> commit-graph file.

A straightforward addition of a parameter to parse_commit() and renaming
it to parse_commit_internal(), while changing parse_commit() to be a
simple wrapper around newly introduced parse_commit_internal(), passing
the default arguments.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit.c | 9 +++++++--
>  commit.h | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)

Nice and simple refactoring in preparation for future changes.

>
> diff --git a/commit.c b/commit.c
> index 1d28677dfb..6eaed0174c 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -392,7 +392,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
>  	return 0;
>  }
>  
> -int parse_commit_gently(struct commit *item, int quiet_on_missing)
> +int parse_commit_internal(struct commit *item, int quiet_on_missing, int use_commit_graph)

I guess that the "new" parse_commit_internal() function was not made
static despite the *_internal() in the name because it would need to be
used from commit-graph.c, isn't it?

I don't think we would need more similar options, so *_with_flags()
would be YAGNI overkill.

>  {
>  	enum object_type type;
>  	void *buffer;
> @@ -403,7 +403,7 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
>  		return -1;
>  	if (item->object.parsed)
>  		return 0;
> -	if (parse_commit_in_graph(item))
> +	if (use_commit_graph && parse_commit_in_graph(item))
>  		return 0;
>  	buffer = read_sha1_file(item->object.oid.hash, &type, &size);
>  	if (!buffer)
> @@ -424,6 +424,11 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
>  	return ret;
>  }
>  
> +int parse_commit_gently(struct commit *item, int quiet_on_missing)
> +{
> +	return parse_commit_internal(item, quiet_on_missing, 1);
> +}
> +
>  void parse_commit_or_die(struct commit *item)
>  {
>  	if (parse_commit(item))
> diff --git a/commit.h b/commit.h
> index b5afde1ae9..5fde74fcd7 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -73,6 +73,7 @@ struct commit *lookup_commit_reference_by_name(const char *name);
>  struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
>  
>  int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size, int check_graph);
> +int parse_commit_internal(struct commit *item, int quiet_on_missing, int use_commit_graph);
>  int parse_commit_gently(struct commit *item, int quiet_on_missing);
>  static inline int parse_commit(struct commit *item)
>  {
