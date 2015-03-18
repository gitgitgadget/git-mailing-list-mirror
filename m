From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 6/8] rebase: remove unused function
Date: Wed, 18 Mar 2015 16:55:45 +0700
Message-ID: <1426672547-11369-7-git-send-email-pclouds@gmail.com>
References: <1426672547-11369-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 10:56:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYAiY-0002rJ-9y
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 10:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933208AbbCRJ4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 05:56:43 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:32838 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933203AbbCRJ4j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 05:56:39 -0400
Received: by pdnc3 with SMTP id c3so38522660pdn.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 02:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EqPER7S0utoaqyP1yLUPHIuMfq540lYSN7tLyUE9dc0=;
        b=IEpmtqsnIAy0cOrfV5nTpcZdexuCK9PvR566L6qNVHbgRpE2HY6r0zTksr2Rerbbmq
         foFtOSFBMv26i72L0r0ob7B681G2Sk4XYKQGsAZTrS8x6IEesW9YYBX34n4fs5Sm2xU5
         MCppMJgXj+Vxt6LEf5jdK1aEpKmkfwJHKnRIEGgLo/IyQWTBXFvOeSsH5ymRP2FOqbZC
         6ZA5BsP94GIxfvCCGvckLfXRI0rNO4oIOJMSWDP+GWkFALQHWtiWgJh1MYF56hMSlKxT
         y4H9cDEvZvckZfw87CxbN5xFkYLp2SJS06FhkDRAt8drrKTbEVzdbA7rtINtEF4VppDq
         tZmA==
X-Received: by 10.67.10.47 with SMTP id dx15mr162647852pad.139.1426672599275;
        Wed, 18 Mar 2015 02:56:39 -0700 (PDT)
Received: from lanh ([115.73.252.85])
        by mx.google.com with ESMTPSA id zi10sm26713537pab.35.2015.03.18.02.56.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2015 02:56:38 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Mar 2015 16:56:35 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1426672547-11369-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265708>

git-rebase.sh is no longer a dependency for rebase subscripts. This
function is only used by subscripts only, which now becomes useless.
---
 git-rebase.sh | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 86119e7..d941239 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -102,19 +102,6 @@ read_basic_state () {
 		allow_rerere_autoupdate="$(cat "$state_dir"/allow_rerere_autoupdate)"
 }
 
-write_basic_state () {
-	echo "$head_name" > "$state_dir"/head-name &&
-	echo "$onto" > "$state_dir"/onto &&
-	echo "$orig_head" > "$state_dir"/orig-head &&
-	echo "$GIT_QUIET" > "$state_dir"/quiet &&
-	test t = "$verbose" && : > "$state_dir"/verbose
-	test -n "$strategy" && echo "$strategy" > "$state_dir"/strategy
-	test -n "$strategy_opts" && echo "$strategy_opts" > \
-		"$state_dir"/strategy_opts
-	test -n "$allow_rerere_autoupdate" && echo "$allow_rerere_autoupdate" > \
-		"$state_dir"/allow_rerere_autoupdate
-}
-
 output () {
 	case "$verbose" in
 	'')
-- 
2.3.0.rc1.137.g477eb31
