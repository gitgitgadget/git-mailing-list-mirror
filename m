From: Jeff King <peff@peff.net>
Subject: [PATCH] Documentation: git-tag '-m' implies '-a'
Date: Mon, 24 Mar 2008 15:43:08 -0400
Message-ID: <20080324194308.GE14002@coredump.intra.peff.net>
References: <47E7BDB2.3030304@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Mon Mar 24 20:44:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdsaL-0007w1-Uw
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 20:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586AbYCXTnN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2008 15:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753503AbYCXTnM
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 15:43:12 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4357 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228AbYCXTnL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 15:43:11 -0400
Received: (qmail 8708 invoked by uid 111); 24 Mar 2008 19:43:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 24 Mar 2008 15:43:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Mar 2008 15:43:08 -0400
Content-Disposition: inline
In-Reply-To: <47E7BDB2.3030304@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78084>

=46rom: Dirk S=C3=BCsserott <newsletter@dirk.my1.cc>

Described that '-a' is implied when '-m' or '-F' is present.
---
On Mon, Mar 24, 2008 at 03:41:54PM +0100, Dirk S=C3=BCsserott wrote:

> Described that '-a' is implied when '-m' or '-F' is present.

Oh, I see you already took my suggestion before I made it. :)

The text looks good to me, but the patch would not apply here. I think
there are some wrapping issues, and it looks like some tabs have been
mangled to spaces.

Also, it is generally a good idea to:
  - at least cc Junio on patch submissions to make sure he sees it
  - sign off your patch (either with commit -s or format-patch -s).

Here is an unmangled version of the patch.

 Documentation/git-tag.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index b62a3d1..c22fb71 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -26,6 +26,9 @@ creates a 'tag' object, and requires the tag message.=
  Unless
 `-m <msg>` or `-F <file>` is given, an editor is started for the user =
to type
 in the tag message.
=20
+If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <key-id>=
`
+are absent, `-a` is implied.
+
 Otherwise just the SHA1 object name of the commit object is
 written (i.e. a lightweight tag).
=20
@@ -68,10 +71,14 @@ OPTIONS
 	Use the given tag message (instead of prompting).
 	If multiple `-m` options are given, there values are
 	concatenated as separate paragraphs.
+	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
+	is given.
=20
 -F <file>::
 	Take the tag message from the given file.  Use '-' to
 	read the message from the standard input.
+	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
+	is given.
=20
 CONFIGURATION
 -------------
--=20
1.5.5.rc1.123.ge5f4e6
