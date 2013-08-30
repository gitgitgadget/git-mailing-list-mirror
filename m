From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/6] pull: trivial cleanup
Date: Fri, 30 Aug 2013 16:56:50 -0500
Message-ID: <1377899810-1818-7-git-send-email-felipe.contreras@gmail.com>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 00:01:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFWlP-00075N-AC
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 00:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212Ab3H3WBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 18:01:45 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:39210 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756125Ab3H3WBn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 18:01:43 -0400
Received: by mail-oa0-f46.google.com with SMTP id o20so2972187oag.19
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 15:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nj33u1jU9rS/8FuzudZWHc+3CjpsIiMuGk3fjHzl3tw=;
        b=W6nAwfuFJwEXtrfpKVZSDuXEMNmHGMrtjIbCnEg38Nvboofmon4/e7u089zsAqPKZA
         N97Hp/L79oa8NPTj0vV4bmwTrxZaIODZO4AXBw+d8Q8/uE6vQHjIQ3qNld+s2OUvr1bo
         841PLSQhgIt8jSMklb7wmd9ZfWW4xza6AT5oDkFw1zs4etS+L/4GPj2rq4AamTtbm3XP
         AZboQtmtp8H2EQh4rkmSd0KfRCcz55MrlS0gA0hgxZ+DgR0roKdfW+6S6/aa+MAhhd0h
         LELpWBmrxHpX+kHvDFNeXqGplPbNoGeU/LvU95G0cXxXlcyz1zWVzDgKTKwxziEetnck
         C0nA==
X-Received: by 10.60.145.241 with SMTP id sx17mr3621915oeb.57.1377900103191;
        Fri, 30 Aug 2013 15:01:43 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u3sm127290oeq.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 15:01:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233476>

There's no need to remove 'refs/heads/' yet again.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-pull.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index f0df41c..3bdcbfd 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -166,7 +166,6 @@ error_on_no_merge_candidates () {
 		op_prep=with
 	fi
 
-	curr_branch=${curr_branch#refs/heads/}
 	upstream=$(git config "branch.$curr_branch.merge")
 	remote=$(git config "branch.$curr_branch.remote")
 
@@ -183,7 +182,7 @@ error_on_no_merge_candidates () {
 		echo "You asked to pull from the remote '$1', but did not specify"
 		echo "a branch. Because this is not the default configured remote"
 		echo "for your current branch, you must specify a branch on the command line."
-	elif [ -z "$curr_branch" -o -z "$upstream" ]; then
+	elif [ -z "$curr_branch_short" -o -z "$upstream" ]; then
 		. git-parse-remote
 		error_on_missing_default_upstream "pull" $op_type $op_prep \
 			"git pull <remote> <branch>"
-- 
1.8.4-fc
