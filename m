Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25DEF20401
	for <e@80x24.org>; Tue, 13 Jun 2017 03:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbdFMDnn (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 23:43:43 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34457 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbdFMDnm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 23:43:42 -0400
Received: by mail-pg0-f42.google.com with SMTP id v18so53929741pgb.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 20:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X0O99XeqVGBzKOe65ytzj3exf5Uo9lkG3IJsacPCl2w=;
        b=QOxqBqo2qH2VfWjwXR+pJr46XX55QJO4PzYpuxjLk8w4Yat7n7rlj9hLvSW0c7gJcZ
         ndqeakS7vdJc7xvJ6r/gU2kbQUsNIIHTWB6fQ2ZiidVfCiKLtU1xtsO7zy9EHv6ekPNB
         w30s9QbRbG1BFnXAt4AmLla5Y3BNkuaMMfbzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X0O99XeqVGBzKOe65ytzj3exf5Uo9lkG3IJsacPCl2w=;
        b=mKNN6NHwV+cYGlsCuOxIrJK30tckjpS/ck0gX5D/CAj8w01iN8AggaA3mgBzF4CeSD
         Vverh+wsQkIiugrzuL0WGYvQoDG6jmCrXfay2WgbMsp8g08p3VMwi4aZiHm1dHcVW4nA
         t62jCWtipq4SjuTXnwp2hp1z+HGSqZPAYya30NIjqb8zfCdTFcG5O7hUF3WBE6L18JI9
         LKWOug5sZpIi+KUVEColTDS6wXyAxv+P8EsdDG1be66CcOUf4yLDfXu50qOySf+ZyUV/
         uTBHzqLYItFtPoueeFLEBdxXrUiI7L1qx6RLTMzSM0YcDThJGj5kfbDnjfQmAj23K774
         KwVw==
X-Gm-Message-State: AODbwcBU3NyhRd7n7p1nOwmUpuSVjiwvVmBr0o9WSP3/qAkz2ybq8YND
        V9IWa4g0K9i7Ofvb2VAVAw==
X-Received: by 10.98.138.143 with SMTP id o15mr36193445pfk.125.1497325421525;
        Mon, 12 Jun 2017 20:43:41 -0700 (PDT)
Received: from localhost ([122.172.35.3])
        by smtp.gmail.com with ESMTPSA id q7sm19523177pfk.108.2017.06.12.20.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jun 2017 20:43:39 -0700 (PDT)
Date:   Tue, 13 Jun 2017 09:13:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] send-email: Add tocmd option to suppress-cc
Message-ID: <20170613034337.GF5297@vireshk-i7>
References: <6367777092d93a62cc83c444061dde853ba3369e.1495107179.git.viresh.kumar@linaro.org>
 <20170612043313.GE5297@vireshk-i7>
 <xmqq8tkxp4nw.fsf@gitster.mtv.corp.google.com>
 <xmqqmv9dnkut.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmv9dnkut.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12-06-17, 11:04, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Viresh Kumar <viresh.kumar@linaro.org> writes:
> >
> >> On 18-05-17, 17:05, Viresh Kumar wrote:
> >>> This adds tocmd option to suppress-cc command which already supports
> >>> cccmd and others.
> >>> 
> >>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >>> ---
> >>>  Documentation/git-send-email.txt | 1 +
> >>>  git-send-email.perl              | 8 ++++----
> >>>  2 files changed, 5 insertions(+), 4 deletions(-)
> >>
> >> Ping !!
> >
> > Pong?
> >
> > I didn't get the impression that in the discussion that led to your
> > patch (or in any response to the patch) we established that it is a
> > good idea to change the behaviour of suppress-cc unconditionally
> > like this patch does.

Yeah, there were no conclusions there but we agreed that we have a
problem to solve. And this patch tried one of the ways.

> I think suppress-cc that suppresses cccmd output is very sensible
> (after all, it is about suppressing CC and cccmd is about producing
> CC), but I am not convinced that it is a good idea to suppress tocmd
> (which is about producing To) via suppress-cc.
> 
> Going back to the core part of your change, i.e.
> 
> -	foreach my $entry (qw (cccmd cc author self sob body bodycc)) {
> +	foreach my $entry (qw (tocmd cccmd cc author self sob body bodycc)) {
> 
> to think about it a bit more, I notice that all the existing ones
> are about CC.  So I am not just not convinced that tocmd belongs to
> the same class.  I am inclined to say that it smells quite different
> from others.

That's right but how do we solve this problem then?

Add another optional argument like suppress-to ? I thought that it
would be better to override suppress-cc rather than attempting any
such thing.

I am fine with any solution that address the concerns raised by this
patch though.

-- 
viresh
