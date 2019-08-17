Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7FEB1F45A
	for <e@80x24.org>; Sat, 17 Aug 2019 00:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfHQAjx (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 20:39:53 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:55299 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfHQAjx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 20:39:53 -0400
Received: by mail-pf1-f201.google.com with SMTP id 22so4856744pfn.22
        for <git@vger.kernel.org>; Fri, 16 Aug 2019 17:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EMGuv5vGKRN5gs3H9Qrv3ByCxwQ42Q+GhuS+KBx5uMY=;
        b=mLPnOJOiD9EbwS+EmBte3V4IwNtaxTq0mhAAtasYJqeF5fHzeOcfQ0oylqKBJot4Rp
         2eYWNlEfOi5JtXxwlZD6rZbQnoiobGeh22wwXybGrwtDFUjXnRf0M7O3L+jZe49w9d2B
         OI+64+HGlHvCtOWb1Vyn2N1Y2woczgBh2FkREqUx/LFLDUZfxWhlDSaRJHqLXIZVmK7y
         G+06oUX0aV/TkXyEgVEUKZGLx3tOg4H7giErqjuEhAno7RRY2DltacBOSNZ4nEn3e33G
         NuG6u5wmpxOhDqN33ufTHTRclt7O+1xXUEfMKEJEfiEeCCrcMzWxMDwLuSOfXSk2Vf56
         cDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EMGuv5vGKRN5gs3H9Qrv3ByCxwQ42Q+GhuS+KBx5uMY=;
        b=Va3XoLGJf5qppmfBVjtJBPVNtY5n7CwfR1rUIogrQAqCXb6zDFqSBraRGYiLU26iVz
         YgKOmu1m15xixFWCy9n2a5Uo9f6QJWS3rh83WvA3aVKK7Iw3sUzApM/41gtA6ohsXaGZ
         pp0lh9AWmksHFLcH+snmYYSauxsk2O+Tc2H2HBJMnPbDfUNOI8oTMHxAdnfDysnUOzpE
         wfkVa9Coj4ES6DEK39E2c+MKy6YbiVA1JWHxp14Rzm5M+MydRhqthKnjzCVF4xC1cCzm
         HD5H0IdGXIoHAFA5BZcA6BjEf47KiEykYXcTLbuX3vdtwx+RZs9etCTvImquk2k7uaIX
         i8WA==
X-Gm-Message-State: APjAAAV5WQk+kbgcuejZvwhAEhbBb7xjqicjSv1VXUwxKsW/00ILfv6N
        n4lTMGDTS+qTJlbcQ6Bn5oTR6+10cEFhFvpVtGYgMILhvP7Mytl0wzJgFzrAxS4Pf8ROJph0mLC
        4mG2uv4G02tb9BPmDSn9G37BR9CaTWFQkmpWzr1Ey1vP1qlsE0TkmrqIkxQx/s31pJlXOAYKw1g
        ==
X-Google-Smtp-Source: APXvYqzf5qUdfKU8hERYMI174D/FGdZ5U7JOkEIvxipCXcFg/d6Y8dawob+2lYYjoqtqsc+7RcIObcRjSJ4hFwT0QYk=
X-Received: by 2002:a65:64c6:: with SMTP id t6mr10185298pgv.323.1566002392136;
 Fri, 16 Aug 2019 17:39:52 -0700 (PDT)
Date:   Fri, 16 Aug 2019 17:39:25 -0700
In-Reply-To: <20190817003926.102944-1-emilyshaffer@google.com>
Message-Id: <20190817003926.102944-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190817003926.102944-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v2 1/2] bugreport: add tool to generate debugging info
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make it easier for users who encounter a bug to send a report by
collecting some state information, intended to be viewed by humans
familiar with Git.

Teach Git how to prompt the user for a good bug report: reproduction
steps, expected behavior, and actual behavior. Also, teach Git to write
down its own version, the version of some of its dependencies, the
operating system information, select entries from the gitconfig, the
configured hooks, and the contents of $GIT_DIR/logs. Finally, make sure
Git asks the user to review the contents of the report after it's
generated.

If users can send us a well-written bug report which contains diagnostic
information we would otherwise need to ask the user for, we can reduce
the number of question-and-answer round trips between the reporter and
the Git contributor.

Users may also wish to send a report like this to their local "Git
expert" if they have put their repository into a state they are confused
by.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 .gitignore                      |   1 +
 Documentation/git-bugreport.txt |  51 ++++++++++++
 Makefile                        |   1 +
 command-list.txt                |   1 +
 git-bugreport-config-whitelist  |  22 +++++
 git-bugreport.sh                | 139 ++++++++++++++++++++++++++++++++
 git-sh-setup.sh                 |   2 +
 t/t0091-bugreport.sh            |  25 ++++++
 8 files changed, 242 insertions(+)
 create mode 100644 Documentation/git-bugreport.txt
 create mode 100644 git-bugreport-config-whitelist
 create mode 100755 git-bugreport.sh
 create mode 100755 t/t0091-bugreport.sh

diff --git a/.gitignore b/.gitignore
index 521d8f4fb4..b4f5433084 100644
--- a/.gitignore
+++ b/.gitignore
@@ -25,6 +25,7 @@
 /git-bisect--helper
 /git-blame
 /git-branch
+/git-bugreport
 /git-bundle
 /git-cat-file
 /git-check-attr
diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
new file mode 100644
index 0000000000..2fc0a63192
--- /dev/null
+++ b/Documentation/git-bugreport.txt
@@ -0,0 +1,51 @@
+git-bugreport(1)
+================
+
+NAME
+----
+git-bugreport - Collect information for user to file a bug report
+
+SYNOPSIS
+--------
+[verse]
+'git bugreport' [-o | --output <path>]
+
+DESCRIPTION
+-----------
+Captures information about the user's machine, Git client, and repository state,
+as well as a form requesting information about the behavior the user observed,
+into a single text file which the user can then share, for example to the Git
+mailing list, in order to report an observed bug.
+
+The following information is requested from the user:
+
+ - Reproduction steps
+ - Expected behavior
+ - Actual behavior
+ - Difference between expected and actual behavior
+
+The following information is captured automatically:
+
+ - Git version (`git version --build-options`)
+ - Machine information (`uname -a`)
+ - Versions of various dependencies (curl, ldd)
+ - Relevant user environment variables ($SHELL)
+ - Some Git config variables, filtered by a whitelist
+   (`git config --show-origin --get`)
+ - A list of all configured git-hooks in `.git/hooks/` (but not their contents)
+ - A list of all loose objects in `.git/objects/`
+ - A list of all packs in `.git/objects/pack`
+ - A list of all object info in `.git/objects/info`
+ - The contents of the alternates file (`.git/objects/info/alternates`)
+ - The contents of `.git/logs`
+
+OPTIONS
+-------
+-o [<path>]::
+--output [<path>]::
+	Place the resulting bug report file in <path> instead of the root of the
+	Git repository.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index f9255344ae..69801a1c45 100644
--- a/Makefile
+++ b/Makefile
@@ -606,6 +606,7 @@ TEST_PROGRAMS_NEED_X =
 unexport CDPATH
 
 SCRIPT_SH += git-bisect.sh
+SCRIPT_SH += git-bugreport.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-merge-octopus.sh
diff --git a/command-list.txt b/command-list.txt
index a9ac72bef4..be5a605047 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -54,6 +54,7 @@ git-archive                             mainporcelain
 git-bisect                              mainporcelain           info
 git-blame                               ancillaryinterrogators          complete
 git-branch                              mainporcelain           history
+git-bugreport                           ancillaryinterrogators
 git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
 git-check-attr                          purehelpers
diff --git a/git-bugreport-config-whitelist b/git-bugreport-config-whitelist
new file mode 100644
index 0000000000..e4f07f7175
--- /dev/null
+++ b/git-bugreport-config-whitelist
@@ -0,0 +1,22 @@
+http.version
+protocol.version
+protocol.persistent-https.allow
+protocol.rpc.allow
+protocol.sso.allow
+submodule.repolike
+trace2.eventtarget
+trace2.configparams
+color.ui
+core.pager
+sendemail.smtpencryption
+sendemail.smtpserver
+sendemail.smtpserverport
+sendemail.smtpsslcertpath
+credential.helper
+merge.tool
+grep.linenumber
+rerere.enabled
+core.repositoryformatversion
+core.filemode
+core.bare
+core.logallrefupdates
diff --git a/git-bugreport.sh b/git-bugreport.sh
new file mode 100755
index 0000000000..0c182c62e9
--- /dev/null
+++ b/git-bugreport.sh
@@ -0,0 +1,139 @@
+#!/bin/sh
+
+print_file_if_exists () {
+	if [ -f "$1" ]
+	then
+		if $(file --mime "$1" | grep -q "charset=binary")
+		then
+			echo "<binary file>"
+		else
+			cat "$1"
+		fi
+	else
+		echo "<file does not exist>"
+	fi
+}
+
+
+print_filenames_and_content () {
+	while read -r line
+	do
+		echo "$line"
+		echo "========"
+		print_file_if_exists "$line"
+		echo
+	done
+}
+
+command_and_output () {
+	echo "$@:"
+	"$@"
+	echo
+}
+
+generate_report_text() {
+
+	# Generate a form for the user to fill out with their issue.
+	gettextln "Thank you for filling out a Git bug report!"
+	gettextln "Please answer the following questions to help us understand your issue."
+	echo
+	gettextln "What did you do before the bug happened? (Steps to reproduce your issue)"
+	echo
+	gettextln "What did you expect to happen? (Expected behavior)"
+	echo
+	gettextln "What happened instead? (Actual behavior)"
+	echo
+	gettextln "What's different between what you expected and what actually happened?"
+	echo
+	gettextln "Anything else you want to add:"
+	echo
+	gettextln "Please review the rest of the bug report below."
+	gettextln "You can delete any lines you don't wish to send."
+	gettextln \
+"When you're done, you should include the contents of this file in your bug \n\
+report, for example by pasting it into an email to git@vger.kernel.org."
+	echo
+
+	# Versions of various necessary software should go here.
+	echo "[Version Information]"
+	command_and_output git version --build-options
+	command_and_output uname -a
+	command_and_output curl-config --version
+	command_and_output ldd --version
+	echo
+
+	# Values of environment variables we find useful should go here.
+	echo "[Environment Information]"
+	command_and_output echo $SHELL
+
+	echo "[Git Config]"
+	xargs -n 1 -I% sh -c 'echo %: $(git config --show-origin --get %)' \
+		<"$(git --exec-path)/git-bugreport-config-whitelist"
+	echo
+
+	echo "[Configured Hooks]"
+	find "$GIT_HOOKS_DIRECTORY" -type f | grep -v "\.sample$"
+	echo
+
+	echo "[Loose Objects]"
+	for objdir in $(find "$GIT_OBJECT_DIRECTORY"/?? -type d);
+	do
+		echo "$objdir: $(ls $objdir | wc -l) objects"
+	done
+	echo
+	
+	echo "[Pack Data]"
+	command_and_output ls -l "$GIT_OBJECT_DIRECTORY/pack"
+	echo
+	
+	echo "[Object Info Data]"
+	command_and_output ls -lR "$GIT_OBJECT_DIRECTORY/info"
+	echo
+	
+	echo "[Alternates File]"
+        echo "$GIT_OBJECT_DIRECTORY/info/alternates" | print_filenames_and_content
+	echo
+
+	# This command is the reflog; it's fairly chatty and hard to scan
+	# quickly, so leave it at the bottom so that users don't miss what
+	# happens before it.
+	echo "[Git Logs]"
+	find "$GIT_LOGS_DIRECTORY" -type f | print_filenames_and_content
+	echo
+}
+
+USAGE="[-o | --output <path>]"
+
+SUBDIRECTORY_OK=t
+OPTIONS_SPEC=
+. git-sh-setup
+. git-sh-i18n
+
+basedir="$PWD"
+while :
+do
+	case "$1" in
+	-o|--output)
+		shift
+		basedir="$1"
+		shift
+		continue
+		;;
+	"")
+		break
+		;;
+	*)
+		usage
+		;;
+	esac
+done
+
+
+# Create bugreport file
+BUGREPORT_FILE="$basedir/git-bugreport-$(whoami)-$(hostname)-$(date +%Y%m%d-%H%M)"
+
+generate_report_text >$BUGREPORT_FILE
+
+git_editor $BUGREPORT_FILE
+
+eval_gettextln "Your new bug report is in \$BUGREPORT_FILE."
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 10d9764185..1db8af0d76 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -379,6 +379,8 @@ git_dir_init () {
 		exit 1
 	}
 	: "${GIT_OBJECT_DIRECTORY="$(git rev-parse --git-path objects)"}"
+        : "${GIT_LOGS_DIRECTORY="$(git rev-parse --git-path logs)"}"
+        : "${GIT_HOOKS_DIRECTORY="$(git rev-parse --git-path hooks)"}"
 }
 
 if test -z "$NONGIT_OK"
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
new file mode 100755
index 0000000000..e4e2d1a927
--- /dev/null
+++ b/t/t0091-bugreport.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+test_description='git bugreport'
+
+. ./test-lib.sh
+
+test_expect_success 'creates a report without crashing' '
+	git bugreport &&
+	rm git-bugreport-*
+'
+
+test_expect_success '--output puts the report in the provided dir' '
+	mkdir foo/ &&
+	git bugreport -o foo/ &&
+	test -f foo/git-bugreport-* &&
+	rm -fr foo/
+'
+
+test_expect_success 'incorrect arguments abort with usage' '
+	test_must_fail git bugreport --false 2>output &&
+	grep usage output &&
+	test ! -f git-bugreport-*
+'
+
+test_done
-- 
2.23.0.rc1.153.gdeed80330f-goog

