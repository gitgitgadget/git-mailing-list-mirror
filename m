Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F3CB65C
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 00:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736208843; cv=none; b=K8hWZlS7QPUAEMX7CdvnQ19bmUx54RPRkhDvQc3Oc723t/LVKB8NSn5/p+bZ7YcpIhWGUP5Xyy4/eweEca4fdKELai0jtrcDlvUtJHoipWanslJMYed7ph8Y/+fIXaj5mjyNPxdHh1pVl/W1tWEjqQK/SouvVcAJBOn9U2YwQ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736208843; c=relaxed/simple;
	bh=IGv0eWbYL3dj2o6RbDLV9nHpL7gVJR8S/D5MHOXgjJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d59E2EalUajeWRodl1psbOxJ2cN57qg0g8jITpGhoxxvy+UNFd8bw27fU/BspKn80Zpr24OxNrNhsfbKOIL+Cq1nu5xFtcRUOkl4brticJc5/6NMZf67Uh+e2Rx3cL5gTxEtUzkNpYXFpYbJeP2EU7X+XUhLI9LIqm3sYjt035s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=tTm3hqaf; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="tTm3hqaf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1736208839;
	bh=IGv0eWbYL3dj2o6RbDLV9nHpL7gVJR8S/D5MHOXgjJc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=tTm3hqafZNKLCvxy/yKIv/dIIgvz5CNCDHoFxl1j5Gt+sc0pzgTiUB7uFe9wwskC0
	 /BbzVcSSr+JuprZNoXcxfW7GTjU5oi6BD/56x92jPiTol3O4nWWZKBf7BQqxJGSutG
	 eVvuyWiTWZCGDsj92CRUdOfW5LwZJ3o/ThtXpXWHAuSOyAqpfuzBvbrHdsAlA8ICFw
	 ptiXDiyiKdG96G+nAQ6Snu4upIK8HM7Lzhelv1HQ2BRdTrAfGf2+C0deyPJ/UHqM6x
	 X2xzTDNbGPenA69kjlHq3sBZyGWaDPCMWu7DAD68TM6PHQtIlbpi3HZfyHPbEoec10
	 EKMfpjB1z6aPzTim8963ZIDvv6nvsv9R4cAzqBPOWA+kWWFdUOzsdrNHIlgD1Y/bbN
	 n8AcS+gtEKRSbOPP3ZFEZFeIgqv/pO+xcPuMqqhdRaDOJqsT3QI7Jwlnqh50azTOOj
	 M1Om9TSjI0b/knJwbizs+iCjgtNz+MciSyoI5SVbxR7+oKJEh20
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 05C3C20991;
	Tue,  7 Jan 2025 00:13:59 +0000 (UTC)
Date: Tue, 7 Jan 2025 00:13:57 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: xmqqfrm9t6up.fsf@gitster.g
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com,
	ps@pks.im, =?utf-8?B?U8O2cmVu?= Krecker <soekkle@freenet.de>
Subject: Re: [PATCHv2 1/4] add-patch: Fix type missmatch rom msvc
Message-ID: <Z3xxxbKtqyLmDAif@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	xmqqfrm9t6up.fsf@gitster.g, git@vger.kernel.org, gitster@pobox.com,
	phillip.wood123@gmail.com, ps@pks.im,
	=?utf-8?B?U8O2cmVu?= Krecker <soekkle@freenet.de>
References: <20250106190855.3098-1-soekkle@freenet.de>
 <20250106190855.3098-2-soekkle@freenet.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OUozRrtU4aK17wNQ"
Content-Disposition: inline
In-Reply-To: <20250106190855.3098-2-soekkle@freenet.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


--OUozRrtU4aK17wNQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-06 at 19:08:52, S=C3=B6ren Krecker wrote:
> Fix some compiler warings from msvw in add-patch.c for value truncation
> form 64 bit to 32 bit integers.Change unsigned long to size_t for
> correct variable size on linux and windows.
> Add macro strtos for converting a string to size_t.
> Test if convertion fails with over or underflow.

A few minor nits here.  We want to say "from" both here and in the title
and "conversion" (and in the title, "mismatch"), and put a space after
the period in a sentence.  I think you meant "MSVC" instead of "msvw",
but if not, please do explain what that is, since I'm not familiar with
it and I'm curious.  The commit message is a good place to explain lots
in detail.

> Signed-off-by: S=C3=B6ren Krecker <soekkle@freenet.de>
>=20
> Uses strtouq

I don't see that we're using this function.

> impove linux support
>=20
> Change Macro name

We don't typically put comments about the revisions we've made to a
patch in the commit message.  We may put them below the --- so that
they're visible to readers and reviewers, which is helpful, but we
pretend that our patches were perfect to begin with in terms of the
commit message, since the future reader of the history only cares about
the actual end result and not what changes we made along the way.

> ---
>  add-patch.c       | 53 +++++++++++++++++++++++++++--------------------
>  gettext.h         |  2 +-
>  git-compat-util.h |  6 ++++++
>  3 files changed, 38 insertions(+), 23 deletions(-)
>=20
> diff --git a/add-patch.c b/add-patch.c
> index 7b598e14df..67a7f68d23 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -242,7 +242,7 @@ static struct patch_mode patch_mode_worktree_nothead =
=3D {
>  };
> =20
>  struct hunk_header {
> -	unsigned long old_offset, old_count, new_offset, new_count;
> +	size_t old_offset, old_count, new_offset, new_count;
>  	/*
>  	 * Start/end offsets to the extra text after the second `@@` in the
>  	 * hunk header, e.g. the function signature. This is expected to
> @@ -322,11 +322,12 @@ static void setup_child_process(struct add_p_state =
*s,
>  }
> =20
>  static int parse_range(const char **p,
> -		       unsigned long *offset, unsigned long *count)
> +		       size_t *offset, size_t *count)
>  {
>  	char *pend;
> -
> -	*offset =3D strtoul(*p, &pend, 10);
> +	*offset =3D strtos(*p, &pend, 10);

I see you've defined this below.

> +	if (errno =3D=3D ERANGE)
> +		return error("Number dose not fit datatype");

I think the word you wanted was "does".  However, perhaps we should
provide a better, more meaningful error message so the user knows what
data they provided that was invalid.  Maybe "absurdly large value in
diff header range"?  It would be quite bizarre to get a value even as
large as the maximum value of a 32-bit integer, and I don't think our
diff code can even handle values larger than INT_MAX.

In that context, it might not even be necessary to handle values larger
than unsigned long, since we can't generate them.  However, in the
interests of compatibility with other implementations which might not
have that limitation, size_t seems reasonable as a choice to handle more
generally.

Assuming we keep this, we probably also want to mark this for
translation by wrapping it in `_(` and `)`.

I also don't think this order is correct.  In general, errno is not
reset implicitly, so unless we know that an error occurred, errno is
meaningless, since another function could have set it to ERANGE.  We'd
probably need to save errno, set it to 0, and restore to verify that we
got the right value, since we can't distinguish here between a truncated
value for range reasons and for other reasons.

>  	if (pend =3D=3D *p)
>  		return -1;
>
>  	if (*pend !=3D ',') {
> @@ -334,7 +335,9 @@ static int parse_range(const char **p,
>  		*p =3D pend;
>  		return 0;
>  	}
> -	*count =3D strtoul(pend + 1, (char **)p, 10);
> +	*count =3D strtos(pend + 1, (char **)p, 10);
> +	if (errno =3D=3D ERANGE)
> +		return error("Number dose not fit datatype");

Same comment here.

>  	return *p =3D=3D pend + 1 ? -1 : 0;
>  }
> =20
> @@ -673,8 +676,8 @@ static void render_hunk(struct add_p_state *s, struct=
 hunk *hunk,
>  		 */
>  		const char *p;
>  		size_t len;
> -		unsigned long old_offset =3D header->old_offset;
> -		unsigned long new_offset =3D header->new_offset;
> +		size_t old_offset =3D header->old_offset;
> +		size_t new_offset =3D header->new_offset;
> =20
>  		if (!colored) {
>  			p =3D s->plain.buf + header->extra_start;
> @@ -700,12 +703,14 @@ static void render_hunk(struct add_p_state *s, stru=
ct hunk *hunk,
>  		else
>  			new_offset +=3D delta;
> =20
> -		strbuf_addf(out, "@@ -%lu", old_offset);
> +		strbuf_addf(out, "@@ -%" PRIuMAX, (uintmax_t)old_offset);
>  		if (header->old_count !=3D 1)
> -			strbuf_addf(out, ",%lu", header->old_count);
> -		strbuf_addf(out, " +%lu", new_offset);
> +			strbuf_addf(out, ",%" PRIuMAX,
> +				    (uintmax_t)header->old_count);
> +		strbuf_addf(out, " +%" PRIuMAX, (uintmax_t)new_offset);

If we're using size_t, we can use %zu.  That's specified in C99 as the
appropriate formatting type for size_t, and we require C99 or C11 for
all systems.  We don't need to cast to uintmax_t.

> diff --git a/gettext.h b/gettext.h
> index 484cafa562..d36f5a7ade 100644
> --- a/gettext.h
> +++ b/gettext.h
> @@ -53,7 +53,7 @@ static inline FORMAT_PRESERVING(1) const char *_(const =
char *msgid)
>  }
> =20
>  static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
> -const char *Q_(const char *msgid, const char *plu, unsigned long n)
> +const char *Q_(const char *msgid, const char *plu, size_t n)
>  {
>  	if (!git_gettext_enabled)
>  		return n =3D=3D 1 ? msgid : plu;
> diff --git a/git-compat-util.h b/git-compat-util.h
> index e283c46c6f..4c33990a05 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -291,6 +291,12 @@ static inline int _have_unix_sockets(void)
>  #ifdef HAVE_BSD_SYSCTL
>  #include <sys/sysctl.h>
>  #endif
> +#if defined _WIN64
> +# define strtos strtoull
> +#else
> +#define strtos strtoul
> +#endif

This is not a great name for the function.  First of all, it resembles
the standard functions a lot, so it's something that POSIX could
standardize or an OS could add, and then we'll have some fun compilation
errors when we redefine things.

Second, it's a lot less future-proof.  While I do agree that only
Windows 64-bit systems are likely to fall into this case, since we
already include <limits.h>, we probably should do this:

  #if SIZE_MAX =3D=3D ULONG_MAX
  #define str_to_size_t strtoul
  #else
  #define str_to_size_t strtoull
  #endif

(or whatever you want to call the function).

That expresses what we care about=E2=80=94that the type is suitable for the
value we want to parse=E2=80=94and doesn't use the OS as a proxy for that d=
ata.
Otherwise, the Unix developer who doesn't use Windows may not
understand _why_ Windows is special and the reason we've chosen this
change.

On that note, it would be helpful if you explained in the commit message
why that is for people who don't know.  Maybe something like this:

  On 64-bit systems, size_t is a 64-bit type.  On most Unix systems,
  unsigned long is also 64 bits in size, so we can use functions for
  that type to parse values of size_t.  However, on Windows, unsigned
  long is always 32 bits, and if we want a 64-bit type, we must use
  unsigned long long.  To future-proof our changes against other
  platforms that might be added in the future, we first check if
  unsigned long is sufficient, and otherwise, use unsigned long long,
  which will work in both cases.

Of course, please feel free to edit as you see fit.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--OUozRrtU4aK17wNQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.45 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ3xxxQAKCRB8DEliiIei
gbYzAP9n/BSM1FKvIsg2iaEviTGaRiYiOQnu9eA6q6XtMgF9sAEA+vqUUE+z+4ly
uhfUyq+XsjksiInHZuqjdM78Qh6KggU=
=GPgS
-----END PGP SIGNATURE-----

--OUozRrtU4aK17wNQ--
