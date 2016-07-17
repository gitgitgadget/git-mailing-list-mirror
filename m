Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90C5020195
	for <e@80x24.org>; Sun, 17 Jul 2016 11:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbcGQLAE (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 07:00:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:61966 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbcGQK77 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 06:59:59 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lyi0B-1bKf6e0kDP-0163vI; Sun, 17 Jul 2016 12:59:51
 +0200
Date:	Sun, 17 Jul 2016 12:59:49 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/4] fsck_walk(): optionally name objects on the go
In-Reply-To: <cover.1468752290.git.johannes.schindelin@gmx.de>
Message-ID: <cd7d97f566484e146eccebe0a0a2335c852bb532.1468752290.git.johannes.schindelin@gmx.de>
References: <cover.1468510191.git.johannes.schindelin@gmx.de> <cover.1468752290.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-940045425-1468753191=:28832"
X-Provags-ID: V03:K0:lKw7/tmG6i5zNyCS6w4+Jk9KOTceo/85CVtvEkLD+xZmcjQJqe6
 tzrBoBrlgQ8GkElo2Ox89uN5yQulKN8J1Hhyz5R18ynSQae0qLxTy8Ddl9ItoUiqOPQ8keQ
 Rawo6F9iG2wxaRhma2CFI2NJJBX6WBroe3ZaNUlP/Ju3Fj8/n3cgD7qAJFVRMO4iLS43zGA
 evZ9RJvMg5DYislU+xKsw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:5VRqP30wUcE=:vbdvZZFy23qrgZJGr7sS+3
 kxF7GyjVMlT4ZnTYCnxiO/2xej0HNYkY1kuIJIeO/ylOQ1iJditV7mFOdvXDYIMfClFwRDKYq
 ogni65ecvw+oIgcPan27ADk/L2V0rFpPHQ2w7kEvx0D9tXl8OmcoySUmqRLAPfAUUj9hh1Nk4
 Sgu829vvT9hbjl6QsJQMGUnQHGiAvq649PKbEyOcZU7OBEYg7MXRaOiQF6sc9Jkdxxbw6hcEN
 0kyOgs2+tpbd+Q/qXgmtU9f4u9KCPj/4F0eFUbjgwhIea4lLS4Kc1TfMnHoKJ/ZuaZD5NSCfj
 QWfRTsVVKXpTladOoW6P+itTHzWjCZNaxqpo2TZobE7t/yO9EldFvCgCxowkPf3hpC3AzlxDV
 6UCQJZwXKbrahIwwULkjXIH6E5mhhKi8XIcEupYeRXmR3NT1tuUfHCvfUoa3GRsAA+hG/AKRx
 13BnjrNOdZ9tz1RmPIC3+6CG0dJCz74pq7ztIRvSO3t9AWaS8Rd+0ye1XgCp0UoGwaRyMhrzo
 YV/FsuJE+HprCFapmpuN5c1K4e3KJKPGf3C3e2x5J4aJXoaLr2/e2nEgzhIypdv8/Y/+x5cKA
 FLFydwfWLLwwNCE1F4lS8LDpN4ETRtyDUsaxERXAkp2os5MVKQ8A94s2KPxpQnD2595gZQN9J
 MbQ4KCSF7XgQVEAy1rXSIs6DXcn9d1QAx5MVRW9uu1NPT8fTyYsToVVCG73iGi0dXjxSJ9Q0u
 OCO7OWCenex856003duiWdMvGFGhvn/CaiVgxdZOG1NV14vC5HzT5jHJfSH4kuRKzokiXVL9z
 JCMe2QT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-940045425-1468753191=:28832
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

If fsck_options->name_objects is initialized, and if it already has
name(s) for the object(s) that are to be the starting point(s) for
fsck_walk(), then that function will now add names for the objects
that were walked.

This will be highly useful for teaching git-fsck to identify root causes
for broken links, which is the task for the next patch in this series.

Note that this patch opts for decorating the objects with plain strings
instead of full-blown structs (=C3=A0 la `struct rev_name` in the code of
the `git name-rev` command), for several reasons:

- the code is much simpler than if it had to work with structs that
  describe arbitrarily long names such as "master~14^2~5:builtin/am.c",

- the string processing is actually quite light-weight compared to the
  rest of fsck's operation,

- the caller of fsck_walk() is expected to provide names for the
  starting points, and using plain and simple strings is just the
  easiest way to do that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 fsck.h |  1 +
 2 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index 0531545..6ed90ec 100644
--- a/fsck.c
+++ b/fsck.c
@@ -9,6 +9,7 @@
 #include "refs.h"
 #include "utf8.h"
 #include "sha1-array.h"
+#include "decorate.h"
=20
 #define FSCK_FATAL -1
 #define FSCK_INFO -2
@@ -297,25 +298,64 @@ static int report(struct fsck_options *options, struc=
t object *object,
 =09return result;
 }
=20
+static char *get_object_name(struct fsck_options *options, struct object *=
obj)
+{
+=09if (!options->object_names)
+=09=09return NULL;
+=09return lookup_decoration(options->object_names, obj);
+}
+
+static void put_object_name(struct fsck_options *options, struct object *o=
bj,
+=09const char *fmt, ...)
+{
+=09va_list ap;
+=09struct strbuf buf =3D STRBUF_INIT;
+=09char *existing;
+
+=09if (!options->object_names)
+=09=09return;
+=09existing =3D lookup_decoration(options->object_names, obj);
+=09if (existing)
+=09=09return;
+=09va_start(ap, fmt);
+=09strbuf_vaddf(&buf, fmt, ap);
+=09add_decoration(options->object_names, obj, strbuf_detach(&buf, NULL));
+=09va_end(ap);
+}
+
 static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_optio=
ns *options)
 {
 =09struct tree_desc desc;
 =09struct name_entry entry;
 =09int res =3D 0;
+=09const char *name;
=20
 =09if (parse_tree(tree))
 =09=09return -1;
=20
+=09name =3D get_object_name(options, &tree->object);
 =09init_tree_desc(&desc, tree->buffer, tree->size);
 =09while (tree_entry(&desc, &entry)) {
+=09=09struct object *obj;
 =09=09int result;
=20
 =09=09if (S_ISGITLINK(entry.mode))
 =09=09=09continue;
-=09=09if (S_ISDIR(entry.mode))
-=09=09=09result =3D options->walk(&lookup_tree(entry.oid->hash)->object, O=
BJ_TREE, data, options);
-=09=09else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode))
-=09=09=09result =3D options->walk(&lookup_blob(entry.oid->hash)->object, O=
BJ_BLOB, data, options);
+
+=09=09if (S_ISDIR(entry.mode)) {
+=09=09=09obj =3D &lookup_tree(entry.oid->hash)->object;
+=09=09=09if (name)
+=09=09=09=09put_object_name(options, obj, "%s%s/", name,
+=09=09=09=09=09entry.path);
+=09=09=09result =3D options->walk(obj, OBJ_TREE, data, options);
+=09=09}
+=09=09else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode)) {
+=09=09=09obj =3D &lookup_blob(entry.oid->hash)->object;
+=09=09=09if (name)
+=09=09=09=09put_object_name(options, obj, "%s%s", name,
+=09=09=09=09=09entry.path);
+=09=09=09result =3D options->walk(obj, OBJ_BLOB, data, options);
+=09=09}
 =09=09else {
 =09=09=09result =3D error("in tree %s: entry %s has bad mode %.6o",
 =09=09=09=09=09oid_to_hex(&tree->object.oid), entry.path, entry.mode);
@@ -330,20 +370,55 @@ static int fsck_walk_tree(struct tree *tree, void *da=
ta, struct fsck_options *op
=20
 static int fsck_walk_commit(struct commit *commit, void *data, struct fsck=
_options *options)
 {
+=09int counter =3D 0, generation =3D 0, name_prefix_len =3D 0;
 =09struct commit_list *parents;
 =09int res;
 =09int result;
+=09const char *name;
=20
 =09if (parse_commit(commit))
 =09=09return -1;
=20
+=09name =3D get_object_name(options, &commit->object);
+=09if (name)
+=09=09put_object_name(options, &commit->tree->object, "%s:", name);
+
 =09result =3D options->walk((struct object *)commit->tree, OBJ_TREE, data,=
 options);
 =09if (result < 0)
 =09=09return result;
 =09res =3D result;
=20
 =09parents =3D commit->parents;
+=09if (name && parents) {
+=09=09int len =3D strlen(name), power;
+
+=09=09if (len && name[len - 1] =3D=3D '^') {
+=09=09=09generation =3D 1;
+=09=09=09name_prefix_len =3D len - 1;
+=09=09}
+=09=09else { /* parse ~<generation> suffix */
+=09=09=09for (generation =3D 0, power =3D 1;
+=09=09=09     len && isdigit(name[len - 1]);
+=09=09=09     power *=3D 10)
+=09=09=09=09generation +=3D power * (name[--len] - '0');
+=09=09=09if (power > 1 && len && name[len - 1] =3D=3D '~')
+=09=09=09=09name_prefix_len =3D len - 1;
+=09=09}
+=09}
+
 =09while (parents) {
+=09=09if (name) {
+=09=09=09struct object *obj =3D &parents->item->object;
+
+=09=09=09if (++counter > 1)
+=09=09=09=09put_object_name(options, obj, "%s^%d",
+=09=09=09=09=09name, counter);
+=09=09=09else if (generation > 0)
+=09=09=09=09put_object_name(options, obj, "%.*s~%d",
+=09=09=09=09=09name_prefix_len, name, generation + 1);
+=09=09=09else
+=09=09=09=09put_object_name(options, obj, "%s^", name);
+=09=09}
 =09=09result =3D options->walk((struct object *)parents->item, OBJ_COMMIT,=
 data, options);
 =09=09if (result < 0)
 =09=09=09return result;
@@ -356,8 +431,12 @@ static int fsck_walk_commit(struct commit *commit, voi=
d *data, struct fsck_optio
=20
 static int fsck_walk_tag(struct tag *tag, void *data, struct fsck_options =
*options)
 {
+=09char *name =3D get_object_name(options, &tag->object);
+
 =09if (parse_tag(tag))
 =09=09return -1;
+=09if (name)
+=09=09put_object_name(options, tag->tagged, "%s", name);
 =09return options->walk(tag->tagged, OBJ_ANY, data, options);
 }
=20
diff --git a/fsck.h b/fsck.h
index dded84b..26c0d41 100644
--- a/fsck.h
+++ b/fsck.h
@@ -33,6 +33,7 @@ struct fsck_options {
 =09unsigned strict:1;
 =09int *msg_type;
 =09struct sha1_array *skiplist;
+=09struct decoration *object_names;
 };
=20
 #define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL }
--=20
2.9.0.281.g286a8d9


--8323329-940045425-1468753191=:28832--
