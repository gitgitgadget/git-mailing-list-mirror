From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] bash completion: allow git stash store options completion
Date: Tue, 13 Jan 2015 23:53:32 +0600
Message-ID: <1421171612-12058-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 18:53:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YB5f6-0008La-Ul
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 18:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbbAMRxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 12:53:49 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:48950 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbbAMRxs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 12:53:48 -0500
Received: by mail-lb0-f181.google.com with SMTP id l4so3886442lbv.12
        for <git@vger.kernel.org>; Tue, 13 Jan 2015 09:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=fovaxwe5qAFwS0k2SvVHa8YMaPm/tfIk9qTKzKAIg3I=;
        b=sx9uaQbW2/kDJBUSsDF0PYp379q0P/IzwC8nNZFcfF4mEB8INRzbQzSAkVZN5LXed2
         LEs6g+KSpuikGXsXKPgplxfvBu0wQUUlAqjLuTuyoyJkRZnTB7jWRMWucwwnCOolItba
         lNCmHNlzJFXqICy9Ab0noLBeQ7wrJAWlXxDGg9SlTvMHMlIjC+ty9XiB4bAv8lAWVz4/
         cuiR5XydcM1UfPyZpWV5e5OqcKY+lo01D3PgA2B2anYj5lninJX3Q9MCRrdiNsO+zYez
         2tcQYwEGJfnw2GwufGeex29noIPXeYIC0Dk7H7ML83/WP296HO1U4oXXSbiTba7ZkrMt
         w87Q==
X-Received: by 10.112.222.135 with SMTP id qm7mr43230529lbc.19.1421171626754;
        Tue, 13 Jan 2015 09:53:46 -0800 (PST)
Received: from localhost.localdomain ([95.59.128.47])
        by mx.google.com with ESMTPSA id g7sm1027501lae.15.2015.01.13.09.53.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Jan 2015 09:53:45 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.239.g0ae1f56.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262340>

This patch adds bash completion for git stash 'store' subcommand
which apperead at bd514cad (stash: introduce 'git stash store', 18 Jun 2013)

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 contrib/completion/git-completion.bash | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c21190d..7578266 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2375,7 +2375,7 @@ _git_show_branch ()
 _git_stash ()
 {
 	local save_opts='--keep-index --no-keep-index --quiet --patch'
-	local subcommands='save list show apply clear drop pop create branch'
+	local subcommands='save list show apply clear drop pop create branch store'
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
@@ -2402,6 +2402,9 @@ _git_stash ()
 			__gitcomp_nl "$(git --git-dir="$(__gitdir)" stash list \
 					| sed -n -e 's/:.*//p')"
 			;;
+		store,--*)
+			__gitcomp "--message --quiet"
+			;;
 		*)
 			;;
 		esac
-- 
2.3.0.rc0.239.g0ae1f56.dirty
