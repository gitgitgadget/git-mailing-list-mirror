From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 2/3] pull: trivial cleanups
Date: Wed, 15 May 2013 22:43:47 -0500
Message-ID: <1368675828-27418-3-git-send-email-felipe.contreras@gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 05:45:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucp8I-0007PV-BC
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 05:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829Ab3EPDp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 23:45:28 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33935 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628Ab3EPDpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 23:45:25 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp18so2880683obc.35
        for <git@vger.kernel.org>; Wed, 15 May 2013 20:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=es1lOvptMY9yipbB7vKqoQrB4gWhAIGVz/cAyAlHqJI=;
        b=QlJ68XR1nPP7Y+jXi9PlyE18vB6wP9AdtMymnlkVBk7JdpXZFvqXa94GyX/v12E5bs
         il9IUo7CdZo5+tVWaYcZwSTByjDOCrggv2pnpOCVf2zEEsNm6WQRZ7PpDkz1o2Z7XAQt
         W15wgrXEeX9FhSfug5ruG3J/619mvc/NPcnVfl/+9RIQkOY6kW7z/ObSG54UOcFYmX46
         0sSwZpBb+ngK38Sr0UPVqkow3lEixN7qw4fzeCxma5taJw1l9Vl6ApgzGnSG8NPjEV+v
         9Udp0EqeK88lZGnQ0SgF/v2kVN1Y6oT1x5pcw/B/QZttK3MC/Jsniktt+9MVjZSOor4g
         6cUw==
X-Received: by 10.182.44.165 with SMTP id f5mr18551486obm.26.1368675924570;
        Wed, 15 May 2013 20:45:24 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id p9sm6377951oeq.7.2013.05.15.20.45.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 15 May 2013 20:45:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224473>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-pull.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 75297c7..b207df2 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -166,9 +166,7 @@ error_on_no_merge_candidates () {
 		op_prep=with
 	fi
 
-	curr_branch=${curr_branch#refs/heads/}
-	upstream=$(git config "branch.$curr_branch.merge")
-	remote=$(git config "branch.$curr_branch.remote")
+	upstream=$(git config "branch.$curr_branch_short.merge")
 
 	if [ $# -gt 1 ]; then
 		if [ "$rebase" = true ]; then
@@ -183,7 +181,7 @@ error_on_no_merge_candidates () {
 		echo "You asked to pull from the remote '$1', but did not specify"
 		echo "a branch. Because this is not the default configured remote"
 		echo "for your current branch, you must specify a branch on the command line."
-	elif [ -z "$curr_branch" -o -z "$upstream" ]; then
+	elif [ -z "$curr_branch_short" -o -z "$upstream" ]; then
 		. git-parse-remote
 		error_on_missing_default_upstream "pull" $op_type $op_prep \
 			"git pull <remote> <branch>"
-- 
1.8.3.rc1.579.g184e698
