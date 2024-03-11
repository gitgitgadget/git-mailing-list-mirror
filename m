Received: from ra.horus-it.com (ra.horus-it.com [65.108.3.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAD352F82
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.3.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710181038; cv=none; b=DSmGl8MifYYbSFsliWhXAJxkA7uF15HsGahEqGtFVXMAwuBpJxUWN1fneebLpRPtohMvT8Xk2+CEDnLHdnpJRGWJdPyS+YJZiCeFvBfkISWZyzX6SyECY29wsGVUW8ZLSmsG+22pCAd4sssBqb1BMPBMi8KfDmcrcGgbXTYP/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710181038; c=relaxed/simple;
	bh=bvHlHmlPpnyWcReXUqrAtrB7Xp0z+i/jB1y6CX9xNzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEaGzbqV4DnsZUwQL5raWLJs8Yr8o0+1ydIxgbL0ZRGPoiOxKICSfgpSvou6e6dWiHut9cPTZ7RLdBKNTRTIv4aw+msSRAw56HwClsdtIIWny5OoMqLYHgqwUJNsmoq+0TGcqwM1eu0kSwZwfJRZbw6Fr+KMRiX0NqMFW+qHf78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de; spf=pass smtp.mailfrom=seichter.de; dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b=I/xC+eNd; arc=none smtp.client-ip=65.108.3.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seichter.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b="I/xC+eNd"
Received: from localhost (localhost [127.0.0.1])
	by ra.horus-it.com (Postfix) with ESMTP id 297C8BE0037;
	Mon, 11 Mar 2024 19:17:00 +0100 (CET)
X-Virus-Scanned: at horus-it.com
Received: from [IPV6:2003:e2:d73d:4900:956c:99cf:bf79:af42] (p200300e2d73d4900956c99cfbf79af42.dip0.t-ipconnect.de [IPv6:2003:e2:d73d:4900:956c:99cf:bf79:af42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "Ralph Seichter", Issuer "HORUS-IT Ralph Seichter - Primary Client CA" (verified OK))
	by ra.horus-it.com (Postfix) with ESMTPSA id C9F46BE002F;
	Mon, 11 Mar 2024 19:16:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seichter.de; s=k23;
	t=1710181020; bh=IHsXoh68owg/29iq3YPvHh6eYiQafgMOR65P9gnbpg4=;
	h=Message-ID:Date:User-Agent:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type;
	b=I/xC+eNdfER7Y6d+MuB3GE8Ex21eoZUESBbH2mjK4cEYimTgDMipW1YXEUYVA3Vhq
	 r4M60ZMdxEMYnrZNmd2YTehVJph4rWFZg7/X5ScMrYaIJYc0Bvjj2qODCxJMJ5H7ac
	 V+hja7qDxRjS19u6elKOmfHVmBhvr/XsiLnm/3LqbrySUYcfrW3wGgwHt+Lt0fyX2K
	 OE8F+OB0hSsW8FwlMkRpberuu1jJLt8c5OU+7O5nDUMwsyXceJ9fymEWFT3BHZBBZV
	 VPlVZ+z/A243Kd6CuGlaVQb7WN2ObxU89RE6GDeRtVevjOPwEIqMjYtmsDkD0HBGp5
	 ChH6OAi9pglZA==
Message-ID: <9166fa83-4ed5-41fd-83f7-337fd524d0e2@seichter.de>
Date: Mon, 11 Mar 2024 19:16:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] config: add --comment option to add a comment
To: Junio C Hamano <gitster@pobox.com>,
 Ralph Seichter via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, rsbecker@nexbridge.com
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
 <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
 <xmqqy1apudvv.fsf@gitster.g>
Content-Language: en-GB
From: Ralph Seichter <github@seichter.de>
In-Reply-To: <xmqqy1apudvv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Preface: I am not replying to every part of Junio's email this time
around. However, that does not imply I am ignoring them, I simply do
not currently have access to the source code.


* Junio C Hamano:

 > For readability, you probably would want to have a SP before the
 > given string, i.e.,
 >
 > 	variable = "value" # message comes here

If the user wants a whitespace after the #, they can add it in the
comment using quoting, e.g. --comment " message comes here". I don't
think it is necessary to enforce the extra SP, because it is not
syntactically required. Besides, readability is quite subjective.

 >> The implementation ensures that a # character is always
 >> prepended to the provided comment string, and that the
 >
 > It is unclear what happens when a user gives comment that already
 > has the comment introducer, e.g., --comment="# this is comment".

Unclear? ;-) I wrote "a # character is always prepended to the
provided comment string", and that is what happens. The current
implementation is meant to be safe, not fancy.

 > No need to repeat a wall of text below the three-dash line if they
 > do not give additional information on top of what is already in the
 > proposed commit log message.

That's GitGitGadget's doing. Unfortunately, it does not want to let me
remove my pull request description on the GitHub website. I already
tried to fiddle with it, but no success yet; GitHub keeps restoring my
latest description text.

 > This topic may want to at least wait for the conclusion of that
 > design discussion, and possibly its implementation.

I don't know enough about the timespans involved to be sure, but that
sounds like it could take a long time?

 > I notice that we are sending "comment" to the underlying machinery
 > without doing ANY sanity checking (like, "ah, we got a message
 > without the '#' prefix, so we should add '# ' in front of it before
 > asking the API to add that comment string to the value line").

As I wrote before, the # is prepended unconditionally. LF is a more
interesting question. I haven't yet tried actively introducing a
linefeed. Does strbuf_addf() have any related filtering logic?

-Ralph
