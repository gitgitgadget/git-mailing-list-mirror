From: XZS <d.f.fischer@web.de>
Subject: [PATCH/GSoC] add a add.patch config variable
Date: Thu, 24 Mar 2016 22:09:47 +0100
Message-ID: <1458853787-29807-2-git-send-email-d.f.fischer@web.de>
References: <1458853787-29807-1-git-send-email-d.f.fischer@web.de>
Cc: XZS <d.f.fischer@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 22:10:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajCWE-0007Uz-SX
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 22:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbcCXVKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 17:10:12 -0400
Received: from mout.web.de ([212.227.17.12]:51549 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132AbcCXVKI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 17:10:08 -0400
Received: from storm.fritz.box ([95.116.247.71]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LlniO-1aA8kP3xdw-00ZLu6; Thu, 24 Mar 2016 22:10:06
 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1458853787-29807-1-git-send-email-d.f.fischer@web.de>
X-Provags-ID: V03:K0:JjQGJH23t2YSFnqMqKNEmWeEboBukta3CRCBXOY40hUWOnvnlRc
 KrhS7BezyZ4GsLvLA15/qvdyVNv2ZfD+3kTUGGMo7ra9BmRoJWGKhZ7PLufSa99CL/43Rxx
 fuJ65RPiB2m1JqL+yQXqt66XtS3D6VXstSa9P2ugT5XHgwZpRJenHo8yWCg07Za7M1Tmx6p
 gTMiC8bPB9M5fv7DGaY2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EogrM90F4wI=:E/ksiRF7Pjcec7kkIgcu2m
 NtAZNDeB1ofnVruAbECRZL0rse6vDoTLxXibCtp7PJhYw18POrqRh6tHYwdjlueFAC3HcEIs4
 BMtHW/LfrZodEyFdwPEsjWD+dYusqVq4ismMTLxiVbhx6eCaNs8SJUtbfsNX0vXY1o74okZig
 Us2FAt9OJIcbwvGa5btOvt44KSPmRR37eBjtVdy8mYJYzSi2UKv2CBetzF46utMokG/q0O+Oj
 +e6rg2ZedIDURzyzCi41u8BzcwxgZvlDqsxLHrMDrGZmlesSwMqmUY48u4JJNzT1po15zormH
 /h0CWcpohVd98htCLQnTbXyHYJgUXl55vhQmMymMtYb26IkiWkP8FdEiPbu0S4Ul4G0obPBlj
 wT4LtvghPIwDgjl1kcS/bCJWmjdC1lTkwSMXGoIdY8NtucoRRKMBtIJQyf1ypiL0ssiMbfAU9
 I7PXK513y1Gdip+213bd59q/9TaabboxG+aRKpIaivTuNd5UFlv3GayOrA6em/KNuiycsVsmm
 P7x+/KFyApZjJ3LusMXoUBuqwcSAbu1rOo0nFm6TfduFuOwLE8emufOQpuGprBHsNYvcGXpmm
 qHXkQ6kGPZ2C/BYb8MiFm+PUcU+eWvLNygoWDqkNs9H3MhksJXKC/4TSISatbwCoC7wrnUl1s
 JcrsxBVVgF8uN+4ROQ+pFpujd4dnq4xPTaKsvASETVLbzykIKNLECfPnprQZADvdwK4CSWIFF
 /XruLz8jDZCuvO12+03iQ6MQQJbXu6H2Ss9bScYhmjIJVrjY88Lx2iDmuiA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289800>

Users may like to review their changes when staging by default. It is
also a convenient safety feature for beginners nudging them to have a
second look at their changes when composing a commit.

To this end, the config variable allows to have git-add to always act
like -p was passed.

Signed-off-by: XZS <d.f.fischer@web.de>
---
The list of microproject suggestions for the Summer of Code 2016 proposed to
"add configuration options for some commonly used command-line options", so I
added a configuraion variable for an option I use all the time.

 Documentation/config.txt               | 5 +++++
 Documentation/git-add.txt              | 3 +++
 builtin/add.c                          | 3 +++
 contrib/completion/git-completion.bash | 1 +
 t/t3701-add-interactive.sh             | 9 +++++++++
 5 files changed, 21 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2cd6bdd..614c599 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -752,6 +752,11 @@ add.ignore-errors (deprecated)::
 	as it does not follow the usual naming convention for configuration
 	variables.
 
+add.patch::
+	Configures 'git add' to always interactively choose hunks, hinting the
+	user to review changes before staging.  This is equivalent to adding the
+	'--patch' option to linkgit:git-add[1].
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
index 145f06e..04f8b5e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -272,6 +272,9 @@ static int add_config(const char *var, const char *value, void *cb)
 	    !strcmp(var, "add.ignore-errors")) {
 		ignore_add_errors = git_config_bool(var, value);
 		return 0;
+	} else if (!strcmp(var, "add.patch")) {
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
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index deae948..25e4b2e 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -380,4 +380,13 @@ test_expect_success 'patch mode ignores unmerged entries' '
 	test_cmp expected diff
 '
 
+test_expect_success 'patch mode can be activated per option' '
+  git config add.patch true &&
+  git reset --hard &&
+  echo change >test &&
+  echo y | git add -p > output &&
+  cat output &&
+  grep "Stage this hunk \[y,n,q,a,d,/,e,?\]?" output
+'
+
 test_done
-- 
2.7.4
