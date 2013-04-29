From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/5] git-completion.bash: add remote.pushdefault to config list
Date: Mon, 29 Apr 2013 18:19:41 +0530
Message-ID: <1367239781-5232-6-git-send-email-artagnon@gmail.com>
References: <1367239781-5232-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@mail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 14:48:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWnVa-0002Vl-6V
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 14:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758156Ab3D2Ms1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 08:48:27 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:40342 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757490Ab3D2MsX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 08:48:23 -0400
Received: by mail-pd0-f172.google.com with SMTP id 4so3609436pdd.17
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Fgxl3TRfdXkiQ6wD3LlNtHLMENdIjy9YIvhV9DU3H9E=;
        b=tqqOOIKAd3cppsgSbyA2O0or4BBoRdNjA/zGP2u9XskvUXwcV4ldk5szMGcb02TCBM
         kRilBAih18coNez5g2hBXzobx3L4QqJ5edZTDFRVVk8nvi2zH8xQAM2r9kdwE+GRmvkW
         s+Am7K2eTscelV15Ldemwv/Gpun2olnDZan1jGaMUdnj5tD41Y1yjhc2meX+HSGyAOkr
         4UwlVAVCzcACAEdbfO/V1KNNVsO/kvKeByvNlC6mPSlnrq49bz6yhZSCRM+6xOLQoGWF
         AEUof7sBWkhJCpYIVJGoIJQ6Yyl3A41l/4O8xQOQQT0CVZksmxPT8BRjcZbZpBDqvL2P
         7x8A==
X-Received: by 10.68.116.166 with SMTP id jx6mr69774701pbb.128.1367239703385;
        Mon, 29 Apr 2013 05:48:23 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id wi6sm23963106pbc.22.2013.04.29.05.48.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 05:48:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.616.ga1e5536.dirty
In-Reply-To: <1367239781-5232-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222790>

224c2171 (remote.c: introduce remote.pushdefault, 2013-04-02)
introduced the remote.pushdefault configuration variable, but forgot
to teach git-completion.bash about it.  Fix this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index af271cc..2bbd8a3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1822,6 +1822,10 @@ _git_config ()
 		__gitcomp "false true"
 		return
 		;;
+	remote.pushdefault)
+		__gitcomp_nl "$(__git_remotes)"
+		return
+		;;
 	remote.*.fetch)
 		local remote="${prev#remote.}"
 		remote="${remote%.fetch}"
@@ -2201,6 +2205,7 @@ _git_config ()
 		receive.fsckObjects
 		receive.unpackLimit
 		receive.updateserverinfo
+		remote.pushdefault
 		remotes.
 		repack.usedeltabaseoffset
 		rerere.autoupdate
-- 
1.8.2.1.616.ga1e5536.dirty
