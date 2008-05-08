From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Teach git-svn how to catch up with its tracking branches
Date: Thu, 8 May 2008 09:38:51 +0200
Message-ID: <20080508073851.GA302@diana.vm.bytemark.co.uk>
References: <20080508013956.GA24956@midwinter.com> <20080508015806.GA759@pe.Belkin> <064B1E1A-9C5C-49A4-AD08-0397FE4C517E@midwinter.com> <20080508022504.GA931@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Chris Shoemaker <c.shoemaker@cox.net>
X-From: git-owner@vger.kernel.org Thu May 08 09:40:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju0jQ-00061b-1e
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 09:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212AbYEHHjL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 May 2008 03:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755412AbYEHHjL
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 03:39:11 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4686 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbYEHHjK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 03:39:10 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Ju0iJ-0000IJ-00; Thu, 08 May 2008 08:38:51 +0100
Content-Disposition: inline
In-Reply-To: <20080508022504.GA931@pe.Belkin>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81512>

On 2008-05-07 22:25:04 -0400, Chris Shoemaker wrote:

> On Wed, May 07, 2008 at 07:08:50PM -0700, Steven Grimm wrote:
>
> > The assumption here is that you have exactly the same revision
> > history in your tracking branches as the repo you're fetching
> > from.
>
> In that case, it would be helpful to enumerate exactly how two
> developers can ensure that they are creating the same revision
> history. At the very least, svn URL scheme and svnauthors file have
> to be the same.

Also, one mustn't use Subversion's ability to retroactively edit
commit messages. (Guess what we tend to do from time to time where I
work.)

What'd really be needed to get all of the corner cases right, I think,
is a single import point that everyone else pulls from. The patch that
started this thread would help that scenario, since it makes it
possible to pull from such a central import point, and then run the
dcommit locally. (There's still the problem that dcommit will do a
local import if necessary -- that would have to be fixed as well.
Maybe simply teach git-svn to always try to pull from a given git
repository before hitting the real svn repo.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
