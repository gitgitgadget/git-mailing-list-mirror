Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B0E71FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 21:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755394AbdBNVgD (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 16:36:03 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36781 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbdBNVgC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 16:36:02 -0500
Received: by mail-wr0-f195.google.com with SMTP id k90so28988684wrc.3
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 13:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dVlzQlFD0zDZ9APp+8e0pTxZuA6nZPeF0czorm5UGoI=;
        b=fQ9gap0EWkYInZ4gjzkKKYk7XmsPQpnWLxy0ht1bE58lZ2gecFtKqhaTNBcF/olFTH
         jJE8yjRgNZA9CqvKYqWbBvqoFALd0QfbcmSpyZg0kdhTi3rKCarFksbryT20jYsg9aXK
         PDOTlgpZPx1aQyoFDf7Y22gIsjSsqkYmTI/OLDP3aUgcoHC+jTp/SkvU0pKBXaYStwL2
         aYsJ6CaJYUYQiK0fjpiDOvDpRRpjDKRgmRWVRGh1sECb+9TABjcvyAahpRh+pPQFdw7n
         dGWZRZkTi5Hsh9EOkzSFtc8vC+Ye4arNdQjR74m4i+VTMvOHwf0yjnd3pAbRhHwHmKN/
         wJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dVlzQlFD0zDZ9APp+8e0pTxZuA6nZPeF0czorm5UGoI=;
        b=ctSKsXoMS7G4wjQewS/aQxpNDIljP8b+YXS2gFrBBYbWCOQ8Xvo4FEqDN5OezngUnn
         Vbo9+JLJU2D/bxaIVVpmkRd52x+4yoLdRlVSe2W7/u08S5PG7j76xryXpXl0L0nijdjv
         /kMpy4Pi3LXdB6dgvRcl/pxQfKddyEPXNIdO3e+9lCD24vBJbM3167+AHS1eMtWNWTuW
         QW4VaSmG0RcmnnYJvL8UwssrTQuY7ywu9l+1vddiWv29Avd2uioUJyEXuRazE1C+SZKu
         eu9Ym3AJ5oKDr/0lkPRfOdpbGkN52cN6rHhOrEQ7hZTRlSUXdrSxhf8bhSm4M3gVnPBo
         HwSA==
X-Gm-Message-State: AMke39m1Rg0sfeqPRS2Ok6FZpQztXulK53eu49PdQ2lzOScXPdPNNagHjN1Ir1C4CLEnxw==
X-Received: by 10.223.139.2 with SMTP id n2mr26781683wra.67.1487108160462;
        Tue, 14 Feb 2017 13:36:00 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id b17sm2764268wma.33.2017.02.14.13.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Feb 2017 13:35:59 -0800 (PST)
Date:   Tue, 14 Feb 2017 21:36:35 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=D8yvind_A_=2E?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 0/5] stash: support pathspec argument
Message-ID: <20170214213635.GF652@hank>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
 <20170206161432.zvpsqegjspaa2l5l@sigill.intra.peff.net>
 <20170212193050.GA652@hank>
 <vpq7f4uxjmo.fsf@anie.imag.fr>
 <20170213200950.m3bcyp52wd25p737@sigill.intra.peff.net>
 <vpqo9y5lqos.fsf@anie.imag.fr>
 <20170213214521.pkjesijdlus36tnp@sigill.intra.peff.net>
 <20170213223346.GD652@hank>
 <vpq60kdjl63.fsf@anie.imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vpq60kdjl63.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/14, Matthieu Moy wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > I'm almost convinced of special casing "-p".  (Maybe I'm easy to
> > convince as well, because it would be convenient ;) ) However it's a
> > bit weird that now "git stash -p file" would work, but "git stash -m
> > message" wouldn't.  Maybe we should do it the other way around, and
> > only special case "-q", and see if there is an non option argument
> > after that?  From a glance at the options that's the only one where
> > "git stash -<option> <verb>" could make sense to the user.
> 
> Special-casing the allowed cases makes it easier to change the behavior
> in the future if needed: it's easy to add special cases and it doesn't
> break backward compatibility.
> 
> So, if we don't have a good reason to do otherwise, I'd rather stay on
> the future-proof side.

Ok, after reading the rest of the messages in the thread I'm convinced
we should just special case "-p" for now.

It's by far my most used stash command as well, after using git stash
without any arguments.

> -- 
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

