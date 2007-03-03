From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 3/6] Fix a "label defined but unreferenced" warning.
Date: Sat, 03 Mar 2007 18:28:46 +0000
Message-ID: <45E9BE5E.2000207@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 03 19:29:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNYzI-0007UJ-UF
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 19:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbXCCS3a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 13:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbXCCS3a
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 13:29:30 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:2792 "EHLO
	anchor-post-31.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030348AbXCCS3U (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Mar 2007 13:29:20 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-31.mail.demon.net with esmtp (Exim 4.42)
	id 1HNYyn-000C0u-5d; Sat, 03 Mar 2007 18:29:14 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41309>



Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
  refs.c |    2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index 6387703..a9b8c72 100644
--- a/refs.c
+++ b/refs.c
@@ -1042,7 +1042,9 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
  		return -1;
  	}

+#ifndef NO_SYMLINK_HEAD
  	done:
+#endif
  	if (logmsg && !read_ref(refs_heads_master, new_sha1))
  		log_ref_write(ref_target, old_sha1, new_sha1, logmsg);

-- 
1.5.0
