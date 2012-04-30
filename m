From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/5] i18n: Add more TRANSLATORS comments
Date: Mon, 30 Apr 2012 15:33:11 +0000
Message-ID: <1335799995-7667-3-git-send-email-avarab@gmail.com>
References: <1335799995-7667-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 17:33:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOsbe-0001J5-VM
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 17:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129Ab2D3Pdd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 11:33:33 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55592 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049Ab2D3Pdb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 11:33:31 -0400
Received: by mail-bk0-f46.google.com with SMTP id ji2so383521bkc.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 08:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=10THhMW2yK1LpcIgMpqB6TdIWBjt/tDj3glytVJiMFI=;
        b=JomwZqVzOyQ9j3bB3HJCRyPxrhMXqNK2+XmoAPZ4cNxj9TRaKrnWnOsmeRNw7RBE3I
         fQUzkvArUXa52mukTEpSRaNUzN43f2T6+aqNNlaAdL4Ndhei0TZPVdntN3hk43URnrEk
         03k9hj7ASbTEuK5k9wbhhiR4fF46LLepqwZoxCs9LrofrdTA7yV6edUQniTKmiRqW1kp
         pV69VHzZ++cppl789tWLsznGjZ+gbmCUw155qFzsufrM7Q+n9rNAfWfK8OrYPvXEYu2n
         bpTVPZBjPOqTHIeBFi0mOX+YgaBF2eaxMjqpk0+vzam5Ot7ziImNuMf81a9x/7KPBCTx
         po5g==
Received: by 10.204.153.12 with SMTP id i12mr75379bkw.120.1335800010560;
        Mon, 30 Apr 2012 08:33:30 -0700 (PDT)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id jr13sm27636569bkb.14.2012.04.30.08.33.29
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Apr 2012 08:33:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.546.gbaa1a.dirty
In-Reply-To: <1335799995-7667-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196570>

I took a pass through git.pot and added comments to various messages
that could use one, comments still need to be added to a lot of other
things, but you have to start somewhere.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 advice.c    |    3 +++
 bundle.c    |    5 +++++
 commit.c    |    4 ++++
 connected.c |    3 +++
 diff.c      |    1 +
 remote.c    |   10 ++++++++++
 sequencer.c |   10 ++++++++++
 7 files changed, 36 insertions(+)

diff --git a/advice.c b/advice.c
index a492eea..5944abb 100644
--- a/advice.c
+++ b/advice.c
@@ -37,6 +37,9 @@ void advise(const char *advice, ...)
=20
 	for (cp =3D buf.buf; *cp; cp =3D np) {
 		np =3D strchrnul(cp, '\n');
+		/* TRANSLATORS: This will be used to prefix each line of an
+		 * advice message, with the format string being the line
+		 */
 		fprintf(stderr,	_("hint: %.*s\n"), (int)(np - cp), cp);
 		if (*np)
 			np++;
diff --git a/bundle.c b/bundle.c
index 8d31b98..f24999e 100644
--- a/bundle.c
+++ b/bundle.c
@@ -86,6 +86,7 @@ int read_bundle_header(const char *path, struct bundl=
e_header *header)
 	int fd =3D open(path, O_RDONLY);
=20
 	if (fd < 0)
+		/* TRANSLATORS: The argument is a path that can't be opened */
 		return error(_("could not open '%s'"), path);
 	return parse_bundle_header(fd, header, path);
 }
@@ -137,6 +138,9 @@ int verify_bundle(struct bundle_header *header, int=
 verbose)
 	struct object_array refs;
 	struct commit *commit;
 	int i, ret =3D 0, req_nr;
+	/* TRANSLATORS: This is a heading that'll precede a list of commit
+	 * hashes and reference names
+	 */
 	const char *message =3D _("Repository lacks these prerequisite commit=
s:");
=20
 	init_revisions(&revs, NULL);
@@ -412,6 +416,7 @@ int create_bundle(struct bundle_header *header, con=
st char *path,
 		return error(_("pack-objects died"));
 	if (!bundle_to_stdout) {
 		if (commit_lock_file(&lock))
+			/* TRANSLATORS: The argument is a path we can't create */
 			die_errno(_("cannot create '%s'"), path);
 	}
 	return 0;
diff --git a/commit.c b/commit.c
index 9ed36c7..a4ee4b7 100644
--- a/commit.c
+++ b/commit.c
@@ -45,8 +45,12 @@ struct commit *lookup_commit_or_die(const unsigned c=
har *sha1, const char *ref_n
 {
 	struct commit *c =3D lookup_commit_reference(sha1);
 	if (!c)
+		/* TRANSLATORS: The argument is a reference name */
 		die(_("could not parse %s"), ref_name);
 	if (hashcmp(sha1, c->object.sha1)) {
+		/* TRANSLATORS: The first argument is a refname, the second is
+		 * a commit hash
+		 */
 		warning(_("%s %s is not a commit!"),
 			ref_name, sha1_to_hex(sha1));
 	}
diff --git a/connected.c b/connected.c
index 1e89c1c..cdd9813 100644
--- a/connected.c
+++ b/connected.c
@@ -45,6 +45,9 @@ int check_everything_connected(sha1_iterate_fn fn, in=
t quiet, void *cb_data)
 		memcpy(commit, sha1_to_hex(sha1), 40);
 		if (write_in_full(rev_list.in, commit, 41) < 0) {
 			if (errno !=3D EPIPE && errno !=3D EINVAL)
+				/* TRANSLATORS: The argument is a strerror()
+				 * message
+				 */
 				error(_("failed write to rev-list: %s"),
 				      strerror(errno));
 			err =3D -1;
diff --git a/diff.c b/diff.c
index 5d06375..0d4534a 100644
--- a/diff.c
+++ b/diff.c
@@ -3436,6 +3436,7 @@ static int parse_dirstat_opt(struct diff_options =
*options, const char *params)
 {
 	struct strbuf errmsg =3D STRBUF_INIT;
 	if (parse_dirstat_params(options, params, &errmsg))
+		/* TRANSLATORS: The argument is an error message */
 		die(_("Failed to parse --dirstat/-X option parameter:\n%s"),
 		    errmsg.buf);
 	strbuf_release(&errmsg);
diff --git a/remote.c b/remote.c
index b296d17..14e7332 100644
--- a/remote.c
+++ b/remote.c
@@ -1604,12 +1604,18 @@ int format_tracking_info(struct branch *branch,=
 struct strbuf *sb)
 	base =3D shorten_unambiguous_ref(base, 0);
 	if (!num_theirs)
 		strbuf_addf(sb,
+			/* TRANSLATORS: the first argument is a branch name, the
+			 * second is a count of how many commits we're ahead of it
+			 */
 			Q_("Your branch is ahead of '%s' by %d commit.\n",
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   num_ours),
 			base, num_ours);
 	else if (!num_ours)
 		strbuf_addf(sb,
+			/* TRANSLATORS: the first argument is a branch name, the
+			 * second is a count of how many commits we're behind it
+			 */
 			Q_("Your branch is behind '%s' by %d commit, "
 			       "and can be fast-forwarded.\n",
 			   "Your branch is behind '%s' by %d commits, "
@@ -1618,6 +1624,10 @@ int format_tracking_info(struct branch *branch, =
struct strbuf *sb)
 			base, num_theirs);
 	else
 		strbuf_addf(sb,
+			/* TRANSLATORS: the first argument is a branch name, the
+			 * second and third arguments are counts of how many
+			 * commits they've diverged by
+			 */
 			Q_("Your branch and '%s' have diverged,\n"
 			       "and have %d and %d different commit each, "
 			       "respectively.\n",
diff --git a/sequencer.c b/sequencer.c
index f83cdfd..b284cf8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -118,8 +118,14 @@ static void write_cherry_pick_head(struct commit *=
commit, const char *pseudoref)
 	filename =3D git_path("%s", pseudoref);
 	fd =3D open(filename, O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
+		/* TRANSLATORS: The argument is a filename that can't be
+		 * opened for writing
+		 */
 		die_errno(_("Could not open '%s' for writing"), filename);
 	if (write_in_full(fd, buf.buf, buf.len) !=3D buf.len || close(fd))
+		/* TRANSLATORS: The argument is a filename that can't be
+		 * opened for writing
+		 */
 		die_errno(_("Could not write to '%s'"), filename);
 	strbuf_release(&buf);
 }
@@ -157,6 +163,9 @@ static void write_message(struct strbuf *msgbuf, co=
nst char *filename)
 	int msg_fd =3D hold_lock_file_for_update(&msg_file, filename,
 					       LOCK_DIE_ON_ERROR);
 	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
+		/* TRANSLATORS: The argument is a filename that can't be
+		 * written to
+		 */
 		die_errno(_("Could not write to %s"), filename);
 	strbuf_release(msgbuf);
 	if (commit_lock_file(&msg_file) < 0)
@@ -365,6 +374,7 @@ static int do_pick_commit(struct commit *commit, st=
ruct replay_opts *opts)
 		struct commit_list *p;
=20
 		if (!opts->mainline)
+			/* TRANSLATORS: The argument is a commit digest */
 			return error(_("Commit %s is a merge but no -m option was given."),
 				sha1_to_hex(commit->object.sha1));
=20
--=20
1.7.10.546.gbaa1a.dirty
