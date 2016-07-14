Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B07220196
	for <e@80x24.org>; Thu, 14 Jul 2016 15:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbcGNPam (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 11:30:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:49416 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367AbcGNPak (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 11:30:40 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M3AWN-1b48NS0T5T-00swl0; Thu, 14 Jul 2016 17:30:33
 +0200
Date:	Thu, 14 Jul 2016 17:30:24 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] fsck_walk(): optionally name objects on the go
In-Reply-To: <cover.1468510191.git.johannes.schindelin@gmx.de>
Message-ID: <f5ef009d2be6bf0137b33ac9ce85ff0ce03a48e8.1468510191.git.johannes.schindelin@gmx.de>
References: <cover.1468510191.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-508294682-1468510233=:6426"
X-Provags-ID: V03:K0:Fs70ujW8jX/ePThOPLX6H6exg5t/PYeNG/GVKZ0kSstOcjMlgSd
 qrGjADsMc7ttkRIJqjGJqIpzQj1laStQuc8bQ0SCFMSQ1I7hqxGlwUfWBPC8R9YOjABg29E
 YXk6LnhO2pJQWGou4aBfiOQI/gk9YJ5loIVuGcmO/taXy48qCEpDKxOsU7RKx3bu4x+FKl6
 fgazPVMsWUoUe95MDSrgw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:i9uwkQyvSoo=:fV6adSVa8A+8g83sjZEfmE
 ewu6Qh7rGQ0+RXVvMczN/JfuiW14+Ers/QMwK5hwNvb1AWQ1mj40wC3/AtaJW0LBEtgajeXl2
 3y8T6RDC/1j1YoOJud5mRVGfnWS6/ZhyWHXIhUg6GMPJ4RybpKOQahuBoZ9WX/ZDix2uv47zx
 haceaNIHzqenAc8RqN4eh/B0nPX8HGe8NIeRiCusCp4BAwCzfY2HVDirM83fgKCSjNZXlGqQW
 bulp+lccnpTIV9R8FWkdJHZ/CdLAI8Qa7uNV/c8RpX4D69Y4ksQWmyPoIL2YWe5CgpDA8uBdy
 A8o7XktmM3LOzBhUG7PiGoOuWRDUijoaR75LxLnrnbUAqq1vzE+W1TBlpRdJ9ooE30H46wo3H
 yjjlp5ResV1ZA3i1/q0JzrKFsLnl4CCMyUZ+PU1UETJCQZjtO7a/zb//oRbQrsR3M9qZvyT/W
 XHIi3j4uoQgRWKxMCDHeJVtiFvr+07XkkEDbJv0i+7tH+4oeLCtEdO1EvDZdKp1BuPbgGi7ZP
 QTT5QSZhloUe3IkXWGO1kXFWKtSgfFqAZlRsjnn85i3h7ly+hUbevB+myCxzWPlPwgWQ2A1HZ
 C6Kyb7bestGiVIyq+tgAgys1YDrig0q1dJjFgoA2zvJOrEekc/BjYNZmc/Z73sz8B94t/Z1SG
 2Dn4jUzqsANz/LegF52mSv2A1KO7gyC/RSAe2KTWE9TtRAWMBdxeiG6XEtgMZ+wKV426C3li9
 CXgRu7+QIOsu22uEhsctePYMqY7V5mWeMxYKZ6sr2ZgiwGy4bSmgldO9XGfjyrml775+D3v4u
 a5IMPvK
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-508294682-1468510233=:6426
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
 fsck.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 fsck.h |  1 +
 2 files changed, 73 insertions(+)

diff --git a/fsck.c b/fsck.c
index 0531545..fe6a28a 100644
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
@@ -297,19 +298,51 @@ static int report(struct fsck_options *options, struc=
t object *object,
 =09return result;
 }
=20
+static char *get_object_name(struct fsck_options *options, struct object *=
obj)
+{
+=09return options->object_names ?
+=09=09lookup_decoration(options->object_names, obj) : NULL;
+}
+
+static void put_object_name(struct fsck_options *options, struct object *o=
bj,
+=09const char *fmt, ...)
+{
+=09va_list ap;
+=09char *existing =3D lookup_decoration(options->object_names, obj);
+=09struct strbuf buf =3D STRBUF_INIT;
+
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
 =09=09int result;
=20
+=09=09if (name) {
+=09=09=09struct object *obj =3D parse_object(entry.oid->hash);
+
+=09=09=09if (obj)
+=09=09=09=09put_object_name(options, obj, "%s%s%s", name,
+=09=09=09=09=09entry.path,
+=09=09=09=09=09S_ISDIR(entry.mode) ? "/" : "");
+=09=09}
+
 =09=09if (S_ISGITLINK(entry.mode))
 =09=09=09continue;
 =09=09if (S_ISDIR(entry.mode))
@@ -330,20 +363,55 @@ static int fsck_walk_tree(struct tree *tree, void *da=
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
@@ -356,8 +424,12 @@ static int fsck_walk_commit(struct commit *commit, voi=
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
2.9.0.278.g1caae67


--8323329-508294682-1468510233=:6426--
