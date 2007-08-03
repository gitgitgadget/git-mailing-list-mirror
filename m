From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: Shell script cleanups/style changes?
Date: Fri, 3 Aug 2007 21:29:42 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070803192942.GA23432@informatik.uni-freiburg.de>
References: <86bqdqkygp.fsf@lola.quinscape.zz> <20070802140011.GN29424@schiele.dyndns.org> <86sl72j9vn.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 21:29:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH2qP-0000dZ-S2
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 21:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758774AbXHCT3r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 3 Aug 2007 15:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758752AbXHCT3r
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 15:29:47 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:63290 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754717AbXHCT3q (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2007 15:29:46 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IH2qG-0007YP-Os; Fri, 03 Aug 2007 21:29:44 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l73JThTX024317;
	Fri, 3 Aug 2007 21:29:43 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l73JTg9U024316;
	Fri, 3 Aug 2007 21:29:42 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <86sl72j9vn.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54747>

David Kastrup wrote:
> Robert Schiele <rschiele@gmail.com> writes:
>=20
> > On Thu, Aug 02, 2007 at 12:44:22PM +0200, David Kastrup wrote:
> >> ! 		logfile=3D"${1#-?}"
> >
> > You can't do something like that on /bin/sh on many systems (for
> > instance Solaris).
>=20
> Sigh.  It's in Posix.
Well Solaris is (kind of) Posix compliant---you need some extra effort
to get it into Posix "mode":

	login@~ > uname -a
	SunOS login 5.10 Generic_125100-10 sun4u sparc
	login@~ > sh
	$ set tralala
	$ echo "${1#tra}"
	lala
	$ ^D

the "problem" here is, that my PATH includes /usr/xpg4/bin before
/usr/bin and that's non-standard (for Solaris).  That is
/usr/xpg4/bin/sh is Posix compliant and /usr/bin/sh is compatible to
former versions of Solaris/SunOS and this one doesn't support these
substitutions:

	login@~ > /usr/bin/sh
	$ set tralala
	$ echo "${1#tra}"
	bad substitution

Having=20

	login@~ > ls -l /bin
	lrwxrwxrwx 1 root root 9 2006-07-03 09:29 /bin -> ./usr/bin

sadly the Solaris sh is used for shell scripts that use a shebang line
calling /bin/sh.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D5+choose+3
