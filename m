Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E8C7FBB5
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410893; cv=none; b=mLOb2tdtV/H2w5tTXAAkq82wNUHiLNPUo9rX+47CyBFZkCvlX4hz2qYWjbQX2hGNsdYxroyzq9r0e34xAFrgkeLDn0QZ0j4wPaF8z7xGgTn92Vjh1NmHdVfmXuTL6pbJT9E3gEC6PCc3f/Co52mWQRo3ERvHqO51AtsV9HPnj3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410893; c=relaxed/simple;
	bh=3HxwMdq5+3W/aGyD28LqQmlPSR9I/iWHNJ4m7RZH8PM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZSk8XBP3s18B0Na8NANNI6jbVPnr3eW3t33OT/j+6fe+uJyv45gmJwWOouj237L1v2Lun2EpzCgNsP0/D/S9I8sS5OrQXCVkbdZ5NH4TxbEhQtPjCZBw5dq3nL4OYCVb9OfmvDyeKoZ00lyG5+lnzTBzypz7oVcgY27L2/SmvO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=T06x6Rwe; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="T06x6Rwe"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C1EE1E73D5;
	Thu,  8 Feb 2024 11:48:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3HxwMdq5+3W/aGyD28LqQmlPSR9I/iWHNJ4m7R
	ZH8PM=; b=T06x6RweJd7Hs7m2TbEZUtODNiteRyHtl2MqcgZ4+g5IbvRbGsy9Uv
	4al089EL+gm0Z3LcW0JhtwdUy0ds7LDuhTdBnqFQJt2FL1j3oVWinAdgHEJbCwg9
	6NcEyz5rAF1f1BKt7WB6CZH2JRhNe4YGuUTC2haCf7BPfCBncT73I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 527F91E73D4;
	Thu,  8 Feb 2024 11:48:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BBA2A1E73D3;
	Thu,  8 Feb 2024 11:48:09 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Matthieu Moy" <git@matthieu-moy.fr>,  git@vger.kernel.org
Subject: Re: [PATCH 1/2] bisect: document "terms" subcommand more fully
In-Reply-To: <a8e67945-153b-43bb-b1b0-ea24fa786097@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 08 Feb 2024 07:36:55 +0100")
References: <24a42fa6-7bc4-4a3b-8bf4-a0ef85dc457a@matthieu-moy.fr>
	<20240207214436.538586-1-gitster@pobox.com>
	<20240207214436.538586-2-gitster@pobox.com>
	<a8e67945-153b-43bb-b1b0-ea24fa786097@app.fastmail.com>
Date: Thu, 08 Feb 2024 08:48:08 -0800
Message-ID: <xmqqil2yq4vr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D7373068-C6A1-11EE-B966-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Wed, Feb 7, 2024, at 22:44, Junio C Hamano wrote:
>> The documentation for "git bisect terms", although it did not hide
>> any information, was a bit incomplete and forced readers to fill in
>> the blanks to get the complete picture.
>>
>> Acked-by: Matthieu Moy <git@matthieu-moy.fr>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>
> Past tense? How about:
>
>     The documentation for "git bisect terms"---although it does not hide
>     any information---is a bit incomplete and forces readers to fill in
>     the blanks to get the complete picture.

Right.
Thanks.
