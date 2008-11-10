From: Aristotle Pagaltzis <pagaltzis@gmx.de>
Subject: Re: [PATCH] git send-email: edit recipient addresses with the
	--compose flag
Date: Mon, 10 Nov 2008 09:08:48 +0100
Message-ID: <20081110080848.GA325@klangraum.plasmasturm.org>
References: <1226235588-2997-1-git-send-email-ian.hilt@gmx.com> <7viqqwa6wo.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0811091910570.21142@sys-0.hiltweb.site> <200811100849.36736.fg@one2team.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 10 09:10:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzRqX-0002EQ-Oh
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 09:10:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbYKJIIv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 03:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbYKJIIv
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 03:08:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:41510 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750970AbYKJIIv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 03:08:51 -0500
Received: (qmail invoked by alias); 10 Nov 2008 08:08:48 -0000
Received: from static-87-79-236-202.netcologne.de (EHLO klangraum) [87.79.236.202]
  by mail.gmx.net (mp005) with SMTP; 10 Nov 2008 09:08:48 +0100
X-Authenticated: #163624
X-Provags-ID: V01U2FsdGVkX18ZNsNXL88ZKmZUZnfYyte52YCOsVYnDKdRK3og/V
	y825LRyuLODvLg
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200811100849.36736.fg@one2team.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100499>

* Francis Galiegue <fg@one2team.com> [2008-11-10 08:55]:
> Le Monday 10 November 2008 01:38:30 Ian Hilt, vous avez =C3=A9crit=C2=
=A0:
> > On Sun, 9 Nov 2008, Junio C Hamano wrote:
> > > Ian Hilt <ian.hilt@gmx.com> writes:
> > > > On Sun, 9 Nov 2008, Francis Galiegue wrote:
> > > >> Le Sunday 09 November 2008 13:59:48 Ian Hilt, vous avez =C3=A9=
crit=C2=A0:
> > > >> > +	if ($c_file =3D~ /^To:\s*+(.+)\s*\nCc:/ism) {
> > > >>
> > > >> Greedy operators are only supported with perl 5.10 or more... =
I think
> > > >> it's a bad idea to use them...

Possessive quantification is supported in much earlier versions
of Perl, it=E2=80=99s just more awkward syntactically:

    /^To:(?>\s*)(.+)\s*\nCc:/ism

But possessification is not going to make a difference in this
regex, since .+ can match anything that \s* can also match, so
the only difference is that if the regex does happen to
backtrack, it will backtrack over all the spaces after the To:
at once instead of one at a time.

I have only just subscribed so I do not have enough context to
know what the problem is, but based on what I have seen so far it
seems to me that all you want is simply

    /^To:\s?(.+)\s*\nCc:/ism

although I have to wonder if the /s modifier here is really what
you want.

> I think the correct term for *+, ++, ?+ etc is "possessive"
> quantifiers, I'm just not sure.

That is correct.

Regards,
--=20
Aristotle Pagaltzis // <http://plasmasturm.org/>
