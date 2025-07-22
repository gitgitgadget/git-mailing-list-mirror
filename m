Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AFA2DAFB2
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176247; cv=none; b=lj11NhHASrWU/CC1LUexOkh4PFVBgI6R7u/Bq/jlvVk5OnlYwoJRBAkVWxuItyh/Q0byxpwUTtUvphyC9Yt5qU+s00aCz5Xm9kYm9I94Ts4CRHit3Daz7F72plSlKiRleQHlHLbgkzstv4kIh0+wcQckwQ4O6yDE0Z9TKrWzKqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176247; c=relaxed/simple;
	bh=7E6qsRnX9wMGKb5hDXhHqKJ4BZv8bFbeuLkM3duDiMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6pnJUrNhaLg9ryLDVFvkD5P3rQW4LWD6IZYf37i1u/Ko+GtqYPyO9emjEboc61G4V8bdqyNIP8kH225aE9XWzHU/s8SJy8LGj5B21JU8y8zdPOse3UtHIPUmg8z2yxx6TMoH5pr3Ds29h8Bp3V+xiiyafAce+/a78T9Jgi4d6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EbN9VndW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EbN9VndW"
Received: (qmail 27120 invoked by uid 109); 22 Jul 2025 09:24:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7E6qsRnX9wMGKb5hDXhHqKJ4BZv8bFbeuLkM3duDiMA=; b=EbN9VndW+stQ0GPXqR6CVyXiCKo8aYYL/H1z73lM5J5QQ6tuMPJVoGf/iapxEpBetSTZng8r8bKiTs661+TDJ4XgC7L6+GRICP4/hq43kvc7fngQWp8KxWNSIGTkKf39eN8WW91qC/45zCru9stLPdNqDkvMTImltOgvRag7/2HtmaJcpk+dqTInG0Nz/t7picE4qSNUz6xWnlc/HaV4ovO4KKW0nlVI9ZTmrBbKSgwxHzFvUZiVxjBsm6s1owc3setMzsFBrIhwQSLsJBGME5WpLlD3HwPL67gXGJIxZ6vs7jUxD0z3vBDu3c2YOJTC6pGbjTRfyYBWY9sWQOaI1w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jul 2025 09:24:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27251 invoked by uid 111); 22 Jul 2025 09:24:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jul 2025 05:24:08 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 22 Jul 2025 05:24:03 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= <dilyan.palauzov@aegee.org>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: git treeless-clone + wait =?utf-8?Q?+_?=
 =?utf-8?B?cHVsbCDihpIgcHJvYmxlbSwgYWdhaW4gcHVsbCDihpI=?= OK
Message-ID: <20250722092403.GA889790@coredump.intra.peff.net>
References: <e7a2fdff63d9a90ef4dc1341fa642fff5197b64a.camel@aegee.org>
 <20250722091749.GA864077@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722091749.GA864077@coredump.intra.peff.net>

On Tue, Jul 22, 2025 at 05:17:49AM -0400, Jeff King wrote:

> Whether or not fetch should avoid kicking off that big string of
> fetches, I don't know. Passing --no-recurse-submodules obviously dulls
> the pain. Perhaps the default behavior ought to be different in a
> tree-less repo. Or maybe those tree diffs should be done with
> lazy-fetching turned off (there is no point in recursing for a version
> of a submodule whose parent tree we don't even have!). But I think
> that's all orthogonal to the race.

In an ideal world, I'd imagine that something like this would make
sense:

diff --git a/submodule.c b/submodule.c
index f8373a9ea7..e064fefd9a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1851,7 +1851,12 @@ int fetch_submodules(struct repository *r,
 	strvec_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
-	calculate_changed_submodule_paths(r, &spf.changed_submodule_names);
+	{
+		int save = fetch_if_missing;
+		fetch_if_missing = 0;
+		calculate_changed_submodule_paths(r, &spf.changed_submodule_names);
+		fetch_if_missing = save;
+	}
 	string_list_sort(&spf.changed_submodule_names);
 	run_processes_parallel(&opts);
 

But it doesn't work, because all of the diff code under the hood in the
calculate_changed_submodule_paths() call is not prepared for trees to be
missing. So you just get:

  fatal: unable to read tree (3a112b53a40e2d1240b2a4d01d5e616e0f4f09fd)

or similar. We'd need to teach the diff code some permissive mode where
it quietly ignores trees we don't have locally.

-Peff
