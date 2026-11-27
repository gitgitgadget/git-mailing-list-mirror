Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804447;
	b=YWlOjORtZpwplGyL/S340+D5awf+jZSw4lOR0zHRJ1In7cjEyPzy2wdJzimwpwVEnQfY
	 HHvURHUxOqh/KXsUYSyrIw0HecSSqRhMUcMx4K/hXF4KMxhPJtSuOVe5pH4EbI86+mzJY
	 BxkE0VI3XRvHl5vEUZWrqjqDJ+yjXDBNxcb2xUt7Ml370/cxzyWUL5yYpVq7mSMDiPaOp
	 RHvKzH9YTrelRRXSJ6LuHUNQa6gWLhV2MGXHF1gmHBDo1MBRJPZ9KVSoJYnq1q5gxBtXx
	 VdhdV+tZp2CcEnRZlfKdPWkPPGyodLZgM/CsIuQCU9FNn/BnkCl17WrLjM8KdFRWEwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804447;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=yJp7U2HT02kgO3Fb7tybmwUeNyDYuVpIsGWZuhUP29I=;
	b=3zkR/fzMLskQU7s0OxcXgQnZxqLf+xkX4NgNlCpEY3NKbC50KRSWXzdeHe0LcbMIv3y6
	 2sTUHnJN4R5lqZUOGF+jYi7+aSZCZV8QeXPXtNf1l0v0jacI4QwxQNv5dNnbZzB/aPq7X
	 4hMXRtlue9oL5hLOAB9SqMVtnj9FJtnf++kWJVSCqMqTXQb7WUbS5qH/ed0cK0Dl6IFtq
	 KlDNZAHgjm8xQ5q32zKZhMDibXhEtyAKYRfvry8K1H3fe/TaYe933Fc9tI4rhZQp4eCuX
	 Tt0nwmLb5Kg224eYDeKc3Vv/4vgufTSxk74rCHgfC+aGMvElY+G0GkmqgfnXN431Qhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=OvaRbwWa;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mWHiRKWO;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAC0606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 18:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFAC0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=OvaRbwWa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mWHiRKWO
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 12F94EC0AE6
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 13:34:06 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 27 Nov 2026 13:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795804446; x=1795890846; bh=yJp7U2HT02
	kgO3Fb7tybmwUeNyDYuVpIsGWZuhUP29I=; b=OvaRbwWa/Np9EFCIFA2G0e01Qg
	PXkISI/qB6AG1lrfh7B0JMPvyTXeFrx5aZoCU6TZLE5l7CZnkwsiG5/xK+lVGVfa
	NyxcvggUpS84gmNAAG3Y4zw9cpEgkmIvWb+8jRfUlsIK0U9ifNPlVQ3tOdJoD/bR
	zFAPH/mTnVDCXgBSpU/Aby3dOpOYZS2yG6+9I6WZguzX76PGuw0kEBAgqWIGxqrq
	+Fe/lsuxhAXuqIWtoIGV0Kw9jXstLH6JTvpC3uTVK/U2gcCP7ng5jbK+JDwOYqy7
	6/8ZxzpJ0d3UHePW2u9wVE7UCsRhUmppHeCQVfVm1WX0Z5zqZCQvs0erSGrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795804446; x=1795890846; bh=yJp7U2HT02kgO3Fb7tybmwUeNyDYuVpIsGW
	ZuhUP29I=; b=mWHiRKWOg324FKSD3M5vy4Gg4ciNDXB1+p1xsRI1fRFjt0lQUNP
	I5UHDlse6/u6P9AADTEms7IxI4U3qKNhKXDF08js0ufv/YJWnrHzbVDCsli+9Y9L
	/LvZpdpYCIqiQa2fyi+dsoNI8AQfpDUAVkDvJcZwTCg+Sk3Sz/a4Z/pw9U561OBY
	/Sczgxle6arYVTdRjjCUrn1ZwRVaAUKF2AOtddGjbm/T/nH8MAnVyDkQQs9Xmabi
	obXY/tsVSEFvl7rNROKU9S+opwDIonZXHbjdvxTD2i2k3AqYHyphGPDwk4iE7DzP
	lrX7Anms23vwNlLpiYM8AaIxrRs13EC59OQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795804446; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PhhPNRs/63fJnaNdPZpaMxDM79ncFoofzkrA3eEpORab9UG
	4ABNO2c+O/zc8JvvSnav9D7IRynnFWSqNiIPjv+fs+TGJHSmlx2+E/4RoImb9IKc
	AQHghwhtIo9eLaxmLfaLmfJN8Hhv2hdYeEQ2lEhFyNf74a5XjIwLdZc5WYEf60Ck
	g0MkfjCJEZwfiHX9WXN4qaECqRWewa3s0iupUK8VlabOGwATk4blMsH0jHxQECzh
	rjE9FsTjuuqe6DJwatZfc5/lojWMub+bdATbWvYIYusyoxtiQ5kpnJmRcPy5nn/a
	E2id3Bf/u2vlXyDwanWQMAw8XLo72WY3Cce83vQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:TnPxO0tmRBxcrzQO2BizL4WWmBn2wPBiSy84FNvKSTU=:Ktvd0knqFu4ci/m0UjNGu5hnv5cMatFVXEFEdee7rSQ=;
X-ME-Sender: <xms:Hc0Jax8n78I_3QKNB5Dqy3qsKqzqywTL4hmHkiLL1hU0OekZV3X0Mw>
    <xme:Hc0Ja8tCvDJNzfxEcFwfeETgthF7MlaySqSKXwYbs_yRN_kJoVJyzs2z9IadBhobp
    mDAUQ6BgcZ1HeV36-EdaoYs8Z4ZtGlEd45A4bm8m-B_-PxAjkYy>
X-ME-Received: <xmr:Hc0Ja0DgOMlIunsSj4wdfnM5xC5C2twiNjE0OQFdwjvDSvBNsQQy2JbAxdkg94bioUN342_zV_EKB40xejLuBzCmI4q6BdNNIg5KdPM>
X-ME-Proxy-Cause: dmFkZTGjjX+xKFTrjCvN+/QejIfLOXNXaDcj8/I5ae7osvbr7RbeEFYmuz/7X1WfqEuimi
    xSCVXo3bTq61aJlTEKLEHVy4MK+pPMuSX9l/V8dWJMyBq3PV1GCkwVX01vER9NVjVvVYRI
    s8qiyo2YPLvdlhJ7dn111LF8jZlN75Jri6YTCH5uHjb8cLej6zU1JlNOOneAhmJe5nvd0A
    TzwIMCXH43Kwj5bq2i6/RTNzsDhY41FKngObNCPoFQvNEnnsfdazZEwfywiJ9MvijnGrbv
    eknw/hI8JPegEgPniUy8YMgCZdL1kfyBPqHBzaFIfN9UDgvn0EfY2yCj91HnqAW6Sf8JTE
    hhS7h6GCiGbDv1zkZ4npikxdMklhHYf3l3O89yvCtjwbKTd9v1ryuaD2iloIoGRQtwdanT
    ssx47Bc3ScercwTBc6ZBWxWg2HCL40LIxhTosO90Eks7RJf1WwIgin55fiMTeJwkJEb+qI
    1A4umLCwcrppbygujOexeI6+m1l2oHJVjmH0Qpju3zBbQoHzNqHCpCkvWlrDvOzUJL64P3
    dOkwDghwA9jnyX8T9BfIedZm64sbYWhFCPJqVmsbaDZ3Q5jxhLEtggrJDWVy/J0i5JPAxY
    vqDhVc2LiaklH/l5MXWH6Kw+XI5cjgzvwNKv/ZrKDGiN3h7wLcAefvWsWzsQ
X-ME-Proxy: <xmx:Hc0Ja0UJ0dq4XRekozYvG1Q-m38ulP0o_EbGbxfx94M7mDEOiNBEtg>
    <xmx:Hc0JayAmMghwxnjnHxtJn9fEwGPTSNltXYfkqKJ25xbH4U8m7kdQlQ>
    <xmx:Hc0Ja39Jsb-ilWTGFHq6MiqxtMAwwAdgdI09ukqpECmHKJYhxAqtLQ>
    <xmx:Hc0Ja5F4g1ElADEF9AlnYEDzqAzhdRT9_sN-Nx5QjB6ClzYmh-77cQ>
    <xmx:Hs0Ja3jWXgcl0wPHoHSEmazIlyAiD7HSEKW3ZwiRwWYeh-mdxz7bLZ5F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 13:34:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] test-lib: run EXPENSIVE tests one at a time
In-Reply-To: <d10dd696-789c-4c0c-ab6a-ee71f29ecb92@gmail.com> (Kaartic
	Sivaraam's message of "Fri, 27 Nov 2026 19:29:12 +0530")
References: <20261119-ks-ci-long-test-hang-fix-v1-1-45c2fff6d9f0@gmail.com>
	<20261119-ks-ci-long-test-hang-fix-v2-1-37011c08380d@gmail.com>
	<xmqqpkw0rp8i.fsf@gitster.g>
	<781ae43f-7831-4aa7-a7a0-aee069950eac@gmail.com>
	<xmqq8q2g1x21.fsf@gitster.g>
	<d10dd696-789c-4c0c-ab6a-ee71f29ecb92@gmail.com>
Date: Fri, 27 Nov 2026 10:34:04 -0800
Message-ID: <xmqq5wxi9l9f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Okay. I'll try to send a v3 with another variant of this which tries to 
> avoid deadlocks as much as possible by using a different mechanism for 
> the locking. I suppose we may have to trade-off on the "only one test 
> runs" guarantee as a consequence.

Yeah, in other words, there is no need for such guarantee.  We never
deadlock must be a strong guarantee, and it is sufficient if we make
sure that most of the time the expensive ones try not to run at the same
time.

Thanks.
