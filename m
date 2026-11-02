Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.231.85.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649224;
	b=SVnGeG6FPxyrEp8qeDFCyDpdsx5V0CA9GeQyW09iifsH/zun2w5Qe/2kwkoo+av0F5cZ
	 w8Lq/h97hX3+jDLbMq+i5YsmKU3khJa/JAI2AOodF4UFHENo72+iCcybdYDq0FbdLBefP
	 hqhBXhkowF0MV6UyJu5NWnVWb1kRbH5XJXSKqwl8zKoksfHv4xjmFwUjMtiusU+cEjYFY
	 9uqpI2xSz9ELfr7GNktPda+ie9bDU4G1kQ5UiR9RbfETmdQQCLlfxHqBLI/UWqD5QEjCv
	 GG4JVz/Mfp7JBW6W3gKff16XKLewNlJYQa8Vz4xns1R4WHoSjdbFjORurFgSRk+BwFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649224;
	h=DMARC-Filter:Date:DKIM-Signature:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Bar;
	bh=VZgK4cXZieiH3USKgO6cZyX1w2Pjb3mJpcQGbZXnkqM=;
	b=VEnaQ1Zx4ioBekszvEg/X1+Ygb6SqDP2g4ItRFqs6j6PGq7pC1ND0apZGmFGGlKeMIUk
	 rzl+K2/xkNhNIip3N0BxvQvPNK0a22Xc5QiAiEFLjvRmAiR8ulLJL9B2DxHQz8FETn7v4
	 SpvoQ8GRz7ZFFnqqxV8RfJXM8yB3Nt/Ta/Hxzq4fDgvP3laT6Znui+4chEJAt0A+Go9Ij
	 T856J52CflQ4vyCYwlP8tIyoUVQsrbB8zXNRAUx33INwyqQiD4kBLUfrLdEycVbBjxawi
	 S9iSLVUZCRKPtNR4SQcdY5bKgUok1v7iXmxhJsxGJGCfWzAX0/KBc/8DBFRC16fDqwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=delayed.space;
	spf=pass smtp.mailfrom=delayed.space;
	dkim=pass header.d=delayed.space header.i=@delayed.space header.a=rsa-sha256 header.s=dkim header.b=TAhVcGct;
	arc=none smtp.remote-ip=195.231.85.169
Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE16082BFD
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 19:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDBE16082BFD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=delayed.space header.i=@delayed.space header.a=rsa-sha256 header.s=dkim header.b=TAhVcGct
Date: Mon, 2 Nov 2026 20:53:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1793649214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZgK4cXZieiH3USKgO6cZyX1w2Pjb3mJpcQGbZXnkqM=;
	b=TAhVcGct7HzZbSvz8sFxZrER/3qakes/OMMXIHLyvXV+9yTnOPYlVQWj4tn++eBpIHb+zy
	CHKDS0Lp6TKV5efu5FcdkUXzWnypyM5+d9WFpIkI+qI2cy/vuLzsne3QS6Wy0HmbNu6mgp
	lYK7xsiRkhNzVlEf+YYyi808svpsiEZgzQ3rb1cOxvMG8gx6yOFyOHIBKAh/v8oFXxIYNX
	tm4G8VtIB4IEX0igGFyWGyTf4AAy4NJ4K4YFidef5jukXSqXtHoUFyK1NJzr3IJXbkzL/b
	8j5kj4oJBDTmWvMvcwF0glJlVdZqP+KFG+3u3Mz+GrgErd/kEOqg64kb0d6Klg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH] bash-completions: add --[no-]graph-indent
Message-ID: <aujlNwM6X3BLz22V@exploit>
References: <63106e1dec45e82c7f132a18816b2d1fffb52752.1791921033.git.mroik@delayed.space>
 <DMHD8RCO7V74.2BK7C9T4HNLHO@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMHD8RCO7V74.2BK7C9T4HNLHO@gmail.com>
X-Spamd-Bar: -

On Thu, Oct 29, 2026 at 01:45:15PM +0000, Pablo Sabater wrote:
> I didn't know about this so I completely forgot to add it, however from
> what I read, this is the __git_log_common_options and I'm not sure if
> this is a "common" opt, as I don't even see --graph here.
> 
> I searched where --graph is, and it's here:
> 
> l 2383-2409 'git-completion.bash'
> 
> 	__gitcomp "
> [more opts]
> 		--graph
> [more opts]
> 		$merge
> 		$__git_diff_common_options
> 		"
> 	return
> 	;;
> 
> I think it would fit better here (not sure, I just quickly skimmed the
> file).

Yes, you're right. I was on automatic mode when choosing where to place
it and defaulted to the place where I put an option of mine that worked
for log. Since this is specific to "git log" I'll place it where you
suggested.

> Also, I missed this for the --graph-lane-limit option so maybe it should
> be added too?

Not familiar with the option but will look into it, might as well add
it.

> My main doubt is, both these options proposed (yours and
> --graph-lane-limit) are --graph dependent, which means if someone
> autocompletes them but doesn't use --graph, they will get an error
> saying that --graph is needed. I'd say we do what other --graph
> dependent options do, but AFAIK these two are the only ones.
> 
> From Toon's Git Merge talk, more options for --graph option will be
> developed so we should maybe think about how to do it in a way that 
> doesn't autocomplete if it's going to error? (maybe that does exist,
> given the multiple options that depend on other options)

From what I can tell the only reason we options through bash-completions
is because these options are not handled by the parse-options.h
machinery. Ideally we'd want to port these options to that? I'm assuming
the reason it wasn't was because of the common options.

With the parse-options.h machinery you can't tell which option depends
on which other, so it just shows every option available for a command
when autocompleting. I'm not sure it's worth it to implement such a
feature with bash-completions when the parse-options.h machinery
doesn't.

Thank you for the review, will reroll.
Mirko Faina
