From: Shawn Pearce <spearce@spearce.org>
Subject: [RFC 1/5] Remove unnecessary local in get_ref_sha1.
Date: Wed, 17 May 2006 05:54:46 -0400
Message-ID: <20060517095446.GB28529@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 17 11:54:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgIk0-0004LU-1O
	for gcvg-git@gmane.org; Wed, 17 May 2006 11:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWEQJyt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 05:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWEQJyt
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 05:54:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52688 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750785AbWEQJyt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 05:54:49 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FgIjs-0000ul-MC
	for git@vger.kernel.org; Wed, 17 May 2006 05:54:44 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0D732212667; Wed, 17 May 2006 05:54:46 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20180>

Remove unnecessary local in get_ref_sha1.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---

 refs.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

339dddea51656af46f6c8a2fba7f50d96ae2a434
diff --git a/refs.c b/refs.c
index 6c91ae6..0f3491f 100644
--- a/refs.c
+++ b/refs.c
@@ -220,12 +220,9 @@ static char *ref_lock_file_name(const ch
 
 int get_ref_sha1(const char *ref, unsigned char *sha1)
 {
-	const char *filename;
-
 	if (check_ref_format(ref))
 		return -1;
-	filename = git_path("refs/%s", ref);
-	return read_ref(filename, sha1);
+	return read_ref(git_path("refs/%s", ref), sha1);
 }
 
 static int lock_ref_file(const char *filename, const char *lock_filename,
-- 
1.3.2.g7278
