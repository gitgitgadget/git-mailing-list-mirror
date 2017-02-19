Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75589201A9
	for <e@80x24.org>; Sun, 19 Feb 2017 09:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750978AbdBSJR4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 04:17:56 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33610 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdBSJRz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 04:17:55 -0500
Received: by mail-wr0-f195.google.com with SMTP id g51so1988148wrg.0
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 01:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GjMN6xqMAe1g3vy65DgUNktzLRZI+fGOhnbDEYTdBBw=;
        b=cl1ywhdqtbIoSCdRIKzFaBDt6fxqwhYq+4ua155QKEaM+mmrB9vnXlmfQCUQpYjgWo
         OP6S5tRAeu9JwxsX2l9H2qihiqYQh8UG56gI3yd/nJtwlAiyzv75wbNuwin8P5jBFRoP
         lq2db+1XycbgtpONpzOFsnGxH98+lyVsc7SlApRq4q9+c3i6I8RIwu9d8upMBQ7JHMC9
         hdF5I9CBiiPoZ6neZ6uJU/qURSHuC3JNnPxiKojqjt7HgQ4dfYUhyR56ajGw8FK0VxIv
         N64qDQocWNh83hF/M4sBZt7Q3qxTNpov0XCnNLAIp+oyuhkuODw1NHjjiUmo01gniuP1
         n6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GjMN6xqMAe1g3vy65DgUNktzLRZI+fGOhnbDEYTdBBw=;
        b=MVG9UwFlE7pOs7VhMbYzC6OfC6Ve8OwW+TtC0UrHHUv41Qds8o6Iy6XH8e+te7foO4
         Z4+6eg+PWYVK6zf1XBnaNi6jal2zWRyRc+S7dP1ugqszTRRT/fyRX72p9Vu648tkQwUT
         UqRDkIRHntfnK93ktxJpU4k9VlFaw/tWdMMk6meWa0aokBcqkNNNnrGYZpih1AamBI0t
         YiXrfyK0gLaNnVL+rmUFhQav+Fchf9RDmbfrg/xjQuRWbTQawMHeF9ayulORh16QO2OZ
         nNcaOQKwuaGHavPoi9iWelIBlWSxycbWbuADIDoRxWAeFqcBVEMbmkibKsWTLYybwFH6
         2uhA==
X-Gm-Message-State: AMke39lhWLHNaHEpwcBVi/qoxpVzuAPnDe7u5Rq03MMKhGDC9fCKVE/p1OkR1L53D0re/w==
X-Received: by 10.223.139.137 with SMTP id o9mr13163334wra.88.1487495874276;
        Sun, 19 Feb 2017 01:17:54 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id r93sm8213206wrb.9.2017.02.19.01.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Feb 2017 01:17:53 -0800 (PST)
Date:   Sun, 19 Feb 2017 09:18:33 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=D8yvind_A_=2E?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 6/6] stash: allow pathspecs in the no verb form
Message-ID: <20170219091833.GK652@hank>
References: <20170212215420.16701-1-t.gummerer@gmail.com>
 <20170217224141.19183-1-t.gummerer@gmail.com>
 <20170217224141.19183-7-t.gummerer@gmail.com>
 <20170217234647.bqhzzm533oruhr5e@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170217234647.bqhzzm533oruhr5e@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/17, Jeff King wrote:
> On Fri, Feb 17, 2017 at 10:41:41PM +0000, Thomas Gummerer wrote:
> 
> > Now that stash_push is used in the no verb form of stash, allow
> > specifying the command line for this form as well.  Always use -- to
> > disambiguate pathspecs from other non-option arguments.
> 
> I think that makes sense.
> 
> > Also make git stash -p an alias for git stash push -p.  This allows
> > users to use git stash -p <pathspec>.
> 
> And I think of all the options we discussed for handling "-p", I think
> this one makes the most sense.
> 
> It may be worth calling out in the documentation that this is how it
> works though, so people do not think that:
> 
>   git stash -k -p <path>
> 
> would work ("git stash -k -p" _does_ happen to work due to the old
> options-only rule, but I think we should advertise the general form as
> "-p is an alias for "push -p").

Yeah, I think adding something about this in the documentation would
be good.  I'll add a paragraph about this in the re-roll.

> -Peff

