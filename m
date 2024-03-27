Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA5381B8
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529191; cv=none; b=KisIF3F3kkrYR/luwFMjqMriBgeLEFW6f4zci7fr9KZf0xbtfSmM0WOd2x25brJ+Duyl76TKOse1LoWHvHsdJyU+drqXKUP0JQRugGTpH3vAvimdjty+aRZpL/1xH7ALzWTmEVyerLjF9bw3uLJXWhiC/KLGxNiCgKzml3NolkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529191; c=relaxed/simple;
	bh=BJo0S9sbmc2A11PNOO8XgikMn8UE5aLI17aEYDewSPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qro3b+AErJJY6KPTkm2IBBNEvZZ8qcLxAPrCQGVuoZ6b/yXPW8z++2BHDxxmaRp3nttw1aCEYD2+pWtP0VIyTJXshhrN0wdyJ8d0RAEOfChbZTENqYkn8OXuUxhQfo+PN3x92W3ZGqd4BNavOj85Y/f0eIYBJsMp0KISwbLVGsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F1rJjv8j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HoRxgGSL; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F1rJjv8j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HoRxgGSL"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1E5E411400E2;
	Wed, 27 Mar 2024 04:46:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 27 Mar 2024 04:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711529189; x=1711615589; bh=2bF1uVyF4R
	8um/vS+ql3ea8MhMM8x7bsyenzVUSazsE=; b=F1rJjv8jTLtyB8w1XMiGVI+stF
	XGEuF0uV8Hc0/sx9Dbc/CT8h9z1mhLcCFqnGUtYbKsKY+bgp0UlSOt4GEJFn8P+U
	cS8Vw0v/hGW4idanQZ1xMyeALQRq/mYPUQ7eCE3OhoTc4y7C1yUy9uodUSYJ5RDA
	gs9w7ct+RtdgzSqIujg1ZT4Fm1hjhFs5vL1gNE/zx53biSaInI4lOxxgIs+aa+XT
	z6+4Q4KNTvQQpHS/+EH3lp8Si8ahNB2l4xO4LhrTE6IHb2WMQkXRa8P2jsZLtRLS
	YRg00r2RqB0MC/zkYxY0aGR3zW6UtQPTbCDE1bMFJ341K2Es1cFoRATpQ8mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711529189; x=1711615589; bh=2bF1uVyF4R8um/vS+ql3ea8MhMM8
	x7bsyenzVUSazsE=; b=HoRxgGSLXwLyAKxB2FIJRX713MKZWRI5cCgQmI+GvyUs
	Usa2vBJXzg6hETXG14wdVF5/EK9GYFbrTrQjYUjb1mWQ2jz9mNk1QTXXkfja1UsW
	NSf77tKQ1FkXZ6gBHV8/QZjc5f71KcikRzYZ+nfT+CWxrHuPovD0T+BKb/TZsqbf
	Coc9JFApsaWvHW4k27ZDwrO+EUHlGEKWcRA/TjgYUUdpg4GqoRYxy/PafW8Njv1d
	cqiim625P1eQzUapC5KnfVA+kL0HV3DtrcCKpAp1gmBw7fkcA2TyF1NLVIzMnWqv
	FcsdtrFY1vBdZwhODhMPruVKFZicKZnXdKcrG6Tyvg==
X-ME-Sender: <xms:5NwDZg7Km-XiIfR28yLSwaDeaZAbIA2zr5b8P6AIC95CTZEQ9DZd3g>
    <xme:5NwDZh64u2vYwVzRBZ8a6CShyaaIG2GjmZnThre6LYpv1vLasl5dDRt0fRfdUbwbC
    3LUVWxqe-L3eGa2vw>
X-ME-Received: <xmr:5NwDZvewYD1L3vsImsKz9XH6PtU4FBpzbrTbXP-DI6NeMRkr3l2ydwiC1FihRfL5mGrfLhVziL2PRhlbFzHkw6_fwPJ5imAWqyjSFGSLmi8EIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:5NwDZlKvwJtHziQllYVABNXyWnQoZuDnLfXeOx2zfJnzlfrxo8FzDQ>
    <xmx:5NwDZkIWamYlsNZULXjJQtcUG9xzBPZ7vDBFZEhgTLzXSJUF23LxCw>
    <xmx:5NwDZmxi6Sx01MjUsQ2uXEXRFd699QoC3gfYxLyWWb53MxqrD48JCQ>
    <xmx:5NwDZoKB-aPBTAqyp7H8EFcLt69GYxfPmhUPF8q6UQPa3YvcyRWHwA>
    <xmx:5dwDZtqFG3J23BjMNMnJeH6KeGBAKomZeVRivxc_AG4gBoMlusrNww>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 04:46:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d2c870a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 08:46:14 +0000 (UTC)
Date: Wed, 27 Mar 2024 09:46:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 04/13] builtin/config: pull out function to handle config
 location
Message-ID: <41585803bf30f329f546616bd27b10da4df047c5.1711527812.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1711527811.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KT1/SLIhnhzURsSi"
Content-Disposition: inline
In-Reply-To: <cover.1711527811.git.ps@pks.im>


--KT1/SLIhnhzURsSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There's quite a bunch of options to git-config(1) that allow the user to
specify which config location to use when reading or writing config
options. The logic to handle this is thus by necessity also quite
involved.

Pull it out into a separate function so that we can reuse it in
subsequent commits which introduce proper subcommands.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 131 ++++++++++++++++++++++++-----------------------
 1 file changed, 67 insertions(+), 64 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index a293161be4..693df32526 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -622,67 +622,8 @@ static char *default_user_config(void)
 	return strbuf_detach(&buf, NULL);
 }
=20
-static struct option builtin_config_options[] =3D {
-	OPT_GROUP(N_("Config file location")),
-	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
-	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
-	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
-	OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree config=
 file")),
-	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use gi=
ven config file")),
-	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read =
config from given blob object")),
-	OPT_GROUP(N_("Action")),
-	OPT_CMDMODE(0, "get", &actions, N_("get value: name [<value-pattern>]"), =
ACTION_GET),
-	OPT_CMDMODE(0, "get-all", &actions, N_("get all values: key [<value-patte=
rn>]"), ACTION_GET_ALL),
-	OPT_CMDMODE(0, "get-regexp", &actions, N_("get values for regexp: name-re=
gex [<value-pattern>]"), ACTION_GET_REGEXP),
-	OPT_CMDMODE(0, "get-urlmatch", &actions, N_("get value specific for the U=
RL: section[.var] URL"), ACTION_GET_URLMATCH),
-	OPT_CMDMODE(0, "replace-all", &actions, N_("replace all matching variable=
s: name value [<value-pattern>]"), ACTION_REPLACE_ALL),
-	OPT_CMDMODE(0, "add", &actions, N_("add a new variable: name value"), ACT=
ION_ADD),
-	OPT_CMDMODE(0, "unset", &actions, N_("remove a variable: name [<value-pat=
tern>]"), ACTION_UNSET),
-	OPT_CMDMODE(0, "unset-all", &actions, N_("remove all matches: name [<valu=
e-pattern>]"), ACTION_UNSET_ALL),
-	OPT_CMDMODE(0, "rename-section", &actions, N_("rename section: old-name n=
ew-name"), ACTION_RENAME_SECTION),
-	OPT_CMDMODE(0, "remove-section", &actions, N_("remove a section: name"), =
ACTION_REMOVE_SECTION),
-	OPT_CMDMODE('l', "list", &actions, N_("list all"), ACTION_LIST),
-	OPT_CMDMODE('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
-	OPT_CMDMODE(0, "get-color", &actions, N_("find the color configured: slot=
 [<default>]"), ACTION_GET_COLOR),
-	OPT_CMDMODE(0, "get-colorbool", &actions, N_("find the color setting: slo=
t [<stdout-is-tty>]"), ACTION_GET_COLORBOOL),
-	OPT_GROUP(N_("Type")),
-	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type=
"), option_parse_type),
-	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\"")=
, TYPE_BOOL),
-	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE_I=
NT),
-	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"=
), TYPE_BOOL_OR_INT),
-	OPT_CALLBACK_VALUE(0, "bool-or-str", &type, N_("value is --bool or string=
"), TYPE_BOOL_OR_STR),
-	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directo=
ry name)"), TYPE_PATH),
-	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date")=
, TYPE_EXPIRY_DATE),
-	OPT_GROUP(N_("Other")),
-	OPT_BOOL('z', "null", &end_nul, N_("terminate values with NUL byte")),
-	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
-	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direct=
ives on lookup")),
-	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file,=
 standard input, blob, command line)")),
-	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree=
, local, global, system, command)")),
-	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use=
 default value when missing entry")),
-	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when com=
paring values to 'value-pattern'")),
-	OPT_END(),
-};
-
-static NORETURN void usage_builtin_config(void)
-{
-	usage_with_options(builtin_config_usage, builtin_config_options);
-}
-
-int cmd_config(int argc, const char **argv, const char *prefix)
+static void handle_config_location(const char *prefix)
 {
-	int nongit =3D !startup_info->have_repository;
-	char *value =3D NULL;
-	int flags =3D 0;
-	int ret =3D 0;
-	struct key_value_info default_kvi =3D KVI_INIT;
-
-	given_config_source.file =3D xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
-
-	argc =3D parse_options(argc, argv, prefix, builtin_config_options,
-			     builtin_config_usage,
-			     PARSE_OPT_STOP_AT_NON_OPTION);
-
 	if (use_global_config + use_system_config + use_local_config +
 	    use_worktree_config +
 	    !!given_config_source.file + !!given_config_source.blob > 1) {
@@ -690,14 +631,13 @@ int cmd_config(int argc, const char **argv, const cha=
r *prefix)
 		usage_builtin_config();
 	}
=20
-	if (nongit) {
+	if (!startup_info->have_repository) {
 		if (use_local_config)
 			die(_("--local can only be used inside a git repository"));
 		if (given_config_source.blob)
 			die(_("--blob can only be used inside a git repository"));
 		if (use_worktree_config)
 			die(_("--worktree can only be used inside a git repository"));
-
 	}
=20
 	if (given_config_source.file &&
@@ -751,10 +691,73 @@ int cmd_config(int argc, const char **argv, const cha=
r *prefix)
 		config_options.respect_includes =3D !given_config_source.file;
 	else
 		config_options.respect_includes =3D respect_includes_opt;
-	if (!nongit) {
+	if (startup_info->have_repository) {
 		config_options.commondir =3D get_git_common_dir();
 		config_options.git_dir =3D get_git_dir();
 	}
+}
+
+static struct option builtin_config_options[] =3D {
+	OPT_GROUP(N_("Config file location")),
+	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
+	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
+	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
+	OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree config=
 file")),
+	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use gi=
ven config file")),
+	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read =
config from given blob object")),
+	OPT_GROUP(N_("Action")),
+	OPT_CMDMODE(0, "get", &actions, N_("get value: name [<value-pattern>]"), =
ACTION_GET),
+	OPT_CMDMODE(0, "get-all", &actions, N_("get all values: key [<value-patte=
rn>]"), ACTION_GET_ALL),
+	OPT_CMDMODE(0, "get-regexp", &actions, N_("get values for regexp: name-re=
gex [<value-pattern>]"), ACTION_GET_REGEXP),
+	OPT_CMDMODE(0, "get-urlmatch", &actions, N_("get value specific for the U=
RL: section[.var] URL"), ACTION_GET_URLMATCH),
+	OPT_CMDMODE(0, "replace-all", &actions, N_("replace all matching variable=
s: name value [<value-pattern>]"), ACTION_REPLACE_ALL),
+	OPT_CMDMODE(0, "add", &actions, N_("add a new variable: name value"), ACT=
ION_ADD),
+	OPT_CMDMODE(0, "unset", &actions, N_("remove a variable: name [<value-pat=
tern>]"), ACTION_UNSET),
+	OPT_CMDMODE(0, "unset-all", &actions, N_("remove all matches: name [<valu=
e-pattern>]"), ACTION_UNSET_ALL),
+	OPT_CMDMODE(0, "rename-section", &actions, N_("rename section: old-name n=
ew-name"), ACTION_RENAME_SECTION),
+	OPT_CMDMODE(0, "remove-section", &actions, N_("remove a section: name"), =
ACTION_REMOVE_SECTION),
+	OPT_CMDMODE('l', "list", &actions, N_("list all"), ACTION_LIST),
+	OPT_CMDMODE('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
+	OPT_CMDMODE(0, "get-color", &actions, N_("find the color configured: slot=
 [<default>]"), ACTION_GET_COLOR),
+	OPT_CMDMODE(0, "get-colorbool", &actions, N_("find the color setting: slo=
t [<stdout-is-tty>]"), ACTION_GET_COLORBOOL),
+	OPT_GROUP(N_("Type")),
+	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type=
"), option_parse_type),
+	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\"")=
, TYPE_BOOL),
+	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE_I=
NT),
+	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"=
), TYPE_BOOL_OR_INT),
+	OPT_CALLBACK_VALUE(0, "bool-or-str", &type, N_("value is --bool or string=
"), TYPE_BOOL_OR_STR),
+	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directo=
ry name)"), TYPE_PATH),
+	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date")=
, TYPE_EXPIRY_DATE),
+	OPT_GROUP(N_("Other")),
+	OPT_BOOL('z', "null", &end_nul, N_("terminate values with NUL byte")),
+	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
+	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direct=
ives on lookup")),
+	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file,=
 standard input, blob, command line)")),
+	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree=
, local, global, system, command)")),
+	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use=
 default value when missing entry")),
+	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when com=
paring values to 'value-pattern'")),
+	OPT_END(),
+};
+
+static NORETURN void usage_builtin_config(void)
+{
+	usage_with_options(builtin_config_usage, builtin_config_options);
+}
+
+int cmd_config(int argc, const char **argv, const char *prefix)
+{
+	char *value =3D NULL;
+	int flags =3D 0;
+	int ret =3D 0;
+	struct key_value_info default_kvi =3D KVI_INIT;
+
+	given_config_source.file =3D xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
+
+	argc =3D parse_options(argc, argv, prefix, builtin_config_options,
+			     builtin_config_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	handle_config_location(prefix);
=20
 	if (end_nul) {
 		term =3D '\0';
@@ -848,7 +851,7 @@ int cmd_config(int argc, const char **argv, const char =
*prefix)
 		char *config_file;
=20
 		check_argc(argc, 0, 0);
-		if (!given_config_source.file && nongit)
+		if (!given_config_source.file && !startup_info->have_repository)
 			die(_("not in a git directory"));
 		if (given_config_source.use_stdin)
 			die(_("editing stdin is not supported"));
--=20
2.44.GIT


--KT1/SLIhnhzURsSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYD3OEACgkQVbJhu7ck
PpSnGQ//SFv3d9+729uFAn/8vjx7wjELbc8SS7FzoiOfx/yZ+d7oahaJjayhhWaE
fYOQMoistvpQ5uEKwDld0Qm42Y6zmLWrezc/rkg7VuMu1F3G0yRaugeCq3YVr1G1
VuwAmNDZHv9SelPipJjZXQFX/p6tz9k2RsPbhfyBkcUGOjeR8kWTf70Elj/LTwaf
/y08z5Ee3KUpYdR3hNvwgBVNfhLwvUEdOu9WURV2ZhuI045GHO/3zlflZRK3RMPl
e7FhaOfeJGjEHYPjpP+yhB6VrO5E+G94C7PWfaYy9DR/pJqlV2y+fN/uvW8ndyPa
9szMnRWzDsgt7ejEaZ8wdHcAqKbljAwd0cK0b1U4flc/2npKwrbRS0ab/11yMsA0
Ma182zjZE9cVpn9MO/Vj82n8MSt8HxOR3Ab62AU4M7qbWP+sTK+jkKTj5VoSr6Ot
DNvm+kI4GvO41NmqWlWAOPiPAqQBOmMOwPsS7fQsyKAr2xSjI4l3jfVKh3EQwT5B
S4Ig2sZS5AZ4Rglb0Iv6iaoQELOvzKW/kbJvugcbRgYR5FD4IiYWpy6pLQGD+i1k
bJxpmYxWrWCzPp9lZXKupdIFo/v0Ocvea+k7pIdfiR4h5GVsHzKztg0st1GibjkT
VN7MKGnUGWzdElUcQEXcNPiMcEZGrgF0ulpg+JPvFaqoIwpdwc4=
=tIs+
-----END PGP SIGNATURE-----

--KT1/SLIhnhzURsSi--
