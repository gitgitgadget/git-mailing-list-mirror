Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82FC1757D
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727287598; cv=none; b=KN6b0DfrpUjvo/Hnd/uUysx7CZf5ZfT1foyza2ZZ3fFkLefTRzYAAA87z/NNr5C7F6P0Hp6yeUvsGEPtvyN87a0eVzP5W3Q8Va4ofhw5Pz0yPYHP+xDwOaEv5gk8dm+RAY6nztlwEgmQ1bAk2snYsW6jwIUE8eEZxaPonqPRsSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727287598; c=relaxed/simple;
	bh=9FuMESPEsdDBFyCR6x9yIMULEi2JcCvrWo48bC83Fns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kR6TxkuX2+z6ynkyQizHPO5FqlYZ1vkgnzxYGt4EeUFaXXu2XDWC/oSRWyTbBtczGh+qG1VSQFpw7UBoolXz/KGqIqBETmz8WJskoItCoVUW27ELpYhafpvrQVJrwS4mXzVxOAXhupFEFiTp7rZ2mfGIudLKVTeW41lBcGARvkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=tQZ1qYSF; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="tQZ1qYSF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727287591; x=1727892391; i=l.s.r@web.de;
	bh=bq7iFhM1Wf4dqxB7gmeqcOjkKLJmc5Ydf95iKxM0r1I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tQZ1qYSFL/cq0KDLhcoJKCW3pjjLshZgplwwVGDz5jH6GjU3PfpHtqCnQCDSwr3y
	 cp8ewSiPxAKt8R7Nmz3c0XnCI8N/QRxihNOPyhYrlUGCdp9Z95Sg98+Du8ZWqC7ae
	 34n8Umth2pUWREgyjpa2emtji4YDhIbyampqgLcW6I9ILufMUJgndQFepVCWS0R8S
	 FSqD4myDzNXvYA0bqUrGVvgMf/PcJDJMVNjZUtnkWddVAUutYmItSxif5GDiy1zlI
	 FXhVLHdji37/jF1DG3yV+YD9WEqhPl2b1RJAaQejfosd1ay42vOW07FY0x+qt/Hud
	 Lv/xRliuP5bmw1eQDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.152.135]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2Phi-1svBdI3W2g-008a7x; Wed, 25
 Sep 2024 20:06:30 +0200
Message-ID: <161b4e83-0aa5-4b98-a1c7-b6e1070629d1@web.de>
Date: Wed, 25 Sep 2024 20:06:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git diff --exit-code misbehaving in 2.46.x
To: Junio C Hamano <gitster@pobox.com>
Cc: Jan Wendland <jwend1703@gmail.com>, git@vger.kernel.org
References: <CAB0mhhz9LHZ1AWSu_0oM=c89+z0w=XemnQwFAm45wp8zSmQ1Sw@mail.gmail.com>
 <e3da5c9b-c208-4937-a2b4-e1028f3e6841@web.de> <xmqqbk0bpt5e.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqbk0bpt5e.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FRHKI9CXXHbt+mz2nOoBOKD23vYtFmnOam+gBhFgI5L+D5PENK7
 uukytCv0hb9FczjeMy1ycoDGfovqAYXcPryx7iwalhrXKaJ0aJnDj/FdmPGqDNfGJv4SEbQ
 PYBedJtiwe2AJGuXcG1nIhBO3PlFeCl/TUs0g4OWfnk3XY84VJzmPw+RS3m65t0uH9fgYt2
 ANLkUpt/9+uEuwUaqiXbg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F3hoe7J50cA=;BTuSjwp72YaAztWz/Iil1cRC+CW
 /FhuKRX4HnYVLN6YauYcuiLBccpsVTcGiVXydPZFEgI1W7WOOxoZvdjFQPuMmKfF9r0W9YxjH
 Gy0V91lZCK6Wqa+00emsVvooRoGkyGK1Moiyf+eUr4HHbWEpATzGXMbuoljpPAOj0/S4Ra0+v
 a+5YE1G6U7TA8hpXx+sX9nM8n2phIVEGANTo6YE5MoOKk+XpNiEr9Jreq2tCSlF3IpWtDDSM+
 ga6OFJ6sRcil5uQAo6qcwz5vfcpaM8EJjA2jkTzLPxuWyWC9yjfUmL1iSBgjkyq1rw0HcdNoV
 gC4x4Weln98nq1r/webE1ggFOgCEbLxqrT/u/dF5oN86fL2aDNIZupeQpU25nbETqIuSJEXtO
 rz7mw9nLs2fqJl4NbpreehZ/WeALU4ShQx+LoCQxW6Dpv0zVMhtiHbRweauJTfnyOub3bp5RK
 S1RYtUcXxFWSoDz2no3jL8JC8irSSnkOJyBou7yL3B8a/J92Ma7qvQrC9vQx03FGNftMHIJZn
 KDZsCSgn9keSCby40TXssf6AFSNf6lkAnSAQlOcvmQHppkFms6TiKDkFX7+WEHnLkQiuNdfex
 /7XlFO+G0yoGIzp1apdEuPi6RMSwbuQRFs213rSfkHv20cd1UEwrLOSz0g5NrCSQxa+Zf42f9
 zZcDPV8/ZbfK+dFpGeSF4gQlyjGFKpdc9d2uIw6It8dnNn/ep1kMkJsTe/M3E5NyLcKY70VYB
 eohviHqtqsdiMn6SLRS3i6bb2UOuAO/teE/VNdcNrwgh5a0Y8BozZvzD68thgNz9zbO0HUhQr
 TALHyzC6B2VbjOyiLtcjJ7ag==

Am 25.09.24 um 18:58 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Am 25.09.24 um 16:27 schrieb Jan Wendland:
>>>
>>> git diff --exit-code in 2.46.x is unexpectedly returning a zero exit
>>> code for files marked as binary in .gitattributes where 2.45.x would
>>> correctly produce a non-zero exit code.
>>> ...
>> Thanks for the report!  This is a known bug.  The "next" branch contain=
s
>> a fix, 9a41735af6 (diff: report modified binary files as changes in
>> builtin_diff(), 2024-09-21).
>
> I just noticed something curious.
>
> 9a41735a (diff: report modified binary files as changes in
> builtin_diff(), 2024-09-21) explains that since 1aaf69e6 (diff:
> shortcut for diff'ing two binary SHA-1 objects, 2014-08-16) added
> binary comparison, the code path always used a quick hash-only
> comparison.  But the above report claims it is a behaviour change
> between 2.45 and 2.46.
>
> It does seem to say things are different with 2.45 when binary
> changes were checked with --quiet/--exit-code from my manual
> testing, though.

There are levels: If the flag diff_from_contents is disabled, diff just
compares hashes (and other meta data).  If diff_from_contents is
enabled, it compares file contents as well.  But not for binary files,
since 1aaf69e6 (diff: shortcut for diff'ing two binary SHA-1 objects,
2014-08-16).

The shortcut exempts binary files from diff_from_contents.  But it
forgot to report changes for exit code calculation.  So git diff with
an option that turns on diff_from_contents (e.g. "git diff -b -q")
has not been reporting a modified binary file since then.

d7b97b7185 (diff: let external diffs report that changes are
uninteresting, 2024-06-09) enabled diff_from_contents by default,
exposing the bug much more widely in 2.46.0.

Ren=C3=A9

