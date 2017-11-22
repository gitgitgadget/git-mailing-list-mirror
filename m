Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71E6520954
	for <e@80x24.org>; Wed, 22 Nov 2017 17:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbdKVRBd (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 12:01:33 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:46662 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbdKVRBc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 12:01:32 -0500
Received: by mail-wm0-f43.google.com with SMTP id u83so11810497wmb.5
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 09:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9uFJSlcTiiMjsHf7H4UGX4wUX7M0xiJDzx8zVv9Vb6A=;
        b=hKH3+AGHGlKRii6idJVHqq8I0h5OCzEviZsh7wC8N9wF7voEDu/6Jb7YZnB1BEYRLW
         zQjEJk6KSPcqyKVHJtLAaufo2o3ehSzDTY9YRHJbaiY7s/WC0oi6cuTXWiHH3RmCNMv1
         HsadkfKu23SEi4gqqr9E2dM9gb105e3UC4/bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9uFJSlcTiiMjsHf7H4UGX4wUX7M0xiJDzx8zVv9Vb6A=;
        b=oFK6eBcHXrouDJhushatMDjjHyEnAMRYBKe2tIYLRuAO7k2/FK8jEQI/RmQA3V2LsA
         OkQdXPfO8uSS265s6ACDjSY7zebOYvxER5eYz7EmzJpCWlnWNgk3r/Iggxa46XQeNtR7
         Ud4oebk2sqRAmzGQI3nxOq7OKC8+HZjONLShQyDxWTYydPTJ1tZoIMIpIXzvXhAYSFOV
         FW8RXqSceeT96icZ6ujpvYjrFkqXJcqu9ntbipaHgbNyGOl5NxeEDhLK1M/+65oWcp6u
         4Tf6tSXs5b30zJBTZIlwi2TfCdieuz7xPWSqLIdbLl/Aq+qrXzX+FvPA3Qpe/mBzO1iO
         WVpQ==
X-Gm-Message-State: AJaThX4fYuW4TBHN5yg6C9ExJMZtyy/jhJpO0kSEsmz2eBkI05QPrb6M
        poWTcfzV6ZZMfpRLwJM+zcYk7Q==
X-Google-Smtp-Source: AGs4zMaMRBB037kbZlHdb8JAoXKmSSBcqgf9b1vLUkvyovVGd1qVr5L2kNL0Vl7sFMyaVxWkObBYFw==
X-Received: by 10.28.71.5 with SMTP id u5mr1606821wma.84.1511370091645;
        Wed, 22 Nov 2017 09:01:31 -0800 (PST)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id r71sm5160119wmd.20.2017.11.22.09.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2017 09:01:30 -0800 (PST)
Date:   Wed, 22 Nov 2017 17:01:29 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Bisect marking new commits incorrectly
Message-ID: <20171122170129.GS20681@dinwoodie.org>
References: <20171122143902.GO20681@dinwoodie.org>
 <CAP8UFD35-z9qA_m28EbpvN-X_HVcDvEirn69DJNESikJ=Txg7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD35-z9qA_m28EbpvN-X_HVcDvEirn69DJNESikJ=Txg7g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 22 November 2017 at 05:21 pm +0100, Christian Couder wrote:
> On Wed, Nov 22, 2017 at 3:39 PM, Adam Dinwoodie <adam@dinwoodie.org> wrote:
> > In trying to do a bisect on the Git repository, I seem to have come
> > across surprising behavior where the order in which `git bisect` appears
> > to forget that previous commits were marked as new.
> 
> Yeah, the algorithm uses many "old" commits and only one "new" commit.
> 
> [...]
> 
> > As you can see, in both cases, only the most recent "new" command
> > appears to have any effect.  I'd have expected that both commits would
> > have been marked as "new", and the bisect run would use both facts to
> > work out which commit is the target of the bisection.
> 
> I didn't look at your test case, but the algorithm to find another
> commit to test is described here:
> 
> https://git-scm.com/docs/git-bisect-lk2009.html#_bisection_algorithm
> 
> and you can see that the first rule of the algorithm is to keep only
> the commits that are ancestors of the "new" commit (including the
> "new" commit itself).
> 
> The reason for this rule is that other commits cannot have introduced
> the behavior we are looking for. The result of this rule is that git
> bisect will always ask you to test a commit that is an ancestor of the
> "new" commit.
> 
> So if you test a commit that git bisect asks you to test, and it
> appears that this commit is "new", then you can just discard the
> previous "new" commit because it will give you less information than
> the new "new" one.
> (The old "new" will not let you discard any commits that the new "new"
> commit allows you to discard, because it is a descendant of the new
> "new" commit.)
> 
> If you don't test the commit that git bisect asks you to test, then
> git bisect assumes that you know better and discards the old "new".

Ah, that makes sense, thank you for the explanation.

In my case, I knew two commits were "new", but didn't know which would
provide more information to the bisect algorithm; I'd assumed if I
provided both, Git would work out the appropriate thing to do with the
combined information without me needing to work it out.

> > This is using v2.15.0.  It's possibly relevant that 95a731ce is a
> > direct parent of 14c63a9d.
> >
> > Is this a bug, or intentional behaviour?  Am I missing something that
> > means it's actually sensible to have Git silently discard some bisect
> > commands in this sort of circumstance?
> 
> Well, instead of silently discarding a the old "new" commit when the
> new "new" commit is not an ancestor of it, git bisect could perhaps
> warn or ask you to confirm that you know what you are doing.

Warning the user seems a sensible suggestion to me.  I'll add it to my
list of things to spend some time on at some point in the future :)
