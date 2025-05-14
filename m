Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CFE129A78
	for <git@vger.kernel.org>; Wed, 14 May 2025 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747238350; cv=none; b=gApEo8Mtex2sLvXLAhetwMHXJlQannAE4FsnEizSxDs1ZBiar74Q/1UiNQXnOsPz18F8uuq8bHYPPIlEOnfkP+pkgbLzdqnBRO7KQESJFA23LjPR/xpoVJu5POnByWP9/8s3JcQKnB0fCZDOZZjGFnq08ekGxVkeri+Bu4xMuGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747238350; c=relaxed/simple;
	bh=rZj2o4PHMBqzp2B0xgznIbXTmPV8uwmPXEw27npSMFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=NRAoX9xYnrvUJaw9DL/rRGdS1yDN/WpHf7Dpfk6oRlKYSDfoUf+hslALV8VzqNyX0QGMqwH31SUzHONGGf3X/xz9mfB9DhxGoVZ/CazK4q6yE+7LPFLS/Oveq4cwzzCOh4/W5yGjg4hnal4ZqJw9OL8Ixa6g5PjT8T3qTXGaRKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4ZyJ1Q0ZWKzRpKr;
	Wed, 14 May 2025 17:59:05 +0200 (CEST)
Message-ID: <dc575a3b-42b7-43a1-8338-e8b4f5a16237@kdbg.org>
Date: Wed, 14 May 2025 17:59:05 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "POSIXLY_CORRECT" - "msgfmt: msgfmt: --tcl requires a "-l locale"
 specification"
Content-Language: en-US
To: Nathan Royce <nroycea+kernel@gmail.com>
References: <CALaQ_hp2dgPS5HYpYPzztCS52SCnR9vF2ovAHZOBPpS8MRLSrA@mail.gmail.com>
 <fc923099-52ca-4f0d-8490-c5768a098444@kdbg.org>
 <CALaQ_hqoARJX2djK3dFUm=bUsnx9NVduQmqQVkbasCnLsixjaw@mail.gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <CALaQ_hqoARJX2djK3dFUm=bUsnx9NVduQmqQVkbasCnLsixjaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 14.05.25 um 08:50 schrieb Nathan Royce:
> On Tue, May 13, 2025 at 12:27 PM Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 13.05.25 um 10:17 schrieb Nathan Royce:
>>> Order matters with POSIX. Arguments come before source/target.
>>>
>>> Success: `msgfmt --statistics --tcl -l bg -d po/ po/bg.po`
>>> vs
>>> Fail: `msgfmt --statistics --tcl po/bg.po -l bg -d po/`
>>>
>>> build/gitk-git
>>> make[1]: *** [Makefile:76: po/bg.msg] Error 1
>>> make: *** [Makefile:2466: all] Error 2
>>
>> Thanks for the report. How did you get this report? Which OS and version?
> 
> Just `\export POSIXLY_CORRECT=1` and try to build it. It won't.
> You don't even have to build it fully, just run both `msgfmt` with
> that environment variable set.

Thanks, fixed.

-- Hannes

