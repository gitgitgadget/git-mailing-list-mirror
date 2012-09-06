From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] remote: prefer subcommand name 'remove' to 'rm'
Date: Thu,  6 Sep 2012 19:25:23 +0700
Message-ID: <1346934323-15938-1-git-send-email-pclouds@gmail.com>
References: <7vehmf6c3x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 14:32:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9bG6-0002yr-Pa
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 14:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167Ab2IFMc2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Sep 2012 08:32:28 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39573 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab2IFMc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 08:32:26 -0400
Received: by pbbrr13 with SMTP id rr13so2440896pbb.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 05:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uaGAA0Q0m006xgcopiHqKqMeRiclRb0jmAVpa94/6bs=;
        b=i+sWPN0KKvmyyFlo3x4X0aNl7bwVtKUwgNRhfmM7siYTWKRCOizbHowT9LNFbJbrYW
         8JKvQMegWUeX3hua2KA6+FqJML0qlhAyZM/KVNnIWuKsW1kSHYA7aTgY38r4fFIZDWmi
         OAp7+LyAg2sryNEOXssw+zLQWDQccRSHMhPUN96Wz3wIFd23LIh8Wxq2OnjiiKdKCSaS
         B7zPauxHhV1XgCXTBPJ8yn/z+U+AteAAEyN6e30f3Y6tiOWddjve8T85kCVabn/VtBfe
         forbyzSewxw1IyoQcMYL4u8DeZMrr0oTaURfjVt13hdH9s2oHGIW5cJxssnhQkPXuEZh
         Uckg==
Received: by 10.66.74.100 with SMTP id s4mr3343450pav.27.1346934746476;
        Thu, 06 Sep 2012 05:32:26 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.40.250])
        by mx.google.com with ESMTPS id ho7sm1281753pbc.3.2012.09.06.05.32.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Sep 2012 05:32:25 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 06 Sep 2012 19:25:47 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <7vehmf6c3x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204879>

All remote subcommands are spelled out words except 'rm'. 'rm', being a
popular UNIX command name, may mislead users that there are also 'ls' o=
r
'mv'. Use 'remove' to fit with the rest of subcommands.

'rm' is still supported and used in the test suite. It's just not
widely advertised.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-remote.txt           | 3 ++-
 builtin/remote.c                       | 6 +++---
 contrib/completion/git-completion.bash | 4 ++--
 t/t5505-remote.sh                      | 4 ++--
 t/t5540-http-push.sh                   | 2 +-
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.tx=
t
index a308f4c..e8c396b 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git remote' [-v | --verbose]
 'git remote add' [-t <branch>] [-m <master>] [-f] [--tags|--no-tags] [=
--mirror=3D<fetch|push>] <name> <url>
 'git remote rename' <old> <new>
-'git remote rm' <name>
+'git remote remove' <name>
 'git remote set-head' <name> (-a | -d | <branch>)
 'git remote set-branches' [--add] <name> <branch>...
 'git remote set-url' [--push] <name> <newurl> [<oldurl>]
@@ -85,6 +85,7 @@ In case <old> and <new> are the same, and <old> is a =
file under
 `$GIT_DIR/remotes` or `$GIT_DIR/branches`, the remote is converted to
 the configuration file format.
=20
+'remove'::
 'rm'::
=20
 Remove the remote named <name>. All remote-tracking branches and
diff --git a/builtin/remote.c b/builtin/remote.c
index 920262d..357d59d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -11,7 +11,7 @@ static const char * const builtin_remote_usage[] =3D =
{
 	"git remote [-v | --verbose]",
 	"git remote add [-t <branch>] [-m <master>] [-f] [--tags|--no-tags] [=
--mirror=3D<fetch|push>] <name> <url>",
 	"git remote rename <old> <new>",
-	"git remote rm <name>",
+	"git remote remove <name>",
 	"git remote set-head <name> (-a | -d | <branch>)",
 	"git remote [-v | --verbose] show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
@@ -34,7 +34,7 @@ static const char * const builtin_remote_rename_usage=
[] =3D {
 };
=20
 static const char * const builtin_remote_rm_usage[] =3D {
-	"git remote rm <name>",
+	"git remote remove <name>",
 	NULL
 };
=20
@@ -1580,7 +1580,7 @@ int cmd_remote(int argc, const char **argv, const=
 char *prefix)
 		result =3D add(argc, argv);
 	else if (!strcmp(argv[0], "rename"))
 		result =3D mv(argc, argv);
-	else if (!strcmp(argv[0], "rm"))
+	else if (!strcmp(argv[0], "rm") || !strcmp(argv[0], "remove"))
 		result =3D rm(argc, argv);
 	else if (!strcmp(argv[0], "set-head"))
 		result =3D set_head(argc, argv);
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 222b804..0492db9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2032,7 +2032,7 @@ _git_config ()
=20
 _git_remote ()
 {
-	local subcommands=3D"add rename rm set-head set-branches set-url show=
 prune update"
+	local subcommands=3D"add rename remove set-head set-branches set-url =
show prune update"
 	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
@@ -2040,7 +2040,7 @@ _git_remote ()
 	fi
=20
 	case "$subcommand" in
-	rename|rm|set-url|show|prune)
+	rename|remove|set-url|show|prune)
 		__gitcomp_nl "$(__git_remotes)"
 		;;
 	set-head|set-branches)
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index e8af615..c03ffdd 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -125,7 +125,7 @@ EOF
 	} &&
 	git tag footag &&
 	git config --add remote.oops.fetch "+refs/*:refs/*" &&
-	git remote rm oops 2>actual1 &&
+	git remote remove oops 2>actual1 &&
 	git branch foobranch &&
 	git config --add remote.oops.fetch "+refs/*:refs/*" &&
 	git remote rm oops 2>actual2 &&
@@ -672,7 +672,7 @@ test_expect_success 'migrate a remote from named fi=
le in $GIT_DIR/remotes' '
 	git clone one five &&
 	origin_url=3D$(pwd)/one &&
 	(cd five &&
-	 git remote rm origin &&
+	 git remote remove origin &&
 	 mkdir -p .git/remotes &&
 	 cat ../remotes_origin > .git/remotes/origin &&
 	 git remote rename origin origin &&
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 1eea647..7c14bc4 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -117,7 +117,7 @@ test_expect_success 'http-push fetches packed objec=
ts' '
 	# By reset, we force git to retrieve the packed object
 	(cd "$ROOT_PATH"/test_repo_clone_packed &&
 	 git reset --hard HEAD^ &&
-	 git remote rm origin &&
+	 git remote remove origin &&
 	 git reflog expire --expire=3D0 --all &&
 	 git prune &&
 	 git push -f -v $HTTPD_URL/dumb/test_repo_packed.git master)
--=20
1.7.12.rc2.18.g61b472e
