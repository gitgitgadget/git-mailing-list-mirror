Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 159581F404
	for <e@80x24.org>; Fri, 20 Apr 2018 00:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753826AbeDTAOW (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 20:14:22 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46833 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753703AbeDTAOV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 20:14:21 -0400
Received: by mail-wr0-f195.google.com with SMTP id d1-v6so18379771wrj.13
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 17:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VQ1koZpXEi9BjZFz+SLZ0MKPPmgxwXmdLzXKLQ8b5vY=;
        b=Vh4/0D/6fbP8/nYmdXKBuRiyxvZuK5+LdhRtuwC7NH4hQiuKXfDlAtVPcSuqwPVxpe
         fgiqrQvRBmJe/sQa4AKwsTYOW3Hitv60rN3yxw1xdqlSPB0nYy6pnVu74DEdk+QomRU2
         jWRzE6L2vJnrq7DKKceC8vLBFO0oQ6Ppjh9mzPLhrj6VZG6j+wcfHemykVM6IuyhOV9K
         AUD/ImPcQWTKUHeEtBETYyvIXFjMLV8oOEdiUqiaianrpJ0Qa8te1VXrZSqZx0RnYg8x
         mg4pR0duwJFMdPiyg41Hu0CE4tYNqebHTiiYO4tMtUcl/LfQKNNEifXtnoYz8R0qqvgc
         PtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VQ1koZpXEi9BjZFz+SLZ0MKPPmgxwXmdLzXKLQ8b5vY=;
        b=XndqPNtsMwynSrfZGu9pOWzD/enTZwEJov2F9nwow9loMz+M/qoeYAdhAQxBksdFoK
         Nluvmxs6H+JS7vL2JZ8lwloUe7IwHfBgRmgDEYE5TyDxnjaY9b+7rGON/whbQQQMFLjm
         fhw5jSJrzk3pfoVccKlXM9Jm7nsC/ZgF9lULjx2qm1i+qtIaGuXqtIpYMpzb2VFZuL0T
         RvS+axqegiU+DdIjn+nWDR/iutsjiqpg/0KMyhZPxLiaHMrIXeH72wMpm2a/4jYtwdR2
         9pC+cRcBXakQjcNnh/EPDvq+244vU6whdeJ977uvZXTUBiARUsjQEW8nixIi109iYkBP
         AOmw==
X-Gm-Message-State: ALQs6tCrsXn2cBSkj3RBB88U+pYsScZTizn/ug/CT2cQ7YUTQTeKuYaq
        z7qj7bzVK6iglCKMI/uyJ2lGYkKW
X-Google-Smtp-Source: AIpwx4/bRezTVnl7iXzi5c4vXl6PY5VW4QwtqX2bJiMhtctgJBkfeyj9FAm8y4ti4DKOMnlMGCFdQA==
X-Received: by 10.28.140.204 with SMTP id o195mr449571wmd.35.1524183259732;
        Thu, 19 Apr 2018 17:14:19 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o12-v6sm3284638wri.78.2018.04.19.17.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Apr 2018 17:14:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Silly "git gc" UI issue.
References: <CA+55aFxSZLuk++Dz6SonD+JhbbSDt9G9VcBx5f1CV=6nJC9hvg@mail.gmail.com>
        <xmqqr2ncezdc.fsf@gitster-ct.c.googlers.com>
        <20180419103447.GA19591@ruderich.org>
Date:   Fri, 20 Apr 2018 09:14:18 +0900
In-Reply-To: <20180419103447.GA19591@ruderich.org> (Simon Ruderich's message
        of "Thu, 19 Apr 2018 12:34:47 +0200")
Message-ID: <xmqqlgdid99h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simon Ruderich <simon@ruderich.org> writes:

> On Thu, Apr 19, 2018 at 10:52:47AM +0900, Junio C Hamano wrote:
>> It turns out that prune silently goes away given a bad expiry
>>
>>     $ git prune --expire=nyah ; echo $?
>>     129
>
> I noticed that git log --since/--after/--before/--until have a
> similar behavior and ignore date parsing errors in those options
> completely. Is this expected or should we warn the user with
> something like the following?

I do not have a strong opinion on this, because I would expect that
"git log --since=nyah" to do whatever random things it may want to
do.

But I suspect I am a minority, and if we were to change the
established behaviour, I agree that erroring out using
approxidate_careful() is the right direction to go in.

Thanks.

> diff --git a/revision.c b/revision.c
> index 4e0e193e57..e5ba6c7dfc 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1794,19 +1794,31 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		revs->max_age = atoi(optarg);
>  		return argcount;
>  	} else if ((argcount = parse_long_opt("since", argv, &optarg))) {
> -		revs->max_age = approxidate(optarg);
> +		int err = 0;
> +		revs->max_age = approxidate_careful(optarg, &err);
> +		if (err)
> +			return error("--since: invalid time '%s'", optarg);
>  		return argcount;
>  	} else if ((argcount = parse_long_opt("after", argv, &optarg))) {
> -		revs->max_age = approxidate(optarg);
> +		int err = 0;
> +		revs->max_age = approxidate_careful(optarg, &err);
> +		if (err)
> +			return error("--after: invalid time '%s'", optarg);
>  		return argcount;
>  	} else if ((argcount = parse_long_opt("min-age", argv, &optarg))) {
>  		revs->min_age = atoi(optarg);
>  		return argcount;
>  	} else if ((argcount = parse_long_opt("before", argv, &optarg))) {
> -		revs->min_age = approxidate(optarg);
> +		int err = 0;
> +		revs->min_age = approxidate_careful(optarg, &err);
> +		if (err)
> +			return error("--before: invalid time '%s'", optarg);
>  		return argcount;
>  	} else if ((argcount = parse_long_opt("until", argv, &optarg))) {
> -		revs->min_age = approxidate(optarg);
> +		int err = 0;
> +		revs->min_age = approxidate_careful(optarg, &err);
> +		if (err)
> +			return error("--until: invalid time '%s'");
>  		return argcount;
>  	} else if (!strcmp(arg, "--first-parent")) {
>  		revs->first_parent_only = 1;
>
> Regards
> Simon
