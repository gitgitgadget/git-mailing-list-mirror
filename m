Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA53E12E53
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f0SD5vXG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p/LtjTka"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id D9BB93200A3F;
	Thu, 11 Jan 2024 05:06:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 11 Jan 2024 05:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704967610; x=1705054010; bh=v4woTvYcNA
	S3r4VRYiQj4ffrk8X6Z6CjqtlTufs0Z8M=; b=f0SD5vXGBTSAGoBpkqFvX+ZDwf
	BifaFHvt85r2VXeSB7VadYM0Z4LvtHSldI98PUr6NWIF/gJctOFhZUb8AyWGYRU4
	/RcNa3LBKwXqktTgFE8tDzDgEQrgI0sFPryFZ5b1MjUzGZCugMcP+QAh8tPADpLQ
	9ALDhHx0K7ImkSAJZ94pDHkX2qT0xYhMcwcoyuzuHzjJN0L978qNrgEGdZYrgWB5
	XNuOBNYNv/ybHK71qz52NF7+bw1k2gmWLEOgHxnh1fzNIQACCrRdgXKKId6RN5Mq
	1+oI1CkPxUkwIaHv0dd3sf4B1rqaprX3+w7/IgABaRsBVXymwGIE+K1x6haw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704967610; x=1705054010; bh=v4woTvYcNAS3r4VRYiQj4ffrk8X6
	Z6CjqtlTufs0Z8M=; b=p/LtjTkanOZdH3SIFtkCI0OgLpvj7uR2vZUl3fCET6xw
	B63ksXCzkTgtt1h6ijx+b9RjQJgE9FcuomMUJUBg+bTpJXcO1jm1VubDpYalQt7C
	KNvDlOtqTDfXfimjayT6ldo4AkIp5Oy2xepRtx5PhC0AT9yGjSCYOdLSJQzSNbgy
	4bYRSz0zboOqMBIjCZgp+7G8WrWZthzkWDzO3iItLFo7HaDByxrtt9KeGpunT6qj
	70TKd80O/8uZRZ1bj4ieg14515Dxr5gJedRE1vAAsH306A8hVLIVP1TlMHfkufVE
	KN/KdNMeUNUTRjmW0gZSpzeYraIzqWGnP6wPvZyqxA==
X-ME-Sender: <xms:ur2fZeWn8eIuSXd9uVb1TiKdMq3iKEKIzSnfsqZDWUz4rcwCQH7fWw>
    <xme:ur2fZalWzmI6wtRZOzuuStCx7mVDc7f0fNP6L-OyBT-LyyOSsZrTvbfeAmCgH_dd8
    Pewn_x25mbsdJFZAA>
X-ME-Received: <xmr:ur2fZSYU49zAXHURwmCo6fPD3ewvXDVtzXvLsBy0SeuFB8CnAOa0rKgeGABFc32tEal6O-9lFbR4COfLI8I1wNfBf_avrbrpV8KFldkyAMuCwfECNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeifedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeetueevhffhudefvdegieeuieelgedthf
    egfedtueevjeejtdfgjeehudejuedtudenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ur2fZVUktdxcxISBzQdxkO-MvMPKXFfetX8AWRhIDzLg8b_c3UNtOg>
    <xmx:ur2fZYmaZCgRmx_VUQ5IrmChx6QljEvh8HrWIkSQ_U1RMuXaf1UNQQ>
    <xmx:ur2fZad-31pYCmfE40Ats2yl-o63JVHa8EC1D_UnmaKIsL75y3kZZg>
    <xmx:ur2fZUuFihujeshrWkuWwUxvWqwVdh29q9YypVMp8RjjLMHSfeUsfw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jan 2024 05:06:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 79472dab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jan 2024 10:04:07 +0000 (UTC)
Date: Thu, 11 Jan 2024 11:06:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/5] reftable/stack: use stat info to avoid re-reading
 stack list
Message-ID: <c0f7cec95bd78231bbbce2a30662b71fe00b091d.1704966670.git.ps@pks.im>
References: <cover.1704714575.git.ps@pks.im>
 <cover.1704966670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cpLXQT/a+D2lPwCv"
Content-Disposition: inline
In-Reply-To: <cover.1704966670.git.ps@pks.im>


--cpLXQT/a+D2lPwCv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Whenever we call into the refs interfaces we potentially have to reload
refs in case they have been concurrently modified, either in-process or
externally. While this happens somewhat automatically for loose refs
because we simply try to re-read the files, the "packed" backend will
reload its snapshot of the packed-refs file in case its stat info has
changed since last reading it.

In the reftable backend we have a similar mechanism that is provided by
`reftable_stack_reload()`. This function will read the list of stacks
=66rom "tables.list" and, if they have changed from the currently stored
list, reload the stacks. This is heavily inefficient though, as we have
to check whether the stack is up-to-date on basically every read and
thus keep on re-reading the file all the time even if it didn't change
at all.

We can do better and use the same stat(3P)-based mechanism that the
"packed" backend uses. Instead of reading the file, we will only open
the file descriptor, fstat(3P) it, and then compare the info against the
cached value from the last time we have updated the stack. This should
always work alright because "tables.list" is updated atomically via a
rename, so even if the ctime or mtime wasn't granular enough to identify
a change, at least the inode number or file size should have changed.

This change significantly speeds up operations where many refs are read,
like when using git-update-ref(1). The following benchmark creates N
refs in an otherwise-empty repository via `git update-ref --stdin`:

  Benchmark 1: update-ref: create many refs (refcount =3D 1, revision =3D H=
EAD~)
    Time (mean =C2=B1 =CF=83):       5.1 ms =C2=B1   0.2 ms    [User: 2.4 m=
s, System: 2.6 ms]
    Range (min =E2=80=A6 max):     4.8 ms =E2=80=A6   7.2 ms    109 runs

  Benchmark 2: update-ref: create many refs (refcount =3D 100, revision =3D=
 HEAD~)
    Time (mean =C2=B1 =CF=83):      19.1 ms =C2=B1   0.9 ms    [User: 8.9 m=
s, System: 9.9 ms]
    Range (min =E2=80=A6 max):    18.4 ms =E2=80=A6  26.7 ms    72 runs

  Benchmark 3: update-ref: create many refs (refcount =3D 10000, revision =
=3D HEAD~)
    Time (mean =C2=B1 =CF=83):      1.336 s =C2=B1  0.018 s    [User: 0.590=
 s, System: 0.724 s]
    Range (min =E2=80=A6 max):    1.314 s =E2=80=A6  1.373 s    10 runs

  Benchmark 4: update-ref: create many refs (refcount =3D 1, revision =3D H=
EAD)
    Time (mean =C2=B1 =CF=83):       5.1 ms =C2=B1   0.2 ms    [User: 2.4 m=
s, System: 2.6 ms]
    Range (min =E2=80=A6 max):     4.8 ms =E2=80=A6   7.2 ms    109 runs

  Benchmark 5: update-ref: create many refs (refcount =3D 100, revision =3D=
 HEAD)
    Time (mean =C2=B1 =CF=83):      14.8 ms =C2=B1   0.2 ms    [User: 7.1 m=
s, System: 7.5 ms]
    Range (min =E2=80=A6 max):    14.2 ms =E2=80=A6  15.2 ms    82 runs

  Benchmark 6: update-ref: create many refs (refcount =3D 10000, revision =
=3D HEAD)
    Time (mean =C2=B1 =CF=83):     927.6 ms =C2=B1   5.3 ms    [User: 437.8=
 ms, System: 489.5 ms]
    Range (min =E2=80=A6 max):   919.4 ms =E2=80=A6 936.4 ms    10 runs

  Summary
    update-ref: create many refs (refcount =3D 1, revision =3D HEAD) ran
      1.00 =C2=B1 0.07 times faster than update-ref: create many refs (refc=
ount =3D 1, revision =3D HEAD~)
      2.89 =C2=B1 0.14 times faster than update-ref: create many refs (refc=
ount =3D 100, revision =3D HEAD)
      3.74 =C2=B1 0.25 times faster than update-ref: create many refs (refc=
ount =3D 100, revision =3D HEAD~)
    181.26 =C2=B1 8.30 times faster than update-ref: create many refs (refc=
ount =3D 10000, revision =3D HEAD)
    261.01 =C2=B1 12.35 times faster than update-ref: create many refs (ref=
count =3D 10000, revision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c  | 12 +++++++++++-
 reftable/stack.h  |  1 +
 reftable/system.h |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index b1ee247601..c28d82299d 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -175,6 +175,7 @@ void reftable_stack_destroy(struct reftable_stack *st)
 		st->readers_len =3D 0;
 		FREE_AND_NULL(st->readers);
 	}
+	stat_validity_clear(&st->list_validity);
 	FREE_AND_NULL(st->list_file);
 	FREE_AND_NULL(st->reftable_dir);
 	reftable_free(st);
@@ -374,7 +375,11 @@ static int reftable_stack_reload_maybe_reuse(struct re=
ftable_stack *st,
 		sleep_millisec(delay);
 	}
=20
+	stat_validity_update(&st->list_validity, fd);
+
 out:
+	if (err)
+		stat_validity_clear(&st->list_validity);
 	if (fd >=3D 0)
 		close(fd);
 	free_names(names);
@@ -388,8 +393,13 @@ static int reftable_stack_reload_maybe_reuse(struct re=
ftable_stack *st,
 static int stack_uptodate(struct reftable_stack *st)
 {
 	char **names =3D NULL;
-	int err =3D read_lines(st->list_file, &names);
+	int err;
 	int i =3D 0;
+
+	if (stat_validity_check(&st->list_validity, st->list_file))
+		return 0;
+
+	err =3D read_lines(st->list_file, &names);
 	if (err < 0)
 		return err;
=20
diff --git a/reftable/stack.h b/reftable/stack.h
index f57005846e..3f80cc598a 100644
--- a/reftable/stack.h
+++ b/reftable/stack.h
@@ -14,6 +14,7 @@ license that can be found in the LICENSE file or at
 #include "reftable-stack.h"
=20
 struct reftable_stack {
+	struct stat_validity list_validity;
 	char *list_file;
 	char *reftable_dir;
 	int disable_auto_compact;
diff --git a/reftable/system.h b/reftable/system.h
index 6b74a81514..2cc7adf271 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -12,6 +12,7 @@ license that can be found in the LICENSE file or at
 /* This header glues the reftable library to the rest of Git */
=20
 #include "git-compat-util.h"
+#include "statinfo.h"
 #include "strbuf.h"
 #include "hash-ll.h" /* hash ID, sizes.*/
 #include "dir.h" /* remove_dir_recursively, for tests.*/
--=20
2.43.GIT


--cpLXQT/a+D2lPwCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWfvbcACgkQVbJhu7ck
PpTtnQ//TDnPKsTGOHVYKx12e6WVyzG8miW6aZF54VybeYz59t1RwNtvvxylIZnI
Avqrwxd+bAoQWqF4FeSOP/Af0dQZIBIF2Pg+7PMq3Oi51nZdMr0nJmwpNqTV7Uzg
oXaIRi0V/F8mIf4uP5NoCyz7KVf4YnhnAqCJFPkLz1UHx9hglFXK0qQINbzVJ8BU
6Z/6V4Fpl0jSTzL+0aC/CMSxxgqE+MlSE3ryVm9HZvjw6+PyN7dWHqyHzncvGXid
ES7QkVQ2Zf+pOHFihuu132DsuNvoy9kSUeFenrUYgp1plecUVr6jc0IlC04Cd3d5
pN61mQ4ACkKPyE1HV5YCUBosomOZf5GwaGSpNVdE3+oNOtvHuctEENLX6oa11UOa
V/+KP1KFA18wQ0PGt+OxGeKggf2BZcadaBebSvh1xTwzSZ9o9u/sfl8HN7lAMdrc
SyDxSXnrfwnJPImZO8+YcNH10mR150xWZUDh5pnZprmCLOpl9uyTH/Jb6Ragh2wi
jdlscmrDOb9RxwKY+Uml8CYUb8ncAwt/XthZmA2xKCtPKWSnz+cO/voSIdNauqbx
XMTZUoW0M0ttREAlWMTFKeCklG757FeQu6ieNNdh4OpLHBOWLpLrKKRmXc4TohQ+
yrEXmdokRkJmekxwNPAeIjpyI4w3qsuxE1hmHT8KtxRwwxc89Kw=
=mvLL
-----END PGP SIGNATURE-----

--cpLXQT/a+D2lPwCv--
