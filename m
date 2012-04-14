From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 2/5] completion: trivial simplification
Date: Sun, 15 Apr 2012 00:43:01 +0300
Message-ID: <1334439784-6460-3-git-send-email-felipe.contreras@gmail.com>
References: <1334439784-6460-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 14 23:44:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJAlR-0002B8-6y
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 23:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756285Ab2DNVoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 17:44:08 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61618 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756157Ab2DNVoG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 17:44:06 -0400
Received: by mail-lb0-f174.google.com with SMTP id gm6so3219309lbb.19
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 14:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ae/deUHs1t1ZLFEBRYzjvB69gTAlwcLavHof/qGOd20=;
        b=0jYxgXx1kXZyj7IFJNCXK8aG07HwR6/YnLwYy0WdmgE8HX7H+vXWqO1y+ec7qeOgPx
         2L6qmxAD19aQpmGU3fJm+C85h/qehstVAw75H9BHGc9DL1VITE7NkfAap9gLq2fyrjjh
         orF9lZApI7hfqWBlpHxeYPSq4XqEZ+cANmWdwW71PE8nnN9jptUi7z9AiVXd4UFr5xlJ
         fE3JUkliyoWuZ2m4nZbqChtGiBbx6lRct3Y1YDuhH1yv7NvKnscwAeh2qOnbfwKh42z1
         yr4GqHFcYVBD4NpQyYtYxwQkwZix7oJk8YPF2itvs8L3DUu57CPcD58Jkz0z/N288e77
         LBfg==
Received: by 10.112.36.133 with SMTP id q5mr2881889lbj.37.1334439845411;
        Sat, 14 Apr 2012 14:44:05 -0700 (PDT)
Received: from localhost (84-231-107-120.elisa-mobile.fi. [84.231.107.120])
        by mx.google.com with ESMTPS id tb4sm7761976lab.14.2012.04.14.14.44.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 Apr 2012 14:44:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.g1f19b8.dirty
In-Reply-To: <1334439784-6460-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195520>

cword-1 is the previous word ($prev).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 13be9a7..9d36bb7 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1658,7 +1658,7 @@ _git_notes ()
 		__gitcomp '--ref'
 		;;
 	,*)
-		case "${words[cword-1]}" in
+		case "$prev" in
 		--ref)
 			__gitcomp_nl "$(__git_refs)"
 			;;
@@ -1684,7 +1684,7 @@ _git_notes ()
 	prune,*)
 		;;
 	*)
-		case "${words[cword-1]}" in
+		case "$prev" in
 		-m|-F)
 			;;
 		*)
-- 
1.7.10.1.g1f19b8.dirty
