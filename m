Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15C92DAFBB
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976913; cv=none; b=iuUqCn68WsWRNQ/bib8NaFqP7Zf/OVgUzD+kJrsL7f9FThMbBeOroeYlVt1xHqwWVsC8EicMtHxpw/XUOpxY6hoXOTXzxcM2NTLxvIX/1his0MNjMKp94+fby0Ky5odRQ++64FyIo2cRN4bPhcQxjbnWqR2kLvEBy/aySkTn8e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976913; c=relaxed/simple;
	bh=ojFxhrNJaEQsPytV6KrggL1ZrEYJ6OlOH7Xqbw9x4fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnvMrxkzy5IWOTix7RXIVpC9KOVDgbQL6RhyE4EAWy3c+rkWA20RzADZIsFAqBS4e+cqV2O+z8ohZEapJeTmGVD9YSBQrdYv8aTlHzPvXZku7lVF/y71yDfACP7BAiWSF1XiY7xmhHEkO+Su8M2k+RLPpkubo96GsPYav5eX45U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EIsoJ5pV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NXz11pO6; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EIsoJ5pV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NXz11pO6"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BE4341400A32;
	Tue,  8 Jul 2025 08:15:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 08 Jul 2025 08:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751976910; x=1752063310; bh=Lihml4cJ6E
	+qqhdHyO+4+BvOZhAs7jelDdHGe693dHc=; b=EIsoJ5pVWoSTyDYA+ricuT/gkG
	2l7egqm+sRPqIYPfCyABGT1lBSaLZuig77w8ls4+SwiY1OTGFXRSFJYSjvg0hhSM
	FJCTRqRL/YFEJW0L1AGkgK1T1LbrkiPPyqcsrXjAbsXgZhERT8JXRioKrAwLVLYw
	qzD591To0IfIbxAL1lfjhZ9sAyGuI/UNBRAXRniG79M/jsmTWjdV2hn0MmMyDUQx
	5Fwvo6/5u3uKm/OFIK8bATJyPrqhOsQGBeTsdXQfFujd0rTLQH7XjgwFPQnzV1SU
	1txt2Zg7ttj72BayMpl3NETGkjPPOQePReNC+oP88/HXFtOGmB5FwG1J5KLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751976910; x=1752063310; bh=Lihml4cJ6E+qqhdHyO+4+BvOZhAs7jelDdH
	Ge693dHc=; b=NXz11pO6vxZ3GZiQEr8cNdjc9pnDt4owXTHr+jdwkWt7Ii7gsrf
	hU4QxmAsAWHnWQHQ3JWjnOpzVYLQx9mhm+vHm/mHd/otjaMS75ZX/0EhCUNO9Km6
	BKVI8Vc6Cm5+TX8oNzEx09/i7Ptha8cFbgqYG2/yRRXmAkCEjIRpc+lJWmqw6ZLj
	VkdUaDNV5PRFShw5sWWcmIQFOB9KvvHomWo2y3peSFHcmiecZ/wv2uMjLXi6jzEd
	Z6gwYpsAwebrVAJ1mrXbmee3D6z4yIjewTLZQN8Lv11imj7gBGMcdQE/P8ltTSBj
	cM61XmaIGwVXvcnJ2MyOTWIy6unpxvNLXiA==
X-ME-Sender: <xms:zgttaJcGvtGxbW7k0FJz2k68f2oDWt-VnBhTungztoHoDSkmtRihxw>
    <xme:zgttaCsLG7CAXo5oBshTUAvCaITGOUpsiYKMdYp7sYoQSIW3kOu8YhDweK3wU4H_s
    l-i4VjYadOPVt9vVQ>
X-ME-Received: <xmr:zgttaI-N0WL6BDaFQLyAvW46mcyRmAeF_R9HCdepKs2AJ349hHPqFroFARPEnZRpJ4Rbjzr9i8tALRWGGzGga4xj7zOrHUbal6jtnbf7ckY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtth
    hopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:zgttaN18UQ_6o3clrAzmxRyFIeshczos75AEn3KMYIcEJ6b77_nWKQ>
    <xmx:zgttaNARmYEBljtLEFHPuZY0Cbl03GG516ljRqkE8uhj2ZKfxazN2g>
    <xmx:zgttaJe9JtbWYSFfjzlPZc_YfV1lJO-DP5tpPFjMUbYcAZT5k7IMAQ>
    <xmx:zgttaK6kea2QJ3wTAbP-h7NkjNxy75iavFSSyj1Iyoi38Lt5TJAQBQ>
    <xmx:zgttaEvwA_9HdQwJKxRYJtbzrd0sEKJJ7vKAS4b4yUibK9Or21p92CkX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 08:15:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 04f0eb98 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 8 Jul 2025 12:15:07 +0000 (UTC)
Date: Tue, 8 Jul 2025 14:15:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/3] sparse-checkout: add 'clean' command
Message-ID: <aG0LyDAUSM7F7OmH@pks.im>
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1941.git.1751973594.gitgitgadget@gmail.com>

On Tue, Jul 08, 2025 at 11:19:50AM +0000, Derrick Stolee via GitGitGadget wrote:
> When using cone-mode sparse-checkout, users specify which tracked
> directories they want (recursively) and any directory not part of the parent
> paths for those directories are considered "out of scope". When changing
> sparse-checkouts, there are a variety of reasons why these "out of scope"
> directories could remain, including:
> 
>  * The user has .gitignore or .git/info/exclude files that tell Git to not
>    remove files of a certain type.
>  * Some filesystem blocker prevented the removal of a tracked file. This is
>    usually more of an issue on Windows where a read handle will block file
>    deletion.
> 
> Typically, this would not mean too much for the user experience. A few extra
> filesystem checks might be required to satisfy git status commands, but the
> scope of the performance hit is relative to how many cruft files are left
> over in this situation.
> 
> However, when using the sparse index, these tracked sparse directories cause
> significant performance issues. When noticing that the index contains a
> sparse directory but that directory exists on disk, Git needs to expand that
> sparse directory to determine which files are tracked or untracked. The
> current mechanism expands the entire index to a full one, an expensive
> operation that scales with the total number of paths at HEAD and not just
> the number of cruft files left over.
> 
> Advice was added in 9479a31d603 (advice: warn when sparse index expands,
> 2024-07-08) to help users determine that they were in this state. However,
> the advice doesn't actually recommend helpful ways to get out of this state.
> Recommending "git clean" on its own is incomplete, as typically users
> actually need 'git clean -dfx' to clear out the ignored or excluded files.
> Even then, they may need 'git sparse-checkout reapply' afterwards to clear
> the sparse directories.
> 
> The advice was successful in helping to alert users to the problem, which is
> how I got wind of many of these cases for how users get into this state.
> It's now time to give them a tool that helps them out of this state.

As usual for you, this is a nicely-written summary of how we got here
and why the current mechanisms are insufficient for mere mortals.

> This series adds a new 'git sparse-checkout clean' command that currently
> only works for cone-mode sparse-checkouts. The only thing it does is
> collapse the index to a sparse index (as much as possible) and make sure
> that any sparse directories are removed. These directories are listed to
> stdout.
> 
> A --dry-run option is available to list the directories that would be
> removed without actually deleting the directories.
> 
> This option would be preferred to something like 'git clean -dfx' since it
> does not clear the excluded files that are still within the sparse-checkout.
> Instead, it performs the exact filesystem operations required to refresh the
> sparse index performance back to what is expected.
> 
> I spent a few weeks debating with myself about whether or not this was the
> right interface, so please suggest alternatives if you have better ideas.
> Among my rejected ideas include:
> 
>  * 'git sparse-checkout reapply -f -x' or similar augmentations of
>    'reapply'.
>  * 'git clean --sparse' to focus the clean operation on things outside of
>    the sparse-checkout.
> 
> The implementation is rather simple with the current CLI. Future
> augmentations could include a --quiet option to silence the output and a
> --verbose option to list the files that exist within each directory and
> would/will be removed.

One of the benefits of your new command is that we can extend it in the
future as necessary if we ever notice that there are other things that
we need to do to bring the sparse checkout up to date again. So without
yet having had a look at the implementation I think this direction is
quite sensible.

Ideally it would of course be great if we could automatically fix the
issue for our users. But as we have to prune potentially-ignored data it
is very much a no-go to do that in the automatically.

Patrick
