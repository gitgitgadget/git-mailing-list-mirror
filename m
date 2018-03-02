Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288861F404
	for <e@80x24.org>; Fri,  2 Mar 2018 21:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933609AbeCBVNv (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 16:13:51 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53803 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933572AbeCBVNv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 16:13:51 -0500
Received: by mail-wm0-f67.google.com with SMTP id t74so5580920wme.3
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 13:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8vIUcQudUH+5O6pW4l1mXy8U6U1oD6MlAHQxE8ZcAH8=;
        b=I+ZaMuSAnC2DHl/Nu3kNuDmr2ykpaPWFLiXFfpv+Xg+wgOyD18bVVujXCS8u8KQrKE
         hDXzEIsfDGCQWVujLqvCgGNwu9xfwJsFXImuQ9zKpAKF4bTdnqrVU6Xv8Jp8hfl+Er0N
         pQiogXczNsYjQRCgwQsNGRpuh4KQAZxVByw2d073TJ2IJVL+LmtI8rjQK1Stff4KhOnV
         PyLItRKCWo4K4bTclu07rb/IxxFVx0wq/pIYMgdFoD1mK/Nnkw1FY9ATqmOcgr8lV4GI
         PzW5klYAEf+k0Zyl4y0I23mP5bEyiIh9Ie3GDw34GRuYPtjHHDVdL2iZJxSoW7ZHBimR
         c3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8vIUcQudUH+5O6pW4l1mXy8U6U1oD6MlAHQxE8ZcAH8=;
        b=maKgIGLNmr2aXdBnkr94+yBti2zHdI0tuG1r1Vm5oWy9Hq+kjFa0ZsIdcANmPZZCAv
         tvY4GqrrVWbvHJC0ob/RLHS/fEtVrx+U4lsu8xeAX9eMXAC649PzQp+FpCymFRrDOTTF
         Q6L8csKulmFwv/gGM9f/INxUYl5Zs07fb10NGOe4XgapvYpsdFbTQH30HMkuBosKbpaa
         qSyiESEkPmq15EVrZcpktFmWuUuU0XRQq/G5MARysO/jTQXLA7MWYje4lSNtf4b0MoUd
         bv/M68qQS8UC1+NyvauADRybABsLvNpdq0iGAvufic6Qn84BDdZRVXmmphymJ5BJbfTq
         WyFg==
X-Gm-Message-State: AElRT7HNr11N3+OiVc2dJgCclVo8Oaw2mYuI6pcpUyzNVOX1dCwudSME
        CMmjugpvngb4cps/rFVHZPQ=
X-Google-Smtp-Source: AG47ELtuzFKb7CXapW++Y3j1PsnTTRHwm8BGRxjRgCreaQYb0qpVdXJcI/LVOjBpDJYDTQ9xEJMosA==
X-Received: by 10.28.135.139 with SMTP id j133mr2447160wmd.151.1520025229445;
        Fri, 02 Mar 2018 13:13:49 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h188sm1781603wmf.23.2018.03.02.13.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Mar 2018 13:13:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 13/35] ls-refs: introduce ls-refs server command
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <20180228232252.102167-14-bmwill@google.com>
Date:   Fri, 02 Mar 2018 13:13:46 -0800
In-Reply-To: <20180228232252.102167-14-bmwill@google.com> (Brandon Williams's
        message of "Wed, 28 Feb 2018 15:22:30 -0800")
Message-ID: <xmqqmuzqb2ph.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> + ls-refs
> +---------
> +
> +`ls-refs` is the command used to request a reference advertisement in v2.
> +Unlike the current reference advertisement, ls-refs takes in arguments
> +which can be used to limit the refs sent from the server.

OK.

> +Additional features not supported in the base command will be advertised
> +as the value of the command in the capability advertisement in the form
> +of a space separated list of features, e.g.  "<command>=<feature 1>
> +<feature 2>".

Doesn't this explain the general convention that applies to any
command, not just ls-refs command?  As a part of ls-refs section,
<command> in the above explanation is always a constant "ls-refs",
right?

It is a bit unclear how <feature N> in the above description are
related to "arguments" in the following paragraph.  Do the server
that can show symref and peeled tags and that can limit the output
with ref-pattern advertise these three as supported features, i.e.

	ls-refs=symrefs peel ref-pattern

or something?  Would there a case where a "feature" does not
correspond 1:1 to an argument to the command, and if so how would
the server and the client negotiate use of such a feature?

> +    ref-pattern <pattern>
> +	When specified, only references matching one of the provided
> +	patterns are displayed.  A pattern is either a valid refname
> +	(e.g.  refs/heads/master), in which a ref must match the pattern
> +	exactly, or a prefix of a ref followed by a single '*' wildcard
> +	character (e.g. refs/heads/*), in which a ref must have a prefix
> +	equal to the pattern up to the wildcard character.

I thought the recent concensus was left-anchored prefix match that
honors /-directory boundary, i.e. no explicit asterisk and just
saying "refs/heads" is enough to match "refs/heads" itself and
"refs/heads/master" but not "refs/headscarf"?
