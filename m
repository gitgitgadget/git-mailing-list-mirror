Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81FB81FD99
	for <e@80x24.org>; Sat, 20 Aug 2016 19:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751260AbcHTT6G (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Aug 2016 15:58:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34323 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbcHTT6F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2016 15:58:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so7727582wma.1
        for <git@vger.kernel.org>; Sat, 20 Aug 2016 12:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=CAoobm2FQr1ZugJB3SuAZQKgj0PaNW8rEFo4qQe6EKE=;
        b=OHge8l/4VZ152F4nE+UATj9+HSGDIRJWei5csHnNMBJJLF6BrSFdXP5FaYGOZUtJwd
         npVQnaNvuMQNDbXOMHx+kSiDA4Omp1bqrqYHGseVYOW0nNJfd+s4hX53EEe9TTaUlNnu
         vLDC0qz2nf+RvuscPma4X94QYycaOhkCW7Lw6MI+fP0SwfpFySd4arIw88KY7bp8yFsB
         qI3+NG5wBK7Ab5joMmXPy0XNZIoWUCZrYbz3ELj02VEqi1LngJtlzGxLMY94S8w2ciEf
         w/6zOO8XKeExDavuL7VxyVrhW/xiOCtIIVMJq7QLkKBxvr8vOBbUBZfIwF+ZSwhq5zRm
         +NPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=CAoobm2FQr1ZugJB3SuAZQKgj0PaNW8rEFo4qQe6EKE=;
        b=Co3OHzFCfHfS2FiYmI2wvmuSApCR8dnbzvP4YuZ67nL1/24ahMe+eq/j/fwTDgdkdK
         mNWgVODR/nSiJyL8YeTWvTQLYTUi5DUM6/R/RQqvbipjJqitua+q2iv6zFeNnKZhMuMh
         w4pLoQlXa0QlLPLIHH75dzEvP4E7eGlRVf0AeBweMZTMHQMHIp+8TYLbIQxljzayLiGo
         6Dr4chQKRYG27JKH33H9GJQHIoTN/p/CaYBLi25Q/PR+2Tw0u5fNBSRwIg3jr2fjgKcD
         t1dN1nq/AybReDluNlaQMYj2R9cv7N5j1nrFF6JMVmbiyZLMV2czVjsVDYzODyIq1uEA
         pYZQ==
X-Gm-Message-State: AEkoousisxVIR2MxSajX7UiVuXwHuBngvnznldTCOs+WHE6Wk+jY62LUj+bEmou6kHH2hA==
X-Received: by 10.28.154.208 with SMTP id c199mr9159418wme.102.1471723083445;
        Sat, 20 Aug 2016 12:58:03 -0700 (PDT)
Received: from [192.168.1.26] (adap46.neoplus.adsl.tpnet.pl. [83.11.251.46])
        by smtp.googlemail.com with ESMTPSA id qe2sm13697565wjc.28.2016.08.20.12.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Aug 2016 12:58:02 -0700 (PDT)
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160819150340.725bejnps6474u2e@sigill.intra.peff.net>
Cc:     Stefan Beller <sbeller@google.com>, meta@public-inbox.org,
        git@vger.kernel.org, Eric Wong <e@80x24.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <46a5b9b6-f3f6-7650-8a5b-b0b52223e375@gmail.com>
Date:   Sat, 20 Aug 2016 21:57:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160819150340.725bejnps6474u2e@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 19.08.2016 o 17:03, Jeff King pisze:
[...]
 
> There is nothing wrong with building tooling around your workflow. If we
> had a GitHub-based workflow, I'd build tooling around that, too. One of
> the things I _like_ about a mail-based workflow is how easy it is to
> build that tooling, and to get it to integrate with other existing
> tools. It's the major reason I'm resistant to moving development to
> GitHub. Not only would I have to throw away all of my tools, but I'm not
> sure I could easily build equivalent ones.

Also, you would have the same problem with tooling around specific Git
hosting site as there is with tooling around specific email client.
Tool that works with GitHub (like submitGit) won't work with Bitbucket
or GitLab.

Well, unless such tooling was built in in all hosting sites.  They have
support for sending mails anyway, isn't it?

But perhaps the problem is current lack of tooling in the opposite direction,
namely getting patches from mailing list and applying them to GitHub repo,
or Bitbucket, or GitLab.  Though with working Git, it is something easier
than sending patches via email; it is enough that email client can save
email to a file (or better, whole sub-thread to file or files).

Also, there is lack of tools that convert inline (in-diff) comments on
GitHub (or Bitbucket, or GitLab) to email with review...


There is also distrust for centralized solutions (email is, in principle,
decentralized).  See projects like https://solid.mit.edu, etc.

> Now, I am perfectly open to the idea that more of the tooling should be
> standardized, so people do not have to build their own. But the major
> problem there is that so much of what I've built is about gluing things
> together for the rest of _my_ tools. I've shared my techniques and
> scripts for using mutt several times, but they don't do somebody a lick
> of good if they are using gmail or thunderbird.

It would be nice to have links to those tools in SubmittingPatches and/or
the Git homepage.

[...] 
> PS There _are_ some open questions in our workflow that are not really
>    mailing list specific. E.g., the fact that it is hard to see whether
>    and if your patch was picked up by Junio, what changes were made,
>    tracking multiple versions, etc. I _don't_ have good tooling for
>    that, but it's something that could be made generally available, as
>    it's unrelated to the MUA. It's also not necessarily specific to
>    mailing list development (e.g., a push-based workflow that
>    aggressively rebases runs into the same versioning questions).

Well, "What's cooking ..." and 'pu' branch helps, I think.

-- 
Jakub Narębski

