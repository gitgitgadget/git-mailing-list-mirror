Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760495;
	b=L8U6dBp2WyyBHjPfS1l9U4cZrSYFfSib2Tadet02BpME2RnEo+bwNZ+IIf+d2kmLdrCE
	 1sWOKRv4uxrmj8WL4/szaXZSAB1Rw30/+9jLwF3uueapy8GIaCx8f4Qa7nOLGqeY8/MNg
	 59/f3mzEBGREAtTsdD/utuE9gn1XOGQhWbONeQNWPOvHcKg+efBZnHLjh4s03FxICzT1D
	 ndOjC4qPSrCL0vxb7esFbARAWBL21pc1I/SdL7I4fzMIjUsaWiyWCA0YTvHzWwVwzC/sd
	 a+vftOBvP9faKefl4W6DhGe82XoIVcoKAqnr6SWXKV0Hx099Zd8jjT9pjlRlnC5c8Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760495;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=SRL5ZyN5S/e6D/KX2REHbwukNLmI5FzLOcw0YyD81nI=;
	b=Y1wWtFLdgVg/qTdt5wueqt+CIxAGUsLv4cFfPTgSF+GyjiDVim6G0jj+/nHG8IqVhTJZ
	 277WPqTNgtrPop3U40WNrWFOgZ0NUoLsyum7Ilg5f4gINYcuV77j0ZADANOXi+E3uzLG1
	 6LTgtpB56lEO8FzK0KdR+SgPDVQiIjX0pociXB9Jk7Gq8Ynl4f3czruCJbfn4Lfg1ex5Q
	 VhI5KqwNc6yUzAwmO2DS8aB4A5SlrayP6cuLF9yrM7kdVhALVWVLPPWT9TgWFwM/uy/UB
	 3HAGDRAp9j3zuEhPIs+sFpd/RSRR4mhkM0gji1MTm2Ncc1BV/1B9m9XUvp5kDgrPpcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=Mc8QTkmI;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1929F606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 02:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1929F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=Mc8QTkmI
Received: (qmail 11461 invoked by uid 106); 4 Nov 2026 02:48:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=InXE9qk5b7hG3VziEMx3YPoeG34R8vGGuE+DneChDF4=; b=Mc8QTkmI6xxzUwGt6TYiu83vLQNPM3m3VfXjl4mfB+qVPOLXwVWhpyKe/pwfr2HM0MacLL1McE2rNyj/5kKIkmcgDFATDraZJpvG4XFaUwqE1JcLG4dM9L2onW+2hy+cdrVjXVHxPa1TpTb47hsdQP7CEyLjbDWbQa9E0ZL/WggzXXGkO9Oth0xRmK58RlInt2mzNLk9b5a9/I7NSVG2pzk/fd9JjAodfIKgm5XBhmnz6gVp9B6GdtL5WdhWvw7iAYMrfqQE0fTjx5gh0iV8aAbKYBWK4Bc9sJXYhfmpc6Nzng2fwIl3GmjWOyDQ2pTjQMuK1hMRDc1bwZDJHri8EA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2026 02:48:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27362 invoked by uid 111); 4 Nov 2026 02:48:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Nov 2026 21:48:07 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 3 Nov 2026 21:48:06 -0500
From: Jeff King <peff@peff.net>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>,
	Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v2] odb: do not list our own refs as alternate refs in
 the quarantine
Message-ID: <20261104024806.GA1492379@coredump.intra.peff.net>
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
 <pull.2285.v2.git.1793619933300.gitgitgadget@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2285.v2.git.1793619933300.gitgitgadget@gmail.com>

On Mon, Nov 02, 2026 at 11:45:33AM +0000, Kristofer Karlsson via GitGitGadget wrote:

> An alternate that is ourselves is not a source of alternate refs: its
> refs are our own refs, which the caller already lists as it sees fit.
> Mark each object directory added via alternates with whether it is
> borrowed from another repository, and list alternate refs only from
> those. Within one process this needs no guessing, as tmp-objdir
> links our own object directory in itself. But a child process rebuilds
> its object store from the environment, so when an alternate is added,
> recognize ourselves in two ways:
> 
>  - as our <commondir>/objects, which also covers an environment that
>    makes our own object directory an alternate by hand;
> 
>  - as the parent of GIT_QUARANTINE_PATH, as the quarantine is created
>    directly inside our object directory (see "QUARANTINE ENVIRONMENT"
>    in git-receive-pack(1)); this also works when the object directory
>    is not under the commondir.

So as I said before, I think this is a reasonable fix regardless of the
how quarantine issues work. We should not be pulling in alternate ref
sources that duplicate each other or our main repo.

But I was surprised to see special handling of GIT_QUARANTINE_PATH here.
I think this is a defect in the alternate-ref code. Yes, the common case
is triggering it with our tmp-objdir shenanigans, but if we fix the
underlying issue, then the use of it here should fix the quarantine
issue automatically.

I.e., I'd expect the code part of the patch to just be:

diff --git a/odb.c b/odb.c
index 2c93a9490c..f9ab5c8e7f 100644
--- a/odb.c
+++ b/odb.c
@@ -183,6 +183,7 @@ static int refs_from_alternate_cb(struct odb_files_dir *alternate,
 				  void *payload)
 {
 	struct strbuf path = STRBUF_INIT;
+	struct strbuf repo = STRBUF_INIT;
 	size_t base_len;
 	struct alternate_refs_data *cb = payload;
 
@@ -198,10 +199,16 @@ static int refs_from_alternate_cb(struct odb_files_dir *alternate,
 		goto out;
 	strbuf_setlen(&path, base_len);
 
+	/* XXX could realpath once in caller as a mild optimization */
+	if (strbuf_realpath(&repo, cb->repo->commondir, 0) &&
+	    !strcmp(path.buf, repo.buf))
+		goto out;
+
 	read_alternate_refs(cb->repo, path.buf, cb->fn, cb->payload);
 
 out:
 	strbuf_release(&path);
+	strbuf_release(&repo);
 	return 0;
 }
 

and keep it totally local to the path hackery in the alternate-refs
path.

Or am I missing something that requires more complication?

> This is safe: alternate refs only serve as negative tips that are
> assumed to be complete, so dropping some can only make the traversal
> walk further, never make it accept a missing object.

That's how _we_ use them in the internal callers, but it's a rev-list
option. So we can't say how they are used elsewhere. That said, I think
this is a totally reasonable tightening of the definition for general
use.

-Peff
