Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A83E2E9729
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 03:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773460796; cv=none; b=S3J3JFyi6MXPWSsS8ghnjalqGyCHBP9dyKkgptJKSHDX4JmyPd6g3iDEVc7HUXxXH0o9Xc9Lz7LMNQ3xFlGMn/xzaPO9RV8vYVbFhLPd2rgqib/M8w4Ol1lxk4VR75W/J5AuYwHO1Pr5wbCMDceVL2s0c4TnxBTq7uzByuexxe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773460796; c=relaxed/simple;
	bh=CzxHbpPw01aVAadzDToIEir8GnrzikcgVQwO9hlJsoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kvEQxMAM7By2n2Xho68TwxuHWeyaqypP9E4itzijSVP0NO/nIoBKT0H0e340og/6eTu1SltJ82l485RBsdoXK8W5O/krLSBbH8fWfaNZpjgStAQ5Nr90wtP5WZ5lhPoBxqQ2RZkn+oEn7ZsQr8rr6nEEfTExaCi3icIE7IjDyA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=PiMLMzct; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=TFsbSGIb; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="PiMLMzct";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="TFsbSGIb"
DKIM-Signature: a=rsa-sha256; b=PiMLMzct31l1+aoR29MPFHA1svpu/shYA73VRfeZMFf5rp801HybB83ZRVFkuXAfGv6kqhiyv/IgEfRQFjVONyoeZRsulxlTfABf5DBm+Kg9trcJYf0Y1/jepgFs06qGsvqsKq/D5l7mm8U5axXE2iHcJ9PkJZ4VeVF6hTF/eVdVyEMg8VY3T/3KCXi8YZoh9O1qKht19OOkMUEbCqx0Vke/Ju6dJrzmThi5PVU6UZs1q1M2vuC14krOb8v2TG8FtpMbb2iUao5NfwgmwF9h8qQF5Y08MltUNO78mkMFYqIkyweyIX+GnXl7wr3fsLGaGrwMsxPIF4qgqpqwwQ5j6A==; s=purelymail2; d=malon.dev; v=1; bh=CzxHbpPw01aVAadzDToIEir8GnrzikcgVQwO9hlJsoo=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=TFsbSGIbSZ7ym7uxHaKgIRkX2B/Yx/z/B0Io40dGfYFMcgy/FJq+Jo2urzIXa9tT+GsEHQKE1CIrLxw1P4//qUK2ZY0hwCZ2/4ZmJloVkOLcHABh4XgidmYI+8DrPBYLGgIlBCrmbZzWwJMagjjRpF/lMwCMtNYKO+2Bgm9yNjvah/cE637o/FS2W0rJMnX9GXlhtKdbIgADVOK7uynyxSm/vwqm/PAP+SJP2NQFFf/dGMqdse7ZAeHa5d3TIiA8wBuHq80WEm/iKjc4ccmMknIBW6Uy/y3UbUNoPQe/fpcWLDLb1m+MU67dmAH5xapWo+ufdcPhHOc0DTiJyZ9+cA==; s=purelymail2; d=purelymail.com; v=1; bh=CzxHbpPw01aVAadzDToIEir8GnrzikcgVQwO9hlJsoo=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1281284292;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 14 Mar 2026 03:59:47 +0000 (UTC)
Message-ID: <405c075b-731b-47e3-9e9c-70aaa0efe1cc@malon.dev>
Date: Sat, 14 Mar 2026 11:59:43 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH GSOC] diff: use conventional comparison order
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: aum2357 <ahambrahmasmi2357@gmail.com>, git@vger.kernel.org
References: <20260313140440.564201-1-ahambrahmasmi2357@gmail.com>
 <9afe48e3-8348-4e2c-8e5f-bbdc3b2951f8@malon.dev> <xmqqldfv4h6k.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqldfv4h6k.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 3/14/26 04:18, Junio C Hamano wrote:

> You guessed wrong.  See CodingGuidelines.

It does have nothing to do with the compiler. Thanks for pointing out.

However, the coding guidelines state:

> Both are valid, and we use both.

So, the real key is this sentence:

> Just do not mix styles in the same part of the code and mimic
> existing styles in the neighbourhood.

However, in builtin/add.c before the patch, there isn't even a single=20
=E2=80=9C>=E2=80=9D symbol used for comparison. The =E2=80=9C<=E2=80=9D sym=
bol is used throughout the=20
comparison sections.

I find it quite strange because the author says:

> to follow the common coding style

This patch seems more like it breaks the common coding style.

Regards,

Yuchen
