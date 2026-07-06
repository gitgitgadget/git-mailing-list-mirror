Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924113A1C9
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347986; cv=none; b=dalrxZ960oGZ/xqN3KOyAjDXpVmqxTLVpQEG3gaDHxM3f6unGVpel8u0ja/oREHFnlsTBP9VGdwswSq1Ni65JMYbOvscj8Icuew1W6B1zvnZ/xyADFM1bQfgpTcQsrfDTJLg0OeG/Cny4tyL1Qmf2E1ff6Si8u3sypPF3VF560Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347986; c=relaxed/simple;
	bh=xi5Y0eNjh8iuUraRcXOzXEpCUk/7fPeCigZ3iCmHuyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DrTaF820dC1VvMjHstJGYSRmyLBT0Ws2Hllre4/OQzhMo4eQoRO5jFzsbU+OIau9owrG9XRYNlmSyy3Lm4wWZWNbnbjIv9Wnlv3Pn+vYt2FL363QHn1DQPwEk24JwkIwIMlECH8ZFyCOPP6AF+H23Wdh1SAuctTZyEyHa0oSVio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=m6C/sJGS; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=VP+2SCRj; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="m6C/sJGS";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="VP+2SCRj"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=m6C/sJGSIlPnYNqbFm6ceZ3ZnKpKFv2UpKIQWJgURiCTlECzZ7i+W88vojSn+WKlMwxCVH/fVbrIB+MHD/AYRANT5DJWONC+TRvWn3NM+6h/NoVDQbXLNo/XCzy8bqtsNbScvtky70MyWu+J21Fcm6pqYUd40L/x3zv37eGxhJfDICTEmt3h0iqYOQ/Gm4NYpIPR0RZSEQvOGznuZmlOtp9q3Ugs5ecQgvm0hfPgWYemZ1vOZOOtVew5QAEYhZZEL9Q6ndMd1yrpAo/hSZsV+RnTFLcYJdjeE5azbihIh1FN4aAe5Hd/cGkAWeBR4wN6PEdYEdWYUYYE/G5ayX2dag==; s=purelymail3; d=malon.dev; v=1; bh=xi5Y0eNjh8iuUraRcXOzXEpCUk/7fPeCigZ3iCmHuyI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=VP+2SCRj/5MRHUXzZ/qu6iIuYPd+viylSSEuO+ey1a1/pkOUk9Aql7EwE6G+CXc50ou4FPAlEUStpTrSeB79RsAHmVorMb7NVdzBwvI2eMPMdNMfKYXB+zdahEd3Rz8yAxBjFeIpFWBzuaVXb0hsLox0hNNkWW58yR4MRITE70oCZ8qey/snVP+miiWeIVitsA4SJi4XOP7oTUyQYO+7qHoE1PqgocYyk5v/Jvmde7hjgXReW/3gBHrZ3NF4hTHu3usbfkpIpmwhh0WahImAwbO66aYlRGT+Z/Kg6Tuq3bH8bMntO3V14pX8nNxFfJq+EaGAjj3HPR7V7+8d6WHFow==; s=purelymail3; d=purelymail.com; v=1; bh=xi5Y0eNjh8iuUraRcXOzXEpCUk/7fPeCigZ3iCmHuyI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1851978137;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 06 Jul 2026 14:26:22 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v7 7/9] environment: move push_default into repo_config_values
Date: Mon,  6 Jul 2026 22:25:28 +0800
Message-ID: <20260706142530.3681520-8-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706142530.3681520-1-cat@malon.dev>
References: <20260701180813.776173-1-cat@malon.dev>
 <20260706142530.3681520-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The global variable 'push_default' specifies the default behavior of
'git push' when no explicit refspec is provided. Move 'push_default'
into 'struct repo_config_values' to continue the libification effort.

While 'enum push_default_type' ideally belongs in 'remote.h', moving it
there introduces a circular dependency chain:

  remote.h -> hash.h -> repository.h -> environment.h.

Therefore, the enum definition is kept in 'environment.h' just above
'struct repo_config_values' with a NEEDSWORK comment for future cleanup.

Modify the configuration parsing in environment.c to update the
per-repository structure directly, and update caller across the
codebase to access the value via 'repo_config_values()'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 builtin/push.c |  8 ++++----
 environment.c  | 16 +++++++++-------
 environment.h  | 26 ++++++++++++++++----------
 remote.c       |  2 +-
 4 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 6021b71d66..6dc3224b60 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -88,7 +88,7 @@ static void refspec_append_mapped(struct refspec *refspec=
, const char *ref,
 =09=09}
 =09}
=20
-=09if (push_default =3D=3D PUSH_DEFAULT_UPSTREAM &&
+=09if (repo_config_values(the_repository)->push_default =3D=3D PUSH_DEFAUL=
T_UPSTREAM &&
 =09    skip_prefix(matched->name, "refs/heads/", &branch_name)) {
 =09=09struct branch *branch =3D branch_get(branch_name);
 =09=09if (branch->merge_nr =3D=3D 1 && branch->merge[0]->src) {
@@ -160,7 +160,7 @@ static NORETURN void die_push_simple(struct branch *bra=
nch,
 =09 * Don't show advice for people who explicitly set
 =09 * push.default.
 =09 */
-=09if (push_default =3D=3D PUSH_DEFAULT_UNSPECIFIED)
+=09if (cfg->push_default =3D=3D PUSH_DEFAULT_UNSPECIFIED)
 =09=09advice_pushdefault_maybe =3D _("\n"
 =09=09=09=09 "To choose either option permanently, "
 =09=09=09=09 "see push.default in 'git help config'.\n");
@@ -232,7 +232,7 @@ static void setup_default_push_refspecs(int *flags, str=
uct remote *remote)
 =09const char *dst;
 =09int same_remote;
=20
-=09switch (push_default) {
+=09switch (repo_config_values(the_repository)->push_default) {
 =09case PUSH_DEFAULT_MATCHING:
 =09=09refspec_append(&rs, ":");
 =09=09return;
@@ -252,7 +252,7 @@ static void setup_default_push_refspecs(int *flags, str=
uct remote *remote)
 =09dst =3D branch->refname;
 =09same_remote =3D !strcmp(remote->name, remote_for_branch(branch, NULL));
=20
-=09switch (push_default) {
+=09switch (repo_config_values(the_repository)->push_default) {
 =09default:
 =09case PUSH_DEFAULT_UNSPECIFIED:
 =09case PUSH_DEFAULT_SIMPLE:
diff --git a/environment.c b/environment.c
index 8744790219..09de2fee87 100644
--- a/environment.c
+++ b/environment.c
@@ -59,7 +59,6 @@ enum eol core_eol =3D EOL_UNSET;
 int global_conv_flags_eol =3D CONV_EOL_RNDTRP_WARN;
 char *check_roundtrip_encoding;
 enum rebase_setup_type autorebase =3D AUTOREBASE_NEVER;
-enum push_default_type push_default =3D PUSH_DEFAULT_UNSPECIFIED;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
@@ -619,21 +618,23 @@ static int git_default_branch_config(const char *var,=
 const char *value)
=20
 static int git_default_push_config(const char *var, const char *value)
 {
+=09struct repo_config_values *cfg =3D repo_config_values(the_repository);
+
 =09if (!strcmp(var, "push.default")) {
 =09=09if (!value)
 =09=09=09return config_error_nonbool(var);
 =09=09else if (!strcmp(value, "nothing"))
-=09=09=09push_default =3D PUSH_DEFAULT_NOTHING;
+=09=09=09cfg->push_default =3D PUSH_DEFAULT_NOTHING;
 =09=09else if (!strcmp(value, "matching"))
-=09=09=09push_default =3D PUSH_DEFAULT_MATCHING;
+=09=09=09cfg->push_default =3D PUSH_DEFAULT_MATCHING;
 =09=09else if (!strcmp(value, "simple"))
-=09=09=09push_default =3D PUSH_DEFAULT_SIMPLE;
+=09=09=09cfg->push_default =3D PUSH_DEFAULT_SIMPLE;
 =09=09else if (!strcmp(value, "upstream"))
-=09=09=09push_default =3D PUSH_DEFAULT_UPSTREAM;
+=09=09=09cfg->push_default =3D PUSH_DEFAULT_UPSTREAM;
 =09=09else if (!strcmp(value, "tracking")) /* deprecated */
-=09=09=09push_default =3D PUSH_DEFAULT_UPSTREAM;
+=09=09=09cfg->push_default =3D PUSH_DEFAULT_UPSTREAM;
 =09=09else if (!strcmp(value, "current"))
-=09=09=09push_default =3D PUSH_DEFAULT_CURRENT;
+=09=09=09cfg->push_default =3D PUSH_DEFAULT_CURRENT;
 =09=09else {
 =09=09=09error(_("malformed value for %s: %s"), var, value);
 =09=09=09return error(_("must be one of nothing, matching, simple, "
@@ -725,6 +726,7 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 =09cfg->askpass_program =3D NULL;
 =09cfg->apply_default_whitespace =3D NULL;
 =09cfg->apply_default_ignorewhitespace =3D NULL;
+=09cfg->push_default =3D PUSH_DEFAULT_UNSPECIFIED;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 =09cfg->trust_ctime =3D 1;
diff --git a/environment.h b/environment.h
index 9aecd64152..72859b5d76 100644
--- a/environment.h
+++ b/environment.h
@@ -87,6 +87,21 @@ extern const char * const local_repo_env[];
 struct strvec;
=20
 struct repository;
+
+/*
+ * NEEDSWORK: It would be better if these definitions could be moved to
+ * other more specific files, but care is needed to avoid circular
+ * inclusion issues.
+ */
+enum push_default_type {
+=09PUSH_DEFAULT_NOTHING =3D 0,
+=09PUSH_DEFAULT_MATCHING,
+=09PUSH_DEFAULT_SIMPLE,
+=09PUSH_DEFAULT_UPSTREAM,
+=09PUSH_DEFAULT_CURRENT,
+=09PUSH_DEFAULT_UNSPECIFIED
+};
+
 struct repo_config_values {
 =09/* section "core" config values */
 =09char *attributes_file;
@@ -96,6 +111,7 @@ struct repo_config_values {
 =09char *askpass_program;
 =09char *apply_default_whitespace;
 =09char *apply_default_ignorewhitespace;
+=09enum push_default_type push_default;
 =09int apply_sparse_checkout;
 =09int trust_ctime;
 =09int check_stat;
@@ -197,16 +213,6 @@ enum rebase_setup_type {
 };
 extern enum rebase_setup_type autorebase;
=20
-enum push_default_type {
-=09PUSH_DEFAULT_NOTHING =3D 0,
-=09PUSH_DEFAULT_MATCHING,
-=09PUSH_DEFAULT_SIMPLE,
-=09PUSH_DEFAULT_UPSTREAM,
-=09PUSH_DEFAULT_CURRENT,
-=09PUSH_DEFAULT_UNSPECIFIED
-};
-extern enum push_default_type push_default;
-
 enum object_creation_mode {
 =09OBJECT_CREATION_USES_HARDLINKS =3D 0,
 =09OBJECT_CREATION_USES_RENAMES =3D 1
diff --git a/remote.c b/remote.c
index 00723b385e..d48c01d375 100644
--- a/remote.c
+++ b/remote.c
@@ -1933,7 +1933,7 @@ static char *branch_get_push_1(struct repository *rep=
o,
 =09if (remote->mirror)
 =09=09return tracking_for_push_dest(remote, branch->refname, err);
=20
-=09switch (push_default) {
+=09switch (repo_config_values(repo)->push_default) {
 =09case PUSH_DEFAULT_NOTHING:
 =09=09return error_buf(err, _("push has no destination (push.default is 'n=
othing')"));
=20
--=20
2.43.0

