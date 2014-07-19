From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/4] completion: complete "unstuck" `git push --recurse-submodules`
Date: Sat, 19 Jul 2014 10:45:55 +0100
Message-ID: <a3317a7692675483f60ee10ff98e1e95a3dc4b5a.1405763157.git.john@keeping.me.uk>
References: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 19 11:46:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8RDj-0007wL-AR
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 11:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757495AbaGSJqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 05:46:17 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:38231 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756654AbaGSJqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 05:46:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 08D96CDA3A8;
	Sat, 19 Jul 2014 10:46:16 +0100 (BST)
X-Quarantine-ID: <SyPVucDWXeUM>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SyPVucDWXeUM; Sat, 19 Jul 2014 10:46:15 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 5FFE8CDA56E;
	Sat, 19 Jul 2014 10:46:08 +0100 (BST)
X-Mailer: git-send-email 2.0.1.472.g6f92e5f.dirty
In-Reply-To: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
In-Reply-To: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
References: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253870>

Since the argument to `--recurse-submodules` is mandatory, it does not
need to be stuck to the option with `=`.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 contrib/completion/git-completion.bash | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d0b2895..06211a6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1624,6 +1624,10 @@ __git_push_recurse_submodules="check on-demand"
 _git_push ()
 {
 	case "$prev" in
+	--recurse_submodules)
+		__gitcomp "$__git_push_recurse_submodules"
+		return
+		;;
 	--repo)
 		__gitcomp_nl "$(__git_remotes)"
 		return
-- 
2.0.1.472.g6f92e5f.dirty
