From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH v2 4/4] Documentation/git-commit.txt: rework the --cleanup section
Date: Tue, 19 Feb 2013 10:29:30 -0800
Message-ID: <1361298570-19738-1-git-send-email-bcasey@nvidia.com>
References: <7va9r06we2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, <jrnieder@gmail.com>,
	<ralf.thielow@gmail.com>, Brandon Casey <drafnel@gmail.com>
To: <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 19:30:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7rxL-00069K-Cc
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 19:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933513Ab3BSS3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 13:29:55 -0500
Received: from hqemgate04.nvidia.com ([216.228.121.35]:15655 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933152Ab3BSS3z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 13:29:55 -0500
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate04.nvidia.com
	id <B5123c4850000>; Tue, 19 Feb 2013 10:29:26 -0800
Received: from hqemhub03.nvidia.com ([172.17.108.22])
  by hqnvupgp08.nvidia.com (PGP Universal service);
  Tue, 19 Feb 2013 10:25:03 -0800
X-PGP-Universal: processed;
	by hqnvupgp08.nvidia.com on Tue, 19 Feb 2013 10:25:03 -0800
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub03.nvidia.com
 (172.20.150.15) with Microsoft SMTP Server id 8.3.297.1; Tue, 19 Feb 2013
 10:29:32 -0800
X-Mailer: git-send-email 1.8.1.3.566.gaa39828
In-Reply-To: <7va9r06we2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216643>

From: Brandon Casey <drafnel@gmail.com>

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


[RESEND] I originally specified Junio's address as gitster@pobox.org.
[RESEND] Sorry, now with the correct address.

Ok, here's the updated text.  I am not set up to build the documentation,
so I hope someone will test, but looks right to me.

-Brandon


 Documentation/git-commit.txt | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0eb79cc..992c219 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -172,16 +172,24 @@ OPTIONS
        linkgit:git-commit-tree[1].
 
 --cleanup=<mode>::
-	This option sets how the commit message is cleaned up.
-	The  '<mode>' can be one of 'verbatim', 'whitespace', 'strip',
-	and 'default'. The 'default' mode will strip leading and
-	trailing empty lines and #commentary from the commit message
-	only if the message is to be edited. Otherwise only whitespace
-	removed. The 'verbatim' mode does not change message at all,
-	'whitespace' removes just leading/trailing whitespace lines
-	and 'strip' removes both whitespace and commentary. The default
-	can be changed by the 'commit.cleanup' configuration variable
-	(see linkgit:git-config[1]).
+	This option determines how the supplied commit message should be
+	cleaned up before committing.  The '<mode>' can be `strip`,
+	`whitespace`, `verbatim`, or `default`.
++
+--
+strip::
+	Strip leading and trailing empty lines, trailing whitespace, and
+	#commentary and collapse consecutive empty lines.
+whitespace::
+	Same as `strip` except #commentary is not removed.
+verbatim::
+	Do not change the message at all.
+default::
+	`strip` if the message is to be edited.  Otherwise `whitespace`.
+--
++
+	The default can be changed by the 'commit.cleanup' configuration
+	variable (see linkgit:git-config[1]).
 
 -e::
 --edit::
-- 
1.8.1.3.566.gaa39828
