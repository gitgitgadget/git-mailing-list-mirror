Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AA93A1E6A
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768592322; cv=none; b=n3iI3bJRbmGypdBIi3g1L2m0ZpZO1L0L5KCea+9dz76xTlYEUSUPuhCEgyyEAte4WeK18ADKotoo23Gb2tPJZoXoKrJPp59Ks+oYYdhWobD1C36NCkACu+KQu1i2AaquOk34kupfssugo6hhFtUpw3Ua0PFFLKtvb0jAZFgGvvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768592322; c=relaxed/simple;
	bh=IjEVnT5LhJ5zQieDCNrCZJ1bk7k3sYvTJAz2nkFsJdI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HCsuBRRmUAllHt818Dptr0kPpj6cXnVwVZVGccpnkn8w3aojF763HshlyFUmxns61j7+NLkbhxZn5srDKcUprMRi/A9KnU2VnjgotsA/sKGLIyRMIBz9qSSVFqBwfHTjNZfeFQYhjeBq1a7PtkGvW4ykEZ0pPwsH8g8NF+CoiwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=aLK9VEVJ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="aLK9VEVJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1768592304; x=1769197104;
	i=johannes.schindelin@gmx.de;
	bh=gxQyOJjCjhp7tHXq7Oj2Iy42nOP4EkLg153yGa0zukU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aLK9VEVJDdC2ymS/usm+/DFVSFroXUIugwT0/yCVTwpIZgHeDEEwaLqeh84+801H
	 GxKrUFLma0sb0tkcx4xUH0/iDH+Q4CdoYqVnsQhm0+gxeWJextS9pX9s3Hy5ELS29
	 fQO1LyCaoT8I2Uc3qUNjCY8IxzkSrrJY8VRPBNbuh6EugFlMbgEaokGUf6YUkhYK3
	 zU6oL+R5wQD0nmmNOpEeFr1nPpMcp/atv66vkaCPuzwaVD03cis6wRJZD9egBHbTd
	 etlp/ZgDlNUYvFA7aEh6FeFqyybpWWenYzWdgKYPotadJ4Vukr89jCf1AiaRLl8j/
	 8zTtNzUMxYBMgW9MXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.21]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyuc-1w3IRi0U5e-00qsBo; Fri, 16
 Jan 2026 20:38:24 +0100
Date: Fri, 16 Jan 2026 20:38:22 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Andreas Schwab <schwab@linux-m68k.org>, 
    Ondrej Pohorelsky <opohorel@redhat.com>
Subject: Re: [PATCH v2 3/4] sideband: do allow ANSI color sequences by
 default
In-Reply-To: <aWD2wpyOo0Tr34OD@pks.im>
Message-ID: <53ed8f19-7084-b9ab-ca4c-cd558b75c1fc@gmx.de>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com> <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com> <44585ba1f4223f053820d82f1513c2258e1e0059.1765981422.git.gitgitgadget@gmail.com> <aWD2wpyOo0Tr34OD@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QSdrVl4Avm2U3yxzhw0YSwZ0MlrlH5XbLKGpEovcOK3aQn7w/AF
 pc65B1C3ox9e5QqITQEklxAYoHVSA69XhCKKNTgYdpwHAiJkLCjvoj0iCmjWpaGMF+ZggPN
 h6Tksl2jIq69f/3U5eSY+7Phlj5JQs4pcffco6O15g3CGqh4Jx34bpmIEWuSq0wmDFH6csa
 VISxy414SBYxhGElIG0MQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:69FCa7UyGlI=;hs7EPXGGPXy2+UH1jgvY3jkXVC3
 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
 3iYtPBf4O5On+yWWhAI5TyVt+P+mp
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Fri, 9 Jan 2026, Patrick Steinhardt wrote:

> On Wed, Dec 17, 2025 at 02:23:41PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > The preceding two commits introduced special handling of the sideband
> > channel to neutralize ANSI escape sequences before sending the payload
> > to the terminal, and `sideband.allowControlCharacters` to override tha=
t
> > behavior.
> >=20
> > However, as reported by brian m. carlson, some `pre-receive` hooks tha=
t
> > are actively used in practice want to color their messages and therefo=
re
> > rely on the fact that Git passes them through to the terminal, even
> > though they have no way to determine whether the receiving side can
> > actually handle Escape sequences (think e.g. about the practice
> > recommended by Git that third-party applications wishing to use Git
> > functionality parse the output of Git commands).
> >=20
> > In contrast to other ANSI escape sequences, it is highly unlikely that
> > coloring sequences can be essential tools in attack vectors that misle=
ad
> > Git users e.g. by hiding crucial information.
>=20
> The worst that they can do is to set up both fore- and background color
> to be the same so that text isn't visible. But I think that's an okay
> tradeoff.

Indeed.

The major concern here is to hide the fact from the user that Git already
exited and that what they see in their terminal is not actually Git asking
them to input something.

Technically, this would be possible by setting the text to "invisible"
(which would be a fine thing when pretending to ask for a password,
anyway). But without the ability to move the cursor, attackers will have a
much harder time to cover their tracks.

> > Therefore we can have both: Continue to allow ANSI coloring sequences =
to
> > be passed to the terminal by default, and neutralize all other ANSI
> > Escape sequences.
>=20
> Makes sense.
>=20
> > diff --git a/Documentation/config/sideband.txt b/Documentation/config/=
sideband.txt
> > index 3fb5045cd7..e5b7383c7a 100644
> > --- a/Documentation/config/sideband.txt
> > +++ b/Documentation/config/sideband.txt
> > @@ -1,5 +1,17 @@
> >  sideband.allowControlCharacters::
> >  	By default, control characters that are delivered via the sideband
> > -	are masked, to prevent potentially unwanted ANSI escape sequences
> > -	from being sent to the terminal. Use this config setting to override
> > -	this behavior.
> > +	are masked, except ANSI color sequences. This prevents potentially
> > +	unwanted ANSI escape sequences from being sent to the terminal. Use
> > +	this config setting to override this behavior:
> > ++
> > +--
> > +	default::
> > +	color::
> > +		Allow ANSI color sequences, line feeds and horizontal tabs,
> > +		but mask all other control characters. This is the default.
> > +	false::
> > +		Mask all control characters other than line feeds and
> > +		horizontal tabs.
> > +	true::
> > +		Allow all control characters to be sent to the terminal.
> > +--
>=20
> Nit: I think that our modern doc style requires the values to use
> backticks. E.g. "`default`::".

Will change.

> > diff --git a/sideband.c b/sideband.c
> > index 997430f2ea..fb43008ab7 100644
> > --- a/sideband.c
> > +++ b/sideband.c
> > @@ -40,8 +45,26 @@ static int use_sideband_colors(void)
> >  	if (use_sideband_colors_cached >=3D 0)
> >  		return use_sideband_colors_cached;
> > =20
> > -	git_config_get_bool("sideband.allowcontrolcharacters",
> > -			    &allow_control_characters);
> > +	switch (git_config_get_maybe_bool("sideband.allowcontrolcharacters",=
 &i)) {
> > +	case 0: /* Boolean value */
> > +		allow_control_characters =3D i ? ALLOW_ALL_CONTROL_CHARACTERS :
> > +			ALLOW_NO_CONTROL_CHARACTERS;
> > +		break;
> > +	case -1: /* non-Boolean value */
> > +		if (git_config_get_string_tmp("sideband.allowcontrolcharacters",
> > +					      &value))
> > +			; /* huh? `get_maybe_bool()` returned -1 */
>=20
> This case is something that shouldn't happen in practice because we know
> that the config ought to exist. I guess it _could_ indicate a race
> condition, even though it's extremely unlikely to ever happen. So I was
> thinking about whether we want to `BUG()` here, but I guess just
> ignoring this is fine, as well.

I don't think that we can even get into a race condition because the
config is cached after it is read.

> > @@ -70,9 +93,41 @@ void list_config_color_sideband_slots(struct string=
_list *list, const char *pref
> >  		list_config_item(list, prefix, keywords[i].keyword);
> >  }
> > =20
> > +static int handle_ansi_color_sequence(struct strbuf *dest, const char=
 *src, int n)
> > +{
> > +	int i;
> > +
> > +	/*
> > +	 * Valid ANSI color sequences are of the form
> > +	 *
> > +	 * ESC [ [<n> [; <n>]*] m
> > +	 *
> > +	 * These are part of the Select Graphic Rendition sequences which
> > +	 * contain more than just color sequences, for more details see
> > +	 * https://en.wikipedia.org/wiki/ANSI_escape_code#SGR.
> > +	 */
> > +
> > +	if (allow_control_characters !=3D ALLOW_ANSI_COLOR_SEQUENCES ||
> > +	    n < 3 || src[0] !=3D '\x1b' || src[1] !=3D '[')
> > +		return 0;
>=20
> This would break in case `allow_control_characters` allows _all_ ANSI
> sequences. But that doesn't matter right now because the function is
> only called via `strbuf_add_sanitized()` when we're sanitizing at least
> some characters.
>=20
> Might be worth though to add a call to `BUG()` in case we see an
> unsupported value for `allow_control_characters`.

Later patches change the logic, though, to make `allow_control_characters`
a bit field. So maybe it can be left as-is here?

>=20
> > +	for (i =3D 2; i < n; i++) {
> > +		if (src[i] =3D=3D 'm') {
> > +			strbuf_add(dest, src, i + 1);
> > +			return i;
> > +		}
> > +		if (!isdigit(src[i]) && src[i] !=3D ';')
> > +			break;
> > +	}
>=20
> Okay, so this loop scans until we find the final "m" character that
> terminates the sequence. Looks good to me.

Thank you for your review!
Johannes
