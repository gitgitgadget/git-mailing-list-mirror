From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 03/47] remote-hg: enable track-branches in hg-git mode
Date: Mon, 13 May 2013 23:36:26 -0500
Message-ID: <1368506230-19614-4-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:38:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc70n-0003jN-7Z
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872Ab3ENEiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:38:50 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:36087 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab3ENEit (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:38:49 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so100815oag.20
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=K8G4+KZocikG29OlQgAFfZd+gU3WwuJLU2RbAdMfP8s=;
        b=dVyaijVJ04baLk3krIKhrSU4LHPLxGmdUCgny77wXDS1+RQ6yvNL8hzxLhlrpClhNW
         cQHXmcwleb32O2Otqd2DGi7e128TqOW9BalhT0b9cpucQRBBxSuXKGui86A/LAfthIY/
         nHNQ0rAd0aJFGR2wgbqaEqS9LCWPmZZs8H3v9fSGQk0JjaomwgblLTqc7tYw1f2fbzOQ
         j90xp9nLLEjzcrmlovP3qgr9qQokXjVPvZ6ua9MC4WzyNayeGZey3v6ED+8ygTiOOO18
         sZbBrDW586HGYCuDnh5mmfO/DTF7mOrZOmyztm8MvEDbZ7xFzkJefzc2LIsI6EUzzI6p
         mtIw==
X-Received: by 10.60.92.41 with SMTP id cj9mr15229847oeb.31.1368506328695;
        Mon, 13 May 2013 21:38:48 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wq8sm19995800obb.7.2013.05.13.21.38.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:38:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224238>

The user can turn this off.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg     | 1 -
 contrib/remote-helpers/test-hg-hg-git.sh | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 9d6940b..de3a96e 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -909,7 +909,6 @@ def main(args):
 
     if get_config('remote-hg.hg-git-compat') == 'true\n':
         hg_git_compat = True
-        track_branches = False
     if get_config('remote-hg.track-branches') == 'false\n':
         track_branches = False
     if get_config('remote-hg.force-push') == 'false\n':
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index 0c36573..7f579c8 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -102,6 +102,7 @@ setup () {
 	) >> "$HOME"/.hgrc &&
 	git config --global receive.denycurrentbranch warn
 	git config --global remote-hg.hg-git-compat true
+	git config --global remote-hg.track-branches false
 
 	HGEDITOR=/usr/bin/true
 
-- 
1.8.3.rc1.579.g184e698
