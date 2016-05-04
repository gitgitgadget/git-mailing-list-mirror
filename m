From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH] config: consistently format $variables in monospaced font
Date: Wed,  4 May 2016 12:24:48 -0700
Message-ID: <1462389888-61447-1-git-send-email-computersforpeace@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 21:25:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay2Pt-0008OO-Ap
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 21:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbcEDTY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 15:24:57 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35271 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbcEDTY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 15:24:56 -0400
Received: by mail-pf0-f182.google.com with SMTP id 77so28412215pfv.2
        for <git@vger.kernel.org>; Wed, 04 May 2016 12:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dxLfMTkdo5UrCQDp7ElUENwTf+/A0fkfjX8NAjwd6RQ=;
        b=CdHWEkkvperD2AIzgOZrEKFR9wibN8Jqhy4WIJ1Fvkt6ChuB02mDSuNmsZXoUTloMh
         9B4RTRXHhI+d2X0ZMAOka6ZKe1GDKPPDYRuKhk06pVdxCnCiTyl6uO4zcIG+xvcP4uZx
         LxCTP5k7M9KCyxSERzwsJN64Yd8zXGX0EvEM1PMKT1SGeRMnhS6l0Io5wuZdRY7VzX/y
         7gUyNVVQj5IhRRiha2WidJjBpaPJKdhIhs0nM99oDh3M3JyuYlKTHXGrBxjlKiWgEw+0
         kMCK9El4dKQnmrFZCDUzZl22hMGFQ8Stb+iB56BXKl/5mlFJAJQ5j0dqcMOR7yrfMfrQ
         uz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dxLfMTkdo5UrCQDp7ElUENwTf+/A0fkfjX8NAjwd6RQ=;
        b=I9y7w9+fnR1aqIoRwvwHZ1rxawB/gI9qfTofiFjfzL4wSjJnL3NlVOXZq/uPekuoq0
         o/zXQ48O9LLR0rfT1WiRqEUXAqkDXoCyn0FVpsHGJMG89kA51VmFlYcPM5SR0lj3z/cQ
         S8mz40VXvF0e9gSnRhtzSx6kIJ39EKgFr2fk4hk/E5boSL8Tf5cnLS8NyZXufi3t323u
         BPHqMT0mtXvUI4PwpzvaRO7LPBrgjy/ZAruwx3kwO91Bb8olJi8NedHOFptKpUeyBWN7
         Knpt21qUEiE1EUqANzMdw85xHxMmEOGL1QS8rQIJGwKIK11B0xII+28+Ynbu1yjn0GCI
         yIMA==
X-Gm-Message-State: AOPr4FUfNIKUnF37WDHkTi8gBi5gWKWRglCaKS0ZcnJJRNfYhiqvrBWkaH7K39MYXXNaTA==
X-Received: by 10.98.64.79 with SMTP id n76mr14498207pfa.149.1462389896043;
        Wed, 04 May 2016 12:24:56 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([172.22.64.120])
        by smtp.gmail.com with ESMTPSA id bk8sm7964840pac.3.2016.05.04.12.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 May 2016 12:24:55 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293573>

We don't consistently use `backticks` for formatting shell variables.
This patch improves the consistency on shell variables (and a few nearby
mentions of "gpg" commands), though it still doesn't straighten out the
use of "quotes."

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 Documentation/config.txt | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4c3cd7621ad0..b8de1e98b82d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -117,7 +117,7 @@ Example
 	[include]
 		path = /path/to/foo.inc ; include by absolute path
 		path = foo ; expand "foo" relative to the current file
-		path = ~/foo ; expand "foo" in your $HOME directory
+		path = ~/foo ; expand "foo" in your `$HOME` directory
 
 
 Values
@@ -496,10 +496,10 @@ repository's usual working tree).
 
 core.logAllRefUpdates::
 	Enable the reflog. Updates to a ref <ref> is logged to the file
-	"$GIT_DIR/logs/<ref>", by appending the new and old
+	"`$GIT_DIR/logs/<ref>`", by appending the new and old
 	SHA-1, the date/time and the reason of the update, but
 	only when the file exists.  If this configuration
-	variable is set to true, missing "$GIT_DIR/logs/<ref>"
+	variable is set to true, missing "`$GIT_DIR/logs/<ref>`"
 	file is automatically created for branch heads (i.e. under
 	refs/heads/), remote refs (i.e. under refs/remotes/),
 	note refs (i.e. under refs/notes/), and the symbolic ref HEAD.
@@ -606,8 +606,8 @@ core.excludesFile::
 	Specifies the pathname to the file that contains patterns to
 	describe paths that are not meant to be tracked, in addition
 	to '.gitignore' (per-directory) and '.git/info/exclude'.
-	Defaults to $XDG_CONFIG_HOME/git/ignore.
-	If $XDG_CONFIG_HOME is either not set or empty, $HOME/.config/git/ignore
+	Defaults to `$XDG_CONFIG_HOME/git/ignore`.
+	If `$XDG_CONFIG_HOME` is either not set or empty, `$HOME/.config/git/ignore`
 	is used instead. See linkgit:gitignore[5].
 
 core.askPass::
@@ -624,8 +624,8 @@ core.attributesFile::
 	'.git/info/attributes', Git looks into this file for attributes
 	(see linkgit:gitattributes[5]). Path expansions are made the same
 	way as for `core.excludesFile`. Its default value is
-	$XDG_CONFIG_HOME/git/attributes. If $XDG_CONFIG_HOME is either not
-	set or empty, $HOME/.config/git/attributes is used instead.
+	`$XDG_CONFIG_HOME/git/attributes`. If `$XDG_CONFIG_HOME` is either not
+	set or empty, `$HOME/.config/git/attributes` is used instead.
 
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
@@ -1343,7 +1343,7 @@ gc.worktreePruneExpire::
 	'git worktree prune --expire 3.months.ago'.
 	This config variable can be used to set a different grace
 	period. The value "now" may be used to disable the grace
-	period and prune $GIT_DIR/worktrees immediately, or "never"
+	period and prune `$GIT_DIR/worktrees` immediately, or "never"
 	may be used to suppress pruning.
 
 gc.reflogExpire::
@@ -1483,13 +1483,13 @@ grep.fallbackToNoIndex::
 	is executed outside of a git repository.  Defaults to false.
 
 gpg.program::
-	Use this custom program instead of "gpg" found on $PATH when
+	Use this custom program instead of "`gpg`" found on `$PATH` when
 	making or verifying a PGP signature. The program must support the
 	same command-line interface as GPG, namely, to verify a detached
-	signature, "gpg --verify $file - <$signature" is run, and the
+	signature, "`gpg --verify $file - <$signature`" is run, and the
 	program is expected to signal a good signature by exiting with
 	code 0, and to generate an ASCII-armored detached signature, the
-	standard input of "gpg -bsau $key" is fed with the contents to be
+	standard input of "`gpg -bsau $key`" is fed with the contents to be
 	signed, and the program is expected to send the result to its
 	standard output.
 
-- 
2.8.0.rc3.226.g39d4020
