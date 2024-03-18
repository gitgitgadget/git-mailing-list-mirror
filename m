Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ADF55780
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779693; cv=none; b=YoAMZnQgHbKvM5+ei4o1OFtXziKTOptzjYwhYl2Y3RalalE15DniL+YwcKo9ftxoE0v27FHh8Hj1lwiNdgv2hFzVTq//j+qEzRmNe68ajL4Od6kzKfa3N+LDieI7nK7igpi3FfsTqxL0gfVe1a9mF4yilCHIVwmItfv1f7BRXNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779693; c=relaxed/simple;
	bh=Rhb8qX2VNOpJX419vmhw7vY/Us5TIPKKqUsIuts3cBE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IPPWV36aYkvtSL9LMxDHwJ+8TAmkeBS24XRdVWhGb5VzwoO+aow87Lg+5PPcpURbSXIL+OqyceLC0VQX2g2mUAIyk1CJOM2XPs+MqqXRRQbhFuJoA8UY7m+og2eljjHKxFkzIkjuKJgK3to6+YEnDzqQ8YxKh2LQNk72URhe6OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lWxwfiwl; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lWxwfiwl"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E05F1FE7BB;
	Mon, 18 Mar 2024 12:34:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Rhb8qX2VNOpJX419vmhw7vY/Us5TIPKKqUsIut
	s3cBE=; b=lWxwfiwloE/aUOJDb0rC03m6c2RmLfcuzj1uVftqCKAAryXZoV8SZ/
	mNrB5NEO9FIagkPlY1IjKA0KE3ymE1Muwiv/EFGdKj9whL6gH7eOVEQg5HGyCxZt
	B3VCriKH434fhU7qWhK2L6547xXowOqaPx0vd09izB9spkLKre5zw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 261061FE7BA;
	Mon, 18 Mar 2024 12:34:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8F4AF1FE7B9;
	Mon, 18 Mar 2024 12:34:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Brian Lyles <brianmlyles@gmail.com>
Cc: git@vger.kernel.org,  linusa@google.com
Subject: Re: [PATCH v2 1/2] docs: correct trailer `key_value_separator`
 description
In-Reply-To: <20240318053848.185201-1-brianmlyles@gmail.com> (Brian Lyles's
	message of "Mon, 18 Mar 2024 00:38:01 -0500")
References: <20240316035612.752910-1-brianmlyles@gmail.com>
	<20240318053848.185201-1-brianmlyles@gmail.com>
Date: Mon, 18 Mar 2024 09:34:43 -0700
Message-ID: <xmqq1q87jy70.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6D66BBF0-E545-11EE-9B34-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Brian Lyles <brianmlyles@gmail.com> writes:

> The description for `key_value_separator` incorrectly states that this
> separator is inserted between trailer lines, which appears likely to
> have been incorrectly copied from `separator` when this option was
> added.
>
> Update the description to correctly indicate that it is a separator that
> appears between the key and the value of each trailer.
>
> Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
> ---
> Changes since v1:
> - Minor wording tweak
> - Minor wrapping tweak
>
>  Documentation/pretty-formats.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index d38b4ab566..e1788cb07a 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -330,8 +330,8 @@ multiple times, the last occurrence wins.
>  ** 'keyonly[=<bool>]': only show the key part of the trailer.
>  ** 'valueonly[=<bool>]': only show the value part of the trailer.
>  ** 'key_value_separator=<sep>': specify a separator inserted between
> -   trailer lines. When this option is not given each trailer key-value
> -   pair is separated by ": ". Otherwise it shares the same semantics
> +   the key and value of each trailer. When this option is not given each trailer
> +   key-value pair is separated by ": ". Otherwise it shares the same semantics
>     as 'separator=<sep>' above.

I was tempted to insert a comma before "each trailer key-value pair"
while queuing this, but the missing comma is shared with other
entries of the same list, so I'd queue it as-is.

Thanks.

