Received: from redcrew.org (redcrew.org [37.157.195.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F661DDA21
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.157.195.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776798; cv=none; b=DKhUOgPe/xBbRuGZ3lIrDkAYLq3oXj2WVqcqlcfvj35PQmxdIJAl1knnBUyuLA2mPs+FMlTCwPsA+8+q0zS3LnDtrevC0s/KKu1juF7mpbhR/6Uj0+sG8AqlsfzYsHFqfHJGVt0Zmly+JdXtt1XuXdno9gyesS748t39nmuGd64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776798; c=relaxed/simple;
	bh=eEgDRCEsaG6H6/q+bXV3GBpXC3xjRtZGgchIanANtSs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=MGDzpCkKtqdxZgEdVW/wEwRtmsc/hI1hy3h++DdEGCoJfmOh/EiHj4chLdFALsd4o+r3ifnLVpfLMjoIkSadRrey/ONKFP5EfDZFZT8+4cvG40tQmZCumRajHe/SeLLEwSGQN8JJ012hqreuXY2Pzyw+L9ZupjYwPJX9zyHpHUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu; spf=pass smtp.mailfrom=cepl.eu; dkim=pass (1024-bit key) header.d=cepl.eu header.i=@cepl.eu header.b=ZQzI57S9; arc=none smtp.client-ip=37.157.195.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cepl.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cepl.eu header.i=@cepl.eu header.b="ZQzI57S9"
Received: from localhost (unknown [185.22.237.37])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by redcrew.org (Postfix) with ESMTPSA id 04B06C26F;
	Thu, 24 Oct 2024 15:33:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 redcrew.org 04B06C26F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cepl.eu; s=default;
	t=1729776790; bh=lyAWjSfczM0HZifObxGisQ+Zwpf/I/QW8qSIEvqUEBA=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=ZQzI57S9KSDI82Xc5njyEXOjJaDu/D7yJzSsX6sFf1txOEMR3gVk6UnmgeV6Lz1w9
	 BBJbr7p51OVLiMRfnG9azygDTPBtXje2I1GOMl7jEU7RDSStxD44pq8gd1A9f8oNNl
	 daIE7v0pH7sAGaYMLm+i0nWicdCEQUpSFWhHbrCs=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=f2c1e3d131e0a784d4db8e3901339c3e79d3de6ed92328e15f125e3aa647;
 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 24 Oct 2024 15:33:09 +0200
Message-Id: <D542P2ZTHIUJ.2GEJYE41VTC0J@cepl.eu>
To: "avih" <avihpit@yahoo.com>, "Taylor Blau" <me@ttaylorr.com>
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: bash prompt evaporates in subdirectories
From: =?utf-8?q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.18.2
References: <D52FCQ2F409N.1S5Q8XRAX5YU7@cepl.eu>
 <ZxfKbsapf3MAUmcy@nand.local> <D53YJ81WH001.2KRT4KHARKLC4@cepl.eu>
 <1101848017.3146876.1729770380522@mail.yahoo.com>
In-Reply-To: <1101848017.3146876.1729770380522@mail.yahoo.com>

--f2c1e3d131e0a784d4db8e3901339c3e79d3de6ed92328e15f125e3aa647
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Oct 24, 2024 at 1:46 PM CEST, avih wrote:
> - What is the "innermost" distro where this happens? Thumbleweed?
> =C2=A0 which version?

Yes, Tumbleweed (actually MicroOS uses Tumbleweed packages as
well), which is a rolling distro and I updated (almost) daily, so
it is hard to say which version.

> - Which git version do you have installed? How did you install it?

mitmanek:~ $ rpm -qf "$(which git)"
git-core-2.47.0-1.1.x86_64
mitmanek:~ $=20

> - How did you install the git-prompt support?

Using the git-prompt.sh from the package, but it seems to be the same as th=
e upstream one in contrib/

mitmanek:~ $ rpm -qf /bin/bash
bash-5.2.37-14.2.x86_64
mitmanek:~ $ rpm -qf /usr/share/bash-completion/completions/git-prompt.sh
git-core-2.47.0-1.1.x86_64
mitmanek:~ $ diff -u \
    /usr/share/bash-completion/completions/git-prompt.sh \
    <(curl -L -s https://github.com/git/git/raw/refs/heads/master/contrib/c=
ompletion/git-prompt.sh)
mitmanek:~ $=20

> - Which shell do you use? (bash? zsh? something else?)

bash with ble.sh (freshly updated, but the problem can be reproduced even w=
ithout it)

> - How is the (git) prompt set in your shell startup file? (~/.bashrc,
> =C2=A0 or ~/.profile, etc). If you don't know exactly, then can you pleas=
e
> =C2=A0 attach your shell startup files?

* /etc/bash.bashrc is
  https://mcepl.fedorapeople.org/tmp/bash.bashrc (the
  standard openSUSE one with the addition of loading
  /etc/profile.d/distrobox_profile.sh)
* /etc/profile is https://mcepl.fedorapeople.org/tmp/profile
  (git is not mentioned anywhere in /etc/profile.d)
* /etc/bash_completion.d/git-prompt is
  https://mcepl.fedorapeople.org/tmp/git-prompt (so, yes
  git-prompt may be attempted to be loaded twice)
* /etc/profile.d/distrobox_profile.sh is
  https://mcepl.fedorapeople.org/tmp/distrobox_profile.sh
* ~/.bashrc is https://mcepl.fedorapeople.org/tmp/bashrc
* ~/.config/blesh/init.sh is
  https://mcepl.fedorapeople.org/tmp/init.sh

> - Can you provide a sample repository to clone which reproduces the
> =C2=A0 issue? for instance, you can pick a small repo from github.

Basically any git repository which has more than one
level of directories, I spent most of my time in
https://git.sr.ht/~mcepl/m2crypto, so when I do `cd src` the git
status evaporates.

> - What are the steps to reproduce the issue? is it enough to "cd"
> =C2=A0 into an existing sub-dir at the git dir? or is it only broken
> =C2=A0 when creating an unrelated sub-dir and "cd" into it? better yet,
> =C2=A0 provide a 1:... 2:... 3:... steps which reproduce the issue for
> =C2=A0 you, and which others can try to follow.

Yes, just run `cat <(curl -L -s https://mcepl.fedorapeople.org/tmp/typescri=
pt)`

> =C2=A0=C2=A0 sudo zypper install bash-git-prompt

I don=E2=80=99t have this package installed at all, using the script from g=
it-core.

> =C2=A0=C2=A0=C2=A0=C2=A0 . ~/git-prompt.sh
> =C2=A0=C2=A0=C2=A0=C2=A0 PS1=3D'\w$(__git_ps1)\n\$ '

Yes, that works:

mitmanek:~ $ export PS1=3D'\w$(__git_ps1)\n\$ '
~
$ ~/repos/m2crypto
cd -- /home/matej/repos/m2crypto
~/repos/m2crypto (master $)
$ cd src
~/repos/m2crypto/src (master $)
$=20

So, the problem is somewhere in my too complicated configuration. Any idea,=
 where?

Thank you for your help so far!

Mat=C4=9Bj

--=20
http://matej.ceplovi.cz/blog/, @mcepl@floss.social
GPG Finger: 3C76 A027 CA45 AD70 98B5  BC1D 7920 5802 880B C9D8
=20
Books aren=E2=80=99t written - they=E2=80=99re rewritten. Including your ow=
n. It
is one of the hardest things to accept, especially after the
seventh rewrite hasn=E2=80=99t quite done it.
  -- Michael Crichton, alluding to Steele MacKaye (1889) article
     where he said this about theater plays.

--f2c1e3d131e0a784d4db8e3901339c3e79d3de6ed92328e15f125e3aa647
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iGwEABECACwWIQSJ70vGKIq/QxurJcPgn+8l2WSErAUCZxpMlg4cbWNlcGxAY2Vw
bC5ldQAKCRDgn+8l2WSErMlCAJ9pnlLG7/1tisOczLjZE/2MMFjqBACgjDHF39yv
2YOOsx5kR3Lj9E15KSE=
=bk3A
-----END PGP SIGNATURE-----

--f2c1e3d131e0a784d4db8e3901339c3e79d3de6ed92328e15f125e3aa647--
