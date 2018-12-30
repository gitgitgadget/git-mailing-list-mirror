Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 991D51F770
	for <e@80x24.org>; Sun, 30 Dec 2018 19:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbeL3TEY (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Dec 2018 14:04:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47091 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeL3TEY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Dec 2018 14:04:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so25063327wrt.13
        for <git@vger.kernel.org>; Sun, 30 Dec 2018 11:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XR+E/5J9FQKrQKOogqoz2e2HYYcQ5x73OtwgJnl4t4Y=;
        b=jN7vRrAYUKJRuKGo8ec5Cseu3qJ0YqFh0a3pDRu165MhzZDMuCNO5aEUT+Xxgahufy
         5E2vb/l5cfN7YCXAy6q0Ck8oWNRZNdPHfS11FUZUxE2PfAKx4vtNOlAc0i+XkEWr0IOx
         O3yctiG4dru8/1Dvjtwi8+Aug8+ZCtB73dK9Hx/cX9MhJSaMkJ0s+WSVj/G1c3RFYo9p
         9IT0ZajO5Qo+uLj0ZtjnByU8/ObYc/9SCGA0S5iFt8nvtTQbXkYB2dlsd0aGl26Fq85C
         6wFVVW53+IzEBgl9Yq/qcS2GgVwXDkQFA6UT2vqjpgU6BfQKdqM5L4Xo7iloR4RfGeVm
         89yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XR+E/5J9FQKrQKOogqoz2e2HYYcQ5x73OtwgJnl4t4Y=;
        b=FzEum09HtYhVEZf70wqT2K3R6O9Q555jVba/9qpnWXIpuxps3zbuLy4zynOFWdBIIH
         zV1TVMa3QBukkMryg1b8+wVl0GsiI8XaPvgo1f1MGUWDdvLqGmjZgNe7Zs9tnaREObe8
         b0lR+NaQNv3gDoI4pbOEvyEDTG2ZClLb9Fu4wiIUk97PWFStzoRuZETc6ZFYEfsDeCb9
         q9Y7F53+JnD6aqKGt0Vx/qNDBnOkzIg/JvE7RrgyQE48XTmgQ6wIxcUyQIOHWjGBsqcY
         7a5JLOX3jzvB0iSiqSGOqUk4ZfZd74lzxEHppP8uM+E5rGrb60RUJZPTYfml3JZEtfEe
         aBvw==
X-Gm-Message-State: AJcUukcBxyM//EDLuwitJoW+uzarm+LR+3IcD1KpUKNBgab+JYifzeV2
        Z6Cs5/uzAzd6LGE7yPmBqEI=
X-Google-Smtp-Source: ALg8bN6jVLNjpfNujGYXuWHu79tqLjp6VU8lkGDikfcsc5TwbRDgIlvRn2a25i3Og6zXbA9lBjS6qA==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr29300618wrq.108.1546196662597;
        Sun, 30 Dec 2018 11:04:22 -0800 (PST)
Received: from szeder.dev (84-236-109-65.pool.digikabel.hu. [84.236.109.65])
        by smtp.gmail.com with ESMTPSA id k3sm58439775wrm.7.2018.12.30.11.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 11:04:21 -0800 (PST)
Date:   Sun, 30 Dec 2018 20:04:19 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/7] test-lib: parse some --options earlier
Message-ID: <20181230190419.GB6120@szeder.dev>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181209225628.22216-1-szeder.dev@gmail.com>
 <20181209225628.22216-3-szeder.dev@gmail.com>
 <20181211110919.GC8452@sigill.intra.peff.net>
 <20181211124245.GT30222@szeder.dev>
 <20181217214436.GB14251@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181217214436.GB14251@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 17, 2018 at 04:44:36PM -0500, Jeff King wrote:
> On Tue, Dec 11, 2018 at 01:42:45PM +0100, SZEDER Gábor wrote:

> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 9a3f7930a3..efdb6be3c8 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -264,58 +264,65 @@ test "x$TERM" != "xdumb" && (
> >  	) &&
> >  	color=t
> >  
> > -while test "$#" -ne 0
> > +store_arg_to=
> > +prev_opt=
> > +for opt
> >  do
> > -	case "$1" in
> > +	if test -n "$store_arg_to"
> > +	then
> > +		eval $store_arg_to=\$opt
> > +		store_arg_to=
> > +		prev_opt=
> > +		continue
> > +	fi
> 
> OK, so this is set for the unstuck options, which then pick up the
> option in the next loop iteration. That's perhaps less gross than my
> "re-build the options with set --" trick.
> 
> A simple variable set is enough for "-r". In theory we could make this:
> 
>   if test -n "$handle_unstuck_arg"
>   then
> 	eval "$handle_unstuck_arg \$1"
>   fi
>   ...
> 
>   -r)
> 	handle_unstuck_arg=handle_opt_r ;;
> 
> and handle_opt_r() could do whatever it wants. But I don't really
> foresee us adding a lot of new options

Yeah, I would refrain from making it too general and fancy with a
callback function for now, when there is only a single option that
could use it.

> (in fact, given that this is just
> the internal tests, I am tempted to say that we should just make it
> "-r<arg>" for the sake of simplicity and consistency. But maybe somebody
> would be annoyed. I have never used "-r" ever myself).

I didn't even know what '-r' does...

And I agree that changing it to '-r<arg>' would be the best, but this
patch series is about adding '--stress', so changing how '-r' gets its
mandatory argument (and potentially annoying someone) is beyond the
scope, I would say.

