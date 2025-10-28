Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9044329C7E
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674776; cv=none; b=CntPN1QYYpv4ib3Y+ETcj+cbAkBkpsBiq9Q4ss+1RlhYxeFT21c31vS7HOXPD1HUAkROfAO1VEl9hX7uFyzH9d2jdySJls0z7Tlq/smU3mLkEOB5qpqBll6XEY857TBkg0ldtKYD06dbLwUvBoXyritmhzek0g5MVdhyJDVGx8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674776; c=relaxed/simple;
	bh=+oRcFHos765mOoJlA4Qh7c25217E/nBn6KPO38g4JMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MB0Sj8yjuJTBmvekpjm7hwRDfJYazncDvAopLBWvLxsKVcRdidx+z+zDeD6j485kHy2OHZb5oPSTQwQMVY5Tu6H1D0u6I3Z7xmlkYO7HrATucCCi44w8ZmuIwgdO3eKrvb8myvQ8WMvfe/1dm41fJ9X5UiY5B0F/nCOw9RbGXYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBFleRiR; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBFleRiR"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-378d6fa5aebso69176651fa.2
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 11:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761674771; x=1762279571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qXlei36deFJn5RVM3ODK0UfrzomQm9EBUdrdS6Dlh4=;
        b=SBFleRiRecDPRHFJo/7FrilJdRH87/xC2Ts4Ot5Bg66Mv2N559PLmNjSe2CARhhm76
         rlIM8WS/BG4h3DRs2oeiWHScUkW5hCK/biTNbyUF9anUmPzK1UuE+WBI8thde7ibbEqJ
         jfLL1UpTqQ8Ns46HBqjCJ26ztvRcpfQlfsAK5o8D8+6vSbpPmRX42gDh4E4STZZ5XNa2
         n9u4BpqI2XhR0F5zbPlTtVPMSh4LTwgjrZMiF+jjILSDWHGhSsGCZwe/KMtv0PSnNXTv
         kekopuqP2hDN1hqYDTOg/+Aa5nNstupJD3hZA7YKR67/i9ZOQDQjsPjtjcQHCZ+nx9MO
         NR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761674771; x=1762279571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qXlei36deFJn5RVM3ODK0UfrzomQm9EBUdrdS6Dlh4=;
        b=A+AjAO6hhQ3zhbEgDxPmOas1HRGH29H3hDIGtiaZ8+HVdmhiCHai4w5isdAqU6kljv
         FOvvePr+jk5ooS/FsniHv296PdR/vdo1z1hvio1R3x9BYfDAcOztM3d4Uw/ZDalLcrPw
         ynVDliO+7Gg8+M8g67Qi+LwfQ6hcJFNBqGIzZ2sg70BwUkt45jkrNlAS0O8Hns0hbngp
         vewfleWO5weTH+1CJy0OdcgXQdd0TUyzhUycxH7AhLljanklaDhnmKNUc+Wp6oOZLwA1
         twaB2SC6n0VlASlprmXFpfAiZtt2l6Dr5JUqrkoRa2oM10dHlJtdcqIu5PlWQKB0NzvF
         46fw==
X-Gm-Message-State: AOJu0YxcFLMTY81ajg7cgif+hE+BR7mydR/xU8s5rjSuEZFR4XSTIJ1z
	rfE6LXDVLjk8/bUIvXajh4Anpph6eYvfTEGGCf2u4Ug5x170KKLFBcpF54AHQWWzUunKEab5v8J
	zWv5IUO3gn6FU887TZPVTWW4YuIfQQmEejYGD
X-Gm-Gg: ASbGncu3q61/ZQToE7O0CKS7AdmV+1pHZ3hDPtRQ1fdl3qGO8zD7grLezU9oD/0t9eB
	S2A7rcV3ZiI5/B/apNqCdU0NW1ehunI1vNswBG5ZD7MKyXXRHNJyxmg+u91YnELsOkyF0rHAgXB
	ZUgPAa5IQl5Tlk8litqyJLIgPZkWy9Q/I9hkHzD40qOUQacYPAyruw8dCfctqe6VUeJ0c8cEeNq
	PoJgBEUuJMl27W0yKRd4/zY/Y32IBDrZaEpBw2EDi9HzKDiqG902MtWeUBPjg==
X-Google-Smtp-Source: AGHT+IHlff+rO67oGnY+QjQ88tB2WcTERMdRU3Fxypssur31Qz4ip3ht5TWjIekukoKdi0uN7iQz9mEyOmMiGJmzmuw=
X-Received: by 2002:a2e:9a12:0:b0:372:9bf0:aec9 with SMTP id
 38308e7fff4ca-37a023b04cemr1437221fa.8.1761674770606; Tue, 28 Oct 2025
 11:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net> <20251027004404.2152927-12-sandals@crustytoothpaste.net>
In-Reply-To: <20251027004404.2152927-12-sandals@crustytoothpaste.net>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 28 Oct 2025 12:05:59 -0600
X-Gm-Features: AWmQ_blkJbXJzuePqMV6EdZScGd6ticd7DsFa0WMqWG40_N5sxuCn0S0LHuF3U4
Message-ID: <CAH=ZcbDCrYuSW7nLerQZnT-R_CoCtN2RNycLqOEEV-T-T7VoZQ@mail.gmail.com>
Subject: Re: [PATCH 11/14] rust: add functionality to hash an object
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 6:44=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> In a future commit, we'll want to hash some data when dealing with a
> loose object map.  Let's make this easy by creating a structure to hash
> objects and calling into the C functions as necessary to perform the
> hashing.  For now, we only implement safe hashing, but in the future we
> could add unsafe hashing if we want.  Implement Clone and Drop to
> appropriately manage our memory.  Additionally implement Write to make
> it easy to use with other formats that implement this trait.
>
> While we're at it, add some tests for the various cases in this file.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  src/hash.rs | 157 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 157 insertions(+)
>
> diff --git a/src/hash.rs b/src/hash.rs
> index a5b9493bd8..8798a50aef 100644
> --- a/src/hash.rs
> +++ b/src/hash.rs
> @@ -10,6 +10,7 @@
>  // You should have received a copy of the GNU General Public License alo=
ng
>  // with this program; if not, see <https://www.gnu.org/licenses/>.
>
> +use std::io::{self, Write};
>  use std::os::raw::c_void;
>
>  pub const GIT_MAX_RAWSZ: usize =3D 32;
> @@ -39,6 +40,81 @@ impl ObjectID {
>      }
>  }
>
> +pub struct Hasher {
> +    algo: HashAlgorithm,
> +    safe: bool,
> +    ctx: *mut c_void,
> +}

The name _Hasher_ is already used by std::hash::Hasher. It would be
preferable to pick a different name to avoid confusion. Perhaps
CryptoHasher, SecureHasher?

> +impl Hasher {
> +    /// Create a new safe hasher.
> +    pub fn new(algo: HashAlgorithm) -> Hasher {
> +        let ctx =3D unsafe { c::git_hash_alloc() };
> +        unsafe { c::git_hash_init(ctx, algo.hash_algo_ptr()) };
> +        Hasher {
> +            algo,
> +            safe: true,
> +            ctx,
> +        }
> +    }

-    pub fn new(algo: HashAlgorithm) -> Hasher {
+    pub fn new(algo: HashAlgorithm) -> Self {
         let ctx =3D unsafe { c::git_hash_alloc() };
         unsafe { c::git_hash_init(ctx, algo.hash_algo_ptr()) };
-        Hasher {
+        Self {
            algo,
            safe: true,
            ctx,
        }

> +    /// Return whether this is a safe hasher.
> +    pub fn is_safe(&self) -> bool {
> +        self.safe
> +    }

I don't understand the point in being able to query whether a given
hasher is safe or not. How does that change how this hasher code is
used? If the functions are safe then you wouldn't wrap it in an unsafe
block. If the functions are declared with unsafe then you'd always
need to wrap it in an unsafe block whether it's actually safe or not.
Using unsafe in Rust isn't like error handling where you do something
different on failure. If something fails in unsafe it's usually
unrecoverable e.g. segfault due to invalid memory access. My
understanding of unsafe in Rust means "The compiler can't verify that
this code is actually safe to run, so I've made sure that it is safe
myself and I'll let the compiler know what code to ignore during
compilation."

> +    /// Update the hasher with the specified data.
> +    pub fn update(&mut self, data: &[u8]) {
> +        unsafe { c::git_hash_update(self.ctx, data.as_ptr() as *const c_=
void, data.len()) };
> +    }
> +
> +    /// Return an object ID, consuming the hasher.
> +    pub fn into_oid(self) -> ObjectID {
> +        let mut oid =3D ObjectID {
> +            hash: [0u8; 32],
> +            algo: self.algo as u32,
> +        };
> +        unsafe { c::git_hash_final_oid(&mut oid as *mut ObjectID as *mut=
 c_void, self.ctx) };
> +        oid
> +    }
> +
> +    /// Return a hash as a `Vec`, consuming the hasher.
> +    pub fn into_vec(self) -> Vec<u8> {
> +        let mut v =3D vec![0u8; self.algo.raw_len()];
> +        unsafe { c::git_hash_final(v.as_mut_ptr(), self.ctx) };
> +        v
> +    }
> +}
> +
> +impl Write for Hasher {
> +    fn write(&mut self, data: &[u8]) -> io::Result<usize> {
> +        self.update(data);
> +        Ok(data.len())
> +    }
> +
> +    fn flush(&mut self) -> io::Result<()> {
> +        Ok(())
> +    }
> +}
> +
> +impl Clone for Hasher {
> +    fn clone(&self) -> Hasher {
> +        let ctx =3D unsafe { c::git_hash_alloc() };
> +        unsafe { c::git_hash_clone(ctx, self.ctx) };
> +        Hasher {
> +            algo: self.algo,
> +            safe: self.safe,
> +            ctx,
> +        }
> +    }
> +}
> +
> +impl Drop for Hasher {
> +    fn drop(&mut self) {
> +        unsafe { c::git_hash_free(self.ctx) };
> +    }
> +}

Make sense.

>  /// A hash algorithm,
>  #[repr(C)]
>  #[derive(Debug, Copy, Clone, Ord, PartialOrd, Eq, PartialEq)]
> @@ -167,6 +243,11 @@ impl HashAlgorithm {
>      pub fn hash_algo_ptr(self) -> *const c_void {
>          unsafe { c::hash_algo_ptr_by_offset(self as u32) }
>      }
> +
> +    /// Create a hasher for this algorithm.
> +    pub fn hasher(self) -> Hasher {
> +        Hasher::new(self)
> +    }
>  }
>
>  pub mod c {
> @@ -174,5 +255,81 @@ pub mod c {
>
>      extern "C" {
>          pub fn hash_algo_ptr_by_offset(n: u32) -> *const c_void;
> +        pub fn unsafe_hash_algo(algop: *const c_void) -> *const c_void;
> +        pub fn git_hash_alloc() -> *mut c_void;
> +        pub fn git_hash_free(ctx: *mut c_void);
> +        pub fn git_hash_init(dst: *mut c_void, algop: *const c_void);
> +        pub fn git_hash_clone(dst: *mut c_void, src: *const c_void);
> +        pub fn git_hash_update(ctx: *mut c_void, inp: *const c_void, len=
: usize);
> +        pub fn git_hash_final(hash: *mut u8, ctx: *mut c_void);
> +        pub fn git_hash_final_oid(hash: *mut c_void, ctx: *mut c_void);
> +    }
> +}
> +
> +#[cfg(test)]
> +mod tests {
> +    use super::{HashAlgorithm, ObjectID};
> +    use std::io::Write;
> +
> +    fn all_algos() -> &'static [HashAlgorithm] {
> +        &[HashAlgorithm::SHA1, HashAlgorithm::SHA256]
> +    }
> +
> +    #[test]
> +    fn format_id_round_trips() {
> +        for algo in all_algos() {
> +            assert_eq!(
> +                *algo,
> +                HashAlgorithm::from_format_id(algo.format_id()).unwrap()
> +            );
> +        }
> +    }
> +
> +    #[test]
> +    fn offset_round_trips() {
> +        for algo in all_algos() {
> +            assert_eq!(*algo, HashAlgorithm::from_u32(*algo as u32).unwr=
ap());
> +        }
> +    }
> +
> +    #[test]
> +    fn slices_have_correct_length() {
> +        for algo in all_algos() {
> +            for oid in [algo.null_oid(), algo.empty_blob(), algo.empty_t=
ree()] {
> +                assert_eq!(oid.as_slice().len(), algo.raw_len());
> +            }
> +        }
> +    }
> +
> +    #[test]
> +    fn hasher_works_correctly() {
> +        for algo in all_algos() {
> +            let tests: &[(&[u8], &ObjectID)] =3D &[
> +                (b"blob 0\0", algo.empty_blob()),
> +                (b"tree 0\0", algo.empty_tree()),
> +            ];
> +            for (data, oid) in tests {
> +                let mut h =3D algo.hasher();
> +                assert_eq!(h.is_safe(), true);
> +                // Test that this works incrementally.
> +                h.update(&data[0..2]);
> +                h.update(&data[2..]);
> +
> +                let h2 =3D h.clone();
> +
> +                let actual_oid =3D h.into_oid();
> +                assert_eq!(**oid, actual_oid);
> +
> +                let v =3D h2.into_vec();
> +                assert_eq!((*oid).as_slice(), &v);
> +
> +                let mut h =3D algo.hasher();
> +                h.write_all(&data[0..2]).unwrap();
> +                h.write_all(&data[2..]).unwrap();
> +
> +                let actual_oid =3D h.into_oid();
> +                assert_eq!(**oid, actual_oid);
> +            }
> +        }
>      }
>  }

Looks good.
