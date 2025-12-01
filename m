Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF7030BB94
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764595637; cv=pass; b=foJ3k3YzFIzrcXv80vNrB80FiJJ1SP9RQAh+lqkWm8biQbPkOSqS9FolhJgNVIBLpx83lJquuvzwosH0+8DD6j3ua4v1oghylyVLyafNxzt/4jwDKjce9aQJcgBkZfpXOQ9QBbWbmzN6EfEGoY8RYtk/RpGpneiCNIfViB5CJwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764595637; c=relaxed/simple;
	bh=WafYOISnsa6ScA5EFjQuTor+L/yDhw18xVyw9eJOIeM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DJwyaIVj3U16BRFeNUjiMsSEE/Y3YKyIrg9YRpbnTFcuAUkhfGg+DEqKQq/4N4yQVvtdIrzbr6SyMVPFK6KVWwn9L4HpNQtVrjnGKbTdYZRXgJwU8HoCsulKg0FRERJzOJOousUKmtON9DM7Sn4iZ1uVKgme5ffZvhxQGkVjwAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=D3HpoBiq; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="D3HpoBiq"
ARC-Seal: i=1; a=rsa-sha256; t=1764595624; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QexE65YHx/g3vHQA2d9m/gV7moLIT4OA+6Je7OiC/AWQ8WAXFWL9ERjnZzeZhvD6Yg9eI24RTwY0nz7YFsIR6zIhiRhvGh3lrXrlJn1xAfO6WWn0DCKcAEzDt/WXKYdsyk6DS1mT91qiRv7EjyDFfXFngU2kjoMgZoNlbbk/EHw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764595624; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=07zBEQIztuoN7xwSrBoCdtgn8RddAq1MbLMrkMEJyUc=; 
	b=PivLBJGeLhyG2LUB1M80GzqnBdDgV8J6kAc5FE6vVGnatla8kXCK4PKG6oGG9Eg3tAZ8lIySttkbfhHZaMhEaP7pfNY+1n68PaBtxGRtgOaiUUfkkO4DIexf6pmDWy7Z1g4eiWP1mMaoFXpK8ngMPNMOWqoDph7hfmv8iQVczy8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764595624;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=07zBEQIztuoN7xwSrBoCdtgn8RddAq1MbLMrkMEJyUc=;
	b=D3HpoBiqfQeBHcXfZy5W7/d1MLSoyJMbubluIlfUiaFRwsnJbhMD2NLthNou92B0
	GqHfiMbNkh+Bsr8hvcsI15iEplIDQNCPPmPRG8gVkiXb1oovqJxqY2JJLhOC15mHXdU
	/J8u37dQ4HyumdkNRY9FDjSUq4COeC3SRRYxzdOU=
Received: by mx.zohomail.com with SMTPS id 1764595621213425.57471491976776;
	Mon, 1 Dec 2025 05:27:01 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Patrick Steinhardt <ps@pks.im>,
 Josh Steadmon <steadmon@google.com>, Ben Knoble <ben.knoble@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 02/10] hook: provide stdin via callback
In-Reply-To: <xmqqldjofpjh.fsf@gitster.g>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251124172043.1650014-1-adrian.ratiu@collabora.com>
 <20251124172043.1650014-3-adrian.ratiu@collabora.com>
 <87iketf0sn.fsf@gentoo.mail-host-address-is-not-set>
 <xmqqldjofpjh.fsf@gitster.g>
Date: Mon, 01 Dec 2025 15:26:55 +0200
Message-ID: <87zf82mixs.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Sat, 29 Nov 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Not about the contents of your message, but I often see in your 
> replies unintelligible randomly line-wrapped text, and this 
> message was an example of such.  You can see how it appears to 
> others by visiting 
> 
>   https://lore.kernel.org/git/87iketf0sn.fsf@gentoo.mail-host-address-is-not-set/ 
> 
> I _think_ it has to do with your e-mail client, and possibly use 
> of the flowed format in 
> 
>     Content-Type: text/plain; charset=utf-8; format=flowed 
> 
> Please make sure your e-mail client is set up correctly. 
 
Ack, it's either my client or the smtp server. Will fix.

Thanks for raising it up!
