Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FD676DA0
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 21:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MzQVuJm7"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8926C1C8FBA;
	Thu, 21 Dec 2023 16:27:55 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GIXe/pApFQkoUUToNG8rGny3wK2SIjPQ2l1hmy
	3T4Ek=; b=MzQVuJm7NyndcY8O5bzo8RikkMa/m8+043kPApbIiusJfVzsWXzWD8
	2qKAxDZVr/1QFRmwDEOXErzXjIyw0btVNXpGlVl513qKOET6S7cEXwLQaBEDd/MQ
	xzl24QqJ8i1i3I6OFuvxbG7XksOxEN6iKh4o5Etu1gxikDXmPkS+Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 80C8A1C8FB9;
	Thu, 21 Dec 2023 16:27:55 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE71F1C8FB8;
	Thu, 21 Dec 2023 16:27:54 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>,  Phillip Wood <phillip.wood123@gmail.com>,  Josh Soref
 <jsoref@gmail.com>
Subject: Re: [PATCH v2 7/9] SubmittingPatches: clarify GitHub visual
In-Reply-To: <cdb5fd0957fee7ce8c19720f588da96898cd3dc9.1703176866.git.gitgitgadget@gmail.com>
	(Josh Soref via GitGitGadget's message of "Thu, 21 Dec 2023 16:41:03
	+0000")
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
	<pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
	<cdb5fd0957fee7ce8c19720f588da96898cd3dc9.1703176866.git.gitgitgadget@gmail.com>
Date: Thu, 21 Dec 2023 13:27:53 -0800
Message-ID: <xmqqv88rjleu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CDB392AA-A047-11EE-8662-25B3960A682E-77302942!pb-smtp2.pobox.com

"Josh Soref via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Josh Soref <jsoref@gmail.com>
>
> GitHub has two general forms for its states, sometimes they're a simple
> colored object (e.g. green check or red x), and sometimes there's also a
> colored container (e.g. green box or red circle) with containing that
> object (e.g. check or x).
>
> That's a lot of words to try to describe things, but in general, the key
> for a failure is that it's recognized as an `x` and that it's associated
> with the color red -- the color of course is problematic for people who
> are red-green color-blind, but that's why they are paired with distinct
> shapes.
>
> Using the term `cross` doesn't really help.

I am not sure if this is accurate.  Using `x` alone does not help,
either.

I think this was raised during the review of the initial round, but
...

>  If a branch did not pass all test cases then it is marked with a red
> -cross. In that case you can click on the failing job and navigate to
> ++x+. In that case you can click on the failing job and navigate to

... it would help if we added something like ", instead of a green
checkmark" after "with a red x".  It will make the contrast with the
succeeding case stronger.  IOW, we can take advantage of the idea to
use "pair with distinct shapes and colors" ourselves.

>  "ci/run-build-and-tests.sh" and/or "ci/print-test-failures.sh". You
>  can also download "Artifacts" which are tarred (or zipped) archives
>  with test data relevant for debugging.
