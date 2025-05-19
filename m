Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B212676F8
	for <git@vger.kernel.org>; Mon, 19 May 2025 07:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747640317; cv=none; b=LIBcVY2pUMmFTSboCW72vld6kz02kKZ3AihaygY6tw5pS0my/XVnum/c8qHKhJ/EhjazAlVTHPhezKlyCRdrM4DH9KlgEAhRNqirLsUjAfm1rRC3XrQCPpzfaQWdgFRxELu1qQmMolVujSW684g4lmMzD1cCem0V+0qckup9hPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747640317; c=relaxed/simple;
	bh=mhDLJUC9evUngcT/JOB3325EtLhsMGuh57vVbXXiWt8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uHFmw4eFuonmcstRNTlVSbsmv26wk8NLu+ED7k4A4NROO5GH+22+TWGrns5bf3qPauGATxXoXYvlcxE4ZPOUTrEePXgbSE5mmvyJIiHhSoCrP61A1hex/a/mj6Neryco+9LAbb0ptDnhRF28NdoiqytnnircI/AiskuHiOW7u/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpsz3t1747640287t4772d2a6
X-QQ-Originating-IP: OlYklmduy1tMoe0Jv4gPJVEu8AOA/tvBNLK3VOWsWi8=
Received: from smtpclient.apple ( [36.152.24.178])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 19 May 2025 15:38:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13607099074010525028
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
In-Reply-To: <aCrdWbcOtbYsw8t6@pks.im>
Date: Mon, 19 May 2025 15:37:55 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AC0F256C-4EEC-41A6-9AAF-78B3FEF26251@smail.nju.edu.cn>
References: <pull.1967.git.git.1747491983066.gitgitgadget@gmail.com>
 <aCrJcK6ml4r4S-mF@pks.im>
 <80BCF957-002B-4532-8E3D-8CAB45AC0349@smail.nju.edu.cn>
 <aCrdWbcOtbYsw8t6@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NEzJl4P/jcVq9NMcRJHspOu7suWmvgM8TVcqgJ9KQbVrrww34/kBXXNH
	ahgeklJ7UoPaVlFEYdsvKYSXEumXIa0cYPXLrhf7EyfHMRJdzKJ4Bj1NSaKktl893VyNN5O
	WwLUxSpq5atat0GhSkEdFNeR4cAgeslxzmVbI5Z+vJIVO1t7JQx90COCr0vaaW7HUle3DgY
	Y+pIexS9aZ0l1JtL6Optw1sq8K1mYyyyQ7kFy5S0+ppN0OBGNCOSjEIhNhwgLDFV9Necb91
	3yjJQP5Cvj6Qq1imUcFm2pBl6wUQ5yp/Jd+WfZ9EoSB6C+9dRoUn3roPQU2Tox58PD2oj6O
	osHYH6SladOFpi3ByX/S2FHsPlQCNgPjRDlExf/iIRTYM+WlzI5Yg0PMa1Pg9R0rtSe1r5W
	AvqUWyYWpyuQmEZh3KttpG1xfcK6gXhvCw7GIWj+7CBs1EaxrjdqmbLxbgOp6XXaqLa91wc
	J8ECn30P9q2fTeCL5yASqagu/oOmDgHxhMt1zJd7+OVAePA1eQiVOVRY/H/9MXscqBme9d+
	ePtQK58G7pECBJd7v0wp7XsgVaFfAZ5GHszn7HoLdEtG8gK4XVp2HdRPPwgeoZdIrWkJa8/
	mrTw4ikaBf9ymLCsFwexAxhc54Oz+wrjXJ3fOob2Rhr2aypAHkslis7WzLMqg+ekaOgTxc/
	7w+f+1Q9e9COKz3PgshMyiOoNAGHkFlNAYoPx4xoROY5csc+3/JRXsE1oqgYykpq3nLEciZ
	jIeJCt7WuKS8YUvnimQARh5+h4s4w/oxN8UXSiz5RGeQH/J1DzaY31a42fmF05v9RVZIR0+
	QcCMh1zXtKInItORg9aZoaD/RscgHPzZu53nkxy+Zzl8KwO1L/CZ0tldTUNZt7fF6OLQJnC
	ZXoQTahMH2QmrmQXS0BbV/BEj//OFrjx2lK2KoxjK5TbHqfQImR1FJocPwCqswZ9/EWDczo
	P+eXXinbWyUiIwvBBzRNgLWf3rCX447/hAVaR7aAMyVXt1jpJ1vZfQtE3OtiJpGeAZdiYM6
	fN4RIyvG00FhxUim0P33mxxkOMSula9N/3M0yjQdtgxh20/Vlz/zKXzBvXttND7FogToofw
	NwfqmB88UKx9ECCVM5NoB8=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0


> 2025=E5=B9=B45=E6=9C=8819=E6=97=A5 15:27=EF=BC=8CPatrick Steinhardt =
<ps@pks.im> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, May 19, 2025 at 02:44:22PM +0800, lidongyan wrote:
>> 2025=E5=B9=B45=E6=9C=8819=E6=97=A5 14:02=EF=BC=8CPatrick Steinhardt =
<ps@pks.im> =E5=86=99=E9=81=93=EF=BC=9A
>>> Okay. We _can_ do that now, but the patch doesn't explain why we
>>> _should_.
>>=20
>> The main purpose of this patch is to provide a test case to check =
whether
>> a memory leak occurs when loading a corrupt index file as requested =
here
>> =
https://lore.kernel.org/git/20250514180325.GB2196784@coredump.intra.peff.n=
et.
>> A potential memory leak is mentioned in this patch here =
https://lore.kernel.org/git/pull.1962.git.git.1747052530271.gitgitgadget@g=
mail.com/.
>=20
> Wouldn't it make sense to include this in a v2 of that patch series
> then? That makes it way easier for the reviewer to draw the connection
> and allows you to draft commit messages in a way that they refer to =
one
> another.
>=20
> Patrick
>=20

Thanks for the suggestion, including it in v2 sounds like the right =
approach.=20
I=E2=80=99ll update the series and revise the commit messages =
accordingly.=
