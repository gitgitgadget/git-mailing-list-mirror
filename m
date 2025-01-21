Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ACC139B
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 00:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737417606; cv=none; b=O+fTr70XB4du19By0gUw+5mv3j09/EpwETEuu9ZIDtLMKg8oj+4mY1l39rdVLlAHe+A9I9WJDFI2r4k4pEyjS6f4Z7LTLsOm/vDTLbgFlswISXQQOfsv1MSQGAxXOfWBUS2l9M7t1512nL/+1CQqrKdzfBpftMGqfPqp9EshMvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737417606; c=relaxed/simple;
	bh=di2C3pH2N2i2oGap0QCeSg1WanfUYEL0nxcvZraG/Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmP4EtncvDPRmsgGxH1gmMcxRKCGPGta5NhLSicPT9gRNd/DvDYarrbnmdot2fuHt8FzQiNTa10ZWXXSnwp4yhKhirehetzUv6VlpYiURCJq9KqAY2poz67K+q+l5qUBTPlvUxhoPjtthZVvMbXyKGQ8VwfC2Bmw20/+gGr4mt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=JvQt8OGt; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JvQt8OGt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1737417602;
	bh=di2C3pH2N2i2oGap0QCeSg1WanfUYEL0nxcvZraG/Bs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=JvQt8OGt/vKTndlSTshJ64H9+LQLi0KN94M0WpakPiCbjXBdeF4JhQaeAFMfHTpiq
	 o/p2l7Xrpcd8YNlE6f/Y+UTMV5yEJ14SVkB1YLt5c+muV76PHAaBIg0p0SkzSumh3w
	 1aBRbgZeEqJfjDVhcTgkEN5qIlKtk2xPLQ/WWk1WY7f5/Ba/dvYfEBjbSYz/fmJo8K
	 3br8mTY4ohJR+BgN9FqV0qokvhgV6DzTpLRqr8jN2Iy5GlczGJdKjdAbzVwUnryO6s
	 0tMdU8Mp/6SBOuk9bFS+s/mgS+HMBz91rCE+BdNj78wEkD0zm4wSDErh63RL2TpG/i
	 fq8dPDt57CSHg+kgQI9U6k2+TplHheDBGw2RJVBaIAK0Dkp08Zr/xGtckEXGQFu80n
	 yGfRQ+kC45OxYTfZpkfX2ZNVPyRdvVdwJDsLtomhaVdGrU1PVKLN9MHKnFTjwao/T5
	 kku3NKEv3yQlA/PvVE5DjIvbRfOLUG24MBGOank87efYs4rsc1E
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7E4CA20033;
	Tue, 21 Jan 2025 00:00:02 +0000 (UTC)
Date: Tue, 21 Jan 2025 00:00:00 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, calvinwan@google.com, nasamuffin@google.com,
	emrass@google.com, gitster@pobox.com, mh@glandium.org, ps@pks.im,
	sunshine@sunshineco.com, phillip.wood123@gmail.com,
	allred.sean@gmail.com
Subject: Re: [PATCH v6 4/5] libgit: add higher-level libgit crate
Message-ID: <Z47jgK-oMjFRSslr@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	calvinwan@google.com, nasamuffin@google.com, emrass@google.com,
	gitster@pobox.com, mh@glandium.org, ps@pks.im,
	sunshine@sunshineco.com, phillip.wood123@gmail.com,
	allred.sean@gmail.com
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1736971328.git.steadmon@google.com>
 <65166ea0c077665c350a1a7b00dc3175be889d55.1736971328.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OHO1+71yzy1JxMqb"
Content-Disposition: inline
In-Reply-To: <65166ea0c077665c350a1a7b00dc3175be889d55.1736971328.git.steadmon@google.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--OHO1+71yzy1JxMqb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-15 at 20:05:43, Josh Steadmon wrote:
> From: Calvin Wan <calvinwan@google.com>
> diff --git a/contrib/libgit-rs/Cargo.lock b/contrib/libgit-rs/Cargo.lock
> new file mode 100644
> index 0000000000..a30c7c8d33
> --- /dev/null
> +++ b/contrib/libgit-rs/Cargo.lock
> @@ -0,0 +1,77 @@
> +# This file is automatically @generated by Cargo.
> +# It is not intended for manual editing.
> +version =3D 3
> +
> +[[package]]
> +name =3D "autocfg"
> +version =3D "1.4.0"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "ace50bade8e6234aa140d9a2f552bbee1db4d353f69b8217bc503490fc=
1a9f26"
> +
> +[[package]]
> +name =3D "cc"
> +version =3D "1.1.15"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "57b6a275aa2903740dc87da01c62040406b8812552e97129a63ea8850a=
17c6e6"
> +dependencies =3D [
> + "shlex",
> +]
> +
> +[[package]]
> +name =3D "libc"
> +version =3D "0.2.158"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "d8adc4bb1803a324070e64a98ae98f38934d91957a99cfb3a43dcbc01b=
c56439"
> +
> +[[package]]
> +name =3D "libgit"
> +version =3D "0.1.0"
> +dependencies =3D [
> + "autocfg",
> + "libgit-sys",
> +]
> +
> +[[package]]
> +name =3D "libgit-sys"
> +version =3D "0.1.0"
> +dependencies =3D [
> + "autocfg",
> + "libz-sys",
> + "make-cmd",
> +]
> +
> +[[package]]
> +name =3D "libz-sys"
> +version =3D "1.1.20"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "d2d16453e800a8cf6dd2fc3eb4bc99b786a9b90c663b8559a5b1a041bf=
89e472"
> +dependencies =3D [
> + "cc",
> + "libc",
> + "pkg-config",
> + "vcpkg",
> +]
> +
> +[[package]]
> +name =3D "make-cmd"
> +version =3D "0.1.0"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "a8ca8afbe8af1785e09636acb5a41e08a765f5f0340568716c18a8700b=
a3c0d3"
> +
> +[[package]]
> +name =3D "pkg-config"
> +version =3D "0.3.30"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "d231b230927b5e4ad203db57bbcbee2802f6bce620b1e4a9024a07d94e=
2907ec"
> +
> +[[package]]
> +name =3D "shlex"
> +version =3D "1.3.0"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "0fda2ff0d084019ba4d7c6f371c95d8fd75ce3524c3cb8fb653a3023f6=
323e64"
> +
> +[[package]]
> +name =3D "vcpkg"
> +version =3D "0.2.15"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb8215f372f52e48b=
b32426"

There are two possibilities here.  The first is to check in the
Cargo.lock, in which case all users will have to use these versions.
That produces a more stable and reliable approach, but it has some
downsides.

Say, for instance, that a cool new platform or architecture is added to
libc and we'd like to support it, but that version of libc requires a
newer version of Rust.  We then would have to hold off supporting that
new platform due to compatibility reasons.  But if we omitted the
Cargo.lock, users could install any version that meets their needs.

I believe Rust just got the ability to install only versions that honour
the rust-version directive in 1.84, whereas older versions will try to
use the latest version, even if that fails.  So I think it's okay for
now to use Cargo.lock, because that means that things will be better out
of the box for users on older Rust.  But we may want to drop it once
1.84 is older than our supported version.

> diff --git a/contrib/libgit-rs/src/lib.rs b/contrib/libgit-rs/src/lib.rs
> new file mode 100644
> index 0000000000..27b6fd63f1
> --- /dev/null
> +++ b/contrib/libgit-rs/src/lib.rs
> @@ -0,0 +1,95 @@
> +use std::ffi::{c_void, CStr, CString};
> +use std::path::Path;
> +
> +#[cfg(has_std__ffi__c_char)]
> +use std::ffi::{c_char, c_int};
> +
> +#[cfg(not(has_std__ffi__c_char))]
> +#[allow(non_camel_case_types)]
> +pub type c_char =3D i8;
> +
> +#[cfg(not(has_std__ffi__c_char))]
> +#[allow(non_camel_case_types)]
> +pub type c_int =3D i32;

By making these `pub`, you're exporting them.  We probably do not want
to do that, since they are not part of our API.

If we need them more generally in the code, let's put them in a module
called `ffi` or such that's `pub(crate)`, and then use them from there.

> +use libgit_sys::*;
> +
> +pub struct ConfigSet(*mut libgit_config_set);
> +impl ConfigSet {

I would suggest we place these in a module, such as `config`.  We should
expect to have a lot more things in our crate in the future and putting
a little thought into this now will make it easier for users in the
future.

I'd also, of course, suggest documentation comments, since if we ever
upload this to crates.io, people are overwhelmingly going to read only
the docs and not the source, and right now we've said nothing about how
this works or should work.

> +#[cfg(test)]
> +mod tests {
> +    use super::*;
> +
> +    #[test]
> +    fn load_configs_via_configset() {
> +        let mut cs =3D ConfigSet::new();
> +        cs.add_files(&[
> +            Path::new("testdata/config1"),
> +            Path::new("testdata/config2"),
> +            Path::new("testdata/config3"),
> +        ]);
> +        // ConfigSet retrieves correct value
> +        assert_eq!(cs.get_int("trace2.eventTarget"), Some(1));
> +        // ConfigSet respects last config value set
> +        assert_eq!(cs.get_int("trace2.eventNesting"), Some(3));
> +        // ConfigSet returns None for missing key
> +        assert_eq!(cs.get_string("foo.bar"), None);
> +    }
> +}

I am, of course, delighted to see tests.  This is a nice improvement in
our code that we can take advantage of, and we can test both the C code
and Rust code at the same time.  And if, in the future, we decide that
we'd like to implement a Rust-based version of this API to replace the C
one, we've already written tests.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--OHO1+71yzy1JxMqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ47jgAAKCRB8DEliiIei
gZjWAQDLheItPnGdXQM37LmiEikutnKfqsjquqk+3NPTiIFQoQD/YZLoL3XZdPCY
ertmbXqcFV7mdSH4E7QVEaizvnHnFQY=
=nzeA
-----END PGP SIGNATURE-----

--OHO1+71yzy1JxMqb--
