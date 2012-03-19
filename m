From: Jeff King <peff@peff.net>
Subject: Re: A better git diff --word-diff (--word-diff-regex) ?
Date: Mon, 19 Mar 2012 11:10:28 -0400
Message-ID: <20120319151028.GC24848@sigill.intra.peff.net>
References: <CAA01CsrJ12LmNYe6ujnDsZecJcGc8mFaB=1GC8-RZzvMYbYuUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 16:10:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9eEI-0002jZ-69
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 16:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755662Ab2CSPKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 11:10:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53490
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416Ab2CSPKc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 11:10:32 -0400
Received: (qmail 31049 invoked by uid 107); 19 Mar 2012 15:10:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Mar 2012 11:10:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Mar 2012 11:10:28 -0400
Content-Disposition: inline
In-Reply-To: <CAA01CsrJ12LmNYe6ujnDsZecJcGc8mFaB=1GC8-RZzvMYbYuUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193431>

On Mon, Mar 19, 2012 at 10:44:31AM +0100, Piotr Krukowiecki wrote:

> is there a way to configure --word-diff to be a more programming
> language friendly? For example if I add one parameter to a function
> declaration, I'd like to see only the addition of the parameter as the
> change. But currently it shows much more.
> 
> For example if
>   void foo(int x);
> is changed to
>   void foo(int x, int y);
> I'd like to see only ",int y" as the change, not "x, int y);".

This does not directly answer your question, but you may want to look at
the diff-highlight script in contrib/diff-highlight. I wrote it because
I found word-diff often unreadable, but still wanted something to
highlight small changes on a line like this.

On your example, it produces:

  -void foo(int x);
  +void foo(int x{+, int y});

except that the {+...} bit is highlighted by color, which makes it quite
readable.

-Peff
