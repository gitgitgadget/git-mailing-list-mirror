Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2C923BCE2
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748964817; cv=none; b=UQMvgpnmbqB3BtqVS2+6fn2i9yeg/Z0jawEUT5DukQ0KJLT1PnpcXhH05xUcSGSM0AAeXwrny7aPmBOVx5dciL2z4s/pe3/unnnl9PtpSMJx4ZkNUodBGG5qZK89Q9CAMu4h6hP77rbTV5bJKm53xNScqfK1Ipxd3ubgkSU1BdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748964817; c=relaxed/simple;
	bh=xGnVEWe5rCvl83bC0RxVFaDHG4QUUnv4iWV8h7/ZjbE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=op9YTYHuktk2SNp49+9Rmkkkor3jaHlhVXRW0qWgk4NcPfcR+8P9YQqDjShjUZzeooiyvo14G/6uCja1gYbHWMy8gch0nOfzcdxAYvZcZXygaoNepNlGZ8oAJ9uMurQZQc6rmQq429hVUYojJTdhMi5GPzGy94HDJ56INQzcHME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpgz15t1748964755t3b14c761
X-QQ-Originating-IP: p1tckcqfHOwv16Nk3CQgXlVYSessFvYeOAU3S9Dt0oo=
Received: from smtpclient.apple ( [202.119.46.26])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Jun 2025 23:32:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9533665091836923082
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3] pack-bitmap: remove checks before bitmap_free
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <xmqqwm9sq2lq.fsf@gitster.g>
Date: Tue, 3 Jun 2025 23:32:23 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>,
 Eric Sunshine <sunshine@sunshineco.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B7032488-F47A-46B9-AF9C-D059AFC31FE8@smail.nju.edu.cn>
References: <pull.1977.v2.git.git.1748628846.gitgitgadget@gmail.com>
 <pull.1977.v3.git.git.1748915181113.gitgitgadget@gmail.com>
 <xmqq1ps1s698.fsf@gitster.g>
 <0BFD6581-2BB9-439B-9837-767FA98900C5@smail.nju.edu.cn>
 <xmqqwm9sq2lq.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Mlf/ulHBoNfw26p1uidPogO1VHnucImEEklA4YqlHzfopuus8S/RFmrJ
	tXVRrqh4lS5huXwr2/tsFq4RI8Cp0qLEpdtXQDt8ILd+QoVy5OVyKyjlO910DhsE/lDHC0X
	UjHFYAXeoR555FptCYWrO9swz6MWY9ca25hCKhRcuFCijSzPsu8q084HmS7/1BScTTIcU+A
	vZP1dp/hqrprPwXuZwdSe++rp39jKUrTGVTa+o/HU01K8hobAY8wFeBkMkYWLiBpRmxUk73
	SeL01RVyBrASr6g+i+4pZsUOxC7BYXgCGsdyJFKPSKLxiGook7gIdPipuUfMyER7LN+IcIL
	UELrXNUMQtIMsfJzZUWeQuv0u5thQSjTwUxohOERIaTZ/hDtF7CP7wBfYVoWFJsyBKWVHKg
	+jGjzru8x7uZUWQ5VAzuipyk9X/DQk8fLkopLxlkafikSagpQxCSSYemtBgn5U1eMxacCOQ
	JrYBXp91Bd/NZhNztMNUpKA+yO+odClQTx0+uTIJxHGHJ5ygiur16hY1U6uo4S/cp9lCblE
	cspjh1qLtDP/I1M44ynfWai8QoMKia6ArCuyhMg0Jcl0P9+lqPBoiaU/prumb7GeyJ8npOi
	5q8nOZlHm1ReOZb3cLu4HOpVmgu5WFvwUnOa0Q/314f9aCvKCiopuWG0UN9AASJkGPjE9QV
	SDpvCItbGUEyHusWjDCfhRLtD6+zAG8mQAWpGYxasawfkdi2Z3sbfduut/qaWySUIvHRmhp
	G55vFOJItxdU0BNpyrjx9DKsdBJOTTRR5l0ft9CPmgHVbby0hVmu71fS2zUCVc6h/TB80bM
	5ZdZWODFBlvk6DjmHV49pCao4rIp+52nu9RHCbgXA/BnC1CVsck3LkGzI3Vde1YQYJNGUck
	cINv/hHxcRqqL0P2WR05kNyFTx7e3jwdtL2L5ODe8eE5eUhR5pcMs/pwUnffYt1eC1tCP4P
	kEGXGcibnbMrqMLRMxQq9x4lzVkOeCKobCY7c7UNE8uq22F5v2hDhqI/HT/QhcawK0cQ=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B46=E6=9C=883=E6=97=A5 23:14=EF=BC=8CJunio C Hamano =
<gitster@pobox.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> It still is curious why this version did not fail for you, though.
> If setting it without exporting it still made "rev-list" traverse
> and expected result, wouldn't that mean we are not really testing
> what we want to test?
>=20
>>>> + test_commit A &&
>>>> + git repack -adb &&
>>>> + test_commit B &&
>>>> +
>>>> + echo '1' >expect &&
>>>> + git rev-list --count --use-bitmap-index HEAD~1..HEAD >actual &&
>>>> + test_cmp expect actual
>>>> + )
>>>> +'
>>>> +
>>>> test_done
>>>>=20
>>>> base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
>>>=20
>=20

No, this test case should only fail when =E2=80=99SANITIZE_LEAK=E2=80=99 =
is set. I heard
that other developer call this type of test as prereq. So only when git =
is
compiled with `-fsanitize=3Daddress` and `export =
ASAN_OPTION=3Ddetect_leaks=3D1`
and without changes as

- if (!cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap))
- bitmap_free(roots_bitmap);
+ cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap);
+ bitmap_free(roots_bitmap);

This test case would fail.=
