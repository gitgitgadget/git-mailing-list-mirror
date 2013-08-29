From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 9/9] completion: update --staged options
Date: Thu, 29 Aug 2013 13:14:40 -0500
Message-ID: <1377800080-5309-10-git-send-email-felipe.contreras@gmail.com>
References: <20130829180129.GA4880@nysa>
 <1377800080-5309-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 20:21:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6qL-0005Wl-F3
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756667Ab3H2SVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:21:00 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:34308 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756283Ab3H2SU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:20:59 -0400
Received: by mail-oa0-f41.google.com with SMTP id j17so861428oag.0
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fz+HNBq+PSwczYFgjmwEHuOpZe/Gc63/XfSdfktVSHM=;
        b=Wj6iRHzhyh8ZI1mpIW76O5Z3Oo2lXoMz0q+vgcqYrbedKKixAjfLQHzFUVqYohdMLB
         zby1rnqY+2plCQTYEMsZZm83euFpW/ckaQS8t+fukqvaoLnHNY1IfTwhKCFPfwyu/nix
         Wnikq62qlat2B9viDqZqY38o+veoxMUQ1FmOfCmIel37O5gL6Hz78b/ZlJ1Zz6g/qqXD
         PAEn+s8KmC2SB6rDic7V0kkr4mvJotH7XApu7CeaB9+3fTgb5KwnGN6mu7d6V9fzYbAF
         +3+XkT6tSSn1cY1es05LcvIWiXpRVtbIpWdat0LW+68SHouD7xiUUMVJ1KL/cZ/9GajR
         wdbw==
X-Received: by 10.182.66.115 with SMTP id e19mr3453136obt.96.1377800459331;
        Thu, 29 Aug 2013 11:20:59 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u3sm22083760oeq.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:20:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377800080-5309-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233318>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5da920e..4adc4ed 100644
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
@@ -2229,7 +2229,7 @@ _git_rm ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
+		__gitcomp "--cached --staged --dry-run --ignore-unmatch --quiet"
 		return
 		;;
 	esac
@@ -2296,7 +2296,7 @@ _git_show_branch ()
 
 _git_stash ()
 {
-	local save_opts='--keep-index --no-keep-index --quiet --patch'
+	local save_opts='--keep-index --no-keep-index --stage --no-stage --quiet --patch'
 	local subcommands='save list show apply clear drop pop create branch'
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
@@ -2316,7 +2316,7 @@ _git_stash ()
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
