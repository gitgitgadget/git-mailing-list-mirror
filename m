From: Alessandro Di Marco <dmr@ethzero.com>
Subject: Re: [PATCH] Geolocation support
Date: Thu, 12 Feb 2015 21:50:42 +0100
Message-ID: <87d25ekg65.fsf@ethzero.com>
References: <87mwrncfkh.fsf@ethzero.com>
	<CALkWK0kHEDn4Wt3Y+XUE59_9ZDf504yopMp9QtBUk49Sd+EXbg@mail.gmail.com>
	<CALWbr2w3=DTAMkFtJoLF1_X46fefpEq2WtTb7HGiTiOExFHG3w@mail.gmail.com>
	<7vhahtfuzm.fsf@alter.siamese.dyndns.org> <87h9uwvtm2.fsf@ethzero.com>
	<CAPc5daW5jYAj5z6UMJAQLoWS4L6OH-NSvbGBMd3LO0qCV40a4A@mail.gmail.com>
	<CACBZZX5rgah7Ucek8dicaDeqvjdkR5ybBC5O7PUxE8+KBwrpgA@mail.gmail.com>
	<xmqqlhk6c2zd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 21:50:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM0iq-0004Mt-FI
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 21:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbbBLUus convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Feb 2015 15:50:48 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:53063 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbbBLUur convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 15:50:47 -0500
Received: by mail-wi0-f171.google.com with SMTP id hi2so7399123wib.4
        for <git@vger.kernel.org>; Thu, 12 Feb 2015 12:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:cc:subject:references:from:date:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=tYemDcNyIioaStYYJ6Yd0PDRvlwwyMNLNK+6oNvleAs=;
        b=KuHsr3L4WbhhAp8iYZuWUeE9+aoFY2jFMUdpUjP5AN57SuMCJt+qdl4uWZhzo1+1Ta
         5n3V5g1+zO87SvM2ixP+2FbbRJe7uTu3nJbSF1CaGINMT1YqkznCtAc6HU5//FuefPK7
         Mphttg1vFiVh2uJDq/tKAT5qLY1ddij8TxrrVroZz/cOc5cBXlKZH9e1pQsPUfM1c3Ad
         bpVnDhS/iLVgCvRBXKJ2I5Ld9ne1kgKBxygvZ9C74HmFPv9xCt+JN7XXlvp0Scc25Ncs
         kypUgrnxmRKRkqxKyCucLsNZ1/SHukg+1bZbJNjCse9BNDffjI7Jozp6srdupmFsFu1t
         I0cA==
X-Gm-Message-State: ALoCoQkt6Jnwi5Isq+llotkdUOHY6XptmtsXAqs8mugp7EQWz1xGNoOVHUhbmcZWUNeXnqui9Jrs
X-Received: by 10.180.74.52 with SMTP id q20mr10777436wiv.0.1423774245863;
        Thu, 12 Feb 2015 12:50:45 -0800 (PST)
Received: from ethzero.com (2-230-204-72.ip203.fastwebnet.it. [2.230.204.72])
        by mx.google.com with ESMTPSA id a5sm20906wib.20.2015.02.12.12.50.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2015 12:50:44 -0800 (PST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263768>

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> We've already told clients for a long time to ignore fields they
>> don't know about,

> Yes, but the reason that mechanism is there is not because we want to
> add random cruft Git does not have to know about.  It is to avoid
> older Git from suddenly stop working when we really need to add new
> essential things.

I see, so the problem lays in the info at hand (ie. the commit
location), apparently not enough important to be promoted to the upper
floor. Admittedly all of this is difficult to appreciate unless you are
on the move (as well as the need of a date would be probably questioned
by an highlander), therefore I refined the previous approach.

The new patch here below will allow anybody to import any crufts
into the commit header. Simply define an envvar such as:

export GIT_XT_CRUFT=3D">foo"

and it will place an extra header such as:

xt-cruft foo

in the commit object. I felt free to insert the 'xt-' prefix in order
not to clash with existing and/or future headers of the commit
object. The '>' indicates that the header is not amendable; in case you
want an amendable one simply switch from '>' to '@' as below:

export GIT_XT_CRUFT=3D"@foo"

> More importantly, adding non-essential stuff left and right will forc=
e
> third party Git reimplementations to pay attention to them and also
> will leave room for them to make mistakes when deciding what to
> propagate, what to drop and what to update when rewriting commits via
> rebase, cherry-pick, etc.

??? http://en.wikipedia.org/wiki/Security_through_obscurity

Do you realize that every git I tried so far has happily accepted any
crufts I sent to it via git push? And that they stored that crufts and
then returned it on cloning? :-|

=46eel free to try the below from your client:

<0> $ git clone git@github.com:dmrlsn/iwillmeltyourdata.git
Cloning into 'iwillmeltyourdata'...
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 3 (delta 0)
Receiving objects: 100% (3/3), done.
Checking connectivity... done.

<0> $ cd iwillmeltyourdata/

<0> $ git log --pretty=3Draw | more
commit b704144270528fc6022714861d149441d4102ee9
tree 6bf21934b3b186561626891e2b98f99e6da89e2f
author Alessandro Di Marco <dmr@ethzero.com> 1423770339 +0100
committer Alessandro Di Marco <dmr@ethzero.com> 1423770339 +0100
xt-committer-location Tokyo, Japan (35.685, 139.7514)
xt-author-location Tokyo, Japan (35.685, 139.7514)

    Minor changes

^^ obtained by defining:

declare -x GIT_XT_AUTHOR_LOCATION=3D">Tokyo, Japan (35.685, 139.7514)"
declare -x GIT_XT_COMMITTER_LOCATION=3D"@Tokyo, Japan (35.685, 139.7514=
)"

prior committing.

> I think this sentence gets it backwards.  The question to ask is if i=
t
> is an arbitrary cruft that the end users are better off if they can
> easily typofix in the commit message log editor, or is it essential
> for Git to operate correctly and end users shouldn't be allowed to
> muck with in the editor?

>>> The expected location format is "CITY, COUNTRY (LAT, LON)".

> I would expect that I can typofix "Les Angeles" to "Los Angeles",
> if I were using this feature.

Well, what about a format such as "(LAT, LON)"? Would you expect to
typofix it too? If so, why don't you put the date on the commit message
as well? Your clock could fail, after all...


Signed-off-by: Alessandro Di Marco <dmr@ethzero.com>
---
 builtin/commit.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
 commit.c         |  14 ++++----
 commit.h         |   3 +-
 3 files changed, 114 insertions(+), 11 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 7f46713..0ff4aef 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -623,6 +623,100 @@ static int author_date_is_interesting(void)
 	return author_message || force_date;
 }

+static void exclude_free(char ***exclude) {
+	char **p =3D *exclude;
+	int len;
+
+	for (len =3D 0; p[len]; len++) {
+		free(p[len]);
+	}
+	free(p);
+	*exclude =3D NULL;
+}
+
+static void exclude_one(char ***exclude, char *what)
+{
+	char **p =3D *exclude;
+	int len;
+
+	for (len =3D 0; p && p[len]; len++);
+	p =3D *exclude =3D xrealloc(p, (len + 2) * sizeof (char *));
+	p[len] =3D xmalloc(strlen(what) + 1);
+	p[len + 1] =3D NULL;
+	strcpy(p[len], what);
+}
+
+static char *env2extra(char *var)
+{
+	int i, l =3D strlen(var);
+
+	for (i =3D 0; i < l; i++) {
+		if (var[i] >=3D 'A' && var[i] <=3D 'Z') {
+			var[i] +=3D 32;
+		} else if (var[i] =3D=3D '_') {
+			var[i] =3D '-';
+		}
+	}
+	memcpy(var -=3D 3, "xt-", 3);
+	return var;
+}
+
+static void determine_xt_vars(struct strbuf *xtvars, char ***exclude)
+{
+	extern char **environ;
+	int i;
+
+	for (i =3D 0; environ[i]; i++) {
+		char *p, *var, *xtvar, *val;
+		int l, amending;
+
+		if (strncmp(environ[i], "GIT_XT_", 7)) {
+			continue;
+		}
+
+		p =3D strchr(environ[i], '=3D');
+		if (!p) {
+			continue;
+		}
+
+		l =3D p - environ[i];
+
+		var =3D xmalloc(l + 1);
+		memcpy(var, environ[i], l);
+		var[l] =3D '\0';
+
+		val =3D getenv(var);
+		if (strlen(val) < 2) {
+			free(var);
+			continue;
+		}
+
+		xtvar =3D env2extra(&var[7]);
+		amending =3D amend;
+
+		switch(val[0]) {
+		case '@':
+			if (amending) {
+				exclude_one(exclude, xtvar);
+				amending =3D 0;
+			}
+			/* fall-through */
+		case '>':
+			if (!amending) {
+				strbuf_addstr(xtvars, xtvar);
+				strbuf_addch(xtvars, ' ');
+				strbuf_addstr(xtvars, val + 1);
+				strbuf_addch(xtvars, '\n');
+			}
+			break;
+		default:
+			/* malformed xtvar, ignore */
+			break;
+		}
+		free(var);
+	}
+}
+
 static void adjust_comment_line_char(const struct strbuf *sb)
 {
 	char candidates[] =3D "#;@!$%^&|:";
@@ -1624,6 +1718,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)

 	struct strbuf sb =3D STRBUF_INIT;
 	struct strbuf author_ident =3D STRBUF_INIT;
+	struct strbuf xtvars =3D STRBUF_INIT;
 	const char *index_file, *reflog_msg;
 	char *nl;
 	unsigned char sha1[20];
@@ -1663,6 +1758,9 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 		return 1;
 	}

+	char **exclude =3D NULL;
+	determine_xt_vars(&xtvars, &exclude);
+
 	/* Determine parents */
 	reflog_msg =3D getenv("GIT_REFLOG_ACTION");
 	if (!current_head) {
@@ -1739,13 +1837,19 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
 	}

 	if (amend) {
-		const char *exclude_gpgsig[2] =3D { "gpgsig", NULL };
-		extra =3D read_commit_extra_headers(current_head, exclude_gpgsig);
+		exclude_one(&exclude, "gpgsig");
+		extra =3D read_commit_extra_headers(current_head, exclude);
+		exclude_free(&exclude);
 	} else {
 		struct commit_extra_header **tail =3D &extra;
 		append_merge_tag_headers(parents, &tail);
 	}

+	if (xtvars.len > 0) {
+		extra =3D read_commit_extra_header_lines(xtvars.buf, xtvars.len, NUL=
L, extra);
+	}
+	strbuf_release(&xtvars);
+
 	if (commit_tree_extended(sb.buf, sb.len, active_cache_tree->sha1,
 			 parents, sha1, author_ident.buf, sign_commit, extra)) {
 		rollback_index_files();
diff --git a/commit.c b/commit.c
index a8c7577..48fc4c0 100644
--- a/commit.c
+++ b/commit.c
@@ -12,8 +12,6 @@
 #include "prio-queue.h"
 #include "sha1-lookup.h"

-static struct commit_extra_header *read_commit_extra_header_lines(cons=
t char *buf, size_t len, const char **);
-
 int save_commit_buffer =3D 1;

 const char *commit_type =3D "commit";
@@ -1279,12 +1277,12 @@ static void add_extra_header(struct strbuf *buf=
fer,
 }

 struct commit_extra_header *read_commit_extra_headers(struct commit *c=
ommit,
-						      const char **exclude)
+						      char **exclude)
 {
 	struct commit_extra_header *extra =3D NULL;
 	unsigned long size;
 	const char *buffer =3D get_commit_buffer(commit, &size);
-	extra =3D read_commit_extra_header_lines(buffer, size, exclude);
+	extra =3D read_commit_extra_header_lines(buffer, size, exclude, extra=
);
 	unuse_commit_buffer(commit, buffer);
 	return extra;
 }
@@ -1311,7 +1309,7 @@ static inline int standard_header_field(const cha=
r *field, size_t len)
 		(len =3D=3D 8 && !memcmp(field, "encoding ", 9)));
 }

-static int excluded_header_field(const char *field, size_t len, const =
char **exclude)
+static int excluded_header_field(const char *field, size_t len, char *=
*exclude)
 {
 	if (!exclude)
 		return 0;
@@ -1326,11 +1324,11 @@ static int excluded_header_field(const char *fi=
eld, size_t len, const char **exc
 	return 0;
 }

-static struct commit_extra_header *read_commit_extra_header_lines(
+struct commit_extra_header *read_commit_extra_header_lines(
 	const char *buffer, size_t size,
-	const char **exclude)
+	char **exclude, struct commit_extra_header *extra)
 {
-	struct commit_extra_header *extra =3D NULL, **tail =3D &extra, *it =3D=
 NULL;
+	struct commit_extra_header **tail =3D extra ? &extra->next : &extra, =
*it =3D NULL;
 	const char *line, *next, *eof, *eob;
 	struct strbuf buf =3D STRBUF_INIT;

diff --git a/commit.h b/commit.h
index 9f189cb..f126d51 100644
--- a/commit.h
+++ b/commit.h
@@ -324,7 +324,8 @@ extern int commit_tree_extended(const char *msg, si=
ze_t msg_len,
 				const char *author, const char *sign_commit,
 				struct commit_extra_header *);

-extern struct commit_extra_header *read_commit_extra_headers(struct co=
mmit *, const char **);
+extern struct commit_extra_header *read_commit_extra_headers(struct co=
mmit *, char **);
+extern struct commit_extra_header *read_commit_extra_header_lines(cons=
t char *, size_t, char **, struct commit_extra_header *);

 extern void free_commit_extra_headers(struct commit_extra_header *extr=
a);

--
2.0.5
