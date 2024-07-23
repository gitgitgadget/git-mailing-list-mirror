Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3A5381B1
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721738270; cv=none; b=APy2/ld3pHBA5FEHZvIn/w9P0MqLSezkp0H8mlbCmgDgMAgQFk4hQ01oyxdZuu4wNHInO/9m6fOkXd21ZeibuevdmotfjRYGCc4sDtgyxyjWktAnG/04YfCQeyFr0bDfoUP+cUhQmqPDJa2MKjZpj9tyA9qlNw/ozNwm5yG1qts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721738270; c=relaxed/simple;
	bh=3KWPsTsB41ttMhFbcvWoOEfTu8OSvUPHd8/EB+KHeFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ms8HKl9GxE2jektTTMw2K33F6yUtmrO6VO+M0shBmdhIlZui6bgp80NIQqPq8Yzp8nD7OC274zkF4ybOL3BkHpv6BxMEC4A3UxHvOH6UxqFysoPheo78I2mNLB4bt+9zzsRMXt60hs3SgdAorIawAA47BIf+yIPjlXWGSVjUiNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=AKhLyoZb; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="AKhLyoZb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721738258; x=1722343058; i=l.s.r@web.de;
	bh=I6oOeEtIaLaSJh9jEw8sUZNkNVVRfbq/BAlT/FG/uOQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AKhLyoZbeXrmFlbUa3kGOTJHZ2bnu3yz5ODj6GInc00dqudheyXZZ7XuRwQhX95J
	 o8p8ey0wuF2dTHVI1S/DBT6Z2zZ1OuOYX6dgcLRQ12DltKkU9ePGlPjn24FqeZx44
	 SVflAaR8hqNyQK1I5AkoAOflCsfuSdmi2ZldGeugqsSyjt0FcZ4k8B6IJNQ4Um9z+
	 yYnEQPAxILOY8TANosE92EnzsopPISlPj6rps8+bqygIGMmHX2sXz0Fff6eV8ZhE9
	 uLXgt9sYvOt8tN6bQatvCVAcIKF1ODV8WbMsAKLKU37bARvawWlc40dtA2gszUayr
	 HkiUTtefMoUZ3+cfWw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N30ZL-1sJlZX1aYf-010ZXa; Tue, 23
 Jul 2024 14:37:38 +0200
Message-ID: <789d99ab-8d39-4f5f-a800-6ed5dd19d23e@web.de>
Date: Tue, 23 Jul 2024 14:37:38 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] unit-tests: add for_test
To: Kyle Lippincott <spectral@google.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
 <2dff757d-3c5d-4923-97df-26bcb1c21230@web.de>
 <CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
 <xmqq1q3lb4me.fsf@gitster.g> <be282096-49af-4d83-b5f7-8b4f1b447edb@web.de>
 <CAO_smViM7_Er4hY_WvxJf_xWGtKVN29gJA9APzW3t3GdAaxsgQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAO_smViM7_Er4hY_WvxJf_xWGtKVN29gJA9APzW3t3GdAaxsgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QPZR2KYd6lnvsA7Z5o6r8w8VhJmwU09eKcD+5CcY6r0JdCLVVPX
 JmUHnKtEY9RvjWgY7AcuZdMAwN/Hvc0n2foPfSrOZhFPuA0RMRR3/WXO95vVVP74U0xq+Z1
 FiL2W3s2sx5hVkowu2EdajFGvPtTu8a7CLOQUglR8eqMz35+k08RXOQmt3GiXG6Iue27jHs
 oCl9WkqUSkofQnb9GxtFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KF5hPDbmxME=;x9HhOZv9/4Z7eUPEtwjhjeJadqI
 Oc7P2d6nVaF8wEClSWQgmx5umpoCbCUo1HDNi9GetjjGIR0NZN4yVBbIiRPN4mKPlkAoIIzuV
 RAMktOrI90y59olIAggjrQTilutiUmbNHaMRght2vaTJkXAxfRHvsrWO3wOEhj0eFtJf0wehP
 qQ0jyFT9IMzgAgAH5VBErsFKzxVFMv7pHTwzG9SGxpE56PNQs2rqAD2mkxsNEgTdGY0gRETX8
 JO0oG1+t/pE1zoprCNLRrwl2mHUNHHN/KD9vbE2PPSDlYu+I8AVtfYNeISdmL/8kKhiBaKU92
 bYalu/nip/LqfQLaW/+EOtxBP5tGhWj+G5uTIcLsFXSkuiXIiJ5xwTm7zNhZXgHLHVpfL7kU7
 Jtn9b7mP6SgZB0xlcEU4pne2I3Ahzmjz4PHSffKx8DxExYp0yIWmeGu7Ix6mfsyGWajgH3d+C
 FqS1BYFOanJHvmjTVN3cfpfyYpdbIjDE8o9BjRLyzSgjH76FnIa+DRtz65YmNknYR4E0GBl21
 BU1Nu7DTCkt10GYSOHL/hjCXddb/wzu/m+drV1EyPx42vGQO5mr0Cizrr6GNXOYRfKZzsceMD
 Nhp44dA3sV290VPm4Rc3tdWQhKHrDzUHBD60kGkTrs+a5OCzWFN3v23Be/ffMFjpQyC8ww4nZ
 PVUuoep9szB7S7LlKIBS1ti+pnmsADHs2GgT/uAFtM9czJNS1WisOT7X2Us/SANnSTYf8DmNm
 HjKJgqze4RLhwv5vzBuwDi/HhfEBncEIjK6UTQxSDx4gj/81IiRXXePXgZfZ7xjUEK41BPFBt
 H0oT7pSTSQHt+JYY3oBSqhOA==

Am 23.07.24 um 00:47 schrieb Kyle Lippincott:
>
> If we have a good set of protections against misuse, does this mean
> we're free to rename it? :) The concern raised for why `for` had to be
> in the name was because it was using a control statement (a
> at-most-1-execution for loop) to achieve its magic, and the control
> statement puts certain restrictions and obligations on how to use it
> correctly. If the misuse is detected reliably, we can choose a name
> that's more descriptive about what it's doing.

Well, I called it "test" initially because I'm lazy and it describes
its purpose.

But the fact remains that this is an iteration statement, even though
it kinda looks like a function, and it should be used as such.  We have
to explicitly tell clang-format, and having "for" in the name reminds
developers as well.

There is a slight dissonance between it executing at most once and it
being an iteration.  In C we commonly use conditionals ("if") for that.
Calling it "if_test" would be misleading with "for" under the hood,
though, as you cannot have an "else" branch -- which we don't need
anyway.

That said, iterating zero or one times is possible and understandable
not too much of a stretch IMHO.  I can understand that one needs a
minute to get used to that new keyword, though.

Ren=C3=A9
