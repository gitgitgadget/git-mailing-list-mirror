Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C681342AB3
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721719121; cv=none; b=rOewiDezU1rQKL66YpeTLYUQRGlaecs9IFPPKsH+JMC5HjtkOXOmxZBUHIu4bpPBwsIHrWbejHuzzs5K41V7JQ4R1F4JVJRmisDqVjn1HK9re5LFVNryrILfcCLx5jQjKckQPnPhQwyXN/8bPr2Hj8s0N9f13RNLNACcI9fPZYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721719121; c=relaxed/simple;
	bh=l47ntPFF7SpcCfvP3u6agV/CQGDEIT9LNuU3Llh0ba0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iN1vfC9VpzE5UCDmUjz1py/oo5zdzFMjqs4xWzABmoL7K6SEedP/ShfFFm83Hr7pDLqMcL6pcyLHnJER7M+gkcvgyEQMAbTgzACvwB21RqBp3A8BBsN1W6Eind7Ll2bLEfgb6I8Fbmwp43IfIiZActCnd62NVYk9llw0NVlSHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=fdlbP7Bh; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="fdlbP7Bh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721719099; x=1722323899; i=l.s.r@web.de;
	bh=7dfAbza70shEAuXStoFnOc+xm4n91LgxvH7ua/zC1Ys=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fdlbP7BhXRHLgGTU/2EfC6Bm6SeFWFLn7kqtRw5RLYCjhfutf3M2fxHgMX7j0zy/
	 xg6dMyWyzyi1tYRV4t2SlixcaSn8lIb+xUEvkNZpSxVEognzovgXJOz24iY7tEWeo
	 Qy97Lqg/0iTRnpBGn4zBC6TG29o6HG4fwoyktufoC0iaSfuly08/KQAHZkKdTJeKI
	 Jf9bagAzotX9To1O5XkBSg1+0nyZeqtIK0EbCbxDltDOUYgKiUy38RRnaVEAv7sdY
	 7PHG2eNDQ1R61vEb3SOnxqQ/ICuGkzAzc//gayoZMQhtSW9FufD1wj50wxwy1d1Su
	 Q0zZKZZSoRQ+2vGQQg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnX5T-1s4YjG0wNh-00jIG9; Tue, 23
 Jul 2024 09:18:19 +0200
Message-ID: <dc2e7ee2-12db-48ea-ab49-4e09991f72a1@web.de>
Date: Tue, 23 Jul 2024 09:18:18 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] unit-tests: add for_test
To: Kyle Lippincott <spectral@google.com>, Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
 <2dff757d-3c5d-4923-97df-26bcb1c21230@web.de>
 <CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
 <xmqq1q3lb4me.fsf@gitster.g>
 <CAO_smViu2AtdU3GceEJkGXK-pXZr+QyvrWk5sYRVLypyFp1PeA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAO_smViu2AtdU3GceEJkGXK-pXZr+QyvrWk5sYRVLypyFp1PeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:odoFCnsf/922MvQK1lS8p6pyGXpbCGcqrGO/8WOYo+ZRVGsv/gx
 69lQfVYVW6giVmDK4AdF01n+U9YF1A5KIqOYF5UO1ZoZ6pYmgOEPh3Cfv/kcsHt61BfkCd9
 ea8JzOYoa7n8i854HIXBEaaG3EPbH5MzMDN4cMttgHQ3tLE/YYwiSqZYbFkFeAAIEWz0pQC
 UwqBCwYwigFUkTOsJo4iA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WlZ5I2hbB6g=;TGmCR/qqrbiYeT5DP1DzArB/02X
 1lVMFPo0Ow5Hx9GDpNWTGnyjaKgaSOW32zYhSn8li/iXxFudCJd19td43XTU8fUmdqnum4yd+
 SaO6PhgrDFsxbFa1AYcKR9PyCbrR3MLjqo2OF2szjHnKx+p5ZhS+3Pm3/sezAqCfAE1Q6cA30
 TJxAyBzKcMa0OCZjkcu/Q64VMqCABdjiNebgf0ySQRajkJAPYwnHpF3HH5TtKdiIe6IhovrTY
 0LIGMaFOWV3QXusFZN/Arf5bIjJcLQyLuYwOt44EUHpiBTVPyybLI7O4dHMnQtuuavgDXFcdJ
 183CsiYlrCfQ3Khe0WxuNxgeGatLPlSNmckm86cktflPbHEx0PwlbQ9UiOAE+lxPApCG8Xza+
 b5tOwlBTZ7dylXU6+KyMUMy3DiFiiuv7nchaoOTa0nm3g8G6HmhpRRWgvaLeGDRJe0YY3N9OF
 /59mLsj3gaow6ffuk0oohl6BJisTMCdeyAEhwsObCZgUVk3RsBCf3svUSmKREyIMgkN3HBoeA
 R/5APFR0P0wRUWNvLdkK9ldY6uGLfr8TP+NqXiM23rYVw+U6towDdTqaNIga/eupeVKus31ar
 Dx0wiueMpeoK5Xx/RaMEVjT0XWDPU40qpxxenOkWvPO1e90o/E2Igt9eoEX/guz/DIRbacSum
 WeXsxpMbpuRrXYn3jG+b4iiAj+pHLIa9QZr0JxS2ojru4BSVNSOX38Eo3PewUhx9FoYQyZCSD
 PLGWf3d9WUY5vQKr8uEvsuyy0N57mDxB/bAOtGVjoBBw5RZhhbWchN4FZLhlcK4lNn5UxUm73
 OVngYj9ffYCb8Ucps6jIPZ+w==

Am 23.07.24 um 00:41 schrieb Kyle Lippincott:
> On Mon, Jul 22, 2024 at 12:37=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
>>
>> Kyle Lippincott <spectral@google.com> writes:
>>
>>> I can see based on this description where the name came from, but
>>> without this context, it's not clear when reading a test what it
>>> actually does. The name comes from an implementation detail, and is
>>> not describing what it _does_, just _how_ it does it.
>>>
>>> Maybe a name like `small_test` or `quick_test` or something like that
>>> would better express the intended usage?
>>
>> Names that explicitly have C keyword for control structures, e.g.
>> "if_somecondition_test()", "while_foo_test()" or "for_test()" is
>> vastly preferrable than these, in order to make it clear that we are
>> introducing a macro that defines control structure.
>
> Perhaps expression_test or something, then? It's testing an expression
> (I think blocks are a type of expression? I never remember which is
> 'larger': expressions or statements, and that might only be a C++
> thing, C might not have the same terminology).

If in doubt, feel free to look it up.  We're not taking a test here
(bad pun intended).

https://en.cppreference.com/w/c/language/expressions
https://en.cppreference.com/w/c/language/statements

TEST requires test bodies to be expressions, for_test allows them to
be statements.  Statements can include arbitrary expressions, but not
the other way around.

The "for" in for_test indicates that it's a for-like macro.  This
already implies that it is followed by a statement.  It works for the
existing for_each macros.

Ren=C3=A9
