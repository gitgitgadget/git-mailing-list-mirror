Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C924523EAB3
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785658893; cv=none; b=CkpfM5nI+EPmHnYBzzgGOt1lLmNohHLuIgIQI25PdtiEEh2/jfhWbAO+Hot6Gck6cKAuLd3fEXyxO0cBC6gwnzylgAqghL+o3LogQ2kiI9STOk1qvXVpVTp9SFKdMJj8kvRGeCE6d0mlVi0LlNzVITA7nykU4/ErHZRuSMHxa+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785658893; c=relaxed/simple;
	bh=Rfp/RRrOfjvcw9u+BvTxvyU8FMK0IYkYQULV0cKvYlI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bwaBirORXLIjc24CnhZURyJszmg0DPk0PZ5ITyUwoBRVuankY6xFEhPGsl52FtKDI3OnPff/+S72MfeUh3DWT2mS8VvehVGzCL7LiYtqJbAtXl8GVu3yWYSyyxC0z9xFSNdNsJQv8baXaWnIHQw0rv+EAUg72fq6B0E74Cw4XEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=ikDuCvq5; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="ikDuCvq5"
Received: from cixi.localnet (unknown [IPv6:2a01:e0a:b3f:5350:b6e:bf81:919d:c0f3])
	(Authenticated sender: tnemeth@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 2023113F861;
	Sun,  2 Aug 2026 10:21:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1785658883;
	bh=Rfp/RRrOfjvcw9u+BvTxvyU8FMK0IYkYQULV0cKvYlI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ikDuCvq5mZxnRpkA1Nz+G7pVrfHWPGOB9w5rqWWzyayReYzvd3kL0TwRi8BtuHyOM
	 xaqMR4zoPPuEgEJEnFEoSoclmVSQj7rq5WYAek/Pi/QMhyxQEA5MOgSzJjuVrG0MF1
	 KpixJpRMoRK5+GnNLRCKeQGpfkuKJWvUcsn/OesOfVdGlRl7R93EfRWMECUePzAz/2
	 y8B35OGHXxgabUV754Wj/LZl8TcnJ7Bm6XiEGxj0+YMsflkZeAfWK21l7AN2XRrAUd
	 by0+MeEwvfS+minMKuBhYwrKv6ldbBJlHa9et/D9Ob5ZbE4xsZWOcNZ3iCNfpb9ziA
	 sHQqzPkdT2XXg==
From: Thomas Nemeth <tnemeth@free.fr>
To: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: Git trailing blank lines feature configuration
Date: Sun, 02 Aug 2026 10:21:21 +0200
Message-ID: <2845859.mvXUDI8C0e@cixi>
Organization: =?UTF-8?B?ZMOpc29yZ2FuaXPDqWU=?=
In-Reply-To: <48771457-9f10-4176-897a-f8af2606bf2d@kdbg.org>
References:
 <5097209.GXAFRqVoOG@cixi> <3433010.aeNJFYEL58@cixi>
 <48771457-9f10-4176-897a-f8af2606bf2d@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Le samedi 1 ao=C3=BBt 2026, 23:05 Johannes Sixt a =C3=A9crit :
> Am 01.08.26 um 10:48 schrieb Thomas Nemeth:
> >     If I need to move a previously static function at the end of the
> >     public functions section, I switch to VISUAL, select the function
> >     to be moved with the blank lines above (I like having neatly
> >     spaced
> >     code) _and_ including the eol of the function last line.
> >     Then I delete it (d), I move to EOF (:$). As the line is blank I
> >     just have to paste (p) it back there. The function is moved. The
> >     last
> >     blank line is kept for other code movements.
>=20
> Sounds like you are using character-wise visual mode (v) instead of
> line-wise mode (V). Use line-wise operations, and these problems are
> gone.
>=20
> Oh, and BTW, just use G instead of :$<Enter>

    Old habits don't die easily ;)


=2D-=20
Thomas.=20


