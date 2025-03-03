Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D56230278
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034599; cv=none; b=j30j71/WptNr7rZ26jO8YA04WkOZjhkpn6iCs+HCternSr3oY5VB9f6hjm5HsKLssRejNW1uygC03EG0bK50E3E6Gea79apOhiyFjnlBMmD+hFAaPl+G+DWAetAuU1r7CIqzgYT3J7MJGNOKTlJ0Em96sSSXIp7ByQ/KPdYYB2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034599; c=relaxed/simple;
	bh=ndQtVXM5x3S4GivQce+qbx4lwhLPTc6bpkheV5+q+eM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RZUtnY55C+mQjqV02orzGcYUFt+cDuhAFg8uzag/gwyhMNXumwRW0+ZQCybo59AQKHd3CSmWmX5biXq6+rZQREH0AOTwFmfG1YoiX4y60/AjBIOgxz7/bYXJZXM43KOMdQnpaoCB9XoSNArvUQy8mC2k3VGpvjKFZ+QW8ld0S2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=cMXAt2rj; dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=H8SNJhSc; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="cMXAt2rj";
	dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="H8SNJhSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1741034002; x=1741700668; h=date:author:from:to:cc:subject:
  message-id:mail-followup-to:openpgp:blahblahblah:author:from:subject:date:
  to:cc:resent-author:resent-date:resent-from:resent-sender:resent-to:
  resent-cc:resent-reply-to:resent-message-id:in-reply-to:references:
  mime-version:content-type:content-transfer-encoding:content-disposition:
  content-id:content-description:message-id:mail-followup-to:openpgp:
  blahblahblah; bh=8K6eDtZqo8SY3fUprr/lJGg4zDH4ArO8Nmo8D3GW7Vc=;
 b=cMXAt2rjVSieGMqwjZS1ROvjpUUP8UjaXKyMmoaCHknMBngebbDNvq5KV7GjSk9+PWxRYWsC
  uyB444Kr7c2LOlUIhAbsNChZINDX/MC1DlK/BVcEVrad0b5CosIYBpr6/z2EmdWEPPVT8Lcnw+
  ItBNis/N4pslramNZ7lY3kXUFtqzP/6toXpi7rDoOZ4rR8upNivlzK0970wsG5oNLDCx2lx02C
  r7xSPpPVlANx2QRhchtUu+zu6RllZv/otNH3mKgZv03BmiXdjTzpbVVc1qbMrUtSQCy3F9Tm56
  oulLgvt/QhMeHCfJFg2ph8OrmS7qbWgEU+rP8wiso05LOb5g==
DKIM-Signature: v=1; a=adaed25519-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=orange; t=1741034002; x=1741700668; h=date:author:from:to:cc:subject:
  message-id:mail-followup-to:openpgp:blahblahblah:author:from:subject:date:
  to:cc:resent-author:resent-date:resent-from:resent-sender:resent-to:
  resent-cc:resent-reply-to:resent-message-id:in-reply-to:references:
  mime-version:content-type:content-transfer-encoding:content-disposition:
  content-id:content-description:message-id:mail-followup-to:openpgp:
  blahblahblah; bh=8K6eDtZqo8SY3fUprr/lJGg4zDH4ArO8Nmo8D3GW7Vc=;
 b=H8SNJhScpNYLlPlBehGCXHmNO6ZNTdK1bU1yMWQXOGPUygV2br4euPtE3afpV5bezky+UE4t
  Hh4Xwzw6VFYYDA==
Date: Mon, 03 Mar 2025 21:33:20 +0100
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: git@vger.kernel.org
Cc: Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: meson build: datadir missing?
Message-ID: <20250303203320.lP10PHC5@steffen%sdaoden.eu>
Mail-Followup-To: git@vger.kernel.org,
 Steffen Nurpmeso <steffen@sdaoden.eu>
User-Agent: s-nail v14.9.25-641-gce53683382-dirty
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>

Hello again after a long time.

I opened

  https://git.crux.nu/ports/opt/issues/18

at my linux distro ([ports/opt] git: creates incomplete repos),
because hook etc directories were missing:

  warning: templates not found in /share/git-core/templates

He then said

  Try setting

    [init]
      templatedir = /usr/share/git-core/templates

  in your gitconfig.

which made me wonder since that is the default, so i looked and
saw his change to switch to meson back in January.  (What a pity,
i liked the make system; only that it requires GNU make, but
well..).  I then said (it is a web ui, sorry):

  hi. thanks, i see now (after looking around). it is a fallout of switching to meson, that build system seems incomplete

  master:meson.build: '-DDEFAULT_GIT_TEMPLATE_DIR="' + get_option('datadir') / 'git-core/templates' + '"',

  but that "datadir" does not happen to be set at all it seems; is this known upstream? (Hamano does not like me either, so i will not do that..)

  Only wondering why this happens at all, and is not covered by its tests, really.

  Ok i overwrite the default with the real default in my config, thanks again.


While here, since a couple of months maybe i get a problem on my
spare notebook when i sync the filesystem (btrfs).
To reproduce:

  #?0|kent:~# mount /media/btrfs-master/
  #?0|kent:/media/btrfs-master# cd crux/kent/root
  #?0|kent:/media/btrfs-master/crux/kent/root# chroot .

^(we are now chroot(1)ed to the same what is /, actually.)

  #?0|kent:/# cd root/
  #?0|kent:~# git co kent
  git: ../git-2.48.1/exec-cmd.c:50: system_prefix: Assertion `executable_dirname' failed.
  Aborted

It will work if i do /usr/bin/git, effectively the same binary.
However, this does not apply "normally":

  #?0|kent:~# cd /
  #?0|kent:/# chroot .
  #?0|kent:/# cd root
  #?0|kent:~# git co kent
  M       hosts/iwd.network/.known_network.freq
  Switched to branch 'kent'
  #?0|kent:~# git co master
  M       hosts/iwd.network/.known_network.freq
  Switched to branch 'master'

Whatever the actual logic is, it seems a bit odd, and furthermore,
and most of all, the above assertion is not a real help to solve
the problem at hand, some kind of hint to a solution would be
tremendous!

Thanks for git, and ciao!

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
