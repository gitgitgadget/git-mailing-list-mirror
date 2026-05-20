Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C383385B2
	for <git@vger.kernel.org>; Wed, 20 May 2026 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294040; cv=none; b=CZF+A9w8+zSqTQrh9L2s50UQBITDjwP98fY/8+0iH6amb15mpOuDcNikIIfQCSjXpKCppVOVjU6DYJ5/imDgrtWjzduyvyEUc6tbkUpiVbbYpsaLdeypJjdVy/z1475NZf0XREDEI6zji3ZYoCPEmQ6PfdJOm3rI58uL+lgR2NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294040; c=relaxed/simple;
	bh=WME9XN5MdbN/1ebKfkPSh81DGjPEnj3vbzv0aqt5rsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rELI/iFkAwiTYhrWPTzexdHeoAzw6NlsDrlY2sQgFm7Z91cVV49ndxb6kTMuAGYM00mbu4ju8tVivErQgt9WrFxO6rHKFzbualchqxUcTasc8lnfs4Cv/5tjGM12QkNt4r8J3igpaEvlY8SqEErO0DgC2Tm+4sxkb0eaVWjJCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkfBQLkw; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkfBQLkw"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-90fe17c157aso578884285a.0
        for <git@vger.kernel.org>; Wed, 20 May 2026 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779294038; x=1779898838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NaduLr9nRJM9sLpwMfh4zq2QLNoWZE1tceUpS8fo1ao=;
        b=ZkfBQLkwPZ07V6kiftIf0eh6S8BAiokP3KQzlR5vPqWIQQ1kkIckqkveWGuJEMX5Hw
         GozUf++k1c7AFoc8vKIvU+yNQ6PeOYSMAUyDRdJSRYeSuxwzaK0CMhVoHZpF3PHLIqGy
         BqLXBFhPYZ13uzNJnIX3kB8vCzWpp3PNOymPS79itjBRDdt7UzAFhyqY930gspoBEIo1
         lwhdX+oG+fagR5nVD/iotqq7PgABfHOggydIkLOBkF+ibAaL4OC4KbfB2R/VYf6FIjiV
         Da2CUrkTZA0MlIHSZpe4wzYUd/WAm4dn+7fCVDJL2pKwF7T1icjtFlY2W/oJBsf2hsvy
         MvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779294038; x=1779898838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NaduLr9nRJM9sLpwMfh4zq2QLNoWZE1tceUpS8fo1ao=;
        b=i7E4zCEQEzcImCMXuSVKTVInEqpJoUjUUhSKTwDhjGtRPSZZn8u4FB8Z2zDRIXmk8/
         xKoCEE0tMDT/zdJIPc3CCPs+818qXK/gb++LPWAB8J0+X9u5fywPWol14XtSxNeZ+2XQ
         uhq6y46QeHWcIaI+c9vy/Vvz7jbeet+3xmpq1ylQJkUPszPd7ZMuKYja/6lu9NSIi7Mx
         qAvcwxC7cDLyrkkldM0tQllDGH9tZ4gAb/WgvSoAn87ckJS6zUR326dG6YzNiS7Bks25
         FiYBrtv/acBwJSJ+HO5JjfwlMVJxTx92tUzBnh6VDhMpZ87Ypqq+zsIyL1mTIdgO0H1J
         k1Pw==
X-Forwarded-Encrypted: i=1; AFNElJ9l3oKq5vegBd1GLnwY1LFURXaAttPPrLxvL6JeIBPwuuuqAJcZAQwjkZdZaKc98zYEL6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzytDMin0R1YJ4N68E/7NXS3QSO0iatI74BPWg+WrBa0+UvjdjW
	0gs2OeEOv9EOwc2EBz/gPUfZtNCr7+1g4JmTECDr3PRhhf6j6jal3eRZ
X-Gm-Gg: Acq92OGkscReUxbIrELwGIp1XdeNjbRtBeIL7Ik/YvbjW0v2JpU4lG6hKYDS+cc+KC/
	YHWdm/N8j3bS5md3k7qQwH2CuWHiz9IeyAfBt/4t0kv0fUPXIpn4TakDCITesd3VS93YdqQkyxn
	asNEQFZlRO62s6XngzKhbZjaeXx/mIIOe19LncMsIrn0Ak7YwZoa8ZiWuN/82cftmlxXMhBBWnx
	lb/AMXX/zlwFl1DzBbt7VUu38g5tckNmods7rWclSxTv0wJ4KD0FMPwnIeheP1Z/aqiPMq3obmu
	UWGAfRjRWYgVJn44RNScDBapTQNKyB0wjjf3QzZneL4gGr7iFNX4eJFqS7MVtWQFvGVPNsP+qpp
	em3AusG0zN+b5xJYRXYBaOut19dS8nkzeDCxoRICyaen4oJFulRByXOS6U6tD4H1LIlBKfnCyaR
	7g3FFBOyrZMgdeGeGqjL6f9YuJguaOluYG6NZH1Ts05gBf3iDcAH1a+TBhllERIfokruBcGnI/A
	eh2kQ3Y
X-Received: by 2002:a05:620a:46a3:b0:90f:9284:66a0 with SMTP id af79cd13be357-911cce886damr3707316185a.6.1779294038068;
        Wed, 20 May 2026 09:20:38 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba36d137sm2156185485a.1.2026.05.20.09.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 09:20:37 -0700 (PDT)
Message-ID: <431a3b73-1819-4798-a0ba-b7351efe6aa1@gmail.com>
Date: Wed, 20 May 2026 12:20:36 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] commit: fall back to full read when maybe_tree is NULL
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Rasmus Villemoes <ravi@prevas.dk>, Daniel Mach <daniel.mach@suse.com>
References: <20260519050513.GA1635924@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260519050513.GA1635924@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/19/2026 1:05 AM, Jeff King wrote:
> When we load a commit object from the commit graph (rather than reading
> the object contents), we don't fill in its "maybe_tree" entry, but
> rather wait to lazy-load it. This goes back to 7b8a21dba1 (commit-graph:
> lazy-load trees for commits, 2018-04-06), and saves the work of
> instantiating tree objects that nobody cares about.
> 
> But it creates a data dependency: now the commit struct depends on the
> graph file to do that lazy load. This is a problem if we close the graph
> file; now we have a commit struct that claims to be parsed but is
> missing some of its data.


> Reported twice recently:
> 
>  - https://lore.kernel.org/git/87h5onsi0f.fsf@prevas.dk/
> 
>  - https://lore.kernel.org/git/6ae85515-9373-4c9e-90d2-5e4176590c5b@suse.com/
> 
> I don't why we suddenly got two reports. AFAICT the bug goes back to
> 2018, though it would become more prominent as use of commit graphs
> increased.

Likely, this may have changed with the switch to using geometric
maintenance instead of gc maintenance by default in Git 2.54.0. That
perhaps increased the amount of commit-graphs being present.
> +static void load_tree_from_commit_contents(struct repository *r, struct commit *commit)
> +{
> +	enum object_type type;
> +	unsigned long size;
> +	char *buf;
> +	const char *p;
> +	struct object_id tree_oid;
> +
> +	buf = odb_read_object(r->objects, &commit->object.oid, &type, &size);
> +	if (!buf)
> +		return;
> +
> +	if (type == OBJ_COMMIT &&
> +	    skip_prefix(buf, "tree ", &p) &&
> +	    !parse_oid_hex(p, &tree_oid, &p) &&
> +	    *p == '\n')
> +		set_commit_tree(commit, lookup_tree(r, &tree_oid));
> +
> +	free(buf);
> +}
> +

I like this focused parsing of the commit contents. I also briefly
considered "unparsing" the commit, but you make a good point in your
message why a focused parse here is important, especially around
munging of the parent list.

>  struct tree *repo_get_commit_tree(struct repository *r,
>  				  const struct commit *commit)
>  {
> @@ -443,7 +464,17 @@ struct tree *repo_get_commit_tree(struct repository *r,
>  	if (commit_graph_position(commit) != COMMIT_NOT_FROM_GRAPH)
>  		return get_commit_tree_in_graph(r, commit);
>  
> -	return NULL;
> +	/*
> +	 * This is either a corrupt commit, or one which we partially loaded
> +	 * from a graph file but then subsequently threw away the graph data.
> +	 *
> +	 * Optimistically assume it's the latter and try to reload from
> +	 * scratch. This gives a performance penalty if it really is a corrupt
> +	 * commit, but presumably that happens rarely (and only once per
> +	 * process).
> +	 */
> +	load_tree_from_commit_contents(r, (struct commit *)commit);
> +	return commit->maybe_tree;
>  }

I agree that this is the right place to insert this logic.

> +test_expect_success 'dissociate from repo with commit graph' '
> +	git init orig &&
> +	# We are trying to make sure the dissociated repo can
> +	# find the tree of the tip commit, so the test could still
> +	# serve its purpose with an empty tree. But having actual
> +	# content future-proofs us against any kind of internal
> +	# empty-tree optimizations.
> +	echo content >orig/file &&
> +	git -C orig add . &&
> +	git -C orig commit -m foo &&
> +
> +	# We will use graph.git as our "local" source to dissociate
> +	# from.
> +	git clone --bare orig graph.git &&
> +	git -C graph.git commit-graph write --reachable &&
> +
> +	# And then finally clone orig, using graph.git to get our objects. This
> +	# must be non-bare so that we perform the checkout step, which will
> +	# need to access the tree of HEAD, which we will have originally loaded
> +	# via the commit graph.
> +	git clone --no-local --reference graph.git --dissociate orig clone
> +'
> +
Thanks for the clear extra coverage here.

-Stolee

