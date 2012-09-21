From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/test-lib.sh: do not trust $SHELL
Date: Fri, 21 Sep 2012 18:15:43 -0400
Message-ID: <20120921221543.GA29100@sigill.intra.peff.net>
References: <505CCA55.6030609@gmail.com>
 <1348260766-25287-1-git-send-email-artagnon@gmail.com>
 <20120921205834.GC22977@sigill.intra.peff.net>
 <CALkWK0kRzN_yQZ1JqJogBs6Z1nLhofBijHzeWR5YfQYHOtpaBA@mail.gmail.com>
 <20120921211217.GA24134@sigill.intra.peff.net>
 <CALkWK0nLLEF7wnUhF0JUAZVP6GG3KHmuYSDZLPS7uGCZPfhV3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 00:16:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFBVr-0007Lt-Rj
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 00:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758283Ab2IUWPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 18:15:46 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53803 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757058Ab2IUWPq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 18:15:46 -0400
Received: (qmail 9473 invoked by uid 107); 21 Sep 2012 22:16:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Sep 2012 18:16:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2012 18:15:43 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0nLLEF7wnUhF0JUAZVP6GG3KHmuYSDZLPS7uGCZPfhV3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206175>

On Sat, Sep 22, 2012 at 03:04:50AM +0530, Ramkumar Ramachandra wrote:

> > No, the #!-header is only information. When you run "make test" we
> > actually invoke the shell ourselves using $SHELL_PATH.
> 
> My SHELL_PATH is not set, and I can see SHELL_PATH ?= $(SHELL) in the
> Makefile.  Which shell is it supposed to point to? 

Something bourne compatible. If you are on a sane system, /bin/sh is
fine (and is the default).

> If you're proposing to use a variable that's only set in the Makefile
> in the test, you're not allowing users to run the test as a
> standalone- that's not a good change, is it?

It gets written to GIT-BUILD-OPTIONS, which should get pulled in by
test-lib.sh. There may be an ordering problem with the command line
parsing though.

-Peff
