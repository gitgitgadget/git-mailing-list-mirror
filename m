Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFD82570
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 00:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722905119; cv=none; b=eBozXmhGIHvFJzkNKOh0Hv0h3jR3Ntd4j1gog2EPXmS+QRoQuX1/iHk2b3q3j6+UhKoZF3cs+1r2fDvvrWDsiSvbfLtj2fDViCuYE+fh4mWtVSowOkA+GtVGJ/MhOhJmwhBObsb//x2kSbbfft2KkGkDH96Zd1LXzLOQgB03B5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722905119; c=relaxed/simple;
	bh=K6CJf999qtLkZQpmCFACA7FF501C5HxdOLE8Z4e6ByA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hu4SpZxpjRTmhVPyJ+yK/oo7j9h+tbEi1hxnjDxttZKxcKU3ioJBqVM3vfI/teZmZ23HnqUvidUUhZws9Y43qR/m8SNnQ8F8yXg8BLSheZJEJAQBVZCV1QegYZHb9kUhr9oo0KHWC1T/RVujt8asVpcfRt2JuGo0HbGExeKj6dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rZ6bHx+5; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rZ6bHx+5"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EECEE283EC;
	Mon,  5 Aug 2024 20:45:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=K6CJf999qtLkZQpmCFACA7FF501C5HxdOLE8Z4
	e6ByA=; b=rZ6bHx+5bivMFACLYjTIJUEUBk4b3mpbSUeYzbDTgrBeWNNt56rcAV
	EnHo83LXG9BnhsWQaa/00rmlaw+KNZI1OF0dtwCQYzsP5DBv1v8dslGYORNaM6FB
	boRJ4eQYAuhFxgx6yE1zULMA8Fvmc696jXDyScj1L3dpV2UwSyDYY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E7223283EB;
	Mon,  5 Aug 2024 20:45:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 56D1F283E9;
	Mon,  5 Aug 2024 20:45:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: AbdAlRahman Gad <abdobngad@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 0/8] t7004: Modernize the style
In-Reply-To: <20240805235917.190699-1-abdobngad@gmail.com> (AbdAlRahman Gad's
	message of "Tue, 6 Aug 2024 02:59:09 +0300")
References: <20240805235917.190699-1-abdobngad@gmail.com>
Date: Mon, 05 Aug 2024 17:45:15 -0700
Message-ID: <xmqqzfpqzdgk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 25EF6018-538D-11EF-9960-9B0F950A682E-77302942!pb-smtp2.pobox.com

AbdAlRahman Gad <abdobngad@gmail.com> writes:

> AbdAlRahman Gad (8):
>   [Newcomer] t7004: Remove space after redirect operators
>   [Newcomer] t7004: Do not lose exit status to pipe
>   [Newcomer] t7004: One command per line
>   [Newcomer] t7004: Do not prepare things outside test_expect_success
>   [Newcomer] t7004: Use indented here-doc
>   [Newcomer] t7004: Description on the same line as test_expect_success
>   [Newcomer] t7004: Description and test body seperated with backslash
>   [Newcomer] t7004: Use single quotes instead of double quotes

As you can see from "git shortlog --no-merges --since=6.months", we
do not capitalize the first word of the title description of each
patch.

Also, I haven't looked at the individual patches, it seems the patch
is somewhoat whitespace damaged.

    $ git am -s ./+ag8-v4
    Applying: t7004: remove space after redirect operators
    .git/rebase-apply/patch:169: indent with spaces.
            git checkout stable &&
    .git/rebase-apply/patch:193: indent with spaces.
            git tag v4.0
    warning: 2 lines add whitespace errors.
    Applying: t7004: do not lose exit status to pipe
    Applying: t7004: one command per line
    Applying: t7004: do not prepare things outside test_expect_success
    .git/rebase-apply/patch:1188: indent with spaces.
            git tag v4.0
    warning: 1 line adds whitespace errors.
    Applying: t7004: use indented here-doc
    Applying: t7004: description on the same line as test_expect_success
    Applying: t7004: test description and test body seperated with backslash
    Applying: t7004: use single quotes instead of double quotes
    .git/rebase-apply/patch:133: indent with spaces.
            git tag v4.0
    warning: 1 line adds whitespace errors.

