From: Josef Wolf <jw@raven.inka.de>
Subject: Re: git-svn and repository hierarchy?
Date: Fri, 27 Feb 2009 17:58:12 +0100
Message-ID: <20090227165812.GA14187@raven.wolf.lan>
References: <20090224223412.GA4573@raven.wolf.lan> <49A50EB2.80300@drmicha.warpmail.net> <20090225232442.GC4573@raven.wolf.lan> <eaa105840902251702l68bc35f3ia15b1c804a6825f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 27 18:02:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld66Q-0004QR-Mb
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 18:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758506AbZB0RAN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 12:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758512AbZB0RAN
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 12:00:13 -0500
Received: from quechua.inka.de ([193.197.184.2]:37977 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758457AbZB0RAL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 12:00:11 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1Ld64H-0001FC-56; Fri, 27 Feb 2009 18:00:09 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id AAED62C909; Fri, 27 Feb 2009 17:58:12 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <eaa105840902251702l68bc35f3ia15b1c804a6825f3@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111683>

On Wed, Feb 25, 2009 at 08:02:45PM -0500, Peter Harris wrote:
> On Wed, Feb 25, 2009 at 6:24 PM, Josef Wolf wrote:
> > And IMHO, there's one catch: to synchronize, I need to tightly
> > coordinate the work on git-svn-repos with the work on its clones. =A0=
The
> > clones are not reachable most of the time, so tightly coordinating
> > would slow down the flow of changesets extremely.
>=20
> Not sure if it helps, but for what it's worth, I use a circular setup=
:
> git-svn-repos is updated from subversion-repos (by cron), but is
> otherwise read-only. cloneN can pull from git-svn-repos (since
> git-pull is a whole lot faster than git svn fetch, especially for the
> initial clone), but has to "git svn dcommit" to push changes back
> upstream.
>=20
> This configuration puts any potential rebase conflicts back into the
> hands of cloneN.

Thanks for the suggestion, Peter!  I guess this would really solve
the problem.

> No need to coordinate clones, aside from each clone
> needing to know how to work in a "commits will be rebased by upstream=
"
> type of environment (which isn't unique to git-svn).

Hmm, what does that exactly mean?  Chances are that the reason for my
problem is that _I_ am the one who don't know that...

> Oh, and make sure
> you're using a recent git; older git-svn didn't have the incremental
> index rebuild.

jw@raven:/home/jw> git --version
git version 1.6.0.2
jw@raven:/home/jw>

Is that OK?
