Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC5C1E04AB
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 22:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551415; cv=none; b=eASCt4ZCi6C9X6Q6nKSau6I+2TYTTRXShhupBPe4sjRMG4hgvQFKW+0w1tFnuRou4uJq1aERW0nErpB7bKT5M1gBQfrHXfiGdPDnTXbmWVAi3wp9rtLfs1IvXxjd3EYSksuqYOzNvlEx3QjRCG/39i2QRkJLlzAIbg5EUF9fvk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551415; c=relaxed/simple;
	bh=s2DkwhjtM73YcCeWIbrGASKEIEeT8Hf7ZHU8P6Ga8hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+ZovB5HYoHo24IdEdEgnwpbs8OqgbdrQWXwd87ahxzqAaXHcu5IzR7rq2VN1iBgSQu0U8gYibxcSps8lZuB1SyERHeaaYjkljIWRGnQQSACdjkdU8cxbq5sqc8e49AsY+Iiak07VEvYp9N/CNA9yLWu0/gpK4IlKLdzYDE4HVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=M0gHlpTE; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="M0gHlpTE"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 31KMtqGbPxile31KNtAidE; Mon, 21 Oct 2024 23:56:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1729551404; bh=TePJWvqXMtdU959tt7l7guYXfMuwlOz8CcUVCwSLE4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=M0gHlpTE5K698yS5CClq5R8+lsCidiPG/S2siyMDfVcJ4iXGMr9KCeLLKIUP+G5gk
	 JlTK7YERoulf9j2bPGM8L8hf4iO53YGnOMNB5QY68d6TqgrCBlCgrV7OAocbL2USZI
	 PsUErAxUk2O6hP3ZV1zC+pTS4fZCgnLOcWOMTfZWAvbr1vXXAnvT8LVr+a21gQrUGD
	 r7A4HOJ+azp5dqEUBthXNh7HPIjPi5ErvY7q3TYlAIg/byALLZyjD4O//TNHpKBpsU
	 dJVyhgUUoJxTGdWZa97zmy1E5luI/VneyRn22rhGEnq7ck8XqEXw5fWyeRI0E+hpM6
	 n644QBjKCjRAQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=VaJUP0p9 c=1 sm=1 tr=0 ts=6716dc2c
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=mal0KrOvvYtf1J3j2dgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <b35b6f10-ebb5-4266-ab95-aafb67cfad22@ramsayjones.plus.com>
Date: Mon, 21 Oct 2024 23:56:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/15] Modernize the build system
To: Eli Schwartz <eschwartz@gentoo.org>, Patrick Steinhardt <ps@pks.im>,
 git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <cover.1727881164.git.ps@pks.im> <cover.1729254070.git.ps@pks.im>
 <86de131b-bdea-4c37-b512-68b8378f4343@ramsayjones.plus.com>
 <361e69ee-4491-4e2b-8edc-fdf4bcbb8532@gentoo.org>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <361e69ee-4491-4e2b-8edc-fdf4bcbb8532@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfC3x5TjSdBqIvQNmn0M/4LSS4XD1CaHAlmDoGHWJQAsl1P/VcsmTyAniItwtH7ILR18fAJmiwPtnsZD+m+HsFtsBDuFQh8IXbVhp0ucCldAscTRTiEiJ
 PXAzMFHhvTF/oucHoanpOCOe1jsDYc8MahTIzh8Ba6r9ICffk4wZ8nBNXK7Goo5QboCEE8xRUGmDbrjEThRDfkkVwWZNZdXfLqw=



On 20/10/2024 09:51, Eli Schwartz wrote:
> On 10/18/24 12:08 PM, Ramsay Jones wrote:
[snip] 
> possibly because due to ninja's juggling of pseudo ttys, the python
> runtime for "meson test" thinks it is *not* running in a tty. I know
> that ninja messes around with this in counterintuitive ways in general,
> but I am not sure exactly how that interacts with the console pool. But
> regardless of the reason -- if it is happening at the python level, then
> exporting PYTHONUNBUFFERED=1 may help. It's something I've had to do
> before for programs other than meson, at least.


Unfortunately, the 'PYTHONUNBUFFERED=1' idea didn't work. In fact nothing
I have tried on cygwin has worked. For example, if I use meson to run just
few tests, like so on Linux: 

  $ meson test --no-rebuild --print-errorlogs 't000*'
  1/9 t0000-basic             OK              7.52s
  2/9 t0001-init              OK              1.88s
  3/9 t0002-gitfile           OK              0.37s
  4/9 t0003-attributes        OK              1.35s
  5/9 t0004-unwritable        OK              0.23s
  6/9 t0005-signals           OK              0.16s
  7/9 t0006-date              OK              0.73s
  8/9 t0007-git-var           OK              0.40s
  9/9 t0008-ignores           OK              3.09s
  
  Ok:                 9   
  Expected Fail:      0   
  Fail:               0   
  Unexpected Pass:    0   
  Skipped:            0   
  Timeout:            0   
  
  Full log written to /home/ramsay/git/build/meson-logs/testlog.txt
  $ 

On cygwin it looks like:
  
  $ meson test --no-rebuild --print-errorlogs 't000*'
  1/9 t0002-gitfile           OK             12.32s
  [2-4/9] 🌖 t0003-attributes                12s

Which actually looks nothing like what actually happens! The first line
is actually the result of (*maybe*) running all 9 tests, but during that
time the line started with '[1-4/9] ...' and they didn't run in sequence
but jumped around ending with t0002. Then on the second line, it almost
immediately hung, again with python hovering up all the cpu cycles. So
I had to kill the task from a second terminal.

Actually, I tell a lie, I did get a single test to work on cygwin:

  $ meson test --no-rebuild --print-errorlogs 't0001*'
  1/1 t0001-init        OK             32.95s
  
  Ok:                 1   
  Expected Fail:      0   
  Fail:               0   
  Unexpected Pass:    0   
  Skipped:            0   
  Timeout:            0   
  
  Full log written to /home/ramsay/git/build/meson-logs/testlog.txt
  $ 

Notice that this took much longer, at 32.95s, than (what looked like) all
nine tests above at 12.32s. (although via 'make test' t0000-basic.sh alone
took 124.13s for v2.47.0!).

Patrick, how do you run the tests on cygwin?

ATB,
Ramsay Jones



