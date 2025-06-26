Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE86335C7
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 01:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750900561; cv=none; b=OeTGH78x+ICwn1zXQBfxHnG3Sc5yN84RTa3HMFmzxR/EW/DC5JTsla5fV5t/9BvL+HzTEWiZsYokTLQ5iknPbrz5rcyqorCL+uXeiO1uupsEIYoC+2VgeGeGPuVl7cTlGEH4lRgF4ihi35o/xHn0lUU09LWgflRie0Jzzmc/KPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750900561; c=relaxed/simple;
	bh=SJt8a/C9CM45cgUNsu9m3tAsZBFqF1cfiCztvBiEOYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RvBYzwLRPKISc3k61z/TVobeebphwdmeAPWF2Qudb0Wc7KAMMtZ1+PdKLF98S8ptcz+l530HAX+802+0xd3xUTcJm6ICxQykkyyku3vinGAbPvjRJvj4H9zhakxhUhI0Z+vau51A2uUHvqxJXxleLNIi1PQHrmRnfNma4V4mf7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop; spf=pass smtp.mailfrom=guixotic.coop; dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b=eTle3p43; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b="eTle3p43"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <maxim@guixotic.coop>)
	id 1uUbDU-00FlEj-IL; Thu, 26 Jun 2025 03:15:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=guixotic.coop; s=selector1; h=Content-Type:MIME-Version:Message-ID:Date:
	References:In-Reply-To:Subject:Cc:To:From;
	bh=XasjZHM0hnWOxrnp8RCRZs1PcFXJJxAJqIwm1QORsWo=; b=eTle3p43b3rvhgKcOsDTApzdSj
	4aY1coPNY7rO3H0npdYVUPov51tGB2tmz/KVqk6sAYnmr5ywcZH2DI/qSzgO3Pv7LWh43zX1sDr91
	1YJUP27ydk7wvTCdhA3tu5zqyVjvkWZy6gdnU8/e/y/m/q6qCV8jemtJKkNCPCr1qeIPI148oVTF0
	u2leHJVTirkML2XI6CtJvF9RBNvJDHQjjJfGLnc3MeK9lZlJEDKjHwiq9oH9cDNvAEF3BqqYKepOF
	2WGc4i5P/eGcMb+TTdy5IaZQtz0CfCenr4XDxNK4lfag8lidji9/5dscewlM1nzkNBsXcLeT09oBQ
	Wy8DCs3Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <maxim@guixotic.coop>)
	id 1uUbDT-0005iB-VP; Thu, 26 Jun 2025 03:15:52 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1476852)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uUbDP-006scA-Cu; Thu, 26 Jun 2025 03:15:47 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,   Andreas Schwab <schwab@linux-m68k.org>,   "brian
 m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 0/3] git-credential-netrc: better symbolic port names
 support
In-Reply-To: <xmqq1pr7wyuf.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	25 Jun 2025 09:49:28 -0700")
Organization: Guixotic
References: <87ecv8k4y9.fsf@terra.mail-host-address-is-not-set>
	<20250625142511.28857-1-maxim@guixotic.coop>
	<xmqq1pr7wyuf.fsf@gitster.g>
Date: Thu, 26 Jun 2025 10:15:42 +0900
Message-ID: <87sejn2thd.fsf@guixotic.coop>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Junio C Hamano <gitster@pobox.com> writes:

> Maxim Cournoyer <maxim@guixotic.coop> writes:
>
>> This revision fixes a single white space in a new test added in 3/3.
>
> The contents exactly match what I locally have (as I fixed up the
> previous round locally before you sent in this iteration).
>
> [v4 0/3] does not look like a reply to [v3 0/3], though.  It has
> these header lines
>
>     Message-ID: <20250625142511.28857-1-maxim@guixotic.coop>
>     In-Reply-To: <87ecv8k4y9.fsf@terra.mail-host-address-is-not-set>
>     References: <87ecv8k4y9.fsf@terra.mail-host-address-is-not-set>
>
> and refers to the message in the discussion thread of [v3 0/3] in
> which you said "I'll now send a v4 fixing the white space issue,
> making sure to --in-reply-to=$message-id-of-v3-cover-letter."

Hm, correct.  I picked the first message I saw as [PATCH v3 0/3] at
https://lore.kernel.org/git/ but it was a reply, no the original.  Maybe
I'll get it right in a future submission ^^'.

Thanks again for the previous comments/review.

Cheers,

-- 
Maxim
