From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] builtin-name-rev.c: remove the remaining "typedef struct rev_name" from git.
Date: Fri, 29 Jan 2010 20:32:02 -0500
Message-ID: <8678db190a73997c7bd757b9d78f0fa9e8721055.1264815015.git.tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 02:32:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb2CD-0008No-Pd
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 02:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963Ab0A3BcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 20:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755476Ab0A3BcP
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 20:32:15 -0500
Received: from mail-qy0-f182.google.com ([209.85.221.182]:37817 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836Ab0A3BcP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 20:32:15 -0500
Received: by qyk12 with SMTP id 12so1162320qyk.21
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 17:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=pTEPPFfdHNYYLS9OhdzDDT+AoZ3WmiSQwwHWfR6CTgk=;
        b=fyZAGeVk6NDa61CPw8rfp2rj1oWlEQz/HpxRyKuqFmu8C+xCc5rtW/9jzjbJT8s1o9
         ZJ8kYUncnT3pxGmaVJHFdLZ/i5FPNITGlYUvYcD1YQ5NuwVdTRDGeyDf5HAT7yDmAfOe
         gPMnIsWOrQkksIKS3ccaJvmxaMA0z976XB2bA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=ZnASbyodVpDdcICqRBuAIwHyyt35nBJQTy264f9zRdZpyqa8+MBIXQDK/oAo9X4nd5
         UxA2OTA7R1Dd+0EzF/UtIa/ZOva3DNXt4nPOriDiWEkLZU07paodlUpmCH+eQmxKO1D7
         1Ch1FSty8y3ukadH+miEhCcUTCkdlaa7+R82c=
Received: by 10.224.45.1 with SMTP id c1mr738829qaf.87.1264815133680;
        Fri, 29 Jan 2010 17:32:13 -0800 (PST)
Received: from localhost ([189.60.227.193])
        by mx.google.com with ESMTPS id 7sm8267992qwb.22.2010.01.29.17.32.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Jan 2010 17:32:12 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1.436.gaba7d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138422>

---
 builtin-name-rev.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 06a38ac..6416f72 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -7,11 +7,11 @@
 
 #define CUTOFF_DATE_SLOP 86400 /* one day */
 
-typedef struct rev_name {
+struct rev_name {
 	const char *tip_name;
 	int generation;
 	int distance;
-} rev_name;
+};
 
 static long cutoff = LONG_MAX;
 
@@ -43,7 +43,7 @@ static void name_rev(struct commit *commit,
 	}
 
 	if (name == NULL) {
-		name = xmalloc(sizeof(rev_name));
+		name = xmalloc(sizeof(struct rev_name));
 		commit->util = name;
 		goto copy_data;
 	} else if (name->distance > distance) {
-- 
1.6.6.1.436.gaba7d
