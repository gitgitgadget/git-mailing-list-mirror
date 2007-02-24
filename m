From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCHv2] core.legacyheaders: Use the description used in RelNotes-1.5.0
Date: Sat, 24 Feb 2007 10:17:10 +0100
Message-ID: <87tzxbj4o9.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 24 10:17:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKt27-0005QV-HJ
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 10:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933454AbXBXJRN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 24 Feb 2007 04:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933457AbXBXJRM
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 04:17:12 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:47674 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933455AbXBXJRL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Feb 2007 04:17:11 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l1O9H8B19274
	for <git@vger.kernel.org>; Sat, 24 Feb 2007 10:17:08 +0100
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40507>


It explains what it does and why, and says how to use the new format.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
Hi *,

 this version removes one of the "older clients".

 Documentation/config.txt |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9d045d8..0c01472 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -192,10 +192,17 @@ core.compression::
 	slowest.
=20
 core.legacyheaders::
-	A boolean which enables the legacy object header format in case
-	you want to interoperate with old clients accessing the object
-	database directly (where the "http://" and "rsync://" protocols
-	count as direct access).
+	A boolean which
+	changes the format of loose objects so that they are more
+	efficient to pack and to send out of the repository over git
+	native protocol, since v1.4.2.  However, loose objects
+	written in the new format cannot be read by git older than
+	that version; people fetching from your repository using
+	older clients over dumb transports (e.g. http) will also
+	be affected.
++
+To let git use the new loose object format, you have to
+set core.legacyheaders to false.
=20
 core.packedGitWindowSize::
 	Number of bytes of a pack file to map into memory in a
--=20
1.5.0.1.576.g78541
