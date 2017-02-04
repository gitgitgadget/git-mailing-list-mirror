Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BCF41F9AF
	for <e@80x24.org>; Sat,  4 Feb 2017 12:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753276AbdBDMS5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 07:18:57 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36817 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753196AbdBDMS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 07:18:56 -0500
Received: by mail-wm0-f68.google.com with SMTP id r18so10741510wmd.3
        for <git@vger.kernel.org>; Sat, 04 Feb 2017 04:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kZ/WroL1uwta8LWYx2s9q1VpxCH8qah2zgEzS06XmKA=;
        b=BKVInmUxOTjai6XpsbJZebLGkUbu/5oXHrZhCjm+qTYueHUUd37sHDZlIn2e3IXhCu
         btrfuYf3ZY0mLMUkOoEvjZAHSpratrVNzIRdFJll273TsNe/ipEqSjvqu32RHd8Rw12l
         wCZdezVoA3pPZeElkfVBiubzyfaoFnop44NkiP5mFDk7fP9ynU3AeTx7BEWfPyRigam6
         vwKiU0pID+a8lKg/0J9AwuiXOYvNfKWVddOkIDTLt/zzq3cEHK7VH1XVBWfV2NfvDMtR
         OXamKseER87y5AHSragkVw5Pis76wxY9yxWbCdnJEPC5LA+vgFRFFFOOWBxr+OvtDMhx
         o9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kZ/WroL1uwta8LWYx2s9q1VpxCH8qah2zgEzS06XmKA=;
        b=VZIHDyUecVbyjAFGGfusoSZo37UnvvPjCaYVcYfSTskkLMViycJf9ims7nW9b5S1gH
         lzRp0cOJtTDzCK++LUJZ6jJl+l1bLJlknYgSd9lKQaJtsvp3JYxVrO5SW/hWs5F9FiIP
         iretUjReaqOUvvO9MbKfTpM7jsahemwo3KTVcRlIUB3h0M6dB5pHnScKQmzqDjkz4uYy
         wGc4W5qBhcY/Gd3uf2s8hVB3kEdHzBLy/9MXEyYFltPiDzeUgPawA6ODQW6RGBtxfr5F
         WNnRohCMJhDWw8ocHUZApjsUz9kzPUfy24ogVNq24zCwQE0g5kK1p9xnoN46gbUdnS3B
         7GAg==
X-Gm-Message-State: AIkVDXLiCQmfZQ3/RL8v+Rk922zVFbp76qFRtD5y//W5BuD9pttFQtbq0G/rxuBe8WtO1g==
X-Received: by 10.223.160.206 with SMTP id n14mr1782119wrn.31.1486210734604;
        Sat, 04 Feb 2017 04:18:54 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id o143sm2396655wmd.3.2017.02.04.04.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Feb 2017 04:18:53 -0800 (PST)
Date:   Sat, 4 Feb 2017 12:19:20 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=D8yvind_A_=2E?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 2/4] stash: introduce push verb
Message-ID: <20170204121920.GE31189@hank>
References: <20170121200804.19009-1-t.gummerer@gmail.com>
 <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170129201604.30445-3-t.gummerer@gmail.com>
 <xmqqy3xsux4g.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3xsux4g.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/30, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Introduce a new git stash push verb in addition to git stash save.  The
> > push verb is used to transition from the current command line arguments
> > to a more conventional way, in which the message is specified after a -m
> > parameter instead of being a positional argument.
> 
> I think the canonical way to express that is "... the message is
> given as an argument to the -m option" (i.e. some options take an
> argument, some others do not, and the "-m" takes one).
> 
> > This allows introducing a new filename argument to stash single files.
> 
> I do not want them to be "a filename argument", and I do not think
> you meant them as such, either.  
> 
>     This allows us to have pathspecs at the end of the command line
>     arguments like other Git commands do, so that the user can say
>     which subset of paths to stash (and leave others behind).

Yeah, this is much better, thanks.

> > +save_stash () {
> > +	push_options=
> > +	while test $# != 0
> > +	do
> > +		case "$1" in
> > +		-k|--keep-index)
> > +...
> > +		esac
> > +		shift
> > +	done
> 
> It is a bit unfortunate that we need to duplicate the above
> case/esac here.  I do not know if doing it this way:
> 
> 	case "$1" in
> 	--)
> 		shift
> 		break 
> 		;;
> 	--help)
> 		show_help
> 		;;
> 	-*)
> 		# pass all options through to push_stash
> 		push_options="$push_options $1"
> 		;;
> 	*)
> 		break
>                 ;;
> 	esac
> 
> and letting push_stash complain for an unknown option is easier to
> maintain.

I think this will work out nicely.  Will try to implement it this way.

> You are reversing the order of the options in the loop.  Don't.

-- 
Thomas
