From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] help: replace underlining "help -a" headers using hyphens with a blank line
Date: Wed, 25 Apr 2012 18:21:53 +0700
Message-ID: <1335352913-32684-1-git-send-email-pclouds@gmail.com>
References: <20120423183439.GA12916@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 13:25:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN0Lb-0005tK-8z
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 13:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758560Ab2DYLZR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Apr 2012 07:25:17 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49519 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758513Ab2DYLZP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 07:25:15 -0400
Received: by pbbro12 with SMTP id ro12so1329654pbb.19
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 04:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yAOARu6yMZMZ5V7+fzQaLQ2wbC8NXmwOB9yQ9TcZ9aE=;
        b=b0I9W6sqtCtEQ9NAWpR1Aye4e4dYa/SKORnr7imn+CID7QfETPGjhQKrJV8RKklAju
         VgXBmJUoZDvU5CMq1hAAWBSnNJU7V7CjAR8QG9PF8p6nCY5Q259CSV+Py1h0Z3tsDL7o
         r6vOyOD/yTrAdWZFyamHuBqiHS5uc5KiCJck2r3wJrPH8rYU8X9Y6UpOU8SqP+L70ClG
         B+bVg8nSnI2W3iVX1wpbey+7AkH5HNKqKHARblm/X/0hOW6VNBPefeztZjPt19WTnp9M
         fMiiSJwObPKdaVsJ/D0B87AL7jRXJRyE1CNAf1VQPyduhsUymhqsVGXKDIUs9tgHSFPS
         55mg==
Received: by 10.68.212.163 with SMTP id nl3mr6648451pbc.112.1335353114562;
        Wed, 25 Apr 2012 04:25:14 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.44.101])
        by mx.google.com with ESMTPS id l1sm20294595pbs.34.2012.04.25.04.25.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Apr 2012 04:25:13 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 25 Apr 2012 18:21:55 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <20120423183439.GA12916@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196308>

We want the underline to align with the text above, for example:

This is a header
----------------
content...

Unfortunately calculating text length could get complicated because
the text could be in any charset in translated Git. Avoid it and print
a blank line (i.e. charset neutral) instead. Readability is not
affected much. After the change we get:

This is a header:

content...

While at it, give translators more context to translate, e.g.
e.g.  "git commands available..." instead of "%s available..."

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 2012/4/24 Jonathan Nieder <jrnieder@gmail.com>:
 > Junio C Hamano wrote:
 >
 >>                                                        Wouldn't a s=
imple
 >> and clean "blank line" look better?
 >
 > Yes, based on a quick test with "vi" it looks reasonable.  Thanks fo=
r
 > a sanity check.

 And it does _not_ assume the translated text is in utf-8.

 And thanks Junio for fixing the other nit before merging the seriess
 to next. I should have read and reacted on these posts yesterday.

 builtin/help.c |    2 +-
 help.c         |   16 +++-------------
 help.h         |    3 +--
 3 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 96a462c..e63668a 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -425,7 +425,7 @@ int cmd_help(int argc, const char **argv, const cha=
r *prefix)
=20
 	if (show_all) {
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
-		list_commands(_("git commands"), &main_cmds, &other_cmds);
+		list_commands(&main_cmds, &other_cmds);
 		printf("%s\n", _(git_more_info_string));
 		return 0;
 	}
diff --git a/help.c b/help.c
index 9e6e0f2..baaf379 100644
--- a/help.c
+++ b/help.c
@@ -203,8 +203,7 @@ void load_command_list(const char *prefix,
 	exclude_cmds(other_cmds, main_cmds);
 }
=20
-void list_commands(const char *title, struct cmdnames *main_cmds,
-		   struct cmdnames *other_cmds)
+void list_commands(struct cmdnames *main_cmds, struct cmdnames *other_=
cmds)
 {
 	int i, longest =3D 0;
=20
@@ -217,23 +216,14 @@ void list_commands(const char *title, struct cmdn=
ames *main_cmds,
=20
 	if (main_cmds->cnt) {
 		const char *exec_path =3D git_exec_path();
-		printf_ln(_("available %s in '%s'"), title, exec_path);
-		/* TRANSLATORS: this must align with "available %s in '%s'" */
-		printf(_("----------------"));
-		mput_char('-', strlen(title) + strlen(exec_path));
+		printf_ln(_("available git commands in '%s':"), exec_path);
 		putchar('\n');
 		pretty_print_string_list(main_cmds, longest);
 		putchar('\n');
 	}
=20
 	if (other_cmds->cnt) {
-		printf_ln(_("%s available from elsewhere on your $PATH"), title);
-		/* TRANSLATORS:
-		 * this must align with
-		 * "%s available from elsewhere on your $PATH"
-		 */
-		printf(_("---------------------------------------"));
-		mput_char('-', strlen(title));
+		printf_ln(_("git commands available from elsewhere on your $PATH:"))=
;
 		putchar('\n');
 		pretty_print_string_list(other_cmds, longest);
 		putchar('\n');
diff --git a/help.h b/help.h
index b6b12d5..dc406c8 100644
--- a/help.h
+++ b/help.h
@@ -25,8 +25,7 @@ extern void add_cmdname(struct cmdnames *cmds, const =
char *name, int len);
 /* Here we require that excludes is a sorted list. */
 extern void exclude_cmds(struct cmdnames *cmds, struct cmdnames *exclu=
des);
 extern int is_in_cmdlist(struct cmdnames *cmds, const char *name);
-extern void list_commands(const char *title,
-			  struct cmdnames *main_cmds,
+extern void list_commands(struct cmdnames *main_cmds,
 			  struct cmdnames *other_cmds);
=20
 #endif /* HELP_H */
--=20
1.7.8.36.g69ee2
