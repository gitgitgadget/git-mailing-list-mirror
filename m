From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v11 14/15] git-clean: add documentation for interactive git-clean
Date: Fri, 17 May 2013 17:20:18 +0800
Message-ID: <93c7a63d4c34b7649e01ae4d69e82dbd322eaceb.1368782129.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 17 11:21:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdGqj-0006aN-CE
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 11:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640Ab3EQJVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 05:21:10 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:50165 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337Ab3EQJVG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 05:21:06 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so2062013pbb.24
        for <git@vger.kernel.org>; Fri, 17 May 2013 02:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=CVwG3wB/mwvAd3ZDyaSyon8Y+2yPH6SNVmFhXMinBso=;
        b=PtFkwI55meH4WOkMzjPM5GHzlytIYe3yhk0MMzDtfUexdxG7LpGeBfsneN91QSdjLi
         tZv6PZ/L51J/2uo1IzvEXIgK5j5UMA5IlB0XbMEcFdXn990vJ1FOmdzZXQa9NpNEYIt8
         6obGscvDL8zlZ61Of7paUoG5my0pGo909RWeQjFJQaZYGQl1jHQvCbqZU2AyhDS8V27A
         Fkjku3b1d3AP6n0yKmf6QuHiX8wVquDcc4sYW1kFN6YhzyKKUxdHFQ/HBsXpROfVUqG+
         0/JdsN4rVjOwxomj+0SN0/BrsW/zwf/xCoE3GKIvc3JPZtj6+QlkcpBXM74xE9vd7VT7
         D1Ww==
X-Received: by 10.68.114.100 with SMTP id jf4mr46878447pbb.144.1368782465417;
        Fri, 17 May 2013 02:21:05 -0700 (PDT)
Received: from localhost.localdomain ([114.248.153.37])
        by mx.google.com with ESMTPSA id 10sm10531002pbm.0.2013.05.17.02.21.03
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 02:21:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.380.g956c2b2
In-Reply-To: <cover.1368782129.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368782129.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224678>

Add new section "Interactive mode" for documentation of interactive
git-clean.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-clean.txt | 65 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 186e34..5bf76 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -39,8 +39,8 @@ OPTIONS
 
 -i::
 --interactive::
-	Show what would be done and the user must confirm before actually
-	cleaning.
+	Show what would be done and clean files interactively. See
+	``Interactive mode'' for details.
 
 -n::
 --dry-run::
@@ -69,6 +69,67 @@ OPTIONS
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
+        1: clean                2: filter by pattern    3: select by numbers
+        4: ask each             5: quit                 6: help
+    What now> 1
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
+filter by pattern::
+
+   This shows the files and directories to be deleted and issues an
+   "Input ignore patterns>>" prompt. You can input space-seperated
+   patterns to exclude files and directories from deletion.
+   E.g. "*.c *.h" will excludes files end with ".c" and ".h" from
+   deletion. When you are satisfied with the filtered result, press
+   ENTER (empty) back to the main menu.
+
+select by numbers::
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
+ask each::
+
+  This will start to clean, and you must confirm one by one in order
+  to delete items. Please note that this action is not as efficient
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
1.8.3.rc2.380.g956c2b2
