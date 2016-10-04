Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8894920986
	for <e@80x24.org>; Tue,  4 Oct 2016 22:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbcJDWLa (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 18:11:30 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35274 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752503AbcJDWL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 18:11:29 -0400
Received: by mail-pa0-f49.google.com with SMTP id ik13so23907190pac.2
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 15:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6wiuckYF4opNOY1yaeAhREeG88p55+ZrU5kWTYugy4c=;
        b=JFN7WscNS90GanctNPRAmFvBLLI7rrgrfk9XRvEvnN9VKcqcApBP411yFkPImdwLwK
         2lz+HZiUjANOPNRKpbHLb6QzK7ynFP7j+WIWE6v8kxiEY48B1bfpdnrrgJ1eB2W6v1lo
         PEuykYY2MGCeHFfhBraFgYA8+OkTbbWf29YlOIExrwgd9ixJPct9TjiinEtF3UYyTudZ
         DIV97iCIT/jQ7UiBFqwGbqKommxAedb6idL2mAaY6/bbt27lgwJbptuEbiomJ2jNGpfw
         rAzz2obra4YYnwJXnNIYukK/WtlOxK6VqodrU2NlMxLv789hyiSsxf7PvoKvUoOuoDvK
         U9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6wiuckYF4opNOY1yaeAhREeG88p55+ZrU5kWTYugy4c=;
        b=ILHY0nW+5rMRc5aGyMoOVgQG0LFIZnBCJiS6myGcUv87rvzIHgvNqL9o/nk8AOPtmc
         lWgJI1FGvptPnnjp8cVSVyIgDLSj3HkdQ/k9KuaDaPSM8tgx8eAGPHxj14AnHQMb/8+7
         v5oyWC8n25Bmj0B1V5ow6kDHrJA5OWYr7sEXqnFkkWkfk6lA0/ZQ+WAgHZO1MdII/dNd
         JzxY9tczhNOjs3xoP06ke1BU3v9WvF0RzjmM9psX+j8tZftzdiWpct32EmzbRFRIN7vX
         kfT+nA+SWpJc5AB/myLcI7+e8BRb+Fzz8VuBppexEo85VdNT1mEUSj81hsQ1qmxXbTib
         YBOg==
X-Gm-Message-State: AA6/9RnclT+EWEf9X0UPesW45CvYBKlLPYPRIrrkMFNSdn8DluVrmc1LydGq+fQXK6WmDg==
X-Received: by 10.66.184.74 with SMTP id es10mr8462982pac.187.1475619088986;
        Tue, 04 Oct 2016 15:11:28 -0700 (PDT)
Received: from localhost (110-174-57-143.static.tpgi.com.au. [110.174.57.143])
        by smtp.gmail.com with ESMTPSA id v6sm9257603pfv.8.2016.10.04.15.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2016 15:11:28 -0700 (PDT)
Date:   Wed, 5 Oct 2016 09:06:25 +1100
From:   James B <jamesbond3142@gmail.com>
To:     musl@lists.openwall.com
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Rich Felker <dalias@libc.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [musl] Re: Regression: git no longer works with musl libc's
 regex impl
Message-Id: <20161005090625.683fdbbfac8164125dee6469@gmail.com>
In-Reply-To: <alpine.DEB.2.20.1610041802310.35196@virtualbox>
References: <20161004150848.GA7949@brightrain.aerifal.cx>
        <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
        <20161004154045.GT19318@brightrain.aerifal.cx>
        <alpine.DEB.2.20.1610041802310.35196@virtualbox>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.31; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 4 Oct 2016 18:08:33 +0200 (CEST)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> 
> No, it is not. You quote POSIX, but the matter of the fact is that we use
> a subset of POSIX in order to be able to keep things running on Windows.
> 
> And quite honestly, there are lots of reasons to keep things running on
> Windows, and even to favor Windows support over musl support. Over four
> million reasons: the Git for Windows users.
> 

Wow, I don't know that Windows is a git's first-tier platform now, and Linux/POSIX second. Are we talking about the same git that was originally written in Linus Torvalds, and is used to manage Linux kernel? Are you by any chance employed by Redmond, directly or indirectly?

Sorry - can't help it.
