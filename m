From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Internationalization of git-gui
Date: Sat, 21 Jul 2007 01:22:40 -0700
Message-ID: <7vr6n2upwv.fsf@assigned-by-dhcp.cox.net>
References: <7vodi7vtct.fsf@assigned-by-dhcp.cox.net>
	<200707210815.l6L8F2Da032066@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Christian Stimming" <stimming@tuhh.de>, git@vger.kernel.org
To: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 10:22:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICAEk-0003Ge-EO
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 10:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760644AbXGUIWr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Jul 2007 04:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbXGUIWp
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 04:22:45 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:51474 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760175AbXGUIWm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 04:22:42 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070721082241.YAWK1399.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 21 Jul 2007 04:22:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id S8Nh1X0051kojtg0000000; Sat, 21 Jul 2007 04:22:42 -0400
In-Reply-To: <200707210815.l6L8F2Da032066@mi0.bluebottle.com>
	(nanako3@bluebottle.com's message of "Sat, 21 Jul 2007 17:12:11
	+0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53154>

=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93  <nanak=
o3@bluebottle.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> Ah, am I expected to volunteer for Japanese part?
>>
>> Unless yashi, yoshifuji, or nanako3 volunteer, although I do not
>> mind doing that myself,...
>
> I can help.  What's involved?

Wonderful.

As Johannes announced the 'mob' stuff, I think it would be
easiest to work there as others --- for this type of work, there
probably won't be much stepping on each other's toes involved as
long as there are not more than one translator per language.

What's involved to get a new language 'xy' started is roughly:

 - Run 'make' once, to get po/git-gui.pot generated;

 - Copy po/git-gui.pot to po/xy.po;

 - Update the placeholder strings at the beginning of the
   po/xy.po file appropriately.

 - Add 'xy' to the list of languages to ALL_LINGUAS list in the
   Makefile.

After that, add translations to the (initially empty) string on
the lines that begin with 'msgstr'.  Set of msgid's need to be
kept in sync with the source as the translated software evolve,
but gettext framework hopefully will take care of most of the
chore.

I'll get on the 'mob' bandwagon and try to push out something
like the attached patch, so that you do not necessarily have to
have the whole gettext toolchain.

-- >8 --

This gets the ball started for Japanese translation, but as I am
lazy, I only translated three words.  I took credit by placing
my name on the "Last-Translator" line, but shifted most of the
remaining work to Nana, who showed interest on the list, by
naming her at the beginnign of the file ;-)

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile |    2 +-
 po/ja.po |  250 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 251 insertions(+), 1 deletions(-)
 create mode 100644 po/ja.po

diff --git a/Makefile b/Makefile
index f6a6ce3..85d2c00 100644
--- a/Makefile
+++ b/Makefile
@@ -107,7 +107,7 @@ XGETTEXT   ?=3D xgettext
 msgsdir    ?=3D $(libdir)/msgs
 msgsdir_SQ  =3D $(subst ','\'',$(msgsdir))
 PO_TEMPLATE =3D po/git-gui.pot
-ALL_LINGUAS =3D de
+ALL_LINGUAS =3D de ja
=20
 $(PO_TEMPLATE): $(SCRIPT_SH) $(ALL_LIBFILES)
 	$(XGETTEXT) -k_ -LTcl -o $@ $(SCRIPT_SH) $(ALL_LIBFILES)
diff --git a/po/ja.po b/po/ja.po
new file mode 100644
index 0000000..abfd4f1
--- /dev/null
+++ b/po/ja.po
@@ -0,0 +1,250 @@
+# Translation of git-gui to Japanese
+# Copyright (C) 2007 Shawn Pearce
+# This file is distributed under the same license as the git-gui packa=
ge.
+# =E3=81=97=E3=82=89=E3=81=84=E3=81=97 =E3=81=AA=E3=81=AA=E3=81=93 <na=
nako3@bluebottle.com>, 2007.
+#
+#, fuzzy
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2007-07-21 01:23-0700\n"
+"PO-Revision-Date: 2007-07-21 01:23-0700\n"
+"Last-Translator: Junio C Hamano <gitster@pobox.com>\n"
+"Language-Team: Japanese\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#: git-gui.sh:1656
+msgid "Repository"
+msgstr "=E3=83=AC=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA"
+
+#: git-gui.sh:1657
+msgid "Edit"
+msgstr "=E7=B7=A8=E9=9B=86"
+
+#: git-gui.sh:1659
+msgid "Branch"
+msgstr "=E5=88=86=E5=B2=90"
+
+#: git-gui.sh:1662 git-gui.sh:1840
+msgid "Commit"
+msgstr ""
+
+#: git-gui.sh:1665
+msgid "Merge"
+msgstr ""
+
+#: git-gui.sh:1666
+msgid "Fetch"
+msgstr ""
+
+#: git-gui.sh:1667
+msgid "Push"
+msgstr ""
+
+#: git-gui.sh:1676
+msgid "Browse Current Branch's Files"
+msgstr ""
+
+#: git-gui.sh:1685
+msgid "Visualize Current Branch's History"
+msgstr ""
+
+#: git-gui.sh:1689
+msgid "Visualize All Branch History"
+msgstr ""
+
+#: git-gui.sh:1694
+msgid "Database Statistics"
+msgstr ""
+
+#: git-gui.sh:1697
+msgid "Compress Database"
+msgstr ""
+
+#: git-gui.sh:1700
+msgid "Verify Database"
+msgstr ""
+
+#: git-gui.sh:1707 git-gui.sh:1711 git-gui.sh:1715
+msgid "Create Desktop Icon"
+msgstr ""
+
+#: git-gui.sh:1720
+msgid "Quit"
+msgstr ""
+
+#: git-gui.sh:1727
+msgid "Undo"
+msgstr ""
+
+#: git-gui.sh:1730
+msgid "Redo"
+msgstr ""
+
+#: git-gui.sh:1734 git-gui.sh:2249
+msgid "Cut"
+msgstr ""
+
+#: git-gui.sh:1737 git-gui.sh:2252 git-gui.sh:2323 git-gui.sh:2395
+msgid "Copy"
+msgstr ""
+
+#: git-gui.sh:1740 git-gui.sh:2255
+msgid "Paste"
+msgstr ""
+
+#: git-gui.sh:1743 git-gui.sh:2258
+msgid "Delete"
+msgstr ""
+
+#: git-gui.sh:1747 git-gui.sh:2262 git-gui.sh:2399
+msgid "Select All"
+msgstr ""
+
+#: git-gui.sh:1756
+msgid "Create..."
+msgstr ""
+
+#: git-gui.sh:1762
+msgid "Checkout..."
+msgstr ""
+
+#: git-gui.sh:1768
+msgid "Rename..."
+msgstr ""
+
+#: git-gui.sh:1773 git-gui.sh:1871
+msgid "Delete..."
+msgstr ""
+
+#: git-gui.sh:1778
+msgid "Reset..."
+msgstr ""
+
+#: git-gui.sh:1790
+msgid "New Commit"
+msgstr ""
+
+#: git-gui.sh:1798
+msgid "Amend Last Commit"
+msgstr ""
+
+#: git-gui.sh:1807
+msgid "Rescan"
+msgstr ""
+
+#: git-gui.sh:1813
+msgid "Add To Commit"
+msgstr ""
+
+#: git-gui.sh:1818
+msgid "Add Existing To Commit"
+msgstr ""
+
+#: git-gui.sh:1824
+msgid "Unstage From Commit"
+msgstr ""
+
+#: git-gui.sh:1829
+msgid "Revert Changes"
+msgstr ""
+
+#: git-gui.sh:1836 git-gui.sh:2273
+msgid "Sign Off"
+msgstr ""
+
+#: git-gui.sh:1851
+msgid "Local Merge..."
+msgstr ""
+
+#: git-gui.sh:1856
+msgid "Abort Merge..."
+msgstr ""
+
+#: git-gui.sh:1868
+msgid "Push..."
+msgstr ""
+
+#: git-gui.sh:1878
+msgid "Apple"
+msgstr ""
+
+#: git-gui.sh:1881 git-gui.sh:1928
+#, tcl-format
+msgid "About %s"
+msgstr ""
+
+#: git-gui.sh:1883 git-gui.sh:1889 git-gui.sh:2441
+msgid "Options..."
+msgstr ""
+
+#: git-gui.sh:1913
+msgid "Tools"
+msgstr ""
+
+#: git-gui.sh:1915
+msgid "Migrate"
+msgstr ""
+
+#: git-gui.sh:1924
+msgid "Help"
+msgstr ""
+
+#: git-gui.sh:1965
+msgid "Online Documentation"
+msgstr ""
+
+#: git-gui.sh:2215
+msgid "Initial Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2216
+msgid "Amended Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2217
+msgid "Amended Initial Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2218
+msgid "Amended Merge Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2219
+msgid "Merge Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2220
+msgid "Commit Message:"
+msgstr ""
+
+#: git-gui.sh:2265 git-gui.sh:2403
+msgid "Copy All"
+msgstr ""
+
+#: git-gui.sh:2391
+msgid "Refresh"
+msgstr ""
+
+#: git-gui.sh:2412
+msgid "Apply/Reverse Hunk"
+msgstr ""
+
+#: git-gui.sh:2418
+msgid "Decrease Font Size"
+msgstr ""
+
+#: git-gui.sh:2422
+msgid "Increase Font Size"
+msgstr ""
+
+#: git-gui.sh:2427
+msgid "Show Less Context"
+msgstr ""
+
+#: git-gui.sh:2434
+msgid "Show More Context"
+msgstr ""
--=20
1.5.3.rc2.22.g69a9b
