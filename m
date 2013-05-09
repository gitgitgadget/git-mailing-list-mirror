From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v8 12/12] git-clean: update document for interactive git-clean
Date: Fri, 10 May 2013 01:14:16 +0800
Message-ID: <29373d346dd31a2c73b582fb3291667df6105b9c.1368118918.git.worldhello.net@gmail.com>
References: <cover.1368118918.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 09 19:15:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaURD-0003Tw-Sg
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 19:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378Ab3EIRPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 13:15:22 -0400
Received: from mail-da0-f49.google.com ([209.85.210.49]:40179 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab3EIRPU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 13:15:20 -0400
Received: by mail-da0-f49.google.com with SMTP id p5so1719540dak.36
        for <git@vger.kernel.org>; Thu, 09 May 2013 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=gMSB+KF1STDpXu6gk+LGUufNHJStfqOFC+zX1D7x1eg=;
        b=ch2S9u2ISbT5x3DWaDKFrE84W1lzdA5aKpyGSUNpvpvfuHZg6KbYerj3MqES7GxF6j
         YvYQMYTx4fj+Wa+guKbhpZE7NzXKn8tIz2/oHk2X78JaHSXIKHaqYFNG6mdjm8aGiGTr
         7VQ9vQt8SgnzN9hIF8aSScRmYU3ogLmLvkAlLdzyVzN7pNUg7chnICyXt+R4CM+6oo3g
         0o/m2YmsDxRri+ucaxC9rmygMGsQkZH/bnfaR3E1tzibvUaDGdG3NtIQmLnLxnQ7jBna
         613N8nr8G/df3buSosh8quCTIXG33fWgh3QWM9cHQORRCYpfSlmqZ9rIDgqv5oboAdwb
         HDDQ==
X-Received: by 10.68.52.39 with SMTP id q7mr13579382pbo.92.1368119720462;
        Thu, 09 May 2013 10:15:20 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id pa2sm4407182pac.9.2013.05.09.10.15.16
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 May 2013 10:15:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g24a8a0f
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
References: <CANYiYbEvYXiRE0OeR5vqBAaOFFpJTPBetQbawZD5EcMCj8veFw@mail.gmail.com> <cover.1368118918.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223761>

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-clean.txt | 71 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 186e34..4512f7 100644
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
@@ -69,6 +69,73 @@ OPTIONS
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
+      1: clean         2: filter by pattern     3: select by numbers
+      4. ask each      5. toggle flags: none    6. quit
+      7: help
+    What now> 2
+------------
+
+You also could say `c` or `clean` above as long as the choice is unique.
+
+The main command loop has 7 subcommands.
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
+toggle flags::
+
+  This lets you change the flags for git-clean, such as -x/-X/-d/-ff,
+  and refresh the cleaning candidates list automatically.
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
1.8.3.rc1.341.g24a8a0f
