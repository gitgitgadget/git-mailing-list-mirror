Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97190405CD
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sYBlQCxq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UM5Jsk8p"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id A1BC83201289;
	Mon,  8 Jan 2024 07:18:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 08 Jan 2024 07:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704716322; x=1704802722; bh=PbmsRiNoE5
	9+zE90j2HD0dSEDlpS3Rsze2wAZJpAAoQ=; b=sYBlQCxqYDzgtJeP4uZ/Rw41td
	fpLlbGoZTqQZaP9sad2pjOzi4vcXVCchD7ftHvxwklgfX6IlKialR7xSthrBtzp8
	ZG4JMPUGKnjEUH6e0I8R4YKrdN2A0z2qJ8e7aumohDpx5anyd47SPvyDt5tm0Mcz
	51AeVUvMEerGx3mI+6hR9UlFWMRglzn/Pp5efhkC6dm8Q/Mhwtx09d+hC06u2Xtd
	IQb6bAK5zwQMLpqfkbEnRjj6vOXj+kQ/0cVb/xnR09QOG+INpgPm1UY4Nw9E/ZAu
	lHG1V9E5nwI0A2kpy3Q7cS3QB8Z5CVuHB/zryHVie/yfKDBcd9E2C7ptwjvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704716322; x=1704802722; bh=PbmsRiNoE59+zE90j2HD0dSEDlpS
	3Rsze2wAZJpAAoQ=; b=UM5Jsk8puYLQev4pCWd8fsz2M+jsXtKOtPSBgWLssWXg
	NpyolPtbeyxIZLKj+THTZltXkxEh9dK6x8s8vCMzgrYlbp5LVxKo5p3qAzv/YV1D
	4dEhfcAVIgWSEGrnbwzLENQyUe2TUaIDXDCdaFjbc7FOxRCdQS6/eneDfpwcPmHB
	gCcqeGRLpdfmSn55l7OEzAaRQQh//SbDY0f4fuao895AtzZIpuBU7EtEcLAW65ZG
	ZBKegFVvlVTcAJvpfyt7ILjRJu1rtpWINIHFbMhD1BXGexWlJTET9Z14HMmTgGGn
	R091gXUHlg4fvX7WP+3bObJl7vsKJIAeX7UGI90UeQ==
X-ME-Sender: <xms:IeibZW79ieSAaiYrlt8HzLm45Ih-tbpbb9DjJHVYGVg2vYlm7im2tA>
    <xme:IeibZf7Xz5Xk9JG8MVvygSOjanrVZZM0DHF0sRk2Zq4pOfaOnajtFTMZitJ5hNp2B
    CmXFVjI9JeZ8rroJQ>
X-ME-Received: <xmr:IeibZVeDFd8mO9fOLX-8RGgntgtL7xFam4FujwR6zLv4UZKXaNTEr1GBIPdykMX-AcoAU_r1ZPfD4rH-hUS_3Y_DyWrUWDlYDRbg0neoIU--jbE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehjedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeetueevhffhudefvdegieeuieelgedthf
    egfedtueevjeejtdfgjeehudejuedtudenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:IuibZTKCQBsJ3fJLpdwZUOKGZwgv6kxzf33nJzOPP7NKo5R0zLtgow>
    <xmx:IuibZaIfzC0C_87BxOJYnzW0i9-QZMZtvWhMvKnkVoI_Z2dAHC9V9Q>
    <xmx:IuibZUygkwp_tHSCW6tMaLYfNnoHki9obCUxs3KLY15vq3RY5CnemQ>
    <xmx:IuibZUwUOUshcfxbQMZkSI0TsSiSqgdAxt1ff4x-VrLyZE2x7MXb4A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 07:18:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 39b5d7e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jan 2024 12:16:05 +0000 (UTC)
Date: Mon, 8 Jan 2024 13:18:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH 3/4] reftable/stack: use stat info to avoid re-reading stack
 list
Message-ID: <4fabdc3d8016dbc1e20fbe90058ee7320a5f770b.1704714575.git.ps@pks.im>
References: <cover.1704714575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zecx7xfy7k7jHTZR"
Content-Disposition: inline
In-Reply-To: <cover.1704714575.git.ps@pks.im>


--Zecx7xfy7k7jHTZR
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
a change, at least the inode number should have changed.

This change significantly speeds up operations where many refs are read,
like when using git-update-ref(1). The following benchmark creates N
refs in an otherwise-empty repository via `git update-ref --stdin`:

  Benchmark 1: update-ref: create many refs (refcount =3D 1, revision =3D H=
EAD~)
    Time (mean =C2=B1 =CF=83):       5.6 ms =C2=B1   0.2 ms    [User: 2.5 m=
s, System: 3.0 ms]
    Range (min =E2=80=A6 max):     5.2 ms =E2=80=A6   6.0 ms    89 runs

  Benchmark 2: update-ref: create many refs (refcount =3D 100, revision =3D=
 HEAD~)
    Time (mean =C2=B1 =CF=83):      19.2 ms =C2=B1   0.3 ms    [User: 8.6 m=
s, System: 10.4 ms]
    Range (min =E2=80=A6 max):    18.4 ms =E2=80=A6  19.8 ms    63 runs

  Benchmark 3: update-ref: create many refs (refcount =3D 10000, revision =
=3D HEAD~)
    Time (mean =C2=B1 =CF=83):      1.310 s =C2=B1  0.014 s    [User: 0.566=
 s, System: 0.724 s]
    Range (min =E2=80=A6 max):    1.291 s =E2=80=A6  1.342 s    10 runs

  Benchmark 4: update-ref: create many refs (refcount =3D 1, revision =3D H=
EAD)
    Time (mean =C2=B1 =CF=83):       5.7 ms =C2=B1   0.4 ms    [User: 2.6 m=
s, System: 3.1 ms]
    Range (min =E2=80=A6 max):     5.1 ms =E2=80=A6   9.5 ms    91 runs

  Benchmark 5: update-ref: create many refs (refcount =3D 100, revision =3D=
 HEAD)
    Time (mean =C2=B1 =CF=83):      15.2 ms =C2=B1   0.3 ms    [User: 7.0 m=
s, System: 8.1 ms]
    Range (min =E2=80=A6 max):    14.3 ms =E2=80=A6  17.1 ms    71 runs

  Benchmark 6: update-ref: create many refs (refcount =3D 10000, revision =
=3D HEAD)
    Time (mean =C2=B1 =CF=83):     916.1 ms =C2=B1  11.0 ms    [User: 420.8=
 ms, System: 495.0 ms]
    Range (min =E2=80=A6 max):   906.9 ms =E2=80=A6 943.8 ms    10 runs

  Summary
    update-ref: create many refs (refcount =3D 1, revision =3D HEAD~) ran
      1.01 =C2=B1 0.09 times faster than update-ref: create many refs (refc=
ount =3D 1, revision =3D HEAD)
      2.72 =C2=B1 0.11 times faster than update-ref: create many refs (refc=
ount =3D 100, revision =3D HEAD)
      3.42 =C2=B1 0.13 times faster than update-ref: create many refs (refc=
ount =3D 100, revision =3D HEAD~)
    163.59 =C2=B1 5.62 times faster than update-ref: create many refs (refc=
ount =3D 10000, revision =3D HEAD)
    233.91 =C2=B1 7.92 times faster than update-ref: create many refs (refc=
ount =3D 10000, revision =3D HEAD~)
---
 reftable/stack.c  | 10 +++++++++-
 reftable/stack.h  |  1 +
 reftable/system.h |  1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index b1ee247601..a51a2dbf1f 100644
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
@@ -374,6 +375,8 @@ static int reftable_stack_reload_maybe_reuse(struct ref=
table_stack *st,
 		sleep_millisec(delay);
 	}
=20
+	stat_validity_update(&st->list_validity, fd);
+
 out:
 	if (fd >=3D 0)
 		close(fd);
@@ -388,8 +391,13 @@ static int reftable_stack_reload_maybe_reuse(struct re=
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


--Zecx7xfy7k7jHTZR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWb6B4ACgkQVbJhu7ck
PpRWiQ/9ESl3cx57Vv5errAYY6en0rM058Gb9l2rBuxoMrXrREEdY2qBOiNJOZg9
aURdm/ppbqAUUKUhdyFztUjrJVuR3szEqlit2QiyJc3XYP/RCUmIQHrdbrUEr5P8
lHorLtOV7uR6VXijutUzNsei/AA6ie0OuLOBrA1VMQh2r90adGbm0mOk8V1in52j
4sv3z4nMC0W03DJiFISfE6z3oJphx8UEPfTmm54kpcEoIIBqHeF4szfsgBZPaEsk
3DrfKIvjmYyJhJej15yr507Rn70E4wRBLb8ltLZI6df7uP6Xke5waNSuQWbe3MpR
/qww2YZVC9AaSXqWmepIYczCUskJVPMnw+Q9g45+kp7MG2/AaKGEdBL9gXT839px
Pfnp+w/PoOIn5A3grHjnOGauSO/Z6eYqopT4TwZWVj6ffVlnf2B82uZl4xlbJ3Aw
c+ZirEuWdkuZ6wGyQ+iKXmsg73LIWHhcRQ/eGDaYiqfjZkxR1R6ML8Dx3+cNPXCN
n1h2zJJmV4PG0Inx3Vebofh26HOL+mxLu3lbEIOvc41hXlgRGlSplTBrCwRmbuuR
DKL91J+gUSOftd2QtRDhRDEcLxeb3CRec06A4rFgAsvUcQM9R4hwZpeBxLjBE4N1
y4eL4GUhqhC7Ffz6zaEiuQHXzNmGg9rOHE7kb8J1buHNRdPGFA0=
=emUX
-----END PGP SIGNATURE-----

--Zecx7xfy7k7jHTZR--
