Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0083939A4
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768592866; cv=none; b=KxE1z+O4nl3jQyWS+NM1PxcX6EjKod0Hi+hhnJcsu2QtOLcmvS3Q745LWRlhWfr7VJLeIl/qaY/nigXXWUPrQarWOPPgrCI5fuhaT2Hl1VuceeEqK2OYK9mmZr3/ZJ1+ojd6drmvpnlKZs7qY3wyQgU8Q6g7NpsX5YC/5zfzemY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768592866; c=relaxed/simple;
	bh=wAss/k/iQWkOlKYZ1mHFihXgT+ngCvjuliIdfrPVI+Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tHbh1r966I6+onG7qU3aZlDcIrmdvdg8vX1ivc5bJADroqoAYoJfXZcmPlxB9OyppJbQdX6SzAowAt3ai34DvPkKf1Tdhp8oD7dbJxzSb8c+cbJXJDGxxjBS28+r3TuW9VA74pzrGEXLkucawzCe9+ibgQe4bR9I7ixPz9LEhsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=dgYwKLhB; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="dgYwKLhB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1768592861; x=1769197661;
	i=johannes.schindelin@gmx.de;
	bh=CM/x3rSbFGXwh1QLOJabHnRqOx7A0LiUE6FjhYOjbeA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dgYwKLhB6YQ7ky1BNQ8KYdttFNF1C/G7KOoaa0UhsdFHqu2gsFyR0I7aJzezWo1d
	 9fgJGTQl6EkPP7lZUXXyXOs+aFlQoLPXu6XsxDPUktOxBkQDkxQawL+795RbvCYZM
	 /2UMNQamcnEYjrAg/z8ShQGCsId/2+e7JjG9rIqSHaaSHTUAGTxk3EFCtKWvCvsfG
	 h+4nenay/tR0n2wmn3X7kOjS70COh6uYmxK8rUsMY2Ws1owPmzXUu2TblFuFfaYRp
	 nPAFpMHuH6hv04mrK4uYalL8mlikv+dGrpCTW6CJafM5xS96YtQr260YyEUAahOU+
	 +POoAeETvkG6Y4MnAA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.21]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoNC-1vd02t2Y7C-008yp1; Fri, 16
 Jan 2026 20:47:41 +0100
Date: Fri, 16 Jan 2026 20:47:39 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Andreas Schwab <schwab@linux-m68k.org>, 
    Ondrej Pohorelsky <opohorel@redhat.com>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
In-Reply-To: <aWD2x154F5f-c3pL@pks.im>
Message-ID: <bb319446-a655-42b7-00b4-581fb9290843@gmx.de>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com> <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com> <fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com> <aWD2x154F5f-c3pL@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3cHtXke/KZx0Kiy77qnTb9h+1tsqR4b38zOEUScw1yvsCGa7dhF
 H2S8kp46MQz4dpKtXsxhUGFSHp6M/QViXUz3g/K4w777Lee0yzKIdDdpMNqMSct96APT9mW
 zLWymQMo8NiAyi2jCZp5jlWMwZCMj4flMHBxcTIct/wEbX9AFtaCDi+pQtYpByzmGMmpNoG
 JKAntEEAB9X/jS16flU+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s2NCMOQ3gXw=;jTeaXl3VHiQc95nSW3/phgztDA3
 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
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Fri, 9 Jan 2026, Patrick Steinhardt wrote:

> On Wed, Dec 17, 2025 at 02:23:42PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > Even though control sequences that erase characters are quite juicy fo=
r
> > attack scenarios, where attackers are eager to hide traces of suspicio=
us
> > activities, during the review of the side band sanitizing patch series
> > concerns were raised that there might be some legimitate scenarios whe=
re
> > Git server's `pre-receive` hooks use those sequences in a benign way.
> >=20
> > Control sequences to move the cursor can likewise be used to hide trac=
ks
> > by overwriting characters, and have been equally pointed out as having
> > legitimate users.
> >=20
> > Let's add options to let users opt into passing through those ANSI
> > Escape sequences: `sideband.allowControlCharacters` now supports also
> > `cursor` and `erase`, and it parses the value as a comma-separated lis=
t.
>=20
> Hm, okay. I don't really see much of a reason to allow these, but now
> that the code exists already I don't see a reason why we should remove
> those options again.

I agree that the feedback that elicited this patch did not specify any
concrete use case where this might be necessary. I basically implemented
this only to alleviate the reviewer feedback more than any real-world
issue.

>=20
> > diff --git a/sideband.c b/sideband.c
> > index fb43008ab7..725e24db0d 100644
> > --- a/sideband.c
> > +++ b/sideband.c
> > @@ -28,9 +28,43 @@ static struct keyword_entry keywords[] =3D {
> >  static enum {
> >  	ALLOW_NO_CONTROL_CHARACTERS =3D 0,
> >  	ALLOW_ANSI_COLOR_SEQUENCES =3D 1<<0,
> > +	ALLOW_ANSI_CURSOR_MOVEMENTS =3D 1<<1,
> > +	ALLOW_ANSI_ERASE =3D 1<<2,
> >  	ALLOW_DEFAULT_ANSI_SEQUENCES =3D ALLOW_ANSI_COLOR_SEQUENCES,
> > -	ALLOW_ALL_CONTROL_CHARACTERS =3D 1<<1,
> > -} allow_control_characters =3D ALLOW_ANSI_COLOR_SEQUENCES;
> > +	ALLOW_ALL_CONTROL_CHARACTERS =3D 1<<3,
> > +} allow_control_characters =3D ALLOW_DEFAULT_ANSI_SEQUENCES;
>=20
> Nit, not worth addressing on its own: readability would be helped a bit
> if the assignments were all aligned.
>=20
>         static enum {
>                 ALLOW_NO_CONTROL_CHARACTERS  =3D 0,
>                 ALLOW_ANSI_COLOR_SEQUENCES   =3D 1<<0,
>                 ALLOW_ANSI_CURSOR_MOVEMENTS  =3D 1<<1,
>                 ALLOW_ANSI_ERASE             =3D 1<<2,
>                 ALLOW_DEFAULT_ANSI_SEQUENCES =3D ALLOW_ANSI_COLOR_SEQUEN=
CES,
>                 ALLOW_ALL_CONTROL_CHARACTERS =3D 1<<3,
>         } allow_control_characters =3D ALLOW_DEFAULT_ANSI_SEQUENCES;

I like that suggestion. Will change it.

> > +static inline int skip_prefix_in_csv(const char *value, const char *p=
refix,
> > +				     const char **out)
> > +{
> > +	if (!skip_prefix(value, prefix, &value) ||
> > +	    (*value && *value !=3D ','))
> > +		return 0;
> > +	*out =3D value + !!*value;
> > +	return 1;
> > +}
> > +
> > +static void parse_allow_control_characters(const char *value)
> > +{
> > +	allow_control_characters =3D ALLOW_NO_CONTROL_CHARACTERS;
> > +	while (*value) {
> > +		if (skip_prefix_in_csv(value, "default", &value))
> > +			allow_control_characters |=3D ALLOW_DEFAULT_ANSI_SEQUENCES;
> > +		else if (skip_prefix_in_csv(value, "color", &value))
> > +			allow_control_characters |=3D ALLOW_ANSI_COLOR_SEQUENCES;
> > +		else if (skip_prefix_in_csv(value, "cursor", &value))
> > +			allow_control_characters |=3D ALLOW_ANSI_CURSOR_MOVEMENTS;
> > +		else if (skip_prefix_in_csv(value, "erase", &value))
> > +			allow_control_characters |=3D ALLOW_ANSI_ERASE;
> > +		else if (skip_prefix_in_csv(value, "true", &value))
> > +			allow_control_characters =3D ALLOW_ALL_CONTROL_CHARACTERS;
> > +		else if (skip_prefix_in_csv(value, "false", &value))
> > +			allow_control_characters =3D ALLOW_NO_CONTROL_CHARACTERS;
>=20
> Does it really make sense to also handle "true" and "false" here? I
> would expect that those values can only be passed standalone.

I was thinking that 1) it keeps the implementation more consistent, and 2)
it would allow for an "oops, let's restart this" type of approach, saying
`color,erase,false,color`.

Might be over-engineered, but the alternative would have to take care of
special-casing `true` and `false` in the following warning (because they
_are_ recognized, they just wouldn't be recognized inside a
comma-separated list).

>=20
> > +		else
> > +			warning(_("unrecognized value for `sideband."
> > +				  "allowControlCharacters`: '%s'"), value);
> > +	}
> > +}
>=20
> This could be simplified if we used e.g. `string_list_split()`. But on
> the other hand it avoids allocations, so that's a nice benefit.

The code also was a lot more verbose. I know, because that's what it
looked like before I changed it. :-)

Ciao,
Johannes
