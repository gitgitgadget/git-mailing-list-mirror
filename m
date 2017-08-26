Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B09771F4DD
	for <e@80x24.org>; Sat, 26 Aug 2017 21:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbdHZVLJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 17:11:09 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:33967 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdHZVLI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Aug 2017 17:11:08 -0400
Received: by mail-wr0-f171.google.com with SMTP id z91so8256262wrc.1
        for <git@vger.kernel.org>; Sat, 26 Aug 2017 14:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VfIX914uE9NOEZQc7C55htLw4kqtQn3+k5N1zoLJ8qE=;
        b=L+yZmHe0KBAIP2vAAFsJPVTkKrjSmqj0Qg7S1XE5XPpmwJAaYLRW0tFO9OfsZCu/d4
         k19dZ0kVxT849ydu8VKR/FuO9wrUqba0B8QyZlE7rUKbw+KpD2kR9SGqjZ2/RAQ6gxue
         oqPdhqUdOqROnty+JM7vf6HSd91hXjjRtwaCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VfIX914uE9NOEZQc7C55htLw4kqtQn3+k5N1zoLJ8qE=;
        b=PrWMtHkDwHZGHGBPCYlaJIAwZ/GcEOOUZwQF7ElQtiCWdsyO8R49sc9v7dKuZMzouM
         VWVv/hmvN43dEF/XtWn8N1feC8Wof9L1vmKFJR8g72MucNdBBwyEUEn8smPLWWugzPaK
         t4yJ6lm8JOw1j632WcsSrgu26kT4AqCGYKudQhrRBp2fDKtMLKC6yNFK+yV323QGVZa6
         tNtkKZQdg7YNRfMFiDeWkEXc2Dm2+6jnIO/CbfUc6v/OOa7mHX6AWg9ykeYflqGfTD1j
         K1Ml6Z3ih1Q24OmXooKV4t8LK39etcnNJEij4BG+oe2OoX+v/Bek9pQ/STuw5uzySMvv
         L40A==
X-Gm-Message-State: AHYfb5g6Ki+dEq5yJqOh7RnGYn9YJChdoK9E7a6erp6QhpbeXdUH0gn6
        xlcXkwhAigldB8TA
X-Received: by 10.223.136.59 with SMTP id d56mr125340wrd.136.1503781867536;
        Sat, 26 Aug 2017 14:11:07 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id a53sm5060052wra.76.2017.08.26.14.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Aug 2017 14:11:05 -0700 (PDT)
Date:   Sat, 26 Aug 2017 22:11:04 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: cat-file timing window on Cygwin
Message-ID: <20170826211104.GC10378@dinwoodie.org>
References: <20170825112529.GA10378@dinwoodie.org>
 <20170825150819.agxvbjytom7ao6n6@sigill.intra.peff.net>
 <253bf111-4e8a-54b7-6e39-2908270aa357@ramsayjones.plus.com>
 <20170826185337.hrcswjuunon54kgj@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170826185337.hrcswjuunon54kgj@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 26, 2017 at 11:53:37AM -0700, Jeff King wrote:
> On Sat, Aug 26, 2017 at 01:57:18AM +0100, Ramsay Jones wrote:
> 
> > > diff --git a/run-command.c b/run-command.c
> > > index 98621faca8..064ebd1995 100644
> > > --- a/run-command.c
> > > +++ b/run-command.c
> > > @@ -641,7 +641,6 @@ int start_command(struct child_process *cmd)
> > >  	}
> > >  
> > >  	trace_argv_printf(cmd->argv, "trace: run_command:");
> > > -	fflush(NULL);
> > >  
> > >  #ifndef GIT_WINDOWS_NATIVE
> > >  {
> > 
> > I suspect not, but I can give it a try ...
> > 
> > ... oh, wow, that works! Ahem. (Hmm, so it's flushing stdin?!)
> 
> Interesting. I find it a little hard to believe there's so obvious a bug
> as "fflush(NULL) flushes stdin", but well...that's what it seems like.
> 
> If that's truly what it is, this is the minimal reproduction I came up
> with:
> 
> -- >8 --
> #include <stdio.h>
> 
> int main(void)
> {
> 	char buf[256];
> 	while (fgets(buf, sizeof(buf), stdin)) {
> 		fprintf(stdout, "got: %s", buf);
> 		fflush(NULL);
> 	}
> 	return 0;
> }
> -- 8< --
> 
> If this really is the bug, then doing something like "seq 10 | ./a.out"
> would drop some of the input lines.

...yep.  It does.  Specifically, I consistently only get the firsts
line:

    $ seq 10 | ./a.exe
    got: 1
    
    $ 

If I introduce a delay between the lines of stdin (which I tested by
just typing stdin from the keyboard), it works as expected.

Looks like this one will need to go to the Cygwin mailing list; I'll
take it there shortly.  Thank you all for your help getting this far!
