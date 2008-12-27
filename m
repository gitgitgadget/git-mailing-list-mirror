From: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
Subject: [PATCH v2] git-shortlog.txt: improve documentation about .mailmap files
Date: Sat, 27 Dec 2008 19:23:30 +0100
Message-ID: <1230402210-30565-1-git-send-email-dato@net.com.org.es>
References: <20081227182140.GA28946@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 27 19:25:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGdqr-0001Nz-Qm
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 19:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbYL0SXf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 13:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753314AbYL0SXe
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 13:23:34 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:4061
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302AbYL0SXd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 13:23:33 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id D43C9801BF66;
	Sat, 27 Dec 2008 19:23:31 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LGdox-0007xh-0G; Sat, 27 Dec 2008 19:23:31 +0100
X-Mailer: git-send-email 1.6.1.307.g07803
In-Reply-To: <20081227182140.GA28946@chistera.yi.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104011>

The previous .mailmap example made it seem like .mailmap files are only
useful for commits with a wrong address for an author, when they are ab=
out
fixing the real name. Explained this better in the text, and replaced t=
he
existing example with a new one that hopefully makes things clearer.

Signed-off-by: Adeodato Sim=C3=B3 <dato@net.com.org.es>
---
 Documentation/git-shortlog.txt |   40 ++++++++++++++++++++++++++++++++=
+-------
 1 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlo=
g.txt
index 7ccf31c..4a76b7f 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -48,15 +48,41 @@ OPTIONS
 FILES
 -----
=20
-If the file `.mailmap` exists, it will be used for mapping author
-email addresses to a real author name. One mapping per line, first
-the author name followed by the email address enclosed by
-'<' and '>'. Use hash '#' for comments. Example:
+If a file `.mailmap` exists in the toplevel directory of the repositor=
y,
+it is used to map author email addresses to a canonical real name. Thi=
s
+can be used to coalesce together commits by the same person where thei=
r
+name was spelled differently (whether with the same email address or
+not).
+
+Each line in the file consists, in this order, of the canonical real n=
ame
+of an author, whitespace, and an email address (enclosed by '<' and '>=
')
+to map to the name. Use hash '#' for comments, either on their own lin=
e,
+or after the email address.
+
+A canonical name may appear in more than one line, associated with
+different email addresses, but it doesn't make sense for a given addre=
ss
+to appear more than once (if that happens, the latest line in which it
+appears will take effect).
+
+So, for example, if your history contains commits by two authors, Jane
+and Joe, whose names appear in the repository under several forms:
+
+------------
+Joe Developer <joe@example.com>
+Joe R. Developer <joe@example.com>
+Jane Doe <jane@example.com>
+Jane Doe <jane@laptop.(none)>
+Jane D. <jane@desktop.(none)>
+------------
+
+Then, supposing Joe wants his middle name initial used, and Jane prefe=
rs
+her family name fully spelled out, a proper `.mailmap` file would be:
=20
 ------------
-# Keep alphabetized
-Adam Morrow <adam@localhost.localdomain>
-Eve Jones <eve@laptop.(none)>
+# Note how we don't need an entry for <jane@laptop.(none)>, because th=
e
+# real name of that author is correct already, and coalesced directly.
+Jane Doe <jane@desktop.(none)>
+Joe R. Developer <joe@random.com>
 ------------
=20
 Author
--=20
1.6.1.307.g07803
