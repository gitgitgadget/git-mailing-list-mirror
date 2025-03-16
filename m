Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAB81494A8
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 22:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742163865; cv=none; b=pkw7LLXTr6uVg/fmxSRVUpBv/IQTj+THQ7evXQvC+l8o3DkvoySg1UGe5vOFO4ZHG/VTOS+TFaN16h+NeCaNbMmHnhp4qB5Q0Xdh42QXR2PA/gwXXc7ej2QaFVRhCvQoZkRqVq1j21p5ScN7x4/S0hsNluDqaKGMAJuuytPhLq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742163865; c=relaxed/simple;
	bh=9u+5GBi9S5nmTNZNjIh7PjVrHXyjDdDDdP7xDtAHags=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EaPYsE+VZC4kUpz5rIsv0VySM46ckz6JVFRCjsH8saBh/K6e7RnSLRzPo8xxhCr5laqFs5QQWjS/TFnssYMc8Ml4zufY7MM4qrxJzveTXc991orYOIC9iBfAindJPgg2mICRmqbsOpdZKgE0dA7nmzKkXbqV7JOfBCYkQZtAxzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=LY1WUZ7K; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="LY1WUZ7K"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id twP4tzFtABiaNtwP5tb0oa; Sun, 16 Mar 2025 22:24:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1742163860; bh=drxCoXbgGT8s7j+/ObM9NEZjLAlrtTV7ifoQCPysgjU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=LY1WUZ7KGMrH/92/vJyW+1Y5MjEgbWidQJLDUZaKM9XmdM8B2JO9AgRxvjTd5Z666
	 bx+vGBwPM9ccgRChGpbzcoZpR1CxF73VckP+4eX1jsiAA4ckH8gAr69Tf6IkFlp342
	 2GSrqhcv+K1+MJs3jUdVUsNDJPymEClYzqkyPQ7CAVYi3GSG+NVjqwoxHQzvc3ThBo
	 VYoqowNafSpnohaLszAo7mCalZ2hw+gcMLHofSVKPxPjIR6YcB5h+7vq2Q3loVrQGW
	 uUnBpbaf/KjqdHLJ1xozbAwS/pdHzMw/qsedF3PCYbqfD6sCOHuV6KW2122PbQEUvg
	 KwXBnPNQiVXqg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=W8CbVgWk c=1 sm=1 tr=0 ts=67d74f94
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=QlNfkm0kDx0h0sBWwOcA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <33561996-3b7f-4d0e-825f-5b2369d7d010@ramsayjones.plus.com>
Date: Sun, 16 Mar 2025 22:24:18 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] config.mak.uname: only set NO_REGEX on cygwin for
 v1.7
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Adam Dinwoodie <git@dinwoodie.org>
References: <a4272c4a-7073-4671-a883-50e9413b0384@ramsayjones.plus.com>
Content-Language: en-US
In-Reply-To: <a4272c4a-7073-4671-a883-50e9413b0384@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNgrbIrMpI3Ktw13x7gU14vr1HPpqLArg1dOk6T3/5Tetrbficy9gd1eszGK4IVluPV7Vfp13Aj+/5vk9jBbhzAwG1dpG6mCXNsi9l07RTnamC8p+E8X
 jx3idyH+Tysk4A/En41hpLE2TOnNvwakw/G8f6Pgnh5KPibbNiDOEkr9wJ5Sy9lrkBbimw0rqL4kZG8oM0ha/qqs5GWBYZ1pym8=



On 15/03/2025 02:47, Ramsay Jones wrote:
> 
> Commit 92f63d2b05 ("Cygwin 1.7 needs compat/regex", 2013-07-19) set
> the NO_REGEX build variable because the platform regex library failed
> some of the tests (t4018 and t4034), which passed just fine with the
> compat library.
> 
> After some time (may a year or two), the platform library had been
> updated (with an import from FreeBSD, I believe) and now passed the full
> test-suite. This would be about the time of the v1.7 -> v2.0 transition
> in 2015. I had a patch ready to send, but just didn't get around to
> submitting it to the list.

I forgot to mention, that one of the reasons that I didn't get around
to submitting this patch then, was because of a '# TODO known breakage
vanished' in test t7815-grep-binary.sh:

  $ ./t7815-grep-binary.sh
  ok 1 - setup
  ok 2 - git grep ina a
  ok 3 - git grep -ah ina a
  ok 4 - git grep -I ina a
  ok 5 - git grep -c ina a
  ok 6 - git grep -l ina a
  ok 7 - git grep -L bar a
  ok 8 - git grep -q ina a
  ok 9 - git grep -F ile a
  ok 10 - git grep -Fi iLE a
  ok 11 - git grep ile a
  ok 12 - git grep .fi a # TODO known breakage vanished
  ok 13 - grep respects binary diff attribute
  ok 14 - grep --cached respects binary diff attribute
  ok 15 - grep --cached respects binary diff attribute (2)
  ok 16 - grep revision respects binary diff attribute
  ok 17 - grep respects not-binary diff attribute
  ok 18 - setup textconv filters
  ok 19 - grep does not honor textconv
  ok 20 - grep --textconv honors textconv
  ok 21 - grep --no-textconv does not honor textconv
  ok 22 - grep --textconv blob honors textconv
  # 1 known breakage(s) vanished; please update test(s)
  # passed all remaining 21 test(s)
  1..22
  $ 

The platform regex library is happy to match a NUL byte with the '.'
pattern. (presumably this is also true on FreeBSD?).

I could not decide on the best way to 'fix' this issue. The options
seemed to be: do nothing (it's not hurting anyone), disable the test
on cygwin or simply remove the test.

[I think I prefer to simply delete the test, since it doesn't seem to
be testing anything useful, as far as I can see.]

What do you think?

ATB,
Ramsay Jones


