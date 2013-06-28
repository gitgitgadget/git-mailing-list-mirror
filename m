From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/4] completion: complete rebase --edit-todo
Date: Fri, 28 Jun 2013 19:48:05 +0530
Message-ID: <1372429088-385-2-git-send-email-artagnon@gmail.com>
References: <1372429088-385-1-git-send-email-artagnon@gmail.com>
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 28 16:21:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsZYQ-0001hh-RC
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 16:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956Ab3F1OVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 10:21:30 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:60190 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754430Ab3F1OV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 10:21:28 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf11so2504585pab.10
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 07:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TMl6nk/Oidd3gud2aEtpZKphU494Fc61fiQ7izYF1nA=;
        b=kMyFQb+ExoG5Xhh8DxJovUN6cHkyFcmv41U4ny+xvV14HPJVCuYtPVBHFP5/EHfE0Y
         Ltyy5jGMSWlvEt9gJiOAZE3ZWYNIR6xj2lBqkRPT7w7C2iqrqrtiwbjbpoGMg9/hE7Eq
         OlEbFP+tPgEoFIBRH2eorlCUSw8HLLYJKGIUUGVaGDoFJT4ogV9puBDhgxqDjSNNp4VS
         Pah4D4aI8iasTeblegOQPq/GIjnweOHCqP/rVP4tT15rNdvjoysF4q0KMLI+932LaH/i
         ydkUYVwmQwbR7kr1FRGKH/KEIvuUVwyvMN1eJuYzriccjGmnLEFlq+bG3FAfN2RbPT9v
         NWwA==
X-Received: by 10.66.219.1 with SMTP id pk1mr11781760pac.29.1372429288113;
        Fri, 28 Jun 2013 07:21:28 -0700 (PDT)
Received: from localhost.localdomain ([122.164.185.186])
        by mx.google.com with ESMTPSA id iq6sm8397665pbc.1.2013.06.28.07.21.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 28 Jun 2013 07:21:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.585.g9832cb9
In-Reply-To: <1372429088-385-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229203>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6c3bafe..b51c9e3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1609,6 +1609,10 @@ _git_rebase ()
 {
 	local dir="$(__gitdir)"
 	if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
+		if [ -e "$dir"/rebase-merge/interactive ]; then
+			__gitcomp "--continue --skip --abort --edit-todo"
+			return
+		fi
 		__gitcomp "--continue --skip --abort"
 		return
 	fi
-- 
1.8.3.1.585.g9832cb9
