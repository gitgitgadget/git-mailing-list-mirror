Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mQcKxdgu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t7rqlk3w"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A6AD9
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 01:07:54 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id CF71A32026AA;
	Mon, 11 Dec 2023 04:07:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 11 Dec 2023 04:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702285673; x=1702372073; bh=8v
	yfzJHgUfHLqxCEXW1N2lgEv94uuppecYrPzjqQO9g=; b=mQcKxdgunVBVUaUpvS
	96ZqpeADwXbJsslxyNOIsk2QYshV7gHMxVmuwIlyTuDjUt88TCTtT/C36F85qxtB
	6ZApNCVXipyB/yl6Xv21mpzNJFSo0cONG0NXL+AW3jfRNlqpmgJtkiM8+aRFnyZD
	RQMv1WdkARnln2X1YjcQ91qGFCsTpLuexxoYAT8kNNVEUgrWaU4vD6E7cXgWj+aU
	dZbHXsLXHB27fScOgR3aRVhZ1nZNEExoMY7vMV7uyctfKAhHI47Q5mmGxP91X/eY
	b6UGG1/w+V1WSFQ4Jmbe3NpKZxa5sou9AgiT/U7LPif/LU48nf+ATdN32mtomMNv
	loXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702285673; x=1702372073; bh=8vyfzJHgUfHLq
	xCEXW1N2lgEv94uuppecYrPzjqQO9g=; b=t7rqlk3wVTC3Y/kgXnCguqTeUs08H
	Azl0AYk+KkwbJUQ4Sr2H8s/JJDyjmOr5bisCGBUh9ys1BfEOA25ePSDboz5EiY5A
	sSD0gSqICSD2DUeG8TEPmnC80g7eyuivvLPzfAFetTgNd9U3K383FPlEbaVVG/F/
	gDt+TXTgQxrldyclBSmzWcUeY2qE4eHv70z2kiwJo2zF1qXiKTF9BhnYOPoUt7dY
	8mzuL4XwYAFPz+UBq+7pMUHhsGwcks4rYMVliR+ngmFdhMy0PhUVVKMz255vFXZ1
	64C24Xx6F7A43xlnIhiJ2EDProlnHM/rmSTYAaOy2tqekTf3aDeeEjO9A==
X-ME-Sender: <xms:adF2ZbDybeJgGlFUYxsyJz07SQNexeLBOWOyuXjm9uayBHYdAtdLCw>
    <xme:adF2ZRiRENP9vB9_YX5ahoAd7gvDj8FjxEV1VlRbkWxEpReIaiPVr4xeV8nOMAG7E
    9SNKwW2Ap3UJpYQXQ>
X-ME-Received: <xmr:adF2ZWmv6UnAZNoTZfU92sjCjcE6dPrgr-wSf5Q1hSiJQE39y-E0XsQbMUFV7D_yLcm_y9Dy3hqvB6uHrEfYrcmnsnb3xrgCy4R6GAnqwEreBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:adF2Zdxxx3Nvr7TCuuE1CRCObmPVtRQz_30jDx2L8VnDM-C6WUkorQ>
    <xmx:adF2ZQTnSneWJXWWNEGVSnlwkMhUHoIhdO7S5oZvRsA0eoT9BFCgKA>
    <xmx:adF2ZQaRCAfXx6f1AmgGmPE9veh6M3ExXNCjWQ1QlKpevtNx5BL7bw>
    <xmx:adF2ZWfRs88wWsuAa7ooho9QfEComhksgYm-qnYvjlONpgHhrqx-Yg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 04:07:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c84654e5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 09:06:16 +0000 (UTC)
Date: Mon, 11 Dec 2023 10:07:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 06/11] reftable/stack: reuse buffers when reloading stack
Message-ID: <6ed9ba60db081a5210d325dabcbf232771754277.1702285387.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702285387.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6aaF9j9GBOzc/uDO"
Content-Disposition: inline
In-Reply-To: <cover.1702285387.git.ps@pks.im>


--6aaF9j9GBOzc/uDO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `reftable_stack_reload_once()` we iterate over all the tables added
to the stack in order to figure out whether any of the tables needs to
be reloaded. We use a set of buffers in this context to compute the
paths of these tables, but discard those buffers on every iteration.
This is quite wasteful given that we do not need to transfer ownership
of the allocated buffer outside of the loop.

Refactor the code to instead reuse the buffers to reduce the number of
allocations we need to do. Note that we do not have to manually reset
the buffer because `stack_filename()` does this for us already.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index f5d18a842a..2dd2373360 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -204,6 +204,7 @@ static int reftable_stack_reload_once(struct reftable_s=
tack *st, char **names,
 		reftable_calloc(sizeof(struct reftable_table) * names_len);
 	int new_readers_len =3D 0;
 	struct reftable_merged_table *new_merged =3D NULL;
+	struct strbuf table_path =3D STRBUF_INIT;
 	int i;
=20
 	while (*names) {
@@ -223,13 +224,10 @@ static int reftable_stack_reload_once(struct reftable=
_stack *st, char **names,
=20
 		if (!rd) {
 			struct reftable_block_source src =3D { NULL };
-			struct strbuf table_path =3D STRBUF_INIT;
 			stack_filename(&table_path, st, name);
=20
 			err =3D reftable_block_source_from_file(&src,
 							      table_path.buf);
-			strbuf_release(&table_path);
-
 			if (err < 0)
 				goto done;
=20
@@ -267,16 +265,13 @@ static int reftable_stack_reload_once(struct reftable=
_stack *st, char **names,
 	for (i =3D 0; i < cur_len; i++) {
 		if (cur[i]) {
 			const char *name =3D reader_name(cur[i]);
-			struct strbuf filename =3D STRBUF_INIT;
-			stack_filename(&filename, st, name);
+			stack_filename(&table_path, st, name);
=20
 			reader_close(cur[i]);
 			reftable_reader_free(cur[i]);
=20
 			/* On Windows, can only unlink after closing. */
-			unlink(filename.buf);
-
-			strbuf_release(&filename);
+			unlink(table_path.buf);
 		}
 	}
=20
@@ -288,6 +283,7 @@ static int reftable_stack_reload_once(struct reftable_s=
tack *st, char **names,
 	reftable_free(new_readers);
 	reftable_free(new_tables);
 	reftable_free(cur);
+	strbuf_release(&table_path);
 	return err;
 }
=20
--=20
2.43.0


--6aaF9j9GBOzc/uDO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV20WUACgkQVbJhu7ck
PpT7RRAAnqBhytdaHIlk0HtxW2HBSyZtD8AuasUmfL2LD7WoWz2IDv4JL08DJs1Z
Rn/3WDUS/58eyVZvaa4w2N/GRraaNJPFuuHgr5FAgQjL/T8v7LrrBqVSIW/iLvJk
iYBP/BKFonLBVcj0cAcqECj6Q4yNrDWQluMiWRLt/Eay5Bg4y2yk87H4NK7gcpq/
pEv/OQ67ibEEPy3CLPOZ9Jmdro88/ZK1QA7DAbd1bMH2NUg0Cp58GhtwWnRzj00e
4m5/RKyu9rZMTFzFWtD9zIrv4TvraFNul3EClYkXiOkxe9Fho4Y01hGvTEBUybZ9
OEmGPYNgW13NKyaLINukPYhPXbP/L2AoFxweumf8BNebfkIJ8oEXFb6wXE5rxfKN
sGVWYicwapdi9RIYF+gYWsKnNMO15hpoe5OHwUUv1cTU46cujhDrroeohH2E0ahH
Ts+nBqDpQVaiWK7gZLV7HjeYQ3Q1Tou0q/b6VMECbHgH+oLZ+zUUkErbmcZRvEEf
Yp2laj4U8wzy6dzeDKY7xuAoTcsUsCp685Oh5X9Bn+L+eH1pFLKfGIx3WEfVQIG9
pJ5Yn2lEU8Rtrp4PZ+beNlxqQHNfUozbP1Mn7eAy+Lz4FaeMIp0yGYCw2kxvhpkZ
bPEwiLmqhGTIMJg6Edkr8En4rF3ny9UQN6+4uLsqwZzkt+TMAXg=
=bCYw
-----END PGP SIGNATURE-----

--6aaF9j9GBOzc/uDO--
