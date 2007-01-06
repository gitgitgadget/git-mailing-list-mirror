From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] Print a more accurate error message when we fail to create a lock file.
Date: Fri, 5 Jan 2007 19:14:04 -0800
Message-ID: <20070106031404.GA4863@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 04:14:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H320b-0003bR-O9
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 04:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbXAFDOI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 22:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbXAFDOI
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 22:14:08 -0500
Received: from tater.midwinter.com ([216.32.86.90]:39483 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751135AbXAFDOH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 22:14:07 -0500
Received: (qmail 5034 invoked by uid 1001); 6 Jan 2007 03:14:04 -0000
To: Len Brown <lenb@kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36073>

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---
 lockfile.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 731bbf3..4824f4d 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -49,7 +49,7 @@ int hold_lock_file_for_update(struct lock_file *lk,
const char *path, int die_on
 {
 	int fd = lock_file(lk, path);
 	if (fd < 0 && die_on_error)
-		die("unable to create '%s': %s", path, strerror(errno));
+		die("unable to create '%s.lock': %s", path, strerror(errno));
 	return fd;
 }
 
-- 
1.5.0.rc0.g244a7
