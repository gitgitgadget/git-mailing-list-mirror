From: mr.gaffo@gmail.com
Subject: [PATCH JGit 17/19] added call to update the info refs file
Date: Sun, 13 Sep 2009 13:44:33 -0500
Message-ID: <1252867475-858-18-git-send-email-mr.gaffo@gmail.com>
References: <1252867475-858-1-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-2-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-3-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-4-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-5-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-6-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-7-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-8-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-9-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-10-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-11-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-12-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-13-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-14-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-15-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-16-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-17-git-send-email-mr.gaffo@gmail.com>
Cc: "mike.gaffney" <mike.gaffney@asolutions.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 20:45:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmu4m-0003Gw-FZ
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbZIMSpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753903AbZIMSpD
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:45:03 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:19834 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbZIMSo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:44:58 -0400
Received: by an-out-0708.google.com with SMTP id d40so7549191and.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 11:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7/UM+XZyzvVo+o7cVJmILlVEadRuIK8cddLbtD7TeCU=;
        b=cg74OUo1LHRxMb3cuwtJN35IalIA0sLs0mf0Foy/VBMq1ZHRS4ALdxAs7bgMiadsvU
         mpFJJcxoWUztclha0uEmDZF4GnRnMA8USrbkpUY89KeufHH4xkAxEDeHRGVubwJf5R+u
         I9TAFHHVLzEkcD34YgI1RnPYLK7x+5rKJHN9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cctm4UlSUAccbynAGuUj9/XfxCxSVi+4m3gWfoVC7SG8aHsZosX4z7VlIeRxDHFVcW
         JbvvJb6lw73FiDobz7D2ZKfw/sld2Y4VpC78w/3teYuWjZJohHiRzMzhb4fZaxr31Ixa
         hiay0nldC3CjuLp0cycX/OBr6figY9kQVEDXI=
Received: by 10.101.190.9 with SMTP id s9mr3841432anp.198.1252867502268;
        Sun, 13 Sep 2009 11:45:02 -0700 (PDT)
Received: from localhost.localdomain ([70.230.157.86])
        by mx.google.com with ESMTPS id 23sm1238736yxe.0.2009.09.13.11.45.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 11:45:01 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1252867475-858-17-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128391>

From: mike.gaffney <mike.gaffney@asolutions.com>

---
 .../org/spearce/jgit/transport/ReceivePack.java    |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
index baa1dec..0c818d9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
@@ -523,6 +523,16 @@ void sendString(final String s) throws IOException {
 
 			postReceive.onPostReceive(this, filterCommands(Result.OK));
 			updateObjectInfoCache();
+			updateInfoRefsCache();
+		}
+	}
+
+	private void updateInfoRefsCache() {
+		try{
+			getRepository().getInfoDatabase().updateInfoCache(getRepository().getAllRefs().values());
+		}
+		catch (IOException e){
+			sendMessage("error updating info/refs: " + e.getMessage());
 		}
 	}
 
-- 
1.6.4.2
