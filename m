From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 4/5] completion: complete values for log.date
Date: Sun,  3 May 2009 23:25:34 -0700
Message-ID: <1241418335-18474-4-git-send-email-bebarino@gmail.com>
References: <1241418335-18474-1-git-send-email-bebarino@gmail.com>
 <1241418335-18474-2-git-send-email-bebarino@gmail.com>
 <1241418335-18474-3-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 04 08:26:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0rdA-0004vC-J2
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 08:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbZEDG0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 02:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752689AbZEDG0E
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 02:26:04 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:48721 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbZEDG0D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 02:26:03 -0400
Received: by wf-out-1314.google.com with SMTP id 26so2971167wfd.4
        for <git@vger.kernel.org>; Sun, 03 May 2009 23:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=m8JH+KVpleDjaxYt/sTQyYFLaELMxu+XwGSrl4vrVdA=;
        b=A7SwM08I6BgJFV1nO273RTnS4SG9VLQvFPo3fEG9k5W4kt1TDSA8Zvtl8NXsEP40tz
         E0yBsypIcB0yXxvhQw0lNE4MXYAZZvCEtIwJhyqSshSWjQlK+/xpCurLOYgpNruSttlX
         i0VqkgZxfGy0AC2uFCFRWAG/AMrf3111th7xg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FGCGylacl13eWp/gPKVLqetD5LCkNpBUfBuc+xFEal1GP9LjbOOQxneotk3+llQFVx
         7aPtyVThv+5u2WuRWPI4rpGwnk3LClYszOaC4zru9UC0V0K6C6Zm8K+qH9IKs5WlKJIZ
         NHxzWhEqiNTKqAoIS4nL29SraWZ1TxqvZJnfE=
Received: by 10.142.132.2 with SMTP id f2mr1965084wfd.175.1241418363543;
        Sun, 03 May 2009 23:26:03 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 22sm641216wfd.19.2009.05.03.23.26.00
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 May 2009 23:26:02 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 03 May 2009 23:25:59 -0700
X-Mailer: git-send-email 1.6.2.3
In-Reply-To: <1241418335-18474-3-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118209>

Add raw to the date formats too.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 contrib/completion/git-completion.bash |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 023b0c9..d67ffd9 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1116,6 +1116,7 @@ __git_log_shortlog_options="
 "
 
 __git_log_pretty_formats="oneline short medium full fuller email raw format:"
+__git_log_date_formats="relative iso8601 rfc2822 short local default raw"
 
 _git_log ()
 {
@@ -1139,9 +1140,7 @@ _git_log ()
 		return
 		;;
 	--date=*)
-		__gitcomp "
-			relative iso8601 rfc2822 short local default
-		" "" "${cur##--date=}"
+		__gitcomp "$__git_log_date_formats" "" "${cur##--date=}"
 		return
 		;;
 	--*)
@@ -1352,6 +1351,10 @@ _git_config ()
 		__gitcomp "man info web html"
 		return
 		;;
+	log.date)
+		__gitcomp "$__git_log_date_formats"
+		return
+		;;
 	*.*)
 		COMPREPLY=()
 		return
-- 
1.6.2.3
