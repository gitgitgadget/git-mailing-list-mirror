Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L+mqrEo9"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7498EDD
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 11:22:55 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CBD081C8A88;
	Wed, 13 Dec 2023 14:22:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZIFHaLXXXOno
	VnhK1+3IzdJ8PG75E6caQJlhntrEUdw=; b=L+mqrEo9zNmKXXH71HxEeLZyHx1T
	igvwAsPK9gWYzprosQxQGdEkroKZpdz6M0LNBqtNale+jWU06y/WZCYd7JRlqDOF
	DKpp36F9wSqFDnw6NC5CGDpzZN/7kYlQ45j10i62EIOO13PjK0BJWGggtu4G5b4G
	xoJH8nUYUs+jMGM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C478C1C8A87;
	Wed, 13 Dec 2023 14:22:54 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3EABA1C8A86;
	Wed, 13 Dec 2023 14:22:54 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?ROaXoOaVsA==?= <wushuripple@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: End-of-line comments are prompted with "is not a valid
 attribute name"
In-Reply-To: <CAOQ=bxz8txyOt6p5L0qfx5DFKfxUhWvHW0pJP+YTbWVfBpvYxg@mail.gmail.com>
	(=?utf-8?B?IkTml6DmlbAiJ3M=?= message of "Thu, 14 Dec 2023 01:32:11 +0800")
References: <CAOQ=bxz8txyOt6p5L0qfx5DFKfxUhWvHW0pJP+YTbWVfBpvYxg@mail.gmail.com>
Date: Wed, 13 Dec 2023 11:22:53 -0800
Message-ID: <xmqqsf45nbzm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 03A80938-99ED-11EE-AFB6-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

D=E6=97=A0=E6=95=B0 <wushuripple@gmail.com> writes:

> This is my .gitattributes:
> ```
> res/csv/*.txt eol=3Dlf # =E4=BF=9D=E8=AF=81csv=E4=B8=BAlf=EF=BC=8C=E4=BB=
=A5=E5=8C=B9=E9=85=8D=E8=A7=A3=E6=9E=90=E6=A0=BC=E5=BC=8F

I do not think of any version of Git ignoring what you wrote after #
(including #) in the middle of the line.

> # Custom for Visual Studio

I know I designed the parser to allow this as a comment, though.

So

> When performing certain operations:
> =C2=B7=C2=B7=C2=B7shell
>> git status
> # is not a valid attribute name: .gitattributes:1

This is totally expected; nothing to see here.

