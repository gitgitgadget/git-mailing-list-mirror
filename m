From: Jeff King <peff@peff.net>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Fri, 14 Jan 2011 11:33:33 -0500
Message-ID: <20110114163333.GA1230@sigill.intra.peff.net>
References: <AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
 <AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com>
 <AANLkTikk7Xdiey76Dmy848_B4qNX2-Vbis7p=E8vtNL9@mail.gmail.com>
 <AANLkTimONqL4=E4Unrsj9PU5u57KGXrmO6xWUOCLorgs@mail.gmail.com>
 <AANLkTi=PTgmOSC7pRLjujO5fi9Wdp69Jmj4zCkhGSYSz@mail.gmail.com>
 <AANLkTiksAZSi-Yo8yJv5ca9XWWvB3iVQhZOJtTs-F8gk@mail.gmail.com>
 <AANLkTi=Z6Dx6m68zi7Q1eRVxX3DXOyKj+Ff177UCQrAj@mail.gmail.com>
 <AANLkTimZF+r2aNzrXsUuHVZR65N5wpOYLutFgGAGoci_@mail.gmail.com>
 <20110114162144.GA867@sigill.intra.peff.net>
 <AANLkTimcQq++CLv66AyTve+PiXBhYdUPk2epCyOXX1c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tor Arntsen <tor@spacetec.no>, JT Olds <jtolds@xnet5.com>,
	git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 14 17:33:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pdmaq-0000c3-Nm
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 17:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757756Ab1ANQdh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jan 2011 11:33:37 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57484 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757189Ab1ANQdf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 11:33:35 -0500
Received: (qmail 6068 invoked by uid 111); 14 Jan 2011 16:33:35 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 14 Jan 2011 16:33:35 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jan 2011 11:33:33 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimcQq++CLv66AyTve+PiXBhYdUPk2epCyOXX1c0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165113>

On Fri, Jan 14, 2011 at 05:30:51PM +0100, Erik Faye-Lund wrote:

> > =C2=A02. Bump the check up to git-commit time, which is the best pl=
ace to
> > =C2=A0 =C2=A0 catch and tell somebody that their name is too short,=
 because they
> > =C2=A0 =C2=A0 can actually fix it.
> >
>=20
> The problem with (2) is that git-am uses git-commit-tree rather than
> git-commit. But I do think that adding the same checks to git-commit
> would make sense. Unless we decide to remove the checks, that is...

Yeah, I didn't say it very clearly, but I meant to factor the check out
and use it also in git-commit (probably as a warning, the same way we d=
o
with other ident verification in print_summary().

Even if we remove the check, it may still be worthwhile to say "Just so
you know, older versions of git may mangle the name you have chosen".

-Peff
