Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C65111F404
	for <e@80x24.org>; Thu, 28 Dec 2017 05:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbdL1FXO (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 00:23:14 -0500
Received: from mail-ot0-f175.google.com ([74.125.82.175]:44885 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbdL1FXN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 00:23:13 -0500
Received: by mail-ot0-f175.google.com with SMTP id g59so10162544otg.11
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 21:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecbaldwin.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q8ttULBlTo4AxbH28SRN43ML3PdYzB6jtWarhRmbceM=;
        b=XdD3YzobwbaRHyCxtxdaGtsxNl5NNbZLamdJKwcv9OQIb6Om+ywTn3Qur3Y0zznxSC
         8pbWtosMDeZxhPpwo4sWw64zIhzpScfU/W8o2nQaXzZy7lnist08jvwWGnWskrb99ePp
         XK5Bf0D9oQN01l1+mcPaVESbjeXLHsZCaBY+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q8ttULBlTo4AxbH28SRN43ML3PdYzB6jtWarhRmbceM=;
        b=WHVaifarBmWYNrGsaSKXcMtYLB7h05o0v0WqD0GZv2n5UDnAHhDRH4c5M6XiCzYvAK
         FZQSAi9n1f9gMEjvDfQCkLH/1/jsAD9iS+74TgLorWJZ1lusV/jsTJ3gokZqXLweqqRg
         q8NE1fsXoLlwfSeJbBRLd/U6Vni0zgwiQrgf+oQ/yeX+IzHQnnzRHKxY6VF5amEOcllK
         ZAJ02sT+M+1eGoj5PPcTftaIy9oICoOgMslYwXKFdo/ijbuMdhmnCw9UGFD+PB1JOaoE
         r2dDaaM8kDur1qmIh71cuodzcvsRmmwRSsHQzsoRIIVH/meI06z1FKW1K+UXSLMXaoYe
         vS/A==
X-Gm-Message-State: AKGB3mKlF4jQQrPy+/AmXuDJlLkzUKanzkv3dY5a4nghdc9jTwNLvmV3
        1qomba7NtkaKJqHYh4woxGQT+A==
X-Google-Smtp-Source: ACJfBostycBdmb6zcshVWd7VAddgTuAQ+W2jOnViZX+8Ablldo1AlJRipdrI+D4u51RBXgHOG1AE4g==
X-Received: by 10.157.51.168 with SMTP id u40mr10791731otc.162.1514438592517;
        Wed, 27 Dec 2017 21:23:12 -0800 (PST)
Received: from Carl-MBP ([2600:100e:b02c:f23f:78c2:1eba:9743:953f])
        by smtp.gmail.com with ESMTPSA id x21sm12068004ote.71.2017.12.27.21.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 21:23:11 -0800 (PST)
Date:   Wed, 27 Dec 2017 22:23:08 -0700
From:   Carl Baldwin <carl@ecbaldwin.net>
To:     Alexei Lozovsky <a.lozovsky@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20171228052303.GA33027@Carl-MBP>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <20171225035215.GC1257@thunk.org>
 <20171227043544.GB26579@Carl-MBP.ecbaldwin.net>
 <C82A30ED-D608-4F79-B824-C23DDB078DD9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C82A30ED-D608-4F79-B824-C23DDB078DD9@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 27, 2017 at 03:35:58PM +0200, Alexei Lozovsky wrote:
> I think the reasoning behind Theo's words is that it would be better
> to first implement the commit relationship tracking as an add-in which
> uses commit messages for data storage, then evaluate its usefulness
> when it's actually available (including extensions to gitk and stuff
> to support the new metadata), and then it could be moved into core git
> data structures, when it has proven itself useful. It's not a trivial
> feature which warrants immediate addition to git and its design can
> change when faced with real- world use-cases, so it would be bad for
> compatibility to rush its addition. Storage location for metadata
> seems to be an implementation detail which could be technically
> changed more or less easily. But it's much easier to ignore a trailer
> in commit message in the favor of a commit header field than to
> replace a deprecated commit header field with a better one, which
> could cause massive headache for all git repositories in the world.

Yeah, this is a point that everyone is eager to make instead of really
trying to understand what I'm trying to do and offering constructive
suggestions. It's not that I'm not listening. I'm not really concerned
about headers vs trailers or the asthetics of the whole thing as much as
I'm concerned about how the server / client interaction will be. I worry
that anything that I come up with that isn't implemented in the regular
git core push and fetch will end up being awkward or end up needing to
reimplement a lot of what's already in git. But, maybe it just needs a
little more thought. Let me try to think through it...

Imagine John posts a new change up for review to a review server. The
current master points at commit A and so he grabs it and drafts his
first proposal, B1.

    digraph history {
        B1 -> A
    }

Soon after posting, he notices a couple of simple errors and uses the
web UI to correct them. This creates B2. (Dashed edges are replaces
references).

    digraph history {
        B1 -> A
        B2 -> A
        B2 -> B1 [ style="dashed"; ]
    }

Anna reviews B2 and finds a small nit. She asks John if she can just fix
it and push up a new review. He agrees. She pushes up B3.

    digraph history {
        B1 -> A
        B2 -> A
        B3 -> A
        B2 -> B1 [ style="dashed"; ]
        B3 -> B2 [ style="dashed"; ]
    }

John goes back to his workspace and does a little more work on B. He
creates the fourth revision, B4 but since he didn't update his workspace
with the other two most recent revisions, his new revision is derived
from B1.

    digraph history {
        B1 -> A
        B2 -> A
        B3 -> A
        B4 -> A
        B2 -> B1 [ style="dashed"; ]
        B3 -> B2 [ style="dashed"; ]
        B4 -> B1 [ style="dashed"; ]
    }

John then pushes to the server. I imagined that would be a command
similar to what gerrit does.

    git push codereview refs/for/master

At this point, I want a couple of things to happen. First, the server
should be able to match the new revision to the change by following the
replaces references to the commits it already has. Then it should
recognize that this is not a fast forward update to the change and
reject it on those grounds.

After that, John needs to be able to fetch B2 and B3 so that his local
client can perform a merge. I guess John needs to know what change he's
trying to fetch. In this case, he needs to fetch both B2 and B3 in order
get the full history graph of the change. The problem I see here is that
today's git fetch would see B2 and B3 as unrelated branches. There could
be any number of them to fetch. So, how does he ask for everything
related to the change? Does he do a wild card or something?

    git fetch codereview refs/changes/123/*

Or does he just fetch all refs (this could be many on a busy review
server)? Or do we need to do something out of band to discover the list
of references that need to be fetched?

I've been thinking out loud a bit. I guess this could be a path forward.
I guess to make gc happy, I've got to keep around a ref pointing at each
new revision so that it doesn't get garbage collected.

Carl
