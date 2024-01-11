Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21BD13ADA
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 10:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YtooVuou";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yvsCzfK2"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 623A43200A68;
	Thu, 11 Jan 2024 05:06:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 11 Jan 2024 05:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704967599; x=1705053999; bh=zjTSQz0fqt
	WmzTII9VKSOzO3XOohMcTQj4u8rwyMw3A=; b=YtooVuouQE4kU7P4lRGgexfye8
	Xnu3LTD+cXZTnX9EtFy/N5aQBPNegfrsnJ08x5CP4pWv+OawoenyxP09Zo4bQsPo
	kZ6K6LHnhZbuouAY9Hepvm4MM1jn5LMLBQbiJadwa9oyuHqFR2bl0UCw9s8lJmxl
	xsBtH+pKaN+6oOLdf8AUXe0V47g4dK7wE8DIYJWHCxRuYjzH9hmvShn/vsjvKK5j
	/qdN3N8T2ySSH23LIrAqzIueXLJn2x7/148clDP5bSHcHnrwW0IigoWTn4gJyfo6
	Ak8lzmyYmQqcHwhD0JUwIhLz+YPLli/KawqoKpKwRkFKya+bOl1ovQD+do2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704967599; x=1705053999; bh=zjTSQz0fqtWmzTII9VKSOzO3XOoh
	McTQj4u8rwyMw3A=; b=yvsCzfK2cn+GiyIlD0XKfotOVW/u5Wwaki3c+gISjxAF
	BCNk9ilUu9tc+Vy1PDtis46njsJEVj/8g3aBPSMBx7qb0jXMMayxGGtV2uWzVX4M
	snqVD/c1dlR8CkIhZiI1Pz3wQcrlncivuwRh9uLC2XLy1+uO8YkklnA6ZgNd32H2
	LaqNGf80YaKDVbQMvP/vuaEt/UBWXHU/RBSsBdd+eNGC6GQ8dUxQWVZgh/+9WCBj
	0cYyGI0ItuvjSjP4p3du/HwRD+hTQnjN4Bc5ug9PahuAeN13BvlsNTDyiOId5ySZ
	xfyD91GiQep7ys+9f4QE4HvRtks8VdN+tualbjmgcQ==
X-ME-Sender: <xms:r72fZUiCgpUWm9j0U5l8re8OzOuWRarlGcjxXSrh4ZKt8-eR9QhWgQ>
    <xme:r72fZdBE9LvAzs7N9EraY0dTnMhtnDpmXen8KRWF6qLB7O9Od0j6C8FGBPU7A-OX6
    m2JeNjZP0lZSeF_sA>
X-ME-Received: <xmr:r72fZcGE9EMrqw_mb4MeBI9mGWFyKjGxdeuYRydISuea65e__A4v-Ai1NrrcoleXhFloE2BuOXhLC9s3rEBRSNEXL2BHWvlpfAvP1tCC5bUpTMfeCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeifedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeetueevhffhudefvdegieeuieelgedthf
    egfedtueevjeejtdfgjeehudejuedtudenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:r72fZVRYMaNoC6FnShnbSAiJFX8ZBrUKGxDV0NOwQ524k-NLlbaKqw>
    <xmx:r72fZRzYEVNOH4M_z0t5yj9OF0JxmalrQfqUZnXgqdYm1ZdgR7t9Hw>
    <xmx:r72fZT7IeGnHMXBt0WtbRGV23zHg9oshZ31XticvGO_PsuMmDPBeDA>
    <xmx:r72fZSqas7pJq98ZGdSS1VvW0UK815YI_9ZSzdFKSOYIyR_d9WOBTA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jan 2024 05:06:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bc23611c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jan 2024 10:03:55 +0000 (UTC)
Date: Thu, 11 Jan 2024 11:06:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/5] reftable: optimize I/O patterns
Message-ID: <cover.1704966670.git.ps@pks.im>
References: <cover.1704714575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NWk1IY8+iTQoNH54"
Content-Disposition: inline
In-Reply-To: <cover.1704714575.git.ps@pks.im>


--NWk1IY8+iTQoNH54
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that optimizes some I/O
patterns that the reftable library uses. Changes compared to v1:

  - Added missing signoffs.

  - The validity cache is now cleared when reloading the reftable stack
    fails.

  - Style fixes for `reftable_block_source_from_file()` are now in a
    separate commit.

  - We now use `xmmap()` exclusively, relying on its fallback code on
    NO_MMAP platforms.

  - The file descriptor is closed immediately after mmapping now.

Thanks for your review, Junio!

Patrick

Patrick Steinhardt (5):
  reftable/stack: refactor stack reloading to have common exit path
  reftable/stack: refactor reloading to use file descriptor
  reftable/stack: use stat info to avoid re-reading stack list
  reftable/blocksource: refactor code to match our coding style
  reftable/blocksource: use mmap to read tables

 reftable/blocksource.c |  39 ++++++--------
 reftable/stack.c       | 113 +++++++++++++++++++++++++----------------
 reftable/stack.h       |   1 +
 reftable/system.h      |   1 +
 4 files changed, 85 insertions(+), 69 deletions(-)

Range-diff against v1:
1:  01ece2626d ! 1:  4b7f52c415 reftable/stack: refactor stack reloading to=
 have common exit path
    @@ Commit message
         Refactor the function to have a common exit path. While at it, tou=
ch up
         the style of this function a bit to match our usual coding style b=
etter.
    =20
    +    Signed-off-by: Patrick Steinhardt <ps@pks.im>
    +
      ## reftable/stack.c ##
     @@ reftable/stack.c: static int tv_cmp(struct timeval *a, struct timev=
al *b)
      static int reftable_stack_reload_maybe_reuse(struct reftable_stack *s=
t,
2:  726d302d7b ! 2:  36b9f6b624 reftable/stack: refactor reloading to use f=
ile descriptor
    @@ Commit message
         Prepare for this by converting the code to use `fd_read_lines()` s=
o that
         we have the file descriptor readily available.
    =20
    +    Signed-off-by: Patrick Steinhardt <ps@pks.im>
    +
      ## reftable/stack.c ##
     @@ reftable/stack.c: static int reftable_stack_reload_maybe_reuse(stru=
ct reftable_stack *st,
      	struct timeval deadline;
3:  4fabdc3d80 ! 3:  c0f7cec95b reftable/stack: use stat info to avoid re-r=
eading stack list
    @@ Commit message
         cached value from the last time we have updated the stack. This sh=
ould
         always work alright because "tables.list" is updated atomically vi=
a a
         rename, so even if the ctime or mtime wasn't granular enough to id=
entify
    -    a change, at least the inode number should have changed.
    +    a change, at least the inode number or file size should have chang=
ed.
    =20
         This change significantly speeds up operations where many refs are=
 read,
         like when using git-update-ref(1). The following benchmark creates=
 N
         refs in an otherwise-empty repository via `git update-ref --stdin`:
    =20
           Benchmark 1: update-ref: create many refs (refcount =3D 1, revis=
ion =3D HEAD~)
    -        Time (mean =C2=B1 =CF=83):       5.6 ms =C2=B1   0.2 ms    [Us=
er: 2.5 ms, System: 3.0 ms]
    -        Range (min =E2=80=A6 max):     5.2 ms =E2=80=A6   6.0 ms    89=
 runs
    +        Time (mean =C2=B1 =CF=83):       5.1 ms =C2=B1   0.2 ms    [Us=
er: 2.4 ms, System: 2.6 ms]
    +        Range (min =E2=80=A6 max):     4.8 ms =E2=80=A6   7.2 ms    10=
9 runs
    =20
           Benchmark 2: update-ref: create many refs (refcount =3D 100, rev=
ision =3D HEAD~)
    -        Time (mean =C2=B1 =CF=83):      19.2 ms =C2=B1   0.3 ms    [Us=
er: 8.6 ms, System: 10.4 ms]
    -        Range (min =E2=80=A6 max):    18.4 ms =E2=80=A6  19.8 ms    63=
 runs
    +        Time (mean =C2=B1 =CF=83):      19.1 ms =C2=B1   0.9 ms    [Us=
er: 8.9 ms, System: 9.9 ms]
    +        Range (min =E2=80=A6 max):    18.4 ms =E2=80=A6  26.7 ms    72=
 runs
    =20
           Benchmark 3: update-ref: create many refs (refcount =3D 10000, r=
evision =3D HEAD~)
    -        Time (mean =C2=B1 =CF=83):      1.310 s =C2=B1  0.014 s    [Us=
er: 0.566 s, System: 0.724 s]
    -        Range (min =E2=80=A6 max):    1.291 s =E2=80=A6  1.342 s    10=
 runs
    +        Time (mean =C2=B1 =CF=83):      1.336 s =C2=B1  0.018 s    [Us=
er: 0.590 s, System: 0.724 s]
    +        Range (min =E2=80=A6 max):    1.314 s =E2=80=A6  1.373 s    10=
 runs
    =20
           Benchmark 4: update-ref: create many refs (refcount =3D 1, revis=
ion =3D HEAD)
    -        Time (mean =C2=B1 =CF=83):       5.7 ms =C2=B1   0.4 ms    [Us=
er: 2.6 ms, System: 3.1 ms]
    -        Range (min =E2=80=A6 max):     5.1 ms =E2=80=A6   9.5 ms    91=
 runs
    +        Time (mean =C2=B1 =CF=83):       5.1 ms =C2=B1   0.2 ms    [Us=
er: 2.4 ms, System: 2.6 ms]
    +        Range (min =E2=80=A6 max):     4.8 ms =E2=80=A6   7.2 ms    10=
9 runs
    =20
           Benchmark 5: update-ref: create many refs (refcount =3D 100, rev=
ision =3D HEAD)
    -        Time (mean =C2=B1 =CF=83):      15.2 ms =C2=B1   0.3 ms    [Us=
er: 7.0 ms, System: 8.1 ms]
    -        Range (min =E2=80=A6 max):    14.3 ms =E2=80=A6  17.1 ms    71=
 runs
    +        Time (mean =C2=B1 =CF=83):      14.8 ms =C2=B1   0.2 ms    [Us=
er: 7.1 ms, System: 7.5 ms]
    +        Range (min =E2=80=A6 max):    14.2 ms =E2=80=A6  15.2 ms    82=
 runs
    =20
           Benchmark 6: update-ref: create many refs (refcount =3D 10000, r=
evision =3D HEAD)
    -        Time (mean =C2=B1 =CF=83):     916.1 ms =C2=B1  11.0 ms    [Us=
er: 420.8 ms, System: 495.0 ms]
    -        Range (min =E2=80=A6 max):   906.9 ms =E2=80=A6 943.8 ms    10=
 runs
    +        Time (mean =C2=B1 =CF=83):     927.6 ms =C2=B1   5.3 ms    [Us=
er: 437.8 ms, System: 489.5 ms]
    +        Range (min =E2=80=A6 max):   919.4 ms =E2=80=A6 936.4 ms    10=
 runs
    =20
           Summary
    -        update-ref: create many refs (refcount =3D 1, revision =3D HEA=
D~) ran
    -          1.01 =C2=B1 0.09 times faster than update-ref: create many r=
efs (refcount =3D 1, revision =3D HEAD)
    -          2.72 =C2=B1 0.11 times faster than update-ref: create many r=
efs (refcount =3D 100, revision =3D HEAD)
    -          3.42 =C2=B1 0.13 times faster than update-ref: create many r=
efs (refcount =3D 100, revision =3D HEAD~)
    -        163.59 =C2=B1 5.62 times faster than update-ref: create many r=
efs (refcount =3D 10000, revision =3D HEAD)
    -        233.91 =C2=B1 7.92 times faster than update-ref: create many r=
efs (refcount =3D 10000, revision =3D HEAD~)
    +        update-ref: create many refs (refcount =3D 1, revision =3D HEA=
D) ran
    +          1.00 =C2=B1 0.07 times faster than update-ref: create many r=
efs (refcount =3D 1, revision =3D HEAD~)
    +          2.89 =C2=B1 0.14 times faster than update-ref: create many r=
efs (refcount =3D 100, revision =3D HEAD)
    +          3.74 =C2=B1 0.25 times faster than update-ref: create many r=
efs (refcount =3D 100, revision =3D HEAD~)
    +        181.26 =C2=B1 8.30 times faster than update-ref: create many r=
efs (refcount =3D 10000, revision =3D HEAD)
    +        261.01 =C2=B1 12.35 times faster than update-ref: create many =
refs (refcount =3D 10000, revision =3D HEAD~)
    +
    +    Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## reftable/stack.c ##
     @@ reftable/stack.c: void reftable_stack_destroy(struct reftable_stack=
 *st)
    @@ reftable/stack.c: static int reftable_stack_reload_maybe_reuse(struc=
t reftable_s
     +	stat_validity_update(&st->list_validity, fd);
     +
      out:
    ++	if (err)
    ++		stat_validity_clear(&st->list_validity);
      	if (fd >=3D 0)
      		close(fd);
    + 	free_names(names);
     @@ reftable/stack.c: static int reftable_stack_reload_maybe_reuse(stru=
ct reftable_stack *st,
      static int stack_uptodate(struct reftable_stack *st)
      {
-:  ---------- > 4:  96e79dc3ba reftable/blocksource: refactor code to matc=
h our coding style
4:  a23f38a806 ! 5:  e53a20c8e1 reftable/blocksource: use mmap to read tabl=
es
    @@ Commit message
         already and ignores any such errors. Also, `reftable_stack_clean()=
` will
         prune stale tables which are not referenced by "tables.list" anymo=
re so
         that those files can eventually be pruned. And second, we never re=
write
    -    already-rewritten stacks, so it does not matter that we cannot ren=
ame a
    +    already-written stacks, so it does not matter that we cannot renam=
e a
         file over an mmaped file, either.
    =20
         Another unfortunate property of mmap is that it is not supported b=
y all
         systems. But given that the size of reftables should typically be =
rather
         limited (megabytes at most in the vast majority of repositories), =
we can
    -    provide an easy fallback by just reading the complete table into m=
emory
    -    on such platforms. This is the same strategy that the "packed" bac=
kend
    -    uses in case the platform does not provide mmap.
    +    use the fallback implementation provided by `git_mmap()` which rea=
ds the
    +    whole file into memory instead. This is the same strategy that the
    +    "packed" backend uses.
    =20
         While this change doesn't significantly improve performance in the=
 case
         where we're seeking through stacks once (like e.g. git-for-each-re=
f(1)
    @@ Commit message
         empty repository:
    =20
           Benchmark 1: update-ref: create many refs (refcount =3D 1, revis=
ion =3D HEAD~)
    -        Time (mean =C2=B1 =CF=83):       5.6 ms =C2=B1   0.2 ms    [Us=
er: 2.7 ms, System: 2.8 ms]
    -        Range (min =E2=80=A6 max):     5.1 ms =E2=80=A6   6.0 ms    90=
 runs
    +        Time (mean =C2=B1 =CF=83):       5.1 ms =C2=B1   0.2 ms    [Us=
er: 2.5 ms, System: 2.5 ms]
    +        Range (min =E2=80=A6 max):     4.8 ms =E2=80=A6   7.1 ms    11=
1 runs
    =20
           Benchmark 2: update-ref: create many refs (refcount =3D 100, rev=
ision =3D HEAD~)
    -        Time (mean =C2=B1 =CF=83):      15.1 ms =C2=B1   0.4 ms    [Us=
er: 7.1 ms, System: 8.0 ms]
    -        Range (min =E2=80=A6 max):    14.2 ms =E2=80=A6  16.5 ms    71=
 runs
    +        Time (mean =C2=B1 =CF=83):      14.8 ms =C2=B1   0.5 ms    [Us=
er: 7.1 ms, System: 7.5 ms]
    +        Range (min =E2=80=A6 max):    14.1 ms =E2=80=A6  18.7 ms    84=
 runs
    =20
           Benchmark 3: update-ref: create many refs (refcount =3D 10000, r=
evision =3D HEAD~)
    -        Time (mean =C2=B1 =CF=83):     919.4 ms =C2=B1  11.2 ms    [Us=
er: 427.5 ms, System: 491.7 ms]
    -        Range (min =E2=80=A6 max):   908.1 ms =E2=80=A6 936.6 ms    10=
 runs
    +        Time (mean =C2=B1 =CF=83):     926.4 ms =C2=B1   5.6 ms    [Us=
er: 448.5 ms, System: 477.7 ms]
    +        Range (min =E2=80=A6 max):   920.0 ms =E2=80=A6 936.1 ms    10=
 runs
    =20
           Benchmark 4: update-ref: create many refs (refcount =3D 1, revis=
ion =3D HEAD)
    -        Time (mean =C2=B1 =CF=83):       5.5 ms =C2=B1   0.3 ms    [Us=
er: 2.4 ms, System: 3.1 ms]
    -        Range (min =E2=80=A6 max):     5.0 ms =E2=80=A6   7.3 ms    89=
 runs
    +        Time (mean =C2=B1 =CF=83):       5.0 ms =C2=B1   0.2 ms    [Us=
er: 2.4 ms, System: 2.5 ms]
    +        Range (min =E2=80=A6 max):     4.7 ms =E2=80=A6   5.4 ms    11=
1 runs
    =20
           Benchmark 5: update-ref: create many refs (refcount =3D 100, rev=
ision =3D HEAD)
    -        Time (mean =C2=B1 =CF=83):      10.4 ms =C2=B1   0.3 ms    [Us=
er: 5.1 ms, System: 5.3 ms]
    -        Range (min =E2=80=A6 max):     9.7 ms =E2=80=A6  11.0 ms    78=
 runs
    +        Time (mean =C2=B1 =CF=83):      10.5 ms =C2=B1   0.2 ms    [Us=
er: 5.0 ms, System: 5.3 ms]
    +        Range (min =E2=80=A6 max):    10.0 ms =E2=80=A6  10.9 ms    93=
 runs
    =20
           Benchmark 6: update-ref: create many refs (refcount =3D 10000, r=
evision =3D HEAD)
    -        Time (mean =C2=B1 =CF=83):     483.5 ms =C2=B1   6.3 ms    [Us=
er: 227.8 ms, System: 255.6 ms]
    -        Range (min =E2=80=A6 max):   477.5 ms =E2=80=A6 498.8 ms    10=
 runs
    +        Time (mean =C2=B1 =CF=83):     529.6 ms =C2=B1   9.1 ms    [Us=
er: 268.0 ms, System: 261.4 ms]
    +        Range (min =E2=80=A6 max):   522.4 ms =E2=80=A6 547.1 ms    10=
 runs
    =20
           Summary
             update-ref: create many refs (refcount =3D 1, revision =3D HEA=
D) ran
               1.01 =C2=B1 0.06 times faster than update-ref: create many r=
efs (refcount =3D 1, revision =3D HEAD~)
    -          1.89 =C2=B1 0.11 times faster than update-ref: create many r=
efs (refcount =3D 100, revision =3D HEAD)
    -          2.73 =C2=B1 0.16 times faster than update-ref: create many r=
efs (refcount =3D 100, revision =3D HEAD~)
    -         87.55 =C2=B1 4.65 times faster than update-ref: create many r=
efs (refcount =3D 10000, revision =3D HEAD)
    -        166.48 =C2=B1 8.80 times faster than update-ref: create many r=
efs (refcount =3D 10000, revision =3D HEAD~)
    +          2.08 =C2=B1 0.07 times faster than update-ref: create many r=
efs (refcount =3D 100, revision =3D HEAD)
    +          2.95 =C2=B1 0.14 times faster than update-ref: create many r=
efs (refcount =3D 100, revision =3D HEAD~)
    +        105.33 =C2=B1 3.76 times faster than update-ref: create many r=
efs (refcount =3D 10000, revision =3D HEAD)
    +        184.24 =C2=B1 5.89 times faster than update-ref: create many r=
efs (refcount =3D 10000, revision =3D HEAD~)
    =20
         Theoretically, we could also replicate the strategy of the "packed"
         backend where small tables are read into memory instead of using m=
map.
         Benchmarks did not confirm that this has a performance benefit tho=
ugh.
    =20
    +    Signed-off-by: Patrick Steinhardt <ps@pks.im>
    +
      ## reftable/blocksource.c ##
    -@@ reftable/blocksource.c: license that can be found in the LICENSE fi=
le or at
    - #include "reftable-blocksource.h"
    - #include "reftable-error.h"
    -=20
    -+#if defined(NO_MMAP)
    -+static int use_mmap =3D 0;
    -+#else
    -+static int use_mmap =3D 1;
    -+#endif
    -+
    - static void strbuf_return_block(void *b, struct reftable_block *dest)
    - {
    - 	if (dest->len)
     @@ reftable/blocksource.c: struct reftable_block_source malloc_block_s=
ource(void)
    + }
    +=20
      struct file_block_source {
    - 	int fd;
    +-	int fd;
      	uint64_t size;
     +	unsigned char *data;
      };
    @@ reftable/blocksource.c: static uint64_t file_size(void *b)
     -	if (fd > 0) {
     -		close(fd);
     -		((struct file_block_source *)b)->fd =3D 0;
    +-	}
    +-
     +	struct file_block_source *b =3D v;
    -+
    -+	if (b->fd >=3D 0) {
    -+		close(b->fd);
    -+		b->fd =3D -1;
    - 	}
    -=20
    -+	if (use_mmap)
    -+		munmap(b->data, b->size);
    -+	else
    -+		reftable_free(b->data);
    -+	b->data =3D NULL;
    -+
    ++	munmap(b->data, b->size);
      	reftable_free(b);
      }
     =20
    @@ reftable/blocksource.c: static int file_read_block(void *v, struct r=
eftable_bloc
      	return size;
      }
     @@ reftable/blocksource.c: int reftable_block_source_from_file(struct =
reftable_block_source *bs,
    - {
    - 	struct stat st =3D { 0 };
    - 	int err =3D 0;
    --	int fd =3D open(name, O_RDONLY);
    -+	int fd;
    - 	struct file_block_source *p =3D NULL;
    -+
    -+	fd =3D open(name, O_RDONLY);
    - 	if (fd < 0) {
    - 		if (errno =3D=3D ENOENT) {
    - 			return REFTABLE_NOT_EXIST_ERROR;
    -@@ reftable/blocksource.c: int reftable_block_source_from_file(struct =
reftable_block_source *bs,
     =20
    - 	p =3D reftable_calloc(sizeof(struct file_block_source));
    + 	p =3D reftable_calloc(sizeof(*p));
      	p->size =3D st.st_size;
     -	p->fd =3D fd;
    -+	if (use_mmap) {
    -+		p->data =3D xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
    -+		p->fd =3D fd;
    -+	} else {
    -+		p->data =3D xmalloc(st.st_size);
    -+		if (read_in_full(fd, p->data, st.st_size) !=3D st.st_size) {
    -+			close(fd);
    -+			return -1;
    -+		}
    -+		close(fd);
    -+		p->fd =3D -1;
    -+	}
    ++	p->data =3D xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
    ++	close(fd);
     =20
      	assert(!bs->ops);
      	bs->ops =3D &file_vtable;

base-commit: a54a84b333adbecf7bc4483c0e36ed5878cac17b
--=20
2.43.GIT


--NWk1IY8+iTQoNH54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWfvaoACgkQVbJhu7ck
PpSz7BAAiKE0VqxQrQBZXXM4mkYsjB3mFqglaS6P3oewmplq59zgeI3ZAh4x06Mp
ArNmZIrxcvCrJ04bUSD1HtRLtDugHaFfR6AdrOpRrRaRPR5yyHu62gtwSDezx9yf
Oju/J3gKqeNoXf5El4zf4dqdqY/p7Jw5QWLhVkv8G+skCVStBfXfSZnCLNLEk9Co
/sKhA0K/7KPBnnSFmKQilY9TIEYiY3RmtC26dkMRhpJIEb4KgahwaHVffcaMhPKM
SvaUJRa1V1sqnq8Fv0KjGUfAJYEieDkSXM9Fyau88qAdJNFVq+aqdPvmDOwIzNns
xleQe9+dxG0qGGKmXNTOlsklMZopxCUIuZ2+8NxHLeZDcUezHnEA1Sc6X/CHfpDu
2V/kS5buVogFFIcxUQZ6KWV80SsEZVQuj1npGaw+Khshwme3ApBd77tN9mWA6Ufv
Pc6Zvff7oOJ9fBpuFfz5iGHpUA2rp6YWYV2hZWhmD83eVKixlpvAcY5WSUVKEGk9
0C3pI5fRkee5GjihgRatGsbw+KItPSIltLJcVYZUrnzuhVdkgKRZ4tqKjgkXFuM1
A2R73UZBsazZowDJoPCpc5FnajIC0mto3Lx1fxOSkdFzQD9Z7e997aqx8EWF/Ikz
IJAoAfbNbvB5K6Cx/M4WhgiHp7j/nCNHrxZZ5usjyi9GU2eMwNU=
=+RGx
-----END PGP SIGNATURE-----

--NWk1IY8+iTQoNH54--
