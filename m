Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 037291F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 21:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbeJKFPw (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:15:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36562 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeJKFPv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:15:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id y11-v6so3144575plt.3
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 14:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M47+UlcmQQYiwHwypJU/H/Mc8KKxXhnS3KcKyCK6Wh8=;
        b=DBOHnPxpEHMRWcOmgDxf0Jjl4KeLiqzXLoQR4gvdDPOGWl3NXram++AIl02748JNqM
         EAs5dAjqwxAsfKZQje6wCgDrO36FcBu/hemL2l9JlMiIrD8144fKG2wipnDzLKYMFKBy
         r9XqyOPzzaWUwPtZWj+Bmnj1IBnV7UBRmw+NA9LuVjc8OJ3Wli9HEyETdXwYOLyntg1R
         wC9wtTbe+xSU4zPtkp+Ob1t1UcwvQvqeyx5oocSRmLhF2k6Kf4r0TQRblSx3YPIkCl5b
         PXks08fp06aWLCEhKugo4EAJJ63Am7W9kJn8o7S6nWflXIOxD+MZO9jvp4+3dYaxYDWa
         3Q4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M47+UlcmQQYiwHwypJU/H/Mc8KKxXhnS3KcKyCK6Wh8=;
        b=jxWdpEAL4fN6241pOGwNw/Sj3/YGCWwkqOKquTkIeA7md6YbpKy4+QnXguogY3YkdV
         osMWic6V3GBgX7+YR3zsIq8gjHKvlA5d3xSMDYovD7WlPB/OF/4OHe9aqWZDmH39KVYs
         Sz6WIhGQaRTbo4FqUS5KELZLjQ9jj2Xc29ZRL2qRxUXn6m/+NEJGEDEkZfKBnmvKJUH/
         AFp7zC5PTo+enAMaS8ogUFg5aG/tIfFV0JTs1MEQjydKZQ5jmXP7HAZ3oH+JHmCKAjGn
         w7p9qjfJf1u/1DLqvbxpystCY56vzEtFCaZr80o9GrWm8DIVz+TVniC+UDW4YC+jBOQ/
         ofOg==
X-Gm-Message-State: ABuFfohPKrTvOwR78Gus1rQMHe5bT2SO0h9m4OC20eo+jn5h7jJSA4BY
        u2M+AdF5mBBJrPmHYggod74=
X-Google-Smtp-Source: ACcGV62Bh5Db+av1127YMGCxBFrCCfHcFpMKcztvkrpw5d2Ny9wTwECzxpRrmRrzaLLW60X2tymOmQ==
X-Received: by 2002:a17:902:b7cb:: with SMTP id v11-v6mr34707403plz.79.1539208305801;
        Wed, 10 Oct 2018 14:51:45 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id a86-v6sm35369813pfg.106.2018.10.10.14.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 14:51:45 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:51:43 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] gc: introduce an --auto-exit-code option for undoing
 3029970275
Message-ID: <20181010215143.GB231512@aiede.svl.corp.google.com>
References: <20181010174624.GC8786@sigill.intra.peff.net>
 <20181010192732.13918-1-avarab@gmail.com>
 <20181010205611.GA195252@aiede.svl.corp.google.com>
 <87sh1declw.fsf@evledraar.gmail.com>
 <20181010211428.GA231512@aiede.svl.corp.google.com>
 <xmqqin29lc0s.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqin29lc0s.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Perhaps this reporting could also print the message from a previous
>> run, so you could write:
>>
>> 	git gc --detached-status || exit
>> 	git gc --auto; # perhaps also passing --detach
>>
>> (Names still open for bikeshedding.)
>
> When the command is given --detached-exit-code/status option, what
> does it do?  Does it perform the "did an earlier run left gc.log?"
> and report the result and nothing else?  In other words, is it a
> pure replacement for "test -e .git/gc.log"?

My intent was the latter.  In other words, in the idiom

	do_something_async &
	... a lot of time passes ...
	wait

it is something like the replacement for "wait".

More precisely,

	git gc --detached-status || exit

would mean something like

	if test -e .git/gc.log	# Error from previous gc --detach?
	then
		cat >&2 .git/gc.log	# Report the error.
		exit 1
	fi

>                                              Or does it do some of
> the "auto-gc" prep logic like guestimating loose object count and
> have that also in its exit status (e.g. "from the gc.log left
> behind, we know that we failed to reduce loose object count down
> sufficiently after finding there are more than 6700 earlier, but now
> we do not have that many loose object, so there is nothing to
> complain about the presence of gc.log")?

Depending on the use case, a user might want to avoid losing
information about the results of a previous "git gc --detach" run,
even if they no longer apply.  For example, a user might want to
collect the error message for monitoring or later log analysis, to
track down intermittent gc errors that go away on their own.

A separate possible use case might be a

	git gc --needs-auto-gc

command that detects whether an auto gc is needed.  With that, a
caller that only wants to learn about errors if auto gc is needed
could run

	if git gc --needs-auto-gc
	then
		git gc --detached-status || exit
	fi

> I am bad at naming myself, but worse at guessing what others meant
> with a new thing that was given a new name whose name is fuzzy,
> so... ;-)

No problem.  I'm mostly trying to tease out more details about the use
case.

Thanks,
Jonathan
