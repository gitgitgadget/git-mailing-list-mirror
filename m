From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] git-svn: handle leading/trailing whitespace from
	svnsync revprops
Date: Sat, 12 Jan 2008 10:55:05 +0100
Message-ID: <20080112095505.GA5681@atjola.homenet>
References: <200801081738.56624.devurandom@gmx.net> <200801101813.45938.devurandom@gmx.net> <7v63y178a3.fsf@gitster.siamese.dyndns.org> <200801102213.04082.devurandom@gmx.net> <7vmyrd5p81.fsf@gitster.siamese.dyndns.org> <20080112071355.GA17021@soma> <7vzlvbv5m9.fsf@gitster.siamese.dyndns.org> <20080112091242.GA27109@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Dennis Schridde <devurandom@gmx.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jan 12 10:55:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDd5Y-0001sO-4G
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 10:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762688AbYALJzL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jan 2008 04:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762311AbYALJzL
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 04:55:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:35800 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754755AbYALJzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 04:55:09 -0500
Received: (qmail invoked by alias); 12 Jan 2008 09:55:07 -0000
Received: from i577AC1E6.versanet.de (EHLO atjola.local) [87.122.193.230]
  by mail.gmx.net (mp055) with SMTP; 12 Jan 2008 10:55:07 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19CqQFr1jhClQ4B7TVVZ/uNmTwXpoYTTPY/UjYq27
	S76LVmx20yyM2l
Content-Disposition: inline
In-Reply-To: <20080112091242.GA27109@soma>
User-Agent: Mutt/1.5.17 (2007-12-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70305>

On 2008.01.12 01:12:42 -0800, Eric Wong wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > Is it only me who finds that
> >=20
> > 	($var) =3D ($var =3D~ m{^(any regexp)$}) or die "message"
> >=20
> > is extremely a roundabout and hard-to-read way to say:
> >=20
> > 	if ($var !~ m{^(the same regexp)$} {
> >         	die "message";
> > 	}
> >=20
> > which is much easier to read?
>=20
> The statements are not equivalent, however.  I'd have to add
>=20
> 	$var =3D $1;
>=20
> too, because I needed to extract what was inside the ( ) since the '$=
'
> doesn't catch the trailing newline, either.  I also couldn't find any=
 of
> the /sm, /m, /s switches useful for making '$' not accept the trailin=
g
> newline, either.

The \z assertion will do, eg m/^foo\z/ will only match exactly "foo",
not "foo\n". As it is a zero-width assertion, you can also write
m/^foo\z$/ if you prefer that.

Bj=F6rn
