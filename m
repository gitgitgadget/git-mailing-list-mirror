Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D2QLpEsb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dsS4t3MT"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075B5D0
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 23:01:07 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 724FA3200A68
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 02:01:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 12 Dec 2023 02:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702364465; x=1702450865; bh=xyDF9KOl/w
	V2xSSCOF+z4j4kMHr41mfMfm4i0ynVOFg=; b=D2QLpEsbzga8jt7jku7ADaBNqW
	ba5MAG3mmpXEx2iVvL6QAD38rBL5N+GAO7hg26uxDKW2V2LG5B/57ARNTQn7T2LT
	5KjD1I417DA8pXq1zwEMFg1Yf1YsjrPdtu3+UeWmVpkA2ddaCFy0sQ3IYnqYIs1u
	1sfSO1J7zeGnNhhtYNKjB7WUMOpMi5PW9v/uyhvEc3xkRoWyK/hK7YNV6zHzufCU
	ha2LrEkxsJ29sh8L4X+MvWWLj1BoFNEVfkovm2zkDsVj+MAe/HXvZiTVgzR+p2E5
	qxC6zJgRFnSIxSpxqcZB8we8LFHw+2RrSetAOLSTAXHsNFw0fZcHPxsikGNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702364465; x=1702450865; bh=xyDF9KOl/wV2xSSCOF+z4j4kMHr4
	1mfMfm4i0ynVOFg=; b=dsS4t3MTtlTE1R2RPnAQnRsTSq34qf5ZdCMQMjBFjtlJ
	JRkp4P3iciaW86nUjOi0ev25WEhkqhFPBCqkV2jmjO5PlLBBWu/WquwPlfc1qRzp
	3InyaINgHtgngOw5p3P1/CjcxefBSxo5q8tH0ZaQ/LZpGWE1/70AWwGmhVouWXVs
	mr4sKHd62T/Qx4PLoepEIH7TdLWFb8RXUh0g3XTQP9/dpu8A/wZMfdXv/UK9SJM4
	jlI37cd1VAtYj9j8VThzim37wekrq++dd21sW1iquSlsIUJi2Wuh4qnICx36vhW2
	cYKDLl/wL/f8f/kd4Ple0Tr5xPKDI9R9pZlSN3sG/w==
X-ME-Sender: <xms:MQV4ZZ-27tkBeJLcOk4zlc8fH8fJ5FzcWoBmeEazs0VInxvRBMyK9Q>
    <xme:MQV4Zdu3QMdYJxJNxoj6Pwn2KMS2Q-DZMF0gToyqcOmUTXLkqfHEap3JdCUkvIARZ
    AnA0lEyiMyGXNqXHQ>
X-ME-Received: <xmr:MQV4ZXBiAVvxf69dqmgCyZW0LKdGdwQ6crDV8SVpuNP43TLD-GIzvzanhjlQuHj1xrOX0KTmabV_u4Au1WCT1e6tWZs3Ffh18xVsVHRHoGD-Mdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:MQV4Zdf1KiKm0uU0MzS5JcAQ0hG5ZJJgXioUreXfcEO2dmAXOGIspA>
    <xmx:MQV4ZeOaoXXkKlBG4hv6k37gviMMYsax2RbvSZaj0NsFSZpR07LTXA>
    <xmx:MQV4ZfmAIWsYsjtL3ve0m9YR8rcw5Z1OJBOfFAR9ZnNarxSC5x3Pug>
    <xmx:MQV4ZRbr8-jET5wAJh8Tl3wf74nBGvQFa5uaQSBy-FkBCQ1GTh_w3A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 12 Dec 2023 02:01:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f76d4677 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 12 Dec 2023 06:59:27 +0000 (UTC)
Date: Tue, 12 Dec 2023 08:01:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH v2 6/7] builtin/clone: skip reading HEAD when retrieving
 remote
Message-ID: <f3485a2708a12dc303308b8150d10d3195b04918.1702361370.git.ps@pks.im>
References: <cover.1701863960.git.ps@pks.im>
 <cover.1702361370.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A0/u0mF/OW4ZvKUH"
Content-Disposition: inline
In-Reply-To: <cover.1702361370.git.ps@pks.im>


--A0/u0mF/OW4ZvKUH
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
2.43.GIT


--A0/u0mF/OW4ZvKUH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV4BS4ACgkQVbJhu7ck
PpR84Q/9Fz+tbQsb3M2FXER7ry/cc8k3QAqvBqbWOMwm3flrljWMphrl5sZzoV42
+Vsx5kDE/LeSxzfs/6KJ40Nr/gKte64EhKk0jhWW2kyMVTH6DgYln9i3JSQOgrGV
PQ8wUyH5D2t4RtgbdInGN+QvP0f94rZLx4rzdnDy/VQpLWZgMcVONk+JY6gQ862p
6hr84gCpajmgxdB0IfihlLEeAhjPkrSn9AxvznAaJgYfKlpdLQO1cLh7Egrq/JQ5
XOVsszrpw2/BmtNFmZeMzpMd25QYIJdl+H4d3/u1GgIa9f+tGXfAaBVtfBJyHDTO
LYlpYw6Co+EVH5fApMXKGPSpntcbU5BpjXU1Xu1C1l0Qv2pLj1fS/dPbXV6lJAkR
NmwuuR0ZKrKMKA42vefodbCcZKHFur0CLu3qJcK9F10W5Ear0xfyWSbR5XSvKb77
Guo2lI5lHL07J58r3q5kxm9Ul1NnxqcihcIaUvE934B+wD3Xl7w77jSN/EqfH4Wp
tbxubXNf2zHfAeU+9J4mIY8mnHH2Ms9CFAScYiza/cn4XTDa+HUY4w0TYTqD4ItQ
4K49uBVwui7ihKeoh74zMpi5GNvoWBGSitjZMG1mBRQe7oynAXh5hIqbjyyMxvKo
uxcWlhbwZG4ke+XipYcWCoa+59C0K7R4qruhRv5bFMEjV/icQUY=
=6N3A
-----END PGP SIGNATURE-----

--A0/u0mF/OW4ZvKUH--
