Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A65B1632DF
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752347719; cv=none; b=RyZt/3EPxCMWBA1It0NqfjNnaxH8Vi7jrkZmSFSNxEPJfwW8/4FokD8aa6sl/EiSo8wNULOx0bD9MCETIcbGNyROv8Bznu3Oqo0o2WNoE9Jeyp+OVDYlrXeU2V3FjEcJTNty0h7rKk/taLllEUBp4plJVp8CNUOHet+c8xYxGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752347719; c=relaxed/simple;
	bh=y4kwZqfwUOICUkuJ8UNhT2nn8SixFB/V/OFjCIHTFgM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2i5JyDxq5uqUUu1KbE1f6Prr9wVrDRITpLaoOY6OxmIqZLELR5dt2e52hkmTHzmycBnXzl9yfPf/i6MaiqXlIM4tu9gjOFLWqQKdBPI0tQ2sJsXt/eQ1yjzjbjPqZHODPq9NsBRQPx5DZV5vZ2fV3ogCrKsN5GPUROb1kkuVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lha1VpgE; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lha1VpgE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1752347707; x=1752606907;
	bh=y4kwZqfwUOICUkuJ8UNhT2nn8SixFB/V/OFjCIHTFgM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lha1VpgEdh49QE0sHJ5VQckwnsLlpgUSOXunPSUL9krc8cWUZ+hQ6utrPBsx0IWKa
	 Phm62TBzi42PplLClaRtNPnYvr+1JoTczFrRiYnFJk3ftuELUa9YTLJt3VDS1+WMuF
	 VQ0EhRWU/jSocEQVzidJbH+pBQ5IIznjSGN3FDV8m3IlIBProK0MafivQl+90uNB2h
	 wV2bvObPuGTWCbxX8Y8DLUc2d6kDv9uu10H3S4TFcrfHjSxlICffsxV0O5cNHwNTP8
	 +ykHkMwYX18ZY1UlLRIYltdfZQlYnmFtgzKN4tbZGOTALF1/ZxFdW1KDlF2xPV7W5G
	 JjRVy+veT2Gzg==
Date: Sat, 12 Jul 2025 19:15:00 +0000
To: Johannes Sixt <j6t@kdbg.org>
From: Jason Cho <jason11choca@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Why doesn't git core.eol=lf work?
Message-ID: <sAxC2ASixUyCVtsk22zrxI2vAeM546T7O2tyWIS2vv_TGFo2OXWegg8J_r0zGzo5bZOA-BrwHa5yjAv2-Ewusjv9Fa9YYocrRkaIfpxhv_c=@proton.me>
In-Reply-To: <23f2bbea-1294-4773-89d8-b270e2c3bb52@kdbg.org>
References: <8jPyf4EU-z7W6OHX4j_kba2G-1c2RIDtgBcSkFjWSNhMuE6pxOOyxSGBnguoZvuDQSaJPypH0u1vLJf6FBX_ahUn3bBO_1DVscfOQm4Jovw=@proton.me> <QcbAE4JJXpU-NcQ1loYdHthi-nYA2ZXcuuetCHE_0N0fRi0mdaf90VaLk0Y2ehrnVzoZraYO7jLhB7Pl68_k4l3HCqkFVGuMOzZ26cHYkfc=@proton.me> <23f2bbea-1294-4773-89d8-b270e2c3bb52@kdbg.org>
Feedback-ID: 126703824:user:proton
X-Pm-Message-ID: 6d32f934cd84757ca9fb5934d9e45ae0a68ed624
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>=20
> Since you posted `git diff` output, may I ask if your concern is
> actually the ^M in the diff output, which you intend to fix with
> automatic CRLF-to-LF conversion?
>=20

No, my intent is to find moved or duplicated text among files.=20

Let's say license_header.txt has=20

DBeaver - Universal Database Manager^M
Copyright (C) 2010-2018 Serge Rider (serge@jkiss.org)

and another.txt has

DBeaver - Universal Database Manager
Copyright (C) 2010-2018 Serge Rider (serge@jkiss.org)

My tool doesn't think the two pieces of txt the same because of ^M.

Although my tool can do normalization internally, if git checks out files t=
o CRLF due to core.autocrlf=3Dtrue, my tool is fighting against git. git sh=
ouldn't spend time converting to CRLF which is about to be converted back t=
o LF by my tool.

That's why I set core.autocrlf=3Dfalse, and ask git to normalize files to L=
F.

So the problem is that, conversion to LF is not happening.

