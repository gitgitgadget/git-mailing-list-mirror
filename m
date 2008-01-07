From: Jeff King <peff@peff.net>
Subject: Re: rm and mv commands: should I use them?
Date: Sun, 6 Jan 2008 20:55:19 -0500
Message-ID: <20080107015518.GD17748@coredump.intra.peff.net>
References: <379EDA94-A67B-483A-BC5F-E961DD52AD0C@gmail.com> <alpine.LFD.1.00.0801061108320.2811@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Hancock <redstarling@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 07 02:55:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBhDQ-0003mO-Lu
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 02:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbYAGBzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 20:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752597AbYAGBzW
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 20:55:22 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4378 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752582AbYAGBzV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 20:55:21 -0500
Received: (qmail 2440 invoked by uid 111); 7 Jan 2008 01:55:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 06 Jan 2008 20:55:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jan 2008 20:55:19 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801061108320.2811@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69752>

On Sun, Jan 06, 2008 at 11:22:50AM -0800, Linus Torvalds wrote:

> > So, do I need to use git's mv and rm commands?
> 
> Nope.
> 
> They are there only to
> 
>  (a) make people who are used to do "svn mv" not complain
> 
>  (b) simplify things a little teeny bit, by avoiding having to "git add" 
>      the new file.

I haven't looked to see if this optimization is in place, but "git mv"
can also avoid having to recompute the sha1 of the file (which in most
cases doesn't matter, but on a large file with a cold cache, can make
the operation seem just as snappy as a regular "mv").

-Peff
