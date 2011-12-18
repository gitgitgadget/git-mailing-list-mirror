From: Jeff King <peff@peff.net>
Subject: Re: Escape character for .gitconfig
Date: Sun, 18 Dec 2011 04:51:20 -0500
Message-ID: <20111218095120.GA2290@sigill.intra.peff.net>
References: <4EEC6A9D.1060005@icefield.yk.ca>
 <20111217105806.GB23935@sigill.intra.peff.net>
 <4EED9BE5.8060600@icefield.yk.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Erik Blake <erik@icefield.yk.ca>
X-From: git-owner@vger.kernel.org Sun Dec 18 10:51:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcDOz-0002JK-0A
	for gcvg-git-2@lo.gmane.org; Sun, 18 Dec 2011 10:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517Ab1LRJvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 04:51:24 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45296
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496Ab1LRJvX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 04:51:23 -0500
Received: (qmail 20474 invoked by uid 107); 18 Dec 2011 09:58:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 18 Dec 2011 04:58:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Dec 2011 04:51:20 -0500
Content-Disposition: inline
In-Reply-To: <4EED9BE5.8060600@icefield.yk.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187417>

On Sun, Dec 18, 2011 at 08:53:09AM +0100, Erik Blake wrote:

> That did the trick for this git newb. For the record, I had tried \(,
> /(, double- and single-quoting the entire path (note that git config
> --global had removed the quotes that were originally around the
> string). Did not think of "nested" quotes.

Yeah, if you are using "git config" to enter it on the command line,
you'll have to put an extra layer of quoting around it to pass it
through the shell you're currently running. That's why I showed the
example as the actual config file text. :)

> Now, however, I have a different problem in that notepad++ is somehow
> signalling git that editing is complete before I even get a chance to
> edit the file. I am trying the command
> >git commit --amend

Yep. This is a general problem with editors that open files in an
existing session. The only signal git has of the user being done editing
is when when the editor process exits. For many editors, there is an
option or other trick for sticking around until the file is closed.

I know nothing about notepad++, but a quick google turned up the
"-multiInst" option, which would avoid attaching to the existing
instance. That might work for you.

-Peff
