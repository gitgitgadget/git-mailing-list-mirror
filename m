Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29441DF990
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 01:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749779741; cv=none; b=KQRsYE22M371WtKGIt0VlOO1+LwFlLvdi0FPDbrk3HyhCRo/2id6J36HG1A9LsWbDJ7ABQ0FMW4KM5hwcqMIOw86VamsZmsG8vbsV0IxIe5oWFzbh3DdGb7Hn4TqLsxI/hy1av7JnbFuBqJoHuXIVr1+OMg9BmbKEYln7s9zhHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749779741; c=relaxed/simple;
	bh=Qpl4WK8aN/dON+7u0TJWsupO/ZBMIKqhUhnbBiFpLpI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JrYrZocdLbqotings6v6axZLr6ntw2yTWUo9aFprxApgZRcz2iEbc94k6k3SRpFDFFzLUABaBSZeVV365+Vnsc8ztFRFfVLj1IQgro3MhPPwPRZNNxEFya0GoeEg6pr1CGqIneG9JUNDY7xR1xe0VrT3p2ny6oXaq9yzA3/16Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpgz1t1749779720t344cbde1
X-QQ-Originating-IP: L5fAYkBE4kYhlcj0x0kMK6RvS27/U5wsMC+OlV1h+gs=
Received: from smtpclient.apple ( [36.152.24.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Jun 2025 09:55:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16444983638016022725
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] git.c: remove the_repository dependence in run_builtin()
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <xmqqecvoev8g.fsf@gitster.g>
Date: Fri, 13 Jun 2025 09:53:40 +0800
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <11AE19A1-7B19-45CE-AFCE-98D89A4570F7@smail.nju.edu.cn>
References: <20250612045905.3023227-1-502024330056@smail.nju.edu.cn>
 <xmqqecvoev8g.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N6+UlSQllctNNZ7HnPsAW6oxtqtfGYE2HB95KBsjAlHqszG+AJ4d3+9j
	mrC+iU+c/7GH8bIkA/we78xN2fHerN9tmUyM2iOHTYYvtPoY2aXI0bQhBZMSWO9VtDvf4H/
	VBT08+yxkHuETUn3o0G4oE8yXjfBWn4sPTpe+BtQ6WnkzaNM6aTYkn+44JTQV7fs2fRvvH6
	eMEmsaUcjPcMdhZo0JIBm3P/86MFseEUQbUjqKrRfPllBWlXMT6qNZEEQK3AxnYOyrS0fu2
	I8FrUc/t7125TDTv07J4eSukjydoio7F2PFx8BwzEmdUwEZGF2KVtsFVO9MYRgKd+8cy3ik
	oQWbyBowAjk+esqUV6yxOFu4Ek1PLFNToScHaTQGNqlmNE7YWRuLKDBe7NcOz4tLWf78myf
	W14z9EhyK58fiTHg5KB4JlZTSkCmM1lIjac5lF/6+DsV5ZpCY3s58dWu9SG58aGJ9KkWYgm
	hlwfgv+jGPrjTUGzt6XgMFMSOSbbLKHUzL79sjuPt1nWbEzKcLTIUKy7JNJvIkPSb8BSpzF
	2Sbyx2+bw73JSVv/pgbg3qOW5dNMit6e8Lobs1YEqJmR8qfYHnr5NFUX4Sd7jACKQFU14ZZ
	foKmjGHLPo72q2XiHKIO3Nfcl+tp6jT3zcWbxMIvkShRTIKldc+V5CrlCiPv2BFZbrKpade
	/R80xwp8d+BC+byfR/eX8GgCu3ZJMypLj4U8GD/kuS2+QMgyJucFzHYHpyFaVfxkyxWLBqK
	n6X1IM24AlY3gse9p36WfxwvjxpySlaYg8a1VhnMC15haNpa5KfUhZQlX6aenBQmwNKQ12s
	iMkp1mrjssi5gwOIGFcx+FFs4PlfqRuRS6JNKVZJCHuTjQsXSXV5VmG9G40/i1ten7vFrps
	sXbwBLIOuSOYo5JzLFjBMDgXLlLHa2lrg2ttK6y1wrQrmkreRTg6xiYoWlq5ygPTZAN8Szq
	d0SnAiTc5hm+ARld1DbYw6qaatdo58sqIyXs=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Junio C Hamano <gitster@pobox.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Lidong Yan <yldhome2d2@gmail.com> writes:
>=20
>> run_builtin() takes a repo parameter, so the use of the_repository
>> is no longer necessary. Removed the usage of the_repository.
>=20
> Good.  The caller always calls this function with the_repository, so
> this patch does not change anything in the bigger picture.
>=20
>> The comment before trace_repo_setup() advises not to use =
get_git_dir(),
>> but this note is unrelated to trace_repo_setup() itself. =
Additionally,
>> get_git_dir() has now been renamed to repo_get_git_dir(). Remove this
>> comment line.
>=20
> Isn't it still relevant to explain the reason why this codepath
> avoids calling the repo_get_git_dir() function?
>=20
> e5b17bda (git: ensure correct git directory setup with -h,
> 2021-12-06) tells us that the comment is about use of
> startup_info->have_repository, which was added by a9ca8a85
> (builtins: print setup info if repo is found, 2010-11-26).

In commit a9ca8a85, the intention was to avoid calling get_git_dir() =
before
confirming that we are indeed inside a Git repository and determining =
the prefix
between the current working directory and the repository root.

However, I believe this concern is no longer relevant:
repo_get_git_dir() no longer sets up the Git repository environment as =
the
original comment implied. Instead, all the necessary setup is now =
handled
by setup_git_env(), which is invoked by setup_git_directory_gently() =
after
the prefix has been determined. As a result, I believe it is no longer =
necessary
to retain this comment message.=
