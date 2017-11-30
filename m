Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88A4820C11
	for <e@80x24.org>; Thu, 30 Nov 2017 20:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751675AbdK3UvG (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 15:51:06 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:44905 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbdK3UvE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 15:51:04 -0500
Received: by mail-wr0-f177.google.com with SMTP id l22so7948350wrc.11
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 12:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iSDE8HBXLZswEc7jbjPrJ6BMvq6kRKAizYJBqYQxx3k=;
        b=qqYAKnQx7TLjlJSn9rUs31nr0SYIweSd/TbfD9by3LSPfFAGSxVX5uJGOe/wWHxd3N
         Eyl0wAfWnwYVq+Lw32PqCPIX1zmzvoKu1PXU0BXc8/JSqbeNDHhKnfZgbkvF2RcF/hPW
         HbJhE/Wgy0PXKfXS+yeC6nePaP7Fn8YUSgY+QfytQmQcmuId6qvz1aflseJo4jYjap0X
         WhNTwzt0eZ8EhwcWE11wdbcFg8CPtt2k2ApmwdgYw9wYKz4P4IFt2IHRJxH9uBJ6UmiC
         lZ6AJEhs464wea4ffrqmmck4DSZl9usXtr6t1TfsRjQvBYIAj9uwlOgVQEys5aCY5SO/
         VTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iSDE8HBXLZswEc7jbjPrJ6BMvq6kRKAizYJBqYQxx3k=;
        b=lLGtLPmNIjWeTGUxbLVmn6kI82o9cJW22pcC32/XNNIZhlgAgF9tvOSBposo4M1WDd
         IcXCha4d/j1TRl+vqR0AWG92+nE8Y/+QMFDJJlIXfdNWATpdLyqCj8H8RXZawOoDILSO
         o6z6huDkJ6IKF8rux+fF4tiL6W4oixqn5yYMltqKRe2FN5+6KmmdSkMUZtNnfxUACQJ0
         GV34FQ+zMNGqNC4YIDdKplgnIxWMJwSQeo6tn1H6l1PRTlX+x26JMe3fokAPk5aqJNFS
         HLBfAU+hTsVzljuswvUTq50AFK3w39JoVY9rVRiKDbob5LVGGRkWLpkCuIYlWz36+pJd
         RRWg==
X-Gm-Message-State: AJaThX5LcXu1s4WVb8U5qMo59YpV4hbzTuLgDvIUpfQakQhrGUA22S7p
        icFRr2dTgEoYK9Sa5pHhioI=
X-Google-Smtp-Source: AGs4zMabNm05FBlLN9iqPrWN64I12DjcQUH1vVGGWY3GCORDrH7U57x0s8qyaLNTEWR7XogKqayZrA==
X-Received: by 10.223.176.113 with SMTP id g46mr3149163wra.267.1512075063208;
        Thu, 30 Nov 2017 12:51:03 -0800 (PST)
Received: from laptop.local (host-78-145-151-122.as13285.net. [78.145.151.122])
        by smtp.gmail.com with ESMTPSA id 90sm8888336wrp.93.2017.11.30.12.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 12:51:02 -0800 (PST)
Date:   Thu, 30 Nov 2017 20:51:00 +0000
From:   Thomas Adam <thomas@xteddy.org>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Adam <thomas@xteddy.org>, lars.schneider@autodesk.com,
        git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        sunshine@sunshineco.com, kaartic.sivaraam@gmail.com,
        sandals@crustytoothpaste.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 0/2] launch_editor(): indicate that Git waits for user
 input
Message-ID: <20171130205058.o6e2ggnjpadaxu46@laptop.local>
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
 <20171129183514.wze5trxjfgqxqs7z@laptop.local>
 <20171130201217.GA3578@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171130201217.GA3578@sigill.intra.peff.net>
User-Agent: NeoMutt/20170714-87-e4144b (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 30, 2017 at 03:12:17PM -0500, Jeff King wrote:
> On Wed, Nov 29, 2017 at 06:35:16PM +0000, Thomas Adam wrote:
> 
> > On Wed, Nov 29, 2017 at 03:37:50PM +0100, lars.schneider@autodesk.com wrote:
> > > +		if (print_waiting_for_editor) {
> > > +			fprintf(stderr, _("hint: Waiting for your editor input..."));
> > >  			fflush(stderr);
> > 
> > Just FYI, stderr is typically unbuffered on most systems I've used, and
> > although the call to fflush() is harmless, I suspect it's not having any
> > effect.  That said, there's plenty of other places in Git which seems to think
> > fflush()ing stderr actually does something.
> 
> I'd prefer to keep them (including this one), even if they are noops on
> most platforms, because:
> 
>   1. They serve as a note for readers of the code that it's important
>      for the output to have been printed immediately.
> 
>   2. We build on some funny and antique platforms. I wouldn't be
>      surprised if there's one that line buffers by default. Or even a
>      modern system with funny settings (e.g., using the GNU stdbuf
>      tool).
> 
> (I know you said later you don't think this case needs to be removed,
> but I want to make it clear I think it's a reasonable project-wide
> policy to not assume we we know how stderr is buffered).

We're talking past each other, Peff.  I'm agreeing with you.  I was surprised
to see the introduction of fflush(stderr) in the interdiff, when it wasn't
present before, was curious to understand why.  I've done that, and since
stated it's fine to leave it as-is.

-- Thomas Adam
