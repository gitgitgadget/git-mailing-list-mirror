From: Christian Stimming <Christian.Stimming@ibeo-as.com>
Subject: Re: git-gui: i18n introductory document (2nd draft)
Date: Fri, 27 Jul 2007 17:21:58 +0200
Message-ID: <OFE65F8F6D.096D98A3-ONC1257325.0052CC69-C1257325.0054663B@sick.de>
References: <7v4pjq7net.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Irina Riesen <irina.riesen@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Nanako Shiraishi <nanako3@bluebottle.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Xudong Guan <xudong.guan@gmail.com>, stimming@tuhh.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 17:22:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IERdh-0004rj-L2
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 17:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761726AbXG0PV6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 27 Jul 2007 11:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761909AbXG0PV5
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 11:21:57 -0400
Received: from mail.sick.de ([62.180.123.254]:56457 "EHLO mail.sick.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761524AbXG0PV4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jul 2007 11:21:56 -0400
X-IronPort-AV: E=Sophos;i="4.16,589,1175464800"; 
   d="scan'208";a="5654998"
Received: from unknown (HELO ibanotes.iba.de.internal) ([10.152.32.22])
  by mail.waki.de.dmz with ESMTP; 27 Jul 2007 17:21:50 +0200
In-Reply-To: <7v4pjq7net.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Lotus Notes Release 7.0.2 September 26, 2006
X-MIMETrack: Serialize by Router on IBAMF01.iba.de.internal/SRV/SICK(Release 6.5.4|March
 27, 2005) at 07/27/2007 05:21:59 PM
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53932>

Junio C Hamano <gitster@pobox.com> schrieb am 27.07.2007 01:31:06:
> I have tried to address issues raised in Christian's comments on
> the first draft that was circulated privately.

Yes, this looks very nice, concise, and good to read. Thanks.

> +to test the resulting translation out.  It also is a good idea to ha=
ve
> +specialized so-called "po file editors" (e.g. emacs po-mode, KBabel,
> +poedit, GTranslator).  Please install them.

I'd rephrase the very last sentence into: Please install at least one o=
f
them, whichever you feel comfortably with.

> + - Often the messages being translated are format strings given to
> +   "printf()"-like functions.  Make sure "%s", "%d", and "%%" in you=
r
> +   translated messages match the original.
> +
> +   When you have to change the order of words, you can add "<number>=
$"
> +   between '%' and the conversion ('s', 'd', etc.) to say "<number>-=
th
> +   parameter to the format string is used at this point".  For examp=
le,
> +   if the original message is like this:
> +
> +   "Length is %d, Weight is %d"
> +
> +   and if for whatever reason your translation needs to say weight f=
irst
> +   and then length, you can say something like:
> +
> +   "WEIGHT IS %2$d, LENGTH IS %1$d"
> +
> +   [NEEDSWORK: this whole "parameter permutation" part needs to be
> +   verified if it works with Tcl at all]

I agree it needs to be verified, although the msgcat documentation clai=
ms
it works. Nevertheless I'd rather question whether this text is helpful=
 at
this point in the document. How about moving the "positional codes" iss=
ues
to a separate section at the end, under the topic "Advanced translation
tips" or something like this?

> +You can test your translation by running "make install", which would
> +create po/af.msg file and installs the result, and then running the
> +resulting git-gui under your locale:
> +
> +   $ make install
> +   $ LANG=3Daf git-gui

Right, this should always work.

> +There is a trick to test your translation without first installing, =
if
> +you prefer.  First, create this symbolic link in the source tree:
> +
> +   $ ln -s ../po lib/msgs
> +
> +After setting up such a symbolic link, you can:
> +
> +   $ make
> +   $ LANG=3Daf ./git-gui
> +
> +[NEEDSWORK: this symlink trick needs to be verified if it works.]

It does work, but as Nanako Shiraishi already pointed out, one has to c=
all
=2E/git-gui.sh in contrast to the version without suffix.

> +   $ msgmerge -U po/af.po po/git-gui.pot
> +
> +[NEEDSWORK: who is responsible for updating po/git-gui.pot file by
> +running xgettext?  IIRC, Christian recommended against running it
> +nilly-willy because it can become a source of unnecessary merge
> +conflicts.  Perhaps we should mention something like "
> +
> +The po/git-gui.pot file is updated by the internationalization
> +coordinator from time to time.  You _could_ update it yourself, but
> +translators are discouraged from doing so because we would want all
> +language teams to be working off of the same version of git-gui.pot.
> +
> +" here?]

I wouldn't have put git-gui.pot into git to start with. Translators who=
 can
msgmerge their translation by definition have the gettext toolchain
available, so they could very well just have git-gui.pot generated
themselves. We can just as well give instructions here on how to regene=
rate
git-gui.pot: "make po/git-gui.pot"; in gnucash, we added a separate rul=
e
"make pot" because that one is easier to type.

As for merging the po file: I would encourage every *translator* to
"msgmerge" their po file as often as they like. This rule will only run
into problems if translators forget to merge their po file regularly, a=
nd
continue to work on the old string; so far I have no solution to this
problem.  I spoke up a few days ago to ask the maintainers not to merge=
 the
*po* files, because this is where the translators work with, and mergin=
g
conflicts here will make translators unhappy. But this concerns the *po
file*. The pot file can just as well be updated by the maintainers or t=
he
translators, but it would be best not to have it in SCM at all.

> + - The original text in English of an older message you already
> +   translated might have been changed.  You will notice a comment li=
ne
> +   that begins with "#, fuzzy" in front of such a message.  msgmerge
> +   tool made its best effort to match your old translation with the
> +   message from the updated software, but you may find cases that it
> +   matched your old translated message to a new msgid and the pairin=
g
> +   does not make any sense -- you would need to fix them, and then
> +   remove the "#, fuzzy" line from the message.

I would add the sentence (because people frequently forget about the
implications of the fuzzy marker): A translation prepended by the '#,
fuzzy" line will not show up in the program. Gettext will treat this
message as if no translation existed.

Overall this is very nice. Thanks a lot.

Christian

IBEO Automobile Sensor GmbH - Sitz: Hamburg - Handelsregister: Hamburg =
HRB
67903
Gesch=E4ftsf=FChrer: Dr. Ulrich S. Lages
