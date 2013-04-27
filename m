From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/11] completion: add space after completed filename
Date: Sat, 27 Apr 2013 05:19:52 -0500
Message-ID: <1367057994-19887-10-git-send-email-felipe.contreras@gmail.com>
References: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 12:21:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW2GF-0003IE-13
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 12:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755843Ab3D0KVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 06:21:40 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58016 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755776Ab3D0KVg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 06:21:36 -0400
Received: by mail-ob0-f174.google.com with SMTP id wc20so4232539obb.19
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 03:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=cZnEH8LE2a9W9f+buTMs3iB2gYCqM8c20mi2l/AngBY=;
        b=IeVXk5Kwzns8OonEnQEdIjUgt+djvEpkfywAi6VVzzopVMV+WVquXmJEvFxwI775LZ
         idiakcsDzZwr0Cl41fNRC6ff9GxTIozjc9r90iPm3myqN6AcB6LUCi1UEYDM2VobD5Q3
         oooJItPewew6g/FjrHR38A8Fy6CJMQCTTKeAs4LglJ41fMhw6FIkbcIuX4z+6O/okmKN
         6bo3JdWLGgO0YAMwWlm4gO+CR/x/GG6T7gXhmi5whkE8JQyq/6DoHOfLpso75wfHAHZp
         omiCNLQ3eDzgGPkkroRyHKId14lxpkjXtDeUqOCsNy8WAGE+I/IItZ625pnpFbBfRkj5
         O2Yw==
X-Received: by 10.60.173.196 with SMTP id bm4mr9273908oec.108.1367058095334;
        Sat, 27 Apr 2013 03:21:35 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wq8sm11499401obb.7.2013.04.27.03.21.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 03:21:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222628>

Just like before fea16b4 (git-completion.bash: add support for path
completion).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |  2 +-
 t/t9902-completion.sh                  | 28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a9b6a48..60a6a0b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -247,7 +247,7 @@ __git_index_file_list_filter ()
 	while read -r path; do
 		case "$path" in
 		?*/*) echo "${path%%/*}/" ;;
-		*) echo "$path" ;;
+		*) echo "$path " ;;
 		esac
 	done
 }
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index e6cdb05..8968ef6 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -355,12 +355,12 @@ test_expect_success 'complete files' '
 	echo "out" >> .gitignore &&
 
 	git add .gitignore &&
-	test_completion "git commit " ".gitignore" &&
+	test_completion "git commit " ".gitignore " &&
 
 	git commit -m ignore &&
 
 	touch new &&
-	test_completion "git add " "new" &&
+	test_completion "git add " "new " &&
 
 	git add new &&
 	git commit -a -m new &&
@@ -368,22 +368,22 @@ test_expect_success 'complete files' '
 
 	git mv new modified &&
 	echo modify > modified &&
-	test_completion "git add " "modified" &&
+	test_completion "git add " "modified " &&
 
 	touch untracked &&
 
 	: TODO .gitignore should not be here &&
 	test_completion "git rm " <<-\EOF &&
-	.gitignore
-	modified
+	.gitignore Z
+	modified Z
 	EOF
 
-	test_completion "git clean " "untracked" &&
+	test_completion "git clean " "untracked " &&
 
 	: TODO .gitignore should not be here &&
 	test_completion "git mv " <<-\EOF &&
-	.gitignore
-	modified
+	.gitignore Z
+	modified Z
 	EOF
 
 	mkdir dir &&
@@ -395,20 +395,20 @@ test_expect_success 'complete files' '
 
 	: TODO .gitignore should not be here &&
 	test_completion "git mv modified " <<-\EOF &&
-	.gitignore
+	.gitignore Z
 	dir/
-	modified
-	untracked
+	modified Z
+	untracked Z
 	untracked-dir/
 	EOF
 
-	test_completion "git commit " "modified" &&
+	test_completion "git commit " "modified " &&
 
 	: TODO .gitignore should not be here &&
 	test_completion "git ls-files " <<-\EOF
-	.gitignore
+	.gitignore Z
 	dir/
-	modified
+	modified Z
 	EOF
 
 	touch momified &&
-- 
1.8.2.1.1031.g2ee5873
