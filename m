From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: [PATCH] Re: Teach mailinfo to ignore everything before -- >8 -- mark
Date: Tue, 25 Aug 2009 18:18:30 +0200
Message-ID: <fc2ecb5cf28cabb7d183e2835ce46aa9afb2a322.1251215299.git.nicolas.s.dev@gmx.fr>
References: <7v3a7g501e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 18:20:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfykU-0005h1-9y
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 18:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952AbZHYQTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 12:19:43 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754900AbZHYQTm
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 12:19:42 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:60091 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754836AbZHYQTl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 12:19:41 -0400
Received: by ewy2 with SMTP id 2so593042ewy.17
        for <git@vger.kernel.org>; Tue, 25 Aug 2009 09:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=LaMF2Q44AWAJW4QNXZYZUv/wob2DveBuuTj9yYZY66k=;
        b=SnNiLm+g9W4+oq30k/762ohk8R1JHA8KeQHMy46NfZZCpvsamdgH2Bl+AfrWrAfadR
         DsQgbcWvrDgPyWIsNKjeAOQjT33qBz60HnmSqwpdY+XuOgqEg6dwuzRsy4uR3xWdwRMx
         oyr490IrpgizbLJjkrVU+IJOYMrjDta9lQBLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=ZvBdjka3tW+PPQUr5QSCje8LJr/yYE3/OiXSlnpTMUsOHw1eWoI2xL0+y5VKeZq60i
         QuJEZEgMhR2QX5T5HqsZYAhJFexg4o5uBF03JMKwwH3gLMbQpLQxK1SwGY/pnai+Q4Qe
         qotLz5f9vwLpcmWLAAxu5R9PPpPLWXwhG90xc=
Received: by 10.210.138.19 with SMTP id l19mr3111766ebd.45.1251217181929;
        Tue, 25 Aug 2009 09:19:41 -0700 (PDT)
Received: from localhost (88-121-119-167.rev.libertysurf.net [88.121.119.167])
        by mx.google.com with ESMTPS id 7sm647948eyb.12.2009.08.25.09.19.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 Aug 2009 09:19:36 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.1.334.gf42e22
In-Reply-To: <7v3a7g501e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127027>

The 24/08/09, Junio C Hamano wrote:

>                                                                    pe=
rhaps                                                                  =
                             =20
> we should tighten the rules a bit,

<...>

> I think we have bikeshedded long enough, so I won't be touching this =
code
> any further only to change the definition of what a scissors mark loo=
ks
> like,

I'm not sure I understand. Are you still open to a patch touching this =
code
/too/?

Anyway, here's what I wrote based on your last round in pu. I've change=
 the
rules to something because I think we'd rather simple =E2=80=95 and "ea=
sy" to=20
explain to the end-user =E2=80=95 rules over "obfuscated" ones.

-- >8 -- squashable to 8683eeb (ogirin/pu) -- >8 --

Subject: Teach mailinfo to ignore everything before a scissors line

This teaches mailinfo the scissors mark (e.g. "-- >8 --");
the command ignores everything before it in the message body.

=46or lefties among us, we also support -- 8< -- ;-)

We can skip this check using the "--ignore-scissors" option on both
the git-mailinfo and the git-am command line. This is necessary
because the stripped message may be either

  interesting from the eyes of the maintainer, regardless what the
  author think;

or

  the scissors line check is a false positive.


Basically, the rules are:

(1) a scissors mark:

  - must be 8 characters long;
  - must have a dash;
  - must have either ">8" or "<8";
  - may contain spaces.

(2) a scissors line:

  - must have only one scissors mark;
  or
  - must have any comment between two identical scissors marks;
  - always ignore spaces outside the scissors marks.


Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
---
 Documentation/git-am.txt       |   14 +++++-
 Documentation/git-mailinfo.txt |    7 ++-
 builtin-mailinfo.c             |  103 +++++++++++++++++++++++---------=
-------
 git-am.sh                      |   14 ++++-
 4 files changed, 90 insertions(+), 48 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index fcacc94..2773a3e 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	 [--3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=3D<option>] [-C<n>] [-p<n>] [--directory=3D<dir>]
-	 [--reject] [-q | --quiet]
+	 [--reject] [-q | --quiet] [--ignore-scissors]
 	 [<mbox> | <Maildir>...]
 'git am' (--skip | --resolved | --abort)
=20
@@ -118,6 +118,14 @@ default.   You can use `--no-utf8` to override thi=
s.
 --abort::
 	Restore the original branch and abort the patching operation.
=20
+--ignore-scissors::
+	Do not check for scissors line in the commit message.  A scissors
+	line consists of a scissors mark which must be at least 8
+	characters long and which must contain dashes '-' and a scissors
+	(either ">8" or "<8").  Spaces are also permited inside the mark.
+	To add a comment on this line, it must be embedded between two
+	identical marks (e.g. "-- >8 -- squashme to <commit> -- >8 --").
+
 DISCUSSION
 ----------
=20
@@ -131,7 +139,9 @@ commit is about in one line of text.
 "From: " and "Subject: " lines starting the body (the rest of the
 message after the blank line terminating the RFC2822 headers)
 override the respective commit author name and title values taken
-from the headers.
+from the headers. These lines immediatly following a scissors line
+override the respective fields regardless what could stand at the
+beginning of the body.
=20
 The commit message is formed by the title taken from the
 "Subject: ", a blank line and the body of the message up to
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinf=
o.txt
index 8d95aaa..e16a577 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -8,7 +8,8 @@ git-mailinfo - Extracts patch and authorship from a sin=
gle e-mail message
=20
 SYNOPSIS
 --------
-'git mailinfo' [-k] [-u | --encoding=3D<encoding> | -n] <msg> <patch>
+'git mailinfo' [-k] [-u | --encoding=3D<encoding> | -n] [--ignore-scis=
sors]
+<msg> <patch>
=20
=20
 DESCRIPTION
@@ -49,6 +50,10 @@ conversion, even with this flag.
 -n::
 	Disable all charset re-coding of the metadata.
=20
+--ignore-scissors::
+	Do not check for a scissors line (see linkgit:git-am[1]
+	for more information on scissors lines).
+
 <msg>::
 	The commit log message extracted from e-mail, usually
 	except the title line which comes from e-mail Subject.
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 7e09b51..92319f6 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -6,6 +6,7 @@
 #include "builtin.h"
 #include "utf8.h"
 #include "strbuf.h"
+#include "git-compat-util.h"
=20
 static FILE *cmitmsg, *patchfile, *fin, *fout;
=20
@@ -25,6 +26,7 @@ static enum  {
 static struct strbuf charset =3D STRBUF_INIT;
 static int patch_lines;
 static struct strbuf **p_hdr_data, **s_hdr_data;
+static int ignore_scissors =3D 0;
=20
 #define MAX_HDR_PARSED 10
 #define MAX_BOUNDARIES 5
@@ -715,51 +717,63 @@ static inline int patchbreak(const struct strbuf =
*line)
 static int is_scissors_line(const struct strbuf *line)
 {
 	size_t i, len =3D line->len;
-	int scissors =3D 0, gap =3D 0;
-	int first_nonblank =3D -1;
-	int last_nonblank =3D 0, visible, perforation, in_perforation =3D 0;
 	const char *buf =3D line->buf;
+	size_t mark_start =3D 0, mark_end =3D 0, mark_len;
+	int scissors_dashes_seen =3D 0;
=20
 	for (i =3D 0; i < len; i++) {
 		if (isspace(buf[i])) {
-			if (in_perforation) {
-				perforation++;
-				gap++;
-			}
+			if (scissors_dashes_seen)
+				mark_end =3D i;
 			continue;
 		}
-		last_nonblank =3D i;
-		if (first_nonblank < 0)
-			first_nonblank =3D i;
+		if (!scissors_dashes_seen)
+			mark_start =3D i;
 		if (buf[i] =3D=3D '-') {
-			in_perforation =3D 1;
-			perforation++;
+			mark_end =3D i;
+			scissors_dashes_seen |=3D 01;
 			continue;
 		}
 		if (i + 1 < len &&
 		    (!memcmp(buf + i, ">8", 2) || !memcmp(buf + i, "8<", 2))) {
-			in_perforation =3D 1;
-			perforation +=3D 2;
-			scissors +=3D 2;
 			i++;
+			mark_end =3D i;
+			scissors_dashes_seen |=3D 02;
 			continue;
 		}
-		in_perforation =3D 0;
+		break;
 	}
=20
-	/*
-	 * The mark must be at least 8 bytes long (e.g. "-- >8 --").
-	 * Even though there can be arbitrary cruft on the same line
-	 * (e.g. "cut here"), in order to avoid misidentification, the
-	 * perforation must occupy more than a third of the visible
-	 * width of the line, and dashes and scissors must occupy more
-	 * than half of the perforation.
-	 */
+	if (scissors_dashes_seen =3D=3D 03) {
+		/* strip trailing spaces at the end of the mark */
+		for (i =3D mark_end; i >=3D mark_start && i <=3D mark_end; i--) {
+			if (isspace(buf[i]))
+				mark_end--;
+			else
+				break;
+		}
=20
-	visible =3D last_nonblank - first_nonblank + 1;
-	return (scissors && 8 <=3D visible &&
-		visible < perforation * 3 &&
-		gap * 2 < perforation);
+		mark_len =3D mark_end - mark_start + 1;
+		if (mark_len >=3D 8) {
+			/* ignore trailing spaces at the end of the line */
+			len--;
+			for (i =3D len - 1; i >=3D 0; i--) {
+				if (isspace(buf[i]))
+					len--;
+				else
+					break;
+			}
+			/*
+			 * The mark is 8 charaters long and contains at least one dash and
+			 * either a ">8" or "<8". Check if the last mark in the line
+			 * matches the first mark found without worrying about what could
+			 * be between them. Only one mark in the whole line is permitted.
+			 */
+			return (!memcmp(buf + mark_start, buf + len - mark_len, mark_len));
+		}
+	}
+
+	return 0;
 }
=20
 static int handle_commit_msg(struct strbuf *line)
@@ -782,22 +796,25 @@ static int handle_commit_msg(struct strbuf *line)
 	if (metainfo_charset)
 		convert_to_utf8(line, charset.buf);
=20
-	if (is_scissors_line(line)) {
-		int i;
-		rewind(cmitmsg);
-		ftruncate(fileno(cmitmsg), 0);
-		still_looking =3D 1;
+	if (!ignore_scissors) {
+		if (is_scissors_line(line)) {
+			warning("scissors line found, will skip text above");
+			int i;
+			rewind(cmitmsg);
+			ftruncate(fileno(cmitmsg), 0);
+			still_looking =3D 1;
=20
-		/*
-		 * We may have already read "secondary headers"; purge
-		 * them to give ourselves a clean restart.
-		 */
-		for (i =3D 0; header[i]; i++) {
-			if (s_hdr_data[i])
-				strbuf_release(s_hdr_data[i]);
-			s_hdr_data[i] =3D NULL;
+			/*
+			 * We may have already read "secondary headers"; purge
+			 * them to give ourselves a clean restart.
+			 */
+			for (i =3D 0; header[i]; i++) {
+				if (s_hdr_data[i])
+					strbuf_release(s_hdr_data[i]);
+				s_hdr_data[i] =3D NULL;
+			}
+			return 0;
 		}
-		return 0;
 	}
=20
 	if (patchbreak(line)) {
@@ -1011,6 +1028,8 @@ int cmd_mailinfo(int argc, const char **argv, con=
st char *prefix)
 	while (1 < argc && argv[1][0] =3D=3D '-') {
 		if (!strcmp(argv[1], "-k"))
 			keep_subject =3D 1;
+		else if (!strcmp(argv[1], "--ignore-scissors"))
+			ignore_scissors =3D 1;
 		else if (!strcmp(argv[1], "-u"))
 			metainfo_charset =3D def_charset;
 		else if (!strcmp(argv[1], "-n"))
diff --git a/git-am.sh b/git-am.sh
index 3c03f3e..17c883f 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -15,6 +15,7 @@ q,quiet         be quiet
 s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
+ignore-scissors pass --ignore-scissors flag to git-mailinfo
 whitespace=3D     pass it through git-apply
 ignore-space-change pass it through git-apply
 ignore-whitespace pass it through git-apply
@@ -288,7 +289,7 @@ split_patches () {
 prec=3D4
 dotest=3D"$GIT_DIR/rebase-apply"
 sign=3D utf8=3Dt keep=3D skip=3D interactive=3D resolved=3D rebasing=3D=
 abort=3D
-resolvemsg=3D resume=3D
+resolvemsg=3D resume=3D ignore_scissors=3D
 git_apply_opt=3D
 committer_date_is_author_date=3D
 ignore_date=3D
@@ -310,6 +311,8 @@ do
 		utf8=3D ;;
 	-k|--keep)
 		keep=3Dt ;;
+	--ignore-scissors)
+		ignore_scissors=3Dt ;;
 	-r|--resolved)
 		resolved=3Dt ;;
 	--skip)
@@ -435,7 +438,7 @@ else
=20
 	split_patches "$@"
=20
-	# -s, -u, -k, --whitespace, -3, -C, -q and -p flags are kept
+	# Following flags are kept
 	# for the resuming session after a patch failure.
 	# -i can and must be given when resuming.
 	echo " $git_apply_opt" >"$dotest/apply-opt"
@@ -443,6 +446,7 @@ else
 	echo "$sign" >"$dotest/sign"
 	echo "$utf8" >"$dotest/utf8"
 	echo "$keep" >"$dotest/keep"
+	echo "$ignore_scissors" >"$dotest/ignore-scissors"
 	echo "$GIT_QUIET" >"$dotest/quiet"
 	echo 1 >"$dotest/next"
 	if test -n "$rebasing"
@@ -484,6 +488,10 @@ if test "$(cat "$dotest/keep")" =3D t
 then
 	keep=3D-k
 fi
+if test "$(cat "$dotest/ignore-scissors")" =3D t
+then
+	ignore_scissors=3D'--ignore-scissors'
+fi
 if test "$(cat "$dotest/quiet")" =3D t
 then
 	GIT_QUIET=3Dt
@@ -538,7 +546,7 @@ do
 	# by the user, or the user can tell us to do so by --resolved flag.
 	case "$resume" in
 	'')
-		git mailinfo $keep $utf8 "$dotest/msg" "$dotest/patch" \
+		git mailinfo $keep $ignore_scissors $utf8 "$dotest/msg" "$dotest/pat=
ch" \
 			<"$dotest/$msgnum" >"$dotest/info" ||
 			stop_here $this
=20
--=20
1.6.4.1.334.gf42e22
