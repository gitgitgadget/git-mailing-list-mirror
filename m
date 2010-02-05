From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: notes TODOs (was: Re: [PATCH 1/4] gitweb: notes feature)
Date: Fri, 5 Feb 2010 13:44:14 +0100
Message-ID: <cb7bb73a1002050444y55f57696gb1b3bd06ab9261ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Feb 05 13:44:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdNYM-0006NJ-Cj
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 13:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282Ab0BEMog convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2010 07:44:36 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:46975 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab0BEMof convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2010 07:44:35 -0500
Received: by ewy28 with SMTP id 28so4224219ewy.28
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 04:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=GRoUhvrRCDpmrHsA3PapzBeZcQgyG8Xxn3AaFQqbygY=;
        b=ZcH0UvmLZ3rgcf2SqiEy+Xravxhzk+099vaTmUuO/6jDCuqpEPirBkhRxc5CDKN0fw
         c2dZTViGQoDZzuVKlrqc/K7mIbcq95KYvx2wNvU8u7IwCuBT9JCCtCKZqt6gHLn3DhZo
         5FSulzhn3is6T6dMG+ecxDTiRgMR8BSbGYTSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=SCl4xIp0CSrsY+ZUJY35ymy1qFBGQulwqbnnVwsgQXDcat8ONJjQufpFWA5scy/t/L
         O3dTQS+z8QWvfKwzzJUGcRaolq/FjaXn3mIZRZFCVuMcW2eMrEp4+FjHv4zjwyAV7PoZ
         qNeFiEglJMzKM3V/KV2CQjqqTzBQU/9IOcem0=
Received: by 10.213.80.204 with SMTP id u12mr537381ebk.95.1265373874181; Fri, 
	05 Feb 2010 04:44:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139046>

On Fri, Feb 5, 2010 at 11:36 AM, Johan Herland <johan@herland.net> wrot=
e:
>
> I already maintain a TODO list at the end of the cover letter to the =
notes
> series. Here is a preview of it (I plan to send the next iteration of
> jh/notes as soon as v1.7.0 is released):
>
>
> - Suggestion by Matthieu Moy and Sverre Rabbelier:
> =A0Add notes support to git-format-patch, where note contents in
> =A0refs/notes/format-patch are added to the "comments section"
> =A0(i.e. following the '---' separator) of generated patches.
>
> - Better integration with rebase/amend/cherry-pick. Optionally bring
> =A0notes across a commit rewrite. Controlled by command-line options
> =A0and/or config variables. Add "git notes move" and "git notes copy"
> =A0to suit. Junio says:
> =A0 =A0I used to fix minor issues (styles, decl-after-stmt, etc.) usi=
ng
> =A0 =A0rebase-i long after running "am" in bulk, but these days I fin=
d
> =A0 =A0myself going back to my "inbox" and fix them in MUA; this is
> =A0 =A0only because I know these notes do not propagate across rebase=
s
> =A0 =A0and amends -- adjusting the workflow to the tool's limitation =
is
> =A0 =A0not very good.

It might be useful to this purpose to have a notes.<refname>.* config
space, like for branches. This would allows us to define per-namespace
attribute for notes, such as whether or not they get across rebases,
whether or not (and how) they are output in format-patch, in logs, etc

> - Junio says:
> =A0The interface to tell tools to use which notes ref to use should b=
e
> =A0able to say "these refs", not just "this ref" i.e. GIT_NOTES_REF=3D=
a:b
> =A0just like PATH=3Da:b:c...); I am fairly certain that we would want=
 to
> =A0store different kind of information in separate notes trees and
> =A0aggregate them, as we gain experience with notes.

I would say that this only makes sense when reading notes, since when
you are writing a note you probably want to add it to a single
specific namespace.

=46or multiple refs I was thinking about shell expansion patterns, with
syntax such as {a,b} rather than a:b; even shell globs might make
sense (so e.g. * would mean 'all existing notes ref namespaces', bug*
all namespaces starting with bug, etc).

Of course the use of multiple namespaces also means that users
(whether human or script) need to be able to teel which namespace each
note comes from.

> - Junio says:
> =A0There should be an interface to tell tools to use which notes refs=
 via
> =A0command line options; "!alias" does not TAB-complete, and "git lgm=
"
> =A0above doesn't, either. "git log --notes=3Dnotes/amlog --notes=3Dno=
tes/other"
> =A0would probably be the way to go.

As mentioned elsewhere in this thread, this might be better as a git
option rather than a subcommand option: git --notes-ref=3Damlog:other
log or git --notes-ref=3D{amlog,other} log.

If I may be allowed to add a suggestion to put in the list, I would
like to see notes attachable to named refs (branch heads in
particular). From a cursory reading of your patches currently in pu it
would seem that you explicitly prohibit this case currently. However,
this has many possible uses, ranging from longer branch descriptions
to tracking information to improve survival in case of remote rebases.

And one last comment: how do notes behave wrt to cloning and remote
handling? Am I correct in my understanding that notes are (presently)
local only? Would it make sense to have them cloned to something like
the refs/notes/remotes/* namespace?





--=20
Giuseppe "Oblomov" Bilotta
