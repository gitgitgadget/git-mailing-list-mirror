Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 760EC1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 18:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfAVSy3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 13:54:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44641 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfAVSy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 13:54:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so28585521wrt.11
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 10:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kEg4Y3M/akUpdlp7FydS8lJOpcabyYPZpm4+fQ0Lt+c=;
        b=nilAoFZ9zZeOZgGg6Jdj3Mi8qH71ZyFesXKvjLqy1i5lx4ZKYUYdnFNPvhCtD3ljQY
         mZ9qlyCQhpU9XuoNTpsE1UtOpq86xeUxjEP0NECUITKzJAExU5Fau2bxvm59uKyoV79X
         rEoJKNb4JfP5FHFczl7/bbNa8Y24ZSlhZuMre3hEExK9BckAEOqiRzlSOIPW6znSD02S
         zf37AObvcqo9gO3oPLJY38xqnfRKcCraBFNlt/WsyDL57aF6Ax5dQ55XKh0TuPfocUIg
         l5ImO8igqEVsufEvY1smMT6Zk17Ugaiar/iCTzDWXiMT2GV9Uitg6moTYK+vkaFOwvS3
         hx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kEg4Y3M/akUpdlp7FydS8lJOpcabyYPZpm4+fQ0Lt+c=;
        b=ohVOXd0wOc5vpjdI/hUhgN0O9wGBeeyq7kPz/Dh8UH/RGqaX/am+aWq60uRJPJt4il
         BYM3qB4BvLclQEeMWafjk2WKmV7XYcXfnqcX1Legcj0CMkZtblii/YSl71JNPlrbwdwD
         IAEqba1YBrAvBJZxhiPSksRIQ2cAlCU9BlpGSeToz2D6f4e2O0HDZLY3FMZncSd4b2gx
         PL7ksnle6HTFn5xM675cnQQGIxIH5bkzq1ShHHYSFW+cOEJOu3X/YkP18pOHqhh7JfXk
         jkn8/rpMIM5LIcu0U/iQp853KKkvYsJDBRZF2K+wlUtyM54Titsco2LoWGelCDCXkO3L
         9lCw==
X-Gm-Message-State: AJcUukdL+FcNKK1gWfTssbcF03sT/YHoTSPYbhiClSmUWnoa05Uyg77J
        Bni9exN+G2yu54Xa9gzA9Xw=
X-Google-Smtp-Source: ALg8bN574i6F77jnJOp1IIs8vCP2CkBjqWuKXOIyG1BcSjJnSini7upSC1NWR8NNVgogN3VzK/8F/Q==
X-Received: by 2002:a5d:6152:: with SMTP id y18mr36009390wrt.141.1548183266961;
        Tue, 22 Jan 2019 10:54:26 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y34sm257700935wrd.68.2019.01.22.10.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 10:54:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, asottile@umich.edu, benpeart@microsoft.com,
        pclouds@gmail.com
Subject: Re: [PATCH v2 0/2] Fix regression in checkout -b
References: <20190118185558.17688-1-peartben@gmail.com>
        <20190121195008.8700-1-peartben@gmail.com>
Date:   Tue, 22 Jan 2019 10:54:25 -0800
In-Reply-To: <20190121195008.8700-1-peartben@gmail.com> (Ben Peart's message
        of "Mon, 21 Jan 2019 14:50:06 -0500")
Message-ID: <xmqq4la0h6am.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index af6b5c8336..9c6e94319e 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -517,12 +517,6 @@ static int skip_merge_working_tree(const struct checkout_opts *opts,
>  	if (core_apply_sparse_checkout && !checkout_optimize_new_branch)
>  		return 0;
>  
> -	/*
> -	 * We must do the merge if this is the initial checkout
> -	 */
> -	if (is_cache_unborn())
> -		return 0;
> -
>  	/*
>  	 * We must do the merge if we are actually moving to a new commit.
>  	 */
> @@ -598,6 +592,13 @@ static int skip_merge_working_tree(const struct checkout_opts *opts,
>  	 * Remaining variables are not checkout options but used to track state
>  	 */
>  
> +	 /*
> +	  * Do the merge if this is the initial checkout
> +	  *
> +	  */
> +	if (!file_exists(get_index_file()))
> +		return 0;
> +
>  	return 1;
>  }

This is curious.  The location the new special case is added is
different, and the way the new special case is detected is also
different, between v1 and v2.  Are both of them significant?  IOW,
if we moved the check down but kept using is_cache_unborn(), would
it break?  Or if we did not move the check but switched to check the
index file on the filesystem instead of calling is_cache_unborn(),
would it break?

There are three existing callers of is_{cache,index}_unborn(), all
of which want to use it to decide if we are in this funny "unborn"
state.  If this fixes the issue we saw in v1 of these two patches,
does that mean these three existing callers also are buggy in the
same way and we are better off rewriting is_index_unborn() to see if
the index file is on the disk?

I am *not* suggesting to make such a drastic change to the existing
system.  I am wondering why they are working fine but only this new
code has to avoid the existing is_index_unborn() logic and go
directly to the filesystem.  Especially as this new exception added
to "skip-merge-working-tree" is to allow the special case code in
merge-working-tree that depends on is_cache_unborn() to trigger.

Thanks for working on this.
