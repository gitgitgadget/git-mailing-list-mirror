Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075171C8611
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751079293; cv=none; b=qfeoKkcydbpEwZUefb3cSWMXMcglvH04PFjQjLgddraFlu4N+fwRw+MaPnWP1RhtjAs8Zmo+aVu1qt9AsjRgLbFIFbyBbQXXeCXvCT8WjdxHyLEeHBf5tao6kX+oGtExO3NIMiMRHRfaUMwnikVw6jp703NG0WxmJh08KTfJ/IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751079293; c=relaxed/simple;
	bh=pPtS8gI2gWX5Ulq12V0lQbHHnKGtQscy8QlZ2lAQk5w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=R3p4HQMmzo5S95D2qmv0YksJhQ7Rk8wZ96NkOW3BkWXWuTM9yr56DRKSTlvNdAkHfttaKXLsvZM7UJaxhrroG0e4UgqoClwkFBzPkB843WX9MxX4MFH7Ir4Jm84D34NahFQs0DVv+MHrTABSpbifjoSKFYo7u7ORmk5+T1QiJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpgz7t1751079260tc142d3ae
X-QQ-Originating-IP: iaTguokGeksd2eoitSbJvAuwys5jbtilD63CzptfxX4=
Received: from smtpclient.apple ( [36.152.24.152])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 28 Jun 2025 10:54:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5024960126293289898
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 2/2] bloom: enable multiple pathspec bloom keys
From: Lidong Yan <502024330056@smail.nju.edu.cn>
In-Reply-To: <xmqqqzz47wd3.fsf@gitster.g>
Date: Sat, 28 Jun 2025 10:54:09 +0800
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1D8CE39A-D6F5-4AB7-8613-6C8DF1302907@smail.nju.edu.cn>
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
 <20250625125541.3048632-3-502024330056@smail.nju.edu.cn>
 <xmqqqzz47wd3.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MXqQCeYgv6iWfrVQkUKmC/fkGpPE3AppIRFY3AmvCIU2hI6N7F2tSQxC
	QUTw3550AbvdRqWW+WsC7pyQ2WUdYiudY5/qIp/LMBsMlHjrCKWMLUAL5ZEY4ca8OXqg4mM
	1vbN7ft8PIwxZd+4el6qeFkWXnEhUoOLNopNN0wrKgAdOKZhWBbOY1TFS1oiwyWs/tvLW6p
	5GPgxH+fgHbDWKYbMog4kZ7ESvRnq7Iz7/6xpjTm/ELy0lvZl6Lq6zw8xyHNyasrXG6vxuj
	AYom7PzyHrjHjYxgvpcX3TaEL85YIzo8UPzCMfnVgzK7u0eKxMMrpYU27xzBp07wVT2S3Me
	yrzEclfsOLjgYX4/3rHtN6KqK26EYIK44L2Ky611xv7xGF8bPnjYG+khS/3gr0UDJzffgpg
	lYdZaGgVUSXbobV3t42yF18tmsoBo9+TZ5IVmB1SBUBk/wW7+RYrpI4r/bqFd+MLOHPaq2q
	dxXG1JWkp5JuqOP7qJI+yfJt3VwFqSbg/uwgEY4iVPFvw3LxBPdH63NksWvimR4y5XGQz+e
	dAfjNlUYBKzD1IYpvE7ik0iz7qrJTVe8h7L9Pyh1NNa3j4ottVZuAcuH5pqfWHUXJDBMTX+
	+Pkm8Vs5aUrGKO/EZNgjPmKVXytz2X3teSXufjB2XO1KvAQHxMGOnuVkKq8ROnJSgvaWYvO
	zyveZZ4lOalqMikdq0yamDHHHVvlr/5SbgYqbxKuEnukZXU6T9odwG2LYvoxzCFYGqKlyK9
	YTqPhQPwC57Glur1HAzVfJVdUDi+rD41bt0yYsvPbcoSc9YRB8GT0hLkH5Chotg7xOF85x0
	/zEIe8H7kAsUhIOPfEOHqXKXoQ7G9fCfKrbVvfho5HIEuUvss6CCNPLowEOrN8D4gtNmRnJ
	UtnOMzUq3ZqS9z6mOG/KIbWK42rfN6mgitwZ4W9SMpp9obR5UlFs0fuSjWPRDw6vj5fyhFA
	OPuU5egugCe8vUsmcgekN/g65r3GestKNO+dJwOtPyDL+GQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Junio C Hamano <gitster@pobox.com> writes:
> Also the setup helper test_bloom_filters_{not_,}used helpers call is
> written in a way to make it impossible to pass a real wildcard and
> see how "$git log" would behave, because it does this:
>=20
> git -c core.commitGraph=3Dfalse log --pretty=3D"format:%s" $1 =
>log_wo_bloom &&

Yeah, if $1 contains * and because $1 is not quotes, * would trigger =
file name
expansion.

> It probably should use 'eval' so that the caller can pass a quoted
> wildcard, perhaps like
>=20
>    eval git -c core.commitgraph=3Dfalse \
>     log --pretty=3Dformat:%s "$1" >log_wo_bloom &&
>=20
> Then a test we can add to see how wildcards prevent Bloom from
> kicking in would look like
>=20
> test_bloom_filters_used "-- file*" &&
> test_bloom_filters_not_used "-- file4 file\*" &&
>=20
> The former lets the shell expand file* when the above "eval"
> evaluates its (concatenated) strings, while the latter leaves the
> backslash before the asterisk in the strings fed to "eval", so the
> "log" will see a pathspec with wildcard.

Wow, this solution is very clever.

> If we were to fix that setup() thing, we of course need to be
> a bit careful about existing tests.

Though the uses of test_bloom_filters_(not_)used are not too much,
I think replace
  git -c core.commitGraph=3Dfalse log --pretty=3D"format:%s" $1 =
>log_wo_bloom &&
with
  git -c core.commitGraph=3Dfalse log --pretty=3D"format:%s=E2=80=9D =
=E2=80=9C$*" >log_wo_bloom &&

is not better than add the =E2=80=9Ceval =E2=80=A6=E2=80=9D solution, I =
will just use eval

Thanks,
Lidong

