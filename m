Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BB7251788
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112204; cv=none; b=qOouu7scGGBVB7p8gfekDo3jpHtYn6TfGtrJ3/HjzU4d1Z5ghpP7yyDKWgHWhTLlR+LPUheFZ093nKOwFHToaPtMPPe2nbjqSO2fG4u+zQa2Qp/swtinBhkZ9/71iiXFOUyFGy6+/DYwRMzYfoi/W1u22fEeFxpFOGfc2tcfYzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112204; c=relaxed/simple;
	bh=D7m13rUqxTG+IB8BQ2Ha7OB4Q5uWL9mBPPdHfRNV4m4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References; b=kWEqh4Qu63xRwZoBRCxZq1V12hchROMTap68lDYy5LQsCfWuw8ix2ouWiJ+FAIcdv64hm61KEcWKmDS90EW6g4jcVZ2YwCXsT+LmKAaBYZ1NtRQSqcDfcI60+b7/zZDLOab0SRWLFFu+xrMshSwfctDYOyCJy2whmGEfTZq+6LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=AuhX8Irp; dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=XjKT9xfA; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="AuhX8Irp";
	dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="XjKT9xfA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1741112198; x=1741778864; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:mail-followup-to:openpgp:blahblahblah:
  author:from:subject:date:to:cc:resent-author:resent-date:resent-from:
  resent-sender:resent-to:resent-cc:resent-reply-to:resent-message-id:
  in-reply-to:references:mime-version:content-type:
  content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=wBUhJ152GHe2B/u/Jjmrs2WR37jPSt5pIFCtH/3RDsU=;
 b=AuhX8Irpoqy0pA+tuBSTxj1uumE3DBTBDGF91PgA9+Cov9F/cbJgTcsmcx6CiTM3n3cHZpH0
  TABVnkNqIFWWD8uEaCBJ7O58O4uPJX8FOmyDW/9kxxjUunlGlVvvFQKgxbGbF/nV3w9yYNDtZK
  iPmnpSvvetTjJ1iG5rNdFzoe/k9qFLzEDq78YJ0wVdAQwu2lYfhMpnBr/L8NXxXxY/MEnU7Z5x
  Qgcl8qlmtHAu49j/Y+0UDBgJRIQMMZ5T2ysyL8nWBauro+ewJ4DHn5e4hFrw8wiyUTS/h2RvJ0
  8eSjgxJYDdEeLewwaPdiaeQSntQIN33aKxNeHxoN9BRyQsHw==
DKIM-Signature: v=1; a=adaed25519-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=orange; t=1741112198; x=1741778864; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:mail-followup-to:openpgp:blahblahblah:
  author:from:subject:date:to:cc:resent-author:resent-date:resent-from:
  resent-sender:resent-to:resent-cc:resent-reply-to:resent-message-id:
  in-reply-to:references:mime-version:content-type:
  content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=wBUhJ152GHe2B/u/Jjmrs2WR37jPSt5pIFCtH/3RDsU=;
 b=XjKT9xfAdk49LApRZO/OwNbPz6QWBMOjCTotMiCVANXUp/QB7AKBZMkv1VLxKZ4hxSHiEyrB
  nVl8eAj53luRCQ==
Date: Tue, 04 Mar 2025 19:16:36 +0100
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: meson build: datadir missing?
Message-ID: <20250304181636.CEUTB9ed@steffen%sdaoden.eu>
In-Reply-To: <Z8am0ZmkJ7QD13_g@pks.im>
References: <20250303203320.lP10PHC5@steffen%sdaoden.eu>
 <Z8am0ZmkJ7QD13_g@pks.im>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
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

Hello Patrick Steinhardt,

Patrick Steinhardt wrote in
 <Z8am0ZmkJ7QD13_g@pks.im>:
 |On Mon, Mar 03, 2025 at 09:33:20PM +0100, Steffen Nurpmeso wrote:
 |> I opened
 |> 
 |>   https://git.crux.nu/ports/opt/issues/18
 |> 
 |> at my linux distro ([ports/opt] git: creates incomplete repos),
 |> because hook etc directories were missing:
 |> 
 |>   warning: templates not found in /share/git-core/templates
 |
 |Okay.
 |
 |>   hi. thanks, i see now (after looking around). it is a fallout of \
 |>   switching to meson, that build system seems incomplete
 ...
 |>   but that "datadir" does not happen to be set at all it seems; is \
 ...
 |"datadir" is set, as it is a default option provided by Meson itself,
 |and can be configured with `meson setup --datadir`. I've also
 |double-checked the logic how we set the template directory path, but it
 |does seem to be correct: our Makefile sets up a path relative to the
 |prefix, and we do the exact same here. Double-checking on my machine
 |also confirmed that this works as expected:
 |
 |    $ meson setup /tmp/build --prefix=/tmp/prefix
 |    $ meson install -C /tmp/build
 |    $ touch /tmp/prefix/share/git-core/templates/foobar
 |    $ /tmp/prefix/bin/git git init /tmp/repo
 |    $ ls /tmp/repo/.git
 |    config  description  foobar  HEAD  hooks  info  objects  refs  reftable

Thanks for all the effort!

 |So I had a closer look at the recipe that Crux uses for building Git
 |[1]. As it turns out, the issue isn't the prefix or datadir, but that
 |Crux enables `-Druntime_prefix=true`:
 |
 |    $ meson setup /tmp/build --prefix=/tmp/prefix -Druntime_prefix=true
 |    $ meson install -C /tmp/build
 |    $ /tmp/prefix/bin/git git init /tmp/repo
 |    warning: templates not found in /share/git-core/templates
 |
 |This is a bug that has already been fixed via bd262d07b65 (meson: fix
 |exec path with enabled runtime prefix, 2025-02-26). I'd recommend to
 |backport this fix or disable the runtime prefix.

I will pass this information through, thank you.

 |>   Only wondering why this happens at all, and is not covered by its \
 |>   tests, really.
 |
 |Things like this are somewhat hard to test for as they require a proper
 |installation.

Sure.  I just did not know about the meson stuff until this issue
arose, lots of things seem to happen this year regarding it, there
is a massive flux etc etc.  I did not want to piss somewhere,
sorry.

 |[1]: https://git.crux.nu/ports/opt/src/branch/3.7/git/Pkgfile
 |
 |Patrick
 --End of <Z8am0ZmkJ7QD13_g@pks.im>

Thanks for git!

Ciao, and greetings,

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
