From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 1/2] git-commit.txt: Correct option alternatives
Date: Sat,  7 Jun 2008 02:24:20 +0200
Message-ID: <1212798261-26785-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 02:25:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4mFT-0006cI-IM
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 02:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756618AbYFGAYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 20:24:42 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756251AbYFGAYk
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 20:24:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:40843 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755516AbYFGAYh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 20:24:37 -0400
Received: (qmail invoked by alias); 07 Jun 2008 00:24:36 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp055) with SMTP; 07 Jun 2008 02:24:36 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18J3iVQ8+AJHu6vg75aagC37sdbeQbs0CyaRSkQGR
	O5On+AghMJQ/Pj
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K4mEH-0006yN-2T; Sat, 07 Jun 2008 02:24:21 +0200
X-Mailer: git-send-email 1.5.5.1.490.g1fabe.dirty
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84155>

This patch fixes the SYNOPSIS in git-commit.txt:
 * --amend is not an alternative option to -c/-C/-F/-m
 * -m and -F are not alternative options to -c/-C,
   because you can reuse authorship from a commit (-c/-C)
   but change the message (-m/-F).

=46urthermore, for long-option consistency --author <author>
is changed to --author=3D<author>.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
Hi,

Dirk S=FCsserott's question about "minimal documentation patches" remin=
ded me
of an obscurity I came across in the SYNOPSIS section of the git-commit=
 manual:
 [(-c | -C) <commit> | -F <file> | -m <msg> | --amend]

It suggests that you can't do something like
  git commit --amend -C deadf00 -m "Foo is dead. Long live foo."
or that it might not be useful.


The second hunk is: --author <author> is advertised for historical
reasons (I guess), but all the other long options with an argument
are --long-opt=3D<arg>, e.g. --message=3D<msg> or --cleanup=3D<mode>.
(Notice the equals sign.)
Because parse_long_opt() accepts both, I changed this for consistency
reasons.

Regards,
  Stephan

 Documentation/git-commit.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index c3c9f5b..c734326 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -8,8 +8,8 @@ git-commit - Record changes to the repository
 SYNOPSIS
 --------
 [verse]
-'git-commit' [-a | --interactive] [-s] [-v] [-u]
-	   [(-c | -C) <commit> | -F <file> | -m <msg> | --amend]
+'git-commit' [-a | --interactive] [-s] [-v] [-u] [--amend]
+	   [(-c | -C) <commit>] [-F <file> | -m <msg>]
 	   [--allow-empty] [--no-verify] [-e] [--author <author>]
 	   [--cleanup=3D<mode>] [--] [[-i | -o ]<file>...]
=20
@@ -68,7 +68,7 @@ OPTIONS
 	Take the commit message from the given file.  Use '-' to
 	read the message from the standard input.
=20
---author <author>::
+--author=3D<author>::
 	Override the author name used in the commit.  Use
 	`A U Thor <author@example.com>` format.
=20
--=20
1.5.5.1
