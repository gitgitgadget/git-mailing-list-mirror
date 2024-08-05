Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1AE159583
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863301; cv=none; b=DpGmIiVtMp55dv2zT368Fm4NT3kHBHfCPpggTGfuMF3FDwVKa/uM8uK1aB+XuOyXFAxwGdpPMXGA7p7khsWhtwtpfbVtmDpDo1eCGIU9iyd6lal3kFzh8tgeuWmPycBUxVbEHlLBG9Qb2hQ5OjODdIqRSGfG8/VaRqaQ0aIXMek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863301; c=relaxed/simple;
	bh=KeLqwWHj4pG4067Ud5Q4dyFuzcqpWvYVS0ni1Ys0lR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lu00tR1f+iCnUT0AdvJgPivR8SN+5fwPguGODBqJroej3YS7zIgoKA/ce/tSY0B25lnU7yXHQ17niZKGuKVYYz3n03AWx8cjK9/N/qNIFax060jmw2MZikHvMVBy1n5Zg4GYPzuyg3f2wwLrhhwxnjlw8uALpIeHvOcN+R/ks1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mGe8pEj5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UIMwI9JC; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mGe8pEj5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UIMwI9JC"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 257F11151B75;
	Mon,  5 Aug 2024 09:08:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 05 Aug 2024 09:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722863299; x=1722949699; bh=YMcltKA7JO
	5S703QCXbBcvKA9XODbzGQ5E9NzaK2Zlc=; b=mGe8pEj5ZiuqkTvP6InCWt4ESH
	Tw9OMia/hmYj6OMy05msqVyNq+P7TntXYZHkt575PpVo9DkKit8wOLrSd27UcReG
	6EKgOuI04CCzarwRHNCILKa5XDliBHSxJ6GBNk/RIAM7QP1ezrJouDNiCjAE0YaI
	Hep2oP/S0CNC73sziIjPqWL2+x1ge7vvShkIg+Blk4Wt4a9+poV5Z1Wb7Pq1Q5PW
	KlCKEDYkrFnvfB8CoLPf1Du1McYzL8bsV/GyosqQfq4fRtKDXZLQeEwZYBNs3ids
	GManPkDp17kkbdwfDDiFX/+t0Uo4vzxAb48oC3eIydKq3foQgn6kvUlK6sJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722863299; x=1722949699; bh=YMcltKA7JO5S703QCXbBcvKA9XOD
	bzGQ5E9NzaK2Zlc=; b=UIMwI9JCyTqEsCbio1YbyVTmQudRbLlIcyXr5VqvmT4F
	Pxv65CM2PX+mx/VfC24EFYDktQetqT6tuTgnL8j+6jvgCOh49K5lSHH3ycQFeRu0
	pQWcP+l9lBDa+k5ej9fjSYALW4CB4kcvhtU/x8mAG9cjmPokYoJaZOgyR/RuOukl
	HJ+HycqTxST175iRfRcew+0Uw2p4bGY63nhceVT8hgFtk0bm75n0a2JBxVZiIqws
	2h6Qa9HoAX1PDCKbKAqF5jRy7sqelhiNcjBjtr5a2cRp1Pr4l91wVP374zyJkwo2
	leGJAIZByqwTMOXffdpEgsrl83A85u5CzKaz+8UCZg==
X-ME-Sender: <xms:w86wZoXUpELQTGhJHToLn94bgKjVX88wqT3w8fkmded9vMhNcgC27g>
    <xme:w86wZskWsP9baNz2QGv5PS7HgPCjHq0eDE653pAFPKya0BwahDPjg7iYv2lEHvFlS
    lyXFVaMOtJAjVi-Hw>
X-ME-Received: <xmr:w86wZsahHlm0BXpVtJe7DDYMeKONatQ4YIycfTNPGHNAfaXTbbjWf67hedSvc9GbUyisyQ5N3T7s0-43DrZP-qb-3vQt17bEwJYjFyyhwk5wIoITnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:w86wZnUxzpJfMGEtlQSd0Cf9jtXGs0C6LNPbfBAxhmng8jILSztdRA>
    <xmx:w86wZinxWQyDEch8tvxt9QHSqQl71i8MUMuNDZmcteaNSxTadgkckQ>
    <xmx:w86wZscgqXE5EZ9znHHLkajiOsbN_Km44CuQOQ5AEpHqZSA84TBR6w>
    <xmx:w86wZkFQh5RtqV4eDQNCkVWG1C3VTpu6jFepPjLUBUIeZ1by5cwe8w>
    <xmx:w86wZkg4lO0PRc0vjbcKKbR9CSU_aOmVhMBZke1xrd2SaiIOvd9qdc8Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 09:08:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b8b8d3ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 13:08:17 +0000 (UTC)
Date: Mon, 5 Aug 2024 15:08:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/9] reftable/stack: use lock_file when adding table to
 "tables.list"
Message-ID: <b868a518d67eb1566f102a94cf2c0fd45fa2668b.1722862822.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1722862822.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fplP4mptVGJV65PH"
Content-Disposition: inline
In-Reply-To: <cover.1722862822.git.ps@pks.im>


--fplP4mptVGJV65PH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When modifying "tables.list", we need to lock the list before updating
it to ensure that no concurrent writers modify the list at the same
point in time. While we do this via the `lock_file` subsystem when
compacting the stack, we manually handle the lock when adding a new
table to it. While not wrong, it is at least inconsistent.

Refactor the code to consistently lock "tables.list" via the `lock_file`
subsytem.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 9ca549294f..54982e0f7d 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -567,7 +567,7 @@ static void format_name(struct strbuf *dest, uint64_t m=
in, uint64_t max)
 }
=20
 struct reftable_addition {
-	struct tempfile *lock_file;
+	struct lock_file tables_list_lock;
 	struct reftable_stack *stack;
=20
 	char **new_tables;
@@ -581,13 +581,13 @@ static int reftable_stack_init_addition(struct reftab=
le_addition *add,
 					struct reftable_stack *st)
 {
 	struct strbuf lock_file_name =3D STRBUF_INIT;
-	int err =3D 0;
-	add->stack =3D st;
+	int err;
=20
-	strbuf_addf(&lock_file_name, "%s.lock", st->list_file);
+	add->stack =3D st;
=20
-	add->lock_file =3D create_tempfile(lock_file_name.buf);
-	if (!add->lock_file) {
+	err =3D hold_lock_file_for_update(&add->tables_list_lock, st->list_file,
+					LOCK_NO_DEREF);
+	if (err < 0) {
 		if (errno =3D=3D EEXIST) {
 			err =3D REFTABLE_LOCK_ERROR;
 		} else {
@@ -596,7 +596,8 @@ static int reftable_stack_init_addition(struct reftable=
_addition *add,
 		goto done;
 	}
 	if (st->opts.default_permissions) {
-		if (chmod(add->lock_file->filename.buf, st->opts.default_permissions) < =
0) {
+		if (chmod(get_lock_file_path(&add->tables_list_lock),
+			  st->opts.default_permissions) < 0) {
 			err =3D REFTABLE_IO_ERROR;
 			goto done;
 		}
@@ -635,7 +636,7 @@ static void reftable_addition_close(struct reftable_add=
ition *add)
 	add->new_tables_len =3D 0;
 	add->new_tables_cap =3D 0;
=20
-	delete_tempfile(&add->lock_file);
+	rollback_lock_file(&add->tables_list_lock);
 	strbuf_release(&nm);
 }
=20
@@ -651,7 +652,7 @@ void reftable_addition_destroy(struct reftable_addition=
 *add)
 int reftable_addition_commit(struct reftable_addition *add)
 {
 	struct strbuf table_list =3D STRBUF_INIT;
-	int lock_file_fd =3D get_tempfile_fd(add->lock_file);
+	int lock_file_fd =3D get_lock_file_fd(&add->tables_list_lock);
 	int err =3D 0;
 	size_t i;
=20
@@ -680,7 +681,7 @@ int reftable_addition_commit(struct reftable_addition *=
add)
 		goto done;
 	}
=20
-	err =3D rename_tempfile(&add->lock_file, add->stack->list_file);
+	err =3D commit_lock_file(&add->tables_list_lock);
 	if (err < 0) {
 		err =3D REFTABLE_IO_ERROR;
 		goto done;
--=20
2.46.0.dirty


--fplP4mptVGJV65PH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawzr4ACgkQVbJhu7ck
PpQjdw/7B6jkzesLrSGUwfRF4ZOhC4gSw7yknt5++o6S3xZoISJLV09lxXdNmwKm
QkvSKISGlXf8mO1GkHERlbkoLvpxrBSHMekchNL7kaPP9KNY3ItgLa2IYHWcJjzP
q0UjQz7o01jb/9UHJHR8SEjAv4YVa8WUZ9ZYK+TjYmAo7QBRZa3ksOPIZFmt6k2J
M/foO1VY7K1zTx0raXKUMe9dyIUL1BigIdKsZkd5mk8kgOd+q50sQI2aethcjaWi
DQV6pjVD7Q57MfjUyzoJiBC/JLKLVTCYHNBGPVUSSU6zn9BzKrK091Jqp+/UOjlt
rwm2oPqtkyKjOlwyChN3KXPni0pdtEI3LqTuP8sNB6H7VWXY0wWteyDddSaBVTA9
6xL9/DjSYPPBkCcmp4KphsyNfyiIodlVa3uNzVSHdephwAx5Q0f3+v35tkNS/UTc
P/EkrVzq1gU0xW2wI+gxdXhxpRrzccOH35vRQiaOdc1edmWFXLCmsTwismLwj13/
0YbfSxFe+319iHrbPQCL4t2S0kS7E8W1B0rh9WExi2vg2Db7yQmnSBQ3wwCO09S1
iqUgSKz6wlygHkjnYX3a15kqzc3bl4f8vBHhHGzdbuVJazSCgR7HX6IprI4TJSj1
PXEbNWFqgNHnWrw17UDz1iTW5X1H+hp3T7r92PtzC0t7rkd6LGw=
=sBJN
-----END PGP SIGNATURE-----

--fplP4mptVGJV65PH--
