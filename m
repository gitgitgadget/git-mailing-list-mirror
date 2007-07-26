From: Christian Stimming <Christian.Stimming@ibeo-as.com>
Subject: Antwort: git-gui i18n introductory document
Date: Thu, 26 Jul 2007 10:13:57 +0200
Message-ID: <OF1A666782.07EBF99C-ONC1257324.002B5B63-C1257324.002D39E0@sick.de>
References: <7vir87adzo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Irina Riesen <irina.riesen@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Xudong Guan <xudong.guan@gmail.com>, git@vger.kernel.org,
	stimming@tuhh.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 10:24:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDyde-0008Nk-TD
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 10:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883AbXGZIX7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 26 Jul 2007 04:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753462AbXGZIX5
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 04:23:57 -0400
Received: from mail.sick.de ([62.180.123.254]:8986 "EHLO mail.sick.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753442AbXGZIXz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2007 04:23:55 -0400
X-Greylist: delayed 595 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jul 2007 04:23:55 EDT
X-IronPort-AV: E=Sophos;i="4.16,583,1175464800"; 
   d="scan'208";a="5576906"
Received: from unknown (HELO ibanotes.iba.de.internal) ([10.152.32.22])
  by mail.waki.de.dmz with ESMTP; 26 Jul 2007 10:13:59 +0200
In-Reply-To: <7vir87adzo.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Lotus Notes Release 7.0.2 September 26, 2006
X-MIMETrack: Serialize by Router on IBAMF01.iba.de.internal/SRV/SICK(Release 6.5.4|March
 27, 2005) at 07/26/2007 10:13:59 AM
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53807>

Junio C Hamano <gitster@pobox.com> schrieb am 26.07.2007 08:14:03:
> I also noticed that po/ directory lacks
> any guidance document for translators.  Here is an attempt to
> add po/README.

Thanks for this write-up. This is very nice, and I agree it is helpful =
for
everyone working on the translations.

=46YI, in the gnucash project we have a similar write-up, only that ove=
r time
we were asked to cover pretty much any subject that came up, so the
document ended up quite long. See http://wiki.gnucash.org/wiki/Translat=
ion

One topic that hasn't been covered but should be added is the po/glossa=
ry/
directory. I'd suggest to point new translators to there *first*, becau=
se
getting the glossary right is a necessary condition for achieving a
high-quality translation.

> I understand that Christian's stance on this issue, to put it
> bluntly, is that you should not be in the l10n business if you
> are not versed with gettext toolchain.

I wouldn't require someone to be "versed". But I would indeed require
someone to 1. have the gettext toolchain *installed* (after all, that
person also must have git installed), and 2. I'd strongly recommend to =
work
on the po files with one of the specialized *po file editors* instead o=
f a
plain text editor. There are so many editors available: emacs po-mode,
KBabel, poedit, GTranslator; it definitely shouldn't be difficult to us=
e at
least one of them.

Nevertheless, explaining the po file structure here in the README is a =
good
thing in itself.

Some comments on your explanation in the file itself:

> +0. Getting started.
> +
> +You would first need to have a working "git".  Your distribution
> +may have git-core package (do not get "GNU Interactive Tools" --
> +that is a different "git").  Please install it.

You should mention the gettext package (required for .msg creation) and=
 one
of the po editors here as well.

> + - Control characters, such as newlines, are written in
> +   backslash sequence
> +
> + - A long message can be split across multiple lines by ending
> +   the string with a doublequote, and starting another string on
> +   the next line with another doublequote.

Good points. Additionally, we need to explain the [format...] arguments
here, i.e. what to do with a "%s" or "%i" or "%%" in the string.

> +You can test the result by running "make", which would create
> +po/af.msg file, and then running the resulting git-gui in your
> +locale:
> +
> +   $ make install
> +   $ LANG=3Daf git-gui

Does the latter line give the newly created translation for you, even
without "make install"? For me and from what I understand from the code=
,
the message catalogs are searched for in the subdirectory msgs/ of the =
lib/
directory, which means they wouldn't be found in an unmodified checkout=
=2E
But you can create a symlink of that name to have the checkout use dire=
ctly
the po/ directory, like so:

   cd lib
   ln -s ../po msgs
   cd ..
   LANG=3Djp ./git-gui.sh

and I also have to call the local git-gui with ./ because . is not in m=
y
PATH, which is probably the same for some people out there as well.

> +   $ edit po/af.po
> +   ... be sure to update Last-Translator: and
> +   ... PO-Revision-Date: lines.

Yes, thanks for the reminder here.

> + - The original text in English of an older message you already
> +   translated might have been changed.  You will notice a
> +   comment line that begins with "#, fuzzy" in front of such a
> +   message.  msgmerge tool made its best effort to match your
> +   old translation with the message from the updated software,
> +   but you will find it matched your old translated message to a
> +   new msgid that does not make any sense -- you would need to
> +   fix them.

Yes. You should also mention here that a msgstr marked as "#, fuzzy" wi=
ll
be treated as if no translation existed at all by msgfmt. Hence, the
instructions for the translators should be something like this: "Messag=
es
which are marked as fuzzy will not be used in the program. You have to
check the msgstr, fix it to match the msgid message, and remove the #,
fuzzy line."

Overall, this is a nice writeup and it is very helpful. Thanks a lot.

Christian

IBEO Automobile Sensor GmbH - Sitz: Hamburg - Handelsregister: Hamburg =
HRB
67903
Gesch=E4ftsf=FChrer: Dr. Ulrich S. Lages
