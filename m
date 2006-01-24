From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] stg export: check if there are any patches to export
Date: Tue, 24 Jan 2006 16:25:41 -0500
Message-ID: <1138137941.24415.33.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 24 22:26:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1Vg1-0004Rl-JR
	for gcvg-git@gmane.org; Tue, 24 Jan 2006 22:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWAXVZ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jan 2006 16:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWAXVZ5
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jan 2006 16:25:57 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:20427 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750735AbWAXVZ4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2006 16:25:56 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F1Vfe-0002Nc-E3
	for git@vger.kernel.org; Tue, 24 Jan 2006 16:25:47 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1F1VfZ-0002CK-AZ; Tue, 24 Jan 2006 16:25:41 -0500
To: Catalin Marinas <catalin.marinas@gmail.com>
X-Mailer: Evolution 2.5.4 (2.5.4-10) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15107>

Otherwise, stg export fails with "list index out of range"

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 stgit/commands/export.py |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/stgit/commands/export.py b/stgit/commands/export.py
index 096fb68..b8ca133 100644
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -124,6 +124,9 @@ def func(parser, options, args):
     patches = applied[start_idx:stop_idx]
 
     num = len(patches)
+    if num == 0:
+        raise CmdException, 'No patches applied'
+
     zpadding = len(str(num))
     if zpadding < 2:
         zpadding = 2


-- 
Regards,
Pavel Roskin
