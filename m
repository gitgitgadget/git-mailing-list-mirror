Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAC7B1FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 22:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754808AbcK1WL1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 17:11:27 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33558 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbcK1WL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 17:11:26 -0500
Received: by mail-pg0-f45.google.com with SMTP id 3so61345711pgd.0
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 14:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7fXy0wkuL9f9iu29pt79u5IxJDzakbm+GtiXoRffCr0=;
        b=iyq1uMw9OQpAgSdhVtejTO6PMYhjcOVVcu7Lx321c/lR7wVKaTuIHc5Cekou6pwHt3
         0KWxBgzvpJyPJJGi1QyF4aF9+qczOQjEgD3WK1LT1OkvkVQjlT7JcolF1W+DRrPoBmhh
         fwq+yVsSu+ftAVyY2EZbbFDS08NAVOzGlSbvM+X07Gnw0+SKhmCuboWReydnf6T+HG3U
         k+G7tBbftQvwAe477kxwNnYPWYyXkACrd/WqdRXPaNcDzE9Q5LMVGLVCmNFve0WtzIZ1
         itkwJ3E0hQyeWs63zKx9Zb/JBsYgp8NGuB4g5Au9TIPeMVjCWYz5wAu0YPF+gPoyiR7h
         2Cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7fXy0wkuL9f9iu29pt79u5IxJDzakbm+GtiXoRffCr0=;
        b=VjP69yKikE11vO0qi6FPc0svCqsz6/uyIEvWX7k6ab0R1Fbxc7KrkbK7inpFvLCxlo
         ksLzOnH9lcUekalU4p1HmaeeTE4aQ+OX9/5/hqowubxQxcgai61cwrpusNQ6mgFPUyXK
         xhxhjmDoEG9Y/QVOjGps/7T/Jl+My0A0JWTXWtGUrgp63mGllfOoJtBM6RTZXo3Z2FZn
         7zTRtmphDO/ZUVQAGW0p/uJ85M9TVSLZ7XOCgMkiUFkEfZEr19biyXtIy+hbjVZlKbpC
         lJtmMMCPWKaVrxaXEahbLxqgtGjJ1iQlqfMaOzwyPNtz6ij6QdzJgIg7TK27TwVPhM0S
         oZgQ==
X-Gm-Message-State: AKaTC03nnbjw80szM+1EWusXVRMXYUheTdoppZau8gqam0oYv3KSVLLoswXDG+dsIzmgBFWc
X-Received: by 10.84.208.227 with SMTP id c32mr54340857plj.144.1480371085122;
        Mon, 28 Nov 2016 14:11:25 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:6409:b611:8934:17a0])
        by smtp.gmail.com with ESMTPSA id o68sm89481026pfb.42.2016.11.28.14.11.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 28 Nov 2016 14:11:24 -0800 (PST)
Date:   Mon, 28 Nov 2016 14:11:23 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 31/35] pathspec: allow querying for attributes
Message-ID: <20161128221123.GC150448@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
 <20161110203428.30512-32-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161110203428.30512-32-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10, Stefan Beller wrote:
> @@ -500,6 +586,18 @@ void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
>  
>  void clear_pathspec(struct pathspec *pathspec)
>  {
> +	int i, j;
> +	for (i = 0; i < pathspec->nr; i++) {
> +		if (!pathspec->items[i].attr_match_nr)
> +			continue;
> +		for (j = 0; j < pathspec->items[j].attr_match_nr; j++)
> +			free(pathspec->items[i].attr_match[j].value);
> +		free(pathspec->items[i].attr_match);
> +		if (pathspec->items[i].attr_check)
> +			git_attr_check_clear(pathspec->items[i].attr_check);
> +		free(pathspec->items[i].attr_check);
> +	}
> +
>  	free(pathspec->items);
>  	pathspec->items = NULL;

You may also want to add logic like this to the 'copy_pathspec' function
so that when a pathspec struct is copied, the destination also has
ownership of its own attribute items.

-- 
Brandon Williams
