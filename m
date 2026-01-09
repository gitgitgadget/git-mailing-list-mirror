Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB8235CB76
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767965648; cv=pass; b=ThF7jPuwlfSs1Ed9jC9ci1OYG1qBfuTX/UiwkQidj1aaEoZZvB0crvL3zusO1CL5XB0DiMr7ASltHRYPSFM7O8S00W7ryqNVqBAYMUPkuWbhe3NfwHsIVKo5DWe4HyeqSQPyONUk4xhX1oglmkjFBTT/5R2Bar294gtOr2Mu6Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767965648; c=relaxed/simple;
	bh=3caZk21Io00TMmzu9rzBxrvKv3XJCnJxSKfueOrrDms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X3CkPMwvbqHyllNPH3dIAD4l/HKw/HjuDu1q3BCvbw3VYvlz0sFlpLqxLB8/wELAVfHZWLUBFudzkKl1S4fNA0L4sRqWegwFf+3YHpyoDDz4zaIPI6dF/vDXtR/F3TyVLbJ8D0p56wxc+tSI2DuuX61p8mWwlsUjf0wPUoP1Tjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=T3bbl1UK; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="T3bbl1UK"
ARC-Seal: i=1; a=rsa-sha256; t=1767965634; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MQwiRe5CnrSJu0imVThpLMUe96tINXeDFRcvC307sLaClrk+LeMab626ZzBjuLiGZGMn+es6P1j6GCd8ukDhDaZ85ur7qvnsub82WkZjSSxrqz1rgmE1YSAmDYqVb1ns8y6477ISzmb4Uo/UoxC4W9GUQDLzOmTt3dmkMEcF4uM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767965634; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3caZk21Io00TMmzu9rzBxrvKv3XJCnJxSKfueOrrDms=; 
	b=fHKjX/xMQBv0ADwAzuKaFbTNJAT+rYFKRQH1OC1HX52GZcKFm/9HwPHLoh6NWZAP1XC0+nKqudDmPtcZQeWF7lWXfbEFy2Ys2tQDi5r2Q8Jyhy5hK2Xc+tgdRXtOmhVgILB6Zs+Vl6OBovMOf6YwcogskVKZeqpJMJqHmPEX5Hs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767965634;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=3caZk21Io00TMmzu9rzBxrvKv3XJCnJxSKfueOrrDms=;
	b=T3bbl1UK9zLwHpFEAbKt1palZ4iFQPX15bIm58DpD2vkHGD4ENU0g2z4QfK4FTth
	cbV1Yu2XTxmzC+F7fpHATarE8VdjocCo7242N3Ql8a29gHE+hYna0yT7hANt0xwWa+P
	OWwpXgfH4k4hXPtF7cDPDC2gzUwT3hmH8JLENH5o=
Received: by mx.zohomail.com with SMTPS id 1767965632332169.28765048705452;
	Fri, 9 Jan 2026 05:33:52 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] ws: add new tab-between-non-ws check
In-Reply-To: <dcd87fc4-6514-4146-9e44-1276bd739d2f@kdbg.org>
References: <20260107013051.312291-1-adrian.ratiu@collabora.com>
 <d3f26459-d828-4d01-8c38-ce754e5cc576@kdbg.org>
 <dcd87fc4-6514-4146-9e44-1276bd739d2f@kdbg.org>
Date: Fri, 09 Jan 2026 15:33:47 +0200
Message-ID: <87h5sux64k.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Thu, 08 Jan 2026, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 07.01.26 um 18:33 schrieb Johannes Sixt:
>> Am 07.01.26 um 02:30 schrieb Adrian Ratiu:
>>> The check is a bit complex because we want to detect places where
>>> a SP was intended (HT can expand to more than one display column),
>>> so we need to count both the display columns (col) and the string
>>> character columns (i) to determine if a HT looks identical to a SP
>>> or can cause confusion.
>>>
>>> Highlighting support for tools like git diff/show/log is added, as
>>> well as git apply --whitespace=fix capability.
>>>
>>> The middle section of the line used to be assumed non-highlighted,
>>> which is obviously not true anymore, so we split its logic into a
>>> separate function named emit_middle_section().
>>>
>>> The new check is enabled for Documentation/**/*.adoc, where these
>>> kinds of mistakes were seen in practice. It can also be enabled in
>>> other locations where it can be useful, by adding to the relevant
>>> attributes file.
>
> This makes me wonder how useful this check is. Yes, I has happened that
> I didn't spot at TAB that should have been a SP, but perhaps a handful
> of times in my career. Compare this to the many times that the other
> kinds of whitespace errors happened.
>
> Applying the rule to all documentation files is questionable: I can't
> format a table with TAB characters between columns reliably, because if
> a column happens to be 7 characters wide, the TAB at the 8th position
> would be diagnosed, but I certainly do *not* want it to be replaced by a
> SP. Yet, I might want legitimate cases outside tables to be diagnosed, so...
>
> Maybe I'm too much of a devil's advocate here...

I'll let Junio decide on the usefulness of this check since he's the one
who asked for it. :)

Maybe we could improve the heuristic to detect tables, for example
patterns like a\tb\tc.

I'm ok either way, just let me know if I should pursue this further.
