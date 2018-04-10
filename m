Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93B671F404
	for <e@80x24.org>; Tue, 10 Apr 2018 02:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbeDJCSB (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 22:18:01 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:41410 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeDJCSA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 22:18:00 -0400
Received: by mail-pf0-f182.google.com with SMTP id a2so6959347pff.8
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 19:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zAtOOdAxE2jjXlV+ygXilGJ51wZ+ExdFlP5/BZDqR8Y=;
        b=epTyTLya8jHyClNrogXCqjugRQmLbtKknr/yWQT3GhUbtrIkFrxyLZaj7JwEarSNoj
         BAgy0YehcZ9bb0eZR8G6qVgLUQvXjWO4jje0SEAN94E++PNCYQkMMPQ6eVSVpVS5Xpxg
         eYgmgZ7cmNHHj2zPwHN77Pp01ds8+Oj11biKCvh7nGkGTJWCqdbPYz1oSGBmuTEOx5Rn
         iOLN6R9DAUxUVlzAW+VnHbHguN3xN7bEHAKERTLRbgM1Tg8uVcVyuJLK03Qb000jWO4X
         DSHvYDTgGmVS9GCw+ju9Ziet3aLegNJbwMt05Bd99ELijJ3oC5Pb3s3nTBfkuphDxPEK
         xdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zAtOOdAxE2jjXlV+ygXilGJ51wZ+ExdFlP5/BZDqR8Y=;
        b=PAH/fcC9e811J+Cwrpfz6PbD+iM8L1hfk+9lhqp8bu3rVxF87KT4PUAJ94jGDZMzhw
         a/DQo1sRM6x/a/31iWw83ry63rZKnfPAzKkdAJ/H2c5MwsrDkwMvuWbSSgUHPJ8HEf8E
         cw9k50yEdrwOzjG4ZXPVGqLovPfIsRlW98Fj2pknsqjyxA/bf/lcsZfiMhG4amXQ+6BE
         KLapt4YFa6zW7pkvf/NDzFbp+q6MlWtod8faks2wqP96nIylgLQh8MAly8CiCc+432OE
         /AhBKO6iQrDc/Xz+KBW3aI0E2a7Fo4K0KTyTzoiyKLB7XA0u31KkhoU5oJCy+V91P79q
         tnaA==
X-Gm-Message-State: ALQs6tDmeW2F1rZIm14yd53reI41Sn+0w8NMN+s5HxggM/vXh7pUOB7H
        4duQdagr0nwxWQwlnB5wl2DmSscgadw=
X-Google-Smtp-Source: AIpwx4+ovhxgWn8BDVnKytY9K1csdtjZtojwZoll5S+SO5jFjB3PoE89cIczD6HoGBfzq1QA5ejeUw==
X-Received: by 10.98.234.13 with SMTP id t13mr1137503pfh.56.1523326679699;
        Mon, 09 Apr 2018 19:17:59 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:1d66:22f3:ac1d:6007])
        by smtp.gmail.com with ESMTPSA id y14sm2434866pfe.172.2018.04.09.19.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 19:17:58 -0700 (PDT)
Date:   Mon, 9 Apr 2018 19:17:57 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        ericsunshine@sunshineco.com
Subject: Re: [PATCH v7 2/2] builtin/config.c: support `--type=<type>` as
 preferred alias for `--type`
Message-ID: <20180410021757.GB937@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
 <cover.1523313730.git.me@ttaylorr.com>
 <20180409224657.GC34547@syl.local>
 <xmqqsh834yz1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsh834yz1.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 10, 2018 at 10:44:18AM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > `git config` has long allowed the ability for callers to provide a 'type
> > specifier', which instructs `git config` to (1) ensure that incoming
> > values are satisfiable under that type, and (2) that outgoing values are
> > canonicalized under that type.
>
> Hmm, "satisfiable" is not the first word that comes to my mind to
> describe "when you give me a string 'frotz', we cannot take it as an
> integer".  s/are satisfiable under/can be interpreted as/ perhaps?

Sure; I think that "can be interpreted as" is clearer. I have amended my
patch locally, and will include this in the next re-roll, should one
exist.

> > In another series, we propose to extend this functionality with
> > `--type=color` and `--default` to replace `--get-color`.
> >
> > However, we traditionally use `--color` to mean "colorize this output",
> > instead of "this value should be treated as a color".
>
> Makes sense.
>
> > Currently, `git config` does not support this kind of colorization, but
> > we should be careful to avoid inhabiting this option too soon, so that
> > `git config` can support `--type=color` (in the traditional sense) in
> > the future, if that is desired.
>
> Shouldn't the above `--color` instead?  That is, we avoid squatting
> on `--color` because we might later want to use it in the
> traditional way.  Also my reading stuttered around "inhabiting".  It
> might be just me, but perhaps s/inhabiting/squating on/?

Ack, yes to both.

> > In this patch, we support `--type=<int|bool|bool-or-int|...>` in
> > addition to `--int`, `--bool`, and etc. This allows the aforementioned
> > upcoming patch to support querying a color value with a default via
> > `--type=color --default=...`, without squandering `--color`.
>
> Good.
>
> > @@ -160,30 +158,39 @@ See also <<FILES>>.
> >  --list::
> >  	List all variables set in config file, along with their values.
> >
> > ---bool::
> > -	'git config' will ensure that the output is "true" or "false"
> > +--type <type>::
> > +  'git config' will ensure that any input or output is valid under the given
> > +  type constraint(s), and will canonicalize outgoing values in `<type>`'s
> > +  canonical form.
> > ++
> > +Valid `<type>`'s include:
> > ++
> > +- 'bool': canonicalize values as either "true" or "false".
> > +- 'int': canonicalize values as simple decimal numbers. An optional suffix of
> > +  'k', 'm', or 'g' will cause the value to be multiplied by 1024, 1048576, or
> > +  1073741824 prior to output.
>
> It is not a new problem introduced by this patch, but these place
> too much weight on the output side and may end up giving a flawed
> mental model to the readers, I am afraid.
>
> It's not like an 'int' value internally is "2k" and shown it as 2048
> when output.  In reality, we internalize it 2048 upon input and we
> do not do anything special when showing, no?  A 'bool' value given
> with a string 'no' internally becomes 0 upon input and is shown as
> 'false' upon output.
>
> I suspect s/prior to output/upon input/ may alleviate the issue
> quite a bit.

I share your concern, and I think that your suggestion would alleviate
the issue entirely.

I have applied these suggestions locally. :-)

Thanks,
Taylor
