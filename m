Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867873D6C
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UZhzcEZ/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d4cffVOR"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D9BF9
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 22:44:21 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 8BF3F5C021A;
	Wed, 15 Nov 2023 01:44:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 15 Nov 2023 01:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1700030658; x=1700117058; bh=yM
	+dfRe6hvJs1tJ1vut2ksGIO4Zoajm3DGQBZqZqgA8=; b=UZhzcEZ/EjdvNKpzQq
	7uRo8bEWjoZGqp/6bWJTm/zxrI7y+SCDzFyUl8E8ZOyW3QbnTAMzt8NwLlpyOAyI
	P3wRS2vyp7cSsM/SywWXysuxBM4mqGpazy9xF3TFctFievqZFB+G+FFlogbWBO2T
	TikjA584YB4DeUm0vFbps9/aZhmwLDBCFI5sQKs1Lw3hf3K6Y/TGNBLW9aOOA346
	iQDnjuMsE4224wC0jDLYUQdCyl2bU73FLg2D6b6pfewLs3pFBFqJ/bEdGqcSh7S+
	PFWUS33RwwQct20IrI13x2Rw1qGjlAWSM+2djoKOqusQa8JanXe23rm19BOVcAed
	oiCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700030658; x=1700117058; bh=yM+dfRe6hvJs1
	tJ1vut2ksGIO4Zoajm3DGQBZqZqgA8=; b=d4cffVORBmaqQcGZrz0hkBZkr1JRN
	YQSjlT0n51jXyDCP6C8ImxTUQ+b1Ksem9+57900imsXEa/IVTAe6zxSE6/8cNSgV
	vzsFWZhEoSJL6GAi30Nisfe3uFPcQxOMj18rEbfdHlD6wilL7Ddgnik7aqDgUCRA
	FPEVxcQqc1sNVWgvcn7EEYjYqRZlPluW9xh3QRiSdsV8HSQNByDbF4587wO6XX9e
	CZmcqNVAOHHtsNhcZxXbO7Zk9mhRH746sng8IfUj2mGpk8l73xWxFuXBzYqHfkjy
	jqtI36yGgM3dvgTL9E9jlISH99WRVsQi8YnPendPkMUHhgzTYqABp3bcg==
X-ME-Sender: <xms:wWhUZYdcj4PT_rN-o-siNnuAFcr8NZRc3SFkZkuK-9Pc-2GgZksdjA>
    <xme:wWhUZaPLlXdAy7zszhMGxMSP1mGj1G40ThVRnOHkxScm9sKlJn4EN51uML6m3OmUh
    2lmuRYy_2J21I8Sxg>
X-ME-Received: <xmr:wWhUZZh-YIu3eQfeiP-ZfkJvStzrbzE_2SB0jz5dxQEQBMAMpp7mGkCQm4l7X4smmRCTu-x7jUZwHvZn054aKz7b4UaCWVVvCq7E5pgbV_Ylog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefhedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeetueevhffhudefvdegieeuieelgedthf
    egfedtueevjeejtdfgjeehudejuedtudenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:wmhUZd_i1dIBRxlJnmWYmGEUAzKK-zEkgSYsN7K5jwfhv0Wi4ni1oQ>
    <xmx:wmhUZUu3vbJb7BK2e7mNkZ6WO5TmKYF4bj0k7BmDOoyt-0qfT30RVQ>
    <xmx:wmhUZUEJfxGw7bkg6zRlIcw_OcN2BNuVgaPfH_1EufqQbRNWONwxZw>
    <xmx:wmhUZQL2LMP6o-wNbZhV21peAvTiaqSIlUhNngxUEATxz97TCRFjUQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Nov 2023 01:44:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 12a14c7d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Nov 2023 06:43:35 +0000 (UTC)
Date: Wed, 15 Nov 2023 07:44:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?SmnFmcOtIEhydcWha2E=?= <jirka@fud.cz>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/5] http: reset CURLOPT_POSTFIELDSIZE_LARGE between
 requests
Message-ID: <ZVRovA9OSfY5odhy@tanuki>
References: <CAGE_+C6DJMAO0bj5QHoKBBV3gMEMtZ-ajJ9ZnDGYq6eorr-oig@mail.gmail.com>
 <20231115033121.939-1-jirka@fud.cz>
 <CAGE_+C5pnASOsrDr4ehNj-deYbSTr=pRgPcWqq5VSQs-Y08ttQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FY4GLBDj9WNq+nDy"
Content-Disposition: inline
In-Reply-To: <CAGE_+C5pnASOsrDr4ehNj-deYbSTr=pRgPcWqq5VSQs-Y08ttQ@mail.gmail.com>


--FY4GLBDj9WNq+nDy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 07:34:55PM -0800, Ji=C5=99=C3=AD Hru=C5=A1ka wrote:
> `get_active_slot()` makes sure that the reused cURL handles it gives
> out are as good as fresh ones, by resetting all options that other code
> might have set on them back to defaults.
>=20
> But this does not apply to `CURLOPT_POSTFIELDSIZE_LARGE` yet, which can
> stay set from a previous request. For example, an earlier probe request
> with just a flush packet "0000" leaves it set to 4.
>=20
> The problem seems harmless in practice, but it can be confusing to see
> a negative amount of remaining bytes to upload when inspecting libcurl
> internals while debugging networking-related issues, for example.
>=20
> So reset also this option to its default value (which is -1, not 0).
>=20
> Signed-off-by: Jiri Hruska <jirka@fud.cz>
> ---
>  http.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/http.c b/http.c
> index 8f71bf00d8..14f2fbb82e 100644
> --- a/http.c
> +++ b/http.c
> @@ -1454,6 +1454,7 @@ struct active_request_slot *get_active_slot(void)
>  	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, NULL);
>  	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, NULL);
>  	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
> +	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE_LARGE, (curl_off_t)-=
1);
>  	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
>  	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);

It feels quite easy for this list to grow stale whenever we start to set
a new option somewhere else. Is there a specific reason why we can't
instead use `curl_easy_reset()` here? Quoting its description:

> Re-initializes all options previously set on a specified CURL handle
> to the default values. This puts back the handle to the same state as
> it was in when it was just created with curl_easy_init.
>=20
> It does not change the following information kept in the handle: live
> connections, the Session ID cache, the DNS cache, the cookies, the
> shares or the alt-svc cache.

=46rom my naive point of view it sounds like exactly what we're after.
Most of the code in question was introduced in 9094950d73 (http: prevent
segfault during curl handle reuse, 2006-05-31), where we used to support
libcurl at least back to v7.7. `curl_easy_reset()` on the other hand had
only been introduced with v7.12.1 of libcurl, so maybe that's the reason
why it's not used here?

I dunno, might as well be that there is a good reason why we don't use
it here. But if we can, then I'd argue it would be a great cleanup to
convert to `curl_easy_reset()` here instead of piling onto the list of
options.

Patrick

--FY4GLBDj9WNq+nDy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVUaLcACgkQVbJhu7ck
PpSD1Q//dNFnVTYzulRMxZBtl1WczqA0UxkXOGxWHFGUX+nO1C4I/JNOccNf3eel
tFa2yxo/EcFQJnVxxttVvqFcb5S8Fz9qZCvYAzHGhGbMliKTRFev6+FdJ+AT4Mwk
f5tBQLubceHsYIf9dxni/2SOnyyj+6Aux/F58mSv90F0nZJbB+dfkO5E3xux6ak0
0L+CzXCyY7kwIiZaqKH+YGJBGUnpOUMq9q/DLoxkXTJjTDpF+CcMD9Qcy0iMQZ4d
lgA3ZSgmbrsiofOHWDe12AM8PtD1vqRMiH+FuBjxW6UNl5EpPJRZxov+HnrE6uin
k7JpJkzkLCZ5bNjxfHCOkynlH1R/1ODg8IuDzXP8J1G8qqOqOG+eCXnsYGKEVwTl
8iIBVNgTti1i//vZztNChnkiS/cgy7Yg7EF3DDYiIbPEfH670PtLo+1KMqwcje2i
g2Pi1eOCftR6B6Ronrb7pDmdYBsVk8SdwLfdnoxfBosbGnS8M0Nk3loyu5QNQ6s2
8zb+wU9HQZAApAbHP8H5b+aOfHif3M7KX8y8gzF59lHg7se75Oil5qFP+DF9x8Y7
42rowyqwJa4DU3fujc84MN6gvwX8mUEPNRh5R3GIXpBCoJvzPKzRsXxTFPYa3Z1c
GKGR7x8EKq2G+pMuL7lCtHRRIHhn8IyAnfzCPQFAOnsoPlvI8uo=
=W/WY
-----END PGP SIGNATURE-----

--FY4GLBDj9WNq+nDy--
