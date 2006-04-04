From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] On some platforms, certain headers need to be included before
 regex.h
Date: Wed, 5 Apr 2006 01:01:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604050059580.19712@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Apr 05 01:01:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQuWO-0002Bc-Ac
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 01:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWDDXBJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 19:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWDDXBI
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 19:01:08 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:6103 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750924AbWDDXBH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Apr 2006 19:01:07 -0400
Received: from virusscan.mail (mailrelay3.mail [172.25.1.42])
	by mailrelay.mail (Postfix) with ESMTP id 06CB0BDA;
	Wed,  5 Apr 2006 01:01:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id EE099BED;
	Wed,  5 Apr 2006 01:01:03 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id D0A771AC0;
	Wed,  5 Apr 2006 01:01:03 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18410>


Happily, these are already included in cache.h, which is included anyway...
so: change the order of includes.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 diffcore-pickaxe.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

0dcea02390ab0a15e2dbb62b4b876046fe0b4e79
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index d89f314..cfcce31 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -1,11 +1,11 @@
 /*
  * Copyright (C) 2005 Junio C Hamano
  */
-#include <regex.h>
-
 #include "cache.h"
 #include "diff.h"
 #include "diffcore.h"
+
+#include <regex.h>
 
 static unsigned int contains(struct diff_filespec *one,
 			     const char *needle, unsigned long len,
-- 
1.3.0.rc2.g7eaca-dirty
