Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CD6D515
	for <git@vger.kernel.org>; Mon, 19 May 2025 06:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747637107; cv=none; b=SZY3gbeL2EebRsN1wnX5iQojz6wIjmI4+JlcDWkCJChpyCM+7TiZ//0J/ejFbr38gjWFOWfayTEH1ZisoBNODfyOKaB449LkAAQ0LMvoy+RAC1ALmc+Yw65ao1jFnLt9G5gBzmtWCDKwEHKyL6dO6qIng22Cs1ijRRbCvzl/dt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747637107; c=relaxed/simple;
	bh=n8yYfN9TgqayXsQNrRl+ckqHRh9eFbQB2os5omogGDs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=a0rUdHU/Ib2ETzeUp6c4SWJLp/q+ZuKYH7VAqL7IAC4DLDKb3oaY4LXwvDtdIPTENqR2nGwfYz+i9AgyZ01rZ5h6OHM22aAlg94VOJVc8GpXtkWbuJ+0CxPubbHQY+AsRBdrPZHMS3HV2EU0li2mCpbDFnmhpqsPsgUIjoFBed8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpsz20t1747637074t415908da
X-QQ-Originating-IP: o5vL5PuQbvXbpEO6usH0Y3tLJVnJCOGMUpiS5Uj6RcU=
Received: from smtpclient.apple ( [36.152.24.178])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 19 May 2025 14:44:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12536741223101506131
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] pack-bitmap: add loading corrupt bitmap_index test
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <aCrJcK6ml4r4S-mF@pks.im>
Date: Mon, 19 May 2025 14:44:22 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <80BCF957-002B-4532-8E3D-8CAB45AC0349@smail.nju.edu.cn>
References: <pull.1967.git.git.1747491983066.gitgitgadget@gmail.com>
 <aCrJcK6ml4r4S-mF@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M182XWJxg1fq184EN5apeV+kIfBH3SgBdu+v6kuBjw2QhvhaiGSYikB0
	52frlwUEKSmXpbeJs0CZ9tjLdQ/SC8ATQ1VWHv4ZseqpBg1xwRg1NRv8IxqjJPi3UlrvoFb
	ihXNZ0ElWB+CXMag/ET+2zY0QhPCslpjZJYBGfvYdbsU6G0Q6taAho4CYOkf/XGnGtInofT
	7eD8qokqWd2oLj0HRuogP6pTuGZ1HHRZWVyU+usXQGmJgneKn2serdT+NFikD7EK7kI0ReX
	x61y+EsZofiN2lNxsnwm0RMxyb2DmYyuugBC0ThzDkz5Mmv9VY6+av6qoIQRf4BW0MBIOO9
	Ctx579KsDOdFWs4xIcD8A9pSIdt9WJRIYgnKYKIp5oyswEV5mQ/9RYIiQFt1sByl76RPZjk
	fSBVzVPkygAd9jdnf1/KqoWyKKgot5WQ82b36b+H5RRGczqJG/7/ZdkavJ6Svu5TXk84muZ
	nuwU/3eYcNeaBzx4PCrPmpDyostbvM4phhKni2g0SnvFHADJ1GD370dbab0mOothlUxE3hd
	1jZQNkoZM/PoxEOvlLx0umT9zDEGcSCMNGVNEtrgvgbygkLY9CMUIwf5nbTJXvmaOaPHQz4
	wRlZs2uHa/h49oobCRe9KpdssQ4zBht3HA4J9nsVUrzXMQYsQ+uOJDLb+kxVbmzDF8ss1ZW
	ILcGwS5tIgLfJR/y93Bu8wCC0E/3g2pUdXHjLIOgR4sameFeJEqzqxJoPW+SOLWJBSTblhx
	wsOpsMtU1jx3rW1sbMpWJcFCXnaCV558PzRm8S92mWd8WZPdeNgZ+Aqw4NwQjpMN4RjFgw8
	W92WJb/ekYYrR9s+2NHd09CS6XEwop3OO6fNPVsuQlSPWghd65axQn48I8Xoq5UQAqrHtIj
	ACCcBuZ2VhfbTii2dV3r1cyZHFUKEs708ThBh+UVQrlcm6phHenNnonqi3BF5KSwsFFAYlt
	4qy5NlICxEONsq70HOodfPnFmcaAcHo6hX7IQhr8CXMPtyQdMfeNTCu/XPm2s8fluHwJprk
	od5TCJeQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B45=E6=9C=8819=E6=97=A5 14:02=EF=BC=8CPatrick Steinhardt =
<ps@pks.im> =E5=86=99=E9=81=93=EF=BC=9A
> Okay. We _can_ do that now, but the patch doesn't explain why we
> _should_.

The main purpose of this patch is to provide a test case to check =
whether
 a memory leak occurs when loading a corrupt index file as requested =
here
=
https://lore.kernel.org/git/20250514180325.GB2196784@coredump.intra.peff.n=
et.
A potential memory leak is mentioned in this patch here =
https://lore.kernel.org/git/pull.1962.git.git.1747052530271.gitgitgadget@g=
mail.com/.

> Does all of this logic really have to be part of "pack-bitmap.c"? It
> would generally preferable to not have our production logic be =
cluttered
> with test logic. Sometimes we don't have a better way to do this, but
> you should explain why we cannot host the logic elsewhere in that =
case.
>=20
> My proposal would be to either move the logic into "test-bitmap.c", or
> to even better to write a unit test in "t/unit-tests/". After all, we
> expect that the code should fail gracefully, so a unit test might be a
> good fit after all.
>=20
> Patrick

I found that the header size of an index file depends only on the type =
of hash algorithm.
To trigger the condition for the memory leak, I need to corrupt a few =
bytes right after the
index file header size. It's more convenient to implement this =
functionality in pack-bitmap.c.
However, I think I can place the test itself under t/unit-tests/.

