From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/5] git-completion.bash: add branch.*.pushremote to config list
Date: Mon, 29 Apr 2013 18:19:40 +0530
Message-ID: <1367239781-5232-5-git-send-email-artagnon@gmail.com>
References: <1367239781-5232-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@mail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 14:48:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWnVM-0002Ed-33
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 14:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758153Ab3D2MsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 08:48:22 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:33593 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758151Ab3D2MsV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 08:48:21 -0400
Received: by mail-pb0-f45.google.com with SMTP id ro2so1969381pbb.32
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 05:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=HtMLe+KL0v3I91kx6gz4a6qT3N6CAovUrko8iDXCWnE=;
        b=XvdyNjA8qEKeA41tFJqhMKgmg7ozS69jVtDwdRdKw/Itw4922MggNU61y0vkGsKWK3
         vyZyG05OAmFmgmdysPkYjl+LKrHEA3cMA66TNly1Q7G1oZkCnQxaxxQbh7ziOjRVYNxg
         WIETnTZCI8YG4iiqi3YyRbiFamsroAjfEvcXTAiXiMeyASFGwxl7PQbWEFQ+OeEwiaOf
         OMJKmmw3tUW/isYDhSyahk9Zk60WELYT5BcCtgUO5fLXK8PiKIKFlHWH5xacxjNnVqTu
         0t8G0wub4D1pfw+uBjFBrN1G8nosK4Fv8MyZpLSaT8tm1HB9e1EdFIti8tsmqn2HG5vp
         jkdQ==
X-Received: by 10.66.251.133 with SMTP id zk5mr45964581pac.26.1367239700524;
        Mon, 29 Apr 2013 05:48:20 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id wi6sm23963106pbc.22.2013.04.29.05.48.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 05:48:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.616.ga1e5536.dirty
In-Reply-To: <1367239781-5232-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222789>

9f765ce (remote.c: introduce branch.<name>.pushremote, 2013-04-02)
introduced the configuration variable branch.*.pushremote, but forgot
to teach git-completion.bash about it.  Fix this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7bb11a1..af271cc 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1810,7 +1810,7 @@ __git_config_get_set_variables ()
 _git_config ()
 {
 	case "$prev" in
-	branch.*.remote)
+	branch.*.remote|branch.*.pushremote)
 		__gitcomp_nl "$(__git_remotes)"
 		return
 		;;
@@ -1906,7 +1906,7 @@ _git_config ()
 		;;
 	branch.*.*)
 		local pfx="${cur%.*}." cur_="${cur##*.}"
-		__gitcomp "remote merge mergeoptions rebase" "$pfx" "$cur_"
+		__gitcomp "remote pushremote merge mergeoptions rebase" "$pfx" "$cur_"
 		return
 		;;
 	branch.*)
-- 
1.8.2.1.616.ga1e5536.dirty
