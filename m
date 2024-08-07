Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDD04D5BD
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 21:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066013; cv=none; b=QjlaF6Con/wpIidfPkhMeUcFsJge0i5o8z+rYCKceUDqeJjHEhVe02C9/2WDVWH9HfPULnXrcMH9Dlcj+cI6mqhMsacqJkEH8J4fQ5eWCx0cXhvM3aCr3hmEbaykFGQIVUxbx5bfls++/bGxcMvHAdjwigIsVffH5HMf30+Rszg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066013; c=relaxed/simple;
	bh=5ghvIc0O06yD2nezFpyjK60q1m5ZKEHGKrrcQHzLSTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBtWFgRn7lCcupJkZlPy8qANdp6V16c1rWf6RH13Uw070Bys5LOA5ERqyvruXWmYJPuhQCrYUmfxblvnxMlZ78gsLmXspkP/YnJpN9mA+YGk2p6AL89DQPwi1zx4NOirce50qcRkaZY3uU3Fcw11RMPifbA/tY9HkwQnakUi8jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=wbn7nI39; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wbn7nI39"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1723066010;
	bh=5ghvIc0O06yD2nezFpyjK60q1m5ZKEHGKrrcQHzLSTo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=wbn7nI395xswlvfS3fNIwxXP3Y4D9e1cfmN4yJklPkVRkQAfjv2Je4Hw+apyOsBMW
	 KkCo9iuOLfdE1bNrDH94u47ijyK+UpjVVaDpLPp44s/PkLnrf/z+CwuyG1p4j7A8eB
	 jQUGsYzglQJeH6D68FOeRXB7eLC+dtmpgNiNuRid/Xi1qVF33qmQ5AErQjhVR5TScA
	 ibddLItwAh5TOPY0iDWMNUiaN514owRuPfyl+UdE4POLhDdtJEkCXOsuOWix0uoAKS
	 DlH+BXsdQtxVpJspppmvZbk9FIko2hJEufWqxzQyZ6En9B5931zpEPHDujuEUalgfQ
	 OZzcA3KKKKv/HkFoJvbFv77BY2t1GQMX/VBmFFjL9ziXdAzZFQA6LCenccLUvWedVL
	 9UBLMuEkUhqenX2+0O2sIAk25Ql/pRkrRxwGBKVndTaUcDFVusxD7dSSTF32xfG3Ed
	 JWE62sJYlUe/Dlc8U/go6rwJi/GuVkGTlWy7fBzcC9gFnAhYm1I
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4EE82209BD;
	Wed,  7 Aug 2024 21:26:50 +0000 (UTC)
Date: Wed, 7 Aug 2024 21:26:48 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com,
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 4/6] contrib/cgit-rs: add repo initialization and
 config access
Message-ID: <ZrPmmBqK3IIiQutV@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
	emrass@google.com, rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
 <b84a8210a05c2358dc29f24a56adcbeaa90c8654.1723054623.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C7oh1gedUlfYEaVV"
Content-Disposition: inline
In-Reply-To: <b84a8210a05c2358dc29f24a56adcbeaa90c8654.1723054623.git.steadmon@google.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--C7oh1gedUlfYEaVV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-07 at 18:21:29, Josh Steadmon wrote:
> diff --git a/contrib/cgit-rs/src/lib.rs b/contrib/cgit-rs/src/lib.rs
> index dc46e7ff42..df350e758f 100644
> --- a/contrib/cgit-rs/src/lib.rs
> +++ b/contrib/cgit-rs/src/lib.rs
> @@ -1,6 +1,17 @@
> -use libc::c_char;
> +use libc::{c_char, c_int};
> =20
>  extern "C" {
> +    pub fn libgit_setup_git_directory() -> *const c_char;
> +
> +    // From config.c
> +    pub fn libgit_config_get_int(key: *const c_char, dest: *mut c_int) -=
>c_int;
> +
> +    // From repository.c
> +    pub fn libgit_initialize_the_repository();
> +
> +    // From parse.c
> +    pub fn libgit_parse_maybe_bool(val: *const c_char) -> c_int;
> +
>      // From version.c
>      pub fn libgit_user_agent() -> *const c_char;
>      pub fn libgit_user_agent_sanitized() -> *const c_char;

I think it would be helpful if we didn't expose the raw C API in Rust.
Nobody is going to want to write code that uses that in Rust.

If we _do_ expose that, it should be in a separate cgit-sys crate, which
is the customary naming, that exposes only that and then we can offer
nicer wrappers around it.

> diff --git a/contrib/cgit-rs/src/main.rs b/contrib/cgit-rs/src/main.rs
> index 1794e3f43e..c5f8644fca 100644
> --- a/contrib/cgit-rs/src/main.rs
> +++ b/contrib/cgit-rs/src/main.rs
> @@ -1,4 +1,4 @@
> -use std::ffi::CStr;
> +use std::ffi::{CStr, CString};
> =20
>  fn main() {
>      println!("Let's print some strings provided by Git");
> @@ -7,4 +7,25 @@ fn main() {
>      println!("git_user_agent() =3D {:?}", c_str);
>      println!("git_user_agent_sanitized() =3D {:?}",
>          unsafe { CStr::from_ptr(cgit::libgit_user_agent_sanitized()) });
> +
> +    println!("\nNow try passing args");
> +    let test_arg =3D CString::new("test_arg").unwrap();
> +    println!("git_parse_maybe_bool(...) =3D {:?}",
> +        unsafe { cgit::libgit_parse_maybe_bool(test_arg.as_ptr()) });
> +
> +    println!("\nCan we get an int out of our config??");
> +    unsafe {
> +        cgit::libgit_initialize_the_repository();
> +        cgit::libgit_setup_git_directory();
> +        let mut val: libc::c_int =3D 0;
> +        let key =3D CString::new("trace2.eventNesting").unwrap();
> +        cgit::libgit_config_get_int(
> +            key.as_ptr(),
> +            &mut val as *mut i32
> +        );
> +        println!(
> +            "git_config_get_int(\"trace2.eventNesting\") -> {:?}",
> +            val
> +        );
> +    };
>  }

It seems like this code wants to be a set of tests and maybe it would
be helpful to write it as a few instead.  For example, we can assume
that our user-agent starts with `git/` assuming it hasn't been
overridden, so maybe we could write that as a test, or at least that we
got a valid C string.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--C7oh1gedUlfYEaVV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZrPmmAAKCRB8DEliiIei
gY3yAQCxtuclLN13aTX09wQovLMPm9U4jTmiZuht2iXr8ub6rwEA0qrs1cakRWFE
Nt1OFEEPCGoVa4egAtLVsYWbbgd+lQo=
=B/JA
-----END PGP SIGNATURE-----

--C7oh1gedUlfYEaVV--
