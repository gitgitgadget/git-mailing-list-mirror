Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212F556470
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789230; cv=none; b=H97tptvHfRZA8diBgmsXCjLjIACrYZWs2Zz7F1+/MrlQs+ymT6EdnBvlknf4YqxWkO/QK22fjIDfLiWBUt4/2HHThnkPAmzDPwVpweIvEAe7hSV0iKF7pEjv/Mvm8cAO8dXLCwjlIlwLrq9LZuQFyN/YCUOfCU0ToDLc7fdjXzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789230; c=relaxed/simple;
	bh=0OuTkhEfmTiTrE6DaN9lK3KukIKJHLcYt8lGveuyPCg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ONGUfEaLmRx1VMSfW15wygBzPFvj862OVHrXWGpMCijYAhtwEEa6XiCMtmjYXUfpIIuFHnw7gbQ+GsB54MGVt557DB1UgBVf1PakeQE2mSTFTeCg5rjNcU3UDyoFuvQ+INYRL34egWOG+Q0+ACWQrt4fWquIGjjgTGSN/c5TiNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=n8cH9m+v; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n8cH9m+v"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A3E62F654;
	Mon, 18 Mar 2024 15:13:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0OuTkhEfmTiT
	rE6DaN9lK3KukIKJHLcYt8lGveuyPCg=; b=n8cH9m+vNw2ccfxHN/GCtT3qWj3r
	/HsxWR2VWhETldH8MWYZA0u7xgXQVAYNgWFLOfstq+K4jwKg42O/6smTVNfKXCyu
	/vXfJiwOTwP6ZBtFBb45sMuhyrVWrSCLiVTv1iQoD66mlYKWSDuoFaZg7JNtrGBF
	/wWwpdEjmgtLsKI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 835842F653;
	Mon, 18 Mar 2024 15:13:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 28B152F651;
	Mon, 18 Mar 2024 15:13:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: brianmlyles <brianmlyles@gmail.com>,  git@vger.kernel.org,  "Linus
 Arver" <linusa@google.com>
Subject: Re: [PATCH] docs: correct trailer `key_value_separator` description
In-Reply-To: <f6a16989-cbcb-4558-ae3b-350437fda7c2@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 18 Mar 2024 19:15:57 +0100")
References: <17bdc28ea2b88503.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
	<owlyv85k2gts.fsf@fine.c.googlers.com> <xmqqh6h3jzp1.fsf@gitster.g>
	<f6a16989-cbcb-4558-ae3b-350437fda7c2@app.fastmail.com>
Date: Mon, 18 Mar 2024 12:13:43 -0700
Message-ID: <xmqq5xxjgxp4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A407D52A-E55B-11EE-8774-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> My interpretation of this is
>
> 1. Commit messages are flowed/reflowed to 72 columns
> 2. Code is reflowed to 80 columns (enforced by tools like clang-format)
>    =E2=80=A2 See `.clang-format` and `.editorconfig` (kept in synch.)
> 3. Source documentation (AsciiDoc) is reflowed to 72 opportunistically;
>    not every time (in order to avoid diff noise) but when it feels like=
 it
>    makes sense
>
> Maybe SubmittingPatches should mention that last point? If my
> interpretation is correct.

I do not know about #2.  I've seen cases where a patch trying to
stick to the hard 80-column limit is hurting readability a lot.  I
think the moral of the story is that code should never be reflowed
mechanically without thinking---rather developers, when they see the
need to go way too deep in indentation levels, should learn to take
it a sign that they need to first refactor their code, e.g. with
smaller helper functions with meaningful names.


