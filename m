From: Junio C Hamano <gitster@pobox.com>
Subject: Re: update-po
Date: Sun, 22 Jul 2007 17:44:57 -0700
Message-ID: <7v644cosmu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707221352210.14781@racer.site>
	<200707222321.l6MNL0pi005112@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Xudong Guan <xudong.guan@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 02:45:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICm3F-0002vz-0h
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 02:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbXGWApG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Jul 2007 20:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765680AbXGWApE
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 20:45:04 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:64100 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765261AbXGWApA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 20:45:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070723004459.SNLA1399.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 22 Jul 2007 20:44:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Soky1X0091kojtg0000000; Sun, 22 Jul 2007 20:44:59 -0400
In-Reply-To: <200707222321.l6MNL0pi005112@mi0.bluebottle.com>
	(nanako3@bluebottle.com's message of "Mon, 23 Jul 2007 08:18:29
	+0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53378>

=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93  <nanak=
o3@bluebottle.com> writes:

> Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> msgid "Add Existing"
>> msgstr ""
>>
>> Actually, the 1st and the fourth copied the translation from somewhe=
re=20
>> else for ja and zh_cn.
>
> I had problem when translating this word "Existing" in my old transla=
tion.
> I did not understand what that expression meaned.  My old translation=
 for
> "Add Existing To Commit" said, because I did not understand what it m=
eant,
> "Add Some Existing THING To Commit", and it felt very wrong, but I co=
uld
> not come up with anything better.
>
> It makes me wonder if there is a corresponding "Add unexisting" comma=
nd
> somewhere else, but adding something that does not exist makes no sen=
se to
> me.

I did not quite understand the "Existing" either (I do not
use git-gui myself---I just launch it from time to time to make
sure it does not barf on simple operations as part of the last
minite tests before pushing changes to git.git out), and had a
discussion on #git channel with a few people.

My reading of git-gui code suggests that "Add Existing To
Commit" is used in an item in "Commit" menu, while "Add
Existing" is a label on the button, and they do exactly the same
operation.  It updates the index with the current contents of
the tracked files.  That is, deleted files are discarded from
the index, and modified files are updated.  IOW, "git add -u".

"Existing" is probably a misnomer even in the original English
UI --- it is more about "Tracked".  I think your confusion about
"Add unexisting" is justified, because "Add Existing" operation
is not about "existing" but "all tracked files without having me
pick and select all of them", and the other variant, "Add To
Commit", lets you add selected files, be they "tracked" or
"untracked".

        Side note: I realize that "track" does not translate
        well to Japanese.  The literal translation E-to-J
        dictionaries give us is "=E8=BF=BD=E8=B7=A1", but looking at th=
at word
        alone gives us connotations associated with crime-drama
        words, "chase" or "pursue", which is misleading.  In the
        context of revision control, "track" simply means "place
        under version control", so probably "=E7=89=88=E7=AE=A1=E7=90=86=
=E4=B8=8B=E3=81=AB=E7=BD=AE=E3=81=8F"
        (place under source control) would be the corresponding
        Japanese for word "to track", but it is rather long.

We often call untracked files "files unknown to git", so the
opposite of that, "tracked file" are "files known to git".
Because we would want short-and-sweet expressions in the UI,
perhaps in Japanese translation, we can say:

	"Add Existing" =3D> "=E6=97=A2=E7=9F=A5=E3=81=AE=E3=83=95=E3=82=A1=E3=82=
=A4=E3=83=AB=E3=82=92=E5=86=8D=E7=99=BB=E9=8C=B2"

(that roughly reads "Re-Register Known Files").

Hmph, that is still too long.  Maybe paraphrasing it as "Add
All Modified" would be shorter?  "=E5=85=A8=E3=81=A6=E3=81=AE=E5=A4=89=E6=
=9B=B4=E3=82=92=E8=BF=BD=E5=8A=A0"
I think I like that better.

Also "staged" and "unstaged" are hard to translate words.
Googling of Japanese sites suggests that "=E3=82=B9=E3=83=86=E3=83=BC=E3=
=82=B8=E3=83=B3=E3=82=B0=E3=81=99=E3=82=8B"
(roughly, "to perform staging") is already accepted as a verb,
so "Staged Changes (Will Be Committted)" would be "=E3=82=B9=E3=83=86=E3=
=83=BC=E3=82=B8=E3=83=B3=E3=82=B0
=E3=81=95=E3=82=8C=E3=81=9F=EF=BC=88=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=
=E3=81=95=E3=82=8C=E3=82=8B=EF=BC=89=E5=A4=89=E6=9B=B4" (roughly, "Chan=
ges that have been
performed <<staging>>").  Yuck.

How about this patch?

-- >8 --
[PATCH] git-gui Japanese messages: translate Add Existing, Staged and U=
nstaged.

Add "Existing" is probably a misnomer, so paraphrase it as "all
modifications".  "To Stage" is hard to translate but "Staging"
has become Japanese word so use that word to translate "Staged"
and "Unstaged" as (roughly) "Have been (Not have been) performed
<<Staging>>".

Signed-off-by: Junio C Hamano <gitster@cox.net>
---

diff --git a/po/ja.po b/po/ja.po
index 2643acf..2f21e84 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -142,7 +142,7 @@ msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=AB=
=E8=BF=BD=E5=8A=A0"
=20
 #: git-gui.sh:1831
 msgid "Add Existing To Commit"
-msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=AB=E5=AD=98=E5=9C=A8=
=E3=81=99=E3=82=8B=E3=81=AE=E3=82=92=E8=BF=BD=E5=8A=A0"
+msgstr "=E5=85=A8=E3=81=A6=E3=81=AE=E5=A4=89=E6=9B=B4=E3=82=92=E3=82=B3=
=E3=83=9F=E3=83=83=E3=83=88=E3=81=AB=E8=BF=BD=E5=8A=A0"
=20
 #: git-gui.sh:1837
 msgid "Unstage From Commit"
@@ -191,19 +191,19 @@ msgstr "=E3=82=AA=E3=83=B3=E3=83=A9=E3=82=A4=E3=83=
=B3=E3=83=BB=E3=83=89=E3=82=AD=E3=83=A5=E3=83=A1=E3=83=B3=E3=83=88"
=20
 #: git-gui.sh:2094
 msgid "Current Branch:"
-msgstr ""
+msgstr "=E7=8F=BE=E5=9C=A8=E3=81=AE=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
"
=20
 #: git-gui.sh:2115
 msgid "Staged Changes (Will Be Committed)"
-msgstr ""
+msgstr "=E3=82=B9=E3=83=86=E3=83=BC=E3=82=B8=E3=83=B3=E3=82=B0=E3=81=95=
=E3=82=8C=E3=81=9F=EF=BC=88=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=95=
=E3=82=8C=E3=82=8B=EF=BC=89=E5=A4=89=E6=9B=B4"
=20
 #: git-gui.sh:2135
 msgid "Unstaged Changes (Will Not Be Committed)"
-msgstr ""
+msgstr "=E3=82=B9=E3=83=86=E3=83=BC=E3=82=B8=E3=83=B3=E3=82=B0=E3=81=95=
=E3=82=8C=E3=81=A6=E3=81=84=E3=81=AA=E3=81=84=EF=BC=88=E3=82=B3=E3=83=9F=
=E3=83=83=E3=83=88=E3=81=95=E3=82=8C=E3=81=AA=E3=81=84=EF=BC=89=E5=A4=89=
=E6=9B=B4"
=20
 #: git-gui.sh:2182
 msgid "Add Existing"
-msgstr ""
+msgstr "=E5=85=A8=E3=81=A6=E3=81=AE=E5=A4=89=E6=9B=B4=E3=82=92=E8=BF=BD=
=E5=8A=A0"
=20
 #: git-gui.sh:2228
 msgid "Initial Commit Message:"
