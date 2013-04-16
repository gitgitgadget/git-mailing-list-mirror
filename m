From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH/RFC] l10n: de.po: translate 39 new messages
Date: Tue, 16 Apr 2013 10:34:09 +0200
Message-ID: <87ppxuan7i.fsf@linux-k42r.v.cablecom.net>
References: <1366043260-3131-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <jk@jk.gs>, <stimming@tuhh.de>, <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 10:34:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US1LN-0007pV-3G
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 10:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996Ab3DPIeO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 04:34:14 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:26858 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754868Ab3DPIeM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 04:34:12 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 16 Apr
 2013 10:34:05 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 16 Apr 2013 10:34:09 +0200
In-Reply-To: <1366043260-3131-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Mon, 15 Apr 2013 18:27:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221395>

Ralf Thielow <ralf.thielow@gmail.com> writes:

>  msgid "You are currently reverting commit %s."
> -msgstr "Sie sind gerade bei einer bin=C3=A4ren Suche in Zweig '%s'."
> +msgstr "Sie kehren gerade Version '%s' um."

Is revert->umkehren new?  I can see it's in the glossary, but

  #: sequencer.c:536
  #, c-format
  msgid "could not revert %s... %s"
  msgstr "Konnte %s nicht zur=C3=BCcksetzen... %s"

  #: sequencer.c:1016
  msgid "Can't revert as initial commit"
  msgstr "Kann nicht zu initialer Version zur=C3=BCcksetzen."

which I don't really like either now that you mention it -- I would
re-translate it as 'reset'.  But either way they should be consistent.

>  msgid "Commit %s has an untrusted GPG signature, allegedly by %s."
> -msgstr ""
> +msgstr "Version %s hat eine nicht vertrauensw=C3=BCrdige GPG-Signatu=
r, "
> +"vermeintlich von %s."
> =20
>  msgid "Commit %s has a bad GPG signature allegedly by %s."
> -msgstr ""
> +msgstr "Version %s hat eine ung=C3=BCltige GPG-Signatur, vermeintlic=
h von %s."

You could say "angeblich" instead, which is more to the point.

>  #: git-submodule.sh:626
> -#, fuzzy, sh-format
> +#, sh-format
>  msgid "Submodule '$name' ($url) unregistered for path '$sm_path'"
> -msgstr "Unterprojekt '$name' ($url) ist f=C3=BCr Pfad '$sm_path' reg=
istriert"
> +msgstr "Unterprojekt '$name' ($url) ist nicht f=C3=BCr Pfad '$sm_pat=
h' registriert."

This is in cmd_deinit(), and the comment for the enclosing block says

  # Remove the whole section so we have a clean state when
  # the user later decides to init this submodule again

So it would seem to use "unregister" as a verb, not an adjective, and
the correct translation is

  msgstr "Unterprojekt '$name' ($url) f=C3=BCr '$sm_path' deregistriert=
=2E"

or some such.  "Deregistriert" is not very nice; in the absence of
context I would suggest "ausgetragen", but that problably collides with
our use of "eintragen".  Perhaps you can go the long way for this
isolated use and just say "aus der Konfiguration entfernt" (and
similarly for 'register').

In any case you should also add 'register' and 'unregister' to the
glossary once you've settled on something.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
