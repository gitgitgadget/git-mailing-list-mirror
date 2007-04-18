From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 20:26:58 -0400
Message-ID: <20070418002658.GA18683@fieldses.org>
References: <200704171041.46176.andyparkins@gmail.com> <Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org> <46250175.4020300@dawes.za.net> <Pine.LNX.4.64.0704171121090.5473@woody.linux-foundation.org> <20070417235649.GE31488@curie-int.orbis-terrarum.net> <7vps62lfbw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Rogan Dawes <lists@dawes.za.net>,
	Andy Parkins <andyparkins@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 02:27:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdy1L-00087c-L3
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 02:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbXDRA1W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 20:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753170AbXDRA1W
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 20:27:22 -0400
Received: from mail.fieldses.org ([66.93.2.214]:42209 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753164AbXDRA1W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 20:27:22 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1Hdy0g-0005Gn-Qe; Tue, 17 Apr 2007 20:26:58 -0400
Content-Disposition: inline
In-Reply-To: <7vps62lfbw.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44846>

On Tue, Apr 17, 2007 at 05:02:43PM -0700, Junio C Hamano wrote:
> "Robin H. Johnson" <robbat2@gentoo.org> writes:
> 
> > As for a usage case:
> > - J.PEBKAC.User gets a a tree (from a tarball or GIT, we should gain the
> >   same output)
> > - Copies some file outside of the tree (the user is NOT smart enough,
> >   and resists all reasonable attempts at edumacation)
> > - Modifies said file outside of tree.
> > - Contacts maintainer with entire changed file.
> > - User vanishes off the internet.
> >
> > The entire file he sent if it's CVS, contains a $Header$ that uniquely
> > identifies the file (path and revision), and the maintainer can simply
> > drop the file in, and 'cvs diff -r$OLDREV $FILE'.
> > If it's git, the maintainer drops the file in, and does 'git diff
> > $OLDSHA1 $FILE'.
> 
> I personally hope that the maintainer drops such a non-patch
> that originates from a PEBKAC.  At least I hope the tools that I
> personally use are not maintained by such a maintainer ;-)

That may not be quite fair--note the 'git diff $OLDSHA1 $FILE'.  So the
$Header$ here is a hint telling the maintainer how to produce a
(hopefully) reviewable patch, not an invitation to blindly drop random
files into the tree.  (Other objections to accepting code from random
non-reachable people aside....)

I've occasionally wondered before whether git could offer any help in
the case where, say, somebody hands me a file, I know it's based on
src/widget/widget.c from somewhere in v0.5..v0.7, and I'd like a guess
at the most likely candidates.

I haven't wondered that often enough that I'd consider it worth
embedding the blob SHA1 in every checked-out file, though!

--b.
