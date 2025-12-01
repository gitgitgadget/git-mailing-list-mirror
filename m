Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD07230BB94
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764595664; cv=none; b=C/5ty4mIX6GoUM65a3Ml1SRpP/JhM5U2bN6iBr5tyZzHlmdRnnZwq+u1Nmf7L3yo0yN9FFsle97+VruF9hFE1YPiefCk8LmR/m7PdB3KpaKoP2H30WbiEExFt7at86cDdCWFkhldb1UubmFsEsKKLUBKAAgg1fR3Z7Fbqk3TpG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764595664; c=relaxed/simple;
	bh=P9XEZJKBCcyC6Wli71E3a2bl9g6DeMEn0UowMJmfoj8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=j2Y9UHfe8DZYbN/L4jY3Bc0MVLz4n2Dqqou7k4YsOCfUY5jBehwCb7CZOifjdnGzfAed53X7StaI+CqzOslZ7+1anflyzBLkU0WQYIqdMMhvtgwEt01PzIRll86HlHW51/T6XNhHg72QEM+S1bgdBDysmjElg8Uzxc8cs4+kJpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=U8DW7U9h; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="U8DW7U9h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764595657; x=1765200457;
	i=johannes.schindelin@gmx.de;
	bh=pUPo64XRX1v9ven/17nc1VBE/jy360Ai1TajO2UbDlA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=U8DW7U9hRRRYjj+iR1G5PTdYjDEvUHc1d3gSQEGvnZtuSEdvwRBdfTzqXgG0xTd/
	 mNb7/U4whP/WGur11opOejwCzOiIZzSrmd49fi8Vuapg4325JEe9TAEXUusc0l4l1
	 VTz/Txemy/V2f4RcYneXQCVoFioyCCNi9kmrIzMgwgAdGcOZDvUtE7xNUAVoF3r6g
	 cceE8PjyKaIHYXuiUv9UvWCq6mh47D2h0lkbuxKqA9+py1e/zcdRwg4gb/zY49bEO
	 WW5ZEgP2WPSCx6VAnNFRtd3w0lCdR2UqWfolfaBr5H09y/FjoTOr8u3/SQMlH0rGz
	 XlN2Yf/mAxYzKtdskg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.165]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mjj8D-1voRCk1Kl1-00idw7; Mon, 01
 Dec 2025 14:27:37 +0100
Date: Mon, 1 Dec 2025 14:27:35 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 06/10] t0600: fix incomplete prerequisite for a test
 case
In-Reply-To: <aS1kEb2dvLU-7FnM@pks.im>
Message-ID: <70fe338c-8802-324f-ca5a-d3ba369ea661@gmx.de>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com> <0866db0a17d88016617e7e626dc032af599679c8.1764440906.git.gitgitgadget@gmail.com> <aS1kEb2dvLU-7FnM@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:R+gUi6RZAmVm6dZ+xkYVLtX1oAAQ0gM3Qwg5prLIdSxtRv5hxHT
 sIknnBUgdl+ob3TQhNBTeWspvzL5gdJMdtqM7Nm3IzF1tHHKjl59uTghfWg2PIXnuFMLRux
 G8DF80UeFocLE5yydkUzDxj6Qq+Mf3jQaR1PZWLWGEGyUFqmydN0EA5XWskVaMWh1DFzP9q
 et97cn8uOebSrSiugTW0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Oer9xAkpwEo=;Rs68kIvyp1oD3Em8IMovXmNIwp8
 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
 8eIy5IZM=
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, 1 Dec 2025, Patrick Steinhardt wrote:

> On Sat, Nov 29, 2025 at 06:28:22PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > The 'symref transaction supports symlinks' test case is guarded by the
> > `SYMLINK` prerequisite because `core.prefersymlinkrefs =3D true` requi=
res
> > symbolic links to be supported.
> >=20
> > However, the `preferSymlinkRefs` feature is not supported on Windows,
> > therefore this test case needs the `MINGW` prerequisite, too.
> >=20
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/t0600-reffiles-backend.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
> > index b11126ed47..74bfa2e9ba 100755
> > --- a/t/t0600-reffiles-backend.sh
> > +++ b/t/t0600-reffiles-backend.sh
> > @@ -467,7 +467,7 @@ test_expect_success POSIXPERM 'git reflog expire h=
onors core.sharedRepository' '
> >  	esac
> >  '
> > =20
> > -test_expect_success SYMLINKS 'symref transaction supports symlinks' '
> > +test_expect_success SYMLINKS,!MINGW 'symref transaction supports syml=
inks' '
> >  	test_when_finished "git symbolic-ref -d TEST_SYMREF_HEAD" &&
> >  	git update-ref refs/heads/new @ &&
> >  	test_config core.prefersymlinkrefs true &&
>=20
> Makes sense. There's a couple more cases where we set this config key:
>=20
>   - In a subsequent test in t0600, but there we explicitly set it to
>     "false". So this would naturally be supported by Windows.
>=20
>   - In t7201 we set the value to "yes", but we never verify that the
>     written reference is a symbolic link in the first place. I guess
>     that we could rather remove setting the configuration value here, as
>     we are about to deprecate support for symrefs via symbolic links in
>     the first place. But that's certainly outside of the scope of this
>     series.
>=20
>   - In t9903 we do the same, but likewise, we don't check whether the
>     written file is a symbolic link.
>=20
> So yes, this seems to be the only instance where we actually need to
> adapt tests.

Thank you for doing my homework. I meant to jot it down in my TODO list as
something that I needed to check before sending the series, but I forgot
to jot it down and therefore forgot.

Thanks again!
Johannes
