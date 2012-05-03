From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] de.po: collection of fixes
Date: Thu, 3 May 2012 23:11:55 +0200
Message-ID: <87obq5vujo.fsf@thomas.inf.ethz.ch>
References: <1336075774-8447-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <jk@jk.gs>, <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Thu May 03 23:12:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ3Jn-0007dP-IN
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 23:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140Ab2ECVMA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 May 2012 17:12:00 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:33932 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754928Ab2ECVL7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2012 17:11:59 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Thu, 3 May
 2012 23:11:57 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (188.155.176.28) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 3 May
 2012 23:11:56 +0200
In-Reply-To: <1336075774-8447-1-git-send-email-ralf.thielow@googlemail.com>
	(Ralf Thielow's message of "Thu, 3 May 2012 22:09:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196960>

On a general note, if you consistently make a single type of change
(like the first two quotes below), it would be easier on the reviewers
if you split them out as separate commits.  That way I could say "I lik=
e
this in general, and I trust you're not sneaking in any other changes i=
n
this patch", and stop reading.

Ralf Thielow <ralf.thielow@googlemail.com> writes:

> -msgstr "konnte %s nicht parsen"
> +msgstr "%s konnte nicht geparst werden"
[...]
> -msgstr "Konnte '%s' nicht zum Schreiben =C3=B6ffnen."
> +msgstr "'%s' konnte nicht zum Schreiben ge=C3=B6ffnet werden."

Why the switch to passive?  It should never be used, and all that...
(There are more further down.)

> -msgstr "Konnte nicht nach %s schreiben"
> +msgstr "Konnte nicht nach '%s' schreiben"
[...]
> -msgstr "Fehler bei Nachbereitung von %s"
> +msgstr "Fehler bei Nachbereitung von '%s'"

These should perhaps also be fixed in the originals.  Again there are
more of the same type.

>  #: builtin/bundle.c:60
>  msgid "Need a repository to unbundle."
> -msgstr "Zum Zerlegen wird ein Projektarchiv ben=C3=B6tigt."
> +msgstr "Zum Entpacken wird ein Projektarchiv ben=C3=B6tigt."

Note that this collides with the use of Packen for packing (as in
pack-objects).  Not sure it matters here, though, and it's definitely a=
n
improvement.

>  #: builtin/gc.c:256
>  msgid ""
>  "There are too many unreachable loose objects; run 'git prune' to re=
move them."
> -msgstr "Es gibt zu viele unerreichbare lose Objekte; f=C3=BChre 'git=
 prune' aus um diese zu entfernen."
> +msgstr "Es gibt zu viele unerreichbare verlorene Objekte; f=C3=BChre=
 'git prune' "
> +"aus um diese zu entfernen."

I think you're partially reverting an earlier change of mine here.
loose really is "lose" as in "not packed".  They are "lost" only by
virtue of being unreachable, which you're also stating.  So if anything=
,
you should consistently change "loose object" to some term other than
"loses Objekt".

> -"Automatische Zusammenf=C3=BChrung gut gegangen; stoppe, wie angefra=
gt, vor der "
> -"Eintragung\n"
> +"Automatische Zusammenf=C3=BChrung abgeschlossen; halte, wie angefra=
gt, vor der "
> +"Eintragung an\n"

Unrelated to your change, but perhaps also "wie angefragt" -> "wie
gew=C3=BCnscht"?

> -"\"pull\" ist nicht m=C3=B6glich weil du nicht zusammengef=C3=BChrte=
 Dateien hast.\n"
> +"\"pull\" ist nicht m=C3=B6glich, weil du nicht zusammengef=C3=BChrt=
e Dateien hast.\n"

Again unrelated, but for me, this is quite hard to parse.  Perhaps,
while strictly speaking wrong, "nicht-zusammengef=C3=BChrte Dateien" or=
 also
something like "konfliktbehaftete Dateien" would be easier to scan.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
