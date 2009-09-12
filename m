From: Jeff King <peff@peff.net>
Subject: Re: Confusing git pull error message
Date: Sat, 12 Sep 2009 18:34:06 -0400
Message-ID: <20090912223406.GB8748@coredump.intra.peff.net>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
 <20090912211119.GA30966@coredump.intra.peff.net>
 <43d8ce650909121431o382b9348q19ee7db5adbb4a72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 00:34:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmbAt-0003PZ-G5
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 00:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208AbZILWeI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2009 18:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbZILWeI
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 18:34:08 -0400
Received: from peff.net ([208.65.91.99]:50346 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393AbZILWeH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 18:34:07 -0400
Received: (qmail 14725 invoked by uid 107); 12 Sep 2009 22:34:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 12 Sep 2009 18:34:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Sep 2009 18:34:06 -0400
Content-Disposition: inline
In-Reply-To: <43d8ce650909121431o382b9348q19ee7db5adbb4a72@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128306>

On Sun, Sep 13, 2009 at 12:31:46AM +0300, John Tapsell wrote:

> 2009/9/13 Jeff King <peff@peff.net>:
>=20
> > + =C2=A0 =C2=A0 =C2=A0 else
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "Your confi=
guration specified for us to pull the ref"
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "'$upstream=
_short', but we were unable to fetch it from"
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "the remote=
=2E"
>=20
> Thanks!
>=20
> But why was it 'unable' ?  Are there cases other than it not existing=
?
>  Maybe something less cryptic:
>=20
> "Attempted to pull from ref $upstream_short but this branch does not
> exist on remote."
>=20
> Or something?

I'm not sure if there are other cases, so I left it unspecified. I thin=
k
that "does not exist" is probably the only one that should make it this
far, though, as any actual error would cause fetch to die, aborting the
pull.

And you can see that when you ask for a specific bogus ref, as in:

  $ git pull origin bogus
  fatal: Couldn't find remote ref bogus

I'll re-roll the patch with more specific wording.

-Peff
