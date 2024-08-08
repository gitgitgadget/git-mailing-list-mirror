Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B78190489
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131767; cv=none; b=JtbWGrOmUH0oxJDUBVPrhS0QbqH4wBcDywzD3RKXmBzLm01KgjMZNsqCmame5k+23bQnrioAeY0XfjkuX2zmm4cWBfLzUdIjUXJzWN6kziuYMprNFbJ3bHNM+8G5wJ3FqYl5KAW9lcMzIE4pfRrvtxSzQ0j/EgI6X/eSIIcaai4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131767; c=relaxed/simple;
	bh=AkedmyQn0H+Mm7REY6SByFQL2WAWTuM7PXFChauMbOY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f/tI9SDHxqNiefCEgEXZUtzztxYOCU/hyB5xxMzfuL/aQWKOqinwARz+qUMGzziFmHXKBN4wjtNd4Qgbx+UB2F/s6EatSojRsJGdNMUA02qFnoAFD2JMxpOIfBO0PUy26QWcuFrWmUDThouSvkRywDHBTlD+QevdQ+lzKXLwdyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=isLKlwOR; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="isLKlwOR"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C5F92239A;
	Thu,  8 Aug 2024 11:42:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AkedmyQn0H+Mm7REY6SByFQL2WAWTuM7PXFCha
	uMbOY=; b=isLKlwORdmt3Km98Z5Onja4UHXX0GinSJoVNifaUV+o9uG9UQkhMBF
	Zaxsv1fHvG8F+7UqZrXu7jCDGvAOwtFzZYeE8U8WeiPrfHaIHVbZETn9iIYTvT8g
	3en51Rq7MyuohWnQpCmAcxJSaRZx1jkz7uTl8rfvWFzWz+7bgRYpc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9545A22399;
	Thu,  8 Aug 2024 11:42:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0EA2122398;
	Thu,  8 Aug 2024 11:42:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: AbdAlRahman Gad <abdobngad@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 0/8] [Newcomer] t7004: modernize the style
In-Reply-To: <20240807130259.28381-1-abdobngad@gmail.com> (AbdAlRahman Gad's
	message of "Wed, 7 Aug 2024 15:58:36 +0300")
References: <20240807130259.28381-1-abdobngad@gmail.com>
Date: Thu, 08 Aug 2024 08:42:43 -0700
Message-ID: <xmqq5xsbkolo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DA7E62B6-559C-11EF-8C7C-9B0F950A682E-77302942!pb-smtp2.pobox.com

AbdAlRahman Gad <abdobngad@gmail.com> writes:

> - Remove whitespace after the redirect operators.
>
> - Move number of expect files prepared outside of
>   test_expect_success to be inside the tests that use it.
>
> - Split some lines that have two commands into two lines
>   one command each.
>
> - Turn some "<<\EOF" into "<<-\EOF" and indent their body.
>
> - Avoid using pipes in the output from "test-tool ref-store"
>   and write the output to a file.
>
> - Change test_expect_success that are seperated from its name
>   to be on the same line.
>
> - Avoid separating test Description and test body with backslash
>
> - Use single quotes instead of double quotes for test description and
>   body.
>
> - Use write_script which takes care of emitting the `#!/bin/sh` line
>   and the `chmod +x`.

I gave another look and they all looked fine.  Except the title of
one step that said

    t7004: test Description and test body seperated with backslash

was a "Huh?  what does it even mean?".

    t7004: begin the test body on the same line as test_expect_success

or something?  I dunno.

> There are still tests that could lose exit status to pipe. This needs
> to be modernized too, I will fix them in another patch series.

;-)

Another one that I noticed is that we have quite a lot of

	cat >expect <<-EOF &&
	v1.1.3
	v2.0
	v3.0
	EOF

that can be shortend to

	test_write_lines >expect v1.1.3 v2.0 v3.0 &&

To use without extra quoting, test_write_lines is more limited, but
the majority of here-doc used for expect files in this test are
enumeration of tag names that we can write without any extra frills,
and test_write_lines may be a very good fit for these use cases.

Thanks.


