From: Ian Hilt <ian.hilt@gmx.com>
Subject: Re: [PATCH] git send-email: edit recipient addresses with the 
 --compose flag
Date: Sun, 9 Nov 2008 15:09:21 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811091344480.20499@sys-0.hiltweb.site>
References: <1226235588-2997-1-git-send-email-ian.hilt@gmx.com> <200811091513.55544.fg@one2team.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; boundary="8323328-822990668-1226259065=:20499"
Cc: Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Francis Galiegue <fg@one2team.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 21:11:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzGd9-0003QH-Ic
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 21:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758900AbYKIUJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 15:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758896AbYKIUJa
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 15:09:30 -0500
Received: from mail.gmx.com ([74.208.5.67]:60548 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758893AbYKIUJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 15:09:29 -0500
Received: (qmail invoked by alias); 09 Nov 2008 20:09:27 -0000
Received: from cpe-75-185-223-130.woh.res.rr.com [75.185.223.130]
  by mail.gmx.com (mp-us003) with SMTP; 09 Nov 2008 15:09:27 -0500
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX18dKwEoAj8d20lRusXG3wGKKJgKrlor28HmaN7Xoq
	6x4wdnwmYTwKpX
In-Reply-To: <200811091513.55544.fg@one2team.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Content-ID: <alpine.LFD.2.00.0811091503300.21142@sys-0.hiltweb.site>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100467>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-822990668-1226259065=:20499
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.LFD.2.00.0811091503301.21142@sys-0.hiltweb.site>

On Sun, 9 Nov 2008, Francis Galiegue wrote:
> Le Sunday 09 November 2008 13:59:48 Ian Hilt, vous avez =E9crit=A0:
> > +=09if ($c_file =3D~ /^To:\s*+(.+)\s*\nCc:/ism) {
>=20
> Greedy operators are only supported with perl 5.10 or more... I think it'=
s a=20
> bad idea to use them...

The problem here was that a space should follow the field, but it may
not.  The user may unwarily backup over it.  "\s*" would match this
case.

But if there is a space, it is included in the "(.+)".  So I tried
"\s+", which did not include the space, but it won't include the first
address if there isn't a space after the field.

The quantified subpattern seemed to do the trick.  But, if it could
result in a dependency issue, I would agree this would be a bad idea.


=09Ian
--8323328-822990668-1226259065=:20499--
