Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8430F9475
	for <git@vger.kernel.org>; Tue, 21 May 2024 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716334604; cv=none; b=CTBgjYyMz8PAcJyY45VmGpvapaUkSlkZ7Bwv7SZy43dXCWBCi9whvHJJO0MPT0Ju4qu4s7vx1NzxA2BLSBStovvYNkdqHO5yH5ns38B/QtNZXcZBsPHztl/NTzk7PXwAOThA+mn86nvzau3QQRmLc9GS+cjrcMHmjj3TjEebQOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716334604; c=relaxed/simple;
	bh=j9qZveFQGma+zceK4xak4NiH1COOkUt/5iiApCco/Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqFxueC9T46OeY7J3hs+nZN3bVYzO/wV/NvQEJ95lrDx07H4UqxtCoYuePmsD+cY1bnSZqEcWgivhCdjsnc4GSkAVqaR8VhL2Fh5gHn9dE91DgrBUKO9Oj5h4mgiI/cIpiZJB1DUYLIb95vMSySQK60fEowU+xTjS6yZdyz7r04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=UbovXRii; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UbovXRii"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 32B095DA9A;
	Tue, 21 May 2024 23:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1716334601;
	bh=j9qZveFQGma+zceK4xak4NiH1COOkUt/5iiApCco/Ms=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=UbovXRiiC0cjGRTh8XmNmC3S8qonNJ+/Ebe8YP0mhGG2tvlhHE2RuYhJZGGyVJW/J
	 yy25I4ac/lcRTQ9W7XDjfuZjzf7AsejG+Ej2zZwQRBkyhDdTFyRuO/aqZM5F1QEqhH
	 i9hoAyjeNegaS4rCgrLEYf25/GIrF9cBt6CnAkAn4xzTYb2JbyZlsQpv09ldZY70wm
	 pXkdUU/iIFPjG/ut3WFrg4wIfMNV8fMmoGzQseg+jvLRvGiSYX66AAiiqFEdnEwTc6
	 jgmUMVtU1pN+TeOXA2t+WIuwDpel3KzdtH8gNd64H1eiFuA/GEAgzRX0xOsMXu0xQR
	 CuAa6EvOCINQZRuk4lebyLxud+gpxzCVNK4gsFW4Y93gVKX/kmHdM27ZlrcvdhThGn
	 Vc1QplWzS3nJ5bCbJPN1mvhQYqbWZorpXHcueW1yp3YVxw3Aeg82Ewqgaay+b5prC3
	 dZW4GE46hFpZvhEmJVCOpsd85agxxRIOEfaekkGVasco4RwzuRs
Date: Tue, 21 May 2024 23:36:38 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Boris Mbarga via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>,
	Boris Mbarga <elhmn42@gmail.com>, elhmn <elhmn@github.com>
Subject: Re: [PATCH] http: display the response body on POST failure
Message-ID: <Zk0wBltFytCGjUFv@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Boris Mbarga via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Boris Mbarga <elhmn42@gmail.com>, elhmn <elhmn@github.com>
References: <pull.1722.git.git.1716239367046.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YFGNV5eYwxnANYIR"
Content-Disposition: inline
In-Reply-To: <pull.1722.git.git.1716239367046.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--YFGNV5eYwxnANYIR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-20 at 21:09:26, Boris Mbarga via GitGitGadget wrote:
> From: elhmn <elhmn@github.com>
>=20
> When Git sends a GET request and receives an HTTP code indicating
> failure (and that failure does not indicate an authentication problem),
> it shows the body of the response, i.e. the error message.
> The same is not true for POST requests. However, it would be good to show
> those error messages e.g. in the case of "429 Too many requests", because
> the user might otherwise be left puzzled about the reason why their clone
> did not work.

I think this is a good idea (and not just because I talked about it with
Boris).  If a user gets an error response, we want them to be able to
receive a helpful response from the server telling them what might have
gone wrong.  While many of us know full well what a 429 response means,
it isn't immediately obvious to many users (judging from my experience
on Stack Overflow), and we might still want to tell users why they got a
429 (too many requests from their IP, network, token, application or
integration, etc.).

> This patch aligns the way POST requests are handled with the GET request
> handling.
>=20
> Signed-off-by: elhmn <elhmn@github.com>

I believe the policy is to put your real name here and in the commit. We
know what it is already from the headers.  You can probably do `git -c
user.name=3D"Boris Mbarga" commit --amend --reset-author --signoff` to fix
that.

> diff --git a/http.c b/http.c
> index 3d80bd6116e..2017e909054 100644
> --- a/http.c
> +++ b/http.c
> @@ -1419,6 +1419,7 @@ struct active_request_slot *get_active_slot(void)
>  		newslot->curl =3D NULL;
>  		newslot->in_use =3D 0;
>  		newslot->next =3D NULL;
> +		newslot->errstr =3D NULL;
> =20
>  		slot =3D active_queue_head;
>  		if (!slot) {
> diff --git a/http.h b/http.h
> index 3af19a8bf53..cb542c62933 100644
> --- a/http.h
> +++ b/http.h
> @@ -30,6 +30,7 @@ struct active_request_slot {
>  	void *callback_data;
>  	void (*callback_func)(void *data);
>  	struct active_request_slot *next;
> +	struct strbuf *errstr;
>  };
> =20
>  struct buffer {
> diff --git a/remote-curl.c b/remote-curl.c
> index 0b6d7815fdd..9b2a41b2451 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -804,8 +804,11 @@ static size_t rpc_in(char *ptr, size_t eltsize,
>  	if (curl_easy_getinfo(data->slot->curl, CURLINFO_RESPONSE_CODE,
>  			      &response_code) !=3D CURLE_OK)
>  		return size;
> -	if (response_code >=3D 300)
> +	if (response_code >=3D 300) {
> +		strbuf_reset(data->slot->errstr);
> +		strbuf_add(data->slot->errstr, ptr, size);
>  		return size;
> +	}
>  	if (size)
>  		data->rpc->any_written =3D 1;
>  	if (data->check_pktline)
> @@ -837,6 +840,8 @@ static int run_slot(struct active_request_slot *slot,
>  				strbuf_addch(&msg, ' ');
>  				strbuf_addstr(&msg, curl_errorstr);
>  			}
> +			if (slot->errstr && slot->errstr->len)
> +				error(_("%s"), slot->errstr->buf);
>  		}
>  		error(_("RPC failed; %s"), msg.buf);

I think we should print the "RPC failed" message as well, and first.
That message, even if not super helpful, contains the status code and
some other information, which might be more helpful than what the remote
server actually said.

We might also want to print "remote:" in front of the error string, so
that the user knows it comes from the server instead of Git.  That can
be helpful when searching for it online.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--YFGNV5eYwxnANYIR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZk0wBgAKCRB8DEliiIei
gWVrAPwPrEWXIkswzZpdmGhmfjneuKGTE9sgprZHvfCPOO5qzgEAyBwRqsrEdCzp
j+gfD2avizSp+g+kLNZJiK5b40ujXwM=
=Oq2Y
-----END PGP SIGNATURE-----

--YFGNV5eYwxnANYIR--
