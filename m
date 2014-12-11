From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] doc: core.ignoreStat clarify the --assume-unchanged effect
Date: Thu, 11 Dec 2014 23:48:53 +0000
Message-ID: <1418341733-1656-2-git-send-email-philipoakley@iee.org>
References: <1418341733-1656-1-git-send-email-philipoakley@iee.org>
Cc: ?utf-8?Q?S=C3=A9rgio?= Basto <sergio@serjux.com>,
	Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 00:49:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzDTe-0002mU-Hb
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 00:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965250AbaLKXsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 18:48:54 -0500
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:53450 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934113AbaLKXsw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Dec 2014 18:48:52 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnYLAMksilROl3QYPGdsb2JhbABZgwaBKoI1g3rFLwQCAoETFwEBAQEBAQUBAQEBODuEDQEFViMQCEk5ChQGARKIMNglAQEBAQYCII9yB4QpBYQkk1aKH4YIhA4+MIJDAQEB
X-IPAS-Result: AnYLAMksilROl3QYPGdsb2JhbABZgwaBKoI1g3rFLwQCAoETFwEBAQEBAQUBAQEBODuEDQEFViMQCEk5ChQGARKIMNglAQEBAQYCII9yB4QpBYQkk1aKH4YIhA4+MIJDAQEB
X-IronPort-AV: E=Sophos;i="5.07,560,1413241200"; 
   d="scan'208";a="124089459"
Received: from host-78-151-116-24.as13285.net (HELO localhost) ([78.151.116.24])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 11 Dec 2014 23:48:49 +0000
X-Mailer: git-send-email 1.9.4.msysgit.0
In-Reply-To: <1418341733-1656-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261309>

The assume-unchanged bit can be misunderstood. Be assertive about
the expectation that file changes should update that flag.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/config.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c26a7c8..81570b7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -354,10 +354,11 @@ proxy use, while defaulting to a common proxy for external domains.
 core.ignoreStat::
 	If true, commands which modify both the working tree and the index
 	will mark the updated paths with the "assume unchanged" bit in the
-	index. These marked files are then assumed to stay unchanged in the
-	working tree, until you mark them otherwise manually - Git will not
-	detect the file changes	by lstat() calls. This is useful on systems
-	where those are very slow, such as Microsoft Windows.
+	index. These marked files are then expected to stay unchanged in the
+	working tree. If you change them you should mark their update manually.
+	Git will normally not detect the file changes by lstat() calls.
+	This is useful on systems where those calls are very slow, such as
+	cifs/Microsoft Windows.
 	See linkgit:git-update-index[1].
 	False by default.
 
-- 
1.9.4.msysgit.0
