Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78FC21F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 21:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeJJE4Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 00:56:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35486 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJE4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 00:56:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id w5-v6so3415874wrt.2
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 14:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=S6LBCoUG1MDNpbS+EVpsr9HxZNEGCWP8UsYY0aOZvE4=;
        b=pfZ/F/JaMF179H4yfsfR5Hr8m09MvqzmsCdmf7/1aDXuND6X55Xz40jl9aMIUzwfU9
         cZU1A1s7N1sLaS1ajAhSvXSGtvTooPX52tEftqJzc5dl/ffQ90p+xpGgaQpHE14kaeoD
         qmgsyEXuH0nxhsmBujJrbaeYXPL3TuIy+6hpS/q47sCthd840WOBnChChYrH2UnmwR9I
         0W5jnnrPT7ufZVxDnN7x/bjyGmE0kOZAcQJ1HlK7DJ7UQqp84Vq3RK0vJGT+iCaNCua1
         TVnH/GkN8vsH7WQz6GeHOZF/Tw5sC84bGChhCrAPTpv6rqGdmaYv8YYKXNZL2Ksbiaxe
         svGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=S6LBCoUG1MDNpbS+EVpsr9HxZNEGCWP8UsYY0aOZvE4=;
        b=AdSu27+IYnpFnPoGAwcpvq8lGF/KeZxTtd6W+bwoebmLBKSJRDOqb9EnlwIaDKi+VN
         Ly5VEnS0EpmMxSmMZ7MDJgRCdLXhztFXP5a1TDxO99SfzCPpkEgb2JWpZ510J+UkgJW1
         IG+XRiaPjzwhydtWzvz29kdpRHhM/4dM4KQlaNEZHgnqw4btiHcUTVk49wHFkld1hOcA
         r9DnzDF7c7kGdPWxioFGNA38bmSLhmAYzZPwcgJ2QLAdIJhQghB8snuGENXvWOBTfuuQ
         6tc0OORPNnDLTHhbdw/ou6Y87HpmMIIgu/DtXqiLXOyg7DijBbRVmktgw5RP+gdwbGBi
         eRtQ==
X-Gm-Message-State: ABuFfohoqiQ1zsH+7KCVYCeeo8OS/VPuFx128ocVq7yRqVE3YSmxcr/b
        xeYbK6fR2oEitJ2+Qx3aFi300UOv
X-Google-Smtp-Source: ACcGV62+Li1M9Hd26pNfWNQMaUnr78o/vrjfHrabckIJNUKIK+F/9VI7BkX2ynMQ8nFwBkn4Qz39yQ==
X-Received: by 2002:adf:8547:: with SMTP id 65-v6mr19122328wrh.69.1539121047557;
        Tue, 09 Oct 2018 14:37:27 -0700 (PDT)
Received: from szeder.dev (x4dbd5132.dyn.telefonica.de. [77.189.81.50])
        by smtp.gmail.com with ESMTPSA id 62-v6sm27053284wra.48.2018.10.09.14.37.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 14:37:25 -0700 (PDT)
Date:   Tue, 9 Oct 2018 23:37:24 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] commit-graph: write a Bloom filter containing
 changed paths for each commit
Message-ID: <20181009213724.GC23446@szeder.dev>
References: <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
 <20181009193445.21908-1-szeder.dev@gmail.com>
 <20181009193445.21908-3-szeder.dev@gmail.com>
 <20181009210620.GA9563@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181009210620.GA9563@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 09, 2018 at 05:06:20PM -0400, Jeff King wrote:
> On Tue, Oct 09, 2018 at 09:34:43PM +0200, SZEDER Gábor wrote:
> 
> > Creating the Bloom filter is sloooow.  Running it on git.git takes
> > about 23s on my hardware, while
> > 
> >   git log --format='%H%n%P' --name-only --all >/dev/null
> > 
> > gathers all the information necessary for that in about 5.3s.
> 
> That command won't open the trees for merges at all. But your
> implementation here looks like it does a diff against each parent of a
> merge.

Yeah, it does so, because that is what try_to_simplify_commit() /
rev_compare_tree() will do while traversing the history.

> Adding "-m" would be a more accurate comparison, I think.
> 
> Though I find that puzzling, because "-m --name-only" seems to take
> about 20x longer, not 3x. So perhaps I'm missing something.

Ugh, indeed.

