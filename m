From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Make the output of "git svn clone" less confusing.
Date: Thu, 18 Oct 2007 10:14:43 -0700
Message-ID: <20071018171443.GA13040@untitled>
References: <87k5poflp5.fsf@lysator.liu.se> <20071018070617.GA29238@spearce.org> <20071018103301.GA21121@soma> <87abqgiqsj.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O.Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Oct 18 19:15:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiYxW-00075f-CU
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 19:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765639AbXJRROr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2007 13:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765095AbXJRROq
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 13:14:46 -0400
Received: from hand.yhbt.net ([66.150.188.102]:48602 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934010AbXJRROo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 13:14:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 937567DC0FE;
	Thu, 18 Oct 2007 10:14:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87abqgiqsj.fsf@lysator.liu.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61548>

David K=E5gedal <davidk@lysator.liu.se> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
>=20
> > "Shawn O. Pearce" <spearce@spearce.org> wrote:
> >> David K=E5gedal <davidk@lysator.liu.se> wrote:
> >> > The problem is that the first thing it prints is
> >> >=20
> >> >   Initialized empty Git repository in .git/
> >> >=20
> >> > even if actually created a subdirectory and changed into it firs=
t. But to the
> >> > user, it looks like it is creating a .git/ dir in the directory =
he/she is
> >> > started git from.
> >>=20
> >> Eric, ack/nack?
> >
> > Nack, here's (hopefully) a better patch.
> >
> > David: agree/disagree?
>=20
> I don't really like this. Now you added a dependency on exactly how
> git-init-db will format its output.  So if e.g. it is updated to use
> the absolute path your patch will create bogus output.

Yes, it's quite ugly :/   I think the best solution would be to fix all
GIT_DIR=3D setting issues and getting git-svn to always respect it for
init/clone/fetch (and tests, of course!).  I probably won't get around
to doing any of this until Friday night or Saturday (PST), however...

Shawn: feel free to ignore this series for now

> Did you consider my suggestion of not doing the chdir befor running
> git-init-db?

That would likely break clone, and also this (from my message
under the commit message).

>  I've actually just noticed that setting GIT_DIR=3D before running
>  git-svn clone is very broken, and I probably won't get a chance
>  to fix it for at least 24 hours (if I'm even awake)...

--=20
Eric Wong
