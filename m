Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s4dtbI+d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FzZB/3+z"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3EBD3
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 04:40:13 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 04D155C0296
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 07:40:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 06 Dec 2023 07:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701866413; x=1701952813; bh=gv
	lWqrz39eBQx6tdLh+1nsoIyVICx9Gqa/3MxQFqkoc=; b=s4dtbI+dzAPpE7XS8N
	rPkpI2A9mAqkAyfzBhE3vZC3loQm82YZ6lH0XyuSSilYdYp0wgiqHWPYDucSYIv9
	Xlj64ixGlfRP60+jCrz3p20nxaurVL74z8XDfBxh61rhApZnUV0liCXczMj/L3Re
	dzeFZtaWhxht3ztEYku+5ZJ17QtFyBQKhqLq3iTfW1FYbWWHq937EV3ASFQeGinX
	t94kAPn1aQWGVIlkjeKj97n9rmmcUbCvqeO7642t8ZYcgcV8VL6mzSUyztP2FWSW
	+qk+yho3XGtRkyyp7rZp7n4uQnKUKzBJzUjD/HPkKLcX/XxETv6zaLCfjtgbIAFl
	zfuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701866413; x=1701952813; bh=gvlWqrz39eBQx
	6tdLh+1nsoIyVICx9Gqa/3MxQFqkoc=; b=FzZB/3+zkL4/HoHETyqY7QZUpzaU3
	PuyXcbyiwXDoNbjUx/jDWOvqPueOnL2ll3UUz4SCrGt8I1qAzMRdfpFJC7yj++Yt
	x7VX55WErYXb1AQlsGETv4ogMxd2Q4llK8l92Iint1H0XgWzn52bQIWY+IzEn3p0
	1oTZIE7ZN1cz0M/mTnFBEF0F2nW0BRrkkXK1Ff6/Z839ooedZjuOk3155KpDPxmX
	ggnlZYTl3DINl9EBsPwDdGPLgrB7EDlUUj5Sld+t/nCsH/7LvMTpZw/mjy7Fudli
	6v0nJhUkd7tmo7tHJXkDmDV9U+h4uZLKW8k0zzTWX2EIbMDL6AG6J+Yag==
X-ME-Sender: <xms:rGtwZbrHY4CTXrVJ9_Xje_zai8okhCMLYS2YALGBLkoNBz0fbwwzNw>
    <xme:rGtwZVpCWwOQjYtARYHmr9DAT2zXYPW5skod7ZR02zEOXV2sRaIZ_K8oqjheSYvDn
    GiuRhTnR6XxOcOqgw>
X-ME-Received: <xmr:rGtwZYN00JlJ7Fc5ewOWsfh5PkAB8en-Ie4apkIsQpiUsUbjkTobQx27a-YX0D25k_1Vhm4fZ8-6nnw6nnq0UzKYjk-9y6Q2J34TXlLCkT1lQ7I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudektddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:rGtwZe65Fg6KlokB9bjMrjxrGUScdx1waRP16uUmUu43Zvta72GLjg>
    <xmx:rGtwZa7CZHKPmZ6oCxSLQoDAlpnkLtYeECCL91NQWX8Yym9_HmkGWg>
    <xmx:rGtwZWjUHRmvLiYRnMXbcxYJfvfDKk-G3R6YMWkMRCZ6oCG4c4YBrA>
    <xmx:rWtwZXWmvwmCJjGdO-xhrQYuEVDQXhdB4GzfLEKuuFeTZm1QwRj2MQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Dec 2023 07:40:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7babb740 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Dec 2023 12:38:46 +0000 (UTC)
Date: Wed, 6 Dec 2023 13:40:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 6/7] builtin/clone: skip reading HEAD when retrieving remote
Message-ID: <6c919fb19c4e0a723c23b407717fda7649bb360f.1701863960.git.ps@pks.im>
References: <cover.1701863960.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YqvsGM5c26PxSD+r"
Content-Disposition: inline
In-Reply-To: <cover.1701863960.git.ps@pks.im>


--YqvsGM5c26PxSD+r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

After we have set up the remote configuration in git-clone(1) we'll call
`remote_get()` to read the remote from the on-disk configuration. But
next to reading the on-disk configuration, `remote_get()` will also
cause us to try and read the repository's HEAD reference so that we can
figure out the current branch. Besides being pointless in git-clone(1)
because we're operating in an empty repository anyway, this will also
break once we move creation of the reference database to a later point
in time.

Refactor the code to introduce a new `remote_get_early()` function that
will skip reading the HEAD reference to address this issue.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c |  2 +-
 remote.c        | 26 ++++++++++++++++----------
 remote.h        |  1 +
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9c60923f31..06966c5d4c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1185,7 +1185,7 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
=20
-	remote =3D remote_get(remote_name);
+	remote =3D remote_get_early(remote_name);
=20
 	refspec_appendf(&remote->fetch, "+%s*:%s*", src_ref_prefix,
 			branch_top.buf);
diff --git a/remote.c b/remote.c
index abb24822be..051d0a64a0 100644
--- a/remote.c
+++ b/remote.c
@@ -509,7 +509,7 @@ static void alias_all_urls(struct remote_state *remote_=
state)
 	}
 }
=20
-static void read_config(struct repository *repo)
+static void read_config(struct repository *repo, int early)
 {
 	int flag;
=20
@@ -518,7 +518,7 @@ static void read_config(struct repository *repo)
 	repo->remote_state->initialized =3D 1;
=20
 	repo->remote_state->current_branch =3D NULL;
-	if (startup_info->have_repository) {
+	if (startup_info->have_repository && !early) {
 		const char *head_ref =3D refs_resolve_ref_unsafe(
 			get_main_ref_store(repo), "HEAD", 0, NULL, &flag);
 		if (head_ref && (flag & REF_ISSYMREF) &&
@@ -561,7 +561,7 @@ static const char *remotes_remote_for_branch(struct rem=
ote_state *remote_state,
=20
 const char *remote_for_branch(struct branch *branch, int *explicit)
 {
-	read_config(the_repository);
+	read_config(the_repository, 0);
 	die_on_missing_branch(the_repository, branch);
=20
 	return remotes_remote_for_branch(the_repository->remote_state, branch,
@@ -587,7 +587,7 @@ remotes_pushremote_for_branch(struct remote_state *remo=
te_state,
=20
 const char *pushremote_for_branch(struct branch *branch, int *explicit)
 {
-	read_config(the_repository);
+	read_config(the_repository, 0);
 	die_on_missing_branch(the_repository, branch);
=20
 	return remotes_pushremote_for_branch(the_repository->remote_state,
@@ -599,7 +599,7 @@ static struct remote *remotes_remote_get(struct remote_=
state *remote_state,
=20
 const char *remote_ref_for_branch(struct branch *branch, int for_push)
 {
-	read_config(the_repository);
+	read_config(the_repository, 0);
 	die_on_missing_branch(the_repository, branch);
=20
 	if (branch) {
@@ -709,7 +709,13 @@ remotes_remote_get(struct remote_state *remote_state, =
const char *name)
=20
 struct remote *remote_get(const char *name)
 {
-	read_config(the_repository);
+	read_config(the_repository, 0);
+	return remotes_remote_get(the_repository->remote_state, name);
+}
+
+struct remote *remote_get_early(const char *name)
+{
+	read_config(the_repository, 1);
 	return remotes_remote_get(the_repository->remote_state, name);
 }
=20
@@ -722,7 +728,7 @@ remotes_pushremote_get(struct remote_state *remote_stat=
e, const char *name)
=20
 struct remote *pushremote_get(const char *name)
 {
-	read_config(the_repository);
+	read_config(the_repository, 0);
 	return remotes_pushremote_get(the_repository->remote_state, name);
 }
=20
@@ -738,7 +744,7 @@ int remote_is_configured(struct remote *remote, int in_=
repo)
 int for_each_remote(each_remote_fn fn, void *priv)
 {
 	int i, result =3D 0;
-	read_config(the_repository);
+	read_config(the_repository, 0);
 	for (i =3D 0; i < the_repository->remote_state->remotes_nr && !result;
 	     i++) {
 		struct remote *remote =3D
@@ -1831,7 +1837,7 @@ struct branch *branch_get(const char *name)
 {
 	struct branch *ret;
=20
-	read_config(the_repository);
+	read_config(the_repository, 0);
 	if (!name || !*name || !strcmp(name, "HEAD"))
 		ret =3D the_repository->remote_state->current_branch;
 	else
@@ -1973,7 +1979,7 @@ static const char *branch_get_push_1(struct remote_st=
ate *remote_state,
=20
 const char *branch_get_push(struct branch *branch, struct strbuf *err)
 {
-	read_config(the_repository);
+	read_config(the_repository, 0);
 	die_on_missing_branch(the_repository, branch);
=20
 	if (!branch)
diff --git a/remote.h b/remote.h
index cdc8b1db42..79353ba226 100644
--- a/remote.h
+++ b/remote.h
@@ -118,6 +118,7 @@ struct remote {
  * and configuration.
  */
 struct remote *remote_get(const char *name);
+struct remote *remote_get_early(const char *name);
=20
 struct remote *pushremote_get(const char *name);
 int remote_is_configured(struct remote *remote, int in_repo);
--=20
2.43.0


--YqvsGM5c26PxSD+r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVwa6kACgkQVbJhu7ck
PpTlwA/+LJmFHtn8KIy+aUosq2RiouorXN5mhtWXdQYuYdaUpFCIdqVPsJxVVMTQ
iub8UQa8/tfKLnhgrFyIoMv8POAQXu2bqEUVA4oFYVoIccYgo/UMQBof7NR9VBt1
6lMm90ufQ6hMFb0aPn8Xt6i5ZCxoDamNjMDNYxwSmzSvtre97Cj+NgfiE49Jawoc
8SQ86BnA0t9Mk4NUMIOKFuAGJHJDevxCgFb28KHA23W0q9UIi4u6AfOLOHfn8v+F
9EEVuT0Zlq2SDupl8D7dCNpKppAPv2WaeVFeTXWr8wpKXlniQkLQKgL2Kf+wNfG+
rnNx3OnHuPIgzF3HAn9/YPPW+14N1qoWR2CN7P0pw4f/76gBCNYdt+EX+NzUA5qL
+dDJp/Bo/+xd2kHPyFK++KRkK4utENK0cNXwjiHU35HsDlks9ds+es72NLhxWYGz
5YyN9Esd8LQhniEdWk3+cS64l7eeYriW2jCoRNJynM2ZPXrDhsDtzBfcLQ8Anq6u
CQcwm7xUF0rM3cOB0vzfKO7lD7uRWhaWB2ywKp8CYDEtdNuKVqjTfZuFOr1HJYwo
p/Vp2JS/ng5YgpGl+fUbNAKp60tKP172Fq25V3GLuWv+mEuhieTMhdz4DrXnhraT
oaXkQywu7VI3QA3qsSdMCrkvEjzRYioHVdU09mTxKj9PfVqK3A4=
=d2h2
-----END PGP SIGNATURE-----

--YqvsGM5c26PxSD+r--
