Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47B1CAA65
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 03:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750908914; cv=none; b=tUG4PdC7i0mckokeuFLXql1aW55UQabhF4DYMz0wD2uG62UZD2IJfcCFATyWHnQBvVk5tJhSfHcoJ0/XmyS0kybWdk6osily2jBMSEgxk6JfwC0ZxjX7NFejVemhjI7KS2qb5dStjiUFXySW03fE32hiSGi5Th4Vg6ojGPGzTTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750908914; c=relaxed/simple;
	bh=jL8STDO5lQS9hxWV1fonUmdNOmSWoa6nko4lD8PuWQM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FdoPlfDtn0FhYS0fmLwAcAqooyFJEz9wbSbmvPF4aoboZ8pdpbcb4iBIf4fE1ha4RH6zaQxWnOsFVjIgGoPuX7hFGLRMZjczyq2ooDfjOJBDGvAh2w9qQBI7mO+E4/xoB24i323uW6Hq1iTG4VIy7dg53tL+EGKOUluFRfgE/i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpgz6t1750908890tf01cd5b4
X-QQ-Originating-IP: CyN6tfDSCFTbDEnGdr53bWyX928muACNw1+Fd+LcOqM=
Received: from smtpclient.apple ( [36.152.24.138])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Jun 2025 11:34:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5616732996666146335
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 0/2] bloom: use bloom filter given multiple pathspec
From: Lidong Yan <502024330056@smail.nju.edu.cn>
In-Reply-To: <xmqq7c0zviat.fsf@gitster.g>
Date: Thu, 26 Jun 2025 11:34:38 +0800
Cc: git@vger.kernel.org,
 Kai Koponen <kaikoponen@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <691CA448-881F-45BF-9D38-190F189DBB4E@smail.nju.edu.cn>
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
 <xmqq7c0zviat.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NXFhtRYX6L9xoon8Hwixe/eEMZ2mxSZP1DFn7Nfiytof1IesX6Q7he+m
	WMZ3dx4p7cbnAc4r7nehFdIcFFNUpl2mKfl/z1rAJk8KvDwuowbDtkl9B1e4MjIk+yX0zo3
	p/uOzgsFoQuuDqSe0kNKoznTFuCXPE/sh2BhjPeKpG+k3bONb8ASBurUHkbAkU/tB81kA5K
	jJ/UeDNCf2cWPQrI1tKDIEsUrO6OaLUET/w3uf6C4d4I8i8scyqQqMxkEMdi6mKCq3sE8FR
	IWsCwM5DHeh63ibI5bRHtWb8hApHBloVoGJaKfcu6ZtbntI2rUsWUw4o6D3aReHBEWYWsh+
	TtA4nU4SGWrq8ptKPi8G0IjPIzVP24m+Yb5mnGtyAEQjMqjojDcEqMH/lKbaC29NLHl3Zj8
	sjrMITnGzBhm2pMhJW7//6thjuEFoSPfnnKMIws0wuZMSEoFP/f8dBU62Rz5xyenfE09DF7
	M5wcMVwSqqo+1ILT6p0mwHS+C1IUnBjJV0KIv5aYwSx87mynjRJ5S76BjMPlCAEgFfIiSzL
	AAcOIja4PO66c41V8PbkFhdY9Z+giJYMGe87dKfUKrtHDDNZYIUu/hPdsBz3CGCz5iY1Yq1
	S64zX1oScE+pp58xF4dCS5svYfYfhsiyEyrUogKgsmKkihCH6KhKSgdUH1adrZIodzONxtK
	eBZ4ZFjs4YJwtsU0mT4GXRztnaf3Em/n9wKvdqbzux3SRxbuqJfD6FqByi48wEoJuNlGmua
	W25ary/8RbXg1ZbJM8SQ4rMASrUaBJifJy83k9GwVOByCUXSbLaY7Vu7DINXqzGgeBm44jy
	qK+luD5CQDp4Pk916ZY0wnar6cYJw0FxNAkpV56SxXbCoy2peIG/HrJSAzQvnIft31YlJQi
	zn4R06KYQJgMXqBrZmgzVoRQrbhYATL8fjxKKaevbMnZUtddi0JMySgKppYz8jEbc5/jFZ9
	NZIroQuuSjyT7LqZcDMQUWZD1MIa905u09bSc8WDQnX6d9g==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Junio C Hamano <gitster@pobox.com> writes:
>=20
> Lidong Yan <yldhome2d2@gmail.com> writes:
>=20
>> git won't use bloom filter for multiple pathspec, which makes the =
command
>=20
> Let's get the terminology straight.  A pathspec consists of one or
> more pathspec elements (or pathspec items).

Thanks for the clarification. I will be more precise with the =
terminology in v2.

> Also, "git won't" is overly general.  The series title shares the
> same issue ("given multiple pathspec" does not even hint that this
> is about revision traversal---you are not making filter used with
> pathspec with more than one element in other code paths).
>=20
> Perhaps like:
>=20
>    The revision traversal limited by pathspec has optimization when
>    the pathspec has only one element, it does not use any pathspec
>    magic (other than literal), and there is no wildcard.
>=20
>    While it is much harder to lift the latter two limitations,
>    supporting a pathspec with multiple elements is relatively easy.
>    Just make sure we hash each of them separately and ask the bloom
>    filter about them, and if we see none of them can possibly be
>    affected by the commit, we can skip without tree comparison.
>=20
> or something along that line?
>=20

What you wrote makes perfect sense to me, I=E2=80=99ll just copy and =
paste
those paragraphs into my cover letter. And the title would be
  "bloom: enable bloom filter optimization for multiple pathspec =
elements in revision traversal"

> Can we have a set of real tests to make sure that the updated filter
> code still identifies commits that touch the files without false
> negatives?  False positives are OK as we will follow them with real
> tree comparison to determine what exactly got changed, but false
> negatives are absolute no-no.
>=20
> Testing to see that the filter code path is activated is much less
> interesting than the filter code path still functions correctly with
> these changes presented here.  I have a feeling that with the
> changes to the test in this series, you wouldn't even find a bug
> where you simply added subpaths for all pathspec elements into a
> single array and use the original "bloom has to say 'possibly yes'
> to all array elements" logic (which would incorrectly require that
> both file1 and file2 must be modified).

I assume that t4216/test_bloom_filters_used has already verified that
using bloom filters with multiple pathspec elements produces the same
results as when bloom filters are not used. But I would love to add more
test cases to check no false negative happened.

Thanks,
Lidong=
