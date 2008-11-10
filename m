From: Ian Hilt <ian.hilt@gmx.com>
Subject: Re: [PATCH] git send-email: edit recipient addresses with the 
 --compose flag
Date: Sun, 9 Nov 2008 19:38:30 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811091910570.21142@sys-0.hiltweb.site>
References: <1226235588-2997-1-git-send-email-ian.hilt@gmx.com> <200811091513.55544.fg@one2team.com> <alpine.LFD.2.00.0811091344480.20499@sys-0.hiltweb.site> <7viqqwa6wo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-960896940-1226277531=:21142"
Cc: Francis Galiegue <fg@one2team.com>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 01:40:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzKpP-0000QQ-0p
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 01:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756610AbYKJAjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 19:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756585AbYKJAjF
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 19:39:05 -0500
Received: from mail.gmx.com ([74.208.5.67]:55269 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756570AbYKJAjE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 19:39:04 -0500
Received: (qmail invoked by alias); 10 Nov 2008 00:39:00 -0000
Received: from cpe-75-185-223-130.woh.res.rr.com [75.185.223.130]
  by mail.gmx.com (mp-us005) with SMTP; 09 Nov 2008 19:39:00 -0500
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX1+nfot60/WnYkx5AGUFLgYTssEuIdXDZT97xKF2kZ
	nABb6GA8tLyQQP
In-Reply-To: <7viqqwa6wo.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100482>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-960896940-1226277531=:21142
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 9 Nov 2008, Junio C Hamano wrote:
> Ian Hilt <ian.hilt@gmx.com> writes:
>=20
> > On Sun, 9 Nov 2008, Francis Galiegue wrote:
> >> Le Sunday 09 November 2008 13:59:48 Ian Hilt, vous avez =C3=A9crit=C2=
=A0:
> >> > +=09if ($c_file =3D~ /^To:\s*+(.+)\s*\nCc:/ism) {
> >>=20
> >> Greedy operators are only supported with perl 5.10 or more... I think =
it's a=20
> >> bad idea to use them...
> >
> > The problem here was that a space should follow the field, but it may
> > not.  The user may unwarily backup over it.  "\s*" would match this
> > case.
> >
> > But if there is a space, it is included in the "(.+)".  So I tried
> > "\s+", which did not include the space, but it won't include the first
> > address if there isn't a space after the field.
> >
> > The quantified subpattern seemed to do the trick.  But, if it could
> > result in a dependency issue, I would agree this would be a bad idea.
>=20
> You expect something non-blank there anyway, so why not do:
>=20
> =09To:\s*(\S.*?)\s*\n....

That works.  Although, I seem to be missing Francis' point.  According
to perlre, a quantified subpattern is "greedy".  So a "greedy operator"
is any one of the standard quantified subpatterns.  The "+" and "?"
modify its matching behavior.  And it seems to me that it _has_ to use a
q.s. to work ...
--8323328-960896940-1226277531=:21142--
