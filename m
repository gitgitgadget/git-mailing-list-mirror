Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2749A1BD9D3
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 01:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752543303; cv=none; b=DhLqeq7Vo1uWnZ4tgbuR/m5sK8ublUHRzjc2JLs2AxhEHsRdM+AuLifabiN5Km6EoHn73Y/zJpPyzQYvhZ6SF5ENMqnHH1M/Pny61vWWUM1fzUwplZwdmv9kSeP2dLOHysnqVLJalsVhKg/hSDtJH/gKmOJWWv8bHTRBFkbrqz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752543303; c=relaxed/simple;
	bh=e8C+UUmeV31vgEl4fmA9scKuRWC0TBD7Thuwt5iA3zA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TY8JLvbfJPAsDEFny0j/lK9tgSAuHRcVsDzTiCHkjq0LwboGw0fghh2Txlyq1ykM8BKKxIBAK0n/qTiDjo7yjZcYlIwxLgwc4/u0F67CVDRMAl2Bee5Js2L1VVJgpS3HQkQe81/sfJt5EOfkUmZBjU7f+zTQCetBhrAYpMhWHCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpsz8t1752543266tb7a89455
X-QQ-Originating-IP: 01Z0kYDomINnQ/lKdQqmuQ7u+NZ0zxbt0tbSulQK+lg=
Received: from smtpclient.apple ( [171.116.160.7])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 09:34:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15382107353221853189
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v6 0/5] bloom: enable bloom filter optimization for
 multiple pathspec elements in revision traversal
From: Lidong Yan <502024330056@smail.nju.edu.cn>
In-Reply-To: <0969e176-b9c7-464d-8e97-cf5cd4a06347@gmail.com>
Date: Tue, 15 Jul 2025 09:34:14 +0800
Cc: git@vger.kernel.org,
 gitster@pobox.com,
 toon@iotcl.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B090DCBA-7306-4BA9-A5BA-DA81D1ABB29C@smail.nju.edu.cn>
References: <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
 <20250712093517.17907-1-yldhome2d2@gmail.com>
 <0969e176-b9c7-464d-8e97-cf5cd4a06347@gmail.com>
To: Derrick Stolee <stolee@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OBoFiaMdrvAdspzo1frR4NJW5vtFuAMG9L97C/2k8kLBeYSdmSoc6S4F
	mLGn4k+3cGyjQW/l9jwhBqBaGvMvxEWum5UDXmX5R3dusAykUDnZ7b8tICN3GpR9Dzg68Y1
	GCVFy4MsIpIBHowLeFsufLAYxrIOPf4vV1oz3wBaGBS8EMkpR1FsMa7XQR9coSJPfvHm7o3
	7uBdNEOxGu6ttCBC2xiMcM6Q4bEV45MQEfoQ5jyn0V7b9g6iCE77/aazFIKu/t8TJq9oIqn
	CGU2BHJ9WVWN3hzBDN76qPs6uD14GP79kzmzdLIMFW0s5Kl91wjscG07j/sR0d4MypLj/+h
	0o8SjFPEy/6JkTjKuA0vJ+rILtZnXapekhIAbaRNsrXNxQeRKCul/eNkn7qy4JLtaM0EEUB
	7ac7SwSZbUuFkTe9H0rdpcypRdZ3nlwEYPFc+BftfULkmok/M5Y1U8CvDJfrF58uQnPVJ7s
	uvRdBcbvXj11e0BrcVOmlFSuv96KYmJs/DyD/hjz8BBCYCCAPZkR7unGeW0J3RB7J04Z5Vk
	qcG7XAGafh8O3QEAzoZ6XjFcKYgJPyOTcD70auwqpe8gN1z9Yqc3xmlSO/1dVDiS4cltVoN
	3qIuiZuuwgyEESVZS12AvdjtzT8OBem6bbth7pZm12s7qPz3gWWrYQ2mF3TM7N7xG7OBXK+
	U+5YubKWwteE5nt+CrTkd3ZDKU0NzqQJy3naGJ2EFM5DBZE4tsjJXYKlcHN9InkxCpZCvf+
	O0BFlX6dEaWLIGFl2gf6NL7vDqoWIrhPs8xEHoUdLW2/0q2ItE4FDc8PzTaFVhQYHPaxUGG
	t9dY/QFuzZRYp3Jb2MywgmYgHvsPA+Oc+aFVt/IvnRsUElyWfFsP6AUPBDKyhF1Yuyhwf0x
	dufvgJ8OTLYgiIWdNQ2JdyUtm9Woi6PWjiYCBWLWfGf06ZEHx/KFnyzQ+QxRMrJlbWwJCGO
	YsSa8m2WN9wzyy3zyLhcDO4wrHgkrkdgB80VCok0oU8SYoQ==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Derrick Stolee <stolee@gmail.com> wrote:
>=20
> On 7/12/2025 5:35 AM, Lidong Yan wrote:
>=20
>> The difference from v5 is:
>>  - extract convert pathspec item to bloom_keyvec logic to
>>    a separate function, which simplifies the =
prepare_to_use_bloom_filter()
>>    function.
>>  - fix few bugs in v5.
>=20
> Thanks for making these changes. Including your fixed patch 5, this
> version looks ready to me.
>=20
> I wouldn't say "fix a few bugs" but instead "fix some compile-time
> linting complaints when using DEVELOPER=3D1" to be clear that the
> functionality hasn't changed but the code is cleaner.

I just learned that `make DEVELOPER=3D1` treats warnings as errors.
Since this is just a cover letter issue, I feel it might not be worth =
rerolling
the patch again.

Thanks,
Lidong=
