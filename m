Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-0.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 11063 invoked by uid 107); 4 Oct 2009 13:49:41 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 04 Oct 2009 09:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757131AbZJDNlB (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Oct 2009 09:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757106AbZJDNlB
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 09:41:01 -0400
Received: from peff.net ([208.65.91.99]:59034 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757074AbZJDNlA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 09:41:00 -0400
Received: (qmail 11044 invoked by uid 107); 4 Oct 2009 13:43:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 04 Oct 2009 09:43:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Oct 2009 09:40:22 -0400
Date:	Sun, 4 Oct 2009 09:40:22 -0400
From:	Jeff King <peff@peff.net>
To:	Mark Rada <marada@uwaterloo.ca>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] tests: make all test files executable
Message-ID: <20091004134022.GA14209@sigill.intra.peff.net>
References: <4AC55E78.7010109@mailservices.uwaterloo.ca>
 <20091002080134.GD27664@coredump.intra.peff.net>
 <20091002083946.GA8627@coredump.intra.peff.net>
 <1762B430-2DC0-48F5-8C34-8428F9145A1E@mailservices.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1762B430-2DC0-48F5-8C34-8428F9145A1E@mailservices.uwaterloo.ca>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Oct 04, 2009 at 09:18:20AM -0400, Mark Rada wrote:

> >Ah, nevermind. The problem is that your patch was word-wrapped, making
> >the second "diff --git" line bogus. It would have been nice to have it
> >print a warning instead of silently ignoring that bit of the patch.
> >
> I didn't have format=flowed buggering things up this time, so I don't
> quite understand the problem; could you please explain with more
> details?

Sure. The patch is perfect except for one line. What should have been:

diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh

was wrapped to:

diff --git a/t/t9501-gitweb-standalone-http-status.sh
b/t/t9501-gitweb-standalone-http-status.sh

I have no idea how you did that, though. :)

It looks like you send with Thunderbird. How do you get the diff content
into the email? Is it possible that it wraps the content after you have
gotten it there?

> When I try to apply the patch from a saved copy of the e-mail, I get
> the following error:
> 
> 	# git am ~/Downloads/\[PATCH\]\ tests_\ make\ all\ test\ files\
> executable.eml
> 	Patch format detection failed.
> 	zsh: exit 1     git am
> 
> The difference between the patch created by format-patch and the saved
> e-mail is just some e-mail header information. Is that a different error
> than what you were getting? I'm not sure what I'm doing wrong here, help
> would be appreciated.

Yeah, that's totally different than the problem I was having. I save to
an mbox from mutt, which "git am" understands just fine. I'd have to see
what was in your .eml file to know why "git am" couldn't figure it out
(and it might be a good test case, as "git am" has recently learned to
accept more mailbox formats).

-Peff
