From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: clong an empty repo over ssh causes (harmless) fatal
Date: Mon, 31 Aug 2009 22:19:11 +0200
Message-ID: <20090831201911.GA24989@atjola.homenet>
References: <slrnh9nc4e.6bn.sitaramc@sitaramc.homelinux.net>
 <vpqskf8z0rj.fsf@bauges.imag.fr>
 <2e24e5b90908310730u53ee27d3nd2b66c1f58202e7@mail.gmail.com>
 <20090831164146.GA23245@coredump.intra.peff.net>
 <vpqocpvevzx.fsf@bauges.imag.fr>
 <20090831191032.GB4876@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 31 22:19:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiDLl-0001kJ-5S
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 22:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbZHaUTT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2009 16:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754546AbZHaUTS
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 16:19:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:42857 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753969AbZHaUTP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 16:19:15 -0400
Received: (qmail invoked by alias); 31 Aug 2009 20:19:16 -0000
Received: from i59F5591B.versanet.de (EHLO atjola.homenet) [89.245.89.27]
  by mail.gmx.net (mp071) with SMTP; 31 Aug 2009 22:19:16 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18Y8Nc88zcYrOxA1b7T6rNsRqOgPpZMEbntY/uZPP
	7/LWloF7PipcUL
Content-Disposition: inline
In-Reply-To: <20090831191032.GB4876@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127497>

On 2009.08.31 15:10:32 -0400, Jeff King wrote:
> On Mon, Aug 31, 2009 at 07:25:22PM +0200, Matthieu Moy wrote:
>=20
> > Since the client and server are the same machine:
> >=20
> >     $ git clone ssh://sitaram@localhost/home/sitaram/t/a b
> >=20
> > I'd bet Sitaram has two installations of git, and plain ssh to the
> > machine points to the old one (like a $PATH set in ~/.login and not
> > ~/.profile or something like that).
>=20
> Oh, indeed. I didn't notice that his host was @localhost. :)
>=20
> But yes, that would be my guess, as well. Trying "ssh sitaram@localho=
st
> git version" would be a good clue.

I see the problem here, too.

doener@atjola:~ $ (mkdir a; cd a; git init)
Initialized empty Git repository in /home/doener/a/.git/

doener@atjola:~ $ git clone localhost:a b
Initialized empty Git repository in /home/doener/b/.git/
warning: You appear to have cloned an empty repository.
fatal: The remote end hung up unexpectedly

doener@atjola:~ $ ssh localhost git --version
git version 1.6.4.2.236.gf324c

Bj=F6rn
