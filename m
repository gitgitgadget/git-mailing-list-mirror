Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F1B61F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 22:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeJKFtl (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:49:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37943 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKFtk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:49:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id q19-v6so97560pll.5
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 15:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pc9iaRNkHL+uMTs9iZtS+8+XZjBR01Lyu2MFudq6nX4=;
        b=MhELrkiXQ61/ZZTd5Syj7WeR2edhwgkHQjZV/UEDDH+u57YvO1a0Z77oZwTW0YN4bW
         VvV5F+52N+8lE4tX5kZt8+JrY7bMRrvg9ss3hvnRDC114A5j/jH1U14ztNbSOjIBZoZ8
         VvQjotoOGg6QKvxe30OrKzaGVHo36IBtrHvT1aYiiWHFJn+/WdtBxw2XOden1ZvkFssH
         c38yRT+gJJREwcLXECSUSUvrgwSs2ZXCw6F3Tr/MWJoL+5I5aqcExb6SaC64JdLSpQ4t
         z3nYgIF4WyBQVDthAP73SLoFppsqWDntzfnUqfr8xwIAZ7vJPbnk/NuwId+zRhVxyJ4X
         EtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pc9iaRNkHL+uMTs9iZtS+8+XZjBR01Lyu2MFudq6nX4=;
        b=HGIMKEDXIeBzDCMTnyLvLtW++uLh1TDDJkkFsPE537Q639vjtrQZRoPfFQhA5F76X9
         bCJYpUaZ4wjLEqEf5tga+9I32KyoOMIlQ+JGrRrIoC1Ps7d0VLL15YQQHwIkvSD0IgJG
         UKwC+pUo/2HN68JHEQwgS8ZPcm4PxJRJmJwq+UHKoGk1VNP3GNQzrawm0XaaaK7VXTjW
         VZh88nDoOfztZD8fZg31p/SUTGG6t8BUhKd+VU7a9fc323sudaGmG6xngp5JCEw6AiPo
         VyPZSi73OTrGyWhqwVaskbGCB7ZRc5h5AzjJk9GrP5sfCURy9m4HVSXODg7EP7Bh5Nmt
         UOmQ==
X-Gm-Message-State: ABuFfogXrmEgi6nsyLHJgzExhu8/fSTTpuUql/LzGBA3JpSxx4DaVpLq
        XY4nF5cGKprr6inWMjoMHXjWy4Pq
X-Google-Smtp-Source: ACcGV61kGsOSr4UzAe/nqffWMXRAfZJgwc0LGZnWW1SHhVksQ+nSBC8r9oiTiY/I5VMDKIWVJ7v5uQ==
X-Received: by 2002:a17:902:7442:: with SMTP id e2-v6mr1236405plt.314.1539210328927;
        Wed, 10 Oct 2018 15:25:28 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id v190-v6sm37551148pgb.16.2018.10.10.15.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 15:25:28 -0700 (PDT)
Date:   Wed, 10 Oct 2018 15:25:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] gc: introduce an --auto-exit-code option for undoing
 3029970275
Message-ID: <20181010222526.GC231512@aiede.svl.corp.google.com>
References: <20181010174624.GC8786@sigill.intra.peff.net>
 <20181010192732.13918-1-avarab@gmail.com>
 <20181010205611.GA195252@aiede.svl.corp.google.com>
 <87sh1declw.fsf@evledraar.gmail.com>
 <20181010211428.GA231512@aiede.svl.corp.google.com>
 <xmqqin29lc0s.fsf@gitster-ct.c.googlers.com>
 <20181010215143.GB231512@aiede.svl.corp.google.com>
 <87o9c1e9br.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o9c1e9br.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

> Which is what I'm doing by running "gc --auto" across a set of servers
> and looking at the exit code. If it's been failing I get an error, if
> there's no need to gc nothing happens, and if it hasn't been failing and
> it just so happens that it's time to GC then fine, now was as good a
> time as any.

For this, a simple "git gc --detached-status" would work.  It sounds
like the bonus gc --auto run was a side effect instead of being a
requirement.

> So if we assume that for the sake of argument there's no point in a
> --detached-status either. My only reason for ever caring about that
> status is when I run "gc --auto" and it says it can't fork() itself so
> it fails. Since I'm using "gc --auto" I have zero reason to even ask
> that question unless I'm OK with kicking off a gc run as a side-effect,
> so why split up the two? It just introduces a race condition for no
> benefit.

What I am trying to do is design an interface which is simple to
explain in the manual.  The existing "git gc --auto" interface since
detaching was introduced is super confusing to me, so I'm going
through the thought exercise of "If we were starting over, what would
we build instead?"

Part of the answer to that question might include a

	--report-from-the-last-time-you-detached

option.  I'm still failing to come up of a case where the answer to
that question would include a

	--report-from-the-last-time-you-detached-and-if-it-went-okay\
	-then-run-another-detached-gc

option.

In other words, I think our disconnect is that you are describing
things in terms of "I have been happy with the existing git gc --auto
detaching behavior, so how can we maintain something as close as
possible to that"?  And I am trying to describe things in terms of
"What is the simplest, most maintainable, and easiest to explain way
to keep Ævar's servers working well"?

Jonathan
