Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A851DFC5
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708297953; cv=none; b=Ay/7olI2YsNS6lrOFUUWz7F3SvaHdIV0oVr5A+5BpkmqPrxf3yz35BQVxRb5Ez67V13YKWw2GRWGkJT9+ydz4RKZkhFfBvyYU+r69rCM/hWUHYITuwroWxCLQIb1Q134SEkPDD2cNWAeZm31wBB4H5NPTshRHh3fNzG/nwN+lNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708297953; c=relaxed/simple;
	bh=dcH46hC4cTwu3+WMxZPp5leWfM9xlODSC+tuixyj2e0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MhOoPXHokeLI0oYnw2PJdbtxZcUteWA1Vtvsxud6RQ1/f5Lz4rHquzU43TP7X7SGcqQ4rurW+UZ3q0O7yCJeT4WX305XONqeTDGAW+sgSirxsKtbtu6THbfs7U4S44atS8yXC4VO4btqLBOzNYYb2dbYT0BOgTcLov0mZZdZUkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=fbO6E6Rw; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="fbO6E6Rw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708297935; x=1708902735; i=johannes.schindelin@gmx.de;
	bh=dcH46hC4cTwu3+WMxZPp5leWfM9xlODSC+tuixyj2e0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=fbO6E6RwgvI64288HoUXcaV8xv9KDheJKnROGcsqgJnMQiK1K8lCCcbLrdE7pkGW
	 /1e1FnVTMmDWQdLnhb1KQ34ekSM49K0jFBNGLXjFcr9A8m0mAUwH36IGPIVqwKgQs
	 ruf3JYDYbkiH0dZhJFErjjdPTizyO4ZRLYAk3NvCH/s5Ju1OR9HYER5pILHBuq12k
	 ETe6hWDlrHwQb+toMch8+nVAsKQKoQAJXVYYN0IMrFfoW6dofJ3ZBMeiLQKORQztY
	 KbFQt3eIG+PTlZWnELanz76JONqNzeIsXcv7QivVSqvZu9v++Fu+rCBOVR+PKL5uJ
	 XmqlxwbQftM/VRESKQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.214.170]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwwZX-1qiVee1pnv-00yQ0n; Mon, 19
 Feb 2024 00:12:15 +0100
Date: Mon, 19 Feb 2024 00:12:13 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>
cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>, 
    Michael Litwak <michael.litwak@nuix.com>, 
    "brian m. carlson" <sandals@crustytoothpaste.net>, 
    "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Suggested clarification for .gitattributes reference
 documentation
In-Reply-To: <DB9P250MB0692C605DFA88572D091D959A56E2@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
Message-ID: <a913cecc-3b99-e3e7-95b9-de145f7bafdf@gmx.de>
References: <SJ0PR10MB569379A093B83BE01A04C789FA6F2@SJ0PR10MB5693.namprd10.prod.outlook.com> <ZaG0EkADl8hQZaqf@tapette.crustytoothpaste.net> <SJ0PR10MB56937175632E5D82793CE13EFA6F2@SJ0PR10MB5693.namprd10.prod.outlook.com>
 <SJ0PR10MB56932ABBEEEC6F8ADE23995AFA6E2@SJ0PR10MB5693.namprd10.prod.outlook.com> <20240113074323.GA6819@tb-raspi4> <DB9P250MB0692C605DFA88572D091D959A56E2@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-758353182-1708297935=:504"
X-Provags-ID: V03:K1:4TtVDUAKjUgM5axR64Kd54po++FmNZIiJyDp83dFaiI4otwZfma
 a4W9HFqGOgUevEpyZWiZIAlpBs5GwJ78UXqy9YbRMonulvQwK0S4LhDuTC8qdk4wL1opDu6
 uyF0qWSKLS/WRlRKlxrtcWP5EgvSQDJBWTaenIUvegacH8f5U5WBH4XDd1YdX+25KOrVQGr
 W5KZhjx8bkr3Acd8twtFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DZwcsb59pK4=;4whFTtTkqn3XejywFyDNskjh5z6
 WQ0Ufvqol9D5YVQUxVi9gx5Lpxt9jQw6jVviVthr/aRJMKhPtkyswyYuL7AuOzk5xgEq8Bp4P
 fqskhINtwsbChShr5DySG2r3z5nZatsn7RcIOWgHyH3wGp4bavezhvdsr8mlKyYbsgIKm4Pzi
 59mzQ8b2WcBa5DL7G11gB7rbK/svdd2fy5btvhDBfkzP6wih4k2Nlpnt7ewEsOO0sis7f+HP6
 qAg+fB3FEpwHB+mP7DLxkyHb5Flbn5Asf/RyRwfvl4oZvuE8n7AmRgU9wnvTe/Ltj3PwbJVIb
 dlM5ec2GENd6+p3z2JPt4sm1z6knWUBi+2rvBCocogQYx0ficbi6WnSxI8zCU6ZSFkRC1HUdF
 ujxaz7esoQ4RW6wcAFtyeGJ/cFBowe6afjVJY2Xpb10wPaZwlpQXxh16kyt82dW5g2wku+t2N
 +cvRtJhIcAwZAluvI+PBuZVAT+hjHo+jj5N9pfAcPJ3fi+Ozl7o/4Hk/ubJUxA7zZj13iXQ1T
 Fp60qasXKehmypz/UzP4x0k/WTL5rkbd9yt33NZkBgSP+wGcOVOYKi6IEkDXlMg+UZI+l1TAM
 zV87ub9ZohPpyAImCz5//szd3hstDxre4Nd8PQY5ZYHja1eI7XBi6YXt2QGxQh5R0PZjjooA4
 JtCzgrBg51StPMN/e0g4bRAdKMoiyeJmkZG2nKzUCdMNFAi+GlsEXt5WY96Rd2r/FYr+In1AJ
 6MzKIijsQvAbFV3UYAx0k0CHIlnkNeVyl3YCveHPQLal8Qzi7CA3z7iKqdSpuI2p9in37hr2t
 WAVXW2iZIEEJ+u8tP97oSyrBnh6B0kldP93jLVpR78FnU=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-758353182-1708297935=:504
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, 13 Jan 2024, Matthias A=C3=9Fhauer wrote:

> On Sat, 13 Jan 2024, Torsten B=C3=B6gershausen wrote:
>
> > On Sat, Jan 13, 2024 at 02:56:27AM +0000, Michael Litwak wrote:
> > > I just installed Git for Windows 2.43.0 and noticed the installer of=
fers
> > > three options for altering the PATH:
> > >
> > > 1) Run git from git bash only
> > >
> > > 2) Run git from git bash, cmd.exe and PowerShell (RECOMMENDED)
> > >
> > > 3) Run git from git bash, cmd.exe and PowerShell with optional utili=
ties
> > > (warning: will override find, sort and other system utilities).
> > >
> > > It turns out iconv.exe is accessible from cmd.exe (Command Prompt) o=
nly
> > > when you take the third option.  But iconv.exe is NOT optional.  It =
is
> > > required for git to deal with UTF-16LE with BOM text conversions (an=
d
> > > probably for numerous other encoding conversions).
>
> For end users directly calling iconv.exe is definitely optional.
>
> > Plese wait a second - and thanks for bringing this up.
> > To my knowledge the binary iconv.exe (or just iconv under non-Windows)
> > is never called from Git itself.
> > Git is using iconv_open() and friends, which are all inside
> > a library, either the C-library "libc", or "libiconv"
> > (not 100% sure about the naming here)
>
> Exactly. I can't find a single instance of Git for Windows calling iconv=
.exe
> instead of using the corresponding library functions. [1]
>
> And even if it did, iconv.exe is definitely on the path for git.exe [2] =
unless
> you're calling /(mingw|clangarm)(64|32)/bin/git.exe directly, in which c=
ase
> the solution is to call /cmd/git.exe instead.

Just a quick addition to this: _even if_ you happen to call
`/*[63][42]/bin/git.exe` directly, the `PATH` is adjusted (unless
`MSYSTEM` is set, which would indicate a pilot error without the
corresponding `PATH` components such as `/usr/bin`):
https://github.com/git-for-windows/git/blob/v2.43.0.windows.1/compat/mingw=
.c#L3529

Ciao,
Johannes

> [1]
> https://github.com/search?q=3Drepo%3Agit-for-windows%2Fgit%20iconv%20NOT=
%20path%3A%2F%5Et%5C%2F%2F%20NOT%20path%3A%2F%5EDocumentation%5C%2F%2F&typ=
e=3Dcode
> [2]
> https://github.com/git-for-windows/MINGW-packages/blob/0c91cf2079184ae6a=
604e8f7a406a47d39305e72/mingw-w64-git/git-wrapper.c#L166-L258
>
> > iconv.exe is not needed in everyday life, or is it ?
> > If yes, when ?
> > iconv.exe is used when you run the test-suite, to verify
> > what Git is doing.
> >
> > Could you elaborate a little bit more,
> > when iconv.exe is missing, and what is happening, please ?
> >
> > >
> > > But when PATH option #2 is chosen, and iconv.exe is unreachable from=
 a
> > > Windows Command Prompt, the git commands which call upon iconv.exe d=
o NOT
> > > indicate the error.  The call to iconv.exe fails silently.  It is on=
ly
> > > later after you commit, push and clone the repo again that you see t=
he
> > > encoding failures.
> > >
> > > And the warning about overriding find and sort must be taken with a =
grain
> > > of salt, since the Windows versions of those programs are accessed v=
ia a
> > > Windows folder which appears earlier in the PATH.
>
> We should probably consider rewording that warning.
>
> > > So this Git for Windows installer screen is misleading.  And perhaps
> > > iconv.exe should be relocated so it is accessible even when PATH opt=
ion #2
> > > is chosen.  I intend to submit an issue on the Git for Windows issue
> > > tracker regarding this.  I'll also submit an issue about the lack of=
 an
> > > error when running 'git add' for a UTF-16LE with BOM file under PATH
> > > option #2.
> > >
> > > Thanks,
> > > - Michael
> > >
> > []
> >
>
>

--8323328-758353182-1708297935=:504--
