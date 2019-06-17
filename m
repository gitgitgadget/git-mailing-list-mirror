Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 877C11F462
	for <e@80x24.org>; Mon, 17 Jun 2019 23:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfFQXds (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 19:33:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38347 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbfFQXds (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 19:33:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id a186so6487518pfa.5
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 16:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=INdECQtYmrCkfpAHkW487wKegA6zQg+pRtb9AOZFK6c=;
        b=cjXl99pq421irirAiVfPRB3P3jeHKliGMnsppTiruhBNSTL33r5U1ugxfqq4w8MOVu
         z7WnQn4QA/aeEczXxHzmzDwx2RBWLWIqPmJnhIMSt878Xr9kuNnFZR3Y4aiTQHW4Yk3b
         rzBEHJBIcXMZOmKFoSMCLjeL/Nl8Ams+2JpYXL1rjHfXqgzVYzK+4okLwMFJ5un20ZSw
         C3lW9fHb+wjQ2PbYaeMmVCAXi64swbCaL1HsEg/t1vvZVxv6mpvXlGYn9iemBLlnqxjL
         C28TiDt3cFPzuRI7OOIquhoVNgSPCd29fc90WI3J2oxnJZFXWYV8em1DNipYRtuAJnNO
         Yesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=INdECQtYmrCkfpAHkW487wKegA6zQg+pRtb9AOZFK6c=;
        b=V63F+otuPD6DtPC86fZaVtLjKZ8tShzurnvr0KnvxlJkueUGT0TM1qo59kPIjbwqq4
         QafAFtEoXYikBADQ5FiAfiXvOHuazQdERpkWLPGAUHZRSviDc8T8HWPYfpf8DbNRAvCk
         konrJcnx0A/FjjMi6JwCZ9Ye9sKqNtgMgYx0oCZdLyPXSZRCLEKkYWy2vZnhIPWzE6vr
         KkCHwjR9mxWQCKpOR6u+clbwNDpvk/zyfzaCgb72AgGL1JQSTwGy6R86ZFYF1iApYd8E
         jBcF6kBLHa33B4bCokgGjERidKX3Ctp07mUQzTFBK4M6pqyoLXM7WODEnjMBBPRa9KAl
         jkWA==
X-Gm-Message-State: APjAAAVCEz2b4+iJMuhPtY30z9K1Y+/NaX8tc+Eor6NWEqVqQFSZKx9x
        tXJB1VHDRZFre1E1g76tPyO13g==
X-Google-Smtp-Source: APXvYqwsPUGAKyfGa74FzqS8QVxGNGn46EkBxw0dyN3lQfkDVKUwGuymaqua2PPHlWh0ifYKTverPg==
X-Received: by 2002:a62:b40a:: with SMTP id h10mr118094982pfn.216.1560814427081;
        Mon, 17 Jun 2019 16:33:47 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id a16sm19372689pfd.68.2019.06.17.16.33.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 16:33:46 -0700 (PDT)
Date:   Mon, 17 Jun 2019 16:33:41 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] documentation: add tutorial for revision walking
Message-ID: <20190617233341.GC100487@google.com>
References: <20190607010708.46654-1-emilyshaffer@google.com>
 <xmqq7e9tmahm.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7e9tmahm.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 10, 2019 at 01:49:41PM -0700, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > +My First Revision Walk
> > +======================
> > +
> > +== What's a Revision Walk?
> > +
> > +The revision walk is a key concept in Git - this is the process that underpins
> > +operations like `git log`, `git blame`, and `git reflog`. Beginning at HEAD, the
> > +list of objects is found by walking parent relationships between objects. The
> > +revision walk can also be usedto determine whether or not a given object is
> > +reachable from the current HEAD pointer.
> 
> s/usedto/used to/;
Done.
> 
> > +We'll put our fiddling into a new command. For fun, let's name it `git walken`.
> > +Open up a new file `builtin/walken.c` and set up the command handler:
> > +
> > +----
> > +/*
> > + * "git walken"
> > + *
> > + * Part of the "My First Revision Walk" tutorial.
> > + */
> > +
> > +#include <stdio.h>
> 
> Bad idea.  In the generic part of the codebase, system headers are
> supposed to be supplied by including git-compat-util.h (or cache.h
> or builtin.h, that are common header files that begin by including
> it and are allowed by CodingGuidelines to be used as such).
Done.
> 
> > +#include "builtin.h"
> > +
> > +int cmd_walken(int argc, const char **argv, const char *prefix)
> > +{
> > +        printf(_("cmd_walken incoming...\n"));
> > +        return 0;
> > +}
> > +----
> 
> I wonder if it makes sense to use trace instead of printf, as our
> reader has already seen the psuh example for doing the above.

Hmmm. I will think about it and look into the intended use of each. I
hadn't considered using a different logging method.

> 
> > +Add usage text and `-h` handling, in order to pass the test suite:
> 
> It is not wrong per-se, and it indeed is a very good practice to
> make sure that our subcommands consistently gives usage text and
> short usage.  Encouraging them early is a good idea.
> 
> But "in order to pass the test suite" invites "eh, the test suite
> does not pass without usage and -h?  why?".
> 
> Either drop the mention of "the test suite", or perhaps say
> something like
> 
> 	Add usage text and `-h` handling, like all the subcommands
> 	should consistently do (our test suite will notice and
> 	complain if you fail to do so).
> 
> i.e. the real purpose is consistency and usability; test suite is
> merely an enforcement mechanism.

Yeah, you're right. I'll reword this.

> 
> > +----
> > +{ "walken", cmd_walken, RUN_SETUP },
> > +----
> > +
> > +Add it to the `Makefile` near the line for `builtin\worktree.o`:
> 
> Backslash intended?

Nope, typo.


Thanks for the comments, Junio.

 - Emily
