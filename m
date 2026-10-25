Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792918967;
	b=Cyug9ONFEgo/6ugmn09Dkq3LVvF/smY7tK+0VPLWht9EYofy76yu34u7xb8+nny6w8l9
	 0D9tXMw0AuPZHnep/mG3CZD5E724hgaCNcA2EOPEUZhtvPIFu4p3Gx30h0EC7zHPIHZHs
	 9XrF9Gg7ZxK4ubdFfLQKQaZys4HoBSv2/Hp7Nh5s/mWuGliM7b3R5XWCkMhBlYT68t+SY
	 DTssHLKEa3ziUkOacKbpdkU1FyYtbyrNbJphPHqKeFFK8zMzIDrGVwZaO5qeeVPUE3hbn
	 aR1Mmf7l2ygbQasG1PgU+znDw8cVKgKWx3F0mUooyO3nj6gEHqQKfjOyY4d2G9y2Nkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792918967;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:User-Agent:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=MQ94rGjb4S6z56WV/pBY6BDhrYPFtbJ5T6R5IMpITLQ=;
	b=hMv67RgBTcUdORZveEcPW9eRIMTEBbwVOeYBefhK1IHTv7g1800e+xCZ+whVlE1enWVu
	 lvsOccpusbrEjKai4qkNz8EC8yETgo95CteqJNreDNFsyPuHqpk46V6YD5RnaPcBjYKYR
	 wwBjWMtoGb8JwCA0yjj0szMf2LUSN+KC3s0BevjaNjL0JhymsVraDZekuPoSNUwObJn6h
	 Kn3758Hc4L9dDU0Rp7lWB8fDun9/cvQINwsSXCS22qyY08a2hjbuLt/hL9/liekrqGLae
	 Kj0WRpgI8NCBdE0UE3OEKeenv14hLqe51O/qjG9ikXTUFCYn7WIUqrSzFSSKIX/p27w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=l5y3f1ZB;
	arc=none smtp.remote-ip=212.227.17.12
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91E5606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 09:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C91E5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=l5y3f1ZB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1792918963; x=1793523763; i=tboegi@web.de;
	bh=MQ94rGjb4S6z56WV/pBY6BDhrYPFtbJ5T6R5IMpITLQ=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=l5y3f1ZBS29bcBbKxNb9FXliK2eGZGSqJc1KZKNU1+EnCtPyFOwBoE7odCmxdRA5
	 8KtJmcHTQzYct8IVSPQox6WxKJ9EO0Y7MvPAxoX9Ge0a/E/65WBpoVI/uhqaeGsQ/
	 VN18CPpRf1TLwADlgWlPE3bURTl3BqtUAb/SHQeAdeGIELIDubb8l9H0oHPl4VvFg
	 gQPrNQh6O4Etw9GQheduYHfjojT0VBjg2Fqh0cx4ApXlxAxN4vjF8ZYwQh2/kfSXK
	 di+mghx6gCwdH16M/h2te9Clw97Awc4oNQRgDzI5xCd35aBjiFdQdp/b0A8G2x8AQ
	 tKSspEKogs1LdVeuDg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MODiN-1wwO3W2iJV-00OZBQ; Sun, 25
 Oct 2026 10:02:43 +0100
Date: Sun, 25 Oct 2026 10:02:42 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Tuomas Ahola <taahol@utu.fi>
Cc: git@vger.kernel.org, ps@pks.im,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/1] t1450: use mv -f when overwriting a read only file
Message-ID: <20261025090242.GA25750@tb-raspi4>
References: <atmvASAoaCIpc_ca@pks.im>
 <20261025043322.1766-1-tboegi@web.de>
 <20261025070641.GW33j%taahol@utu.fi>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261025070641.GW33j%taahol@utu.fi>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:9m841DdmacT0n+ak/yyW1LpXKADiyvSa+o2KThzKHbt9aqmy2j3
 W+CCSLiqR2B+v2wHjLeADyWcT8BK7bHTdBb6jlZR556i6q/sqWzl5PhKWCTwH4KMlXNZ0mG
 nCcPPl/WtVbn80/ipwWXIVErfeq6DFomva90heeiLmtkQ3Wq4XuCNPfi5oqov6TA+WNTxW+
 UOvZmC+aGsG119yJ5xVsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wYVvEotTU2A=;wmG/WnicjFkCynVMGe1jncb1ERi
 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

On Sun, Oct 25, 2026 at 09:06:41AM +0200, Tuomas Ahola wrote:
> tboegi@web.de wrote:
>=20
> > From: Torsten B=F6gershausen <tboegi@web.de>
> >=20
> > test case 38 in t/t1450-fsck.sh replaces a loose blob, "$tmp" below,
> > with a trucated version "obj.tmp" using
> >=20
>=20
> s/trucated/truncated/
>=20
> > mv obj.tmp "$obj"
> >=20
> > This fails on some sytems, like older MacOS.
>=20
> s/sytems/systems
>=20
> FWIW, it seems that the glitch was fixed in macOS 12.3 (file_cmds-353.10=
0.22).
>=20
> > `man mv`
> > includes this information:
> >   The following options are available:
> >   -f      Do not prompt for confirmation before overwriting the destin=
ation
> >            path.  (The -f option overrides any previous -i or -n optio=
ns.)
> > and further down:
> >   If the destination path does not have a mode which permits writing, =
mv
> >   prompts the user for confirmation as specified for the -i option.
> >=20
> > Running the test case in debug and verbose mode `./t1450-fsck.sh -d -v=
`
> > shows this lines (which I have shortened to fit into 72 characters)
> >=20
> > override r--r--r--  user/staff for .git/objects/fc/a75a5be3823dc0560da=
5?
> > (y/n [n]) not overwritten
> > fca75a5be3823dc0560da57ade678f212aeb33f6
> >=20
> > POSIX mentions that the observed
> > "prompt to standard error and read a line from standard input"
> > should not be done if "standard input is a terminal".
>=20
> This replaced "when" with "if" but the meaning didn't change.  The obser=
ved
> behavior shouldn't happen if the stdin is _not_ a terminal.
>=20
> > So we may blame the "standard input is a terminal" logic to fail.
>=20
> Well, macOS versions older than 12.3 just don't have that logic in mv(1)=
.
> Can nonexisting logic fail?  (If somebody is interested, the actual chan=
ge
> in 12.3 was
>=20
> @@ -265,12 +290,12 @@ do_move(const char *from, const char *to)
>  		} else if (iflg) {
>  			(void)fprintf(stderr, "overwrite %s? %s", to, YESNO);
>  			ask =3D 1;
> -		} else if (access(to, W_OK) && !stat(to, &sb)) {
> +		} else if (access(to, W_OK) && !stat(to, &sb) && isatty(STDIN_FILENO)=
) {
>  			strmode(sb.st_mode, modep);
>  			(void)fprintf(stderr, "override %s%s%s/%s for %s? %s",
>  			    modep + 1, modep[9] =3D=3D ' ' ? "" : " ",
>=20
> rather simple indeed.)
>=20
> >=20
> > Side note: Answering with 'y' to the question of `mv` like this
> > (echo y | mv obj.tmp "$obj")
> > makes the test case pass.
> >=20
> > To make things not too complicated use the most portable form
> > mv -f obj.tmp "$obj"
> >=20
> > Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>
> > ---
> >=20
> > Thanks to all reviewers.
> > Changes since V1:
> >   "should not be done when" -> "should not be done if"
> >   Fix "mv -v": it must be "mv -f"
> >=20
[]
> Thanks.
>=20
Thanks as well from my side - I will wait a little while before
sending out v3
