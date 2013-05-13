From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 03/10] remote-hg: enable track-branches in hg-git mode
Date: Mon, 13 May 2013 18:11:53 -0500
Message-ID: <1368486720-2716-4-git-send-email-felipe.contreras@gmail.com>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 01:14:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc1wv-0007Jj-02
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 01:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565Ab3EMXOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 19:14:10 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:63712 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755474Ab3EMXOI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 19:14:08 -0400
Received: by mail-ob0-f170.google.com with SMTP id er7so5949197obc.29
        for <git@vger.kernel.org>; Mon, 13 May 2013 16:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=K8G4+KZocikG29OlQgAFfZd+gU3WwuJLU2RbAdMfP8s=;
        b=WVQedkolPZnnQYLiDNJ1abAd5eoSonMRh9Fyv+rPmbqA8nAlM1rhvQhXWJb2DNMvA+
         IbKMcBSrJYW/Q1N66FjnSAPODtJki7849rNQz++JZvNltDU5Mt+sA4yYT3xjlIGYN4yc
         0uM41Wae3XefP4aOMWnSNBfmtwffPtFv7s1B11o4p4hmO5er5yVugPLsVkadVxhKZs4e
         RBOJaK8CdbQs9TTkhWO3thus0Zs3ZAoZwmf/GwjLwcySSqD86CBHhbo4+11y30BhWy7v
         BElllDxstOnqex0byHrbW4dZiNaqKLkdUy35ciMyvI5FsA9GAUKbylMKHAw/Wd/S2lbw
         b90w==
X-Received: by 10.60.125.232 with SMTP id mt8mr8667797oeb.33.1368486847235;
        Mon, 13 May 2013 16:14:07 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ku7sm18773133obc.6.2013.05.13.16.14.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 16:14:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224221>

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
