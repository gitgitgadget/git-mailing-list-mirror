From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] help: show manpage for aliased command on git <alias>
 --help
Date: Tue, 5 Mar 2013 16:54:53 +0100
Message-ID: <20130305165453.6077226c@pc09.procura.nl>
References: <1362494681-11419-1-git-send-email-avarab@gmail.com>
	<5136127C.2090402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 05 17:06:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCuNY-0003F0-GE
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 17:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896Ab3CEQFr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Mar 2013 11:05:47 -0500
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:3164 "EHLO
	smtp-vbr14.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab3CEQFq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Mar 2013 11:05:46 -0500
Received: from pc09.procura.nl (adsl.procura.nl [82.95.216.30])
	(authenticated bits=0)
	by smtp-vbr14.xs4all.nl (8.13.8/8.13.8) with ESMTP id r25Fss3v028821
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 5 Mar 2013 16:54:55 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <5136127C.2090402@viscovery.net>
X-Mailer: Claws Mail 3.9.0cvs60 (GTK+ 2.24.10; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217457>

On Tue, 05 Mar 2013 16:42:52 +0100, Johannes Sixt
<j.sixt@viscovery.net> wrote:

> Am 3/5/2013 15:44, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> > Change the semantics of "git <alias> --help" to show the help for t=
he
> > command <alias> is aliased to, instead of just saying:
> >=20
> >     `git <alias>' is aliased to `<whatever>'
> >=20
> > E.g. if you have "checkout" aliased to "co" you won't get:
> >=20
> >     $ git co --help
> >     `git co' is aliased to `checkout'
> >=20
> > But will instead get the manpage for git-checkout.
> ...
> >  	alias =3D alias_lookup(argv[0]);
> >  	if (alias && !is_git_command(argv[0])) {
> > -		printf_ln(_("`git %s' is aliased to `%s'"), argv[0], alias);
> > -		return 0;
> > +		show_help_for =3D alias;
> > +	} else {
> > +		show_help_for =3D argv[0];
> >  	}
>=20
> This needs a lot more scrutiny. The alias can be more than just a sin=
gle
> word, and it can even be a shell scriptlet, i.e., not a git command a=
t all.
>=20
> It may make sense to show the help of the aliased-to command if the a=
lias
> resolves to just a single word.

A single word that is (already) known to git as being a valid command
to do --help with. I which case I fully agree.

--=20
H.Merijn Brand  http://tux.nl   Perl Monger  http://amsterdam.pm.org/
using perl5.00307 .. 5.17   porting perl5 on HP-UX, AIX, and openSUSE
http://mirrors.develooper.com/hpux/        http://www.test-smoke.org/
http://qa.perl.org   http://www.goldmark.org/jeff/stupid-disclaimers/
