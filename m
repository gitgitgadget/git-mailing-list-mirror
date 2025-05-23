Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B572DCC0E
	for <git@vger.kernel.org>; Fri, 23 May 2025 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747984677; cv=none; b=QqfoK9QH1xVf5r/yGg7jnwcR+ffEo71g5vPxbRuJD4aKs5xZnVj+InImWsxqTrK+rRvV554XSfERiWAgAcRDUVf16PNOI4tC5Vf5+yOItIuWvJ5OkKQgN/Hr3USRHXDv5TYun1xH7Je5G1s2Iwmnl+FYZ8TGbLLjnS6NedauvjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747984677; c=relaxed/simple;
	bh=FAOplS4EjpJiweaSl3gtzPPEqdmt36mkNVoiz2rr8/E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VTWkIW5zCd5ixD9XX7xAfJy0QcTn0PfXjHy1ueOynRfIQ0UHcPVNzPDBMiKl+HepHK2IREkNgw8hgYw+ltSwkux1KEMt8/QgVZ2v+ah814GlT5TZx0IX2h/OhhufzrO5Xh80k4IHjP8/wU3U85/crQ806zICcfvYPbmN9oIxNBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpgz11t1747984636tefd3dd1f
X-QQ-Originating-IP: vzzYXJDEcTD6Wl7MirUkVR4c1iM0sYYfIQ26u79dSck=
Received: from smtpclient.apple ( [58.213.8.94])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 23 May 2025 15:17:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6046107806945990938
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 3/3] pack-bitmap: add loading corrupt bitmap_index test
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <aC/B21ZYCixgFSfe@nand.local>
Date: Fri, 23 May 2025 15:17:05 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CD2E6414-76C3-4A0B-A625-C3146BEF2686@smail.nju.edu.cn>
References: <pull.1962.git.git.1747052530271.gitgitgadget@gmail.com>
 <pull.1962.v2.git.git.1747732991.gitgitgadget@gmail.com>
 <5be22d563af714ebb902506f12b4468a5348896c.1747732991.git.gitgitgadget@gmail.com>
 <aC5rCRJd3GaTNgL5@nand.local>
 <013153DA-8314-429B-8408-9A79A3304013@smail.nju.edu.cn>
 <aC/B21ZYCixgFSfe@nand.local>
To: Taylor Blau <me@ttaylorr.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NvjhxCSDgXICTYmzxuODQF1xu2b1L5MRvrvRUJoUekX/h2QTgm40ugPJ
	vsuSfxOZ/5BY0kqpwUP4pHAOw87c30pm76729FjQwwcjGHG3lE5OggxdOmXMC2m82VGWPwp
	Il1IVWIKIAlYCXGwB2mQzNH6y1H0SFL0tlc86Tjc/TQXOAVjuEsRIhb6mv4rRA1aDO4gt0F
	pE61opLGzJDd5YOf3ZqWvGunFp547zdeF0SrGU8HFQJEldh9XaEpWleneELzccdEhodqf3r
	EfwE9QR3RdBSz04m43H3swttSHI8RiS/z8ZHzObDEzgtN80JtHoqHbBtK1nxiYASKFxvcgW
	CGqHyon5T4l36jO/bVquwh+WV/TYfCwuJ3la2ZVBgHihqPEPKCKPe8XDKYTs9Q61FXgYoj7
	aoYmlEiorW7QgJrdAm/zIrkDWlo6e1rRTx+IYd3k6IOZPRgkO6xPIa2NAkNyWqv59IkIYVd
	Sjtw1V1GvALuILoTFuf/hXm2l4lkEPv6xzzD+Xre0aadTmAEnqfRgdf8jXTlFaIPLSuAAPL
	ed9I/opBsJ3NtSSFGZezwieodaBSU1gZpAFfGAacGfll8JjXxlmF2pkkBX7mlL0UXwsGhgu
	Pq73zFCjKK7/esgPtDyeca6jqkSQEnbTH18ezdfVGpxNhl3BO5JUHKZ1ou0aU9p0nHe6bd9
	qQcGAX1k46umRoToEmXedeRvneGkuSlWmGrgGtY1OE1jEgDf23ECzktbwnVUKjRbJBy3oeB
	cOjdV8zPpe7J2d9MIgHQCJEJfFRJPau1XibI8tRxePdIrpwTFK60HDTINmfqe5QM3hRSoiM
	t9UfY3fCHmRxqyY+TFK7gR3iNVEPlCOLcAn/9qEfjp0zBK70Er86loS0HYZh3sIRs00botO
	kH4pno06A4+6RaxumwWC8pE0CU8ei4Ke5mGIaj60eYvrbn3oscMZRmTVu/pw6u3T2kBM1fK
	nnVer7wgC0fqG6F/MOHAK+DZuWi6VFduCqmWZe0lJrZF9fA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B45=E6=9C=8823=E6=97=A5 08:31=EF=BC=8CTaylor Blau =
<me@ttaylorr.com> =E5=86=99=E9=81=93=EF=BC=9A
> But the (elided) code below isn't quite what I was thinking. I think =
the
> "write garbage data" part is fine as-is and can continue to be written
> in shell. We have lots of examples of using dd to write garbage data
> into files (see for e.g., the "corrupt_data()" function in t5319).
>=20
> What I was thinking is the test helper would print (via some new mode,
> or bolted onto "list-commits") line-delimited output like the =
following:
>=20
>    $COMMIT_OID $BITMAP_OFFSET $FLAGS $XOR_OFFSET
>=20
> or similar. Then you could use the output of that to determine the
> location (replacing everything up to the actual "printf | dd
> of=3D$bitmap ...", which is the most fragile in my opinion).

Agreed, I would add a `test-tool bitmap dump-entries` helper which dumps
the output you suggest.

> I think the above scenario (writing a test that would have leaked =
memory
> otherwise behind a SANITIZE_LEAK prerequisite) is reasonable.

I will submit patch v3 with better structure and cover letter soon.

Thanks,
Lidong

