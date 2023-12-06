Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fx+iUj3G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YlVshOs0"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A8DD3
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 04:40:04 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 071BA5C0297
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 07:40:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 06 Dec 2023 07:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701866404; x=1701952804; bh=1L
	c5HAo25ugq7oeSNUCiN+GW+jVQgSNYcNqCD/LmB60=; b=Fx+iUj3GasCgfPYrAd
	b3ry7D7tJ2IcrocR9wKqQ625PzCc+A35L6P4FfgLOyVQ04zq6Tr/1JVLYe2uifr/
	tS459aHCzOguHoJeoi0sZ4Jo53WttOBT1EGhl0jkPQvlZP/BKgQQkb5C5bK5Y2yV
	dORRap31KydMWo59OAM/+y+AGWsgFeRjSHweIfbw/kcaT7c5oT/MKf0UXiXyq9/m
	9kBQlMl61dG25u6PKtPpnedvo4Io124hpLWGxMylN4YrUPvdB4qLUiWizY04ipEn
	+i0HP8UlAcGf56Ar3ZKYNbfeUaIKJ1DPs3n9WjCy5GOTL0y8RA149e//4ERf0JFM
	8k0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701866404; x=1701952804; bh=1Lc5HAo25ugq7
	oeSNUCiN+GW+jVQgSNYcNqCD/LmB60=; b=YlVshOs0iZziEauztqGyqLCfJoST3
	JDMAzikXk9L4bFcLLNBT5pJIx6hvOO3R95jhddgzSMGWre1RrB1OpvZR2l1J6LdP
	o/JFzKNpjsUBFzTcYgLjqUp+SSYi5g8Mtgpqgesg61oL/nRAkHko8pXoFYH16DQZ
	H9VjVCR9nzhVjSpamMPDHW+g7HNZl9LJRBCFVw/8nJLEb49Cc/YYNPEUHAuqj8s8
	Bgg2gr3bDbg+WRIJisQ6hNgnVHqWAwr36IGVYVKET+DzQ6D5eW5Ug3B88v7Bc/1u
	R4+/YOYX7himZWF+nd1AKWXi/duoM7BvGOOV9jANcjxLaloBC9Ga9+94g==
X-ME-Sender: <xms:o2twZTSFCyfnwevgLfYKvXfWDTAQDMwQej4XiZiYtBhul2Kt9l1Cuw>
    <xme:o2twZUyLeiXQGBYEz8Y_HnOF8N9uRTiS-sldJwtzeixMOZSlvwTWAzsSaL9gHY17K
    FwTbkNZ2Yr5l9iAZQ>
X-ME-Received: <xmr:o2twZY3vw1fXAFxlpiMb59qbT8wT2_Pj2ejxmbZEbnFa2ZDXy2VMgJF2AOMy6yNn8I0GSKQA_0wQBhMSwvslfUyKxbG05pFuAUmF9ugKTZmFnxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudektddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:o2twZTAZhciqRJQEhl7BcTNNBKJtqO4AnmiIHItBm8dieLpd1-Ih5Q>
    <xmx:o2twZcid0AmkMPIFVcbPn_IDw9vBSKpsciuw5QlE611EezJRC6j5Iw>
    <xmx:o2twZXp62wCmHe36rQ4KoJhlm4eSRIDWXW-_wbyVQeIISEZFNjM72A>
    <xmx:pGtwZadbELfhAvpjUbwY-uiVBjLtWYZjVf8rNAAOlBC11JLhguGn5A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Dec 2023 07:40:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6701feb7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Dec 2023 12:38:37 +0000 (UTC)
Date: Wed, 6 Dec 2023 13:40:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/7] builtin/clone: fix bundle URIs with mismatching object
 formats
Message-ID: <c7a9d6ef74ff39e660f80e2e104a96b7c875845d.1701863960.git.ps@pks.im>
References: <cover.1701863960.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b5bvMDatJyRN07Kb"
Content-Disposition: inline
In-Reply-To: <cover.1701863960.git.ps@pks.im>


--b5bvMDatJyRN07Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We create the reference database in git-clone(1) quite early before
connecting to the remote repository. Given that we do not yet know about
the object format that the remote repository uses at that point in time
the consequence is that the refdb may be initialized with the wrong
object format.

This is not a problem in the context of the files backend as we do not
encode the object format anywhere, and furthermore the only reference
that we write between initializing the refdb and learning about the
object format is the "HEAD" symref. It will become a problem though once
we land the reftable backend, which indeed does require to know about
the proper object format at the time of creation. We thus need to
rearrange the logic in git-clone(1) so that we only initialize the refdb
once we have learned about the actual object format.

As a first step, move listing of remote references to happen earlier,
which also allow us to set up the hash algorithm of the repository
earlier now. While we aim to execute this logic as late as possible
until after most of the setup has happened already, detection of the
object format and thus later the setup of the reference database must
happen before any other logic that may spawn Git commands or otherwise
these Git commands may not recognize the repository as such.

The first Git step where we expect the repository to be fully initalized
is when we fetch bundles via bundle URIs. Funny enough, the comments
there also state that "the_repository must match the cloned repo", which
is indeed not necessarily the case for the hash algorithm right now. So
in practice it is the right thing to detect the remote's object format
before downloading bundle URIs anyway, and not doing so causes clones
with bundle URIS to fail when the local default object format does not
match the remote repository's format.

Unfortunately though, this creates a new issue: downloading bundles may
take a long time, so if we list refs beforehand they might've grown
stale meanwhile. It is not clear how to solve this issue except for a
second reference listing though after we have downloaded the bundles,
which may be an expensive thing to do.

Arguably though, it's preferable to have a staleness issue compared to
being unable to clone a repository altogether.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c             | 48 ++++++++++++++++++-------------------
 t/t5558-clone-bundle-uri.sh | 18 ++++++++++++++
 2 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index c6357af949..d188650881 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1266,6 +1266,26 @@ int cmd_clone(int argc, const char **argv, const cha=
r *prefix)
 	if (transport->smart_options && !deepen && !filter_options.choice)
 		transport->smart_options->check_self_contained_and_connected =3D 1;
=20
+	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
+	refspec_ref_prefixes(&remote->fetch,
+			     &transport_ls_refs_options.ref_prefixes);
+	if (option_branch)
+		expand_ref_prefix(&transport_ls_refs_options.ref_prefixes,
+				  option_branch);
+	if (!option_no_tags)
+		strvec_push(&transport_ls_refs_options.ref_prefixes,
+			    "refs/tags/");
+
+	refs =3D transport_get_remote_refs(transport, &transport_ls_refs_options);
+
+	/*
+	 * Now that we know what algorithm the remote side is using, let's set
+	 * ours to the same thing.
+	 */
+	hash_algo =3D hash_algo_by_ptr(transport_get_hash_algo(transport));
+	initialize_repository_version(hash_algo, 1);
+	repo_set_hash_algo(the_repository, hash_algo);
+
 	/*
 	 * Before fetching from the remote, download and install bundle
 	 * data from the --bundle-uri option.
@@ -1281,24 +1301,7 @@ int cmd_clone(int argc, const char **argv, const cha=
r *prefix)
 				bundle_uri);
 		else if (has_heuristic)
 			git_config_set_gently("fetch.bundleuri", bundle_uri);
-	}
-
-	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
-	refspec_ref_prefixes(&remote->fetch,
-			     &transport_ls_refs_options.ref_prefixes);
-	if (option_branch)
-		expand_ref_prefix(&transport_ls_refs_options.ref_prefixes,
-				  option_branch);
-	if (!option_no_tags)
-		strvec_push(&transport_ls_refs_options.ref_prefixes,
-			    "refs/tags/");
-
-	refs =3D transport_get_remote_refs(transport, &transport_ls_refs_options);
-
-	if (refs)
-		mapped_refs =3D wanted_peer_refs(refs, &remote->fetch);
-
-	if (!bundle_uri) {
+	} else {
 		/*
 		* Populate transport->got_remote_bundle_uri and
 		* transport->bundle_uri. We might get nothing.
@@ -1319,13 +1322,8 @@ int cmd_clone(int argc, const char **argv, const cha=
r *prefix)
 		}
 	}
=20
-		/*
-		 * Now that we know what algorithm the remote side is using,
-		 * let's set ours to the same thing.
-		 */
-	hash_algo =3D hash_algo_by_ptr(transport_get_hash_algo(transport));
-	initialize_repository_version(hash_algo, 1);
-	repo_set_hash_algo(the_repository, hash_algo);
+	if (refs)
+		mapped_refs =3D wanted_peer_refs(refs, &remote->fetch);
=20
 	if (mapped_refs) {
 		/*
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 996a08e90c..1ca5f745e7 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -33,6 +33,15 @@ test_expect_success 'clone with path bundle' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'clone with path bundle and non-default hash' '
+	test_when_finished "rm -rf clone-path-non-default-hash" &&
+	GIT_DEFAULT_HASH=3Dsha256 git clone --bundle-uri=3D"clone-from/B.bundle" \
+		clone-from clone-path-non-default-hash &&
+	git -C clone-path-non-default-hash rev-parse refs/bundles/topic >actual &&
+	git -C clone-from rev-parse topic >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'clone with file:// bundle' '
 	git clone --bundle-uri=3D"file://$(pwd)/clone-from/B.bundle" \
 		clone-from clone-file &&
@@ -284,6 +293,15 @@ test_expect_success 'clone HTTP bundle' '
 	test_config -C clone-http log.excludedecoration refs/bundle/
 '
=20
+test_expect_success 'clone HTTP bundle with non-default hash' '
+	test_when_finished "rm -rf clone-http-non-default-hash" &&
+	GIT_DEFAULT_HASH=3Dsha256 git clone --bundle-uri=3D"$HTTPD_URL/B.bundle" \
+		"$HTTPD_URL/smart/fetch.git" clone-http-non-default-hash &&
+	git -C clone-http-non-default-hash rev-parse refs/bundles/topic >actual &&
+	git -C clone-from rev-parse topic >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'clone bundle list (HTTP, no heuristic)' '
 	test_when_finished rm -f trace*.txt &&
=20
--=20
2.43.0


--b5bvMDatJyRN07Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVwa6AACgkQVbJhu7ck
PpTO7hAAkMpW8ylTNFxVYsxU2jsV/g2QBmTnPJCMKou2BaZHX31RsMNk02sB7bI5
t4ajSaNb/GVy/HWkpTENQ5myC/6dOFXJdRNQppPLsqrZmgNj/3iHHOT5EdN0acWh
r7P1TH/CP93UHEGGx+nFxiBq5UQ0Zp+l1bHQ0Tx67XEvXedX6bnxlXvZGI2QhoUY
gk8rXomByyJmWCGiJ+qRM1ibhgOulZ3w/aPuqvbZim9eUeISZGXuGzHK9NT2UpU0
A3biy4+Sn1/5yiUETCWfNmYGPi5qLqAOFOUP9OJp7+tEUt+ujvUJvfri8WnFs+aa
Rme0igklAb2kWQqktQXu+Ttq5Ym36/Uu2ONjvdNrmXdSOPJ8ccmmOdFiVhuvPPuh
93WuGKeCakBm58q6mRKL9LEle7np/2TZKc05N3qENtCN2v7EYctzeFJBXjUjYWQ+
0nQEur4dcJKGf94Xpgw1i9c1ziOOGwNh4pQv1ViYI7HqLyoMUkSnhcspdLUFtI9C
jYHwE0IXsaASMV9cJ4q7uSUAxFba4hd/OuhErtl1WVgeyY56bo/duco6fmdYoe7Y
mbmFf296+XBvSzqkixX+AUYwl8cejUDyT/rpiH6D2HEsYxmGg3kB6nPwJpC4jgsj
OD3143ikllmAlMKqcGsb1eftoSi4UTLtHn+Ujum1hJjJEukBlGk=
=xrd/
-----END PGP SIGNATURE-----

--b5bvMDatJyRN07Kb--
