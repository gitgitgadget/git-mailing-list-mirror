From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] Better error message when we are unable to lock the index file
Date: Sat, 12 Aug 2006 09:37:56 +0200
Message-ID: <20060812073756.5442.5498.stgit@c165>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Aug 12 09:38:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBo4I-0004Og-EI
	for gcvg-git@gmane.org; Sat, 12 Aug 2006 09:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWHLHh7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Aug 2006 03:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWHLHh7
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Aug 2006 03:37:59 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:26615 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S964814AbWHLHh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Aug 2006 03:37:58 -0400
Received: from c165 ([213.114.27.85] [213.114.27.85])
          by mxfep01.bredband.com with ESMTP
          id <20060812073757.EWLH5813.mxfep01.bredband.com@c165>;
          Sat, 12 Aug 2006 09:37:57 +0200
Received: from c165 ([127.0.0.1])
	by c165 with esmtp (Exim 3.36 #1 (Debian))
	id 1GBo4C-0001Pt-00; Sat, 12 Aug 2006 09:37:56 +0200
To: git@vger.kernel.org
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25253>




Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 builtin-update-index.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 24dca47..f8f5e10 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -493,7 +493,7 @@ int cmd_update_index(int argc, const cha
 
 	newfd = hold_lock_file_for_update(lock_file, get_index_file());
 	if (newfd < 0)
-		die("unable to create new cachefile");
+		die("unable to lock index file: %s", strerror(errno));
 
 	entries = read_cache();
 	if (entries < 0)
