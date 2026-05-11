Received: from mx1.b1-systems.de (mx1.b1-systems.de [159.69.135.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F8538332B
	for <git@vger.kernel.org>; Mon, 11 May 2026 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.135.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778539569; cv=none; b=YWYmHEZzzlDvumcsmAf0DwW5cfhJ1Q/10KEFq0QBsGMymIgfP58lLLrXbXCJAcerhR6EzssBr6S29IH8sp0qjChAClV60BRhgltAYGcMJteFI9dC7laUUvECfMcZnzqfiZSzQRRoSWOwSn8Z+4kkr48yXy5Ys0jYo+idS1CClLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778539569; c=relaxed/simple;
	bh=Pt0xHMfmcg+h7qkTZ25L29+qQKH2JUKort9o2m15fAM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UP+VtLh5CgJo7OMv2G2iFdtTT7Dodg1wa+mLvj9yKT2QLG0oVzw3XI8zElfquwvSNW/phNn4N/ikGp8Tld1G88qkjNW1U7pv1CFLDawaTK0ezUepagfBNvl9ZSF28vn9cF6OnHCvvBwg4/EKv/81Ad4p/HVMBYOK5gTwB5+bMAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1-systems.de; spf=pass smtp.mailfrom=b1-systems.de; dkim=pass (1024-bit key) header.d=b1-systems.de header.i=@b1-systems.de header.b=DkIARKYJ; arc=none smtp.client-ip=159.69.135.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1-systems.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1-systems.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=b1-systems.de header.i=@b1-systems.de header.b="DkIARKYJ"
Date: Tue, 12 May 2026 00:46:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=b1-systems.de;
	s=default; t=1778539565;
	bh=Pt0xHMfmcg+h7qkTZ25L29+qQKH2JUKort9o2m15fAM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=DkIARKYJRVPc6ftUo7yG/KHvWOhOhiPDGhJN05BVjKvc8yeFmtoevgbqllvPMavA0
	 7h0fbddjltfICfO8OIER8RYm9IUcINsCiZbHevVMOUjcPvo8l5b4b9T+MBDoO5pp4h
	 d7A2ygq++RSGGobWQDsOdzWZn349lNvuK8wtpJgc=
From: Thorsten Glaser <tglaser@b1-systems.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
cc: git@vger.kernel.org
Subject: Re: git hard-codes use of /bin/sh for aliases
In-Reply-To: <agJaS0xuMaLm6UZv@fruit.crustytoothpaste.net>
Message-ID: <9f279637-c0fe-c88b-24de-3a00b957ae3b@b1-systems.de>
References: <6791cb26-16af-dcda-1dae-82b85da6fb0f@b1-systems.de> <agJaS0xuMaLm6UZv@fruit.crustytoothpaste.net>
x-ms-reactions: disallow
X-Zitierstil: Wir wechseln gerne von TOFU auf den Usenet-Zitierstandard; sprechen Sie uns einfach an!
X-Quoting-Style: We will gladly switch from top-posting to Usenet standard quoting style; please just ask!
Content-Language: ksh-Latn-DE-u-ca-iso8601-co-POSIX-kk-false-em-text-rg-denw-tz-utc-va-posix, de-DE-1901-u-ca-iso8601-co-POSIX-kk-false-em-text-rg-denw-tz-utc-va-posix, de-Latf-DE-1901-u-ca-iso8601-co-POSIX-kk-false-em-text-rg-denw-tz-utc-va-posix, en-GB-u-ca-iso8601-fw-mon-hc-h23-co-POSIX-kk-false-cu-eur-em-text-rg-denw-ms-metric-mu-celsius-tz-utc-va-posix, und-Zsym-u-ca-iso8601-fw-mon-hc-h23-co-POSIX-kk-false-cu-eur-em-text-rg-denw-ms-metric-mu-celsius-tz-utc-va-posix
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 11 May 2026, brian m. carlson wrote:

>On Linux, I have mksh, but my work machine on macOS does not, so
>specifying `core.sh =3D /bin/mksh` would not work on all my systems.  If

But it could be made possible by pointing it to ~/.etc/bin/mksh
on the Macintosh=E2=80=A6

>I'll also note that Git doesn't handle aliases specially.  Git has a
>with-shell and a without-shell mode for running commands, and we use the
>former for aliases.

Ah, okay.

I was merely wondering that it was not configurable for aliases.

When looking at the aliases in detail, I found that I already invoked
mksh -c '=E2=80=A6' in those that used mksh-specific code, and that the one
that failed merely uses a recent POSIX sh construct that /bin/sh on
a customer system does not yet implement and I could reword it.

bye,
//Thorsten
--=20
Thorsten Glaser
Linux / Unix Developer
Tel.: +49 160 91168501
E-Mail: tglaser@b1-systems.de

B1 Systems GmbH
Osterfeldstra=C3=9Fe 7 / 85088 Vohburg / https://www.b1-systems.de/
GF: Ralph Dehner / Unternehmenssitz: Vohburg / AG: Ingolstadt, HRB 3537
