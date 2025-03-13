Received: from uggla.sjd.se (uggla.sjd.se [178.174.241.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FA125FA1B
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.174.241.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852808; cv=none; b=IPBrE372ZNKYgYHc20KlJeazK7GHg7Cm4NNX8FW39R3JYchyDUoRI9a3HDGbt/Zue59jjC7RT0EMXFVk8uNnuOOX7Wb4eG+HkZt+xkfwIQedcF05r6uMT/ldqBZKNJoRcTy0RHVM4UQcBR0vHGA6cu8a3kq2AlVtdkaBofk9Rbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852808; c=relaxed/simple;
	bh=FlFKxiM9902OsBWGM572eQx2xtoEmndFXXGHRYtGWqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MmcPxWxtYUlPdMXRD7iqGy9WPg0Em7roaVeYKZYRoH5Hffaz3Liih+wcVQX7dPm8h4UWgJHRUun+4trxlKceKC6FRegSs3u6vVO4Wf5Vk5YyhM7lr0Sq1FF3qSs87LLQDgaY5E9C1GbTWQD9YCA3EV4hDlhdjOhZFBJo0VJO1AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=josefsson.org; spf=pass smtp.mailfrom=josefsson.org; dkim=permerror (0-bit key) header.d=josefsson.org header.i=@josefsson.org header.b=0eFIxhfg; dkim=temperror (0-bit key) header.d=josefsson.org header.i=@josefsson.org header.b=l55D1W9o; arc=none smtp.client-ip=178.174.241.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=josefsson.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=josefsson.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=josefsson.org header.i=@josefsson.org header.b="0eFIxhfg";
	dkim=temperror (0-bit key) header.d=josefsson.org header.i=@josefsson.org header.b="l55D1W9o"
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=josefsson.org; s=ed2303; h=Content-Type:MIME-Version:Message-ID:Date:
	References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f1IYaS2H/YwLNTZTuqOeE0IXU2tuiav7oYkTnhcqIS0=; t=1741852794; x=1743062394; 
	b=0eFIxhfgW+C6Fx5DWTTMZqPcWka/msPb/M8ccJCTV7aMHbpCzb2vsV0gFCZGdtwm68VGXkAxhfd
	oM3INRrsLDg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=josefsson.org; s=rsa2303; h=Content-Type:MIME-Version:Message-ID:Date:
	References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f1IYaS2H/YwLNTZTuqOeE0IXU2tuiav7oYkTnhcqIS0=; t=1741852794; x=1743062394; 
	b=l55D1W9oPhQUnTu1Tr7EaiVPjsDgBBxQWxELUOBLLg8mXoEUpescW25dQjiVV/1WaSI/cFyZDvT
	MDANEgXYjz9ImhB42FFuDf1XkPjdBubHIHgzgAMD1bdzRMqxAeZzcaXzLiJtpwSPyAHVfSTzQk2MP
	xHiPKE03ymlKPD4uSKASsIKv1US+1ebdhSYIRTACgpJq5oSB++VjOvjsucAjHarsSNhsEJT0VCEiA
	As7V5l8g6nlkT5SWMv8FbLTO+1dZXDi5gEPHl3FfdxgQeKTcRT+dVGwzct5GkcA8NsgtQwxQphBYL
	U/TtdYCkoWCzVlXJ96OmwwyItskK46kXKhGcQyPrPphzuLjtgQ6uhfhSAq2CJ+nB2rwiILzL/reMU
	tnwJbyxaiybHc/oPVBdBGVrH8I7gkYpTaA8IR7HV8L5OsWasa+YQbMyKcERZkVtcL/h+LQtmt;
Received: from h-178-174-130-130.a498.priv.bahnhof.se ([178.174.130.130]:36418 helo=kaka)
	by uggla.sjd.se with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <simon@josefsson.org>)
	id 1tsdTr-000892-Fz;
	Thu, 13 Mar 2025 07:59:51 +0000
From: Simon Josefsson <simon@josefsson.org>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org
Subject: Re: Making bit-by-bit reproducible Git Bundles?
In-Reply-To: <CAO_smViryqTa1LfQSsPbBYcSvijs-UkYkHaot3CK1j=uiuEppQ@mail.gmail.com>
	(Kyle Lippincott's message of "Wed, 12 Mar 2025 20:09:03 -0700")
References: <871pv2jx4a.fsf@josefsson.org>
	<CAO_smViryqTa1LfQSsPbBYcSvijs-UkYkHaot3CK1j=uiuEppQ@mail.gmail.com>
OpenPGP: id=B1D2BD1375BECB784CF4F8C4D73CF638C53C06BE;
 url=https://josefsson.org/key-20190320.txt
X-Hashcash: 1:23:250313:spectral@google.com::Hk2Z1SpRiUuDwD/o:3R9X
X-Hashcash: 1:23:250313:git@vger.kernel.org::g52Qlar4esUDPmFf:BJtS
Date: Thu, 13 Mar 2025 08:59:36 +0100
Message-ID: <87tt7xicnr.fsf@josefsson.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Kyle Lippincott <spectral@google.com> writes:

>> Can anyone explain what is causing the irreproducibility?  Running
>> diffoscope is not helpful, since the bundle is compressed and diffoscope
>> doesn't seem to know how to untangle it.
>
> Spent some time on this, and when I followed the instructions, the
> diffs were in the pack file portion of the bundle file, different
> "tree" objects were produced at different points in the pack file. But
> it produces identical bundles if I run `git bundle create` multiple
> times in the same clone. My guess is that the non-determinism is
> coming from the clone process being multi-threaded, meaning that the
> order things are created in the filesystem during the clone,
> presumably due to multithreading happening during the clone process,
> or maybe during gc? The contents of .git/objects/pack have different
> hashes across my two clones, and I haven't investigated why.

Yes, my perception is also that the reproducibility problems happens
during 'git clone'.  Within the same git clone, it is no problem to
create a bit-by-bit reproducible git bundle.  But if you work in two
different clones, I haven't been able to find any set of commands that
leads to identical results.

FWIW, some other ways to do the clone that I have tried but didn't get
to work (of course I may have made some mistake in my attempts):

# dumb protocol doesn't repack the objects
GIT_SMART_HTTP=0 git clone https://git.savannah.gnu.org/git/gnulib.git

# using rsync fetches .git identical as upstream
rsync -av git.savannah.gnu.org::git/gnulib.git/ gnulib

>> If this is not possible today, what do you think about changes to make
>> this work?
>
> What is your end goal with being able to reproduce the bundles?

Good question - I should have made that clear.

The end goal is for someone other than me as uploader of the gnulib git
bundle to be able re-create it bit-by-bit identical.  This pursuit is in
the name of improved software security supply-chain security.  Compare
efforts to make gzip and tarball files reproducible by others:

https://www.gnu.org/software/tar/manual/html_node/Reproducibility.html
https://www.gnu.org/software/gzip/manual/html_node/Environment.html

> Producing an identical bit-for-bit bundle might be doable by doing
> some form of sorting of the objects in the pack file, but this would
> only get us closer to bit-for-bit reproducibility *on the same machine
> and versions of everything*. There could be some changes to git, zlib,
> machine architecture, etc. that causes deterministic but different
> values to be produced. As an example, maybe future versions of zlib
> compress better, producing an equal result when decompressed, but a
> different compressed result.

That is an improvement compared to todays situation where nobody can
reproduce the git bundle at all.  Being able to reproduce it using the
same environment (toolchain) is better.  This is similar for
reproducible builds of binaries: typically you need to reproduce a
similar environment to get reproducible results.

/Simon

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQNoBAEWCAMQFiEEo8ychwudMQq61M8vUXIrCP5HRaIFAmfSkGgUHHNpbW9uQGpv
c2Vmc3Nvbi5vcmfCHCYAmDMEXJLOtBYJKwYBBAHaRw8BAQdACIcrZIvhrxDBkK9f
V+QlTmXxo2naObDuGtw58YaxlOu0JVNpbW9uIEpvc2Vmc3NvbiA8c2ltb25Aam9z
ZWZzc29uLm9yZz6IlgQTFggAPgIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgBYh
BLHSvRN1vst4TPT4xNc89jjFPAa+BQJn0XQkBQkNZGbwAAoJENc89jjFPAa+BtIA
/iR73CfBurG9y8pASh3cbGOMHpDZfMAtosu6jbpO69GHAP4p7l57d+iVty2VQMsx
+3TCSAvZkpr4P/FuTzZ8JZe8BrgzBFySz4EWCSsGAQQB2kcPAQEHQOxTCIOaeXAx
I2hIX4HK9bQTpNVei708oNr1Klm8qCGKiPUEGBYIACYCGwIWIQSx0r0Tdb7LeEz0
+MTXPPY4xTwGvgUCZ9F0SgUJDWRmSQCBdiAEGRYIAB0WIQSjzJyHC50xCrrUzy9R
cisI/kdFogUCXJLPgQAKCRBRcisI/kdFoqdMAQCgH45aseZgIrwKOvUOA9QfsmeE
8GZHYNuFHmM9FEQS6AD6A4x5aYvoY6lo98pgtw2HPDhmcCXFItjXCrV4A0GmJA4J
ENc89jjFPAa+wUUBAO64fbZek6FPlRK0DrlWsrjCXuLi6PUxyzCAY6lG2nhUAQC6
qobB9mkZlZ0qihy1x4JRtflqFcqqT9n7iUZkCDIiDbg4BFySz2oSCisGAQQBl1UB
BQEBB0AxlRumDW6nZY7A+VCfek9VpEx6PJmdJyYPt3lNHMd6HAMBCAeIfgQYFggA
JgIbDBYhBLHSvRN1vst4TPT4xNc89jjFPAa+BQJn0XTSBQkNZGboAAoJENc89jjF
PAa+0M0BAPPRq73kLnHYNDMniVBOzUdi2XeF32idjEWWfjvyIJUOAP4wZ+ALxIeh
is3Uw2BzGZE6ttXQ2Q+DeCJO3TPpIqaXDAAKCRBRcisI/kdFonJFAQD5KhMQv+zq
1+S4XOo9nmdLVF7KD306fVvQfGhWvA6inwD+NpVaET6HV/l7erJa4R9DkXa2bbGj
/lkQOHlM3XPdngw=
=AW/T
-----END PGP SIGNATURE-----
--=-=-=--
