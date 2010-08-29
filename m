From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH v3?] Add global and system-wide gitattributes
Date: Sun, 29 Aug 2010 12:32:18 +0200
Message-ID: <87fwxxhfpp.fsf_-_@gmail.com>
References: <vpqy6bqr3ep.fsf@bauges.imag.fr>
	<1283020870-24888-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Onderka <gsvick@gmail.com>,
	"Junio C. Hamano" <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Aug 29 12:32:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpfC6-0000Bx-1w
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 12:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866Ab0H2Kcw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 06:32:52 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33131 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab0H2Kcv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 06:32:51 -0400
Received: by pzk9 with SMTP id 9so1712564pzk.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 03:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=Hw0TWbM4pH8pEAZ1yYT06znHYUG9xivkKYrKJ4LgjEs=;
        b=OJ5HnUFv3Q1YK8F8rVEAPIojjival41DFDLKVOsDh8PimbZfjoAppuLs0Gv+OVDFy+
         Q7gtqes7gySyw+yQASBItayD5Zm/PDWcRNP3oikeQYXUHxHxV9tJXpcARA45nFx7WuyV
         fhMVKm00MOpAIflb6tbV5kaP7oiroim4m91JM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=WCe/3keBXrWVRQSEwF5qpOu8s6Vhs/qYvW/l9yxJQl/E2gwZn7CulV5pBhw3PSygFx
         3k8aMjz3Dfykh3x8SzEtYaXTIOggE6fYbxHIxRKqasVsKDANDfTAqiu0Y15V3Mxf2AqW
         t3vgmdJ96SgivyNuic3Pasq+zjsQQmxBKRQuU=
Received: by 10.114.203.10 with SMTP id a10mr3415940wag.42.1283077970747;
        Sun, 29 Aug 2010 03:32:50 -0700 (PDT)
Received: from localhost ([88.103.132.186])
        by mx.google.com with ESMTPS id q6sm11396386waj.10.2010.08.29.03.32.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 03:32:48 -0700 (PDT)
In-Reply-To: <1283020870-24888-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Sat, 28 Aug 2010 20:41:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154685>


Thanks, Matthieu!

Petr's original patch doesn't apply cleanly due to a bogus context line
after a recent change in Makefile. For convenience, below is the update=
d
patch including Matthieu's changes applicable to current master.

And FWIW (I didn't try to build the documentation, though):

Tested-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>

--- 8< ---
=46rom b63a6449dbf2c6d4a111ad840ae7d408afdd5e43 Mon Sep 17 00:00:00 200=
1
=46rom: Petr Onderka <gsvick@gmail.com>
Date: Mon, 16 Aug 2010 16:56:53 +0000
Subject: [PATCH] Add global and system-wide gitattributes

Allow gitattributes to be set globally and system wide. This way, setti=
ngs
for particular file types can be set in one place and apply for all use=
r's
repositories.

The location of system-wide attributes file is $(prefix)/etc/gitattribu=
tes.
The location of the global file can be configured by setting
core.attributesfile.

Some parts of the code were copied from the implementation of the same
functionality in config.c.

Signed-off-by: Petr Onderka <gsvick@gmail.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/config.txt        |    6 +++++
 Documentation/gitattributes.txt |   13 +++++++++--
 Makefile                        |    6 +++++
 attr.c                          |   42 +++++++++++++++++++++++++++++++=
+++++++-
 cache.h                         |    1 +
 config.c                        |    3 ++
 configure.ac                    |   10 ++++++++-
 environment.c                   |    1 +
 t/t0003-attributes.sh           |   14 +++++++++++++
 9 files changed, 91 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 05ec3fe..0e15e72 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -450,6 +450,12 @@ core.excludesfile::
 	to the value of `$HOME` and "{tilde}user/" to the specified user's
 	home directory.  See linkgit:gitignore[5].
=20
+core.attributesfile::
+	In addition to '.gitattributes' (per-directory) and
+	'.git/info/attributes', git looks into this file for attributes
+	(see linkgit:gitattributes[5]). Path expansions are made the same
+	way as for `core.excludesfile`.
+
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
 	messages by launching an editor uses the value of this
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index 2e2370c..ebd4852 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -62,14 +62,21 @@ consults `$GIT_DIR/info/attributes` file (which has=
 the highest
 precedence), `.gitattributes` file in the same directory as the
 path in question, and its parent directories up to the toplevel of the
 work tree (the further the directory that contains `.gitattributes`
-is from the path in question, the lower its precedence).
+is from the path in question, the lower its precedence). Finally
+global and system-wide files are considered (they have the lowest
+precedence).
=20
 If you wish to affect only a single repository (i.e., to assign
-attributes to files that are particular to one user's workflow), then
+attributes to files that are particular to
+one user's workflow for that repository), then
 attributes should be placed in the `$GIT_DIR/info/attributes` file.
 Attributes which should be version-controlled and distributed to other
 repositories (i.e., attributes of interest to all users) should go int=
o
-`.gitattributes` files.
+`.gitattributes` files. Attributes that should affect all repositories
+for a single user should be placed in a file specified by the
+`core.attributesfile` configuration option (see linkgit:git-config[1])=
=2E
+Attributes for all users on a system should be placed in the
+`$(prefix)/etc/gitattributes` file.
=20
 Sometimes you would need to override an setting of an attribute
 for a path to `unspecified` state.  This can be done by listing
diff --git a/Makefile b/Makefile
index b4745a5..fdb7b4e 100644
--- a/Makefile
+++ b/Makefile
@@ -268,6 +268,7 @@ STRIP ?=3D strip
 #   infodir
 #   htmldir
 #   ETC_GITCONFIG (but not sysconfdir)
+#   ETC_GITATTRIBUTES
 # can be specified as a relative path some/where/else;
 # this is interpreted as relative to $(prefix) and "git" at
 # runtime figures out where they are based on the path to the executab=
le.
@@ -286,9 +287,11 @@ htmldir =3D share/doc/git-doc
 ifeq ($(prefix),/usr)
 sysconfdir =3D /etc
 ETC_GITCONFIG =3D $(sysconfdir)/gitconfig
+ETC_GITATTRIBUTES =3D $(sysconfdir)/gitattributes
 else
 sysconfdir =3D $(prefix)/etc
 ETC_GITCONFIG =3D etc/gitconfig
+ETC_GITATTRIBUTES =3D etc/gitattributes
 endif
 lib =3D lib
 # DESTDIR=3D
@@ -1502,6 +1505,7 @@ endif
=20
 SHA1_HEADER_SQ =3D $(subst ','\'',$(SHA1_HEADER))
 ETC_GITCONFIG_SQ =3D $(subst ','\'',$(ETC_GITCONFIG))
+ETC_GITATTRIBUTES_SQ =3D $(subst ','\'',$(ETC_GITATTRIBUTES))
=20
 DESTDIR_SQ =3D $(subst ','\'',$(DESTDIR))
 bindir_SQ =3D $(subst ','\'',$(bindir))
@@ -1873,6 +1877,8 @@ builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLA=
GS =3D \
=20
 config.s config.o: EXTRA_CPPFLAGS =3D -DETC_GITCONFIG=3D'"$(ETC_GITCON=
=46IG_SQ)"'
=20
+attr.s attr.o: EXTRA_CPPFLAGS =3D -DETC_GITATTRIBUTES=3D'"$(ETC_GITATT=
RIBUTES_SQ)"'
+
 http.s http.o: EXTRA_CPPFLAGS =3D -DGIT_HTTP_USER_AGENT=3D'"git/$(GIT_=
VERSION)"'
=20
 ifdef NO_EXPAT
diff --git a/attr.c b/attr.c
index 8ba606c..342791a 100644
--- a/attr.c
+++ b/attr.c
@@ -1,5 +1,6 @@
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "exec_cmd.h"
 #include "attr.h"
=20
 const char git_attr__true[] =3D "(builtin)true";
@@ -462,6 +463,24 @@ static void drop_attr_stack(void)
 	}
 }
=20
+const char *git_etc_gitattributes(void)
+{
+	static const char *system_wide;
+	if (!system_wide)
+		system_wide =3D system_path(ETC_GITATTRIBUTES);
+	return system_wide;
+}
+
+int git_attr_system(void)
+{
+	return !git_env_bool("GIT_ATTR_NOSYSTEM", 0);
+}
+
+int git_attr_global(void)
+{
+	return !git_env_bool("GIT_ATTR_NOGLOBAL", 0);
+}
+
 static void bootstrap_attr_stack(void)
 {
 	if (!attr_stack) {
@@ -472,6 +491,25 @@ static void bootstrap_attr_stack(void)
 		elem->prev =3D attr_stack;
 		attr_stack =3D elem;
=20
+		if (git_attr_system()) {
+			elem =3D read_attr_from_file(git_etc_gitattributes(), 1);
+			if (elem) {
+				elem->origin =3D NULL;
+				elem->prev =3D attr_stack;
+				attr_stack =3D elem;
+			}
+		}
+
+		git_config(git_default_config, NULL);
+		if (git_attr_global() && attributes_file) {
+			elem =3D read_attr_from_file(attributes_file, 1);
+			if (elem) {
+				elem->origin =3D NULL;
+				elem->prev =3D attr_stack;
+				attr_stack =3D elem;
+			}
+		}
+
 		if (!is_bare_repository() || direction =3D=3D GIT_ATTR_INDEX) {
 			elem =3D read_attr(GITATTRIBUTES_FILE, 1);
 			elem->origin =3D strdup("");
@@ -499,7 +537,9 @@ static void prepare_attr_stack(const char *path, in=
t dirlen)
=20
 	/*
 	 * At the bottom of the attribute stack is the built-in
-	 * set of attribute definitions.  Then, contents from
+	 * set of attribute definitions, followed by the contents
+	 * of $(prefix)/etc/gitattributes and a file specified by
+	 * core.attributesfile.  Then, contents from
 	 * .gitattribute files from directories closer to the
 	 * root to the ones in deeper directories are pushed
 	 * to the stack.  Finally, at the very top of the stack
diff --git a/cache.h b/cache.h
index eb77e1d..28d9497 100644
--- a/cache.h
+++ b/cache.h
@@ -1033,6 +1033,7 @@ extern int pager_use_color;
=20
 extern const char *editor_program;
 extern const char *excludes_file;
+extern const char *attributes_file;
=20
 /* base85 */
 int decode_85(char *dst, const char *line, int linelen);
diff --git a/config.c b/config.c
index cdcf583..f602cd4 100644
--- a/config.c
+++ b/config.c
@@ -563,6 +563,9 @@ static int git_default_core_config(const char *var,=
 const char *value)
 	if (!strcmp(var, "core.excludesfile"))
 		return git_config_pathname(&excludes_file, var, value);
=20
+	if (!strcmp(var, "core.attributesfile"))
+		return git_config_pathname(&attributes_file, var, value);
+
 	if (!strcmp(var, "core.whitespace")) {
 		if (!value)
 			return config_error_nonbool(var);
diff --git a/configure.ac b/configure.ac
index 5601e8b..c5b3a41 100644
--- a/configure.ac
+++ b/configure.ac
@@ -282,7 +282,15 @@ GIT_PARSE_WITH(iconv))
 GIT_PARSE_WITH_SET_MAKE_VAR(gitconfig, ETC_GITCONFIG,
 			Use VALUE instead of /etc/gitconfig as the
 			global git configuration file.
-			If VALUE is not fully qualified it will be interpretted
+			If VALUE is not fully qualified it will be interpreted
+			as a path relative to the computed prefix at runtime.)
+
+#
+# Allow user to set ETC_GITATTRIBUTES variable
+GIT_PARSE_WITH_SET_MAKE_VAR(gitattributes, ETC_GITATTRIBUTES,
+			Use VALUE instead of /etc/gitattributes as the
+			global git attributes file.
+			If VALUE is not fully qualified it will be interpreted
 			as a path relative to the computed prefix at runtime.)
=20
 #
diff --git a/environment.c b/environment.c
index 83d38d3..58f719a 100644
--- a/environment.c
+++ b/environment.c
@@ -38,6 +38,7 @@ const char *pager_program;
 int pager_use_color =3D 1;
 const char *editor_program;
 const char *excludes_file;
+const char *attributes_file;
 enum auto_crlf auto_crlf =3D AUTO_CRLF_FALSE;
 int read_replace_refs =3D 1;
 enum eol eol =3D EOL_UNSET;
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 53bd7fc..7fe3b49 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -15,6 +15,7 @@ attr_check () {
=20
 }
=20
+HOME=3D$(pwd)
=20
 test_expect_success 'setup' '
=20
@@ -36,6 +37,9 @@ test_expect_success 'setup' '
 		echo "d/* test=3Da/b/d/*"
 		echo "d/yes notest"
 	) >a/b/.gitattributes
+	(
+		echo "global test=3Dglobal"
+	) >$HOME/global-gitattributes
=20
 '
=20
@@ -57,6 +61,16 @@ test_expect_success 'attribute test' '
=20
 '
=20
+test_expect_success 'core.attributesfile' '
+	attr_check global unspecified &&
+	git config core.attributesfile "$HOME/global-gitattributes" &&
+	attr_check global global &&
+	git config core.attributesfile "~/global-gitattributes" &&
+	attr_check global global &&
+	echo "global test=3Dprecedence" >> .gitattributes &&
+	attr_check global precedence
+'
+
 test_expect_success 'attribute test: read paths from stdin' '
=20
 	cat <<EOF > expect
--=20
1.7.1
