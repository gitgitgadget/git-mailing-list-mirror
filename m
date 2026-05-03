Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226553126B1
	for <git@vger.kernel.org>; Sun,  3 May 2026 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777829333; cv=none; b=lxzUU/BQRZHyuo9xvMdo8OF7lhuCgOv6GZisfORtkO+kCVWyl/ty73LTgEDsNEvZfuQr45kgyhxsaQjvqLrRsPFOed9X9oGCGIClByUSoaf58M9DNOVWGSoRQ4IWbBfIsAQIOdNlWxe1TnUvFJCtOVo2lo7ELtB6y2s1DAN+Els=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777829333; c=relaxed/simple;
	bh=DQUK3qgidc8+W7pcZmSrcoeXFqelxafly3r9Ykmg63I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6ZDSKuI709sngzDVekrTtjJSnwaSlnNKlC6WxG8CBO1tnVRmew7icHoAi4lG8d4YIRQXU4EIwd755u7kGRZM6Rex9cj3CeOcugkXSXnhLm9ex5zdBmcSMyV3FpqOI6SFO7HI8ccUfk6cAo7VWnOwM5n/YADM4EttikQgHcAJqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=oKbBXETE; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="oKbBXETE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1777829318; x=1778434118; i=tboegi@web.de;
	bh=ClYRsgneEj1B+ztDTpI+1M9sL+ajoygrTMQZwa12acc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oKbBXETEoqBh7HGsJUYCRSUWnr9trLMrfklPvPw1ywKtXQSbWYnot3OKTFIRt+9Z
	 +44oE3KG4Vx91k3BE7FxEjJWOnZV1TldqxWMBsZHoIpeizavFw6EITbXQ3kazwxJs
	 nVNEDSTgNzPFHwEODcLImXlGVyqy8NQnch7OwOf1Daq+XLQ2l4zVZ/QGeKgOFMtzK
	 P1vmWhMayxEDrEN5s4Hr52/kAolkWcAIx020JEEiMgDhsxtyEso3v+XRf4iK47u/q
	 thoYu3BcT7zf0rmHfdDv9tDxxuRJbqAd/blJVPqbcjRtEb/FDPV2jwleiJqlxUrkt
	 hdmXBlgHNHBWPfYQkA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwA1O-1vRcSA387A-016dB5; Sun, 03
 May 2026 19:28:38 +0200
Date: Sun, 3 May 2026 19:28:38 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Matheus Moreira via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	Matheus Moreira <matheus@matheusmoreira.com>
Subject: Re: [PATCH v3 0/8] builtin: implement, document and test url-parse
Message-ID: <20260503172838.GA22957@tb-raspi4>
References: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
 <pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:PoIcKxiVYWyjUb/Xg128ejWiBgJVeDgjq0UCpJMNjbPxVPlxgnw
 Re4KH1wdIDyLL9cdDgPjEY7IxtL79bLJSZ4F6yO90QCNiDl5AYi6mxBXGYMB72RJWuprnlw
 42WC4/MaUY+SIKP7NaY6Trf1AXqLIDyL8tq9msUc0HtEhqAyPnB1U27qfA4Y/HpcVh5iMuO
 iPZawNQ5O2dE+TJl3ioCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NWuIEbI9Kr8=;05qD3UbKLOgslfzdfaKA21NIpIT
 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
 ZNU7H7yT0Zo3KtBUKCyiVNYSkdfSiVcrRfeM=

>=20
> The series consists of eight commits.

Reviewers comment: Nicely done.

> Changes since v2:
>=20
>  * Fix Windows CI failure: handle DOS drive prefix in the helpful local-=
path
>    error. With this, the message for a drive-letter input like C:/repo (=
or
>    an MSYS-mangled /abs/path that bash rewrites to D:/.../abs/path befor=
e
>    git sees it) gets the specific file:///<input> suggestion rather than=
 the
>    generic fallback. No effect on Linux or macOS, since has_dos_drive_pr=
efix
>    is a no-op on non-Windows builds.
>=20
>  * t9904: relax the grep on the absolute-path test from the literal
>    file:///abs/path to the structural file:/// (three slashes). The orig=
inal
>    assertion depended on the input being preserved verbatim, which MSYS =
does
>    not do. The relaxed grep verifies the structurally meaningful propert=
y
>    (specific URL suggestion was produced, not the generic fallback) and =
runs
>    cross-platform.

More a question to myself, may be, about t9904 (and may be other parts)
I have in mind that the parser learned to handle

file://server/share/repo
correctly under Windows.
I don't know if this needs to be addressed here or in a follow-up commit ?
The \\server\share\repo is an UNC name, which is handled by the
Windows file system, backslashes towards windows must be used (which we do=
)
and '/' may be used outside Git.


commit ebb8d2c90fb0840a0803935804e37e2205505f23
Author: Torsten B=F6gershausen <tboegi@web.de>
Date:   Sat Aug 24 15:07:59 2019 -0700

    mingw: support UNC in git clone file://server/share/repo
   =20
    Extend the parser to accept file://server/share/repo in the way that
    Windows users expect it to be parsed who are used to referring to file
    shares by UNC paths of the form \\server\share\folder.
   =20
    [jes: tightened check to avoid handling file://C:/some/path as a UNC
    path.]
   =20
    This closes https://github.com/git-for-windows/git/issues/1264.
