Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E261448E3
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 00:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759883383; cv=none; b=iSE1u1JCunl76C//+wg/WI8hdObdICAg4proxF6mZxUsVfUdQe5mmrVVtcr9OfrobPQhrLty0qb0IFDOSBjX/DmA8buMmIqWBe+VDTxmxKIIUJ1TuGvgkaSP8SFVTEHoGQEYfn05uJEy2fb3UN3u8atHphJ1wT8uwHlscTW/TDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759883383; c=relaxed/simple;
	bh=hE2TYTZyx7LdtUMybhX1o0gOQuvoy6TvwS6k29lg1vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H93Dd2G0Juko47Qq90oSfBTe+m102BKrd7QYRIUGpSSF7yXdav7lZNaEbxPvkozjxOb1gphsNb6IwrNhL8qjtvMxm7AwTfwdXF6ZFcVu0vB1SIF0C7y7cfwYmbxl82E1Zvzr+BIPX9KZJTQTuczp8rYTZmpHZNfL8HE3U6xrCFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ZQ5bhPIY; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ZQ5bhPIY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759883379;
	bh=hE2TYTZyx7LdtUMybhX1o0gOQuvoy6TvwS6k29lg1vg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ZQ5bhPIY8O82Zul7GfawLBGj2l31aguDinxZ8OOHWzCnnferyRtv1EnznRZtnLwXE
	 t9yEfrDBSazNwz2r5FNqDjpYxmXEm484KMjVrIPIZjxZg/bE7z64Q0KGsFrRZ6EB+4
	 9LrPEJZ8buQiDU0tqXufs1fUdNoY2gf9CX2VxzsAR2bBCpN0ffsZswMFzi6WVADLAM
	 ly7ujs2iQNhNjI2f6F0+MVedt9dEuOTyEVK2HOTYk2OwLUOLvAUeMMFYXHMLxlPsBW
	 QSqBKFs4DecPrt8j7MipecvH5vUeiT5PcTuH8cmtZgl0e6k1WWEFunp5RWuP4nyiJ3
	 55xC5vSveoKD2mr+P1PVdAqsuEy+R91OeKE8lP1rhjnL6gzxsJEmeFnvRvnjpk7w53
	 pjkKG5TYb53hGOT5E3dNT4R3Zg5Cl8VsywX5NXSLdxN54hwUTqkxbCFzNeUEnmTBFi
	 4y7y8rt0fQM6yxy3IUPjHiOM0L0x6r//oaOAd+/uJNMOxJadU+r
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:225c:7da:a6d4:350c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CA82E200C6;
	Wed,  8 Oct 2025 00:29:39 +0000 (UTC)
Date: Wed, 8 Oct 2025 00:29:38 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/6] rust/varint: add safety comments
Message-ID: <aOWwcqyithDKQzVs@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
 <20251007-b4-pks-ci-rust-v1-3-394502abe7ea@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PJZcMQ9B2phClY+c"
Content-Disposition: inline
In-Reply-To: <20251007-b4-pks-ci-rust-v1-3-394502abe7ea@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--PJZcMQ9B2phClY+c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-07 at 12:36:31, Patrick Steinhardt wrote:
> +/// # Safety
> +///
> +/// The provided buffer must be large enough to store the encoded varint=
=2E Callers may either provide
> +/// a `[u8; 16]` here, which is guaranteed to satisfy all encodable numb=
ers. Or they can call this
> +/// function with a `NULL` pointer first to figure out array size.
>  #[no_mangle]
>  pub unsafe extern "C" fn encode_varint(value: u64, buf: *mut u8) -> u8 {
>      let mut varint: [u8; 16] =3D [0; 16];

I'm planning to do something a little different with this code by
refactoring it out into a Rust function, so at that point it will no
longer be possible to provide a buffer smaller than 16 bytes.  Note that
all callers of this function pass a 16-byte buffer, so that should be
safe.

That doesn't mean that you can't send this patch (and I think your patch
is good), just that we shouldn't tell people we can use a buffer smaller
than 16 bytes, since that will at some point no longer be true.

Here's the current version of the patch I'm planning on sending for
reference.  I can rebase onto your series once Junio picks it up.

-- >% --
=46rom 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
=46rom: "brian m. carlson" <sandals@crustytoothpaste.net>
Date: Wed, 8 Oct 2025 00:27:56 +0000
Subject: [PATCH] varint: write a safe Rust version of encode_varint

Our original version of encode_varint in Rust used pointers much like
the C version did.  However, if we end up using this function elsewhere
in Rust, it would be better to have a safe version that we can use.

In addition, writing our unsafe C-compatible version in terms of a safe
Rust version makes it obvious what our requirements are.  For instance,
we do not need buf to actually point anywhere and can accept a null
pointer if we just want the length, and we can clearly indicate that we
require 16 bytes worth of memory to encode data by creating an
appropriate slice.  All of our existing callers always pass a 16-byte
buffer, so we can safely assume that.

We can then improve our Rust version by performing normal bounds
checking to make sure that we don't exceed the buffer size and use the
standard usize return for lengths, converting as necessary in the
C-compatible caller.

Move the C-compatible code to a mod c to keep things tidy and allow us
to have a different Rust version.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 src/varint.rs | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/src/varint.rs b/src/varint.rs
index 6e610bdd8e..83990afe7a 100644
--- a/src/varint.rs
+++ b/src/varint.rs
@@ -22,8 +22,7 @@ pub unsafe extern "C" fn decode_varint(bufp: *mut *const =
u8) -> u64 {
     val
 }
=20
-#[no_mangle]
-pub unsafe extern "C" fn encode_varint(value: u64, buf: *mut u8) -> u8 {
+pub fn encode_varint(value: u64, buf: Option<&mut [u8]>) -> usize {
     let mut varint: [u8; 16] =3D [0; 16];
     let mut pos =3D varint.len() - 1;
=20
@@ -37,16 +36,19 @@ pub unsafe extern "C" fn encode_varint(value: u64, buf:=
 *mut u8) -> u8 {
         value >>=3D 7;
     }
=20
-    if !buf.is_null() {
-        std::ptr::copy_nonoverlapping(varint.as_ptr().add(pos), buf, varin=
t.len() - pos);
+    let len =3D varint.len() - pos;
+
+    if let Some(buf) =3D buf {
+        buf[0..len].copy_from_slice(&varint[pos..pos + len]);
     }
=20
-    (varint.len() - pos) as u8
+    len
 }
=20
 #[cfg(test)]
 mod tests {
-    use super::*;
+    use super::c::encode_varint;
+    use super::decode_varint;
=20
     #[test]
     fn test_decode_varint() {
@@ -90,3 +92,23 @@ mod tests {
         }
     }
 }
+
+mod c {
+    /// Encode `value` into `buf` as a variable-length integer unless `buf=
` is null.
+    ///
+    /// Returns the number of bytes written, or, if `buf` is null, the num=
ber of bytes that would be
+    /// used to encode the integer.
+    ///
+    /// # Safety
+    ///
+    /// `buf` must either be null or point to at least 16 bytes of memory.
+    #[no_mangle]
+    pub unsafe extern "C" fn encode_varint(value: u64, buf: *mut u8) -> u8=
 {
+        let buffer =3D if buf.is_null() {
+            None
+        } else {
+            Some(std::slice::from_raw_parts_mut(buf, 16))
+        };
+        super::encode_varint(value, buffer) as u8
+    }
+}
-- >% --
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--PJZcMQ9B2phClY+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaOWwcgAKCRB8DEliiIei
gdhxAQC/iuspD3YQqAaDYzT+7ZRMqdMAxZLc+svP2fZUlkuy/gEA8qVg1um8A7vu
RsE5wW5gYBAJwbOXMaMbdtTxoGQJjQo=
=GOwM
-----END PGP SIGNATURE-----

--PJZcMQ9B2phClY+c--
