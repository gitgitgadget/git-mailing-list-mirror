Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7061C6AB
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="Fx17JPQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704307324; x=1704912124; i=tboegi@web.de;
	bh=h/nndAiFfF/bN5uNKqhMjHfqt1zkdAEleW03ryqx6CE=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=Fx17JPQaewCTOm0l+vvS0Q1n2/bM1dTNOx01BnMJywUTGstFO9noarQlDVw2+WL2
	 hpcGve3mErBSB103Vb6WJ5N6e8SCf/sl2KJheWVlqrMeHMOzr49BXe0rQl5qWkjHC
	 i4gAK8yqffb29mI68fjV9wsRn+OCJ8VeHXBa3U0s9R75sxxgGaxdUEfFLmW5RA1Dz
	 3pyUOHUM1+NVk74MM7uJE7/nw1TC4sJWf3oDLZuY3/CWhA3p4PNXZmwci2+xHysfx
	 nX+2gW7ZgD2MbhAQkRwzHR4jmKzU1tjBQ8+i+/pl6I7CKhlAvd/AdmXtGdUybtnkN
	 D0h4+Ab/L8oV3yU58A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNfYN-1raqgR2aK3-00Ouji; Wed, 03
 Jan 2024 19:42:04 +0100
Date: Wed, 3 Jan 2024 19:42:03 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Chandra Pratap <chandrapratap376@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v2] write-or-die: make GIT_FLUSH a Boolean environment
 variable
Message-ID: <20240103184203.GA4334@tb-raspi4>
References: <pull.1628.git.1703955246308.gitgitgadget@gmail.com>
 <pull.1628.v2.git.1704268708720.gitgitgadget@gmail.com>
 <ZZUZNQqDTx3bnveJ@tanuki>
 <ZZWWLkY+ixg+OMM4@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZWWLkY+ixg+OMM4@nand.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:562mt8K7gii+28r7an0dfS6zB8giZRLf2ggkRHQJCzUzfBRxNfy
 QWQvFanzFPsrbP6oVDcbEmihSOoUoEDPty8lIp5rmDNfq4xwhspBu4aG+boMr3ThdToqzDD
 cqjNQsuxkHeGG3xDGBGEESYKKybpVOV/MLpP2cFvdvw4rBW4WEdQi//l95JVg6HCnxoeeOS
 A/DW6lFASCQtHhiQK+WuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d7s+s9Ha9Jo=;RfqLI5g2mOD4u42h6NQaivRQv7k
 gNjyqdlc0H83i+MdefXWw4VPI6BPhLVYKpSkvSueSKOflrPw/3RQXxQXX5JZOLksomVK8O7+1
 /JWAeWA1FqP2wT/jk5XZYJgUWHgSwWUbEI6FpoBsF2bsqE9JLttlJW9UV00xtUGl6U9LrWaD2
 xis9yPTh3n/SJU85G6/53hQlviDAgNVrQRpAw+TTWEkNzYZ05mVQo81wa8BrggdtHluN4Oppl
 SYFm+bhmTMhmx1/9JMyLELWWN4b3u9OfSGm/URFYjN8SWMXh6yaGIHThU9vcqBIwXpzadFzvX
 WltC3izJ/2YzHGqJKz1qtsl3y2ijVapFqwWb7rLBcW4u0lDUxTvPhgfRBspBa8PGbkgLL/nbu
 Vq1PSSrlTLQEzPvy0xKxznUW5PBQEBQxcfjn3pnQ+Tyb4LIngpeQwBTVFXZ96eeAZvBEMk54e
 LpIOhiD7iWf+vBL+Cxb/BiucqD/dLQtvtTQM04IaSPE18rSG/8JkPfeiryL9M/LRDfVRvVI7H
 W21ZJHgTZOpY+lreVDeKv3EPUJ4hXZxxOugu9ekezUAE6DyH2E02AeTPBlOKjoSRlCPK2J/Og
 2VJtUv7MOjdB+4LayhbJ/shhKnxxvD9gcBgbG2Fl3ttDtWf833PP9Pb7cMRpQ9BeVZK3jk2wO
 1ezySjCNfp9e4Seth2z0JIKhai4qyAW1wOZrEZLfD4ObcM7TSam+IODlj4glsXY3JnIEHMh5W
 KQTRUOqPP+pRo9KOPpqA5o3bOCNnRzJKsvl883TGjvNrc8Czx+G2rLxKwASL4D0HPuY0/P0h9
 rTgNzlDHV4QBTENNJa34VAlFGv9mVtaHYhFwn/NnmSky5mkpzubOXPMr7sjt5DbkrzMubtODi
 NOFCZfkvXc/0YrU2lYxIzVEVRE/6W7rzSIzREp5xWEShjr+BowRTY2NyCT/gtVtk+UBxA20Du
 2YTkxMiAhNAKgkFvPaLIX7CqCA8=
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 12:15:26PM -0500, Taylor Blau wrote:
> On Wed, Jan 03, 2024 at 09:22:13AM +0100, Patrick Steinhardt wrote:
> > On Wed, Jan 03, 2024 at 07:58:28AM +0000, Chandra Pratap via GitGitGad=
get wrote:
> > [snip]
> > > diff --git a/write-or-die.c b/write-or-die.c
> > > index 42a2dc73cd3..a6acabd329f 100644
> > > --- a/write-or-die.c
> > > +++ b/write-or-die.c
> > > @@ -20,15 +20,12 @@ void maybe_flush_or_die(FILE *f, const char *des=
c)
> > >  {
> > >  	static int skip_stdout_flush =3D -1;
> > >  	struct stat st;
> > > -	char *cp;
> > >
> > >  	if (f =3D=3D stdout) {
> > >  		if (skip_stdout_flush < 0) {
> > > -			/* NEEDSWORK: make this a normal Boolean */
> > > -			cp =3D getenv("GIT_FLUSH");
> > > -			if (cp)
> > > -				skip_stdout_flush =3D (atoi(cp) =3D=3D 0);
> > > -			else if ((fstat(fileno(stdout), &st) =3D=3D 0) &&
> > > +			if (!git_env_bool("GIT_FLUSH", -1))
> > > +				skip_stdout_flush =3D 1;
> >
> > It's a bit surprising to pass `-1` as default value to `git_env_bool()=
`
> > here, as this value would hint that the caller wants to explicitly
> > handle the case where the "GIT_FLUSH" envvar is not set at all. We don=
't
> > though, and essentially fall back to "GIT_FLUSH=3D1", so passing `1` a=
s
> > the fallback value would be less confusing.
> >
> > Anyway, the resulting behaviour is the same regardless of whether we
> > pass `1` or `-1`, so I'm not sure whether this is worth a reroll.
>
> Hmm. If we pass -1 as the default value in the call to git_env_bool(),
> the only time we'll end up in the else branch is if the environment is
> set to some false-y value.
>
> I don't think that matches the existing behavior, since right now we'll
> infer skip_stdout_flush based on whether or not stdout is a regular file
> or something else.
>
> I think you'd probably want something closer to:
>
> --- 8< ---
> diff --git a/write-or-die.c b/write-or-die.c
> index 42a2dc73cd..f12e111688 100644
> --- a/write-or-die.c
> +++ b/write-or-die.c
> @@ -19,20 +19,17 @@
>  void maybe_flush_or_die(FILE *f, const char *desc)
>  {
>  	static int skip_stdout_flush =3D -1;
> -	struct stat st;
> -	char *cp;
>
>  	if (f =3D=3D stdout) {
>  		if (skip_stdout_flush < 0) {
> -			/* NEEDSWORK: make this a normal Boolean */
> -			cp =3D getenv("GIT_FLUSH");
> -			if (cp)
> -				skip_stdout_flush =3D (atoi(cp) =3D=3D 0);
> -			else if ((fstat(fileno(stdout), &st) =3D=3D 0) &&
> -				 S_ISREG(st.st_mode))
> -				skip_stdout_flush =3D 1;
> -			else
> -				skip_stdout_flush =3D 0;
> +			skip_stdout_flush =3D git_env_bool("GIT_FLUSH", -1);
> +			if (skip_stdout_flush < 0) {
> +				struct stat st;
> +				if (fstat(fileno(f), &st))
> +					skip_stdout_flush =3D 0;
> +				else
> +					skip_stdout_flush =3D S_ISREG(st.st_mode);
> +			}
>  		}
>  		if (skip_stdout_flush && !ferror(f))
>  			return;
> --- >8 ---

Thanks for a nice reading - I can not imagine a better version.
