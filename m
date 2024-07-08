Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E22B14532B
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457681; cv=none; b=FjBUITVyyayQpo1NJtxoCBgZ7zWskWGe2Vsg7WgFABvsgereFqPV2JGTfGTXfMsb594GxdZfMAJfdpcVgU11b2BLDgkFNofMIaBarrwJUfvieQGSyr4vc13VcfOICTqjbLcxbUr4ab/XibXqmxjFHLcsJ0c6wCoE1Zx8yDNSQzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457681; c=relaxed/simple;
	bh=T3f/F1TqQBFxsMa47gSO7C148gczKEI/6YNRvhoVGiY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d5tvRSZDvELMBFDUE+LwluaF3udG0PuK8VENvHPkMS0Yi68RrSh356Cnlj2zmsnaLyNRArixlySfUt75pm5q7ApcwRE4tZ63U+1u1x1a/oT60327iP1FtXJOhHYOR+fB6HAZWDsZ8BMExNLMckrTKP4oL5DQ0VZ37HyIEXRbZXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sT4a3Bug; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sT4a3Bug"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EB791AEDD;
	Mon,  8 Jul 2024 12:54:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=T3f/F1TqQBFxsMa47gSO7C148gczKEI/6YNRvh
	oVGiY=; b=sT4a3BugpfILBjjmqL8bGyKlQalIAN4ZUSkNQvqQX3Az5gmQnSu1by
	WsEx4m5wOif+srkfmPb1Rti+AnR9zJXQVaYIQxhtse6OZGaAb7aS7lfo1B8BIWeq
	KDCDQ4fCib3Ov7Ph6TVrCX3Qe6XzWgW9KcgHgG5Tv1e14khETrClE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 987961AEDC;
	Mon,  8 Jul 2024 12:54:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 262171AEDA;
	Mon,  8 Jul 2024 12:54:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  chriscool@tuxfamily.org
Subject: Re: [PATCH 6/8] clang-format: formalize some of the spacing rules
In-Reply-To: <20240708092317.267915-7-karthik.188@gmail.com> (Karthik Nayak's
	message of "Mon, 8 Jul 2024 11:23:14 +0200")
References: <20240708092317.267915-1-karthik.188@gmail.com>
	<20240708092317.267915-7-karthik.188@gmail.com>
Date: Mon, 08 Jul 2024 09:54:34 -0700
Message-ID: <xmqq8qybj039.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C1E5F3B4-3D4A-11EF-9D6F-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> There are some spacing rules that we follow in the project and it makes
> sen to formalize them:
> * Ensure there is no space inserted after the logical not '!' operator.

Shouldn't the rule be more like "no space between any single operand
prefix or postfix operator and its operand"?  "foo++", "--foo", "~0"
are the examples that come to my mind.

> * Ensure there is no space before the case statement's color.

"color" -> "colon".

> * Ensure there is no space before the first bracket '[' of an array.
> * Ensure there is no space in empty blocks.

Hmph, I actually thought we preferred to be more explicit, using

	if (foo)
		; /* nothing */

instead of any of

	if (foo) {}
	if (foo) { }
	if (foo) { ; }
	if (foo) { ; /* nothing */ }

to write an empty statement.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  .clang-format | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/.clang-format b/.clang-format
> index 1a5f0c9046..05036f610b 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -126,11 +126,18 @@ RemoveBracesLLVM: true
>  # x = (int32)y;    not    x = (int32) y;
>  SpaceAfterCStyleCast: false
>  
> +# No space is inserted after the logical not operator
> +SpaceAfterLogicalNot: false
> +
>  # Insert spaces before and after assignment operators
>  # int a = 5;    not    int a=5;
>  # a += 42;             a+=42;
>  SpaceBeforeAssignmentOperators: true
>  
> +# Spaces will be removed before case colon.
> +# case 1: break;    not     case 1 : break;
> +SpaceBeforeCaseColon: false
> +
>  # Put a space before opening parentheses only after control statement keywords.
>  # void f() {
>  #   if (true) {
> @@ -139,6 +146,13 @@ SpaceBeforeAssignmentOperators: true
>  # }
>  SpaceBeforeParens: ControlStatements
>  
> +# No space before first '[' in arrays
> +# int a[5][5];     not      int a [5][5];
> +SpaceBeforeSquareBrackets: false
> +
> +# No space will be inserted into {}
> +# while (true) {}    not    while (true) { }
> +SpaceInEmptyBlock: false
>  
>  # The number of spaces before trailing line comments (// - comments).
>  # This does not affect trailing block comments (/* - comments).
