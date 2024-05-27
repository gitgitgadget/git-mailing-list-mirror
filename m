Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC14017E8ED
	for <git@vger.kernel.org>; Mon, 27 May 2024 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716839477; cv=none; b=MdnRBomIiYvfbWvxQu8lw9Mgctf+zVqoa5fERLrgf9U7GDzyk+H4XaJhuuRgjS71WwjsHIr6NY3CT77S2Xytizhsrf5TdRHJ24GUxNxxVASP0rIX4cywDMO04G+rb210Knqu24n2MOckrXgVeZsvqzpCE9Fpq7Ct3SEmgO8K5BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716839477; c=relaxed/simple;
	bh=S0+V40Gorbv0+1zDGSIOTna4tjM1Xc2YqIZAnSAyaxM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qwUwZu3VDRdhd9BuyFKyyfpd7owbFBGi/Ub/3uzKp8yhKViQXXQLlxEomqWq3qec3Q3a9bJ0yYq6R3EVYRKr+TkF/1rh6vge8zv1c/YJLkIU8eG6jCaTDxD91cof2a2z+WO76O0V+NaRIbPqchOBSycCVSyHmnbILeGE2JD5wco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=cXTv2blj; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="cXTv2blj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716839467; x=1717444267;
	i=johannes.schindelin@gmx.de;
	bh=N1hxM20Z5G5dJTBckIONkosdgroHQ0OsFcjRhygm6Gg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cXTv2bljkhkyIh9DDLyzqfVubHhDHkRmvc5kMIEkYC0+P+eovjv4w/L9MeN6LBT2
	 QK15NL0bTtlmLdXbFC069ZLc1qTiIf0s82jYufz5KOHJLD4znxXNtsRMALmQSu9Zs
	 tJqu+VccvqAR6AmlG73al4IkV38Csm36D2JX5XnLa0IjS5ab2C4NyYWzrQbFnSI8p
	 is0J+yI0YYg+x8HIbfWggkiebNCYSUOwgz1LQ5V977nYtUwPQP/tZLByNTJb2Ib/y
	 WOQbdSbK0cgnIJ8HPXpc1/vjlL9n+7uestzI2pAfvNq+b50K3gP7JuFrfn4P6vBgs
	 f6qMwquzh8pPriEi2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.216.58]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mkpav-1svRNE1j8J-00mJjC; Mon, 27
 May 2024 21:51:07 +0200
Date: Mon, 27 May 2024 21:51:05 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Joey Hess <id@joeyh.name>
cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/12] Fix various overly aggressive protections in 2.45.1
 and friends
In-Reply-To: <Zk9vafYPijqyWpXv@kitenet.net>
Message-ID: <99225123-70f0-3546-a6fa-b6d1f981b41d@gmx.de>
References: <20240521195659.870714-1-gitster@pobox.com> <Zk3ChIHr5amGh8Mt@kitenet.net> <xmqqv835xekc.fsf@gitster.g> <Zk9vafYPijqyWpXv@kitenet.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1155091960-1716839411=:117"
Content-ID: <4362efa5-fb11-f61e-81e6-54c88c4e7e5d@gitforwindows.org>
X-Provags-ID: V03:K1:u08yNIVJThvZPZ2Hsw+xiFHpwloqbHy7HgfS0pVS+GPxK5f4mI0
 z6ggk6s5zg7DllbK4ds8tioZoZDC0nXAnsSjMYqoMhTLqFc3FwyDHyapmjelLagff+NRMVe
 FuS9Uq8Oo28Uhh9fp+Vt0xD+SLEWm6d0/UKNvt/h4Q8bVXp7ld6EYudtILRdqWKJ96+K9iM
 pu7n57oppagiNrVj/rloA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bFYXL9jAIuE=;ujDNExWAjxsCBRSrDygW2dPtnxl
 TfeBkcXH5Yxh0XSyaP8wjYhuwOecvTQnj27zHdYmUDZqe62CQQC5GbMxK70ribkMB7Yr3mM3s
 is0jXTJjJPk3SrfY0g7tF1A+o7Kj7pxhGLxopc7F2xM2ZW+jbA1gIy36XCBtE+BprOw16o4+f
 O8HkHRCyfjiv8sTptkXKI6qYC7cKs4bY7UX83tYr85KTCUELWaekgfx6ssebBu3P3NpOb0POW
 aRLRDHF4a5MUgf599lFsfGLtjnYLmQFkv2I5tsqId75/3uhWCu930+u8ve3YLyHWJJvARuVu+
 KAD106tqtzwfoA4gEv3hReqV/zyEtWJo4siwuONOfAEja+OtBCNDL2Vmr7tLxyNOSjrPlgJZU
 +r+drN+lqI8Qa12UJokap03piljwJDWbduTQSDJvCOWYmkQxIHLthfv0mz2+ETnCpJbN1BdUI
 cpvxQ18PrV5grUVY+9ypQRLTUEeYkFzU/ZJIf/Eg1vnZG0wr3RSW6YsBr6EQyKPTvJYz5XROE
 eUhq6MXYqH6eQDaw6KaV2wsH77FLa6sCeoA5bZdy9Ad3JGdKVwOz0naiDCqc1qRbZxtYf/3UH
 nO4pFQhxQJSq8i6FgWemEblUQGdjFphSDysrzQN5mLEXay99F7A93t9kaufmIAnURYWMa05p/
 hdxz9EgX6ByqUxyEUKTedcstT9UlRH54ep4jGQF/R+SaFXC2GtTTkSeacIyCrgAgFPUD+1n0N
 clnw5F4Uyn/bEwEC80NlZzaXiZN5AETZNvyRt4fUXBo5pm4W0sWdWXtH+HjA294V7MIBr2WEw
 YxG68yfsZtL6QUCRdJssqMVvdb7JX3p5+aKm2WrCOk6hlhF4m9ueggtc75IVzBysEaZwNcBqb
 ED6wK+4B3vCKgkwQdpfBoRHTIoElS35bN1/Q=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1155091960-1716839411=:117
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <47ff1164-a8a3-5d11-393e-bea70069a144@gitforwindows.org>

Hi Joey,

On Thu, 23 May 2024, Joey Hess wrote:

> Junio C Hamano wrote:
> >  - The extra check seems to have meant to target the symbolic links
> >    that point at objects, refs, config, and anything _we_ care
> >    about, as opposed to random garbage (from _our_ point of view)
> >    files third-parties throw into .git/ directory.  Would it have
> >    made a better trade-off if we tried to make the check more
> >    precise, only complaining about the things we care about (in
> >    other words, what _we_ use)
>
> I wondered about that possibility too. But it's not at all clear to
> me how a symlink to .git/objects/foo risks any more security problem
> to git than one to .git/annex/whatever, or indeed to /home/linus/.bashrc=
.

It risks more security problems because `.git/objects/??/*` is not
re-hashed when it is being used by Git. That's a very easy way to slip in
unwanted file contents.

And there is a good reason _not_ to write stuff inside the `.git/`
directory unless you happen to be, well, Git itself: Git makes no
guarantees whatsoever that you can write into that directory whatever you
want. A future Git version might even write a file `.git/annex`, breaking
`git-annex`' assumptions, and that'd be totally within the guarantees Git
makes.

> Git clearly has to get the security right of handling working tree files
> that are symlinks.
>
> The security hole that triggered this defense in depth, CVE-2024-32021,
> involved an attacker with write access to .git/objects/ making a symlink
> in there while another repo was cloning it. So it involved symlinks
> inside a remote .git/objects/, which is very different than symlinks
> into .git/objects/.

No, the vulnerability that triggered this defense-in-depth was not
CVE-2024-32021, but instead CVE-2024-32002, a critical security issue.

Removing the defense-in-depth makes it more likely for otherwise
relatively harmless bugs =C3=A0 la "oh whoops, we wrote something we shoul=
dn't
have" to escalate to full, critical Remote Code Execution vulnerabilities.

Ciao,
Johannes

--8323328-1155091960-1716839411=:117--
