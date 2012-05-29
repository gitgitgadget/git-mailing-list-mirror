From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: "docs: stop using asciidoc no-inline-literal" breaks asciidoc 8.2.5
Date: Tue, 29 May 2012 14:03:39 +0200
Message-ID: <87ehq3mbxg.fsf@thomas.inf.ethz.ch>
References: <CACBZZX7Y-NTzRP1KYy=eEHTsLHTrzxGms61anXSHVbyCSPgurw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 14:03:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZL9P-0005Ti-Ag
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 14:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871Ab2E2MDm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 May 2012 08:03:42 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:16364 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753866Ab2E2MDl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 May 2012 08:03:41 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 29 May
 2012 14:03:39 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 29 May
 2012 14:03:39 +0200
In-Reply-To: <CACBZZX7Y-NTzRP1KYy=eEHTsLHTrzxGms61anXSHVbyCSPgurw@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 29 May
 2012 12:19:56
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198736>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Jeff King's 6cf378f0cbe7c7f944637892caeb9058c90a185a broke my Git
> build on CentOS 5.5. The patch suggests that it only breaks
> compatibility with asciidoc 7 but that isn't actually the case.

The commit message of 6cf378f0 is not correct in that respect.  My
ancient 71c020c5 has the right numbers: asciidoc 8.4.1 is the one that
introduced the new inline-literal behavior.  Based on my little survey
in

  http://thread.gmane.org/gmane.comp.version-control.git/191738/focus=3D=
191790

we decided that "nobody" really uses such an old asciidoc any more.
Evidently you are a counterexample.

> I suggest just ejecting this patch and trying again, these RedHat
> systems are still used in a lot of environments, especially by variou=
s
> companies.

Do you/they have to *build* the docs, as opposed to using the prebuilt
ones coming from Junio?  Perhaps we can make it so 'make man' refuses t=
o
run if asciidoc is too old, and give a message to the effect that you
should 'make quick-install-man' instead.

Otherwise we'll be working around the f{asterisk}{asterisk}{asterisk}in=
g
quoting rules for years to come.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
