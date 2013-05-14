From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v9 9/9] git-clean: add documentation for interactive git-clean
Date: Tue, 14 May 2013 16:45:23 +0800
Message-ID: <d85f9305d99bcdccbd54421de88c95d625c38f57.1368518327.git.worldhello.net@gmail.com>
References: <cover.1368518327.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 14 10:46:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcAsZ-0003DI-N0
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 10:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756993Ab3ENIqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 04:46:24 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34334 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756730Ab3ENIqT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 04:46:19 -0400
Received: by mail-pd0-f174.google.com with SMTP id u10so240942pdi.19
        for <git@vger.kernel.org>; Tue, 14 May 2013 01:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=5suxUgJgbJWQzosQDWEv2cRnAaPM252Rz8UGNisqKuk=;
        b=epwAK/+pRrTEyuqimQjF4e8pOGxWdMMvFdWqDORmZo0YeUKutxEOHK0FslPUo/BwIk
         0jRipErlZ1vikWXRbDdL5iTLQYJBH+TCCYsx5ZGnQKF7MexueV1EB3ZsTPwT+WSFc5YN
         QqDu00Kq2fwXJSsuZwvJ43VWi45WNDe7T5OPa8fREHR8HZk015uYm9cpsTHimsqZjAEq
         xuXdUjgXcmR6N6YrSTkwwocRfrW6Z5VjXTkOOLFRnHrPCc23pKl+GmnwyZBT+fgoSQBj
         uS1/CfVi2KG8MioPb2xw+COc4V3zaIehihHlgTZLaJwJ19SbNrxExaNCmzG0hEur/O6K
         YP7w==
X-Received: by 10.66.158.36 with SMTP id wr4mr33271437pab.28.1368521179070;
        Tue, 14 May 2013 01:46:19 -0700 (PDT)
Received: from localhost.localdomain ([114.248.141.128])
        by mx.google.com with ESMTPSA id wt5sm17356069pbc.38.2013.05.14.01.46.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 14 May 2013 01:46:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.401.gfc9adf8
In-Reply-To: <cover.1368518327.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368518327.git.worldhello.net@gmail.com>
References: <cover.1368518327.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224290>

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
1.8.3.rc1.404.gb9fcf3e
