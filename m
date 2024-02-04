Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FDE2C689
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 22:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084873; cv=pass; b=ibyzsZQK6OE/PuGoH3Lp3vi/NIPHXQ/s1WNwO2usqE76qmEAki4EOR4crhfb4T8f4g5XUWnu4tUuyPBfcpXtHsl877B/Inecm3Gnsgh8QueofrBUqDGaDCIOLC2OAR0eXlKeiWf0eXyMryBf1bHmogtvM9A38hnR46iFxUyljd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084873; c=relaxed/simple;
	bh=sS2vTQpNTptpSYO8d0Az4dG3SNdnvUxkGXVTjZ19Ndk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ic3Lw3nzNjtxut0H3dqoxYGc9K5GmYgxEJ+uSg4ke8tJKJaqANXbpo22s5SrSOcAD/uQelKBaFQ+WKaN3fTlv1gtWoh48tR2fRlPQqEe7WmUuAFKIkXj7BVumLXpmepjOH2ktjxp0oraOxwvqJABxJ4k/EJ+iK/gT+OPJi5w9Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zoho.com; spf=pass smtp.mailfrom=zoho.com; dkim=pass (1024-bit key) header.d=zoho.com header.i=mmogilvi+git@zoho.com header.b=LZL3gVFn; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zoho.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zoho.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=mmogilvi+git@zoho.com header.b="LZL3gVFn"
ARC-Seal: i=1; a=rsa-sha256; t=1707084869; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Deqju/MMmwkAq/nVWt+jPlswhHw49kalpqKRE9gKCLspfowh4obMS0WeS7QC3RCBYEqGSkuxf9hSSpOHP28RCnkwCzYCEuhh/umgfE34LXEWU0xvHoD9gvFac6x7yjmXMRS8rYb5HLkBzsUNps+nAbLkpRqvgYwtWDJ0Efh6eCQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1707084869; h=Content-Type:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=QBD2+Tml8/cij/GR7mHAYqgKiZHvijKXm1O+M5HQylA=; 
	b=equvAqDhtsKor64cLMntAYklvg3Ui3T8bB7sTQjtl8IziXU9gOfck4EuUrFKFGbWnkOTicUBUsj+vL2y5MkMWJHUlH57bNaqNU+27HDWZXTyLLrAypuGDdm4mhtaYe1NV1oNSmrRIE/TsXI9BqJDk2Y0VDlNrU6G/ZIgXy2yOlE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zoho.com;
	spf=pass  smtp.mailfrom=mmogilvi+git@zoho.com;
	dmarc=pass header.from=<mmogilvi+git@zoho.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1707084869;
	s=zm2022; d=zoho.com; i=mmogilvi+git@zoho.com;
	h=Date:Date:From:From:To:To:Subject:Subject:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To:Cc;
	bh=QBD2+Tml8/cij/GR7mHAYqgKiZHvijKXm1O+M5HQylA=;
	b=LZL3gVFnFkWPsD0zP67DPyER7vgPCuZQnzsUDADvxcT8Ch6XHaQawnlNvt1yB/Vj
	rH1tz7xsL2RsOnxP/MFTye0u6OQ6LINZiGwjsj4Aiu0SyhRqVRb8MMi6AMigEUnSh/5
	5s2+HdSVb9mPX/0/YxOd1b7i724RM4gRjrxXe4Wg=
Received: from mmogilvi.dynu.net (75.70.202.171 [75.70.202.171]) by mx.zohomail.com
	with SMTPS id 170708486773026.400363244894038; Sun, 4 Feb 2024 14:14:27 -0800 (PST)
Received: by mmogilvi.dynu.net (Postfix, from userid 501)
	id 6920147C3464; Sun,  4 Feb 2024 15:14:26 -0700 (MST)
Date: Sun, 4 Feb 2024 15:14:26 -0700
From: Matthew Ogilvie <mmogilvi+git@zoho.com>
To: git@vger.kernel.org
Subject: submodules: multiple alternative relative URL schemes?
Message-ID: <ZcAMQpQlVsV2w2y2@comcast.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ZohoMailClient: External

Background:

At work we are switching to submodules to share various
utility code between mostly-unrelated projects and programs.

When working on any one project, I commonly fetch and push
preliminary changes beween numerous different sandboxes in
various places (same machine, different machines, VM's, etc).
Basically, I make extensive use of git's distributed nature.

Issue:

However, submodules don't seem to streamline fetching/pushing
the whole collection of modules together from varied sources
very well, without manually configuring or manipulating each
submodule and its' "remote"s individually.  For example, if
I recursively clone from a local sandbox with local changes
into another local sandbox, it will clone the main superproject
from the local source, but the submodules will be downloaded
from the URLs in the .gitmodules file, not the local copies
(that might have local changes that will be missed).

-----

Relative URLs could maybe help, except there seems to be at least
two common relative URL repository schemes/organizations that
are often needed, and probably more:

1. Subproject bare repositories are immediately adjacent to the
superproject repository, such that relative URLs like
"../submodule1.git" should work.

This is probably common in web-based hosting of personal "forks"
like in github, bitbucket, or similar.

It is also the most obvious way to organize multiple
semi-related repositories on a small self-hosted server.

2. Or you want to fetch changes between sandboxes, perhaps
to test code changes on multiple platforms, or to continue someone
else's incomplete work.  In this case, relative links like
"./.git/modules/submodule1" would probably work.  But bare/origin/main
repositories would rarely be organized like this.

3. "Official" configured upstream URLs may also be organized in other
ways.  For example, in something like github, different upstream URLs
may be "owned" by different owners, so they may URLs like
"BASE/OWNER1/MODULE1.git", "BASE/OWNER2/MODULE2.git",
with different and semi-random "OWNER"s, not amenable to template
strings (see (E) below).  Or different submodule upstreams may be on
completely different servers...

-----

Basically, I would like to restore or at least improve git's
ability to transparently/smoothly work in a "distributed" manner
(no "blesssed main upstream repositories") when a project
requires certain submodules.

Some Ideas:

A. Is there something I'm missing?  Is there some good solution
I just haven't stumbled over?  Any documentation URLs and/or
keywords I should look for?

B. Of course no matter what, you could always set up all your various
remote URLs individually manually, or write special project-specific
helper scripts.  But something more automated and built-in
would be nice...

C. future?: Potentially, the .gitmodules file could define multiple
different URLs for each submodule, distinguished by named URL
"schemes" that could be specified on the command line.
"git clone", "git fetch", "git push", "git submodule", etc could
all take an optional "scheme" argument of some kind to indicate
which sets of URLs to use...

D. future?: Potentially hard-code some schemes?  1 and 2 are probably the
most common alternative relative URL schemes, so it might be worth
explicitly supporting them without requiring any explicit configuration
changes.  Maybe this would be adequate by itself; don't even support
other "alternative" named schemes (multiple 3's)?

E. future?: In some cases, a "scheme" for a whole set of URLs
could maybe be simplified into a single URL template string.
Substitute in the "base" and the submodule name to get a
specific URL...

F. Potentially add some optional fallback logic?  If it fails to
fetch/clone from one URL, try another scheme instead?  (But this
might leave things in a confusingly unpredictable/mixed state,
particularly if the network is flakey...)

G. Different approach: Instead of separate repositories, maybe
the submodules could essentially all be in one repository, but
distinguished by using different tags/namespaces in the "refs"
hierarchy.  ("refs/heads/SUBMODULE/WHATEVER"?
"refs/SUBMODULE/heads/WHATEVER"?)  The "original/main" upstream
might still split up repositories, but clones/local changes/etc
could be more self-contained this way...  (Working out all the
nuances to streamline this idea might be a whole separate
discussion...)

H. "git subtree" instead of submodules: If it was up to me, I like
the subtree solution.  Most of the time you can ignore the fact that
some code is shared, and only need to worry about it when actually
syncing/merging shared code between different projects, which is
generally much rarer than day-to-day development tasks.
But unfortunately subtrees seems to be somewhat unpopular, as
currently implemented: Isolated in "contrib", doing graph traversal
logic in shell script of all things (very slow, especially on
Windows where many of my coworkers reside), etc.  And ultimately
in my case I think I've already lost this argument.  So I'm trying
to figure out how to make submodules work better.

I. Any other ideas?

-----

In the short term, I expect I'll have to resort to (B) (custom scripts).

In the longer term, depending on what people think and if I can find
the time, maybe I could actually implement some of these ideas
in git for a future release?  What do people think of these ideas?

                - Matthew Ogilvie
