From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 11/14] completion: update --staged options
Date: Sat, 12 Oct 2013 02:04:47 -0500
Message-ID: <1381561488-20294-14-git-send-email-felipe.contreras@gmail.com>
References: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:11:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtMZ-0004MJ-P4
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813Ab3JLHLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:11:30 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:47750 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775Ab3JLHL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:11:28 -0400
Received: by mail-oa0-f41.google.com with SMTP id n10so3149086oag.28
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7AkUHiGl19sYeDd7SqfgYLdqvrJhRnd11BtqE3CIMrI=;
        b=er8zEpqUkA1nry674btzrHWPutQc6P1vIsNcShncGNOSaVyBWFmd2KTlg8k6aZ/SeS
         +9aBEw1ulVhprgIlNZTtKKQoo6awuwHl3ilcDW19eUUnhnSgZroCZiMP/E/4xwf5UEcR
         adr8SukAj497kNmWT105DOBpwDNA2CevTKsypABLsKDlzHbH9fTPk7HUsdIKFqWHbKx9
         UUFkLig8Hh4f0fjjPuG5vkzhYP7f9Ihvqz6OY2s/uEXpQvNIdEZithW68RcG9DUreKPD
         BWQONLONfZhBvAmWAdtc5VavZyGgnW1KSHiJfm/FwOKIPoDvqJyFhVZi1rVusPl8tq6o
         B/xw==
X-Received: by 10.182.130.131 with SMTP id oe3mr17757794obb.34.1381561888240;
        Sat, 12 Oct 2013 00:11:28 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u3sm101371496oeq.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:11:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235977>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2b81e78..1dde51f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -881,7 +881,7 @@ _git_apply ()
 		__gitcomp "
 			--stat --numstat --summary --check --index
 			--cached --index-info --reverse --reject --unidiff-zero
-			--apply --no-add --exclude=
+			--apply --no-add --exclude= --staged
 			--ignore-whitespace --ignore-space-change
 			--whitespace= --inaccurate-eof --verbose
 			"
@@ -1294,7 +1294,7 @@ _git_grep ()
 	case "$cur" in
 	--*)
 		__gitcomp "
-			--cached
+			--cached --staged
 			--text --ignore-case --word-regexp --invert-match
 			--full-name --line-number
 			--extended-regexp --basic-regexp --fixed-strings
@@ -2253,7 +2253,7 @@ _git_rm ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
+		__gitcomp "--cached --staged --dry-run --ignore-unmatch --quiet"
 		return
 		;;
 	esac
@@ -2320,7 +2320,7 @@ _git_show_branch ()
 
 _git_stash ()
 {
-	local save_opts='--keep-index --no-keep-index --quiet --patch'
+	local save_opts='--keep-index --no-keep-index --stage --no-stage --quiet --patch'
 	local subcommands='save list show apply clear drop pop create branch'
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
@@ -2340,7 +2340,7 @@ _git_stash ()
 			__gitcomp "$save_opts"
 			;;
 		apply,--*|pop,--*)
-			__gitcomp "--index --quiet"
+			__gitcomp "--index --stage --quiet"
 			;;
 		show,--*|drop,--*|branch,--*)
 			;;
-- 
1.8.4-fc
