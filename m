Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E793207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 22:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1955338AbdDYW47 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 18:56:59 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34691 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1953495AbdDYW4q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 18:56:46 -0400
Received: by mail-io0-f195.google.com with SMTP id h41so55529561ioi.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 15:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CLo1xo8sVgjewqe7XUyA/PCdJBwzO2ttMWiFz9bPwxY=;
        b=b6NOCDHRMv8UNWTIm+iW3llooO131KNf3AtjBEE4xvfP3WJWwXu2+ng3LxyjSU9cSm
         xfGrM8W4AE9ZiZ7vbZffUUVuCuQni1qP6UqfTMzH4jyeepYWp4uz/shUsImpgN6oB8by
         5tpMQM6eGEosl3d5FEGoKfRUhG/lnGEngv2Pfv7xM6WGrTfb6rKeJicykB1HHa1uen4z
         4+vCUcJHmdy3qBUEPTApiF7DVBbuE0bjEhl/xEyQQQKSzkX0y/b8hitRInF5kpu6bP8d
         eTQFbxKLy6ZILNze1pQF8F23BNtaZ4tTyclzn9Z7OUnla6R3vGGMN4On8EDQ/EIItmQY
         Q5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CLo1xo8sVgjewqe7XUyA/PCdJBwzO2ttMWiFz9bPwxY=;
        b=W8WBGUZXUxv6e7Qa1gMjwYAruPXzTbVaNfQgl4i/NLjSaqTtqmS6htC928n1wwGftS
         wUJbgsmJB/Yynb7OGmDvj/OZv3JUY6MgTc0L3icisNzjLsn09aOO+q/EOhzi0/nHHsPM
         8jGPOuY7GZ6W6Drx+LJjpoO5KFR/1dtNrEIknaeOSG14T5L7V92Kc3pAYs9QI2Zn7DZs
         X1L4tLq/Y3ua9FgfYDixRJq0yJjq4fj26DWuH0psKxSMypuBmaxHm1ddwSDqm03VQGAs
         /DObrUUj74cDrKVnKd1NiNekPhKtXIoUWuXrHe4238b/7h09QCAOmr1kam7Wg3a+GiKX
         aTBQ==
X-Gm-Message-State: AN3rC/4MkyE++YD+j+mmHbvP9cON+S7kW4eFvtmP9AN0HLNTznHAmUHN
        Q/BmALYbNiH9YQ==
X-Received: by 10.107.58.135 with SMTP id h129mr19832105ioa.70.1493161005015;
        Tue, 25 Apr 2017 15:56:45 -0700 (PDT)
Received: from atris (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.googlemail.com with ESMTPSA id g202sm741064ioe.46.2017.04.25.15.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Apr 2017 15:56:44 -0700 (PDT)
Message-ID: <1493160991.29673.26.camel@gmail.com>
Subject: Re: [PATCH v2] rebase -i: add config to abbreviate command-names
From:   liam BEGUIN <liambeguin@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org, peff@peff.net
Date:   Tue, 25 Apr 2017 18:56:31 -0400
In-Reply-To: <alpine.DEB.2.20.1704252318080.3480@virtualbox>
References: <20170424032347.10878-1-liambeguin@gmail.com>
         <20170425044320.17840-1-liambeguin@gmail.com>
         <87zif4q0cy.fsf@linux-m68k.org>
         <alpine.DEB.2.20.1704252318080.3480@virtualbox>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.5 (3.22.5-1.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,


On Tue, 2017-04-25 at 23:23 +0200, Johannes Schindelin wrote:
> Hi Andreas,
> 
> On Tue, 25 Apr 2017, Andreas Schwab wrote:
> 
> > On Apr 25 2017, Liam Beguin <liambeguin@gmail.com> wrote:
> > 
> > > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > > index 475e874d5155..8b1877f2df91 100644
> > > --- a/Documentation/config.txt
> > > +++ b/Documentation/config.txt
> > > @@ -2614,6 +2614,25 @@ rebase.instructionFormat::
> > >  	the instruction list during an interactive rebase.  The format will automatically
> > >  	have the long commit hash prepended to the format.
> > >  
> > > +rebase.abbrevCmd::
> > > +	If set to true, `git rebase -i` will abbreviate the command-names in the
> > > +	instruction list. This means that instead of looking like this,
> > > +
> > > +-------------------------------------------
> > > +	pick deadbee The oneline of this commit
> > > +	pick fa1afe1 The oneline of the next commit
> > > +	...
> > > +-------------------------------------------
> > > +
> > > +	the list would use the short version of the command resulting in
> > > +	something like this.
> > > +
> > > +-------------------------------------------
> > > +	p deadbee The oneline of this commit
> > > +	p fa1afe1 The oneline of the next commit
> > > +	...
> > > +-------------------------------------------
> > 
> > That doesn't explain the point of the option.
> 
> And what you forgot to say in order to make this a constructive criticism
> is: we probably want to add a sentence like this:
> 
> 
> 	Using the one-letter abbreviations will align the lines better
> 	in case that the non-abbreviated commands have different lengths.
> 
> Speaking of commands with different lengths, I just thought of fixup and
> squash. I do not think those are handled by the patch, but they should be
> (the `action` in the first loop of `rearrange_squash` should abbreviate
> via `test p != "$pickcmd" || action=${action%${action#?}}`).
> 

I just noticed this today, I'll make changes to handle this case. 

> Ciao,
> Johannes

Thanks,
Liam
