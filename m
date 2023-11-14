Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B890D567D
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 01:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S6qwqspo"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D7E115
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 17:36:38 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2DCDC29724;
	Mon, 13 Nov 2023 20:36:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QrBUVmJYqD/TqfgUubWwAYV8PnkuSeDB35xcSN
	fEtY4=; b=S6qwqspo4q92zg/nqqzi0VpatLE4kd2aepN7os0HkRcKU3GvaGkBR6
	ezjTviMxMwx7+3HFRo9qWiMIfO8krN86zAHrFdc0PZclrNVyypEFLfigI7J33RNX
	XPnZibI22xoG7JcdBs+g9gb68wiHqSxvW8AD1+W/xQ7MKEB9uABBs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2638729723;
	Mon, 13 Nov 2023 20:36:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BFFD22971A;
	Mon, 13 Nov 2023 20:36:34 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: =?utf-8?B?SmnFmcOtIEhydcWha2E=?= <jirka@fud.cz>,  git@vger.kernel.org,
  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH] remote-curl: avoid hang if curl asks for more data
 after eof
In-Reply-To: <20231113212243.1495815-1-jonathantanmy@google.com> (Jonathan
	Tan's message of "Mon, 13 Nov 2023 13:22:42 -0800")
References: <20231113212243.1495815-1-jonathantanmy@google.com>
Date: Tue, 14 Nov 2023 10:36:33 +0900
Message-ID: <xmqqv8a515ge.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3EF1243C-828E-11EE-BA57-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jonathan Tan <jonathantanmy@google.com> writes:

> Due to the nature of the bug and the fix, I do agree that it's hard to
> test and I would be OK with including the fix without associated tests.

Is this a bug on our side, or cURL library calling us when it should not?
Even if the latter, we should be prepared and the two liner fix you
suggested would be worth doing, but at the same time we should let
the cURL maintainer know if the latter is the case, and that is why
I am asking.

Thanks, both.  Especially thanks, Jonathan, for excellent review
comments.


