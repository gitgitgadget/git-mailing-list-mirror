Received: from mail.luna.gl (mail.luna.gl [141.147.12.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82303A4508
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.147.12.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780388120; cv=none; b=TLlfN/93thCXGAAPmjT6E3Mxe+KVguOQRJTUU7XFUg0k5HBhOvub7GlMf4mveX8MdmgRxu86lhKJnopRYitlrh9z5Tf8BWinn7hWQfHzk0BZnM9Yfre/ig0EeNLRY+6Ky7OUtw6cW/nGSl+thDy5gEiSjAzX6iRRZ92PaJJh9cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780388120; c=relaxed/simple;
	bh=W3hx+emmdU19WIi1zxcdqVcohYjmXbjuSl6mfH/0Hgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UESRz25kNfMW86tmJMbonEG+YQ+NtzueJEgYjCKsmDBzulLWGFBM/94WZhy2GuQa54xMiq5vqdcVBY5oqfCL0BVeBbfrDwU2wDjcFLRi4ep/OsQKOTUKMvnm8FdqshOeO5Qs2RW9T5JmgWyEGI+XJ8v2sbebBOLxf20Ca8Rz7bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luna.gl; spf=pass smtp.mailfrom=luna.gl; dkim=pass (2048-bit key) header.d=luna.gl header.i=@luna.gl header.b=RgFU8gcH; dkim=permerror (0-bit key) header.d=luna.gl header.i=@luna.gl header.b=d5MK+yut; arc=none smtp.client-ip=141.147.12.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luna.gl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luna.gl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=luna.gl header.i=@luna.gl header.b="RgFU8gcH";
	dkim=permerror (0-bit key) header.d=luna.gl header.i=@luna.gl header.b="d5MK+yut"
DKIM-Signature: v=1; a=rsa-sha256; s=202405r; d=luna.gl; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1780388115; bh=vY0812oE2bLpcO3HoqRYedM
	eLSg0Pq7wSIGAWfmTLa8=; b=RgFU8gcHFlG15Lzz1PAmWKgwoqL2RFAg11lpuxo7zqnngK2ndk
	Xh37PogPJN3LfmIISLQBv4yuphu/rWzCsq+dlOaHRUpK9eLQ7I/bGEN/lb5QGYfgG7ZeOrVhK/r
	UmK+7xvliUbZ32z4c+4NFQjMb8LFCRsn/vef+Yqh52grIJoPTiGKPfUKP/5bg5vyhjeCYv7meKG
	wmdyzenOCmmNIoVWYCTPrtT3A6ej4nT+SagSisNtJFjvd5AcPq0yCuypuAQFvfsx68YLln92Qt1
	Wjq7x2YFy1EmuEJcJm81EFlzqg+CzLB7+0mQ17cG+lPg4iTGotw+UpQlcsl1yeCqcKw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202405e; d=luna.gl; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1780388115; bh=vY0812oE2bLpcO3HoqRYedM
	eLSg0Pq7wSIGAWfmTLa8=; b=d5MK+yut5ECH4Vx1ADNZ5eq593FqaVXXLMHD7cQjgzq6ut3Ef0
	EiFzJgf79pP6t3CJpvWwPYSXvNVNDVXXCqDQ==;
Message-ID: <2194e42a-5c41-44e1-ba36-1599cbd41415@luna.gl>
Date: Tue, 2 Jun 2026 10:15:15 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: document and test `@` prefix for raw timestamps
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20260601213944.645731-2-dev@luna.gl> <xmqqfr35zt6h.fsf@gitster.g>
Content-Language: en-US
From: Luna Schwalbe <dev@luna.gl>
In-Reply-To: <xmqqfr35zt6h.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 > Does this "additional paragraph" format correctly, instead of
 > rendered as a literal block (typically typeset in typewriter font,
 > monospace)?  Don't you need to do something like what is done for
 > "ISO 8601::" that appears later in the same file?  I.e. lose the
 > four-space indent and replace the blank line before it with a single
 > '+' list continuation operator?

Terribly sorry, you're right of course, I somehow forgot to actually 
build and check the docs. Will send an updated patch right away.

 > This is totally outside the scope of this topic, but we might want
 > to enhance the rule a bit to declare this is *not* ambigous.  As
 > there is no 99th month or 99th day, this cannot be in the YYYYMMDD
 > date format.

I agree there is room for change with this rule, although I'm not sure 
how sensible it is to start allowing certain values based on whether 
they are also a valid calendar date or not (we'd end up trying to parse 
YYYYMMDD first, and only afterwards do the actual timestamp parsing; I 
feel like this might just make the system less predictable for users in 
practice).

As far as I can tell the rule is technically not necessary at all (apart 
from some unusual approxidate interpretations like the `2000 +0000` 
example, which I honestly think are more confusing than useful), seeing 
that YYYYMMDD isn't a supported format anywhere.

If we want to have it as a safeguard tho, better documentation is 
probably the most important aspect. As a user, ideally I'd love to get a 
"ambiguous date format, prefix with @ if you intend to specify a raw 
timestamp" kind of error message, but I suspect that might be difficult 
to implement.
