From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH] Read the config in rev-list
Date: Sun, 18 Feb 2007 10:36:22 +0100
Message-ID: <20070218093621.10137.25801.stgit@c165>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 18 10:36:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIiTC-0005d3-RL
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 10:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933160AbXBRJgZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 04:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933161AbXBRJgY
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 04:36:24 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:57995 "EHLO
	mxfep02.bredband.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933160AbXBRJgY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 04:36:24 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep02.bredband.com with ESMTP
          id <20070218093622.YAVV2832.mxfep02.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Sun, 18 Feb 2007 10:36:22 +0100
Received: from c-6466e455.09-360-6c6b701.cust.bredbandsbolaget.se (HELO c165) ([85.228.102.100])
  by ironport.bredband.com with ESMTP; 18 Feb 2007 10:36:22 +0100
Received: from c165 ([127.0.0.1])
	by c165 with esmtp (Exim 3.36 #1 (Debian))
	id 1HIiT0-0002dc-00
	for <git@vger.kernel.org>; Sun, 18 Feb 2007 10:36:22 +0100
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40069>


Otherwise "git rev-list --header HEAD" will not do the right
thing if i18n.commitencoding is set.

Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>

---

 builtin-rev-list.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 1bb3a06..c2db5a5 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -226,6 +226,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int i;
 	int read_from_stdin = 0;
 
+	git_config(git_default_config);
 	init_revisions(&revs, prefix);
 	revs.abbrev = 0;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
