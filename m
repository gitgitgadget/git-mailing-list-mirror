Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE6221FC4
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006317; cv=none; b=un+iIZolxo4th3uQYjAoJLEp+01qogGG4Cv08b1cGZXDMq8/Q9N8UXH3XbbOXWmKQk4qFiN64M4uh7V7+hpgtcnGiKdDCesLi6mKKy1j2WMtIzhhVRds0u+WlbAlWyXxVkZTRPihhPmyoaixZimwT5Fm79eFQT1bvkXvPcVF+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006317; c=relaxed/simple;
	bh=If75cIM6to0Cp61QoGtTNFfoTrDmladhwTYKU1gTWwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MHsr32D+ZzhKyYGwb3e2APSgxEBCfZps28aDFjyk2Tg/b05lJNhB8ay5ITatUMZKZEtGGBdnoD9/rZhSxShlLZOtRJ8Un94ef9vtAJcNII0+dWGAv5WPZi110z/uNfjp5p0PfCzKlHVoBZ1COwS1qiZGbq5K+FKfaVR8R8glWHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JuhWfUP/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eTQrrEHu; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JuhWfUP/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eTQrrEHu"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C483E14002D2;
	Tue,  8 Jul 2025 16:25:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 08 Jul 2025 16:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752006313; x=1752092713; bh=VbUJa3jZ5v
	LqpH3TO8/g2+7XPa/YB/S5En0xG54Po6k=; b=JuhWfUP/dbYTYAgRMly+x0sFNE
	RZW7owV76ypqDNkEga1YpHzNnzt4sHul3NREQS6QZQO2Oar0aqz6/A4yY3xqsA7W
	uYw57QVm7QSXIy+CTg69Lps9BVKX2DywEI6iw5N+Us+9vxMUqhknamO45ldumHag
	1DuS+Fzxiq+/j7eqH2Ac0FnUFT8yUHSpzV5gKyQBIdWrPjoC8q0aKFG1a7AokguZ
	HHNuzatlHKWXXsOoFGb1n+2h2tjyBXsHNdCFsuHc5Nlea6+d21JsqBWtFV9FAhWK
	rKx8gvgd3nL6b8tcQ3RgR1+LGN1x/SXCLWBQWeJvACc1O3R86GNpcPKFmyIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752006313; x=1752092713; bh=VbUJa3jZ5vLqpH3TO8/g2+7XPa/YB/S5En0
	xG54Po6k=; b=eTQrrEHuVweSGJS3XEwF/29AIlT4N3q88gDl7d8hFqegkI0yEc8
	wkIomWlVIwAktp3ze0kRT46tYgIr3occ47rZXYJl/c8En0VjuMrSagrDDg5Ttnki
	QhSI5LpuQLILBSinogo4htCRAhnkXKJtxHsPrcslxWWClx2GaFX2h51h524iqcp2
	wWd/Q3jECt5kToHWK0q2fjZGqryYxhSfZLuLzgl6fpDWGnF8XpAG0jR8xLAVUp/s
	2OGpvCPxA1OYIfqTMqziNQ5Lp5Vg9HTrrs0pWlDfCkYHjfQzhDYHwtK9XoHZtzkN
	K4Q5qGqCSQ0+6acHqTstX62yMDkRnlgDLdA==
X-ME-Sender: <xms:qX5taIcJEo9ZNP1OoGRqO_q_BIC-NL3fJ8G90eFvSE2Rswl07xiLCg>
    <xme:qX5taCqzdEK7UAzISbcxw6QqDzZmh4xeBfBfjIxXqold66LHIeruDkBXS5d-J0vJ7
    FhX7D08y-DWzhDfXA>
X-ME-Received: <xmr:qX5taJ90TZ-PCzUfiJfDlxoYWQ4gRCiSSf-DdGpeh6-K28zJO8Memi7s1Vxleecr9z3R5YFvGK0RxShr8PoDn5vDp_X6dK492ORrSvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefheeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepshgthhifrggssehlihhnuhigqdhmieekkhdroh
    hrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qX5taOdQyzVnWJx5QgasQt32vngEeWJPGH3-xV2DO_v-ZIw605Lm3g>
    <xmx:qX5taDIbZQhxa5bLNpeI719MvhVFmRbMiVf1qTh0Tjf53KyfLz40Pg>
    <xmx:qX5taOj2m-XZWETLTHVTvf5JJ2MsmxqGd6pl7S3q9TLbmdppAs_Rig>
    <xmx:qX5taBSV6q8p3ATwiI2J1LBGpZDBhVfotxRe1y31JMIqU9CKbCZPoQ>
    <xmx:qX5taI8KtNRLXWLSxIDfAzoTrddvV_8LfJ_-dL0Cc0c1-7Zxeio7qblW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 16:25:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  schwab@linux-m68k.org,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 4/4] for-each-ref: introduce a '--start-after' option
In-Reply-To: <20250708-306-git-for-each-ref-pagination-v3-4-8cfba1080be4@gmail.com>
	(Karthik Nayak's message of "Tue, 08 Jul 2025 15:47:49 +0200")
References: <20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com>
	<20250708-306-git-for-each-ref-pagination-v3-4-8cfba1080be4@gmail.com>
Date: Tue, 08 Jul 2025 13:25:11 -0700
Message-ID: <xmqq4ivmv3a0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The `git-for-each-ref(1)` command is used to iterate over references
> present in a repository. In large repositories with millions of
> references, it would be optimal to paginate this output such that we
> can start iteration from a given reference. This would avoid having to
> iterate over all references from the beginning each time when paginating
> through results.
>
> The previous commit added 'seek' functionality to the reference
> backends. Utilize this and expose a '--start-after' option in
> 'git-for-each-ref(1)'. When used, the reference iteration seeks to the
> lexicographically next reference and iterates from there onward.
>
> This enables efficient pagination workflows like:
>     git for-each-ref --count=100
>     git for-each-ref --count=100 --start-after=refs/heads/branch-100
>     git for-each-ref --count=100 --start-after=refs/heads/branch-200

It is a bit hard to understand how this leads to "efficient
pagination" unless the reader is told what the calling script does
after the first call before making the second call.  It remembers
the last output from the Nth call and prepares the N+1th call by
using that last output entry.

But that probably belongs to the end-user facing documentation, not
in the log message.

> +--start-after::

`--start-after=<marker>`::

> +    Allows paginating the output by skipping references up to and including the
> +    specified marker. When paging, it should be noted that references may be
> +    deleted, modified or added between invocations. Output will only yield those
> +    references which follow the marker lexicographically. If the marker does not
> +    exist, output begins from the first reference that would come after it
> +    alphabetically.

It is true that the first entry shown would be what would come
immediately _after_ the given <marker>, whether the marker does or
does not exist.  So "If the marker does not exist, output begins..."
-> "Output begins ..."

Other than that, looked pretty good to me.

Thanks, will queue.

