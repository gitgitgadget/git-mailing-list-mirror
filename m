Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 094EB1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 08:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbfKHIXP (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 03:23:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37091 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfKHIXO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 03:23:14 -0500
Received: by mail-pg1-f194.google.com with SMTP id z24so3530051pgu.4
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 00:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tv00s6K0SlUYBIFVBtWZY0iBuXYnkHiElY4xiwfj3pQ=;
        b=ixrjDysRhcPKD9U2DOFAAlZUXQQyk3OahvUqFj4pU7MUejqOc8I9hDaJFhUWCXwsVJ
         licDwaUVq5uyaRiPLQILD7WhmiiKPiH2gOutTDgFc1eq6xxMONk6IStHrydZhcA+WRVa
         WPGm7SvM4/2p8ihFwDIrpvmFb+V1k2pxwwXwcYjlBDNaJxOD4dumTxZZyE3yjOqxzLVe
         cgGjH7AeEhp6fRGiBudjAMCkzJiXuT6PczkAoYleorzmjOG+3YY9CmfLBiCmIbG/RT0s
         pW3H4BYxM+PbrZKnjJbyM3za10214qiOKTfkBtzNvLLou8EQP0g5SSARp9y8AaWZpOVT
         FXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tv00s6K0SlUYBIFVBtWZY0iBuXYnkHiElY4xiwfj3pQ=;
        b=YmhF0gZGMiMck/HCf0L7DTobZdEypO5m+q5d86Q9cE21aBqR/WrPvhBIOsBcpe/doj
         PbGQmotvjIHm8AV+QmcGfkNaaAYVE4HEsr1WvGwZBCT/ISv2NLgCEj/WXsfnIIoHmK7n
         A2aHNAmZxdUv/AEkHu4SKsgeHj80piPZj6Nadex75D9fcWhoYz/aAdCqgzg0FdyvF3yH
         8aBn7DOg74H8vjciQk7h20KBJNS9QlXKO5192/wJ8S6AtE3+2AuSCSUbx99xcymbsWCA
         1joOA5+TKqaEIsLeVWyBeJ2F8HEgXTJc0Tj2osuSr9LDTJq+xvTxhDpYssxKgN7uBbK8
         FKLQ==
X-Gm-Message-State: APjAAAV5wWoe/fcINVE/ku2z6bA1W9+sxS0yY7N2BLx/DYNhO30HviD3
        gffwVIPmH/7u5ZMgqaFvsitY7G2I
X-Google-Smtp-Source: APXvYqx5jkoZPrtZV6DLbGtgTdLMlnFx2SptkGauRd3ocYBIB7+WsSuiLMlPq4enNs6JD5gXc3G6eQ==
X-Received: by 2002:a63:9d0f:: with SMTP id i15mr10555679pgd.286.1573201393927;
        Fri, 08 Nov 2019 00:23:13 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id q73sm4444164pjc.22.2019.11.08.00.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 00:23:12 -0800 (PST)
Date:   Fri, 8 Nov 2019 00:23:10 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 01/14] t: teach test_cmp_rev to accept ! for not-equals
Message-ID: <20191108082310.GA2497@generichostname>
References: <cover.1571739459.git.liu.denton@gmail.com>
 <cover.1573152598.git.liu.denton@gmail.com>
 <0d0696f310a6f8e13ed480b1a1e91cdc2debaa20.1573152599.git.liu.denton@gmail.com>
 <xmqqpni3nj8j.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpni3nj8j.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 08, 2019 at 12:24:12PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > Currently, in the case where we are using test_cmp_rev() to report
> > not-equals, we write `! test_cmp_rev`. However, since test_cmp_rev()
> > contains
> >
> > 	r1=$(git rev-parse --verify "$1") &&
> > 	r2=$(git rev-parse --verify "$2") &&
> >
> > In the case where `git rev-parse` segfaults and dies unexpectedly, the
> > failure will be ignored.

I'll probably reword this to

	In the case where we are using test_cmp_rev() to report
	not-equals, we write `! test_cmp_rev`. However, since
	test_cmp_rev() contains

		r1=$(git rev-parse --verify "$1") &&
		r2=$(git rev-parse --verify "$2") &&

	`! test_cmp_rev` will succeed if any of the rev-parses fail.
	This behavior is not desired. We want the rev-parses to _always_
	be successful.

because of your puzzlement below.

> 
> Good justification.  The last two lines are continuation of the
> sentence that begins the proposed log message, so downcase "In" at
> the beginning of the line.  Also, when we present the problem to be
> solved at the beginning, it is customary to describe the status quo,
> and "Currently, " is a noiseword that does not add much information,
> so drop it.

Thanks, I'll make a note to stop doing this in future patches as well.

[...]

> 
> >  test_cmp_rev () {
> > +	local inverted_op
> > +	inverted_op='!='
> > +	if test $# -ge 1 && test "x$1" = 'x!'
> > +	then
> > +	    inverted_op='='
> > +	    shift
> > +	fi
> 
> I'd rather avoid having to keep track of negation to reduce mental
> burden.  How about using = by default and != when '!' was given
> (which would be more natural to readers) and call it $op, and say
> "if ! test $r1 $op $r2" where it is used?

Good idea, I felt a little uneasy doing the inverted thing but it never
occurred to me to just negate the return code of `test`.

> 
> 
> >  	if test $# != 2
> >  	then
> >  		error "bug in the test script: test_cmp_rev requires two revisions, but got $#"
> >  	else
> >  		local r1 r2
> >  		r1=$(git rev-parse --verify "$1") &&
> >  		r2=$(git rev-parse --verify "$2") &&
> 
> If either of the calls fail, the assignment itself would fail, and
> the &&-cascade would stop without executing the if statment below.
> 
> I see the "!" feature, but where is the promised "fix" for
> segfaulting rev-parse?
> 
> Puzzled.

I suppose your puzzlement comes from my badly worded commit message
above. I meant to say that in the _hypothetical_ case that 
`git rev-parse` segfaults, it wouldn't be caught because we're
blanket-ignoring failures if we do `! test_cmp_rev`.

But I suppose I focused too much on segfaults. I guess I didn't realise
that the problem is more general than that; any failure of 
`git rev-parse` should be reported.

Thanks for the review,

Denton
