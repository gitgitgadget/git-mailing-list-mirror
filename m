Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 405A020954
	for <e@80x24.org>; Tue, 21 Nov 2017 10:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbdKUKoN (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 05:44:13 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35485 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751766AbdKUKoI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 05:44:08 -0500
Received: by mail-wm0-f45.google.com with SMTP id y80so2322901wmd.0
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 02:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xJycUYYevvy/uYul9vSsQy4lnLoVJzzDkQm1humU+xc=;
        b=rIlY6qYAYPhlkuSoOIpLPbl9wy4Evry7KgbKiNEJzlZi0Re0XswMfSx3Ur4QTl3J++
         YDDGAw39wirmDMNkdDP1IdwIP48YFJUnpXLw1WJdJpuD/U1ufpp4MD7KVfQu60sORWFJ
         NxqBKMc+NYg+A3ESIpjPivTZJYywI3DdkAUU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xJycUYYevvy/uYul9vSsQy4lnLoVJzzDkQm1humU+xc=;
        b=bdLwh9I4LUB81SFZRColIjdzR75Pp5FZVkWdnhefls93DrFD4AM0rQJ1LjFVB9oR9+
         L6v/nbuNoZ7j5nqyE9mjOlSHMdRnwHyrXDSoStT0UvrxEWesfbOELHSf+yBmwiJViY4c
         sGUEQEww0XuEEpn9JZlg3FZ42UnbXpZResF/CX+0YpfvHsMbVX48jF728qqSkcD7wtzQ
         Zvu81Q1JmSnrBHEDJoJKgtJx4mgcz+7Btwa+OpTpS+wvg2r3Wykr6RoPkLspwzHj5zKs
         vgWPRdZDHQriTVjP4x7ZvozJvNjZGeuwR/6hicSKWLAf5Ih5c+8WB9+MY5wp34o2Odg0
         xP4w==
X-Gm-Message-State: AJaThX7a52W3y9VqAfWlr0rqc1cWlASBnPiz5z5IjM4a+2YiVpOFMqsp
        aPrB8XzpP/17889Ju59QpkwJxw==
X-Google-Smtp-Source: AGs4zMaCiJY4VC53NqQ3VWjan+VpPSSe4zincfgFqxcr7QTxvK0mOAQDB/mRGV15sJGX1jPNG4RdjA==
X-Received: by 10.28.110.26 with SMTP id j26mr919906wmc.46.1511261047062;
        Tue, 21 Nov 2017 02:44:07 -0800 (PST)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id u194sm924937wmd.6.2017.11.21.02.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2017 02:44:06 -0800 (PST)
Date:   Tue, 21 Nov 2017 10:44:04 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Stefan Beller <sbeller@google.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: t3512 & t3513 'unexpected passes'
Message-ID: <20171121104404.GN20681@dinwoodie.org>
References: <73f0fb1e-5b55-1049-7706-652f1f9deaed@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73f0fb1e-5b55-1049-7706-652f1f9deaed@ramsayjones.plus.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday 20 November 2017 at 08:16 pm +0000, Ramsay Jones wrote:
> For several days, I have been staring at some 'unexpected passes' in
> the t3512-cherry-pick-submodule.sh and t3513-revert-submodule.sh test
> files (tests #11-13 in both cases).
> 
> I finally found time tonight to 'git bisect' the 'problem', and found
> that bisect fingered commit b5a812b298 ("sequencer: try to commit without
>  forking 'git commit'", 17-11-2017).
> 
> During the bisection I stumbled across (several times) the following
> compilation error:
> 
>       CC sequencer.o
>   sequencer.c: In function ‘do_commit’:
>   sequencer.c:1142:9: error: void value not ignored as it ought to be
>        res = print_commit_summary(NULL, &oid,
>            ^
>   Makefile:2105: recipe for target 'sequencer.o' failed
>   make: *** [sequencer.o] Error 1
> 
> which I 'fixed' like so: s/res = //
> 
> So, given that the 'fingered' commit didn't immediately seem to be
> related to the problem, along with the above errors, this may well
> not be the culprit.

I've seen the same unexpected passes, and had just completed the same
bisect run myself, although I fixed the build failure by cherry-picking
82921316a ("SQUASH???", 2017-11-18) onto commits that wouldn't build,
given that commit seems to exist entirely to fix that build breakage.  I
think that adds more weight to b5a812b29 being the culprit for these
unexpected passes.

It's definitely the case that these unexpected passes exist at 8e4ff0ae1
("Merge branch 'pw/sequencer-in-process-commit' into pu", 2017-11-21)
and do not exist at its immediate left-hand parent, e017a4ccc ("Merge
branch 'jn/ssh-wrappers' into jch", 2017-11-21), which means it's
clearly _something_ in the branch merged at 8e4ff0ae1.
