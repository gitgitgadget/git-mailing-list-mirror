Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77423202C43
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749041092; cv=none; b=d8nFgSJccnd9qnAd5pNWcgZRgB7wc5oJE6fYX/Orx7KnXNVLs7ukGot5vE3ijj7oFHxn9X4/R5sLAAJuOnsiN6IvEBrjKuJcCFr8DrBVAqu/PcYQK9tsRSKnO6+um/AKAoNXr55QUb4lT57GPrYdBjVzvOUmrk27BJV7MFhdaHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749041092; c=relaxed/simple;
	bh=6HCFqgjS3G93SZ50YiMjVFq9moAleFtyiCvfzjF52NY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EZjC2D2asi83K8yBrQtUDUaaaGx71F3Oh3FTAljrIFiLdTm0Yvq4KMg8Az5OVnIOjVQLJiIegjtyUN+6PnyPPFSut//X9l6gXbVP5gjy3mi/WTm48M6PsWIp34HJxB6d8hNj3ENFmJPnVqA9vqOFeZDt0jmUK+3Zw6hcjNnNkAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpsz6t1749041041t066a5351
X-QQ-Originating-IP: 82ss+fmJiLjmZc94LW1YKqBaddqk2BVHOrdz3sbaexY=
Received: from smtpclient.apple ( [202.119.41.185])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Jun 2025 20:43:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3253840494251508180
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
In-Reply-To: <xmqqcybjg00s.fsf@gitster.g>
Date: Wed, 4 Jun 2025 20:43:49 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>,
 Eric Sunshine <sunshine@sunshineco.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <60E19C19-2910-46E7-9409-58D26190722A@smail.nju.edu.cn>
References: <pull.1977.v2.git.git.1748628846.gitgitgadget@gmail.com>
 <pull.1977.v3.git.git.1748915181113.gitgitgadget@gmail.com>
 <xmqq1ps1s698.fsf@gitster.g>
 <0BFD6581-2BB9-439B-9837-767FA98900C5@smail.nju.edu.cn>
 <xmqqwm9sq2lq.fsf@gitster.g>
 <B7032488-F47A-46B9-AF9C-D059AFC31FE8@smail.nju.edu.cn>
 <xmqqcybjg00s.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: ObRDf3flJ9WfXwHACw4CpobVWoz2CcAkJkjrln5oRXw1CEM/kqg9yBCI
	CuoxDxhWogD/LomJ0pzeq5qIkC3uG1y9XQArKlCqIL3AHTHV6FInD7n9cvXkNZrH6wxEw75
	emM6zQkbpCDd3VCTlUC6jO8bDVIVe5C+Ov/x0ScaQ7jogfTalyzMA/10Fy5yc7jmmYrXLQv
	MGxA9NM2MSYrxcuMUTB/Ts6VvjTlo5Ye1ykM0++AZvR9HNqtPvWPGSyTAH1ozHcRTpoMyrV
	dCqBw9DmnJTldYCkKVEmsOQyMur26tsIYhXRFEvgFtJRRdb0Qc599gTIPTJEMMT07HXR/sO
	c1NsfUCoW6w8HTk/afRmv3aM0zlDyE6+or1nGPdrBPfp2RmvxnMfz4t2aulUCilDXcj0IVk
	gbNlqm2AyktERAWVbVAfqR5D2HwE697FjMkJ6ihqf8C1v5m24UXbIbeSBhkvUYp7hR1e1fT
	abZrg0FkGjPl5DRMieo4Fx7bPmpMwRXgZvnwxZbf3zplvvLvBNpeqAJSYjWyxnLSwPQksBW
	0HUvgE0HZgVhpM+elHMVgveraa4c2WyMqx6NRpgrniVIwK4rWLbZ41+AQQ5eQeuaMsDALBL
	FtAkAI6BbRe/9/vpYqJp+8v2T9CRyIfh1PplUjElxPfZIixpGchgzh83/ZK50OfJ3CTPaJ3
	rZUYkJlGZ3HzlzwfcUAzYzhDBKaJVsUHhdKosGR1jCs9Uw5ORDQdVGFIHjD/hrqZaya9Zns
	SqvpkA8exa7+ArQbVezR4dnbUEb27oQMEeS44DXLCyfpkx4kTJALslrP4vMoGEq/GLChwOg
	MwCZnv00HGUvneWRiHEs8T/+gaYZJ4MethJkR7gXHyw/Td3jAzu9+yI9LM4Kv6+UL+chvmK
	v8TlPEk6qt4AlweF5uYeKZN9G/+DK5EHlK7Qeo92O6cTKRQy6XjqApbIrXnWGEvOZf49Z5D
	gkn5kSV1IMMqmnujqhmG28j6vKZo2fv1ekaL23+Rkg0X9QcQs+1f1UBiwjfKCG/RdmdvhvB
	zLtUH77OROKeLWy1Kt+hGUUQRIWrda6i2J+hIZ04rGsP3i6LEi
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B46=E6=9C=884=E6=97=A5 20:32=EF=BC=8CJunio C Hamano =
<gitster@pobox.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> lidongyan <502024330056@smail.nju.edu.cn> writes:
>=20
>> No, this test case should only fail when =E2=80=99SANITIZE_LEAK=E2=80=99=
 is set. I heard
>> that other developer call this type of test as prereq. So only when =
git is
>> compiled with `-fsanitize=3Daddress` and `export =
ASAN_OPTION=3Ddetect_leaks=3D1`
>> and without changes as
>>=20
>> - if (!cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap))
>> - bitmap_free(roots_bitmap);
>> + cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap);
>> + bitmap_free(roots_bitmap);
>>=20
>> This test case would fail.
>=20
> If the test tickles the code path that used to be broken (and
> corrected by the patch), temporarily reverting only the code changes
> to pack-bitmap.c and then this test (under leak sanitizer, of
> course) should have failed.  And if the test passed with such an
> experiment, you would have noticed that something is wrong.
>=20
> But you didn't notice it and sent the patch, so I'd assume that you
> saw such a test still failed.  IOW, with "export" forgotten in the
> test, the original (unfixed) code still leaked, without using the
> bitmap traversal, right?
>=20
> Which was where my question came from.
>=20
> Or perhaps you didn't do that "is my test really tickling the bug I
> fixed and makes the original code without my fix fail?" test?  Which
> also explains why lack of "export" was not noticed.

The test case in v0 with =E2=80=9Cexport=E2=80=9D would fail, but =
test-lint in CI shouts. To make
CI happy, I delete =E2=80=9Cexport=E2=80=9D and submit immediately. So I =
am sure now in
v3 this test truly test what we want. But I make two mistakes that I =
haven=E2=80=99t
pass all CI test before submit. I apologize for the oversight. I'll =
double-check
my tests more carefully in the future to avoid similar issues.

Thanks,
Lidong=
