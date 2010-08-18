From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] optionally disable overwriting of ignored files
Date: Thu, 19 Aug 2010 01:39:00 +0200
Message-ID: <20100818233900.GA27531@localhost>
References: <4C6A1C5B.4030304@workspacewhiz.com>
 <7viq39avay.fsf@alter.siamese.dyndns.org>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 01:39:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlsEC-0003mc-Cg
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 01:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673Ab0HRXjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 19:39:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57084 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab0HRXjP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 19:39:15 -0400
Received: by fxm13 with SMTP id 13so675585fxm.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 16:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=n/xqrhjzayhuOEAfxcnRBNX2Li0dWLESH8l2Di8YQr4=;
        b=xDpFxWvODJq0N7+1t3mtAIPhKFQLVEVQPF54erEkjVvYI1SxD9a583a1XpuRt7sBQK
         N7GNpzMqQtwFQNRbYD+JaQMi1Mdv3ql723O2zDpjzvyBy5ckommp5oy69nav5XaKRyV+
         a+1NVjpdxj5YPAEKXNr/3EW7O1UAW9IghadqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=Vzyad/+Q+CPsJ8DR0vS/BIqEQO8qrwFvjK5Pyp2CyFA4M+8XmiLThhx3uVSk+rUHd9
         oSi0g2m9lDYIF0eV5HtKxHng8r+R448sEfKZl8pRJFq25fnndeCq+ymlUxmqy/HpcyAZ
         Q1vg6CJPhwAzyipRi/CdAcqKZRg8DUmGgJYiU=
Received: by 10.223.126.84 with SMTP id b20mr8459775fas.98.1282174754453;
        Wed, 18 Aug 2010 16:39:14 -0700 (PDT)
Received: from darc.lan (p549A54DC.dip.t-dialin.net [84.154.84.220])
        by mx.google.com with ESMTPS id q17sm409301faa.45.2010.08.18.16.39.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 16:39:13 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OlsDk-0007EM-UF; Thu, 19 Aug 2010 01:39:00 +0200
Content-Disposition: inline
In-Reply-To: <7viq39avay.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153897>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

By default, checkout and fast-forward merge will overwrite ignored
files. Make this behavior configurable.

If overwriting ignored files is disabled, it can still be enabled
on the command line by passing -i to merge or checkout.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

Hi,

On Tue, Aug 17, 2010 at 12:33:25PM -0700, Junio C Hamano wrote:
>
> Ancient git didn't honor gitignore and considered no files trashable,
> which caused a lot of trouble to users.  It may be illuminating to check
> discussions in the list archive during the period the following commits
> were made.  f8a9d42 (read-tree: further loosen "working file will be lost"
> check., 2006-12-04), ed93b44 (merge: loosen overcautious "working file
> will be lost" check., 2006-10-08), c819353 (Fix switching to a branch with
> D/F when current branch has file D., 2007-03-15).

I am not convinced this is something that most users want.

The fact that adding a file to .gitignore also marks it as
trashable to git is quite surprising to me. This is something that
the gitignore manpage should warn about loudly. Instead, I think
this behavior is completely undocumented.

As far as I can tell from the code, only fast-forward merge and
checkout overwrite ignored files by default. A regular merge will
complain about untracked files that would be overwritten (ignored
or not). I am quite familiar with that behavior and I think it's
useful to be reminded of those untracked files rather than having
them overwritten. I thought that by extension, other git commands
would behave in the same way.

Here is a patch to optionally disable overwriting of ignored files.
But I think we should even disable it by default.=20

Clemens

 Documentation/config.txt |    6 ++++++
 builtin/checkout.c       |    7 +++++++
 builtin/merge.c          |    9 +++++++++
 cache.h                  |    1 +
 config.c                 |    3 +++
 environment.c            |    1 +
 6 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f81fb91..eb9bb43 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -450,6 +450,12 @@ core.excludesfile::
 	to the value of `$HOME` and "{tilde}user/" to the specified user's
 	home directory.  See linkgit:gitignore[5].
=20
+core.overwriteignored::
+	Untracked files can get in the way of merge or checkout. If
+	overwriteignored is enabled, such files will be overwritten
+	to let fast-forward merges and checkouts succeed. Enabled
+	by default.
+
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
 	messages by launching an editor uses the value of this
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5affb6f..121a6a3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -389,6 +389,11 @@ static int merge_working_tree(struct checkout_opts *op=
ts,
 		topts.gently =3D opts->merge && old->commit;
 		topts.verbose_update =3D !opts->quiet;
 		topts.fn =3D twoway_merge;
+		if (overwrite_ignored) {
+			topts.dir =3D xcalloc(1, sizeof(*topts.dir));
+			topts.dir->flags |=3D DIR_SHOW_IGNORED;
+			topts.dir->exclude_per_dir =3D ".gitignore";
+		}
 		tree =3D parse_tree_indirect(old->commit ?
 					   old->commit->object.sha1 :
 					   (unsigned char *)EMPTY_TREE_SHA1_BIN);
@@ -664,6 +669,8 @@ int cmd_checkout(int argc, const char **argv, const cha=
r *prefix)
 		OPT_SET_INT('3', "theirs", &opts.writeout_stage, "stage",
 			    3),
 		OPT_BOOLEAN('f', "force", &opts.force, "force"),
+		OPT_BOOLEAN('i', "overwrite-ignored", &overwrite_ignored,
+		  "allow explicitly ignored files to be overwritten"),
 		OPT_BOOLEAN('m', "merge", &opts.merge, "merge"),
 		OPT_STRING(0, "conflict", &conflict_style, "style",
 			   "conflict style (merge or diff3)"),
diff --git a/builtin/merge.c b/builtin/merge.c
index 4d31e09..47b12ba 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -185,6 +185,8 @@ static struct option builtin_merge_options[] =3D {
 		"allow fast-forward (default)"),
 	OPT_BOOLEAN(0, "ff-only", &fast_forward_only,
 		"abort if fast-forward is not possible"),
+	OPT_BOOLEAN('i', "overwrite-ignored", &overwrite_ignored,
+	  "allow explicitly ignored files to be overwritten"),
 	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 	OPT_CALLBACK('s', "strategy", &use_strategies, "strategy",
 		"merge strategy to use", option_parse_strategy),
@@ -682,6 +684,7 @@ int checkout_fast_forward(const unsigned char *head, co=
nst unsigned char *remote
 	struct unpack_trees_options opts;
 	struct tree_desc t[MAX_UNPACK_TREES];
 	int i, fd, nr_trees =3D 0;
+	struct dir_struct dir;
 	struct lock_file *lock_file =3D xcalloc(1, sizeof(struct lock_file));
=20
 	refresh_cache(REFRESH_QUIET);
@@ -691,6 +694,12 @@ int checkout_fast_forward(const unsigned char *head, c=
onst unsigned char *remote
 	memset(&trees, 0, sizeof(trees));
 	memset(&opts, 0, sizeof(opts));
 	memset(&t, 0, sizeof(t));
+	memset(&dir, 0, sizeof(dir));
+	if (overwrite_ignored) {
+		dir.flags |=3D DIR_SHOW_IGNORED;
+		dir.exclude_per_dir =3D ".gitignore";
+		opts.dir =3D &dir;
+	}
=20
 	opts.head_idx =3D 1;
 	opts.src_index =3D &the_index;
diff --git a/cache.h b/cache.h
index c9fa3df..dd1b8f7 100644
--- a/cache.h
+++ b/cache.h
@@ -548,6 +548,7 @@ extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern int read_replace_refs;
+extern int overwrite_ignored;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
diff --git a/config.c b/config.c
index cdcf583..bd7956e 100644
--- a/config.c
+++ b/config.c
@@ -563,6 +563,9 @@ static int git_default_core_config(const char *var, con=
st char *value)
 	if (!strcmp(var, "core.excludesfile"))
 		return git_config_pathname(&excludes_file, var, value);
=20
+	if (!strcmp(var, "core.overwriteignored"))
+		overwrite_ignored =3D git_config_bool(var, value);
+
 	if (!strcmp(var, "core.whitespace")) {
 		if (!value)
 			return config_error_nonbool(var);
diff --git a/environment.c b/environment.c
index 83d38d3..1b92f60 100644
--- a/environment.c
+++ b/environment.c
@@ -30,6 +30,7 @@ const char *apply_default_ignorewhitespace;
 int zlib_compression_level =3D Z_BEST_SPEED;
 int core_compression_level;
 int core_compression_seen;
+int overwrite_ignored =3D 1;
 int fsync_object_files;
 size_t packed_git_window_size =3D DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit =3D DEFAULT_PACKED_GIT_LIMIT;
--=20
1.7.2.1.1.g202c


--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMbG8QAAoJELKdZexG8uqMCCUIAJx9De3oa0pKHFh8n8n+F4Ez
MHmFjLFu/Ijamzm+W091dE9LrBu3p8AFHeI084iKAn+bXOxK6SiHbmESFJ2gWtrw
MmK1VY3wa+MES54UScC/rUZkaAuNxpEmmdFsscZOEiIRnSEMfLoACzpet3LTm/Qz
wREBFM1stmedLN0LAi55XVLLcJYvnt4uWnKbrC1VK9u0huGblVaE1It9XZjtsDIZ
NMep21ZNhtHZsJUIS7SulPramBaecTVhuhqiyQVnMIPaS6osL5h9nWwn/DXABoSc
j1uQg6o78pK5MKfmyUF2Ls/FD4iVRjvCKqfdSUm9X2DzPOZds0yvKf/YHWTSGMM=
=6oTP
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
