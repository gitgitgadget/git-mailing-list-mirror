From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH v2] optionally disable overwriting of ignored files
Date: Sat, 21 Aug 2010 08:48:44 +0200
Message-ID: <20100821064844.GA29968@localhost>
References: <4C6A1C5B.4030304@workspacewhiz.com>
 <7viq39avay.fsf@alter.siamese.dyndns.org>
 <20100818233900.GA27531@localhost>
 <7vtymp9fn1.fsf@alter.siamese.dyndns.org>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 08:49:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmhtD-0000gl-Np
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 08:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278Ab0HUGs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 02:48:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34357 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab0HUGsz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 02:48:55 -0400
Received: by fxm13 with SMTP id 13so2182687fxm.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 23:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=GKB5EXAKZIg2bi+l4fq736GHSY6PdrdQshc7DH+llUA=;
        b=Os35P1Hy/ufxzYcasgkR1l/CsMnwfug1gKsqYGPawgrZL+NE3IG7K4TBX9+6OBfSKr
         93PXe2cac4VAfJ1Mfz7kJZUapmOivAXdcKPpAYV14+HG+ycTdVsCzCDLrVSfD/TFEzH/
         sWCD5e9igaBr6Y77SucJJUs+S/buG2Oh4PsJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=udgcXgsW3EBpPCWQ1OhWBWwazLXQ1WEKcB8SUm3WirgITbbrR6+IEsPsYpeGqfwRYs
         NXE7eFOIn5CeIywh2KtPpCy06uFN6OCFltRov4vnp31KafhAbkLCt07fCDfuwNTGdfWl
         DYzAbYWHuaB+DapmvASbdo/OFm4C5JAqjRkCA=
Received: by 10.223.104.15 with SMTP id m15mr1859198fao.103.1282373331349;
        Fri, 20 Aug 2010 23:48:51 -0700 (PDT)
Received: from darc.lan (p549A39C7.dip.t-dialin.net [84.154.57.199])
        by mx.google.com with ESMTPS id t6sm1498097faa.27.2010.08.20.23.48.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 23:48:49 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1Omhsi-0007oc-DJ; Sat, 21 Aug 2010 08:48:44 +0200
Content-Disposition: inline
In-Reply-To: <7vtymp9fn1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154117>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Fri, Aug 20, 2010 at 01:46:10PM -0700, Junio C Hamano wrote:
>        =20
> What is this patch based on?
         =20
Oops, I forgot to squash an intermediate commit. This is based on
v1.7.2.1.

 Documentation/config.txt |    6 ++++++
 builtin/checkout.c       |   10 +++++++---
 builtin/merge.c          |   10 +++++++---
 cache.h                  |    1 +
 config.c                 |    3 +++
 environment.c            |    1 +
 6 files changed, 25 insertions(+), 6 deletions(-)

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
index 1994be9..121a6a3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -389,9 +389,11 @@ static int merge_working_tree(struct checkout_opts *op=
ts,
 		topts.gently =3D opts->merge && old->commit;
 		topts.verbose_update =3D !opts->quiet;
 		topts.fn =3D twoway_merge;
-		topts.dir =3D xcalloc(1, sizeof(*topts.dir));
-		topts.dir->flags |=3D DIR_SHOW_IGNORED;
-		topts.dir->exclude_per_dir =3D ".gitignore";
+		if (overwrite_ignored) {
+			topts.dir =3D xcalloc(1, sizeof(*topts.dir));
+			topts.dir->flags |=3D DIR_SHOW_IGNORED;
+			topts.dir->exclude_per_dir =3D ".gitignore";
+		}
 		tree =3D parse_tree_indirect(old->commit ?
 					   old->commit->object.sha1 :
 					   (unsigned char *)EMPTY_TREE_SHA1_BIN);
@@ -667,6 +669,8 @@ int cmd_checkout(int argc, const char **argv, const cha=
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
index 37ce4f5..47b12ba 100644
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
@@ -693,9 +695,11 @@ int checkout_fast_forward(const unsigned char *head, c=
onst unsigned char *remote
 	memset(&opts, 0, sizeof(opts));
 	memset(&t, 0, sizeof(t));
 	memset(&dir, 0, sizeof(dir));
-	dir.flags |=3D DIR_SHOW_IGNORED;
-	dir.exclude_per_dir =3D ".gitignore";
-	opts.dir =3D &dir;
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


--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMb3bMAAoJELKdZexG8uqMAUoH/irQ3fZMrbVg/6oi1W5j6GuI
sC7IW633a/rCsA7vVa2JsOkSZXvwcw6Ua8ryX/1ybp9u/o5CmogVYYWyjOJDK5Vh
vOX/xvf+uuR4xyWX+0O6z9NSw/hThZDIsuKY5fWzJVQ+8/Qk8oBXBOeB5KsMg/0L
n17d12hF3LxK0XDuEcG7Gcfydi6qlIwrdSnQBUy0msff59sKcKuZXbc5xRjfaxwl
xrjmETRqLw+2h8H0cPGfrpOyAD1LbRP+zZOqjyaBpbqM1CQUQmg+J6HkqsK0hpE6
QUwq9N048UkYRYG5PrSGB507Zs1qidaIAAt7bmExZU/rCeaJwps1Se3EVp48UPo=
=dmiZ
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
