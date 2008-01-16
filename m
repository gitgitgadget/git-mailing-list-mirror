From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [FEATURE REQUEST] git-svn format-patch
Date: Tue, 15 Jan 2008 21:20:52 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801152109580.13593@iabervon.org>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>  <478D1442.2090301@gmx.ch> <c0f2d4110801151230g5843df66t62fb659375a1680e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jean-Luc Herren <jlh@gmx.ch>, git@vger.kernel.org
To: Chris Ortman <chrisortman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 03:21:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JExuI-0004Qo-Pz
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 03:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbYAPCVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 21:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753833AbYAPCVF
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 21:21:05 -0500
Received: from iabervon.org ([66.92.72.58]:50392 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169AbYAPCVC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 21:21:02 -0500
Received: (qmail 13386 invoked by uid 1000); 16 Jan 2008 02:20:52 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Jan 2008 02:20:52 -0000
In-Reply-To: <c0f2d4110801151230g5843df66t62fb659375a1680e@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70605>

On Tue, 15 Jan 2008, Chris Ortman wrote:

> You are correct about Tortoise in that it is too strict.
> I looked through their code and they have written their own patch
> program which keys off these Index: lines
> http://tortoisesvn.tigris.org/svn/tortoisesvn/trunk/src/TortoiseMerge/Patch.cpp
> 
> I think it could go either way as to if git-svn creates a different
> format patch or tsvn accepts multiple formats, but I anticipated
> git-svn would be easier to extend so I started here.

I think it would be worthwhile for tsvn to be less picky in some ways. It 
should at least be able to accept GNU diff, since sometimes people send 
maintainers patches prepared by hand (diff -u file.c.orig file.c), and 
there are comments in there that suggest that they're trying to support 
non-svn-generated diffs, although they seem to think that such diffs look 
like:

Index: filename
============
@@ -xxx,xxx +xxx,xxx @@
...

which isn't anything I've ever seen. You're much more likely to get:

...junk...
--- junk
+++ filename	junk
@@ -xxx,xxx +xxx,xxx @@

And that should be easy enough to parse as an alternative format in tsvn. 
(I'd send them a patch to do it, but they wouldn't be able to apply it...)

	-Daniel
*This .sig left intentionally blank*
