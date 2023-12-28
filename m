Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3556D24
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TlfDftTA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4JUr02LR"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 142B15C0091
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 04:59:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 28 Dec 2023 04:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1703757590; x=1703843990; bh=AoSXmrF7YP6iyXyYlHQf/d5NSV6J/oOV
	+Zu3mlGzX+U=; b=TlfDftTAvMFSG8gAdXr1/Xmhotb5dOUe6bg/lJJr75qYzGbD
	bf358dEwYMuXYo+VyrTe1TNAmnQa3/ZcgChrSVgZH2XZOQcoK6ZCvz4NTFfCE/YB
	4/KYaNOGsNNh34lL/4ckeYYN7eLJXQZLp4wR1vK6Z6ScixB1EP5S9FJiEbyzPMfD
	2QFoWiNEkPZWkiGMVNOBOqDEB3fqYhbCedlVCRo9jvSAgM33HQf5xM7plZqJX6vL
	jjkFKW3dLI7TYFTbPGyujZTI8oN6L6X3CvFgnyIw/ODxPNvzdS23zBVaeMDYjoCg
	rjUrQF0lzS2fouL+/NzOxZ548UoBJSThrNFXNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1703757590; x=1703843990; bh=AoSXmrF7YP6iyXyYlHQf/d5NSV6J/oOV+Zu
	3mlGzX+U=; b=4JUr02LRdkd9nrKEUDP4YV0tWpWReNrOOKCcpHx0m+EvWN8WP7d
	7j/d35X0sSMzizo+vJFMcKZvIuJ0E2N1lmjsQgUSF5rtEoWV/k92nm/LKrXgfKG2
	9nThSO3w5h0jpiiyeQlCtYaRIXaZ0le/rlxX+cWwtBfAo1mi2q1cmNEh6Wm2d30G
	uIQgoGaecLSAX9A0vAqHRWWyZ9jncCFxwBE/pQW4+qOTVRgN2Y+GkSpB9VqAgRYl
	hd7fHtJb8DzhFi280yEZEgV4q2jyl7REhyvJgL68jg48rXccW5tZFcE0gUnaGk5x
	wQVrGJj3BRT3RxYMhy/XUIvChvYL42uGMqw==
X-ME-Sender: <xms:FUeNZdzxot9f7HZLqrmWDk_G_cIpJzK1ZCXweRmujVY3nlxF1HDGAA>
    <xme:FUeNZdS-cqSOap_KDK4NZqKFLCM5yXeFs8OJ24EbbizgCpNyLyPNI41thpgwI3cWg
    hvNVhiSmGQvGFqFIA>
X-ME-Received: <xmr:FUeNZXUQHtff5INRHJ0ifq_s4Tf7jlRtTpg38q83k_DZqILUPCig0pf9SU7qQrOjpu915U3M_so-6_1gXpnkW0BbKEyZSNYdLcctTxVdLMCw9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:FUeNZfiLVYFnBrnFt7jHSmpRsh3kat7VDIoqopnFu6CAgIk-Kwh8qw>
    <xmx:FUeNZfAsEULdkqKgVNaExGNoQGCfYI4bKZ6j1dp0ixcM0zDMOY4eiA>
    <xmx:FUeNZYJe1p1ecQoi9IsMTnLcb9lrNNUOBW-YRgfErEGA9AU-_6GEBw>
    <xmx:FkeNZS94uCdqd0tJv36Ax1xyU7OELDaGADVd9u6naVthmlW8NxgNyQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 28 Dec 2023 04:59:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 030c357d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 28 Dec 2023 09:57:34 +0000 (UTC)
Date: Thu, 28 Dec 2023 10:59:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/6] worktree: initialize refdb via ref backends
Message-ID: <cover.1703754513.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="we0BGDAXBqwKHOqp"
Content-Disposition: inline


--we0BGDAXBqwKHOqp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

when initializing worktrees we manually create the on-disk data
structures required for the ref backend in "worktree.c". This works just
fine right now where we only have a single user-exposed ref backend, but
it will become unwieldy once we have multiple ref backends. This patch
series thus refactors how we initialize worktrees so that we can use
`refs_init_db()` to initialize required files for us.

This patch series conflicts with ps/refstorage-extension. The conflict
can be solved as shown below. I'm happy to defer this patch series
though until the topic has landed on `master` in case this causes
issues.

Patrick

diff --cc setup.c
index f2d55994e2,4712bba6f8..0000000000
--- a/setup.c
+++ b/setup.c
@@@ -1904,7 -1926,23 +1926,8 @@@ void create_reference_database(int ref_
  	struct strbuf err =3D STRBUF_INIT;
  	int reinit =3D is_reinit();
 =20
 -	/*
 -	 * We need to create a "refs" dir in any case so that older versions of
 -	 * Git can tell that this is a repository. This serves two main purposes:
 -	 *
 -	 * - Clients will know to stop walking the parent-directory chain when
 -	 *   detecting the Git repository. Otherwise they may end up detecting
 -	 *   a Git repository in a parent directory instead.
 -	 *
 -	 * - Instead of failing to detect a repository with unknown reference
 -	 *   format altogether, old clients will print an error saying that
 -	 *   they do not understand the reference format extension.
 -	 */
 -	safe_create_dir(git_path("refs"), 1);
 -	adjust_shared_perm(git_path("refs"));
 -
+ 	repo_set_ref_storage_format(the_repository, ref_storage_format);
 -	if (refs_init_db(&err))
 +	if (refs_init_db(get_main_ref_store(the_repository), 0, &err))
  		die("failed to set up refs db: %s", err.buf);
 =20
  	/*
diff --cc worktree.c
index 085f2cc41a,9702ed0308..0000000000
--- a/worktree.c
+++ b/worktree.c
@@@ -79,7 -75,8 +80,8 @@@ static struct worktree *get_main_worktr
  	return worktree;
  }
 =20
- struct worktree *get_linked_worktree(const char *id)
 -static struct worktree *get_linked_worktree(const char *id,
 -					    int skip_reading_head)
++struct worktree *get_linked_worktree(const char *id,
++				     int skip_reading_head)
  {
  	struct worktree *worktree =3D NULL;
  	struct strbuf path =3D STRBUF_INIT;
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9d935bee84..558c5537f5 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -502,7 +502,7 @@ static int add_worktree(const char *path, const char *r=
efname,
 	/*
 	 * Set up the ref store of the worktree and create the HEAD reference.
 	 */
-	wt =3D get_linked_worktree(name);
+	wt =3D get_linked_worktree(name, 1);
 	if (!wt) {
 		ret =3D error(_("could not find created worktree '%s'"), name);
 		goto done;
diff --git a/worktree.h b/worktree.h
index 8a75691eac..f14784a2ff 100644
--- a/worktree.h
+++ b/worktree.h
@@ -61,7 +61,8 @@ struct worktree *find_worktree(struct worktree **list,
  * Look up the worktree corresponding to `id`, or NULL of no such worktree
  * exists.
  */
-struct worktree *get_linked_worktree(const char *id);
+struct worktree *get_linked_worktree(const char *id,
+				     int skip_reading_head);
=20
 /*
  * Return the worktree corresponding to `path`, or NULL if no such worktree

Patrick Steinhardt (6):
  refs: prepare `refs_init_db()` for initializing worktree refs
  setup: move creation of "refs/" into the files backend
  refs/files: skip creation of "refs/{heads,tags}" for worktrees
  builtin/worktree: move setup of commondir file earlier
  worktree: expose interface to look up worktree by name
  builtin/worktree: create refdb via ref backend

 builtin/worktree.c    | 53 ++++++++++++++++++++-----------------------
 refs.c                |  6 ++---
 refs.h                |  4 +++-
 refs/debug.c          |  4 ++--
 refs/files-backend.c  | 37 +++++++++++++++++++++++++-----
 refs/packed-backend.c |  1 +
 refs/refs-internal.h  |  4 +++-
 setup.c               | 17 +-------------
 worktree.c            | 25 ++++++++++++--------
 worktree.h            | 11 +++++++++
 10 files changed, 94 insertions(+), 68 deletions(-)


base-commit: e79552d19784ee7f4bbce278fe25f93fbda196fa
--=20
2.43.GIT


--we0BGDAXBqwKHOqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNRxIACgkQVbJhu7ck
PpQaAg//WUp7fvVv7hZxC3wpnOepmEOBwuy8e1s51LUYHPtq+HcysARUWHMmv1T6
iwVBbHgrplizYH46yV96Rw/43p3s2r74Syl5Dkf+ibXfvdFuegJdfKy6o5iHIkwz
oJK667Kpb5WSh5jiBiBrMZ9jUryItHMjfkEIYxfZnJ0/6zJNMNMemfR8MGzZpL1C
9TTvcrdrpJpMe/c94lgolYPXhGRn4YJs3973a9BCzbo1nZYhkGfYElb+0oIrNV98
X4CEap3O04l1MzSABD8vQTOS8eZ1GSn5/5t95rOpabNrKXiIIms7U6oLsjqf65fW
BrgAllcOtKEp8VMf+got7PjMHnSpozn37E1F7m5Zn8VxxLjbjzZ4fgKTxlFDuQev
azogVj1RIWyKfK1+w8T0Iy9dDJPntQR7siB4JZStkcv7mCRf4z2aLKUgtDTvujYp
dyurnFV1AcAR/aeCss/QXFy2Tc4AYVQTO8bGI/weSIFIWNJ6T8+7U8jewHc90q+r
mKKQ0dm2YQ21eU2Vir56M50YMm0VPP5/08wmN9+5sBGb1/7KHlGKtsV49sXrLIUK
F3zB/ko7CiArhWyv8lbTb4/yt352dL4HlGoEXSRiN5R4pZP6DE+9sKMGiKl2hgLX
XA8HZcU5LWRc2IeAseL7U8aUPykO9hIG9dBDsWx3Dl2NPRwNdmI=
=17mm
-----END PGP SIGNATURE-----

--we0BGDAXBqwKHOqp--
