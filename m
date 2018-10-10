Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12D651F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 21:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbeJKEia (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 00:38:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43422 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbeJKEi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 00:38:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id p24-v6so3236663pff.10
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 14:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wkamokD+Xtb7JOtJxtdM0HTPQNgofozTU2tdTdWgrJI=;
        b=o1T9BqH7fcvIJj3v1JHhBcDhpg1R8EKtAY754Cb3l/zo7NpEMlFcvXVWiJnoaQffXZ
         CIjZmxUCSCII/NoxoK5GQGD6aSYcuYagm5HMkG8uXfJoLF7fly/Ry50XWcf5XrdleqmR
         hpF4N8OrhPSQj6utEmPbdAp8j8plQXUmp2JJDwy5ybqOYDJQS9U0pPvp/q9TWPLMqfqy
         ixu0S74PoqRhRINxS5mHdtmUDpO5LQsraNpwOej/D/K6EHr1SXYcVwZRyYbvyZw6m4RQ
         a+Uuik5JRXxTswQylzE9gGaoOay+WsxoAWk07T99CMaNCxBerQhw8g3j0qpZwTUJQzzt
         mLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wkamokD+Xtb7JOtJxtdM0HTPQNgofozTU2tdTdWgrJI=;
        b=NVX9vwYinFf2/nxauD/xzGdxVNGgE2URiV+RThGSjU6HSCtUvRjL9hLoFdqjevYc1G
         Dqwqu4ulSwFoL0DG4YXWHlC3VttQWphzzwWv0dQK1y66R/QjD1DMroPek7uZqFv8wfoc
         S7Vzo29cudS+SSBZqHa8yJp8Qsx1WFzSPGOPzXBwUqbu1dY9RW8PZ0+1ZVqnfVyHDaUY
         7fMonzbEwEqkhSKf6BGcJct41kKT8x0RybZjS21vbWX6YvGLH/wSZNToWfTxIKYwAKak
         RDyqQY5uoznl5GrFOYtkuOozas4lozNNGRN8bG2S0W1z/QzBkT2b3peM38U4JZawKTUN
         wgmA==
X-Gm-Message-State: ABuFfogdGfoQJ9oeKNqxIubJxIOMEwAHrBp5kLekl1DM7BoB28VigmGJ
        pATbnagK6c1CGFrwIFokzPzSeD8a
X-Google-Smtp-Source: ACcGV62CXVphaHLqLJOpb8RxX26LlKjZdRBbG4Fw7AixCo6L71mW9mslGVu5ausNK5LZcrJD3T0U0w==
X-Received: by 2002:a63:5509:: with SMTP id j9-v6mr30566781pgb.208.1539206070770;
        Wed, 10 Oct 2018 14:14:30 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id 20-v6sm25896378pge.77.2018.10.10.14.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 14:14:30 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:14:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] gc: introduce an --auto-exit-code option for undoing
 3029970275
Message-ID: <20181010211428.GA231512@aiede.svl.corp.google.com>
References: <20181010174624.GC8786@sigill.intra.peff.net>
 <20181010192732.13918-1-avarab@gmail.com>
 <20181010205611.GA195252@aiede.svl.corp.google.com>
 <87sh1declw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sh1declw.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

>     Right. I know. What I mean is now I can (and do) use it to run 'git gc
>     --auto' across our server fleet and see whether I have any of #3, or
>     whether it's all #1 or #2. If there's nothing to do in #1 that's fine,
>     and it just so happens that I'll run gc due to #2 that's also fine, but
>     I'd like to see if gc really is stuck.
>
>     This of course relies on them having other users / scripts doing normal
>     git commands which would trigger previous 'git gc --auto' runs.
>
> I.e. with your change that command:
>
>     git gc --auto
>
> Would change to something like:
>
>     git gc --auto && ! test -e .git/gc.log
>
> Which, as noted is a bit of a nasty breaker of the encapsulation

That helps.  What if we package up the "test -e .git/gc.log" bit
*without* having the side effect of running git gc --auto, so that you
can run

	if ! git gc --detached-exit-code
	then
		... handle the error ...
	fi
	git gc --auto; # perhaps also with --detach

?

I'm not great at naming options, so the --detached-exit-code name is
bikesheddable.  What I really mean to ask about is: what if the status
reporting goes in a separate command from running gc --auto?

Perhaps this reporting could also print the message from a previous
run, so you could write:

	git gc --detached-status || exit
	git gc --auto; # perhaps also passing --detach

(Names still open for bikeshedding.)

Thanks and hope that helps,
Jonathan
