From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/5] git-completion.bash: complete branch.*.rebase as boolean
Date: Mon, 29 Apr 2013 18:19:39 +0530
Message-ID: <1367239781-5232-4-git-send-email-artagnon@gmail.com>
References: <1367239781-5232-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@mail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 14:48:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWnVL-0002Ed-IS
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 14:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758152Ab3D2MsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 08:48:20 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:65096 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758150Ab3D2MsS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 08:48:18 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so1604192pde.37
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 05:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=K9l2kucMFrNQAzO2X+fXbI/97lK4zoFh6t5+8gH9CS4=;
        b=OaUpxAxGhVQD++/0sMIxh76eiWY/YMkDUTVyI90TvrYa635z+aK9oNwIXLmvKorGPM
         XC9apKC6BtcRjTyauWvWsQqtC9G+FPfwofh8Qd1DFUktu+G4A9QAPZGCzacjbECrpfV7
         GM1XZHSTJVNe2gMzFPsDfrQffMiqzZjHXSrKnJX8tjtd5Ln6v971lX3f/MwskP13VMlc
         RTmw/RKfwMy0lHNmc6JyxZbIx0Rg4mExEUMEdLRWxle1Za4WZLnHBWLi2qq2hOopA0cR
         4xUYItTv9WgVO3zS8pyxNGEhSrwNI3tgqlgEjWtB3mcakHFFGp6rdFC35FUB58zOlbVc
         tewQ==
X-Received: by 10.68.179.101 with SMTP id df5mr12864204pbc.199.1367239698042;
        Mon, 29 Apr 2013 05:48:18 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id wi6sm23963106pbc.22.2013.04.29.05.48.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 05:48:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.616.ga1e5536.dirty
In-Reply-To: <1367239781-5232-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222788>

6fac1b83 (completion: add missing config variables, 2009-06-29) added
"rebase" to the list of completions for "branch.*.*", but forgot to
specify completions for the values that this configuration variable
can take (namely "false" and "true").  Fix this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ba46cd9..7bb11a1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1818,6 +1818,10 @@ _git_config ()
 		__gitcomp_nl "$(__git_refs)"
 		return
 		;;
+	branch.*.rebase)
+		__gitcomp "false true"
+		return
+		;;
 	remote.*.fetch)
 		local remote="${prev#remote.}"
 		remote="${remote%.fetch}"
-- 
1.8.2.1.616.ga1e5536.dirty
