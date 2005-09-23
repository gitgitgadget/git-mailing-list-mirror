From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 1/6] fetch.c: Do not build object ref lists
Date: Fri, 23 Sep 2005 16:28:13 +0400 (MSD)
Message-ID: <20050923122813.27F56E010FC@center4.mivlgu.local>
References: <20050923122754.GB2197@master.mivlgu.local>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 14:29:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EImf7-00077W-L0
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 14:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbVIWM2T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 08:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbVIWM2T
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 08:28:19 -0400
Received: from mivlgu.ru ([81.18.140.87]:13008 "EHLO center4.mivlgu.local")
	by vger.kernel.org with ESMTP id S1750925AbVIWM2S (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 08:28:18 -0400
Received: by center4.mivlgu.local (Postfix, from userid 500)
	id 27F56E010FC; Fri, 23 Sep 2005 16:28:13 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20050923122754.GB2197@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9184>

The fetch code does not need object ref lists; by disabling them we
can save some time and memory.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>


---

 fetch.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

cf77c02b386647f312a86ffc342b010ae55725cd
diff --git a/fetch.c b/fetch.c
--- a/fetch.c
+++ b/fetch.c
@@ -206,6 +206,7 @@ int pull(char *target)
 	int fd = -1;
 
 	save_commit_buffer = 0;
+	track_object_refs = 0;
 	if (write_ref && current_ref) {
 		fd = lock_ref_sha1(write_ref, current_ref);
 		if (fd < 0)
