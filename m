From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 8/8] transport-helper: remove unnecessary strbuf resets
Date: Sun, 20 Apr 2014 13:59:30 -0500
Message-ID: <1398020370-11406-9-git-send-email-felipe.contreras@gmail.com>
References: <1398020370-11406-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 21:10:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbx8Y-0005yI-P9
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 21:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481AbaDTTKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 15:10:39 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:32882 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755488AbaDTTKR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 15:10:17 -0400
Received: by mail-yk0-f172.google.com with SMTP id 200so2820813ykr.3
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 12:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l+pwFdgqVEAwcKD9IuGA5FNmO7gnSOe1WumMylUqSyU=;
        b=F4U/ditq6LrzWt0vmKV0N/INw9GV8EQuyFfspFExk04vbs1dUlqDmSwiaxClKGWOJD
         CjxnNQ0MITh/7snvpNOqdPnjS2uH7GiUuqc21W8oTTRSUL8SwRzgDiEvXsi1Usq2SxVT
         6VYow57Rlz0y0dFaFuFNg8swoSEaN4CHHnb/ZVbzjSIpKVQKjaXs3wrFLG3HHq1+mB0M
         BGBhOveBrkIBN0aUTSdghwlxF/B/7sAOSu3v+UsCwIhpCKupUHIH1Jm3FgaEws3rd7Vl
         ztub+MXdR9XNS+xfeuw7WOtwwuFShaWz/WeDdFZyR8RhCZBjWmnKFJKXk8tgOIW+hvCS
         yieQ==
X-Received: by 10.236.119.169 with SMTP id n29mr18391426yhh.62.1398021016989;
        Sun, 20 Apr 2014 12:10:16 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id z4sm19203094yhc.11.2014.04.20.12.10.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 12:10:16 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1398020370-11406-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246566>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 36fbf93..a90094d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -876,8 +876,6 @@ static int push_refs_with_export(struct transport *transport,
 
 	write_constant(helper->in, "export\n");
 
-	strbuf_reset(&buf);
-
 	for (ref = remote_refs; ref; ref = ref->next) {
 		char *private;
 		unsigned char sha1[20];
@@ -892,8 +890,6 @@ static int push_refs_with_export(struct transport *transport,
 
 		if (ref->peer_ref) {
 			if (strcmp(ref->name, ref->peer_ref->name)) {
-				struct strbuf buf = STRBUF_INIT;
-
 				if (!ref->deletion) {
 					const char *name;
 					int flag;
-- 
1.9.1+fc3.9.gc73078e
