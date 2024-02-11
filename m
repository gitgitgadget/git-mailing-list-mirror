Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98E12837D
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707670797; cv=none; b=CA55Io2NwtK8V+mEaw8PefrMN7mOW9UtTx7OKxlZFK2jGTnuvh8fPYIw+jAy4oCi2xUIoYbaMZx5h1PiD4G/as27Ztc57EUd/loqK8wdZGxEADck3Bqnf1DJb+RgnXVSGfOgpWcqKMVm/fVoQ0f8Qq7lfrXDN02Z2zZeTIBdlgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707670797; c=relaxed/simple;
	bh=r54PbG61BShlj0vvVexQGmz39QfGCvp5LeS/ReW9qyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EW9U59QW2lpaEKNiJRrh41Z6HuGq4H9It7aoIFarqnv15jOZGorXpOTs0Hng8DaRo998Qbo4bvx/BfZt6n6FrjZlx4+iaOcx0jlfcP4xPZ6XUy7equAo6fJobGjm5WrYpZTQM0kOllQAKN28X5ebSIcUeJh/qGT6b5HTjdAh4RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=P29E1VB2; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="P29E1VB2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707670782; x=1708275582; i=tboegi@web.de;
	bh=r54PbG61BShlj0vvVexQGmz39QfGCvp5LeS/ReW9qyI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=P29E1VB2uZZppw1A1AQuUDT38Rrh1Ix8EB9h8o6e92BiQSsn05e29WeeVSGXNdtT
	 uk6K9GXzZoz17ffkL80Pd74KEj6z5V0tR4WTty6x+4mzZxeVNjP9xORneIeQZ95lx
	 mYT4qdEtAldpq5O939PLcXTKyj4lV2V6LFsfXDEdRmTC9shVXqYTcT5vGw1Dyk6Mj
	 3YvfIByUyWPNm4Bu1L5P8xGKeQr5AYS6xyK39pIrwjahsrf2mdsVCoRbHwSP0avtL
	 VgaT8OY+ZWWw8SiuF1UrfR+zFWefdS6No/xSo8aYyHRmyNZwF2Ob7wdHkBeI8tK6o
	 GzYC9gkb79FRhX3akQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqIFF-1rDqqT0pKF-00nRlJ; Sun, 11
 Feb 2024 17:59:42 +0100
Date: Sun, 11 Feb 2024 17:59:41 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	K_V <zinen2@gmail.com>, git@vger.kernel.org
Subject: Re: git gc changes ownerships of files linux
Message-ID: <20240211165941.GB28699@tb-raspi4>
References: <CABkRduQNdgdF8WhZadP5hyYvpEWgP_AE8=qzxNiRNA71bdJcYQ@mail.gmail.com>
 <20240211151455.GA27103@tb-raspi4>
 <ZcjnuSAZiNHvA5h1@tapette.crustytoothpaste.net>
 <20240211154345.GA28699@tb-raspi4>
 <xmqqcyt39cju.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqcyt39cju.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:OHT9FNyolKC3IHnBj5kJ4+w8KfpvJlGhl2XpQcrgB3E/sVvU2f9
 yKZJQTpmTTYvOrWJRfNkH8ua1Hv+1+g9B0PkgrN33KdtvERNd66OxlAZSCslMoJzsPJg/ol
 nNGLsMTivvcc3blYRMEeF1CyuQYD4XHheaoPpAiLlLQ+ZEyG66o9Uv3bgvZNWK4FZEmIEkk
 8P6UtRrVTtVJqnodqFQsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6Et4z+V3lDI=;bHMSgxZRIZwzvgXTxR9qWVsi2J5
 hj3glGZyw2uATC6Yb6vML7ABRTDWxsUBoHOT7dWllvwbzYEJQd+qI03EmSBzF8u5Y6isC90FE
 deEuUlgx35MDmFL9CbPhA+NXS6ZozjF/VMR96CDsLwz3TElFTS9iZbKh9eLcGlffG1DMEH8nB
 S1ljxxptERsTkA327sfHV/joSkp9h42blwhNJ8FzYIeKJTIA0X7m5LY4Pzwgqo8yTTMUrnaBY
 HdTX/9vILnYfw0LDKR8Pmzr4OyKHHCBhlz11Y2eJZqFOOJE7hI4Qo3klCed1OQCiXY4JJy3Me
 XO1c+tX7cvnohV1cELRttvJgcTExZH6tYKaW9jx1b9uDwz9YfESNvb+1+iCK5Njj5Nfi8LuVM
 Kal8JiYZAGF7ur7kRyLIXtyBtyaH2JgtW7Xh4cQ6VXriGzUiiG+EoWbeCRKvQ85NsuSUuBOGK
 lSdgqj+vI28gs4Iumn8T2OWJ2JI5AK7tbGJgjaBd2cgsL4KymqB3XfnHcm3R4qjylo49IvbCq
 fTk/fMFWRuUehaa4iUECA0zf9uPc/H7y6Dxcb5HcYXXhhixpgP6Hxoroot8WS34TLCQtM0TSD
 dAA1W0hqqnKV4sppmVZBVU+aO8PRCGIXTWOPFmud1r4SuZrAK7A7rP+E+9i7qCFDg9oYvBckV
 STDSFT8b3efevjYiwG1nfGT2qByh1KJ0a62/Ld6rIy9W04R+ItavJmR+26GtS1CtfQjdGF/ox
 mdmzIo/+Mg7i/4fEBYGS4SC/upkVEoFfPInqx1hVxQWT38zIQiUozMM+0xKWp9G3HCzr5aWy8
 qdEA9N7trWl63jCCP9NNhTrB4zwl6v++foW80Tl0JI1vQ=

On Sun, Feb 11, 2024 at 08:43:33AM -0800, Junio C Hamano wrote:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>
> > Briam, Hm, I wonder what this function (in path.c) does:
> >
> > int adjust_shared_perm(const char *path)
> >
> > According to my understanding, it was included into the Git codebase
> > to work around the missing "setgid" feature in Linux (and probably cyg=
win).
>
> No.  "g+s on directory" is required and depended upon for getting
> the correct group ownership.  We do not do anything to chown(2) a
> filesystem entry to force what group it is owned by there.
>
> What adjust_shared_perm() does is to counter what the screwed-up
> umask settings the user may have causes.  If you are a member of a
> group and working in a directory owned by the group with other
> members, you want to make sure others in the group can access the
> files and the directories in the project.  Their umask should be
> loosened to at least 027 and preferrably to 007 to give group
> members the same access as you do.  Yet people do not loosen their
> umask when starting work in such a group owned directory that is
> supposed to be shared, as it would be extremely cumbersome to do
> [*].  These users end up creating files with overly tight permission
> bits, e.g. 0644 or 0700, and we go in with adjust_shared_perm() to
> fix these modes.
>
> You definitely must set up your initial directory with g+s if you
> are usihng the group-writable shared directory model (which I would
> actually be surprised to see in 2020---is a shared machine with more
> than one user-account still a thing???); adjust_shared_perm() will
> not help you there.
>

Oh - I learned something today and sorry for the noise.

>
> [Footnote]
>
> * Unless, of course, you use some sort of "hook" in the shell to
>   notice you switched to a certain directory and run command
>   there---some people achieve this by aliasing their "cd", "pushd",
>   and "popd".
>
>
