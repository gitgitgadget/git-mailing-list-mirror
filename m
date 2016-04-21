From: XZS <d.f.fischer@web.de>
Subject: [PATCH/RFC/GSoC 2/2] add a add.patch config variable
Date: Thu, 21 Apr 2016 11:15:22 +0200
Message-ID: <e6c7aaaf26ec6b5021cc6f183f72b494fdceb330.1459946531.git.d.f.fischer@web.de>
References: <cover.1459946531.git.d.f.fischer@web.de>
Cc: XZS <d.f.fischer@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 11:16:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atAiK-0006aU-TS
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 11:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbcDUJPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 05:15:43 -0400
Received: from mout.web.de ([212.227.15.4]:51289 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752325AbcDUJPk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 05:15:40 -0400
Received: from storm.fritz.box ([95.116.240.233]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LfAro-1bUROG1RxA-00omIQ; Thu, 21 Apr 2016 11:15:32
 +0200
X-Mailer: git-send-email 2.8.0
In-Reply-To: <cover.1459946531.git.d.f.fischer@web.de>
In-Reply-To: <cover.1459946531.git.d.f.fischer@web.de>
References: <CAP8UFD0KZk1nTgR8gdbedsAuw2ztWZDWri6EkeEkf8FhwS9yag@mail.gmail.com> <cover.1459946531.git.d.f.fischer@web.de>
X-Provags-ID: V03:K0:gCgKfwrltZlbbrcREzg6WULNQbpvOo5bLYxunEdi9n16EBJbLX3
 DoiqAVssn1qe+Hj9yz5fCvtUd0D0yYfC9TD5+nWcuxDZjsXaplZP/mOz2Cof6xalHj8URfM
 xcsTwAyIBMGbQckI0zUTrlwzjL1U3xLZXLyMB8hzoFaj06BRbY7ocJfFXeikOiZuZd5OIup
 zULX7Tqf35v+m6KQv4h1w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VZDhAOUhMc0=:jQLhUpfJJRxXYdp+sWqSzt
 gkY5VkSun9X5KC5ZCpFo83vBelzyZ+UuBLuT78/w62F0parhdXh4d72TxCSmKiVhwNZeIFIA5
 hVCZ4+GGx+w8S8fXatTzRDcyjbugGt0xCjNha59Hig/osqJ/D4zuMdpXwyrlffHw9N2aheGhU
 Ktkc0LJkpNTb64Jd98gan91GgEJsUxHKPWRzfokfrpiRYG0ZpwDSRAM/AijJQa3FntpHNzCG1
 6s/Te9LaqnLYDZORVww3bvYToSlqTmd+Oq5QT0nVAURAvSgbWAp5HpLR+gwIKN+IxhvKlNudX
 P2RL4ClHdKJ3n7QVhv7JLuKlBY0Tvou1t3wrm/5nmmFj81xsgLR4Na9qCpN+UgTWgHOL4pT72
 Ta/y0ig/3cQAT2nf6xk1CnWx4UkwKMbv1u0c2rcpmmbke4moQXbTDCFpSPMT0Q4ccsmQdNWmI
 y25oybe0CWSQcZKJGqtZtToXXeZxSpdnaUuwi9I6iZMy6tT+zUmkZulyqNrYxO25D2NowXSA+
 DGdlWTF/d7c6OUdzDNpbJm6wwSEPmtJFwSzWjFSNotiA5q7r+ROSWrMZ6ckB6kWfnOiX/reeZ
 UMAZ8reI+M8X4nxSaghypNtedivg3lNR8AHqXRNTWVxqDxfnOXIkoZxk2ZqWjQPjOPcIsMCdp
 H6RZmeaMtjm/wo83niUC+KORAA9v33yIYQJbSvq/AqAJVslW7EfnZEnrfGZ52t2yiPz25d6pq
 fTHFklQNld4YRA4YrwJXFotn082xkVOFR74zHkOL2NlQ5y4Lnw0WqKurc88=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292103>

Users may like to review their changes when staging by default. It is
also a convenient safety feature for beginners nudging them to have a
second look at their changes when composing a commit.

To this end, the config variable allows to have git-add to always act
like -p was passed.

To not affect other commands that use the add built-in, the variable
looses its effect when invoked transitively.

Signed-off-by: XZS <d.f.fischer@web.de>
---

I corrected the errorneous use of -p in the test. Thanks to Christian
Couder for the notice.

 Documentation/config.txt               |  6 ++++++
 Documentation/git-add.txt              |  3 +++
 builtin/add.c                          |  3 +++
 contrib/completion/git-completion.bash |  1 +
 git.c                                  |  3 ++-
 t/t3701-add-interactive.sh             | 27 +++++++++++++++++++++++++++
 6 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index aea6bd1..73f7dfa 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -752,6 +752,12 @@ add.ignore-errors (deprecated)::
 	as it does not follow the usual naming convention for configuration
 	variables.
 
+add.patch::
+	Configures 'git add' to always interactively choose hunks, hinting the
+	user to review changes before staging. This is equivalent to adding the
+	'--patch' option to linkgit:git-add[1] and can be overwritten by
+	invoking git-add with --no-patch.
+
 alias.*::
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 6a96a66..cdb6663 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -92,6 +92,9 @@ OPTIONS
 This effectively runs `add --interactive`, but bypasses the
 initial command menu and directly jumps to the `patch` subcommand.
 See ``Interactive mode'' for details.
++
+The configuration variable `add.patch` can be set to true to make
+this the default behaviour.
 
 -e::
 --edit::
diff --git a/builtin/add.c b/builtin/add.c
index 145f06e..3249a55 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -272,6 +272,9 @@ static int add_config(const char *var, const char *value, void *cb)
 	    !strcmp(var, "add.ignore-errors")) {
 		ignore_add_errors = git_config_bool(var, value);
 		return 0;
+	} else if (!strcmp(var, "add.patch") && recursion_depth <= 0) {
+		patch_interactive = git_config_bool(var, value);
+		return 0;
 	}
 	return git_default_config(var, value, cb);
 }
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e3918c8..597d20f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1969,6 +1969,7 @@ _git_config ()
 	esac
 	__gitcomp "
 		add.ignoreErrors
+		add.patch
 		advice.commitBeforeMerge
 		advice.detachedHead
 		advice.implicitIdentity
diff --git a/git.c b/git.c
index 0bcc7b4..df2fe58 100644
--- a/git.c
+++ b/git.c
@@ -2,6 +2,7 @@
 #include "exec_cmd.h"
 #include "help.h"
 #include "run-command.h"
+#include <math.h>
 
 const char git_usage_string[] =
 	"git [--version] [--help] [-C <path>] [-c name=value]\n"
@@ -639,7 +640,7 @@ static int get_recursion_depth(void)
 
 static int set_recursion_depth(int depth)
 {
-	char number[10]; // TODO compute length
+	char number[(int) ceil(log10(pow(2, sizeof(int))))];
 	snprintf(number, sizeof(number), "%i", depth);
 	return setenv("GIT_RECURSION_DEPTH", number, 1);
 }
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index deae948..7ba2817 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -380,4 +380,31 @@ test_expect_success 'patch mode ignores unmerged entries' '
 	test_cmp expected diff
 '
 
+test_expect_success 'patch mode can be activated per option' '
+	git config add.patch true &&
+	git reset --hard &&
+	echo change >test &&
+	yes | git add > output &&
+	cat output &&
+	grep "Stage this hunk \[y,n,q,a,d,/,e,?\]?" output
+'
+
+test_expect_success 'add.patch configuration does not affect transitive add invocations' '
+	git reset --hard &&
+	git checkout -b main >/dev/null 2>&1 &&
+	git branch branch &&
+	echo change >test &&
+	git add --no-patch test &&
+	git commit -m commit >/dev/null 2>&1 &&
+	git checkout branch >/dev/null 2>&1 &&
+	echo other >test &&
+	git add --no-patch test &&
+	git commit -m other >/dev/null 2>&1 &&
+	test_must_fail git merge main >/dev/null 2>&1 &&
+	git config merge.tool mybase &&
+	git config mergetool.mybase.cmd "cat \"\$BASE\" >\"\$MERGED\"" &&
+	git config mergetool.mybase.trustExitCode true &&
+	git mergetool 2>&1 1>/dev/null | test_must_fail grep -q "ignoring unmerged"
+'
+
 test_done
-- 
2.8.0
