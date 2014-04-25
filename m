From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 try2 11/14] completion: update --staged options
Date: Fri, 25 Apr 2014 13:12:44 -0500
Message-ID: <1398449567-16314-12-git-send-email-felipe.contreras@gmail.com>
References: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 20:24:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdknD-00079k-Pu
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 20:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749AbaDYSYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 14:24:05 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:60230 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629AbaDYSYA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 14:24:00 -0400
Received: by mail-oa0-f47.google.com with SMTP id i11so4610091oag.34
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 11:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PDhfoGPYUpjq0TdBfQZyhfJpOrUs1el6gX8s3yXxrdo=;
        b=VN3FJcS+VB0iIINRCavMe0Uz2c1x3FSWkxnz42q2sunRqJTFbhyLqd9MouYPzPlfXh
         C34JaBIrCIxAq/0EoXNT2Fu6VHkmmsMnER51Qzzoqz+jKgt22OX/xgoMhuyoXJo7kdWv
         Ul6WtffTF5iRkekphvpuXCMmCDqGBEJX/jUJzcgrHgtIiOGoE0bTftYj1bODFfVuuUf5
         fCmqFVYkmMjswh668qtNOf+oAbmfC9oFWR1MidrwoN9/MGZKWXGvKOai69ZNOnqntEPS
         l4OqO7bHUFWUGCTMW7BdY9eY92I3Q6o5LChttrn8br3IqMbZRiRlovJQKKDL2bqg1Gz3
         dfcw==
X-Received: by 10.182.241.9 with SMTP id we9mr1800567obc.81.1398450240590;
        Fri, 25 Apr 2014 11:24:00 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id y10sm17070994obk.4.2014.04.25.11.23.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 11:23:59 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247083>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2ec7b1a..52d83f2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -889,7 +889,7 @@ _git_apply ()
 		__gitcomp "
 			--stat --numstat --summary --check --index
 			--cached --index-info --reverse --reject --unidiff-zero
-			--apply --no-add --exclude=
+			--apply --no-add --exclude= --staged
 			--ignore-whitespace --ignore-space-change
 			--whitespace= --inaccurate-eof --verbose
 			"
@@ -1302,7 +1302,7 @@ _git_grep ()
 	case "$cur" in
 	--*)
 		__gitcomp "
-			--cached
+			--cached --staged
 			--text --ignore-case --word-regexp --invert-match
 			--full-name --line-number
 			--extended-regexp --basic-regexp --fixed-strings
@@ -2270,7 +2270,7 @@ _git_rm ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
+		__gitcomp "--cached --staged --dry-run --ignore-unmatch --quiet"
 		return
 		;;
 	esac
@@ -2337,7 +2337,7 @@ _git_show_branch ()
 
 _git_stash ()
 {
-	local save_opts='--keep-index --no-keep-index --quiet --patch'
+	local save_opts='--keep-index --no-keep-index --stage --no-stage --quiet --patch'
 	local subcommands='save list show apply clear drop pop create branch'
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
@@ -2357,7 +2357,7 @@ _git_stash ()
 			__gitcomp "$save_opts"
 			;;
 		apply,--*|pop,--*)
-			__gitcomp "--index --quiet"
+			__gitcomp "--index --stage --quiet"
 			;;
 		show,--*|drop,--*|branch,--*)
 			;;
-- 
1.9.2+fc1.2.gfbaae8c
