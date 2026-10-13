Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE17E4718E1
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914485; cv=none; b=l+2nVLyHHKPgPCif/8FLUMIB9oCQyaGP+wW5jhV0jco9AaMvg4nY7oSdYZoDib0bljR5CxAYBr1ifSiRuelIao7z1bPkzCldHK+8XspjPFWELGpi13FX/IiTG8zfmbCUlHvuJPnpl+gMiWcfbK5knKeB+EEOQGYpwNiwPz3AbH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914485; c=relaxed/simple;
	bh=/fw3TKDKSnmRNqg2SGiPAFDRBPE60eslLhZ5lDvF6cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFd+A3VayxkTjCsxHb5SH2LLTEaj2DxlJcDS7Vyy1MkUwlnrnFONiPhr/MCvy0qMYsj5UIpttYHIaST4gktnxQhfQjYxmZckpGZxKOOx9mnWSSODxwe5rTU+vLLdhO4oQsugY41/ZrgA90DEuS1/kxeWvuaqoUyw3lfC4AoYe9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=HJiVXG8q; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="HJiVXG8q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1791914477; x=1792519277; i=tboegi@web.de;
	bh=mE1HVbsOmWzAvkm2jj5ijCrLyJCVopFQD6RtMJHb/oA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HJiVXG8qp4uUJdXt0eT/Rqb7qn7drR4WBqGZY+BC9EwrEfxAKz0qwDBZcwGyI1Yo
	 z11Lqx2dvsaIIBiyQ8LOeEiy13klXSQ7rTbA5bN+oUSRgDGXPQxWvzlAbdqdyU6v1
	 bNIpFNXxWP1+4x5IxfsPQzRHIZIusggeoqbcKH0Ucokl2o2X4adhC9U0cqHtK/XYc
	 uSVDhOvwtlSR7oD0hn3cZelgEvmqVIgQrv8QUbVhLUw/o86AFyL4+1Js7eXeicnrY
	 iLzOBqJzaLf2X1vQvCP1t0wvS7U/gIGY9RwxKp/RDhcJZdLHm6CYTogYqnd+/+aG7
	 kLX09hSay1GwROdJ2w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N30ZL-1wViFc0vfR-013xik; Tue, 13
 Oct 2026 20:01:17 +0200
Date: Tue, 13 Oct 2026 20:01:16 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Curtis Allen Smith <curtis.allen.smith@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] read-cache: do not trust a size change when
 conversion is active
Message-ID: <20261013180116.GA26647@tb-raspi4>
References: <20261012175638.3712-1-tboegi@web.de>
 <20261013065915.879-1-curtis.allen.smith@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261013065915.879-1-curtis.allen.smith@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:XDdjLtI7tTQIUus/CxMgyx6TQEnihplxYntcqgK6vzW/v7UaPYy
 QKqf7kKXsztP1gpzAcUBrMShY1/bHTT6xGkQMhnSoeVzJpUSvlEFUgjj1hK2jjf07xSJJbk
 X90xn+rLp+Kga/qBnwvSgF9VkaUD/2Zw+DmV+YnUmxSMevZ87ExZDV+poEU2ifjTYorhG1w
 K3WeyEuT/9O4I0IqfExZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:djXNNon0fFE=;ta1cZl7yQipJ6iwnNYLC0wGBLxQ
 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
 =

On Tue, Oct 13, 2026 at 12:58:28AM -0600, Curtis Allen Smith wrote:

Thanks for the fast and good answers everybody.
As a comment: no, I didn't intend to tak over the series -
just want to move things forward.
And the Helped-By is of course ok.

I don't know if we need more explanations why this change
is needed (after so long time), but here is my undestanding:

When we run


git init t && cd t
printf 'one\ntwo\nthree\n' >file.txt
git add . && git commit -m init

followed by

printf 'two\ntwo\nthree\n' >file.txt

then Git will notice that the actual  mtime as a result of lstat()
is different from what is recorded in the index.
As a result, git needs to re-hash the content to conclude if the
content has changed.
However, in order to avoid the expensive hashing,
Git concludes that when the size of a file has changed
then the content -must- be different - files having a different size
are never identical.
This did work well until the .gitattributes feature was introduced.
Now, in the example below, a file having a different size -can-
result in the same blob once it is commited.
Therefore this patch does need to check if attributes
(for input conversions) are defined.
If not, take the shortcut and conclude that the file is modified.
But if, take the long way, which is what happens when only mtime
(and possibly other elements from struct st are changed.

And now the new size, mtime (and the rest)
will be recorded in the index. So it is a one-time cost.

Does this make sense ?


> "git status" can report a file as modified while "git diff" and
> "git add" agree that its contents are unchanged:
>=20
> 	git init t && cd t
> 	printf '* text eol=3Dlf\n' >.gitattributes
> 	printf 'one\ntwo\nthree\n' >file.txt
> 	git add . && git commit -m init
>=20
> 	printf 'one\r\ntwo\r\nthree\r\n' >file.txt
>=20
> 	git status --short      # ->  M file.txt
> 	git diff                # -> empty
> 	git add file.txt        # -> nothing to commit
>=20
> ie_modified() takes a change in the file's size since the index
> entry was last refreshed as proof that the file is modified, without
> looking at the contents.  A size change proves only that the bytes in
> the working tree changed.  When the path is subject to conversion
> (the "text" and "eol" attributes, core.autocrlf, a clean filter),
> different bytes can convert to the same blob, as the CRLF rewrite
> above does.
>=20
> For such a path, fall through to ce_modified_check_fs(), as is
> already done when only the mtime changed.  Paths without conversion
> return early as before.
>=20
> Helped-by: Torsten B=F6gershausen <tboegi@web.de>
> Signed-off-by: Curtis Allen Smith <curtis.allen.smith@gmail.com>
> ---
> Changes since v3:
>  - The fix is inlined into the condition in ie_modified(), with no
>    helper function.
>  - Shorter log message, using Junio's wording; the "real life"
>    examples are gone.
>=20
> Cost, i9-14900K under WSL2, warm cache, fastest of 5 runs of
> "git status -uno", stock 6de20f6 against this patch:
>=20
> 	10000 files x 2.6 KB, no conversion       stock      v4
> 	  clean tree                               5 ms     5 ms
> 	  10000 files with a size change          26 ms    24 ms
>=20
> 	10000 files x 2.6 KB, "* text=3Dauto eol=3Dlf"
> 	  clean tree                               5 ms     5 ms
> 	  10000 genuinely modified                25 ms   137 ms
> 	  10000 CRLF-rewritten, 1st run           21 ms   143 ms
> 	  the same, every run after               21 ms     5 ms
>=20
> 	200 files x 1 MB, "* text=3Dauto eol=3Dlf"
> 	  clean tree                               3 ms     3 ms
> 	  200 genuinely modified                   3 ms   498 ms
> 	  200 CRLF-rewritten, 1st run              3 ms   584 ms
> 	  the same, every run after                3 ms     3 ms
>=20
> The attribute lookup happens only for a path whose size changed, so a
> clean tree pays nothing, and a tree without conversion pays one
> lookup per size-changed path (the first block).  A converted path
> whose size changed is now read, converted and hashed, which is what
> already happens when only its mtime changes.  Stock git keeps
> reporting the CRLF-rewritten files as modified on every run.
>=20
> A follow-up that skips the conversion and the hash when the length
> already rules out a match is ready if wanted.  It takes the
> "genuinely modified" rows to 57 ms and 25 ms.

[snip]
