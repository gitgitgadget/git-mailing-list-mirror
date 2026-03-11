Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EF83E8666
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253048; cv=none; b=SNo2ejWUY+9CBGsH2dj1iIMZDmB+dY5GzoZBOkP6MLf4EYvSdjtrhmq/jHuu58TyhpfLiLQZrLTGpfMtwe0pH8CZAGD/57uF9n7t1WM9A5mxG8R3TnFgZK1EsGFGouJBcUPzri30H87LaYLNBy6iYK+n7KWUOajA3+9O9Ldt5FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253048; c=relaxed/simple;
	bh=ztBWZLsKL5j1+1L5QmuXJA63d7zq84xeCUe2OJfSzvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U9/e3kWpaU5swJRjIEcGHn+45tF3qvgSYtAG9qBr3rf7jaCQI0hVf0LiXubwGoOg+vyMD9Cxn4RMQNsLT+D7w/PIXR/+Inp5A79f6R1uCHpwbtefCzzY44rXMIgrLQx5+NwwzWGb3rHPRwZ7ccqWa6M0mExpS1pb5jFM3AFTt/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=kprCG2y0; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=aMo6Oo4m; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="kprCG2y0";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="aMo6Oo4m"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=kprCG2y0+mLEmNQprdb/7KL8xZkAl9k6PHYOZo3t6el89AH1dmqe2EWJMQrpmjfskIaFqPBr4ZwdRwnoX+RbM6bxXe2LCxQJYunayJ5Rj52SeGXk/pEe5MSicbaFpF7o+uOqnTRBSzmCofcrogOhNFsmzSJBOhl1CQZvUOsxraCNkIBrTP6yn+KrgvHSr5/o9jcczPoyFWoH3/ESUVVOd77cT5FbPqYNiyTo9ttIM8Wor8XAZmNGIvphccj7lIL5AijWMpKfYcVmNvDS5+1JkF4xYKZxnmH/8Qzmom/WF0XE6fIo+ZUv19MNkwYkKSVPG51wCMLYc5oZaFnf+6TrTA==; s=purelymail2; d=malon.dev; v=1; bh=ztBWZLsKL5j1+1L5QmuXJA63d7zq84xeCUe2OJfSzvs=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=aMo6Oo4mxOoC7qw64pR9ko6gQy1H/+u/kPTCUWSETJBL/rBr6/00VfiBngKW6kIf0gUXcsqZ5uCs1xUpdrpxoo7wGrWKtMx2l6TB0UTelMAlIiglftlbNXh7DyFOV/spe/GTa/ii9UdYDwdVJBSv2berMhkTJTE86FPylE7+XatT666kPVh3TLwuc0Mse3BrXERV1PglPmooBAGAC/zNyyFZxNebW8aZt93RBQ0USK12fdzqeZXevbqhopF15jmEwkAtuA2bgSN+Q+6B4A6ZjVzNlJVVQED3FEfrOahKLMc6ZkiCwNhyxfXJ8mS/5td2eXQCnI1mHXj1+9rfT0ppNg==; s=purelymail2; d=purelymail.com; v=1; bh=ztBWZLsKL5j1+1L5QmuXJA63d7zq84xeCUe2OJfSzvs=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2114418119;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 11 Mar 2026 18:17:17 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	ps@pks.im,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v1] builtin/mktree: remove USE_THE_REPOSITORY_VARIABLE
Date: Thu, 12 Mar 2026 02:17:03 +0800
Message-ID: <20260311181704.958509-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The 'cmd_mktree' already receives a 'struct repository *repo' but was
previously marked as UNUSED.

Pass the 'repo' down the 'mktree-line()' and 'write_tree()'.
Consequently, remove the 'USE_THE_REPOSITORY_VARIABLE' macro, and
replace 'parse_oid_hex()' with its context-aware version
'parse_oid_hex_algop()'.

Signed-off-by: Tian Yuchen <cat@malon.dev>
---

I originally intended to attempt the #FIXME in t1006-cat-file.sh.
I followed the clues all the way here, only to discover that the
FIXME required a level of expertise far beyond my capabilities,
so I gave up. However, I spot the global variable here, so I went
ahead and fixed it ;)

Two questions:

The 'oid_to_hex' function appears to use 'the_hash_algo' internally.
Seems that it also implicitly relying on global state. Is there
anything we should be aware of?

I've always been unsure about who to CC on domain-specific patches,
so I've only been sending them to Junio and the mailing list. Could
this be why my previous patch for a global variable refactor didn't
receive any review feedback? Here is the link:

https://lore.kernel.org/git/20260302085738.2510514-1-a3205153416@gmail.com/

I would be most grateful if you could provide any feedback. Thank you.

 builtin/mktree.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 12772303f5..4084e32476 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -3,7 +3,6 @@
  *
  * Copyright (c) Junio C Hamano, 2006, 2009
  */
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
@@ -46,7 +45,7 @@ static int ent_compare(const void *a_, const void *b_)
 =09=09=09=09 b->name, b->len, b->mode);
 }
=20
-static void write_tree(struct object_id *oid)
+static void write_tree(struct repository *repo, struct object_id *oid)
 {
 =09struct strbuf buf;
 =09size_t size;
@@ -60,10 +59,10 @@ static void write_tree(struct object_id *oid)
 =09for (i =3D 0; i < used; i++) {
 =09=09struct treeent *ent =3D entries[i];
 =09=09strbuf_addf(&buf, "%o %s%c", ent->mode, ent->name, '\0');
-=09=09strbuf_add(&buf, ent->oid.hash, the_hash_algo->rawsz);
+=09=09strbuf_add(&buf, ent->oid.hash, repo->hash_algo->rawsz);
 =09}
=20
-=09odb_write_object(the_repository->objects, buf.buf, buf.len, OBJ_TREE, o=
id);
+=09odb_write_object(repo->objects, buf.buf, buf.len, OBJ_TREE, oid);
 =09strbuf_release(&buf);
 }
=20
@@ -72,7 +71,7 @@ static const char *const mktree_usage[] =3D {
 =09NULL
 };
=20
-static void mktree_line(char *buf, int nul_term_line, int allow_missing)
+static void mktree_line(struct repository *repo, char *buf, int nul_term_l=
ine, int allow_missing)
 {
 =09char *ptr, *ntr;
 =09const char *p;
@@ -93,7 +92,7 @@ static void mktree_line(char *buf, int nul_term_line, int=
 allow_missing)
 =09=09die("input format error: %s", buf);
 =09ptr =3D ntr + 1; /* type */
 =09ntr =3D strchr(ptr, ' ');
-=09if (!ntr || parse_oid_hex(ntr + 1, &oid, &p) ||
+=09if (!ntr || parse_oid_hex_algop(ntr + 1, &oid, &p, repo->hash_algo) ||
 =09    *p !=3D '\t')
 =09=09die("input format error: %s", buf);
=20
@@ -124,7 +123,7 @@ static void mktree_line(char *buf, int nul_term_line, i=
nt allow_missing)
=20
 =09/* Check the type of object identified by oid without fetching objects =
*/
 =09oi.typep =3D &obj_type;
-=09if (odb_read_object_info_extended(the_repository->objects, &oid, &oi,
+=09if (odb_read_object_info_extended(repo->objects, &oid, &oi,
 =09=09=09=09=09  OBJECT_INFO_LOOKUP_REPLACE |
 =09=09=09=09=09  OBJECT_INFO_QUICK |
 =09=09=09=09=09  OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
@@ -155,7 +154,7 @@ static void mktree_line(char *buf, int nul_term_line, i=
nt allow_missing)
 int cmd_mktree(int ac,
 =09       const char **av,
 =09       const char *prefix,
-=09       struct repository *repo UNUSED)
+=09       struct repository *repo)
 {
 =09struct strbuf sb =3D STRBUF_INIT;
 =09struct object_id oid;
@@ -187,7 +186,7 @@ int cmd_mktree(int ac,
 =09=09=09=09=09break;
 =09=09=09=09die("input format error: (blank line only valid in batch mode)=
");
 =09=09=09}
-=09=09=09mktree_line(sb.buf, nul_term_line, allow_missing);
+=09=09=09mktree_line(repo, sb.buf, nul_term_line, allow_missing);
 =09=09}
 =09=09if (is_batch_mode && got_eof && used < 1) {
 =09=09=09/*
@@ -197,7 +196,7 @@ int cmd_mktree(int ac,
 =09=09=09 */
 =09=09=09; /* skip creating an empty tree */
 =09=09} else {
-=09=09=09write_tree(&oid);
+=09=09=09write_tree(repo, &oid);
 =09=09=09puts(oid_to_hex(&oid));
 =09=09=09fflush(stdout);
 =09=09}
--=20
2.43.0

