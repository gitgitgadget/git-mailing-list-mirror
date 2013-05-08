From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v7 07/10] git-clean: update document for interactive git-clean
Date: Wed,  8 May 2013 19:38:52 +0800
Message-ID: <187bf672e3795601f929f15b102746e5083471c5.1368011946.git.worldhello.net@gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
 <ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
 <6a7931a0bb14f8c71479e16175812bedb6b826cb.1368011946.git.worldhello.net@gmail.com>
 <d7302adabb4269dd94698090fb20c739f723f00a.1368011946.git.worldhello.net@gmail.com>
 <e7cf5d7ffd83e238078b4585ac4bef4ec9a48e21.1368011946.git.worldhello.net@gmail.com>
 <ae69a75fa1bbad9827ef3891a33c3bfa6685d914.1368011946.git.worldhello.net@gmail.com>
 <95c019e293fcea899e5e227c35338f696f99525f.1368011946.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 08 13:39:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua2il-0001Lx-NE
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 13:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582Ab3EHLjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 07:39:35 -0400
Received: from mail-da0-f44.google.com ([209.85.210.44]:38372 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808Ab3EHLje (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 07:39:34 -0400
Received: by mail-da0-f44.google.com with SMTP id z8so935840daj.31
        for <git@vger.kernel.org>; Wed, 08 May 2013 04:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=63UlMGWE3jFs4SuO4zIqstzorOGh9kk2qmlFgj8waYk=;
        b=TfW4Cu8XBN7vm5zxkyvWgkzfS2JELjRPU8epqzeZexo9h2wH16j+rO3rsL5C7r/EaJ
         8rsR2eCz4pHYg7RXT10sCdQzo/5zHjEae3RbUq64lZXCXrTu2C24GlxU19dfvVYkoCWg
         En9B8JwzS7NeL5aQXjruAj7SrWsSJrI9xxAkRJtFQUHNp/uzWAcNU5P+uNzrVjzdJKLt
         v5W81PSGJ0gF/nP/+ysym4ly+H+Sd5ruDcXhidk2o2mzERRrTPSekjjb/UtThTnvIlZN
         V3ZfudFFb0GW0vjpNeyv1sx5ixiS29i1IaBWBsGK1idPCAQaDJOIa70BU4wxPn3Dq69j
         NqTg==
X-Received: by 10.68.196.1 with SMTP id ii1mr7096657pbc.200.1368013173221;
        Wed, 08 May 2013 04:39:33 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id gc5sm32287860pbb.19.2013.05.08.04.39.29
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 04:39:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g1c24ab7
In-Reply-To: <95c019e293fcea899e5e227c35338f696f99525f.1368011946.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368011946.git.worldhello.net@gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223664>

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 Documentation/git-clean.txt | 70 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index f5572..47e8e 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -39,13 +39,8 @@ OPTIONS
 
 -i::
 --interactive::
-	Show what would be done and the user must confirm before actually
-	cleaning. In the confirmation dialog, the user can choose to abort
-	the cleaning, or enter into an edit mode. In the edit mode, the
-	user can input space-separated patterns (the same syntax as
-	gitignore), and each clean candidate that matches with one of the
-	patterns will be excluded from cleaning. When the user feels it's
-	OK, presses ENTER and back to the confirmation dialog.
+	Show what would be done and clean files interactively. See
+	``Interactive mode'' for details.
 
 -n::
 --dry-run::
@@ -74,6 +69,67 @@ OPTIONS
 	Remove only files ignored by Git.  This may be useful to rebuild
 	everything from scratch, but keep manually created files.
 
+Interactive mode
+----------------
+When the command enters the interactive mode, it shows the
+files and directories to be cleaned, and goes into its
+interactive command loop.
+
+The command loop shows the list of subcommands available, and
+gives a prompt "What now> ".  In general, when the prompt ends
+with a single '>', you can pick only one of the choices given
+and type return, like this:
+
+------------
+    *** Commands ***
+      1: clean             2: edit by patterns   3: edit by numbers
+      4. rm -i             5. quit               6. help
+    What now> 2
+------------
+
+You also could say `c` or `clean` above as long as the choice is unique.
+
+The main command loop has 6 subcommands.
+
+clean::
+
+   Start cleaning files and directories, and then quit.
+
+edit by patterns::
+
+   This shows the files and directories to be deleted and issues an
+   "Input ignore patterns>>" prompt. You can input a space-seperated
+   patterns to exclude files and directories from deletion.
+   E.g. "*.c *.h" will excludes files end with ".c" and ".h" from
+   deletion. When you are satisfied with the filtered result, press
+   ENTER (empty) back to the main menu.
+
+edit by numbers::
+
+   This shows the files and directories to be deleted and issues an
+   "Select items to delete>>" prompt. When the prompt ends with double
+   '>>' like this, you can make more than one selection, concatenated
+   with whitespace or comma.  Also you can say ranges.  E.g. "2-5 7,9"
+   to choose 2,3,4,5,7,9 from the list.  If the second number in a
+   range is omitted, all remaining patches are taken.  E.g. "7-" to
+   choose 7,8,9 from the list.  You can say '*' to choose everything.
+   Also when you are satisfied with the filtered result, press ENTER
+   (empty) back to the main menu.
+
+rm -i::
+
+  This will show a "rm -i" style cleaning, that you must confirm one
+  by one in order to delete items. This action is not as efficient
+  as the above two actions.
+
+quit::
+
+  This lets you quit without do cleaning.
+
+help::
+
+  Show brief usage of interactive git-clean.
+
 SEE ALSO
 --------
 linkgit:gitignore[5]
-- 
1.8.3.rc1.341.g1c24ab7
