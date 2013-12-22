From: Adam Spiers <git@adamspiers.org>
Subject: Re: questions / suggestions about history simplification
Date: Sun, 22 Dec 2013 13:41:56 +0000
Message-ID: <20131222134156.GM23496@pacific.linksys.moosehall>
References: <20131219183645.GD23496@pacific.linksys.moosehall>
 <20131219190333.GE23496@pacific.linksys.moosehall>
 <xmqqsitoefvi.fsf@gitster.dls.corp.google.com>
 <20131219205858.GJ23496@pacific.linksys.moosehall>
 <7vr495jsf8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 22 14:42:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VujIB-00032p-6W
	for gcvg-git-2@plane.gmane.org; Sun, 22 Dec 2013 14:42:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878Ab3LVNl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Dec 2013 08:41:59 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:55404 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab3LVNl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Dec 2013 08:41:58 -0500
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 788C25428E
	for <git@vger.kernel.org>; Sun, 22 Dec 2013 13:41:57 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vr495jsf8.fsf@alter.siamese.dyndns.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239643>

On Sat, Dec 21, 2013 at 10:44:43PM -0800, Junio C Hamano wrote:
> Adam Spiers <git@adamspiers.org> writes:
> 
> >> I doubt it.  75% of the work for such a person to understand the
> >> behaviour from such an example is to understand what kind of history
> >> the example is building.
> >
> > Agreed.  And that's precisely why I wanted a real repository
> > manifesting the given example: being able to view it in gitk makes
> > that a lot easier to understand, for obvious reasons.
> > ...
> > Well I didn't roll my own; I just copied the example from the man
> > page.  So it only tells you that I was spending a fair amount of
> > effort trying to understand the man page ;-)
> 
> Oh, that part I would agree, but then ...
> 
> > Not if the man page says "if you wish to experiment with these options
> > yourself, you can easily recreate the repository in this example by
> > running the script contrib/foo bundled in the source distribution".
> > ...
> > The goal of sharing the series of commands is not to educate users
> > through reading them, but simply to save them the time they would have
> > to spend manually recreating the example scenario given in the man
> > page.
> 
> ... this part could be even easier if distro ships a sample repository,
> not a recipe to create such a sample repository, no?

It could ship either or both, but shipping a repository only saves the
user from having to run a single command to create the repository from
the script, and even that advantage is negated if the user wishes the
repository to be read/write (since then they would need "cp -a ...").

However, the question of how the distro should ship it is separate to
the question of how the git source repository and release tarballs
should provide it.  Including a script (e.g. in contrib/) means that
any changes to the man page can trivially be mirrored in that script
within a single commit, giving all the normal advantages git offers
for tracking source.  And then the distro can easily create the sample
repository from the script at package build-time, if they want to.

OTOH, including a sample repository embedded within the git repository
is either impossible or very ugly (e.g. having a non-default value of
GIT_DIR for the embedded repository).  But I doubt you were suggesting
that ;-)
