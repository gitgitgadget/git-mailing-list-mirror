Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C600420562
	for <e@80x24.org>; Mon, 30 Oct 2017 18:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932301AbdJ3SGW (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 14:06:22 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:47350 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752702AbdJ3SGV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 14:06:21 -0400
Received: by mail-io0-f194.google.com with SMTP id h70so29187093ioi.4
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oy6KHxTP1OP8VWhch6vA610jASkGj3CAZ9g603sAJmY=;
        b=m9a4cJJQE+o8uT9PcHEsc5Ql1EMCGThvwGAXQMLFKMhpP477vOjkx3s51XTjleYZ32
         tJIDMKw/eIc5zx/wj0gj0jf+5nRvXC25K6lkSNNUlFWg3bbYXoDJZD/DcCH/31fSTigy
         IkkT0CThDkkUNYRmsTqVli0QMJzNLPLqE1QL5Vs5lBgOAeERFmIY7UH7lNJEorSOK98L
         2xTzPYCQf3GkXiZqQj108QSiZa512Nh5nEo0ScVXAD+noOH/p3cmkTJOwxNhvsigh7ao
         31F120cMpXjqOcqr8YyFMKU4bJJ8e2Ng0ck6+V6PQAowzPADaDpIhlN+Km1CViW0N954
         SStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oy6KHxTP1OP8VWhch6vA610jASkGj3CAZ9g603sAJmY=;
        b=nlWJQnVvof6A/al5A4XOc3IfkKqPUb3YG1PNiuYQjzgIjkhb7ZXjKdlj4mj1qzcjsC
         weNTV9EkjFGNbg8j9KrCJtBRFWWxJX4fWue3nS8mX5hax2O6MUH5pkQ+pn5YLyKUs/BA
         xlhs9ay8BJJZK7VGtC9LLGrD85vxyXkK5Ne+2H7tdfh8EAO5dK9LyJ6byw8AoCPB3tqw
         w9YDXd+tIsEJtk799+cdnzgjoqvl1Jhy9DW2rj34uJpEF7Ru1HmrrxJmQ0ojIYMF2D8m
         yDwaSjQi7qarYoWHVb0vcV3hPvcuJnsd9uuoHAZlxNSxLgPAxn5NYUsDQinjI8VS9sPW
         dLvA==
X-Gm-Message-State: AMCzsaUPWHqT+eAT+ozQ2B8wauJwQmeIe3gDRfQy5z8gUHqfl+vOrf06
        rPKIoEQjTwxPrGT1h+EwlA/B46hhdXY=
X-Google-Smtp-Source: ABhQp+RYpDIBD1KjvQLnlojdUXyfA7txeUChanolsJ+vEY0df5pUsPwozxdo6tN2H5vtAjvxYiCvTQ==
X-Received: by 10.107.12.216 with SMTP id 85mr12125688iom.80.1509386780432;
        Mon, 30 Oct 2017 11:06:20 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:9c29:988d:323f:ada0])
        by smtp.gmail.com with ESMTPSA id w186sm2102782itd.12.2017.10.30.11.06.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 11:06:19 -0700 (PDT)
Date:   Mon, 30 Oct 2017 11:06:18 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] reset: use DIFF_OPT_SET macro to set a diff flag
Message-ID: <20171030180618.GB125460@google.com>
References: <20171027222853.180981-1-bmwill@google.com>
 <20171027222853.180981-3-bmwill@google.com>
 <xmqq1slmbv73.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1slmbv73.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/29, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Instead of explicitly setting the 'DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG'
> > flag, use the 'DIFF_OPT_SET' macro.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> 
> Looks good.  It's not like one of 1/3 and 2/3 could be a good idea
> while the other is not, so it would make a lot more sense to combine
> them into a single preliminary clean-up patch, though.  
> 

I'll squash them together in v2.

> In any case, these two are very good clean-up patches, whose value
> does not diminish even we do not go ahead with 3/3 yet.  
> 
> Nicely spotted; thanks.
> 
> 
> >  builtin/reset.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/builtin/reset.c b/builtin/reset.c
> > index 9cd89b230..ea2fad5a0 100644
> > --- a/builtin/reset.c
> > +++ b/builtin/reset.c
> > @@ -166,7 +166,7 @@ static int read_from_tree(const struct pathspec *pathspec,
> >  	opt.output_format = DIFF_FORMAT_CALLBACK;
> >  	opt.format_callback = update_index_from_diff;
> >  	opt.format_callback_data = &intent_to_add;
> > -	opt.flags |= DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
> > +	DIFF_OPT_SET(&opt, OVERRIDE_SUBMODULE_CONFIG);
> >  
> >  	if (do_diff_cache(tree_oid, &opt))
> >  		return 1;

-- 
Brandon Williams
