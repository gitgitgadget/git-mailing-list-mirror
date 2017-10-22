Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E05ED202DD
	for <e@80x24.org>; Sun, 22 Oct 2017 16:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbdJVQ15 (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Oct 2017 12:27:57 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:54744 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdJVQ14 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Oct 2017 12:27:56 -0400
Received: by mail-wr0-f196.google.com with SMTP id o44so15101047wrf.11
        for <git@vger.kernel.org>; Sun, 22 Oct 2017 09:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8Rs2TVrmDueOHJMjpSgJ5D+iZ0iWkZVfsojeh/OASUE=;
        b=BOXkSDrGkjDjDOHuwIgGg25lyfKIF84Sdv8mEnq/RMQqOGq7c+vI2TRX4tI5F1Mla5
         6Px0+2/QDPGxO1DTxOFsRK2jnamftJnFkm1LA3RtsCAihjtL9rioUMXi8gHIAo5+zMcg
         a52v2VMaTib1HqX2iLkTBlt7qDxQdAuiiWcCUhMB/O8+IHBZ1hOBKh0z2zHTSGxu6jMo
         2X+qSJFljNtBJ4wBp3SUm4O516oi7w6zEugEbfbqvPgVAmaktNRDh6TWJ8EN+7VOBgEi
         1aUa6capFDMTUWcMwWXz1hj1FgrI/TLG7LtWE8IspiPMDbvsGU2BzMq2K27J8c1Jkti0
         zrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Rs2TVrmDueOHJMjpSgJ5D+iZ0iWkZVfsojeh/OASUE=;
        b=BBT3Vt9+Isa2LTvO0qTIK807iDQaWLj3oZHuCqZpJhMWyGvS6kbSPLkSMOdVXhGyqq
         cbOm8+ykygH/LKTDUO/YdGAIGuegGvzXlc6y0w3ymARX29GxaqJM4qQRsT3eUOvRQQdb
         wr8fcRqL+jkq2DNF7VtHxaA67dGM94vA4f8E8jrzNIKEz4ETsIyee7Pou1QVpoTgtu0D
         pGcNZS5j3JgRlZM4dXvGxUhfsjmYkgTPhwukLTfc1t5dzCEnGgcVJUVCpGmT7JS4vKka
         OKW5Wk0EMDeFbaaJwUUIxaDCf09tWav9Dkk+pRab7/qkcFyosCycowSCyq4hYEEGBA26
         +Ikw==
X-Gm-Message-State: AMCzsaXwRadjpBtsi+uUpUxsL01pRYlvt/6uh5sxggx62ilfO2mAqZq8
        70p21OnLe8ryVI3cYsvv+qg=
X-Google-Smtp-Source: ABhQp+To5LZ12XByAXYSJIVJgfGzep3FBZEY6v4Vzb9XWBpVmNmHwV/JhvsPPfxa5Y81F9qg1r1jcw==
X-Received: by 10.223.173.66 with SMTP id p60mr8692165wrc.13.1508689674987;
        Sun, 22 Oct 2017 09:27:54 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id i1sm2405005wri.34.2017.10.22.09.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Oct 2017 09:27:53 -0700 (PDT)
Date:   Sun, 22 Oct 2017 17:28:58 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        "Robert P . J . Day" <rpjday@crashcourse.ca>
Subject: Re: [PATCH v2 1/2] replace git stash save with git stash push in the
 documentation
Message-ID: <20171022162858.GJ15399@hank>
References: <20171005200049.GF30301@hank>
 <20171019183304.26748-1-t.gummerer@gmail.com>
 <20171021062617.yajqusruqanjnicb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171021062617.yajqusruqanjnicb@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/21, Jeff King wrote:
> On Thu, Oct 19, 2017 at 07:33:03PM +0100, Thomas Gummerer wrote:
> 
> > diff --git a/git-stash.sh b/git-stash.sh
> > index 8b2ce9afda..16919277ba 100755
> > --- a/git-stash.sh
> > +++ b/git-stash.sh
> > @@ -267,11 +267,11 @@ push_stash () {
> >  			# translation of "error: " takes in your language. E.g. in
> >  			# English this is:
> >  			#
> > -			#    $ git stash save --blah-blah 2>&1 | head -n 2
> > -			#    error: unknown option for 'stash save': --blah-blah
> > -			#           To provide a message, use git stash save -- '--blah-blah'
> > -			eval_gettextln "error: unknown option for 'stash save': \$option
> > -       To provide a message, use git stash save -- '\$option'"
> > +			#    $ git stash push --blah-blah 2>&1 | head -n 2
> > +			#    error: unknown option for 'stash push': --blah-blah
> > +			#           To provide a message, use git stash push -- '--blah-blah'
> > +			eval_gettextln "error: unknown option for 'stash push': \$option
> > +       To provide a message, use git stash push -m '\$option'"
> 
> The user message is fixed here, but doesn't the message for translators
> need the same treatment?  I guess it's just talking about the spacing,
> so it doesn't need to be completely accurate. But it probably makes
> sense to update it at the same time.

Yeah, I was completely blind here, that should definitely have been
updated as well.  Thanks for catching.

> As an aside, I do kind of wonder if the right advice for "push" is
> different than for "save" here. I.e., should it say "to provide a
> pathspec that starts with --, use push -- --blah-blah". I'm not sure it
> matters that much. Second-guessing what a user meant seems likely to go
> wrong (e.g., "--icnlude-untracked" would trigger this message, which is
> just silly). But that's largely orthogonal to what you're doing here.

The best advice for it might indeed be different for "save" and
"push".  The slight weirdness we have here is that both "save" and
"push" are using the same option parsing.

Now that we're deprecating "save", I don't think it's worth the effort
to try to get rid of this weirdness.

I think using "--" to distinguish the the pathspec from the command
line options is a common enough pattern that we don't need to give
advice to the users.  I feel like that second line was mostly there
because of the weirdness in the user interface for "stash save".
Maybe we should just get rid of that part alltogether?

> -Peff
