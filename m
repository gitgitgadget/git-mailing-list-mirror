Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D08D5A781
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711221569; cv=none; b=NqjelPw8jMXxSb8KUQRrUsHx/RH2daQqS6mS+YV9YGBK9rRRHiefa2vqAx2RGKy4e5uMP5NSuZmXNruigTJsiP6O4UrKS6Vqo3NqyJiz+xfriU9KJpWm3SWuJYL0N3nuJRhurBul8RLhasgWoUXfrfku5Y3QusidNxagVQ3lqFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711221569; c=relaxed/simple;
	bh=t58r/GR8Q6JwXQ26+RJa/etWUy7dNhW0EPnZSDS27ok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d35yuyF+iz3mDsNWyzmSj/v8lBMs53bM8EDXS7eumjAo6oYXxNqZlyAA/em5OhWK4KaewgTb0iMeXtdK7ldaz7uRzZZJox63k09JSwfA39ndnm2SPA9rHaI5LOVEEF17DwmJf6GNesFHToBXmmyMPKpY1GoI+Ww/h+/GdrNpa8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CkFlLPLI; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CkFlLPLI"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B4763EB96;
	Sat, 23 Mar 2024 15:19:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=t58r/GR8Q6JwXQ26+RJa/etWUy7dNhW0EPnZSD
	S27ok=; b=CkFlLPLIrqeA1f2yvooXdmqxFg1a3GNrkk6DR6edZvP3K+9YafLOtE
	BbOtzXen6ph2AjeUvPhfpELMiu2GR3/d1tNHE1WXOaW/BMIwA4ctgQvuQXTbenvJ
	hgKomMvbdYlWKIDEFFyBJQVHJDVh8ZqtM04njlTkE/d/X5ERm61Ls=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 132F73EB95;
	Sat, 23 Mar 2024 15:19:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 93E773EB94;
	Sat, 23 Mar 2024 15:19:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH] RFC: add MAINTAINERS file
In-Reply-To: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com> (Linus
	Arver via GitGitGadget's message of "Sat, 23 Mar 2024 03:27:40 +0000")
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com>
Date: Sat, 23 Mar 2024 12:19:15 -0700
Message-ID: <xmqqsf0gvjrg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3DA5F03A-E94A-11EE-89C7-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> This patch is designed to spur discussion about adding an official
> MAINTAINERS file to our project. The hope is that it could be used as a
> reference in (at least) the following scenarios:
>
>   (1) [CC list] patch authors want to know who to CC on their
>       submissions, without resorting to git-blame-level of precision;
>
>   (2) [escalation path] patch authors have been waiting 1+ weeks for
>       review comments, but are not sure who to escalate to (other than
>       Junio);
>
>   (3) [status tracking] record former maintainers/reviewers who are now
>       inactive.
>
> In addition having a MAINTAINERS file could give a more official sense
> of ownership in the codebase.

OK.  They are understandable goals.

As to the format of the actual file, I do not have much opinion.
What works for the kernel may or may not work for us, as the project
size is very different, but I am fairly confident that we can agree
on something usable.

I am more worried about how the file is used and maintained.  Some
things to think about while in the "spurred discussion" I can think
of are:

 - Is the project big enough to require this (especially for the
   purpose of (1)), or would

   $ git shortlog -n --no-merges --since=24.months -- path-to-file

   be sufficient and more importantly the value that it will keep
   current automatically outweigh the benefit of having this file
   that can go stale?  To answer this question, we'd need to know
   the turnover rates of past project contributors, of course.  If
   it is too high, having such a list may help for (1) and (3)
   above.

 - How binding is it for a contributor to be on this list as an area
   expert?  Will there be concrete "expected response time"?  It can
   be different for each area expert, of course.  I'd expect better
   from those who work on Git as a major part of their job and
   contributes some part of their work product back to the upstream,
   than from folks who do Git as a hobby.  Is each contributer
   expected to volunteer to be on this list, with self declared
   service level target?

 - With many good reviewer candidates being employed in companies
   and doing Git as part of their job, how would we handle folks
   getting transferred out of the Git ecosystem?  Unlike in a
   corporate environment, nominating successors who have no track
   record in the community by the current area expert would not work
   at all.  The successors themselves have to earn respect by
   demonstrating their own competence, which would take time.

There may be many others.

Thanks.

> The MAINTAINERS file here is stolen from the one used in the Linux
> Kernel. We do not have to follow its format at all; it is merely added
> here as a reference for comparison and prior art.
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>     RFC: add MAINTAINERS file
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1694%2Flistx%2Fmaintainers-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1694/listx/maintainers-v1
> Pull-Request: https://github.com/git/git/pull/1694
>
>  MAINTAINERS | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 MAINTAINERS
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> new file mode 100644
> index 00000000000..34fa3baf3a5
> --- /dev/null
> +++ b/MAINTAINERS
> @@ -0,0 +1,85 @@
> +List of maintainers
> +===================
> +
> +Descriptions of section entries and preferred order
> +---------------------------------------------------
> +
> +	M: *Mail* patches to: FullName <address@domain>
> +	R: Designated *Reviewer*: FullName <address@domain>
> +	   These reviewers should be CCed on patches.
> +	L: *Mailing list* that is relevant to this area
> +	S: *Status*, one of the following:
> +	   Supported:	Someone is actually paid to look after this.
> +	   Maintained:	Someone actually looks after it.
> +	   Odd Fixes:	It has a maintainer but they don't have time to do
> +			much other than throw the odd patch in. See below..
> +	   Orphan:	No current maintainer [but maybe you could take the
> +			role as you write your new code].
> +	   Obsolete:	Old code. Something tagged obsolete generally means
> +			it has been replaced by a better system and you
> +			should be using that.
> +	W: *Web-page* with status/info
> +	Q: *Patchwork* web based patch tracking system site
> +	B: URI for where to file *bugs*. A web-page with detailed bug
> +	   filing info, a direct bug tracker link, or a mailto: URI.
> +	C: URI for *chat* protocol, server and channel where developers
> +	   usually hang out, for example irc://server/channel.
> +	P: *Subsystem Profile* document for more details submitting
> +	   patches to the given subsystem. This is either an in-tree file,
> +	   or a URI. See Documentation/maintainer/maintainer-entry-profile.rst
> +	   for details.
> +	T: *SCM* tree type and location.
> +	   Type is one of: git, hg, quilt, stgit, topgit
> +	F: *Files* and directories wildcard patterns.
> +	   A trailing slash includes all files and subdirectory files.
> +	   F:	drivers/net/	all files in and below drivers/net
> +	   F:	drivers/net/*	all files in drivers/net, but not below
> +	   F:	*/net/*		all files in "any top level directory"/net
> +	   One pattern per line.  Multiple F: lines acceptable.
> +	X: *Excluded* files and directories that are NOT maintained, same
> +	   rules as F:. Files exclusions are tested before file matches.
> +	   Can be useful for excluding a specific subdirectory, for instance:
> +	   F:	net/
> +	   X:	net/ipv6/
> +	   matches all files in and below net excluding net/ipv6/
> +	N: Files and directories *Regex* patterns.
> +	   N:	[^a-z]tegra	all files whose path contains tegra
> +	                        (not including files like integrator)
> +	   One pattern per line.  Multiple N: lines acceptable.
> +	   scripts/get_maintainer.pl has different behavior for files that
> +	   match F: pattern and matches of N: patterns.  By default,
> +	   get_maintainer will not look at git log history when an F: pattern
> +	   match occurs.  When an N: match occurs, git log history is used
> +	   to also notify the people that have git commit signatures.
> +	K: *Content regex* (perl extended) pattern match in a patch or file.
> +	   For instance:
> +	   K: of_get_profile
> +	      matches patches or files that contain "of_get_profile"
> +	   K: \b(printk|pr_(info|err))\b
> +	      matches patches or files that contain one or more of the words
> +	      printk, pr_info or pr_err
> +	   One regex pattern per line.  Multiple K: lines acceptable.
> +
> +Maintainers List
> +----------------
> +
> +.. note:: When reading this list, please look for the most precise areas
> +          first. When adding to this list, please keep the entries in
> +          alphabetical order.
> +
> +3C59X NETWORK DRIVER
> +M:	Steffen Klassert <klassert@kernel.org>
> +L:	netdev@vger.kernel.org
> +S:	Odd Fixes
> +F:	Documentation/networking/device_drivers/ethernet/3com/vortex.rst
> +F:	drivers/net/ethernet/3com/3c59x.c
> +
> +...
> +
> +THE REST
> +M:	Linus Torvalds <torvalds@linux-foundation.org>
> +L:	linux-kernel@vger.kernel.org
> +S:	Buried alive in reporters
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> +F:	*
> +F:	*/
>
> base-commit: 11c821f2f2a31e70fb5cc449f9a29401c333aad2
