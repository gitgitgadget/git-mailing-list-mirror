Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6516CDA1
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 21:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401816; cv=none; b=IEwIBbqYtYw0DVWBXTH/Lll+wl+K36EzLvumWTo/50u3vK9u6IUrSt4Iso6LuOwaey+kNwvdV5F43JY76sok0yOEVNQ87fylj3rwAIyMacw5Yj07ZMWjrvd2KEdvJu3NZcuLuUeOC+jCPSbLraUNi23MK2sb+cZLiaBGqogcoQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401816; c=relaxed/simple;
	bh=Mgq5lKo6bllFd/mK0e1P72SxIhTP2zmTmXOlDUd2CzE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gOHx1IIg491syzbh6oepBAFA+A00tKNjBGwHboxp7udqcgpH2oUFTDNkSrKzj210+aqR4Wo5ZRZ4cyRAckredfwVUin79bqMTq55KLgAfu+gM7LYgv7k8lkvQ6PyBpLFLbjq/rTOK5KCzM6NXPEsiJL02BeTosxplLPz81E0THE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KiDei9NY; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KiDei9NY"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 500BA27AAD;
	Mon, 25 Mar 2024 17:23:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Mgq5lKo6bllF
	d/mK0e1P72SxIhTP2zmTmXOlDUd2CzE=; b=KiDei9NYSba8g9jJbcQjvBt7tRDu
	E0IrOyfaqLs+D7ggiBr1QP6kU/riTgX3jSR2BGSzlUN1MLimwyfqeMOM3POw2lB7
	nUQrRse96BCIeSzehVekWryORuoJ3Qp4KU4fJGBSw9k0a8YKD+D10O5MQ5T+PxMZ
	GMDAahLBLWJxjXw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4712C27AAC;
	Mon, 25 Mar 2024 17:23:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CBFA927AA7;
	Mon, 25 Mar 2024 17:23:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: vk <g@vkabc.me>,  git@vger.kernel.org
Subject: Re: [GSoC] Microproject help
In-Reply-To: <CAPig+cRLUra6RObK82nvm1S_goK8q2CXe3A7EeCFA7xqhJCdMg@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 25 Mar 2024 16:51:55 -0400")
References: <51647635a10e31e800f87e8bd4a2e62c@vkabc.me>
	<CAPig+cRLUra6RObK82nvm1S_goK8q2CXe3A7EeCFA7xqhJCdMg@mail.gmail.com>
Date: Mon, 25 Mar 2024 14:23:29 -0700
Message-ID: <xmqq1q7yhupa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 ED8ACF12-EAED-11EE-BB00-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Mar 25, 2024 at 11:40=E2=80=AFAM vk <g@vkabc.me> wrote:
>> For the microproject, I have looked into the lists for 2024 and it see=
ms
>> that all the projects have been taken except for `Replace a
>> run_command*() call by direct calls to C functions`. However, it seems
>> that the issue has been solved. The command I ran to search throughout
>> the repo is `git grep 'run_command*('` and the search result returns
>> run_command functions which I assume are essential.
>>
>> If there is any low hanging fruits that you can suggest to me for the
>> microproject, that will be great. I will also be searching throughout
>> the mailing list to see if there are any potential microproject to wor=
k
>> on.
>
> Searching the mailing list for "#leftoverbits"[1] can be a good way to
> discover little tasks which may be suitable for a GSoC microproject.
>
> [1]: https://lore.kernel.org/git/?q=3D%23leftoverbits

True, but with a caveat that they may range from "low hanging fruit"
to "too hard, let's punt".  After seeing the anonymous questioners'
question, I did go to that query page (actually I qualified the
query further to list only the ones I gave the mark) and decided not
to suggest it because I found that many recent ones are harder than
"trivial changes suitable for a practice material to go through the
review cycles" X-<.

Thanks.

