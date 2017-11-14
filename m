Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2B351F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 20:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753626AbdKNUCM (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 15:02:12 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:53263 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbdKNUCL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 15:02:11 -0500
Received: by mail-io0-f172.google.com with SMTP id 189so25665846iow.10
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 12:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8wlqOMi1LVvkzi9ymNyW24LM888dSJmcPFkKGkedYbo=;
        b=ZGijWLblqA57bFDmWahd28LQQYS7yXzWfBDpONT7cy5PfxlbEEikTBP49VQwSSTwYx
         zXuG2qzn5psiojlIpd8godt5vizTBK31Q2C39zYKPvD7ysgXAcoUHjCutvZY4jmjY5ca
         3TXYReXGySDi7lBPEpOsqUl7BcoOuBIgTtV7gs4t18EixH+Y30tbUtDMrvbtUL/3Xmx9
         A58Vjso5j549w7H5YG6kMTjA4In3pT/SH9CigxOasirUAFPMbbygTN3PI8N2UFKNfXfO
         uZXuq3NILLHmUm9RALxoYwwq4+zvZkus2DO4w+NSi7Z9DEPzM+ZFqQjmjN65HptgCbJf
         mOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8wlqOMi1LVvkzi9ymNyW24LM888dSJmcPFkKGkedYbo=;
        b=kM51lcRW5nQcdKCd9HYV1Lv8ctjq6+SvQfd1/5HoGdOX1V+jvhVxkqG2RL3zMFXagu
         10PY2G6s/V/kzHZWRZxrOMQdwT2cgR9Khp3V4Jt7nJbhqgK842HM5tYL9F0SZC9Yt9TI
         MuN5s1/cduoN39MprfaqwuUiG3AfwYSsX9duaRxGX+rYZy4Pf+ar1uqD3R3QaelaqkyN
         Ya3yyq4nyF4gdCQkJHgt1LC+LT6UCqElIt7s7v4BAhV7O16fltkiRRVc5Y/Q7qN2cyFS
         pprUViTL8qKNlxof8Dk/ZW8HZcCn7/ju9tneYYNjQeWlaGiItW+7eQvCBWNLtEpnxDso
         KAyw==
X-Gm-Message-State: AJaThX6oH0vKysaZozTDb41I5c/DO9vvtV1d9Haa0t2xd/mt1TidgRP7
        2zIj9f6Kl16XHGU14+wUSnXXfa76szI=
X-Google-Smtp-Source: AGs4zMZKAj8TkEOeMwK76MUqvM0NncERfS8LBDwTs1KljNOwNwLtU8D4T2SHs9eLGb60VCwRQWe/bg==
X-Received: by 10.107.145.10 with SMTP id t10mr4310681iod.190.1510689730128;
        Tue, 14 Nov 2017 12:02:10 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:9ca7:c33c:854a:a353])
        by smtp.gmail.com with ESMTPSA id f79sm2345442ioj.60.2017.11.14.12.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Nov 2017 12:02:09 -0800 (PST)
Date:   Tue, 14 Nov 2017 12:02:08 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info, schwab@linux-m68k.org
Subject: Re: [PATCHv3 7/7] builtin/describe.c: describe a blob
Message-Id: <20171114120208.d0570f20672f117bcf8e5396@google.com>
In-Reply-To: <20171102194148.2124-8-sbeller@google.com>
References: <20171031211852.13001-1-sbeller@google.com>
        <20171102194148.2124-1-sbeller@google.com>
        <20171102194148.2124-8-sbeller@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu,  2 Nov 2017 12:41:48 -0700
Stefan Beller <sbeller@google.com> wrote:

> Sometimes users are given a hash of an object and they want to
> identify it further (ex.: Use verify-pack to find the largest blobs,
> but what are these? or [1])
> 
> "This is an interesting endeavor, because describing things is hard."
>   -- me, upon writing this patch.
> 
> When describing commits, we try to anchor them to tags or refs, as these
> are conceptually on a higher level than the commit. And if there is no ref
> or tag that matches exactly, we're out of luck.  So we employ a heuristic
> to make up a name for the commit. These names are ambiguous, there might
> be different tags or refs to anchor to, and there might be different
> path in the DAG to travel to arrive at the commit precisely.
> 
> When describing a blob, we want to describe the blob from a higher layer
> as well, which is a tuple of (commit, deep/path) as the tree objects
> involved are rather uninteresting.  The same blob can be referenced by
> multiple commits, so how we decide which commit to use?  This patch
> implements a rather naive approach on this: As there are no back pointers
> from blobs to commits in which the blob occurs, we'll start walking from
> any tips available, listing the blobs in-order of the commit and once we
> found the blob, we'll take the first commit that listed the blob.  For
> source code this is likely not the first commit that introduced the blob,
> but rather the latest commit that contained the blob.  For example:
> 
>   git describe v0.99:Makefile
>   v0.99-5-gab6625e06a:Makefile
> 
> tells us the latest commit that contained the Makefile as it was in tag
> v0.99 is commit v0.99-5-gab6625e06a (and at the same path), as the next
> commit on top v0.99-6-gb1de9de2b9 ([PATCH] Bootstrap "make dist",
> 2005-07-11) touches the Makefile.
> 
> Let's see how this description turns out, if it is useful in day-to-day
> use as I have the intuition that we'd rather want to see the *first*
> commit that this blob was introduced to the repository (which can be
> achieved easily by giving the `--reverse` flag in the describe_blob rev
> walk).

The method of your intuition indeed seems better - could we just have
this from the start?

Alternatively, to me, it seems that listing commits that *introduces*
the blob (that is, where it references the blob, but none of its parents
do) would be the best way. That would then be independent of traversal
order (and we would no longer need to find a tag etc. to tie the blob
to).

If we do that, it seems to me that there is a future optimization that
could get the first commit to the user more quickly - once a commit
without the blob and a descendant commit with the blob is found, that
interval can be bisected, so that the first commit is found in O(log
number of commits) instead of O(commits). But this can be done later.
