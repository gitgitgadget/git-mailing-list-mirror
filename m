Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0766C54BD5
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lQLmIVyR"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ACE861D6740;
	Mon,  8 Jan 2024 13:20:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rT58UJSvVCtqVlEz1aMwNSvzdzx9cNH46c9GJL
	T76wc=; b=lQLmIVyRSSUuD9fBz9aKwgr/YTJeYiWiAa8XgyFmifeapgliHtKJ3H
	buMQJEn8OuRsvYNmsFttytevD9haa2pEPyHciTRGJ0422jMs5pSuRB/TtNIwTWxf
	ObtsQcdDt68uRJtPHZ1YUJMR08VjLpNUGkh8hEM1J/iKz6yCFpAG8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 946E11D673E;
	Mon,  8 Jan 2024 13:20:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3D6BB1D673A;
	Mon,  8 Jan 2024 13:20:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Stefan Haller <lists@haller-berlin.de>
Cc: git@vger.kernel.org
Subject: Re: Storing private config files in .git directory?
In-Reply-To: <8e344dee-f84e-4a2c-835a-406ee72d129b@haller-berlin.de> (Stefan
	Haller's message of "Sun, 7 Jan 2024 14:03:20 +0100")
References: <8e344dee-f84e-4a2c-835a-406ee72d129b@haller-berlin.de>
Date: Mon, 08 Jan 2024 10:20:00 -0800
Message-ID: <xmqq34v7lmb3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8A1C6D00-AE52-11EE-9283-25B3960A682E-77302942!pb-smtp2.pobox.com

Stefan Haller <lists@haller-berlin.de> writes:

> Our git client (lazygit) has a need to store per-repo config files that
> override the global one, much like git itself. The easiest way to do
> that is to store those in a .git/lazygit.cfg file, and I'm wondering if
> there's any reason why this is a bad idea?

An obvious alternative is to have .lazygit directory next to .git directory
which would give you a bigger separation, which can cut both ways.

