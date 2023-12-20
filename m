Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B4E1F5FC
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NpqVfQNe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0VHwbGVh"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id D65EF5C01DA
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 04:17:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 20 Dec 2023 04:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703063853; x=1703150253; bh=IJYBXV6OpK
	uF0WD8tK0pUJwLaDBpQsm7Nuqo0O4A5+8=; b=NpqVfQNeUro+wkKK/25h1d3JKs
	O1fOy1I7HUXts1OV2BMzVz4GKGOGSpEesRWMJHM/5y5w8oRoI68Q5jZsn8cBgFZC
	hY/3xYv5VRUPnDf4raVVlhqvvC90mdgf+7e7+vDZJr48Ma3sPW6R4S+lCv6I/NP9
	REAGy3aFiyMvoJ9WiXGsPbBe4H98kFiQgJUANqCxo0tguAQ5D1TsCU2k6VGOvjem
	Q+ITqMfIY0Hz/w0ogkSREBnFpH7vkphlmP+n6yBpQfOjhR+e6y4+QuWink9GAoAi
	tYcRt+6UfMtKTtbBGlZY0NKXkzl7fcTVhz1gk2RpZ9c5Snf3yJ9Rm1MMmbWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703063853; x=1703150253; bh=IJYBXV6OpKuF0WD8tK0pUJwLaDBp
	Qsm7Nuqo0O4A5+8=; b=0VHwbGVhwQyynuA8Xt+tLXxqoNlAKPOw4SGJr1vtS/ZP
	dZjE8xP8lcsZIgPhx+3JY579nxNcz7LKR0tQLiepanbUTBueijLgDT6MMz+asQWw
	oCjusmSz8eOXvt5D/KB7qCW4enXabWSk7yiHlJz0nPle4QbbBJAuGFAw45eYXjyp
	cqSdP0kqwaU2pyC/pHyMu21EJe0ZpKnAWz0Wy+L5Vk8TpZbDpSmjG7xaBm3jAs3V
	5pYL9zUGHW3WU8iRcaFu7q7iuTNUHVGEVgpGS++DGJZzlNum4dJhh7mDxxnLSW2B
	nkqU57xBzZLZq27ly73vTkpSRMak0EcqXwd7WI+Oag==
X-ME-Sender: <xms:LbGCZSGtWQUHBrwr-xy5QlUcXE8WhT8mSXNvHsYaw6xCAAGKEzY1ew>
    <xme:LbGCZTV5HFlCnTL-r7_i6mZs45y9e2WK3Zw-25rKXrztxcaWPH-DqlFQzHBAhu43g
    XzAOyO741yzYegPhw>
X-ME-Received: <xmr:LbGCZcKRQTBtUwfRgA7cbmiUmT0pzHgHW3AlQoOhHNlBZivDeBM1HDjrqyU3EKz9y9rnO6tFX21guy8U9CCIpOphkzch-5boG7S6FVn26EJnLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:LbGCZcHHmlSEA--6pt01NMUqcnV59sJTQb2hz81DoBEuo5CMxKoUGA>
    <xmx:LbGCZYU3jtXWqoK1nyL0owF4bXe1fCmJeRemIfQQAabHHzBBOuroYA>
    <xmx:LbGCZfO98bh0VU6T0rSOfrtyweybRuvqlVl9h10ou8OtHAwDQo1tnA>
    <xmx:LbGCZbC9YAtsPeDcwAlFi0_8REdgXEeqNQEtEBBRJpEsnJ1C_jkZNA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 04:17:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5eec481f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 09:15:37 +0000 (UTC)
Date: Wed, 20 Dec 2023 10:17:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 7/7] reftable/merged: transfer ownership of records when
 iterating
Message-ID: <3dbabea22a2fca6b9eeddde26da664e50ccfddab.1703063544.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SC/vlTIRZ17oNYBD"
Content-Disposition: inline
In-Reply-To: <cover.1703063544.git.ps@pks.im>


--SC/vlTIRZ17oNYBD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When iterating over recods with the merged iterator we put the records
into a priority queue before yielding them to the caller. This means
that we need to allocate the contents of these records before we can
pass them over to the caller.

The handover to the caller is quite inefficient though because we first
deallocate the record passed in by the caller and then copy over the new
record, which requires us to reallocate memory.

Refactor the code to instead transfer ownership of the new record to the
caller. So instead of reallocating all contents, we now release the old
record and then copy contents of the new record into place.

The following benchmark of `git show-ref --quiet` in a repository with
around 350k refs shows a clear improvement. Before:

    HEAP SUMMARY:
        in use at exit: 21,163 bytes in 193 blocks
      total heap usage: 708,058 allocs, 707,865 frees, 36,783,255 bytes all=
ocated

After:

    HEAP SUMMARY:
        in use at exit: 21,163 bytes in 193 blocks
      total heap usage: 357,007 allocs, 356,814 frees, 24,193,602 bytes all=
ocated

This shows that we now have roundabout a single allocation per record
that we're yielding from the iterator. Ideally, we'd also get rid of
this allocation so that the number of allocations doesn't scale with the
number of refs anymore. This would require some larger surgery though
because the memory is owned by the priority queue before transferring it
over to the caller.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index a28bb99aaf..a52914d667 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -124,10 +124,12 @@ static int merged_iter_next_entry(struct merged_iter =
*mi,
 		reftable_record_release(&top.rec);
 	}
=20
-	reftable_record_copy_from(rec, &entry.rec, hash_size(mi->hash_id));
+	reftable_record_release(rec);
+	*rec =3D entry.rec;
=20
 done:
-	reftable_record_release(&entry.rec);
+	if (err)
+		reftable_record_release(&entry.rec);
 	return err;
 }
=20
--=20
2.43.GIT


--SC/vlTIRZ17oNYBD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCsSoACgkQVbJhu7ck
PpQUvw//QPXLqMnM8S9lZa3rRzdNHscfdL38vO/oUB1FfO2062lGXpghRpNTuneE
nM08pR30zH5fuihWQSYgCMdfogOKjU01g5NOQ5i/iWa2nfPlzhjzAr8N26KNK4T6
1NiqFzgEjbctseizmXyiXDd/Q2t19MvWFDlPG9fYMLfTNpv9Piy0AeKSgS8il2cy
IUNZpVvTl5zBJjIieFDWr5azA9EZlt1syp6Ogr3N7pWkSv3p+OblXLSYHoXJmFb6
GDY6WfSTPBiTUr/c5uCDRz9SvKz3Uw3HCS6TJqcoJF2tM7ZBSMPa7Tpy5seIYpux
CpZKgLhY6CZ7n0CGI4mq67pPHhJB/FaOft0QMH0Uo8uCLbID6v53lXgF7Hj67TS3
KPw1up4iixFqMNnrZYfymIW/dXU/og7FUYYLUswD13hl8axoOSgKAZK3awJJA/ep
oTworJwEJIO4cvzDBb3PCyvgcAPbVAA2Yf5lDIn11GNrvxnl5zyfM/j1ANanFlPZ
vQzGKAIWOjJrqG1JEOfTimNx3mfDwf6JSurCPAxTKFnLl4fz2jCHskpd9eYCJCMU
3dEMv412SN7Z2y1svd2rJkwHhLpSusLS99f8HC7Ft55F8WliM5Ln100GvTEQLak3
rfinASm+zb+RM/32rnVakz1Ah40n2Pg8NTFcz+INp/z/R8789pA=
=27b0
-----END PGP SIGNATURE-----

--SC/vlTIRZ17oNYBD--
