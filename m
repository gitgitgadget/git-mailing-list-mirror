Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914B0F9E8
	for <git@vger.kernel.org>; Fri, 26 Dec 2025 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766756045; cv=none; b=X6nA3WHKUAJLzr7OQlnGboU8BJSghucKrVwYhePWzSzdVKh9Cd2nQ5YkhsEZHEYgPfiTynw4+GBpXUjlAkUVPotkpJFkWNtBVf/p0pTxqufG6aN/Sa48NGmkwCQPjNrt8HeqKv4znRIiTx/pje0fNCz9dCJGM3DTjbjJLDsiBKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766756045; c=relaxed/simple;
	bh=GbekjfEcGUwpnFIFfC9SlBvcIBeoHKQivZoUvTdm6AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CO2vSxvEpm0mh2QnJ/7C16Q6mWUsCyIsvwSXp7XsiEgJNQ6VprJOSO9BPxhV2EFn8zLYOrWpSwBpAUSgVZ5F2FFPjikdkMi88M1ZTiU+kID/ZCga5qULgRcAyVU3lF6ApNOPufj3ddfR0ukiHxCBKntgfyaw9EbV8hYKaC3mkoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 7276A4D0AB
	for <git@vger.kernel.org>; Fri, 26 Dec 2025 14:33:54 +0100 (CET)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:2de5:2436:debf:9390])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id B8ABBB00572;
	Fri, 26 Dec 2025 14:33:38 +0100 (CET)
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <avila.jn@gmail.com>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>,
 Elijah Newren <newren@gmail.com>,
 Christian Couder <christian.couder@gmail.com>,
 Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 5/9] doc: fetch: document `--filter=<filter-spec>` option
Date: Fri, 26 Dec 2025 14:33:38 +0100
Message-ID: <4702585.LvFx2qVVIh@cayenne>
In-Reply-To: <20251223111113.47473-6-christian.couder@gmail.com>
References:
 <20251223111113.47473-1-christian.couder@gmail.com>
 <20251223111113.47473-6-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 23 December 2025 12:11:09 CET Christian Couder wrote:
> The `--filter=3D<filter-spec>` option is documented in most commands that
> support it except `git fetch`.
>=20
> Let's fix that and document that option properly in the same way as it
> is already documented for `git clone`.
>=20
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/fetch-options.adoc | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-
options.adoc
> index fcba46ee9e..70a9818331 100644
> --- a/Documentation/fetch-options.adoc
> +++ b/Documentation/fetch-options.adoc
> @@ -88,6 +88,16 @@ linkgit:git-config[1].
>  This is incompatible with `--recurse-submodules=3D(yes|on-demand)` and t=
akes
>  precedence over the `fetch.output` config option.
>=20
> +--filter=3D<filter-spec>::

The option itself must also be back-ticked.

`--filter=3D<filter-spec>`::

> +	Use the partial clone feature and request that the server sends
> +	a subset of reachable objects according to a given object filter.
> +	When using `--filter`, the supplied _<filter-spec>_ is used for
> +	the partial fetch. For example, `--filter=3Dblob:none` will filter


Isn't this second sentence redundant? What new information is brought?

> +	out all blobs (file contents) until needed by Git. Also,
> +	`--filter=3Dblob:limit=3D<size>` will filter out all blobs of size
> +	at least _<size>_. For more details on filter specifications, see
> +	the `--filter` option in linkgit:git-rev-list[1].
> +
>  ifndef::git-pull[]
>  `--write-fetch-head`::
>  `--no-write-fetch-head`::

Thank you

Jean-No=C3=ABl


