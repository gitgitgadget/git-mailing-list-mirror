Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5534C207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 23:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1950184AbdDYXeM (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 19:34:12 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33145 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1949062AbdDYXeK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 19:34:10 -0400
Received: by mail-pf0-f195.google.com with SMTP id c198so12979960pfc.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 16:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1BbNbuucLcn6ItSaVkOazqg+Q89ZiQlRHxwRoihYCfY=;
        b=quJnG1mIg8bWFccy5GPyIA3t9NnlP4fOg6Ev5dr83yIMWIf7Va/KipvuFZj0jr1Is4
         tN2rjB+LQo24rNwKZEZnhLtyh5wmTWY91R8FeQVky1+ai0YvpI93Fs/+RZZATawZ3dE3
         aiAUfqbQtQImm5MwU+5X9EDxCQmzyqtYwik+XH4nFjP0UIWKvSgVi9t456sM/3Ma6MyC
         xaXtSzIGqYlwmrhoiizCMxzRGyNmdXOWCO9V4iW6PoUbHTfpo65jvutqC6dzQJRZQCL3
         gtEqqzrpJiYdge1Su1Cs+kuWu8IOUcDPfQSudsxeXi+gN/fTiKi07tYVvtBJWepR0o3c
         U/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1BbNbuucLcn6ItSaVkOazqg+Q89ZiQlRHxwRoihYCfY=;
        b=ZpZbZGpme/B88RLEajK9RK/8jF+yzx/DCpE/JOfaGji9Yzky7KQoFif7Pvhu5kO6J+
         Gqje3200fJqfrVPubJOhycdedxJyLEOkYSNVtKrcvbkYiY375ugpiY5oM8EafzGM9R5i
         JzOTR4TwOETjCGXNy7zK9a/MpCDbgB5T5xeT34lDMMvEDB7uzE3r+senH4HxQJHT+lr/
         h7wiXenl6KCiFZTxrMBxhkdYc++coi0PRxkdLRhmd5M8osdqqAHEXjNjXyRYnI7oFEWU
         cTFh1M9japTY8Q1Bp1M6Xh4I+AhBB9H0RY6vJd1ffvwnunexQvUMvn3tsNrDDGoszQ+/
         6LZA==
X-Gm-Message-State: AN3rC/6Nprv/poGWXfo/BC/QqlNy5ZSZoFRLTJ4PYsV6HCJ20URWHy5e
        4uZTGkJVoBxgeQ==
X-Received: by 10.99.124.71 with SMTP id l7mr29664702pgn.14.1493163249617;
        Tue, 25 Apr 2017 16:34:09 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:c0ea:3a03:d3a7:cb53])
        by smtp.gmail.com with ESMTPSA id m4sm38399977pgm.25.2017.04.25.16.34.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 16:34:09 -0700 (PDT)
Date:   Tue, 25 Apr 2017 16:34:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, computersforpeace@gmail.com
Subject: Re: [PATCH] sequencer: require trailing NL in footers
Message-ID: <20170425233407.GO28740@aiede.svl.corp.google.com>
References: <20170421220155.GA142345@google.com>
 <20170425190651.8910-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425190651.8910-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> In commit 967dfd4 ("sequencer: use trailer's trailer layout",
> 2016-11-29), sequencer was taught to use the same mechanism as
> interpret-trailers to determine the nature of the trailer of a commit
> message (referred to as the "footer" in sequencer.c). However, the
> requirement that a footer end in a newline character was inadvertently
> removed. Restore that requirement.
>
> While writing this commit, I noticed that if the "ignore_footer"
> parameter in "has_conforming_footer" is greater than the distance
> between the trailer start and sb->len, "has_conforming_footer" will
> return an unexpected result. This does not occur in practice, because
> "ignore_footer" is either zero or the return value of an invocation to
> "ignore_non_trailer", which only skips empty lines and comment lines.
> This commit contains a comment explaining this in the function's
> documentation.
>
> Reported-by: Brian Norris <computersforpeace@gmail.com>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
[...]
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -151,6 +151,12 @@ static const char *get_todo_path(const struct replay_opts *opts)
>   * Returns 1 for conforming footer
>   * Returns 2 when sob exists within conforming footer
>   * Returns 3 when sob exists within conforming footer as last entry
> + *
> + * A footer that does not end in a newline is considered non-conforming.
> + *
> + * ignore_footer, if not zero, should be the return value of an invocation to
> + * ignore_non_trailer. See the documentation of that function for more
> + * information.
>   */
>  static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
>  	int ignore_footer)
> @@ -159,6 +165,11 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
>  	int i;
>  	int found_sob = 0, found_sob_last = 0;
>  
> +	if (sb->len <= ignore_footer)
> +		return 0;
> +	if (sb->buf[sb->len - ignore_footer - 1] != '\n')
> +		return 0;
> +

This is super subtle, but it does the right thing.  The caller will
notice it's not a conforming footer, add a newline to separate the new
footer from it, and repair the footer as a side effect.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Followup question: what should happen if there is a non-footer-shaped
thing with no trailing newline at the end of the commit message? Should
we add two newlines in that case when producing a new footer?

Thanks,
Jonathan
