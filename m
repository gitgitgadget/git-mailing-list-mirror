Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B1D71FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 22:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbdBMWd0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 17:33:26 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34285 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbdBMWdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 17:33:25 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so627828wmi.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 14:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7ZJxxchAt0ZOlZLvpqGEIRUFLt1ldw4bws0jucKnGOs=;
        b=ZD/55zTjbdmHdgpYL+8LjRe1fgHa2MvXH359LAf2A1jVWTBWsBaDAGKHu5PwvBEgbP
         UhLGj5YT6bv0PQiz4LqnN58dqwVsiS8qgV2ZBh6XKU7JP1lpjfLU8Etr7gwhWnALeT2t
         djQPHWFTwRpp/8kF+wzXDu9BSAeRtbZcjywAka6XX2L5SlYXSwIDV80recjkyW26i0x9
         Ba6NYN0cwB4UEISE4N9JK5MqmPqSD41jLZAt2jtxDxsLmhN7Rzp3YKmURgs3IC/V66Nq
         j3x/UPAQEN6RxvI7t8eGqzq4KBrG35KfHRcpknvXKc56a0ByvMjwPkSEZiKvLaGBlagm
         mpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7ZJxxchAt0ZOlZLvpqGEIRUFLt1ldw4bws0jucKnGOs=;
        b=YlGgH3Ktt5RoG/MsHb/JLq39zKHBBF66InmNumQ3PDMQsqrYFzLPR2k5hkS5tWxVQD
         /oDAeGfG4KlxAwig0lMgStDtyQ7wwPyO42rhG+CZqjrmrV2lEDAIldSCJGYi9wPN/MgD
         BqEVjVr8VYbSeqX0yqj0TnjW+KpPEIvC+pYsnwb7JaUi4yCjNI/4nVdK6X+oHhoL+5IJ
         Dm7s/1Agyrc5Mt37Z+cTGU1LX3LM9XmtRRipDJ9EyDtYz87f7O0Opl2zfu+KUA6sdguu
         AMgA+bMICfpEZ/+Hu0WT5hT/8bWkaFOmDbEMlV9MXVbp4zi64CD4JlPpqc1lE3mQTXAH
         tkAQ==
X-Gm-Message-State: AMke39lfNnh2ytwTK+uFG7gEwIiRTSZqgxNKBi5fsuDRmONLa9Jgz9lK0A1OkFcN1lKXRw==
X-Received: by 10.28.54.90 with SMTP id d87mr453109wma.89.1487025193214;
        Mon, 13 Feb 2017 14:33:13 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id y65sm989505wmb.5.2017.02.13.14.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Feb 2017 14:33:12 -0800 (PST)
Date:   Mon, 13 Feb 2017 22:33:46 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
        Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=D8yvind_A_=2E?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 0/5] stash: support pathspec argument
Message-ID: <20170213223346.GD652@hank>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
 <20170206161432.zvpsqegjspaa2l5l@sigill.intra.peff.net>
 <20170212193050.GA652@hank>
 <vpq7f4uxjmo.fsf@anie.imag.fr>
 <20170213200950.m3bcyp52wd25p737@sigill.intra.peff.net>
 <vpqo9y5lqos.fsf@anie.imag.fr>
 <20170213214521.pkjesijdlus36tnp@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170213214521.pkjesijdlus36tnp@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/13, Jeff King wrote:
> On Mon, Feb 13, 2017 at 10:35:31PM +0100, Matthieu Moy wrote:
> 
> > > Is it really that dangerous, though? The likely outcome is Git saying
> > > "nope, you don't have any changes to the file named drop". Of course the
> > > user may have meant something different, but I feel like "-p" is a good
> > > indicator that they are interested in making an actual stash.
> > 
> > Indeed -p is not the best example. In the old thread, I used -q which is
> > much more problematic:
> > 
> >   git stash -q drop => interpreted as: git stash push -q drop
> >   git stash drop -q => drop with option -q
> 
> Yeah, I'd agree with that. I wouldn't propose to loosen it entirely, but
> rather to treat "-p" specially.
> 
> > It's not really "dangerous" at least in this case, since we misinterpret
> > a destructive command for a less destructive one, but it is rather
> > confusing that changing the order between command and options change the
> > behavior.
> > 
> > I actually find it a reasonable expectation to allow swapping commands
> > and options, some programs other than git allow it.
> 
> I think we may have already crossed that bridge with "git -p stash".
> 
> Not to mention that the ordering already _is_ relevant (we disallow one
> order but not the other). If we really wanted to allow swapping, it
> would mean making:
> 
>   git stash -p drop
> 
> the same as:
> 
>   git stash drop -p
> 
> I actually find _that_ more confusing. It would perhaps make more sense
> with something like "-q", which is more of a "global" option than a
> command-specific one. But I think we'd want to whitelist such global
> options (and "-p" would not be on that list).
>
> > > The complexity is that right now, the first-level decision of "which
> > > stash sub-command am I running?" doesn't know about any options. So "git
> > > stash -m foo" would be rejected in the name of typo prevention, unless
> > > that outer decision learns about "-m" as an option.
> > 
> > Ah, OK. But that's not really hard to implement: when going through the
> > option list looking for non-option, shift one more time when finding -m.
> 
> No, it's not hard conceptually. It just means implementing the
> option-parsing policy in two places. That's not too bad now, but if we
> started using rev-parse's options helper, then I think you have corner
> cases like "git stash -km foo".
> 
> My "-p" suggestion suffers from a similar problem if you treat it as
> "you can omit the 'push' if you say "-p", rather than "if -p is the
> first option, it is a synonym for 'push -p'".

I'm almost convinced of special casing "-p".  (Maybe I'm easy to
convince as well, because it would be convenient ;) ) However it's a
bit weird that now "git stash -p file" would work, but "git stash -m
message" wouldn't.  Maybe we should do it the other way around, and
only special case "-q", and see if there is an non option argument
after that?  From a glance at the options that's the only one where
"git stash -<option> <verb>" could make sense to the user.
