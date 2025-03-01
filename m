Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4788923F372
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740833244; cv=none; b=D9EavNv3t/Le7ZT5NIWyF7LMbn6XJczgc1qsdMnrZKQ/XtRjLRWzgLoxDS7I1FxXvDBcOh+KYDbA7pC3gv0iZaPdFEQpf2Eez6/EiiZR8IRRZiZu99lGNGfOpP9EDx/Sa64AjaOKNKRNSYK5cLlHjX9atiQPXoQ7nDs/IYS0J8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740833244; c=relaxed/simple;
	bh=FyFOslAztSSktwPuTV/iA3VF5CukkPr7YOiD1CkACOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ltimfKvqCZOCOFE1Zcwq5Ji8bAh24LTvI/hxgqmPQdoBzdiYCJpAnkhhUZdDrTaLTboRejMdrOSU9xsReNOYsmu8uJbIBYROsP6X1rVjwIE9UCUxO/TwDH9bY+jg6N9pf1EgwCJUyiOSRARG42hWgJI2Nf8jqLP7mmz5RbHZcD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=QBEdHQGl; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="QBEdHQGl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740833240; x=1741438040; i=l.s.r@web.de;
	bh=G1R7+iQljHuVlpzUh0jX3AQKzaTs/zRrFaT0nz4BLfc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QBEdHQGl39eIlLZCZi2ARNOAoTT3J/F54dX2QiWGZQ/pKVZWPB4sMWNShyri7VIg
	 uN4cM0bsCqYAAv3kdYR9KzjRVK6+g5hl4H3+S4CVkaRbAR6n5rN/6lLA6Y1cJlm3b
	 EuK3pNIMx/9fEqW6vss+jtBrA5WzhLoK4lOhM8Q6bThqRN+o0esf4XslvwNVGOQlx
	 lOQKrolpmQW4SYmB8eV32CSGzl1XVz9Cd6tFWF1kKuW1dVhABSe4zJDl8Kt8ExiU0
	 /spiE6QRTYbXdEG4LxsYqkb+/uuVV+Tlw5zVJCfYkfojri+5y7/kD+HIWt8LDFU8I
	 x0tHtxObARLQ1SnzxA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.144.81]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTfon-1tihL83sRZ-00Yjpk; Sat, 01
 Mar 2025 13:47:19 +0100
Message-ID: <6ab668ba-0293-4afc-944f-9bd1299110b5@web.de>
Date: Sat, 1 Mar 2025 13:47:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Subject: Null pointer dereference vulnerability in
 src/read-cache.h
To: H Z <shiyuyuranzh@gmail.com>, git@vger.kernel.org
References: <CAAJd+faaEsTVqfTH=EsjXu8kneP1ZAASCCoaqp9zuODjSnDatw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAAJd+faaEsTVqfTH=EsjXu8kneP1ZAASCCoaqp9zuODjSnDatw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aLckQdDNXjwd0lAHB7vdrNMZfHMRicVEnlzuFDQ60KyNsEARYJo
 qEg5aUBhior7HFRmg7l8QQzve53aWfISBGXKZrHEVisMw9pvM39rgGKSPsKfaVf1ld2wbUL
 Tnd9cwEBnRsrvscrnIFDQsl3vAuyJ3XhnuHHHzMCdqKGNFEUjz+bNy1cHFvudadvrvH1zVF
 jI9vgsewHT4cwkXhZd7QA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XlXuVtb6Nm0=;E02eMcYtwyUGlJSlIPH3ZZogiz5
 O4eSa9c8nXvBSCKru4yAfLSBB6jR/F34hF7coaBzpblcXCKGra/iWECwSA5aHTMWjb138/jqu
 a6qjzwWa1MaW5qBOm+YeHjYmTxT7VERDIQuutf1dl1o9DfyODMw6Z8IJmSRM+14htlg3739YQ
 8TBtQ8pYObQYFnAFwzUKxXxDXS80nvClWQxxZlR2fVdTI0B9z4WHXnqjeocQo7yFO4Tc4JYzb
 OHhN2V6fi8UOJCGYkC+WmXeyp6Kv29505ReRT48bv0DzcPFxaTEJcZs19qhAOtOjD4e8/u4XV
 XGrVXnNAehGuTPt7lmh7gneUqwG49szOmlp5JSc8PJr3LjKQ4+M60L1yrTsOes8wq1SixNXUT
 nRa+VPZN+axhD73kK8CUpMhmYQGmr57bYx7beKnBLJzJS5KJxHgTT+7vXK5+4W/k+JvXG/H5W
 c3Um0b6BGvNOIVrrHp4yQV5aBnkWwh9WEjrBzU/hWJKuzvrENkm4z2TbtAAAdjLGaPeOz4JSQ
 PAUAM07kUv5uQ0iZSAxz49Bg6Z4TeViwQjM4sJw9luN63g0qjUT28YF+tfLeKTL0Zq7nkmnnv
 le8L8BqGp3QAikvyNUAwF40V7KeKDrxcpDINuLIK+Aq5DJ95+zWJvNpG4qDhuR/vU/lAPS70C
 fJRFO2ydagX2KdcAv9UuApvJgMnIwZwkfYvz9hstTFTWTxSat9jrjPe8TtZ+2244qMFSg19fe
 ByB6lsOtpQRhRHzAFWEZ0ZQ96L/KwhKAx4WNHHFuSxmqab2RNR9Zix8schn4WAQw0L/LQCIJ0
 KJEaEmdbGkvASnhAMQzGktMrRDxGWbwYXkq9HL3+oTXUPbM6eh1jjVzflmnYjrwFL77+8mXnb
 RanmO76NZjmYZnHdcidDX+dQJoBX932epgD0qHG1ohBoa+4EGYaY4xUS7fM7Z9Si2nsQZuOn0
 G7OPmftk/1DnthLwxJSoIW55RwdfJHXdxFXmMh2piv1et9e3lhTx0dWAkgBkAUfJElP42hvne
 P1YFaJ314ALprrD1fsWkRL91ba8iBaSieV4gaa8883UU9bVkz8R9qrTiKjule0LYUefhAElTr
 3A5jWo2lNLw4btbDRwxNb3nm+PqaSnOsC+b8/eE454WDRl9L1VXEStX+7g6jlshjlk3fo5gDI
 NtzqjUxr940HSCecUHil2Aqwahk0dNJEZGf00n2dA1pOuYCr1TVJ/bJoAKQjPWRRMNIcFxrAM
 okhgYbDJYAZjk/XmWaKUyyHm8/P910SUDSWfMaKOnE4Ddh4drq19NoK7QjI7kedLpQwFOZLnK
 1mbMrJYLaMxjU5GSjpQuAQO0vJbmszTOqupMAbFsQfhbTlbstIvjQAPWtyi3bmxxPN8Vezf1u
 LLRsfdLvU4O6qjgaPD3TsadRTqkmUGQRHxqQBNyItew/52ZUXEyglTF9Ta

Am 01.03.25 um 07:43 schrieb H Z:
> Hi, I am a static analysis tool developer, and I have found a
> potential null pointer dereference bug in src/read-cache.h and would
> like to report it to the maintainers. This vulnerability has the
> potential to cause unexpected application behavior, crashes. Can you
> please help me check it? Thank you for your effort and patience!
>
> Below is the execution sequence of the program that may produce the
> null pointer dereference bug.
>
> Below is the execution sequence of the program that may produce the bug.
> First, in the file diff-lib.c, the function oneway_diff assigns tree
> to NULL on line 537.

Context:

	const struct cache_entry *idx =3D src[0];
	const struct cache_entry *tree =3D src[1];

	/*
	 * Unpack-trees generates a DF/conflict entry if
	 * there was a directory in the index and a tree
	 * in the tree. From a diff standpoint, that's a
	 * delete of the tree and a create of the file.
	 */
	if (tree =3D=3D o->df_conflict_entry)
		tree =3D NULL;

What's a DF conflict?  A directory (D) in the index and a file (F) in
the tree for the same path, or vice versa.  Except that in the object
database directories are represented by "trees" and files by "blobs",
but that's not important here.

Not sure why "a tree in the tree" would conflict with a directory,
though, as the comment claims.  Probably a typo, and it should read
"a blob in the tree" instead.

> Second, if on line 540, idx ? idx : tree conditional judgement is
> false, tree, which is NULL, is passed as the 2nd argument to the
> function ce_path_match.

This should never happen, as we don't call a situation where one side
is absent (i.e. an added or removed file or directory) a DF conflict,
i.e. (tree =3D=3D o->df_conflict_entry) and (idx =3D=3D NULL) should never=
 be
true at the same time.

Now it would be very interesting if that assumption could actually be
violated by callers.  That's a bit hard to prove across the indirect
call by function pointer, I guess.

> Third, in file read-cache.h, the parameter ce of function
> ce_path_match is assigned to NULL. and ce is dereferenced on line 41,
> resulting in a null pointer dereference vulnerability.

We could add a defensive check, but is it worth it?  If we get it
wrong we'd get a segfault, at least on our main target platforms.

Ren=C3=A9

