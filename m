From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] completion: add git-tag options
Date: Thu,  4 Dec 2014 19:07:35 +0100
Message-ID: <1417716455-5609-1-git-send-email-ralf.thielow@gmail.com>
Cc: Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 04 19:07:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwaod-0002K6-VD
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 19:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932905AbaLDSHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 13:07:43 -0500
Received: from mail-wi0-f177.google.com ([209.85.212.177]:61967 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932802AbaLDSHm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 13:07:42 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so28826869wiw.10
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 10:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=keN3jOkLvh6Wnn8N1uSpTYR7fghCeR7I++T/pZSXz9E=;
        b=Ny83H35I5dUIm6n0XMjOZ4ckCBImyr09xCpc1E5VzBjsfkq2SYPi+z77y1d18iz+Zq
         wFsumeH6Joa7X31Za6v+ZHK0tjRnF+qhPSg57Yaq6BSjJTIIVWfD3F7JWt9YmpN+Xfyp
         d5rV1Sci3iFQ+WLpaxs8zItqM95v3EueU41oxjUFwyfBz0WAj36fz26EFKZ5W6bIP0Aq
         Gf+hWjF126FCNcNS4Cr51IlwSbxbtj2z3DvJsGAXaCcILbDQsvi1N2L5KXPRgQmdMn6I
         42dmQL/nOMNqay3OsX6tybJwpzRDIzR5CEJtZqzoAwYY4e20xQqrDcC0AO/7rRNWhMex
         4iNQ==
X-Received: by 10.194.85.137 with SMTP id h9mr18423049wjz.70.1417716458307;
        Thu, 04 Dec 2014 10:07:38 -0800 (PST)
Received: from localhost (dslb-088-073-192-130.088.073.pools.vodafone-ip.de. [88.73.192.130])
        by mx.google.com with ESMTPSA id ud1sm41470927wjc.7.2014.12.04.10.07.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 10:07:37 -0800 (PST)
X-Mailer: git-send-email 2.2.0.269.ge4ffef3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260774>

Add completion for git-tag options including
all options that are currently shown in "git tag -h".

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 contrib/completion/git-completion.bash | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2fece98..cb32dc1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2548,6 +2548,16 @@ _git_tag ()
 		__gitcomp_nl "$(__git_refs)"
 		;;
 	esac
+
+	case "$cur" in
+	--*)
+		__gitcomp "
+			--list --delete --verify --annotate --message --file
+			--sign --cleanup --local-user --force --column --sort
+			--contains --points-at
+			"
+		;;
+	esac
 }
 
 _git_whatchanged ()
-- 
2.2.0.269.ge4ffef3
