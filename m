Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795225048;
	b=UQxQ7XgPbKmq1EuCbSbJhCgCd0/z53qpG96isKAPDXth9x3QGm7mOktLqJmbHVyfhtgy
	 ba8YRSE2pigQ9xBWyxpvcKwNmU/02ZYj3FTv6vodmhpdamEea0c4qxSjOfQ28KJTxgAGp
	 PtJI8b3fYnkN4Br0icwTsMnKhh+HajkbC1Q5BxWvg5ve54olBJzsPBl1vhahviDPfOciF
	 CdB/JpY+FME1w6Sp9KEz1cEZ5OfVylklnx0Y68nLymaEmK6+dMqvyvtuhPX5WaYv1Neco
	 m9j7nVd5RazpRZImO8lM2PfNC6B+EjMBt8cd4uUmLO3zxGLWqdMmE3+Hr4wpBoIXvSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795225048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 In-Reply-To:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SFqzBLCmNI6B/4yJC9Gu894MqT114D7EhgBz8A59xA0=;
	b=lRtJp9hGKYDLmnPQqe6+s3O0EuEs3kn4WmETvJC3TTn57XjvKEzhbWTjXKxUtLFn6EJp
	 1EQnfesluvnZP3iY5DK+tlyVtIR1ngh6DU8wZ97sCSdDDtuwu+j6sC5lnrCEW0eZHBWZO
	 cG51Fj3oT4CNuekGiTcbZolExJaum9w/bfPjVyE6b0XPZppLlgg2JXCOpDyUJmsp3t6rc
	 8o6WrsQew+MvK4Sdlq1v2zAQdn7SNCEWg1nZXz1FR8pqnnefM8Edm9ZNWyINEX6LVdBhA
	 6QlUlwXBtfUoAYk52VxzWoRcb4GDONscHwuUredAK19MUYTTYSkqWMKVPMbZFHHYHjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UnvdOkhb;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1579606A6BC
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 01:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1579606A6BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UnvdOkhb
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b5ae415f7fso118809b3a.0
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 17:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795225038; x=1795829838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SFqzBLCmNI6B/4yJC9Gu894MqT114D7EhgBz8A59xA0=;
        b=UnvdOkhbSYXLSZVdw/1mJod9/YseNsZEtB0XpXaPeclL+GM13AM563I5BKziFerjaJ
         tg9VkGaITW+ZE3UihHIfZ920Gv3r8WU85fb6KBs4dvk1BbAMcBXeFAmu2z4y9Fs1ygs5
         SAVWRVLb4roM39HDGE0P/trZCWxXVt5caTWo4pFbntxbKMq3aNrzo45iLh4chRjYHEpe
         ZQLQf1doS9Cx11zT0MaZ6/BcbfDSKAGxeGQs4QfxI/P9FFgJENicMcOIF1R+hlbekzV1
         +EVTAwWDOOhNzOQFg3hqhEnzgE6Uc6eezyRDe8su9y4L/cQJujs2vpcRZHyXhnF9r+Zb
         tE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795225038; x=1795829838;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SFqzBLCmNI6B/4yJC9Gu894MqT114D7EhgBz8A59xA0=;
        b=S6a6tOAWZNzpgMztmtOlPlVp2KpcCjQuXxP6V9Lpb/9f/vxVfM1eu5ZJpaMQzwBLfx
         sR1xG0SK0H5Q0jul5RSyjgc/6Ru4TsVSDDMv8YHNlJdgG+QV6UaMgJKkC10WH7aqh+rs
         XGSURpWvwf7GShXONz2EOAa8OKLQz6rIpzmE5xsuxBi95nIHrefkxJ/bJ/C5T7DoX6A7
         E5jsYODxXc7bxWe1zZwG/Re4HM6eRKGfpzwNatylg5MCjN7riDeDXCuMZXxYEnNrg84J
         zkn7buMRvCcjBTTgxaBNHMLmNs4yYgnlLuwgb+eMA4uaelGan8yrf4W1kEEeAj1/dV7M
         NdYQ==
X-Gm-Message-State: APuU4Z9jy3qmvuO4bH/n3caCuqGq0Tr2CynxSdyMSJ0aEJXXBqodN3Ub
	WhCnuzneQHBVmaU/0lXoW+OWUEwRYAwluPp4ofpagmoQbyx3TvpYcq8mNCqydLz7
X-Gm-Gg: AZFdTZdd3ZSaof+2k+U5tN4haoUc7MVvFASrd94gxlfd2MiDL/Z0jG/Jn3Lv3aqAdjW
	wHjdFZHloAYzKq98a3JyL4otF6l+pObvewKObOSyycATD2PKv81buzA71S+0ef1h0G2WaZIDmMZ
	v8BmGj4OveHZv3gdZRGikyiOAnNHTjgMWo/YjCyw6/p070iQF/obSOEdmtcRi59XYXdTEKf7+z8
	3/maYkEHSTgzN7DE/MdIvh0BSld1zRzXoN2KHndmnceR0fcbDEwkS36gkYXTPXIKnY3wRAf7kj1
	ZpCJaJ4Fs2n+VameW3y6cbHftYT6zpqYCeu8w+gyJWcEQp5mJXAyGQdFewEIwkavEhlm/ndwt5X
	AHDTO5jnTBKXoD7kqYsnz7tvt+V3br493vbPtcuzxXy5owrtpdKAWmVWdQzkLEFFt6Zwman2krA
	dEXeEUtrzycPiSd7zJ8L1lJCHeXf6YLQDyeaHk/ipm23VUFqV8d7Ep8A84D+K8w59y2f+pbyFCr
	rXHDHQrj61NRzIOn2/EPGQmgGf1Ycpg0IMaOmG5fmBu30Rqg1/7TZKqCsQfvBr3m/6f2JEbfXEx
	Rl7gtNysrlgWQtjnAS+au5FSjjM1cCpVZGj7DR622D8ZwGMYJKDy7wOC411t6OmnPeSwei97qFq
	gL9v/UMjWwaRIPyX/IkXFChaX8fLu9Flqve9Vczymb1gAuJZi1gSMIW/WFmn79I0IhtPKa3Lao7
	EAImieb7ke
X-Received: by 2002:a05:6a00:1a0b:b0:8ba:fa01:4925 with SMTP id d2e1a72fcca58-8c8796aa4fbmr5789559b3a.1.1795225038037;
        Fri, 20 Nov 2026 17:37:18 -0800 (PST)
Received: from canneberge (dhcp-206-87-134-18.ubcsecure.wireless.ubc.ca. [206.87.134.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873b2434asm2127815b3a.45.2026.11.20.17.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:37:17 -0800 (PST)
From: Andrei =?utf-8?Q?=C8=98ova?= <andreisva2023@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org
Subject: [PATCH v2] builtin/clone: fix --revision when remote / local hash
 algos differ
In-Reply-To: <87mrr486sg.fsf@gmail.com>
Date: Thu, 19 Nov 2026 21:00:52 -0700
Message-ID: <87a4n3ufqw.fsf@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Under protocol v2, "git clone --revision" fails with "fatal: Remote
revision ... not found in upstream origin" when it is passed a valid
commit hash with an algorithm that does not match the default
algorithm (under protocol v1, this error message is: "fatal: couldn't
find remote ref ..."). However, the hash points to a valid commit object
on the remote.

The refspec item is created before the destination repository's hash
algorithm is set up, so when cloning repositories using a different
object format parse_refspec incorrectly parses the hash.

Delay the initialization of the refspec item until after we have
gathered the remote repository's hash algorithm, so that it parses
correctly under the expected algorithm. Consequently, leave the prefix
list empty when --revision is used to get all the advertised refs.

Signed-off-by: Andrei =C8=98ova <andreisva2023@gmail.com>
---
 builtin/clone.c           | 38 +++++++++++++++++++++++---------------
 t/t5621-clone-revision.sh | 19 +++++++++++++++++++
 2 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 4b9929b980..07a4c2db98 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -485,7 +485,8 @@ static struct ref *find_remote_branch(const struct ref =
*refs, const char *branch
=20
 static struct ref *wanted_peer_refs(struct clone_opts *opts,
 				    const struct ref *refs,
-				    struct refspec *refspec)
+				    struct refspec *refspec,
+				    int rev_refspec_idx)
 {
 	struct ref *local_refs =3D NULL;
 	struct ref **tail =3D &local_refs;
@@ -506,7 +507,7 @@ static struct ref *wanted_peer_refs(struct clone_opts *=
opts,
 	}
=20
 	for (size_t i =3D 0; i < refspec->nr; i++)
-		get_fetch_map(refs, &refspec->items[i], &tail, 0);
+		get_fetch_map(refs, &refspec->items[i], &tail, i =3D=3D rev_refspec_idx);
=20
 	free_one_ref(to_free);
=20
@@ -963,6 +964,7 @@ int cmd_clone(int argc,
 	struct string_list server_options =3D STRING_LIST_INIT_NODUP;
 	const char *bundle_uri =3D NULL;
 	char *option_rev =3D NULL;
+	int rev_refspec_idx =3D -1;
=20
 	struct clone_opts opts =3D CLONE_OPTS_INIT;
=20
@@ -1478,24 +1480,24 @@ int cmd_clone(int argc,
 	if (transport->smart_options && !deepen && !filter_options.choice)
 		transport->smart_options->check_self_contained_and_connected =3D 1;
=20
+	if ((option_tags || option_branch) && !option_rev)
+		/*
+		 * Add tags refspec when user asked for tags (implicitly) or
+		 * specified --branch, whose argument might be a tag.
+		 */
+		refspec_append(&remote->fetch, TAG_REFSPEC);
+
+	if (!option_rev)
+		refspec_ref_prefixes(&remote->fetch,
+				     &transport_ls_refs_options.ref_prefixes);
+
 	if (option_rev) {
 		option_tags =3D 0;
 		option_single_branch =3D 0;
 		opts.wants_head =3D 0;
 		opts.detach =3D 1;
-
-		refspec_append(&remote->fetch, option_rev);
 	}
=20
-	if (option_tags || option_branch)
-		/*
-		 * Add tags refspec when user asked for tags (implicitly) or
-		 * specified --branch, whose argument might be a tag.
-		 */
-		refspec_append(&remote->fetch, TAG_REFSPEC);
-
-	refspec_ref_prefixes(&remote->fetch,
-			     &transport_ls_refs_options.ref_prefixes);
 	if (option_branch)
 		expand_ref_prefix(&transport_ls_refs_options.ref_prefixes,
 				  option_branch);
@@ -1508,7 +1510,7 @@ int cmd_clone(int argc,
 	 * ref_prefixes will be empty so we fall back to asking about HEAD to
 	 * reduce traffic from the server.
 	 */
-	if (opts.wants_head || transport_ls_refs_options.ref_prefixes.nr =3D=3D 0)
+	if ((opts.wants_head || transport_ls_refs_options.ref_prefixes.nr =3D=3D =
0) && !option_rev)
 		strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
=20
 	refs =3D transport_get_remote_refs(transport, &transport_ls_refs_options);
@@ -1525,6 +1527,12 @@ int cmd_clone(int argc,
 	create_reference_database(the_repository, NULL, 1);
 	startup_info->have_repository =3D 1;
=20
+	if (option_rev) {
+		remote->fetch.hash_algo =3D the_repository->hash_algo;
+		rev_refspec_idx =3D remote->fetch.nr;
+		refspec_append(&remote->fetch, option_rev);
+	}
+
 	/*
 	 * Before fetching from the remote, download and install bundle
 	 * data from the --bundle-uri option.
@@ -1589,7 +1597,7 @@ int cmd_clone(int argc,
 	}
=20
 	if (refs)
-		mapped_refs =3D wanted_peer_refs(&opts, refs, &remote->fetch);
+		mapped_refs =3D wanted_peer_refs(&opts, refs, &remote->fetch, rev_refspe=
c_idx);
=20
 	if (mapped_refs) {
 		/*
diff --git a/t/t5621-clone-revision.sh b/t/t5621-clone-revision.sh
index 54789423f8..a52c0a1d0e 100755
--- a/t/t5621-clone-revision.sh
+++ b/t/t5621-clone-revision.sh
@@ -78,6 +78,25 @@ test_expect_success 'clone with --revision being a raw c=
ommit hash' '
 	test_must_fail git -C dst config remote.origin.fetch
 '
=20
+test_expect_success 'clone with --revision being a raw SHA-256 commit hash=
' '
+	test_when_finished "rm -rf src256 dst256" &&
+
+	git init --object-format=3Dsha256 src256 &&
+	test_commit -C src256 "test" &&
+	oid=3D$(git -C src256 rev-parse HEAD) &&
+
+	GIT_DEFAULT_HASH=3Dsha1 git clone --no-local --revision=3D$oid src256 dst=
256 &&
+
+	echo $oid >expect &&
+	git -C dst256 rev-parse HEAD >actual &&
+	test_cmp expect actual &&
+
+	git -C dst256 for-each-ref refs >actual &&
+	test_must_be_empty actual &&
+
+	test_must_fail git -C dst256 config remote.origin.fetch
+'
+
 test_expect_success 'clone with --revision and --bare' '
 	test_when_finished "rm -rf dst" &&
 	git clone --revision=3Drefs/heads/main --bare . dst &&
--=20
2.55.0
