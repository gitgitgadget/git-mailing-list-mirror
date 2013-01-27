From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 12/21] git p4 test: use LineEnd unix in windows tests too
Date: Sat, 26 Jan 2013 22:11:15 -0500
Message-ID: <1359256284-5660-13-git-send-email-pw@padd.com>
References: <1359256284-5660-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 04:15:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIik-00060z-KD
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539Ab3A0DP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:15:29 -0500
Received: from honk.padd.com ([74.3.171.149]:58729 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755361Ab3A0DP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:15:28 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id 026F52F3F;
	Sat, 26 Jan 2013 19:15:28 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id AC28422838; Sat, 26 Jan 2013 22:15:24 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.gf5c753f
In-Reply-To: <1359256284-5660-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214663>

In all clients, even those created on windows, use unix line
endings.  This makes it possible to verify file contents without
doing OS-specific comparisons in all the tests.

Tests in t9802-git-p4-filetype.sh are used to make sure that
the other LineEnd options continue to work.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index d5596de..67101b1 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -142,6 +142,7 @@ client_view() {
 		Description: $P4CLIENT
 		Root: $cli
 		AltRoots: $(native_path "$cli")
+		LineEnd: unix
 		View:
 		EOF
 		printf "\t%s\n" "$@"
-- 
1.8.1.1.460.g6fa8886
