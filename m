Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284C7194A54
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736961273; cv=none; b=lPCLqPef3vC9rF/GtgIRoAWeaGvxIzJgtpKkHs1/teqo8Fp89Kvppk92eIZrpD1vBxvitJHPNpc7EASaHr35rLEt2BIES0eppGhkIcWtBrdnW46hbpvUsD/ySsqToGw09IgZhszIIqHLEpyUmchPMAZp6L4Yk/gy9wN3psAQnhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736961273; c=relaxed/simple;
	bh=+uHGPu11WRrofkKi7WOBxfDv8h8CXFdoEqCt/hu/0zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WI0JQMdHrarKkGWNvmHVqYdYDSuWJjrVN3zSTqc9m+EFUCepyo61usX84kBjw/fLSbDz1AHwiJnWNqoDw1C+P1Xq5rjpdQaxQYFv7ln82brW3XcEDALB8I9vQmbqjLt1JGY0ghK2ETRVEGlaDPyEVaAhag9QQG948BI73VL0SDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KzjOH6/1; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KzjOH6/1"
Received: (qmail 5218 invoked by uid 109); 15 Jan 2025 17:14:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+uHGPu11WRrofkKi7WOBxfDv8h8CXFdoEqCt/hu/0zo=; b=KzjOH6/1/8S6QLkC+VIStFI9PLM9/QhXiBBe4cFvhSafnaNOQgpmiVksQ3fuYChUgUTg56laePFr42WSKYCAaPHkoboOumZ7pKgfLfxDpd8xgin2PTppeqr6KRFqGYwzoGrmJeKNpB6+WZSgNf6KS7eU8PGajcl2MSa/eZ8bl3KRmZJ0wGTpkwSJ///yAef3Dm/o2OBKEqPPDUPvk08zmdvYsNAKSwGPKvXR6dZb4slN0kJKCfgR8ZJkD7G2rYjEg5ydafC42lBpehVbvGSx/obQmAZKym/5i8EfccwhHv6qWbuMDFZl6S69SvHEHEmtXOfVz9hlOwRZnM3iMP8YGw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Jan 2025 17:14:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11050 invoked by uid 111); 15 Jan 2025 17:14:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Jan 2025 12:14:24 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 15 Jan 2025 12:14:23 -0500
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>,
	Jonas Konrad <jonas.konrad@uni-muenster.de>, git@vger.kernel.org
Subject: Re: Git branch outputs usage message on stderr
Message-ID: <20250115171423.GB57018@coredump.intra.peff.net>
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
 <D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu>
 <xmqqed1414gt.fsf@gitster.g>
 <c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>

On Wed, Jan 15, 2025 at 05:55:19PM +0100, Kristoffer Haugsbakk wrote:

> On Wed, Jan 15, 2025, at 16:28, Junio C Hamano wrote:
> > Somebody may want to go over "git help --all" and for each of them
> > try "git $cmd -h >/dev/null" to find those that give the help output
> > to their standard error stream.
> 
>     #!/bin/sh
> 
>     for cmd in $(git --list-cmds=builtins); do
>         git $cmd -h >/dev/null
>     done 2>&1 | grep '^usage: ' \
>         | perl -pe 's/^usage:\s*(\(EXPERIMENTAL!\)\s*)?//; s/^(git\s+[a-zA-Z0-9-]+).*/\1/'
> [...]

We may want:

diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 1d273d91c2..469cb12eb2 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -255,7 +255,8 @@ do
 		(
 			GIT_CEILING_DIRECTORIES=$(pwd) &&
 			export GIT_CEILING_DIRECTORIES &&
-			test_expect_code 129 git -C sub $builtin -h >output 2>&1
+			test_expect_code 129 git -C sub $builtin -h >output 2>err &&
+			test_must_be_empty err
 		) &&
 		test_grep usage output
 	'

which produces a similar list. In the case of git-branch, it is due to
1dacfbcf13 (branch -h: show usage even in an invalid repository,
2010-10-22). Instead of letting parse-options handle it (which then goes
to stdout), we call usage_with_options(), which is usually for
complaining about a broken option, not showing "-h".

The reason there is that some of the pre-parse_options() setup accesses
the ref store (causing a BUG() if you run "branch -h" outside of a
repository). In this case, I think it can simply be reordered like:

diff --git a/builtin/branch.c b/builtin/branch.c
index 6e7b0cfddb..4617e32fff 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -784,31 +784,28 @@ int cmd_branch(int argc,
 	filter.kind = FILTER_REFS_BRANCHES;
 	filter.abbrev = -1;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_branch_usage, options);
-
 	/*
 	 * Try to set sort keys from config. If config does not set any,
 	 * fall back on default (refname) sorting.
 	 */
 	git_config(git_branch_config, &sorting_options);
 	if (!sorting_options.nr)
 		string_list_append(&sorting_options, "refname");
 
 	track = git_branch_track;
 
+	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
+			     0);
+
 	head = refs_resolve_refdup(get_main_ref_store(the_repository), "HEAD",
 				   0, &head_oid, NULL);
 	if (!head)
 		die(_("failed to resolve HEAD as a valid ref"));
 	if (!strcmp(head, "HEAD"))
 		filter.detached = 1;
 	else if (!skip_prefix(head, "refs/heads/", &head))
 		die(_("HEAD not found below refs/heads!"));
 
-	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
-			     0);
-
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
 	    !show_current && !unset_upstream && argc == 0)
 		list = 1;

Knowing that is safe means confirming manually that setup code is not
needed by parse_options(). E.g., if it were setting defaults the user
could overwrite with an option. In this case neither "head" nor
"filter.detached" is touched by any of the options.

But there are a ton of commands, as you saw, and handling each one would
be a pain. So it would probably be easier to just introduce a variant of
usage_with_options() that writes to stdout (the underlying _internal
function already does so, we'd just need a one-liner wrapper). And then
use that everywhere. Possibly it could even do the argc/argv check, too,
since every call site is going to be doing that itself.

-Peff
