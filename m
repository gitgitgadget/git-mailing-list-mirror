Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EF3B201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 19:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbdBYTWS (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 14:22:18 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33110 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbdBYTWO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 14:22:14 -0500
Received: by mail-wm0-f68.google.com with SMTP id v77so7686522wmv.0
        for <git@vger.kernel.org>; Sat, 25 Feb 2017 11:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=loYS15bm0hzW35cCb66pOGvt9CLD/lpd07ZA0QMJYMs=;
        b=s7dKbNi7YSv6j6o2y62OBlfmR6pbd6mQvM/FqSgghgB2+v5N7r+1rYfasiA9jqP4NY
         0aYFuixjZ4GI15jsya9NAKVhuD04wkwo5ccNbSwKYBgPWYWSaGXVXZuKZHgCR47Ia3Pg
         O063YYVqoaYzUMtjoB6CkAAwpJ+TZMds7kPIm87P70w1MFlECifFkNImeEZvyPUqPW2y
         X8BaFU99kfExKHgTKmtDGBFv4za/LRwMpmfZHS+7cF1CSQa8QTPm4Qy+Yhhxco69rJtE
         CWnUzKp11YwJR/TqvFts5S+oy4k51jfgPOpv9eVq5RU05YhoyU3XsHbISxuJVgV2/RDq
         IOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=loYS15bm0hzW35cCb66pOGvt9CLD/lpd07ZA0QMJYMs=;
        b=VY/YHZYd431acyqow6TtO1UwChj7Nirk+mq1eUlTgs0WGqgjINho4+8wyiFjUTecS2
         i9fB4jFcYwIk5Vi/nsMwTgE6BQ69008tcpxXHAxzp/6/9fFy5wvrJpFwYD960Q+23aJQ
         IbUqNH667xwlXqTiAVhgTmZlDxnV6ct2OfmR0WWD6znVbX1MtIS2tl5AY6NFEiNeYxrQ
         NJ8jq8FYDLU/O4YNIIpFZDg93n/SN/sDhngTJy7HW/ZhqdlbrdaFq6LIZx8MLjbsESsL
         xoHSKVtukPUpdsq3Ewu3omQ5FRfLR3NUEuQw53BtD8L0y2KImNJbKOvZU1DaaBg4VKAI
         9a1g==
X-Gm-Message-State: AMke39nB0S8soRjh0wRO6zpCk+jWstsoiGzr4PM+EbTjtZonDJZmdQvtvU1Ket+J248/WQ==
X-Received: by 10.28.131.132 with SMTP id f126mr7804992wmd.61.1488050506303;
        Sat, 25 Feb 2017 11:21:46 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id v72sm4903694wmd.0.2017.02.25.11.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Feb 2017 11:21:45 -0800 (PST)
Date:   Sat, 25 Feb 2017 20:27:33 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 4/6] stash: teach 'push' (and 'create_stash') to honor
 pathspec
Message-ID: <20170225202733.GB6243@hank>
References: <20170217224141.19183-1-t.gummerer@gmail.com>
 <20170219110313.24070-1-t.gummerer@gmail.com>
 <20170219110313.24070-5-t.gummerer@gmail.com>
 <xmqqmvdfh4az.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmvdfh4az.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/21, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > -		git reset --hard ${GIT_QUIET:+-q}
> 
> This hunk is probably the most important one to review in the whole
> series, in the sense that these are entirely new code that didn't
> exist in the original.
> 
> > +		if test $# != 0
> > +		then
> > +			saved_untracked=
> > +			if test -n "$(git ls-files --others -- "$@")"
> 
> I notice that "ls-files -o" used in the code before this series are
> almost always used with --exclude-standard but we do not set up the
> standard exclude pattern here.  Is there a good reason to use (or
> not to use) it here as well?

We probably should use it, not adding it was an oversight.

> > +			then
> > +				saved_untracked=$(
> > +					git ls-files -z --others -- "$@" |
> > +					    xargs -0 git stash create -u all --)
> > +			fi
> 
> Running the same ls-files twice look somewhat wasteful.
> 
> I suspect that we avoid "xargs -0" in our code from portability
> concern (isn't it a GNU invention?)
> 
> > +			git ls-files -z -- "$@" | xargs -0 git reset ${GIT_QUIET:+-q} --
> 
> Hmm, am I being naive to suspect that the above is a roundabout way
> to say:
> 
> 	git reset ${GIT_QUIET:+-q} -- "$@"
> 
> or is an effect quite different from that intended here?
> 
> > +			git ls-files -z --modified -- "$@" | xargs -0 git checkout ${GIT_QUIET:+-q} HEAD --
> 
> Likewise.  Wouldn't the above be equivalent to:
> 
> 	git checkout ${GIT_QUIET:+-q} HEAD -- "$@"
> 
> Or is this trying to preserve paths modified in the working tree and
> fully added to the index?.

No, it's not trying to do that (all the paths we're touching here
would have been "reset" earlier, so it wouldn't change anything.
However what this code tried to do is to allow "stash push -- path
pathspec-not-in-repo", where "pathspec-not-in-repo" would end up
tripping up "checkout" which does not accept pathspecs that are not in
the index.

I think we should disallow such pathspecs in stash as well, except in
the --include-untracked case, where it still makes sense.

This means we can't get rid of the "ls-files --modified" here, but we
can in all other places, and get rid of the "stash_create"
"stash_apply" dance to store the untracked files, simplifying this
part quite a bit.

Will re-roll.

> 
> > +			if test -n "$(git ls-files -z --others -- "$@")"
> > +			then
> > +				git ls-files -z --others -- "$@" | xargs -0 git clean --force -d ${GIT_QUIET:+-q} --
> 
> Likewise.  "ls-files --others" being the major part of what "clean"
> is about, I suspect the "ls-files piped to clean" is redundant.  Do
> you even need a test?  IOW, doesn't "git clean" with a pathspec that
> does not match anything silently succeed without doing anything
> harmful?
>
> > +			fi
> > +			if test -n "$saved_untracked"
> > +			then
> > +				git stash pop -q $saved_untracked
> 
> I see this thing was "created", and the whole point of "create" is
> to be different from "save/push" that automatically adds the result
> to the stash reflog.  Should we be "pop"ing it, or did you mean to
> just call apply_stash on it?
>
> > +			fi
> > +		else
> > +			git reset --hard ${GIT_QUIET:+-q}
> > +		fi
> 
