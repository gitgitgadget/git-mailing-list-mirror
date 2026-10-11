Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92863C9EF3
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 06:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791701864; cv=none; b=jag0vfzBf4WJkSncUid9qBr+DxNs0lavfHt3OgbNTWvIBE0DUS//3GOweIKGtxpbKjgzrRdh5kV6MvXsEPBQ3xgKwc5svjpCILjLwMUa3zXIfdLGA9nhHe0G+UnbA0/8j4O+BimEhpz9uXXvL2ewMh1yaPSb/Y2j0gCWk+7TNxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791701864; c=relaxed/simple;
	bh=n8sJRFYmln29ZkyOIzcc1+A4eO8W4unujYxErYi1EKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7yBGWR9y1LSgervNXchz3cQhB3Dx55bMEuaEz2McOg46vCNd5wSoQtcj+KlUdrI/goH0TktWS2YOAkGq/HtR39woQKsZIQltsyIM/BBWm/8lPNf3qUSkwyg5gM3Q3yxr3gc3qZlcp1Uk37XESO6UZRnAlJ7a13zKUy05y2mxg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=QOqd8Xn5; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="QOqd8Xn5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1791701859; x=1792306659; i=tboegi@web.de;
	bh=9k3NuSgw3iaOPX6uo4A1FazEhs9TNrDLKmSscluzCjw=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QOqd8Xn5vjWcaOkG3BTz+WbobaVnRhkeZpXTAEfyEyZM1Gr6mcQMzbK6JoUu+xDn
	 O0s3xl+0hQHlM9cUF4/VQ96TU8fGycGm81CTkD6nyhmTlBNmXQ89YFzwKXf07UUbO
	 l8hsUMSTrjrUt2+z1E1WkTgL5RXrdhEOQ1XC0nRa9oSVZ8/0x5b74gdmBcPsT+8WX
	 dqXgxc/O3sD5pEhFfTrAHPxS5dE/s2nKX45Fm7SelMS/AaYXObq86bWyZvLuld7jZ
	 +DqhszegRiuqc9M/VXGbUpwyYJlneXgpGsPDjNzIA3Y9XqQ3sxQGMHUMNMk612qqa
	 7vNiD9EkkqBQy1E9bA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M59nK-1xGtxn1hMC-001f2z; Sun, 11
 Oct 2026 08:57:39 +0200
Date: Sun, 11 Oct 2026 08:57:38 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Curtis Allen Smith <curtis.allen.smith@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] read-cache: do not trust a size change when
 conversion is active
Message-ID: <20261011065738.GA1873@tb-raspi4>
References: <20261008204603.1988-1-curtis.allen.smith@gmail.com>
 <20261008204603.1988-2-curtis.allen.smith@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008204603.1988-2-curtis.allen.smith@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:6EwBHGc0zmgtHRZimmjjtntfW5XNSOeusU+GIKkZ+hkealqdDL9
 /nhxMldtRhgpzXp+noVSjwpfnMjQWzICI9wjxWW3J1Fw8lJf/AYkCg1D7DAAL+Gmv2zy1fh
 WpuBp4xdQ88ck8kmOpPh/j45WrRX08lj1WWLSjO8hzFg19BhD4RJy43VjrKYRJIE/qux5f1
 aJWNW2SyCoT8sskEKYvfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k2uW72ivOj4=;bHJRmulOCURZk42DdIosfRomH8n
 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
Content-Transfer-Encoding: quoted-printable

On 2026-10-08 22:45, Curtis Allen Smith wrote:

Disclaimer: My comments may be hard to read - they are intended to
be helpfull, but I struggled with my email-prgrams here.

> "git status", "git diff" and "git add" can disagree about whether a
> file has been modified.  Under
>=20
> 	* text eol=3Dlf
>=20
> a tool that rewrites an otherwise unchanged file with CRLF endings
> makes "git status" report it as modified, while "git diff" shows
> nothing and "git add" stages nothing [snip]

Nit:... stages nothing to be committed.
It does update the index,
since the length of the file in the working tree has changed.

`git add` runs the clean filter, the working tree encoding, CRLF
conversion and the "indent" filter, if specified for a file.

[snip]
> That contradiction, rather than the line endings as such, is what
> this series is about.
good

>=20
> The cause is the size comparison in ie_match_stat().  ie_modified()
> takes a difference between the file's size and the size recorded in
> the index as proof of a content change and returns without reading
> the file.
[snip] The following can be shortened, but I don't have a good suggestion
yet.

> The mtime branch of the very same function already reads
> the file and applies the conversion before deciding, so Git pays for ski=
p

"Git pays" ? May be: does the correct thing.

> the conversion-aware check in one branch and refuses to in the other.
>=20
> Patch 1 makes the size branch behave like the mtime branch whenever
> the path is subject to conversion.  Paths with no conversion take the
> existing early return untouched.  It also stops ce_compare_data()
> hashing a file whose converted length already differs from the size
> of its blob, since equal contents must have equal length; that is
> where most of the cost of the new check would otherwise go, and it
> helps the pre-existing mtime path as well.  When the end-of-line
> conversion is the only one that applies, that length comes from a
> scan for CR, and the file is not converted either.

Skip the rest: I don't think that an option turning this feature off
is needed.
Users which don't use CRLF conversion or any clean filters are not
affected by this path - or did I miss something ?
Users which use filters and/or CRLF should probably get the correct
answer from `git status`.
And yes, I think that this has happened to me as well - in my
case a tool insisting to replace 4 spaces with a TAB combined
with a clean filter that converted TAB into 4 spaces.
`git status` and `git diff` didn't agree, and I was never able to find
out why.

[snip]
> This was reported against Git for Windows [1], where Torsten suggested
> bringing it to the list.  It is not Windows-specific; anything with a
> clean filter runs into it, and Git LFS users on Linux see the same
> contradiction.

Yes.

>=20
> Built with gcc 15.2 on top of 6de20f6; each commit builds and passes
> on its own.  t0020 (with the new tests), t0021, t0026, t0027, t1300,
> t2106, t2200, t3700, t7508 and t0008 pass.
>=20
> [1] https://github.com/git-for-windows/git/issues/6410
I didn't dig deep into the code yet - that's for the future.
Thanks for working on this.

