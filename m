From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Allowing override of the default "origin" nickname
Date: Fri, 11 Jan 2008 18:01:27 +0100
Message-ID: <20080111170127.GA23893@atjola.homenet>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <Pine.LNX.4.64.0801111301360.14355@wbgn129.biozentrum.uni-wuerzburg.de> <30e4a070801110506h19b77488sbfa6ae48701f30f9@mail.gmail.com> <alpine.LSU.1.00.0801111348230.31053@racer.site> <30e4a070801110653n61a826c0y33ed13f95cddf25d@mail.gmail.com> <alpine.LSU.1.00.0801111501510.31053@racer.site> <30e4a070801110839j6b27e224j9a83fc9975f2e4c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 18:02:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDNGa-0001DH-3P
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 18:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759949AbYAKRBc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2008 12:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760180AbYAKRBc
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 12:01:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:38613 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759646AbYAKRBb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 12:01:31 -0500
Received: (qmail invoked by alias); 11 Jan 2008 17:01:29 -0000
Received: from i577AC1E6.versanet.de (EHLO atjola.local) [87.122.193.230]
  by mail.gmx.net (mp053) with SMTP; 11 Jan 2008 18:01:29 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/Z7cpPnAjZ5TZAaNIZNGDEXqY2/8DthADRhKBq+y
	OPUY4QPardSHSt
Content-Disposition: inline
In-Reply-To: <30e4a070801110839j6b27e224j9a83fc9975f2e4c6@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-12-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70176>

On 2008.01.11 11:39:48 -0500, Mark Levedahl wrote:
> On Jan 11, 2008 10:03 AM, Johannes Schindelin >
> > Okay, so with your change the user has to either remember or lookup=
 which
> > is the default remote.  Without your change, the user has to either
> > remember or lookup where origin points to.
> >
> > I still think your change does not help.
>=20
> That's a theoretical argument: my *experience* with trying to make th=
e
> current workflow operate was sufficiently bad and troublesome that it
> caused me to write code and fix it to enable the new workflow. Also,
> absent submodules the new workflow is fully supported by
> branch.<name>.remote: are you advocating the elimination of that
> existing feature?

AFAICT your main point is that you can do:
git config --get remotes.default

and get an unique _symbolic_ name, right? So while you still need to
lookup the value of remotes.default, you get e.g. "myremote" instead of
"git://myremote/foo.git" which you get from "git remote show origin". A=
t
least that's how I interpreted it. Your argumentation wasn't that clear
on what you actually want to achieve/improve and why just looking up
"origin" isn't enough, IMHO.

A different approach, which feels more in-line with the current state o=
f
things, might be to allow remote aliases. "origin" would be an alias of
"myremote", and "git remote show origin" might say "origin is an alias
for myremote" followed by the details of "myremote". So that would give
you the same benefit, but "origin" would keep its meaning, and you woul=
d
not get different behaviour depending on some configuration setting (so
the poor folks on #git can just assume that "origin" is the default for
everyone).

Admittedly, I don't see any use-case for aliases except for that origin
thing, but maybe someone else does?

Bj=F6rn
