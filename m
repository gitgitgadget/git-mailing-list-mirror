Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XyodcoBR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q3H0rT4R"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C7790
	for <git@vger.kernel.org>; Mon, 20 Nov 2023 23:04:33 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 6EB8D5C1662;
	Tue, 21 Nov 2023 02:04:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 21 Nov 2023 02:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1700550273; x=1700636673; bh=KU
	N1u+yN84USZoxraciClmYF5T+bNUyMhMKQZ+Daqh0=; b=XyodcoBRmPMQ5vWhbP
	TDK0EfmJDHyTwcrwi3oSYjHFL8Fo12dHdtZrjuew2zTyjBnZFqOkhK60DqlD4xbQ
	iIk6j1E0Z0oHQae9YrhQddOzQORECHaUym6T4BBn50EQkkP4bFkp19sGNqdD4zXN
	EqupxcX1w1jf0655CuEEC1cX2/9wms9Qif/j08paVk8zKDMPsxI3xNhUaOnyFMdJ
	FsVR1eHg6D4ayFBu4Td8l7oULsuAQ9ct5RJYgJhWkM1urDnDG6Usm1qjhcbYcqlX
	olL+1dBgRp/eDFVryL2nJkOJjOi9aiyfU5IYqyl1eZ/lDhGQtlDAQ+Hg9o+z6uq3
	rmPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700550273; x=1700636673; bh=KUN1u+yN84USZ
	oxraciClmYF5T+bNUyMhMKQZ+Daqh0=; b=q3H0rT4RRnlWX01oi7fxyA6YgqS2w
	Y7R8xfFbCkcl/gzbGnwbmVAbNtviLxqNJMjy+/IY5qjMXIOXIafoBxaFWkH6vVo+
	aFqS+KWu4UsLeYuxFQ3/TQtDpjKOoup44TQpK9Ho7ic4IjUFpMn+HVi88fW34kH3
	TTUw1QNzXjxerKpdMe2LiZwSYWZRHXdjjy4lL6adY3ZbXDr0Dh36JqFJid384EVH
	+DjvJDX39wMuR5f73HU5pBbRP1q8tjtvtpoQHFXsbqeObdD4LOZbGGApl0a4CAB6
	6fK3PIUF1ZdhOOT8p2BUEfYSEPMlGPS0zWrW/NbVeht1fTN3Vj4vtKGDQ==
X-ME-Sender: <xms:gVZcZQyPfvnMsCyYAbyrvcifyHBpwVQoUnuEix8wHdh4mNHLaa02xw>
    <xme:gVZcZUTMbX56gkFCQA-LRkS1R3jufFg4og0Z9sUD63vyPlWI_XEH69ETy2U-2AM5U
    v4n98F85IJaJ8xa8A>
X-ME-Received: <xmr:gVZcZSVpVbg0pHfeSE0Ohz_Z3Zy9j4LSbcpdokVww5xvkAJTyX_xjnkC8JJgOXqQHlBeqsaP-wQwf3kgmeK_wZuDiW5DY_NYQlmOdS6s0r0G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegkedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:gVZcZehu1IFVv16OyGQxyLEc-AM0XZwaVnipMpALqKj4k0h7RMd9rg>
    <xmx:gVZcZSBtO82lhirhxXV1-URDxLzowS26G7CGMtwEAkZc_vnlhzO4Vg>
    <xmx:gVZcZfLSvqCghwGeCVd4bqTagcdi-TqBndUnRDgX3noIKRpN_DvwrA>
    <xmx:gVZcZT5vI-juaVIhZjSozxslK0-N8Sh3z9hk7SboUVAmnDwkZfahOQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Nov 2023 02:04:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9f72fbc2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Nov 2023 07:03:40 +0000 (UTC)
Date: Tue, 21 Nov 2023 08:04:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/8] reftable/stack: reuse buffers when reloading stack
Message-ID: <54e8fd15d8ab3266b1159045b1029b2a38f447a7.1700549493.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y4T1fFH4g2ftBpWD"
Content-Disposition: inline
In-Reply-To: <cover.1700549493.git.ps@pks.im>


--Y4T1fFH4g2ftBpWD
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
allocations we need to do.

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
2.42.0


--Y4T1fFH4g2ftBpWD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVcVn4ACgkQVbJhu7ck
PpTP7g//agi7UjUG+RwaKo9xGPPL8n9UI5kr1g9gCId8BgXONHOF8aHF3PQIwVO3
s9hgzybPxxcTZ1jQypc6fqK4a6QgTeG/hSXhq7OYLbtwGbQEsFmTyGk14m76mt5i
gyBKxFZ8guijGnnz/DF4Onb4C+PP5hD1vA5kjDh8axShSOvc36mE+DsJJADxXWjQ
T8Ts4zvzo+gPv5cSlkTlcFQ1Lto2bY43IppiHuQfhMQ9DZ6WiOXZLt1QOSnE9Es2
BvtAsvvh3/B7VuIoBaBOtqcL0UR83jJJ14I6hOq8LSe4M9eRdCpM1RcbxfMnlu1d
5Jc+DoNr7h3wtJb+1F0upvo08jBd+8ykMBNyA3tAM10c+2ix4BDbJGqaN98zU7e/
jEHMpKb2Q0ZblpY4HvLoBFeeIWkHbN0wJFTXDJ9JrqkqqA3jU3qOKA6cqIfTPr2J
gc4fsmpxz42ClQ5m3VaHjiA767TptkxBwCfFJewNX4syu468oDPsgLK1y1lK6r8T
MfD2CkrmeiUZ9ajHC4dFn8AGGUgS6zfBtrkDi88jO+WXP0VabbCnqQkRyJ4YQaUs
FvN9qanoRynj+cnSpXBpyoZZ0fdIe/5whK0G5joRIHU8pDZTYqxt4asnMRiSRP+k
iLYf5nRHYbiiYsgE/rxtIK2OPhXeIMisYmTajhiAN87Azxovi1A=
=xf08
-----END PGP SIGNATURE-----

--Y4T1fFH4g2ftBpWD--
