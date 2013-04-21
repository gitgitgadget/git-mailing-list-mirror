From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/5] git-completion.bash: add branch.*.pushremote to config list
Date: Sun, 21 Apr 2013 18:35:50 +0530
Message-ID: <1366549551-18763-5-git-send-email-artagnon@gmail.com>
References: <1366549551-18763-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 21 15:06:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTtyG-0007Es-0i
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 15:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458Ab3DUNGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 09:06:11 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:53202 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab3DUNGI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 09:06:08 -0400
Received: by mail-pd0-f180.google.com with SMTP id q11so3033517pdj.11
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 06:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=K1P6XhLFnESBLLBAtZxx2BWr3UfN9ubeB2gpx/jycKw=;
        b=PLwyOcotqfpSeLHilZOW/z36Hbilln30niPKiNxfL/xV4ZFmB/X2Pa9RxmhhGe4fWj
         PvyBdNi1DFwvKNupTopPUa/Ptz8YEVQnJXuZ4jJt0MEQ5T2Xdof/LnIqrXR10dnOvcoD
         CvMUywRpCs+PDUEfbbjOb0+Kl04FAy8ggDd6I9smfqNuq0Pgfiy6v4qJvYUCoSjBc4Mx
         STum5rKnfoG3K26yNeBLmy6UbcF4rWNZ7EG/5Q4TinrnDoKzBUAWZg82EuYWikewaFvI
         SUG86y8BSsex4iETL0RR4JxfeWKO6BVOMJ69f+XwnvBM8d/BWCCXyOjnsyo3R0h9aaw8
         AraA==
X-Received: by 10.68.164.163 with SMTP id yr3mr27095686pbb.27.1366549567918;
        Sun, 21 Apr 2013 06:06:07 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id aa8sm1570112pad.14.2013.04.21.06.06.05
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 06:06:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
In-Reply-To: <1366549551-18763-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221952>

9f765ce (remote.c: introduce branch.<name>.pushremote, 2013-04-02)
introduced the configuration variable branch.*.pushremote, but forgot
to teach git-completion.bash about it.  Fix this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 843273c..fa0d604 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1817,7 +1817,7 @@ __git_config_get_set_variables ()
 _git_config ()
 {
 	case "$prev" in
-	branch.*.remote)
+	branch.*.remote|branch.*.pushremote)
 		__gitcomp_nl "$(__git_remotes)"
 		return
 		;;
@@ -1913,7 +1913,7 @@ _git_config ()
 		;;
 	branch.*.*)
 		local pfx="${cur%.*}." cur_="${cur##*.}"
-		__gitcomp "remote merge mergeoptions rebase" "$pfx" "$cur_"
+		__gitcomp "remote pushremote merge mergeoptions rebase" "$pfx" "$cur_"
 		return
 		;;
 	branch.*)
-- 
1.8.2.1.501.gd2949c7
