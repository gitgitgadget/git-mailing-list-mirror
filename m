Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7DC28F1
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 00:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705538421; cv=none; b=JFnjfylmzJuDIX/3ttdf1fk1a1NX01UPVG2za6zkc0agfQNLH916JKEv8enlinqViF+704OPOnQIPzt+CxGpxL8qp0GFfL+B8EqXFG8JJhSBVLuQbmQ1iDYkqEAKefL7eUiewdvIMnt4rjCs9Wf5ter+7dBxnfLfSwYvRomDZWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705538421; c=relaxed/simple;
	bh=pA45M4d+3YP2R8NSl2eJUCS+4AZVOE2cx242lTSu5yw=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=KBGWVMDS2NA2eAXWabN5W/CKOVOCbugAwRTtbHimWo+JPeIR3h7fIaLZfombGX38RXOPq58KGWGDXXDoeYRdIMzOZCO1zMWdHUKP0NEL0MNAfzihYWh9MYxBevo2WHwgZ88q2G0ETP6n5FyBNvqnR/8NaK2SQW1kwqZyZHAUL+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GJEHabtm; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GJEHabtm"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4323C1C443B;
	Wed, 17 Jan 2024 19:40:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pA45M4d+3YP2R8NSl2eJUCS+4AZVOE2cx242lT
	Su5yw=; b=GJEHabtmQqSGac8dBHRUPXzc7VBhiTkb7avQI0fiO7k23w/dHBxJUt
	FXsd0Kxl9vDiz1+edK9cs/ocU1GpMiED82DxEN0zFB575nK87VRmkraYXgaoeWFx
	8FmpUhbxEBlmAYNwOiAOdBDS5+pmcHcxLkk1HhhFuECM3ywC8O6uA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3997E1C4439;
	Wed, 17 Jan 2024 19:40:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 819CC1C4437;
	Wed, 17 Jan 2024 19:40:11 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 01/12] t3210: move to t0602
In-Reply-To: <0e2b6e197ab2fbfc81a42fd601b6aaf41e38929f.1705521155.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Wed, 17 Jan 2024 19:52:24
	+0000")
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
	<0e2b6e197ab2fbfc81a42fd601b6aaf41e38929f.1705521155.git.gitgitgadget@gmail.com>
Date: Wed, 17 Jan 2024 16:40:10 -0800
Message-ID: <xmqqil3rtqxh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 233765F0-B59A-11EE-A185-25B3960A682E-77302942!pb-smtp2.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Move t3210 to t0602, since these tests are reffiles specific in that
> they modify loose refs manually. This is part of the effort to
> categorize these tests together based on the ref backend they test. When
> we upstream the reftable backend, we can add more tests to t06xx. This
> way, all tests that test specific ref backend behavior will be grouped
> together.

So, ... is the idea to have (1) majority of ref tests, against which
all backends ought to behave the same way, will be written in
backend agnostic way (e.g., we have seen some patches to stop
touching the filesystem .git/refs/ hierarchy manually), and (2) some
backend specific tests will be grouped in a small number of test
script files for each backend and they all will use t6xx numbrs?

OK.  Sounds like a good plan to me.




> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  t/{t3210-pack-refs.sh => t0602-reffiles-pack-refs.sh} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename t/{t3210-pack-refs.sh => t0602-reffiles-pack-refs.sh} (100%)
>
> diff --git a/t/t3210-pack-refs.sh b/t/t0602-reffiles-pack-refs.sh
> similarity index 100%
> rename from t/t3210-pack-refs.sh
> rename to t/t0602-reffiles-pack-refs.sh
