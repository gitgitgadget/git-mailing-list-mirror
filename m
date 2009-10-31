From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3] Teach git var about GIT_EDITOR
Date: Fri, 30 Oct 2009 23:04:36 -0500
Message-ID: <20091031040436.GB6022@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
 <20091031013934.GD5160@progeny.tock>
 <7vk4yccodl.fsf@alter.siamese.dyndns.org>
 <20091031022347.GA5569@progeny.tock>
 <7vws2cb8bp.fsf@alter.siamese.dyndns.org>
 <20091031040003.GA6022@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 04:54:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N452n-0007Dx-NB
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 04:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757711AbZJaDyP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 23:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757709AbZJaDyP
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 23:54:15 -0400
Received: from mail-gx0-f226.google.com ([209.85.217.226]:36203 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757640AbZJaDyO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 23:54:14 -0400
Received: by gxk26 with SMTP id 26so974600gxk.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 20:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ocnhKqudABEFABS3rltLhDidp640isOf+lWCLiqt7rE=;
        b=Z/5idskN7XYGc/+t3YMCnqAZvOtiVRL4p0GaGL+FX29rfe1BkQS8Sg61sqtDOrrTnh
         YYQc/eOEFtqeMVsRDTDOlkyiow5COKgSVos7Y+fa4IDN/bQir4KSz/NHMEg47UD7jw9D
         LgY41dxcle8ujC1UuVKjpHHE6tEwsr62U1aFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=MVUGEyPr87VMqZyZtFgt2pejmm5OxMTFDvACYMNmpGyp1+Hlh/ttn2MPvHzOd3x9Hz
         zBemSNk+JcZSDJee+q4jy0SN734MFiQc/1lWNtTq7GmBoXQw/C2dHRi4fQNyTdjdh/Mp
         On4EuHTirdBXRG3zLL/NO3Vf+tDyrvvqcmlWQ=
Received: by 10.90.242.1 with SMTP id p1mr5713300agh.105.1256961259442;
        Fri, 30 Oct 2009 20:54:19 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm1647894yxh.4.2009.10.30.20.54.18
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 20:54:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091031040003.GA6022@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131831>

=46rom: Johannes Sixt <j6t@kdbg.org>

Expose the command used by launch_editor() for scripts to use.
This should allow one to avoid searching for a proper editor
separately in each command.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:

> How about this patch?  With the "git var GIT_EDITOR" patch applied on
> top, "git var -l" silently omits the GIT_EDITOR variable when a suita=
ble
> editor cannot be found.
>=20
> -- %< --
> Subject: Suppress warnings from "git var -l"
>=20
> For scripts using "git var -l" to read all logical variables at
> once, not all per-variable warnings will be relevant.  Suppress
> them.

Here=E2=80=99s the "git var GIT_EDITOR" patch again, rebased on top of =
the
aforementioned patch.  The rest of the series should apply without
changes.

 Documentation/git-var.txt |    8 ++++++++
 cache.h                   |    1 +
 editor.c                  |   14 ++++++++++++--
 var.c                     |   16 +++++++++++++++-
 4 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index e2f4c09..89e4b4f 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -36,6 +36,14 @@ GIT_AUTHOR_IDENT::
 GIT_COMMITTER_IDENT::
     The person who put a piece of code into git.
=20
+GIT_EDITOR::
+    Text editor for use by git commands.  The value is meant to be
+    interpreted by the shell when it is used.  Examples: `~/bin/vi`,
+    `$SOME_ENVIRONMENT_VARIABLE`, `"C:\Program Files\Vim\gvim.exe"
+    --nofork`.  The order of preference is the `$GIT_EDITOR`
+    environment variable, then `core.editor` configuration, then
+    `$VISUAL`, then `$EDITOR`, and then finally 'vi'.
+
 Diagnostics
 -----------
 You don't exist. Go away!::
diff --git a/cache.h b/cache.h
index 96840c7..311cfe1 100644
--- a/cache.h
+++ b/cache.h
@@ -750,6 +750,7 @@ extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
 extern const char *fmt_ident(const char *name, const char *email, cons=
t char *date_str, int);
 extern const char *fmt_name(const char *name, const char *email);
+extern const char *git_editor(void);
=20
 struct checkout {
 	const char *base_dir;
diff --git a/editor.c b/editor.c
index 3f13751..4f98b72 100644
--- a/editor.c
+++ b/editor.c
@@ -2,7 +2,7 @@
 #include "strbuf.h"
 #include "run-command.h"
=20
-int launch_editor(const char *path, struct strbuf *buffer, const char =
*const *env)
+const char *git_editor(void)
 {
 	const char *editor =3D getenv("GIT_EDITOR");
 	const char *terminal =3D getenv("TERM");
@@ -16,11 +16,21 @@ int launch_editor(const char *path, struct strbuf *=
buffer, const char *const *en
 		editor =3D getenv("EDITOR");
=20
 	if (!editor && terminal_is_dumb)
-		return error("terminal is dumb, but EDITOR unset");
+		return NULL;
=20
 	if (!editor)
 		editor =3D "vi";
=20
+	return editor;
+}
+
+int launch_editor(const char *path, struct strbuf *buffer, const char =
*const *env)
+{
+	const char *editor =3D git_editor();
+
+	if (!editor)
+		return error("terminal is dumb, but EDITOR unset");
+
 	if (strcmp(editor, ":")) {
 		size_t len =3D strlen(editor);
 		int i =3D 0;
diff --git a/var.c b/var.c
index dacbaab..12a8512 100644
--- a/var.c
+++ b/var.c
@@ -8,6 +8,16 @@
=20
 static const char var_usage[] =3D "git var [-l | <variable>]";
=20
+static const char *editor(int flag)
+{
+	const char *pgm =3D git_editor();
+
+	if (!pgm && flag & IDENT_ERROR_ON_NO_NAME)
+		die("terminal is dumb, but VISUAL and EDITOR unset");
+
+	return pgm;
+}
+
 struct git_var {
 	const char *name;
 	const char *(*read)(int);
@@ -15,14 +25,18 @@ struct git_var {
 static struct git_var git_vars[] =3D {
 	{ "GIT_COMMITTER_IDENT", git_committer_info },
 	{ "GIT_AUTHOR_IDENT",   git_author_info },
+	{ "GIT_EDITOR", editor },
 	{ "", NULL },
 };
=20
 static void list_vars(void)
 {
 	struct git_var *ptr;
+	const char *val;
+
 	for (ptr =3D git_vars; ptr->read; ptr++)
-		printf("%s=3D%s\n", ptr->name, ptr->read(0));
+		if ((val =3D ptr->read(0))
+			printf("%s=3D%s\n", ptr->name, val);
 }
=20
 static const char *read_var(const char *var)
--=20
1.6.5.2
