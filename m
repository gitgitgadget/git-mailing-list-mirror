Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D91323C368
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 20:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783886681; cv=none; b=phmKXiZAl6lg/tV5ltRuct6L7jORO1h6jEVjSroQFzagooE6gzHcnMRtlO/c/+EpIwij5Yv9xy+Wtibd1czosyT9NJ0n+xkyrL49B5F0g79/B23/1sG+Kb0los6FcR2KDNUKzs+V0vq4bB7ciOJeL9uKqvrHkzogVPZH8zBI4i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783886681; c=relaxed/simple;
	bh=c9FcJ9RiN1VxgCxYoFfg+MqzvH2o+dLFsz93r5uH5Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvb7LQ1sJe4lYlufH30wbNxHM/KGZWMTNEnOEC7b42VQozWVHZB0LiFedXl2sbz+q+bfm2Km5PL9hEdvhHwa5dLbOOdWR6jA7exbsm75pO1x2qXZnN7iXlonKnB/heZMY+zDYXoD0X5rhnfGiLEdpzjNHVSkkBqWJxvNMzZhZu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=hQvUrJFI; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="hQvUrJFI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783886668; x=1784491468; i=tboegi@web.de;
	bh=PkEqbXew/XOYeX9D+xnCQS6fdQAKocNUReb29mvkul8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hQvUrJFI8dXzuQiTEnsryWwwUShgigeGK08+80QOjt7sWk24JPKWuFWC14+JctfY
	 /tlFo4c/zgDGLD6/W7x/KhZVEVIEqpbuH7F9j5mSFZoL0trnKm0tv5kyVvzfaXNH/
	 fqIp361P4gJ4S8fN2JhTY+yqOMVeX9lGFb+2wHkKaMhUrk74Q/woh6IbZJlEcNiWz
	 wrY1sjtgSAf8Xvwp0hVImDWs4lD3S25IKRiVUxdEnQNuwn5M7WsnEutncAL0LkYQ1
	 4MwugDMkUGm4jf1cjGghfIPvA9N/NmJk8B+llCcvs7bpPkPrWVrGYKQpUKZmTFVXM
	 dK1JVX/gmBkjh0b5Tg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjxiM-1xT2Xr3gbY-00lZJl; Sun, 12
 Jul 2026 22:04:27 +0200
Date: Sun, 12 Jul 2026 22:04:27 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: cygwin v2.55.0 test failures
Message-ID: <20260712200426.GA11328@tb-raspi4>
References: <f65466c9-bede-472e-ad57-e72a5289be27@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f65466c9-bede-472e-ad57-e72a5289be27@ramsayjones.plus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:F722U6RsnByRrM/76lYdWPckVmIWm3cupjI08qKVxb/y1vBBzQo
 nezpdQFcFGe+nc3mu55tHxNSi+erMdSl16973fh2AhVYbai13d5Cx/IbrKrX85cweB0tbtk
 WZeTF1IPn7U5ktmlrF5M3BhxB3+oU6xPKjWHT8cco4Oj0sv5DTTiwEprct7wvmN6nyZnLI7
 Ju/Rdrdl0C+kT0wmXgxRg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jNFKl3x+81U=;puK4HiACNOV0w7P9n5bDyV40MmZ
 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
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 07:32:23PM +0100, Ramsay Jones wrote:

[snip]
Hej Ramsay,
 Thanks for picking this up - I have some smaller comments inline,
 trying to be helpful.

> As luck would have it, I left a note to myself about the remaining two
> failure cases. This leads to the remaining hunk, to connect.c, in the pa=
tch
> below; ie. the removal of a conditional (which should only fire for GfW =
and
> cygwin). The '#ifdef DUMMY/#endif' should probably be replaced with an
> '#ifdef GIT_WINDOWS_NATIVE/#endif' so that GfW is not affected. (Having =
said
> that, I suspect that even GfW should drop it ['somebody was smoking some=
thing
> exotic'], but I have no way to test it, so ...).

> Personally, I would be quite happy to rip out all win32 path handling an=
d
> only support POSIX paths (I have been using cygwin since about 1996 and
> have only ever used win32 paths when testing git ... that is the whole
> point of cygwin! :) ), but I already know that that is a no-go. (there i=
s
> always somebody that complains when you suggest it).

As cygwin supports/allows win32 paths: we do support them in Git as well.
(and nobody is forced to use them)

>=20
> So, for now anyway, it seems that I need to tidy up the patch and move i=
n
> the opposite direction to e.g. commit 1cadad6f65 ("git clone <url>=20
> C:\cygwin\home\USER\repo' is working (again)", 2018-12-15).
>=20
> Part of the reason for vacillating on the correct way forward with this
> patch, was because I have often thought that I should use the cygwin API
> to cater to both POSIX and win32 paths. For example, we could possibly u=
se
> the 'cygwin_conv_path()' function to do the path conversion (somewhat
> similar to the macos pre-composed-utf8 stuff, minus the directory readin=
g).
> However, I think that would open a different can of worms, including som=
e
> potential memory leaks. So, not exactly a slam dunk.
>=20
> [I also had a note-to-self about 'mixed / and \ urls' in the config file
> which is exposed by these same tests. So, another patch may be needed?]
Not sure if I follow. cygwin allows mixed / and \ . What should be patched=
 ?=20
>=20
> Anyway, something to think about. Hmm, I suspect it would be best to jus=
t
> tidy up this patch first. ;)
>=20
> Just FYI. Thanks!
>=20
> ATB,
> Ramsay Jones
> diff --git a/connect.c b/connect.c
> index 47e39d2a73..6f5715e938 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -1088,10 +1088,12 @@ static enum url_scheme parse_connect_url(const c=
har *url_orig, char **ret_host,
> =20
>  	if (scheme =3D=3D URL_SCHEME_LOCAL)
>  		path =3D end;
> +#ifdef DUMMY
>  	else if (scheme =3D=3D URL_SCHEME_FILE && *host !=3D '/' &&
>  		 !has_dos_drive_prefix(host) &&
>  		 offset_1st_component(host - 2) > 1)
>  		path =3D host - 2; /* include the leading "//" */
> +#endif

This very lines come from

commit ebb8d2c90fb0840a0803935804e37e2205505f23
  mingw: support UNC in git clone file://server/share/repo

...and I can not see a reason to remove it.

