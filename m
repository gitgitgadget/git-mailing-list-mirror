Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D774C6F
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 20:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KC7Zt/oA"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F8B81D77F9;
	Tue, 26 Dec 2023 15:56:19 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=s4w4PwmxxgZlkXaCs/Szff9jX6i8WXq2PMB9Ur
	4NhT4=; b=KC7Zt/oAyG7ENBP+oj1d2nHplYg/VqRmmCQIY5iA3RjFeGSTlfojMb
	QfOFuQcL78BiM5vZwPn2D6WV/aiijCu6Foonzb70B6kmcDEn5HMIW+fBlChT0KH4
	YXOGD/iLjksiafPcxR2JKqXa28fTCDuOyf7G5bvWLj6Fgm80NL71A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5819C1D77F8;
	Tue, 26 Dec 2023 15:56:19 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C10C61D77F7;
	Tue, 26 Dec 2023 15:56:18 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 00/12] Introduce `refStorage` extension
In-Reply-To: <CAOLa=ZR0mM_rVBa3LG-etpgYGCpiXinCZ83hcWLVeZVUhKH3UA@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 22 Dec 2023 05:43:42 -0800")
References: <cover.1703067989.git.ps@pks.im>
	<CAOLa=ZR0mM_rVBa3LG-etpgYGCpiXinCZ83hcWLVeZVUhKH3UA@mail.gmail.com>
Date: Tue, 26 Dec 2023 12:56:17 -0800
Message-ID: <xmqqy1dgfzta.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 37970D36-A431-11EE-934C-25B3960A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Hello,
>
> Patrick Steinhardt <ps@pks.im> writes:
>> Hi,
>>
>> this patch series introduces a new `refStorage` extension and related
>> tooling. While there is only a single user-visible ref backend for now,
>> this extension will eventually allow us to determine which backend shall
>> be used for a repository. Furthermore, the series introduces tooling so
>> that the ref storage format becomes more accessible.
>
> Apart from small nits, the series looks good to me, thanks!

Thanks.  Hopefully we can merge it down after a quick, small, and
final reroll?
