From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 20/25] gettextize: git-tag basic messages
Date: Thu,  2 Sep 2010 19:40:41 +0000
Message-ID: <1283456446-22577-21-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:42:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFgT-0006jt-Av
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756682Ab0IBTm3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:42:29 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50195 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756672Ab0IBTm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:42:28 -0400
Received: by mail-wy0-f174.google.com with SMTP id 35so81343wyb.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=0ELewhfNy/PsaOEGFfsfVIRRMTQis+olSIN5hEvTu2U=;
        b=IxbtGNziusSxf8VH30/e3mCqolbsa2IDdymNhCgnKTTSbky9w1wcp1Phe1SbdClVLL
         RA/fDXx/GjC47ZALZH2IZQ/IWhNXBFHYkcfQC4eUx71IekE5FDCxqdIpsetL57QjNHEL
         u3K4yRtTYTnE/DfU30Y79DQVCDpXD6d9Mohhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=QtKA5CPHnbw/eHCFBJRnNtKaKwjYo6mQ3zbwGguGy0NDD9buWPN9/DF1loHsiuCQOf
         zU56RQSNG7hCPHZnY3ItGSU/Uvkh2xgQkVzfgNAA5bFgLRO+/67stESvL9XFnJHTmYM1
         KWJLEefYDFq8ue/F7YCZVhSRup9cKfVP6ZLOU=
Received: by 10.227.145.20 with SMTP id b20mr129030wbv.28.1283456547206;
        Thu, 02 Sep 2010 12:42:27 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.42.26
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:42:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155186>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/tag.c |   60 ++++++++++++++++++++++++++++---------------------=
-------
 1 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index c200e1e..7870d87 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -120,12 +120,12 @@ static int for_each_tag_name(const char **argv, e=
ach_tag_name_fn fn)
 	for (p =3D argv; *p; p++) {
 		if (snprintf(ref, sizeof(ref), "refs/tags/%s", *p)
 					>=3D sizeof(ref)) {
-			error("tag name too long: %.*s...", 50, *p);
+			error(_("tag name too long: %.*s..."), 50, *p);
 			had_error =3D 1;
 			continue;
 		}
 		if (!resolve_ref(ref, sha1, 1, NULL)) {
-			error("tag '%s' not found.", *p);
+			error(_("tag '%s' not found."), *p);
 			had_error =3D 1;
 			continue;
 		}
@@ -140,7 +140,7 @@ static int delete_tag(const char *name, const char =
*ref,
 {
 	if (delete_ref(ref, sha1, 0))
 		return 1;
-	printf("Deleted tag '%s' (was %s)\n", name, find_unique_abbrev(sha1, =
DEFAULT_ABBREV));
+	printf(_("Deleted tag '%s' (was %s)\n"), name, find_unique_abbrev(sha=
1, DEFAULT_ABBREV));
 	return 0;
 }
=20
@@ -152,7 +152,7 @@ static int verify_tag(const char *name, const char =
*ref,
 	argv_verify_tag[2] =3D sha1_to_hex(sha1);
=20
 	if (run_command_v_opt(argv_verify_tag, RUN_GIT_CMD))
-		return error("could not verify the tag '%s'", name);
+		return error(_("could not verify the tag '%s'"), name);
 	return 0;
 }
=20
@@ -167,7 +167,7 @@ static int do_sign(struct strbuf *buffer)
 	if (!*signingkey) {
 		if (strlcpy(signingkey, git_committer_info(IDENT_ERROR_ON_NO_NAME),
 				sizeof(signingkey)) > sizeof(signingkey) - 1)
-			return error("committer info too long.");
+			return error(_("committer info too long."));
 		bracket =3D strchr(signingkey, '>');
 		if (bracket)
 			bracket[1] =3D '\0';
@@ -187,20 +187,20 @@ static int do_sign(struct strbuf *buffer)
 	args[3] =3D NULL;
=20
 	if (start_command(&gpg))
-		return error("could not run gpg.");
+		return error(_("could not run gpg."));
=20
 	if (write_in_full(gpg.in, buffer->buf, buffer->len) !=3D buffer->len)=
 {
 		close(gpg.in);
 		close(gpg.out);
 		finish_command(&gpg);
-		return error("gpg did not accept the tag data");
+		return error(_("gpg did not accept the tag data"));
 	}
 	close(gpg.in);
 	len =3D strbuf_read(buffer, gpg.out, 1024);
 	close(gpg.out);
=20
 	if (finish_command(&gpg) || !len || len < 0)
-		return error("gpg failed to sign the tag");
+		return error(_("gpg failed to sign the tag"));
=20
 	/* Strip CR from the line endings, in case we are on Windows. */
 	for (i =3D j =3D 0; i < buffer->len; i++)
@@ -223,7 +223,7 @@ static const char tag_template[] =3D
 static void set_signingkey(const char *value)
 {
 	if (strlcpy(signingkey, value, sizeof(signingkey)) >=3D sizeof(signin=
gkey))
-		die("signing key value too long (%.10s...)", value);
+		die(_("signing key value too long (%.10s...)"), value);
 }
=20
 static int git_tag_config(const char *var, const char *value, void *cb=
)
@@ -269,9 +269,9 @@ static void write_tag_body(int fd, const unsigned c=
har *sha1)
 static int build_tag_object(struct strbuf *buf, int sign, unsigned cha=
r *result)
 {
 	if (sign && do_sign(buf) < 0)
-		return error("unable to sign the tag");
+		return error(_("unable to sign the tag"));
 	if (write_sha1_file(buf->buf, buf->len, tag_type, result) < 0)
-		return error("unable to write tag file");
+		return error(_("unable to write tag file"));
 	return 0;
 }
=20
@@ -286,7 +286,7 @@ static void create_tag(const unsigned char *object,=
 const char *tag,
=20
 	type =3D sha1_object_info(object, NULL);
 	if (type <=3D OBJ_NONE)
-	    die("bad object type.");
+	    die(_("bad object type."));
=20
 	header_len =3D snprintf(header_buf, sizeof(header_buf),
 			  "object %s\n"
@@ -299,7 +299,7 @@ static void create_tag(const unsigned char *object,=
 const char *tag,
 			  git_committer_info(IDENT_ERROR_ON_NO_NAME));
=20
 	if (header_len > sizeof(header_buf) - 1)
-		die("tag header too big.");
+		die(_("tag header too big."));
=20
 	if (!message) {
 		int fd;
@@ -308,7 +308,7 @@ static void create_tag(const unsigned char *object,=
 const char *tag,
 		path =3D git_pathdup("TAG_EDITMSG");
 		fd =3D open(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
 		if (fd < 0)
-			die_errno("could not create file '%s'", path);
+			die_errno(_("could not create file '%s'"), path);
=20
 		if (!is_null_sha1(prev))
 			write_tag_body(fd, prev);
@@ -318,7 +318,7 @@ static void create_tag(const unsigned char *object,=
 const char *tag,
=20
 		if (launch_editor(path, buf, NULL)) {
 			fprintf(stderr,
-			"Please supply the message using either -m or -F option.\n");
+			_("Please supply the message using either -m or -F option.\n"));
 			exit(1);
 		}
 	}
@@ -326,13 +326,13 @@ static void create_tag(const unsigned char *objec=
t, const char *tag,
 	stripspace(buf, 1);
=20
 	if (!message && !buf->len)
-		die("no tag message?");
+		die(_("no tag message?"));
=20
 	strbuf_insert(buf, 0, header_buf, header_len);
=20
 	if (build_tag_object(buf, sign, result) < 0) {
 		if (path)
-			fprintf(stderr, "The tag message has been left in %s\n",
+			fprintf(stderr, _("The tag message has been left in %s\n"),
 				path);
 		exit(128);
 	}
@@ -425,9 +425,9 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 		return list_tags(argv[0], lines =3D=3D -1 ? 0 : lines,
 				 with_commit);
 	if (lines !=3D -1)
-		die("-n option is only allowed with -l.");
+		die(_("-n option is only allowed with -l."));
 	if (with_commit)
-		die("--contains option is only allowed with -l.");
+		die(_("--contains option is only allowed with -l."));
 	if (delete)
 		return for_each_tag_name(argv, delete_tag);
 	if (verify)
@@ -435,17 +435,17 @@ int cmd_tag(int argc, const char **argv, const ch=
ar *prefix)
=20
 	if (msg.given || msgfile) {
 		if (msg.given && msgfile)
-			die("only one -F or -m option is allowed.");
+			die(_("only one -F or -m option is allowed."));
 		annotate =3D 1;
 		if (msg.given)
 			strbuf_addbuf(&buf, &(msg.buf));
 		else {
 			if (!strcmp(msgfile, "-")) {
 				if (strbuf_read(&buf, 0, 1024) < 0)
-					die_errno("cannot read '%s'", msgfile);
+					die_errno(_("cannot read '%s'"), msgfile);
 			} else {
 				if (strbuf_read_file(&buf, msgfile, 1024) < 0)
-					die_errno("could not open or read '%s'",
+					die_errno(_("could not open or read '%s'"),
 						msgfile);
 			}
 		}
@@ -455,20 +455,20 @@ int cmd_tag(int argc, const char **argv, const ch=
ar *prefix)
=20
 	object_ref =3D argc =3D=3D 2 ? argv[1] : "HEAD";
 	if (argc > 2)
-		die("too many params");
+		die(_("too many params"));
=20
 	if (get_sha1(object_ref, object))
-		die("Failed to resolve '%s' as a valid ref.", object_ref);
+		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
=20
 	if (snprintf(ref, sizeof(ref), "refs/tags/%s", tag) > sizeof(ref) - 1=
)
-		die("tag name too long: %.*s...", 50, tag);
+		die(_("tag name too long: %.*s..."), 50, tag);
 	if (check_ref_format(ref))
-		die("'%s' is not a valid tag name.", tag);
+		die(_("'%s' is not a valid tag name."), tag);
=20
 	if (!resolve_ref(ref, prev, 1, NULL))
 		hashclr(prev);
 	else if (!force)
-		die("tag '%s' already exists", tag);
+		die(_("tag '%s' already exists"), tag);
=20
 	if (annotate)
 		create_tag(object, tag, &buf, msg.given || msgfile,
@@ -476,11 +476,11 @@ int cmd_tag(int argc, const char **argv, const ch=
ar *prefix)
=20
 	lock =3D lock_any_ref_for_update(ref, prev, 0);
 	if (!lock)
-		die("%s: cannot lock the ref", ref);
+		die(_("%s: cannot lock the ref"), ref);
 	if (write_ref_sha1(lock, object, NULL) < 0)
-		die("%s: cannot update the ref", ref);
+		die(_("%s: cannot update the ref"), ref);
 	if (force && hashcmp(prev, object))
-		printf("Updated tag '%s' (was %s)\n", tag, find_unique_abbrev(prev, =
DEFAULT_ABBREV));
+		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(pre=
v, DEFAULT_ABBREV));
=20
 	strbuf_release(&buf);
 	return 0;
--=20
1.7.2.2.614.g1dc9
