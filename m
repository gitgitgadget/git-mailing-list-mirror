Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6B836124
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 07:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127655; cv=none; b=OYcmwTe7BpBC628NbAEwPis939s9ZUObr2aUJqYYGESrvddE9I9KIgaDygvYxmBbdPhO24Hk/ZMJTuN8yUOaVGyBIbXOuPcafrI6hEogH/80j7xry2aBuLpUc9aa9fugUCrBPVbE6NZ74OziAqWuR50AqZgYkD9xkctoS1jrPO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127655; c=relaxed/simple;
	bh=/jO7SuITJ3PIa8mmPaelTVSYDmHYWrPZ6O4tDcjiznE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=duRFf3TjacxhJzkJ6pAwe+Y1u0hiIMcwgzCkN62YytYf/zyBc5hZUdgsM5fUfqNdf/q4u5Ovuq221EdPBGb+fi0uzAhsSoxwD3iGx+39X5lgQH1eK9t4LSFe3kIC1kqetpA7hfXENsaPgVXVsmf+AIVYBbQUDEJdKmnizZv142E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=jWkrh1Z4; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="jWkrh1Z4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1726127646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/jO7SuITJ3PIa8mmPaelTVSYDmHYWrPZ6O4tDcjiznE=;
	b=jWkrh1Z4syw0kxOVqQVDu/vhP9MNxOUhBK8CSUAdGxy9m+6VVQSctn8UFjXdHZWziRT1Qh
	eiFtwXML4IwrDPDUVeM4jBLGMcURo8e3gXvDRXODz+PqIGEO4lw1OU5Pn86ZdjNYGO5W8m
	Vdt077BVeb5H20B+NqZrPFQEFL4+z+8=
From: Toon Claes <toon@iotcl.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
Cc: Matt Burke <spraints@gmail.com>, Victoria Dye <vdye@github.com>,
 Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>, Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>, Todd Zullinger <tmz@pobox.com>, Johannes
 Sixt <j6t@kdbg.org>
Subject: Re: Migration of git-scm.com to a static web site: ready for
 review/testing
In-Reply-To: <155bc141-a16a-9fd2-920b-7a8c398d5e36@gmx.de>
References: <6f7d20b4-a725-0ef9-f6d3-ff2810da9e7a@gmx.de>
 <155bc141-a16a-9fd2-920b-7a8c398d5e36@gmx.de>
Date: Thu, 12 Sep 2024 09:53:56 +0200
Message-ID: <87h6al9ujv.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Me again,
>
> It's time for the next update, after working with Pagefind, lychee and
> Playwright project members to improve on this effort. Here is a focused
> list of changes since November 17th 2023 (when I sent the first RFC), in
> descending, quite subjective order of importance
>
> [snip]

Hi Johannes,

I just discovered this effort. I didn't realize this was happening, but
I'm super excited to see this going (and being picked up again).

I've been doing some testing locally, and I've been posting some
comments on the GitHub PR, with small patches.

The biggest thing I've noticed is there is still some work to be done on
the search results page, for example:
https://git.github.io/git-scm.com/search/results?search=bundle&language=en

I assume we'd need to inject some of our CSS into the pagefind results.
I'm happy to contribute to this if you like? It would give me the
opportunity to play with some CSS again.

--
Toon
