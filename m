Received: from mail-vs2-f36.google.com (mail-vs2-f36.google.com [74.125.227.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0799B43F8CB
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228451; cv=pass; b=TJFqyV6kFVvw5HIOVIC25/OtCyvpBWdgNxbjcYzPizaf/KlFLLNk8sGVk3DweE8ixO7SRg2gczglXsCwcqFTtuHxPAeuETaxRVTH2AsscQKRpaqpOAAflsrr9i84jhihT7AJKprY8zwz4Kiz1GJ+/paG7cM8pAkDnqVcMufmYyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228451; c=relaxed/simple;
	bh=LccgVgk5uv9LAaWxIXD9AmbpqBs8DydRVtfwyW7ae5g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=RCG7rBOGMgIo4jCygmm4hvpJgzMm/GM3Y0wR3bwpemKqpSSTAF+I1FCAXjR72iz5/X/GyuFaXOn93sFox8Ed9hHIQFRI9uBYCZX3KvX/mN9ZbK/NmgsLedLMpRZNchtD3FEKqVVb/mc7HfVKkNlUPNWxiPhFD+KcZ1g7IrBGlkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIN+v1dK; arc=pass smtp.client-ip=74.125.227.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIN+v1dK"
Received: by mail-vs2-f36.google.com with SMTP id 71dfb90a1353d-5d7274a41d8so1107367e0c.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 12:27:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791228449; cv=none;
        d=google.com; s=arc-20260327;
        b=gRQjysk5/SSfoPb1Dc/OUk/HGxCDYG0bIU7xeBx0tonSm4pA7I6CHqEpRy3Ym1B5IW
         ErNl+OhwKubbcmmE9BjPBkuHbJTvx8Z7XPL8fj32coH/+QrsEkVb2P9QdxtOdkGckXYm
         +TX46f0zn3mVhPEEIQPUu8r+eq/xkZaGp48S8gAABMC/8lVaif7WTiXc8/9DcAGxztq2
         sBQOd/Im3Lurb6Qz3X9qIgk0qe1eAI6qDz9zvOupnvjge2pTW1OWq735Ko3wGr9fUlWf
         cQ/igaBDFm9h0dfShgIgeuJMPSWYxN6rQvERuIcee+voy0T86MNs8lWuAY0Jwuw+73Oo
         oPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=LccgVgk5uv9LAaWxIXD9AmbpqBs8DydRVtfwyW7ae5g=;
        fh=UJuCIHMT5Tj4AmplMNOnDFtlRuAIDl/lB2eRADGWYw8=;
        b=rCWDjBwZMdDn7fnDvwfMjzZMdOgTRQYtjvsXgvzTtPP8ZR7bTIR5XoJpND1HX94v+n
         wnonovz9DSZflhIcsKRM+qF1H8G4lX8CjwqJ0L6u1+99WwRYFGfzOjYTB7JHj8u/Sp4s
         XTIcHvLcEH/95ljUR8dNdiSK7OStp26aINHPYYY782CEwUbyPNcV68WAz1aUi9joxtEl
         kYo/v8h+DHnKPIcVcaRzimxugtAe6tjOkN8j3nF4We1/F9oYbk4vp/DvR48BUdGphchS
         L1mWqxsjOXBE2aTwid6x6o2txzr2WBwvM11BSfHui4SaXFKV7wxfAPCVeSFYAx3ob4qJ
         fUbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791228449; x=1791833249; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LccgVgk5uv9LAaWxIXD9AmbpqBs8DydRVtfwyW7ae5g=;
        b=DIN+v1dKcGz3m/MIO65AJOJOmhLYSIDpxdjhAHzw4knSlt66dKuhB3n6e14lWhQgHl
         FM+J5VrHxzjeEKPLCD62ZFIBSLCx5tCKx57MVxyYVnTgfRre+u4ecroRmcVRLIgsJTFY
         ASWf1vVGZWLM2k2P2Yvfl5nyl03ehKHg5GW4/EiX5g2ASjMnMv15aYciCQB1SLVwawUs
         r4B5Ouy/3N5GdMSV82+BrTAZe+0wMYYkJomSe0DdThwGk7hV2AFO7azTaR7KKXi5WjcY
         RjccWRPST4s2/uQJSo312IG9gYLZCQyvUL0QtwriFG4cjUFfm36/AhA1ssRkFacJGtfr
         cL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791228449; x=1791833249;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LccgVgk5uv9LAaWxIXD9AmbpqBs8DydRVtfwyW7ae5g=;
        b=El6QIAWGF/0VxT0zf1a9LvuYcEBOVAHOffFPz/ENmbZs9kGKTRDrm6I20EBkvsZhFQ
         EbNxN8+bH27l2Y5OJJ0lEvcbdOJQg37pDqGykoQr0PXwVxBaEmx21nv3FnXB1AtKn0y6
         +1bGZXb+bI73MLBnWBoniYf1sbGruAlShcap4oHv/0FKqaieOwCWz+uANO5NGcrnow9n
         EfkF5+iT5ioAskKUvJTk53yZ6fCoKWqG9gx/aCIWEi3qxJD4bXkNts43E76rIQvE0lYe
         +PBF/vO2ui3BvoIS3pgJWaq7VAjdJM8ebsunRJq2vNF2694cLRH8y0DsF7H0n4NVLxxW
         Ci1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzabRS4C9xYU7E071H8F7BbO33brxCDOhMzLPhNp+X7PsuZJlCyKMWH487aSCHgFUgVUjA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPvmCRtB0T0R0NQHcnueos0clEVbH7p1dxqhoBh5S9ZeIu5Qgx
	UcHhV+WAg1kcv2QzZSUam1DqsXoNxAzbZZ9hQWIuows538RGkqBoXE3ow1OEZNiiDcJhAGbAePj
	Gqge7yEdqxu94lmKtNwmZqHDE+LVmKQJ8/A==
X-Gm-Gg: AYBFou11madRJ7Eg5OcmJBdQv1GQGZQi3/EVzrAM4dpXS/WJne9InE0ODKySUKCoY1d
	XzCeic6cKUyt2YrruhGdBOCp10rkgvup2BwCdMBBNHCQ6HVEUVcPYdBbrZQ8FMJydy/huSFfqQS
	df8krdDE5RzBBi7hec0x1E6dDihukiZyNDh+E0Sj4ZAdYkCeLcS9/+eg0WTi7yLIj3jBIZQ7OQf
	XUwfn+CnzgHhCzrpCOgZifvdDSt8BhoVW8W4VOJ9pXPMic5B9pHpV+61sTA5DpY6cm4tYJ/JgJn
	Rw4nz1FZYFsp2jlS9U/57ha2vIO6d9J+OxUEEsiqQ+kogEX9CiMhv5HBTInxFxeYvINCY4lh3Gw
	azbi27soHOxPqSsZAqs51euNFvAocN+saoi/1H7tuuKlC1w==
X-Received: by 2002:a05:6102:1591:b0:7bb:c382:2ff4 with SMTP id
 ada2fe7eead31-7c0f4fa60c1mr3424782137.20.1791228448884; Mon, 05 Oct 2026
 12:27:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Oct 2026 15:27:27 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Oct 2026 15:27:27 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261002-pks-odb-move-alternates-v1-1-8a63507b88c4@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im> <20261002-pks-odb-move-alternates-v1-1-8a63507b88c4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 5 Oct 2026 15:27:27 -0400
X-Gm-Features: AclHuK9WXuQckgJjwvGbIksUq3bL7VKvtHyawT_ZbzqxaECzd7FkUGN3qa3mAA4
Message-ID: <CAOLa=ZS_S3bYXEufor7AgXpX76NwtV4NJdGRO57-bpSkYZrzvw@mail.gmail.com>
Subject: Re: [PATCH 01/13] commit-graph: require resolved packfile paths for `stdin_packs`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000686729065d1cdfea"

--000000000000686729065d1cdfea
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Users can ask git-commit-graph(1) to write a commit graph specifically
> for a set of packfiles via the "--stdin-packs" option. Those users are
> expected to pass in relative paths, and those eventually get resolved in
> `fill_oids_from_packs()`. This ties the logic in "commit-graph.c" to the
> specific object database source.
>
> Refactor the logic to instead require the caller to pass in resolved
> packfiles to untangle that dependency.
>

Nit: the changes look good, what I'm missing is 'why' are we doing this
change.

[snip]

--000000000000686729065d1cdfea
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bfea9dcd2e3fabda_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yRCtoMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNzIrQy85SXZyQmQ1VElXdm1nMkRpZ05nR3J1RDRpTgpwbmNhcTd3b1I0
OEZxQk01ZDgwSkMyeVBDNXRDck9HUVNqemhZcml6Z0kwSFRZWjBEWVFXZkhUblJFSnRsOUhhCmpC
eUF1K1VjRVRUT05nZ3ZDRkMyRmtPRlJyWmgyOExTb0xtbmp5RGMvSVFCUGw1NjRHL2lSNzMzYTBK
MVlZQ0YKamt2bG5kWXQyS1NaclJNWGMvVnZ5bjI3K2dHeFlZcXI0V0drVlg3UTZOSEZiUE5DOTRH
eXczaTN4WXhrdjU0UApQaFpIMWVEV0pHeisxUTk5NXl4RkF2OHdqcXhOZ1VlcC9MMko5ZWMxWlV5
eUkzTnc1YWN1OFdNYzFaZ2prdG5ZClFEOGVqdWpsQU8zQTJOQ20vTFNSQld1ekRGeGw5WlIrd2lP
SGdpeE56UjlwTUVvOWx5eUt1cFhnaUJUMnlrSXkKQ1huNzNQbTlrK0ZaS2lOOURaR1NJdGt3WWZD
UU5FbE5lQUYvNXBBQy80QTlaV3pUUFdubmVxdU51UkIrZGtTTApUVHhRRUV2ZWVqeXQrYWpJc1Nq
bGRSeEJ1WnRtMlgyeWVOQXVzVndwOEJBang2MVRwSlQwZ0xuQXJPWlRVTUMyCnk5WE50b3hzVW1x
NmVReWdwbXdWN0NCNlpscGNuMWUvaTBETksraz0KPThHTUEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000686729065d1cdfea--
