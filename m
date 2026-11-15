Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794771318;
	b=F2+nhbzeHks3HkuXRzm2qRKvBV5ze9BRbCiO+ngdVmxrQkiet8QkItRmruJ44lOYGJK2
	 eJN9cJYVCsXVax9lPjIHn5HlL5dP4xMKZoH+igfueH8dnxxVOMrq3TkjFS1NecOCVohgd
	 yDSw5B1KBFwwsRDF8lkf5NPAuGTXg0OR/hST+DUFXP+GhfloBRZBrlEJc2k5rORxgA2Oo
	 uzlTGXo+j81zlpkVR0YKUR/yunCGFyEsdNg0Cd5dBGP+XYeZlIReiByEjXVsPjkntLjrg
	 +G2kY0zf5URMUgLFbqQOzuOLvMWhI0Le2Thw8U5vtmc/q8q+cO5Uci/hePB8ctuRIgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794771318;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport:Content-Transfer-Encoding;
	bh=VM+hgxafSgNOYsv2y+PxOSY/0f6NG6ljDshN5e09Aig=;
	b=MPoyfQQl0+YaiGGgdBWafROh1PuthBrZKko++4356tb35ZMnyfRCY56Dav8ur8CW4AQ6
	 dYlkZLzZYGj3Wr41BmN0rYR69SNcESsfgbHtDvAH3qBtwxzpFfF1owLAkQO1eBUrWA41+
	 gZEb5e5O+gWtupViQwv1l8i+YTfDecdI+HURMY7zrR9KKTGwVoO/9oNx5WEwvowVi7puf
	 +3Ubhrk+lc+oe5NpaCRwdtYxEEDVZ/uKcWhvohRCdBd5SvuhIRVS74/sbu8nFiac2uHdY
	 Ffs9DlnAoh8srqenOJK0umgWBWhtXT920bGDSuYJY9Lf5Zj6U0DA/gNnjgyFbC3AunA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=kLWevtKr;
	arc=none smtp.remote-ip=212.227.15.19
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF57606A33B
	for <git@vger.kernel.org>; Sun, 15 Nov 2026 19:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEF57606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=kLWevtKr
DKIM2-Signature:  i=1; m=1; t=1794771315;
 mf=PEpvaGFubmVzLlNjaGluZGVsaW5AZ214LmRlPg==;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:iAjjavur9v5RXtDKbIeq7QSxFvFR
   CdTD7i0+2Zl1J3S7IAkK7YlW8Lxh/ynIXPtNwjoZDpD5E6J/zROF1UsWIfJFyXzNK4ky5WRQ3Zq
   pMhvtzPtW8tG6mbE130iqMQvYDNxGWMfFXWsYN2wA7NgmlMI/cU4yvUPWe8ga4/36W6+YPWQrzG
   GS8UTh+wlAt+oSgf/eyfdlX1tz71BQNfboL9rjvTSUdF7SzGVWHlXhVjf0aG2Wh848MVv0IxEhE
   yAkSCf7TYfNS+f+yP4JFG3v5Dl56UICzHa5YkU4HtkHsG8SP5UyIleHlHmKDV35OHQMNySoG/5o
   1LoL9mY7woYL8A==;
Message-Instance:  m=1;
 h=sha256:
   QjonTNIwoBR4ec9HLx9LvR2l6Fueo95AfV5Nr2SSRzg=:
   fqsFHHFQHuUSgIYEm5INK2RUlMCv2oFWtrIS4WPE95Y=,
  sha512:
   hH+yK+WkjDVEPdfyYY14rvdLA5GYV6i2lJVIpwwmoGxsP1Abrm/dSGu92jLaXaifgFbm9Hhiil6RwOedUp3zCw==:
   BSVBChUqLEdA5IEFg8r4RaX/Q28Mgu5SD/Ye/bkk7utZhLZScF9wdG1Q/5KxqjNejdl80MY4FbC1QoZm6xw7rA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794771314; x=1795376114;
	i=johannes.schindelin@gmx.de;
	bh=VM+hgxafSgNOYsv2y+PxOSY/0f6NG6ljDshN5e09Aig=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kLWevtKrHYo/TiqIP9rZM8pBtycXHk0tidyf9P2L9+tTwH47dvY+27Egq6mmj25l
	 /sDfvZ24LAqnckZQq7clqVf7SxM0aW669Zaxb88GgScw/ngIAVsEjDQQrEKEPPsVt
	 1r6naiB5V6Tc7XF3oRLuHp1MgJdVZW7VCM8cK8GlVv/fsUKVo0DicVxSPCAfVD+5T
	 G33sl9NfzCD1Wi+nFNjzzVUdmRX7tKfwAwWAUwKvPRaO4UDL0cTy4VYzGcI2+5mAH
	 ga1zIATtkLph/m/9ZBNFpqBBwmYlhJP3ghLqloI1YpivXHLTj95GCjFdf5f00sCeb
	 M9n2C3WyhC8+yOK6bQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbEf-1xJda63oEF-00HKeR; Sun, 15
 Nov 2026 20:35:13 +0100
Date: Sun, 15 Nov 2026 20:35:12 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Phillip Wood <phillip.wood123@gmail.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 5/5] date: avoid overflow in approxidate relative-time
 multiplication
In-Reply-To: <163d14a8-711c-4d4f-b441-8268db819541@gmail.com>
Message-ID: <fb0ee14d-e133-86af-012b-b6befd51f826@gmx.de>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com> <a4e602b9e726081aaaf73c627548b823a4d35477.1791958171.git.gitgitgadget@gmail.com> <163d14a8-711c-4d4f-b441-8268db819541@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:7JO7thofucNVO5Ufdf92hPzt/XsujmMlaQWQMprSF4Ji+TBZ25I
 DRjfq6nJmsRIYKorXtz2FH3oAi1kzEVlVZzHBHvjsZDuJZnf++lg+7q7TtQNc/nYlrcf2Bb
 ckooHcKPLJzJQY8o9mm5w+kVzl6UHCO4SLiQHmxDyFQksDe77MNRT2Q975Vjb2owsUnpt/o
 oWp4obcZ77jT+clYNPIMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b9IgKc8beyA=;3DzM5rLGEVIDvXdflBDvT+/Cm4L
 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
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Thu, 15 Oct 2026, Phillip Wood wrote:

> On 14/10/2026 07:09, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > The `approxidate_alpha()` function multiplies a time unit length (e.g.=
,
> > 604800 for weeks) by a user-supplied number to compute a time offset i=
n
> > seconds. Both operands are `int`, and the product is passed to
> > `update_tm()` as `time_t`. For inputs like "99999 weeks ago", the int
> > multiplication overflows (604800 * 99999 is roughly 60 billion, far
> > beyond `INT_MAX`), producing a wrapped value that results in a wrong
> > date.
>=20
> Signed integer overflow is undefined so we don't necessarily get a wrapp=
ed
> value - the whole program is invalid.
>=20
> It looks like "length" is always positive, can the user supplied number =
ever
> be negative?

Indeed, length cannot be negative. My entire approach was overzealous.
I've simply replaced the logic with much easier-to-review manual overflow
checks.

> > Use the checked `time_t` multiplication so oversized products do not
> > overflow or wrap around.
>=20
> This is only true when compiling with gcc or clang though because
> mult_overflows() always returns 0 on other compilers, so we're still exp=
osed
> to undefined behavior when compiling with a different compiler on platfo=
rms
> where time_t is signed. I wonder if it would be better to perform the
> multiplication on a known type and then check that the result can be
> losslessly converted to time_t
>=20
> 	intmax_t length tl->length, num_t =3D *num, result;
>=20
> 	if (signed_mult_overflows(length, num_t))
> 		// error
> 	result =3D length * num_t;
> 	if ((intmax_t)((time_t)result) !=3D result ||
> 	    (result < 0 && (time_t)result > 0))
> 		// error
>=20
> that would avoid overflow on all platforms, regardless of the compiler a=
nd
> regardless of the type of time_t. Having mult_overflows() only implement=
ed for
> gcc seems like a footgun waiting to happen when we're typically checking=
 for
> overflow to avoid some form of bad behavior.

Yes, this GCC-only logic wasn't very smart of me.

> > On platforms where `time_t` is unsigned (and where the pre-processor
> > allows us to determine this fact), reject counts that are too large an=
d
> > report a parse error. Narrowing them first could otherwise produce
> > negative or truncated values that become bogus offsets. Leave signed
> > `time_t` count parsing unchanged.
>=20
> I'm a bit confused what this is trying to do - why can't we check this w=
hen
> time_t is signed?
>=20
> 	if ((timestamp_t)((int)number) !=3D number)
> 		return NULL
>=20
> 	return *val =3D value;
>=20
> Ensures "value" fits in "val" without truncation, we could also add a ch=
eck
> that value is positive when time_t is unsigned if we wanted.

I simply did `if (number > INT_MAX) return NULL`.

Thank you for your thorough review!
Johannes

>=20
> Thanks
>=20
> Phillip
> > Pointed out by Coverity.
> >=20
> > Assisted-by: Claude Opus 4.6 and GPT-6.1 Sol
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >   date.c | 26 ++++++++++++++++++++++++--
> >   1 file changed, 24 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/date.c b/date.c
> > index 014065b419..0d65804d2f 100644
> > --- a/date.c
> > +++ b/date.c
> > @@ -1298,7 +1298,18 @@ static const char *approxidate_alpha(const char
> > *date, struct tm *tm, struct tm
> >    while (tl->type) {
> >     size_t len =3D strlen(tl->type);
> >     if (match_string(date, tl->type) >=3D len-1) {
> > -			update_tm(tm, now, tl->length * *num);
> > +			time_t length =3D tl->length, num_t =3D *num;
> > +			time_t seconds;
> > +#ifndef is_unsigned_type
> > +			seconds =3D length * num_t;
> > +#else
> > +			time_t max_val =3D is_unsigned_type(length)
> > +				? maximum_unsigned_value_of_type(length)
> > +				: maximum_signed_value_of_type(length);
> > +			seconds =3D mult_overflows(length, num_t)
> > +				? max_val : length * num_t;
> > +#endif
> > +			update_tm(tm, now, seconds);
> >      *num =3D 0;
> >      *touched =3D 1;
> >      return end;
> > @@ -1368,8 +1379,15 @@ static const char *approxidate_digit(const char
> > *date, struct tm *tm, int *num,
> >    }
> >  =20
> >   	/* Accept zero-padding only for small numbers ("Dec 02", never "Dec
> > 0002") */
> > -	if (date[0] !=3D '0' || end - date <=3D 2)
> > +	if (date[0] !=3D '0' || end - date <=3D 2) {
> > +#ifdef is_unsigned_type
> > +		if (is_unsigned_type((time_t)0) &&
> > +		    (number > INT_MAX ||
> > +		     number > maximum_unsigned_value_of_type((time_t)0)))
> > +			return NULL;
> > +#endif
> >   		*num =3D number;
> > +	}
> >   	return end;
> >   }
> >  =20
> > @@ -1398,6 +1416,10 @@ static timestamp_t approxidate_str(const char *=
date,
> >     if (isdigit(c)) {
> >      pending_number(&tm, &number);
> >      date =3D approxidate_digit(date-1, &tm, &number, time_sec);
> > +			if (!date) {
> > +				*error_ret =3D 1;
> > +				return 0;
> > +			}
> >      touched =3D 1;
> >      continue;
> >     }
>=20
>=20
>=20
