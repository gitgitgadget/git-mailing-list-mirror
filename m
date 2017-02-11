Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BB941FAF4
	for <e@80x24.org>; Sat, 11 Feb 2017 13:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932084AbdBKNcf (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 08:32:35 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34339 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932069AbdBKNce (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 08:32:34 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so10926234wmi.1
        for <git@vger.kernel.org>; Sat, 11 Feb 2017 05:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FRLeOTedVkkBvRAgVcL/pM4Y2V1+9tGMjJ3VjhLt7K0=;
        b=a6bhEUwYRSDdXYxi0vNwWX/QctukUZzgW89HgvNp5ywH+hISe2OkSRZVjSyVq2owvF
         jm39d9nl6GUgYd29gCYHLXfhZXgonaNb0zFKw+XM4rzcltCv3iRZyCpcMi5g6eWljvdo
         Mymx/uYdP3++7PCq+3IF64apAbEN6t41nLl0wZ8eGelfsPVvBHrFdqMbB5uX2xE1f/wH
         Cq3LDG7FCJi0iZY1CDYxyQOZK4FktPlqUGjXSNt4wzsI/6u04uP5VvGU/SjOOcdPL0Fz
         XN4XlFslo06LPJVVwflHBoOjPVWrKBb9QTQ1TfSespuWmYInI5d5hpnRdEjVqF4TtvGV
         bSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FRLeOTedVkkBvRAgVcL/pM4Y2V1+9tGMjJ3VjhLt7K0=;
        b=eIqayQavJ07lCP2D1C0/XLHYQmLqvKncRJJp5VFWmV/iKVXPHw/K0NbZ001I8n3pvi
         Efn0NpCLIzd7Zk2/ZvlJQKeOTzIpUmpWT2pzMSacSI1oIy8a3btrWhXy2P2e2KhU6SJb
         9WeSa5N7WQPuS9yQ+I21NQsIjkMhnEUiFeX/We3HYycbU6xum/fED+WLhr1NLGBhdok4
         N6/iYI84ILVsIR2+hEvj/aF8Da4sRguAYr9akYzgusADn+K/KGdt5N0XudJvDGzDejly
         hqnnDhh5xWHRi4Gfr+B18jp5vhZZiMOc6oJvurY8f7zNglkPjC1ROlB/AlamWaEI4NX3
         HsSQ==
X-Gm-Message-State: AMke39mFqn0xBYU7COPFublJeQyn/uKcX9t3fw690jFELgQws1YzyjSTJ2yR64ZlWQCZbA==
X-Received: by 10.28.68.10 with SMTP id r10mr11779396wma.68.1486819952530;
        Sat, 11 Feb 2017 05:32:32 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id u42sm6428817wrc.1.2017.02.11.05.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Feb 2017 05:32:31 -0800 (PST)
Date:   Sat, 11 Feb 2017 13:33:05 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=D8yvind_A_=2E?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 2/5] stash: introduce push verb
Message-ID: <20170211133305.GI31189@hank>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
 <20170205202642.14216-3-t.gummerer@gmail.com>
 <20170206154628.v27z5mqhxylz22ba@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170206154628.v27z5mqhxylz22ba@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[sorry for the late responses, life is keeping me busy]

On 02/06, Jeff King wrote:
> On Sun, Feb 05, 2017 at 08:26:39PM +0000, Thomas Gummerer wrote:
> 
> > +		-m|--message)
> > +			shift
> > +			stash_msg=${1?"-m needs an argument"}
> > +			;;
> 
> I think this is our first use of the "?" parameter expansion magic. It
> _is_ in POSIX, so it may be fine. We may get complaints from people on
> weird shell variants, though. If that's the only reason to avoid it, I'd
> be inclined to try it and see, as it is much shorter.
> 
> OTOH, most of the other usage errors call usage(), and this one doesn't.
> Nor is the error message translatable. Perhaps we should stick to the
> longer form (and add a helper function if necessary to reduce the
> boilerplate).

Yeah I do agree that calling usage is the better option here.

> > +save_stash () {
> > +	push_options=
> > +	while test $# != 0
> > +	do
> > +		case "$1" in
> > +		--help)
> > +			show_help
> > +			;;
> > +		--)
> > +			shift
> > +			break
> > +			;;
> > +		-*)
> > +			# pass all options through to push_stash
> > +			push_options="$push_options $1"
> > +			;;
> > +		*)
> > +			break
> > +			;;
> > +		esac
> > +		shift
> > +	done
> 
> I suspect you could just let "--help" get handled in the pass-through
> case (it generally takes precedence over errors found in other options,
> but I do not see any other parsing errors that could be found by this
> loop). It is not too bad to keep it, though (the important thing is that
> we're not duplicating all of the push_stash options here).

Good point, would be good to get rid of that duplication as well.

> > +	if test -z "$stash_msg"
> > +	then
> > +		push_stash $push_options
> > +	else
> > +		push_stash $push_options -m "$stash_msg"
> > +	fi
> 
> Hmm. So $push_options is subject to word-splitting here. That's
> necessary to split the options back apart. It does the wrong thing if
> any of the options had spaces in them. But I don't think there are any
> valid options which do so, and "save" would presumably not grow any new
> options (they would go straight to "push").
> 
> So there is a detectable behavior change:
> 
>   [before]
>   $ git stash "--bogus option"
>   error: unknown option for 'stash save': --bogus option
>          To provide a message, use git stash save -- '--bogus option'
>   [etc...]
> 
>   [after]
>   $ git stash "--bogus option"
>   error: unknown option for 'stash save': --bogus
>          To provide a message, use git stash save -- '--bogus'
> 
> but it's probably an acceptable casualty (the "right" way would be to
> shell-quote everything you stuff into $push_options and then eval the
> result when you invoke push_stash).
>
> Likewise, it's usually a mistake to just stick a new option (like "-m")
> after a list of unknown options. But it's OK here because we know we
> removed any "--" or non-option arguments.
> 
> -Peff

-- 
Thomas
