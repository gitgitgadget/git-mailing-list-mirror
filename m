Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9EB28FC
	for <git@vger.kernel.org>; Thu,  2 May 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671232; cv=none; b=F0D9/R9Mqr5UjJUuaPwCEw46ivcpeDD1hifVKHa4LZexTEUotvBGcvdZTfuZsQLKqeuw8wf5cPdi0ZLMM6L4+GN70+cu8uYLumi13jJm/o932t2aX50ljBpCSotNHNoZrjgerQTu9P9cCDxQBxM7FzAPB4kaPmBsuALYSd+Zxzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671232; c=relaxed/simple;
	bh=c/Rgrt/3QrBZTAgiwphFt7sW5yiAZ5PTrc5v+YLzz1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCfxwQRb+fsLLxTF6X3lllP54KjbxJ8Xh1HISmsErnNwdVItB6GDJW3x4/0ePVpT4oaQsHoPbDSUmpOSDNGn/JFkOtUd1dfGvBhkLxUmH5NgzQpnK4ZQQUAOUsOjBcUQmkyxxG5vwvEocujPEc1M1Bt95v5LnLo5/FNVm5UL8WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=0mqKUC0M; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0mqKUC0M"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61b92a83216so93524447b3.2
        for <git@vger.kernel.org>; Thu, 02 May 2024 10:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714671230; x=1715276030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JgiFEAdpCrV5AujyVHGKwusyLDq0XIskfwqS/Zqb9mE=;
        b=0mqKUC0MDBfCRWGIs8Ys4IlJJojdM4tIhr8xV4cwKfTM9j3ht7LooFrZpYIerwAIE/
         ky3dO0KVdjUOYkFeD62SRQKUo/Jy2edyy3ZH+Sx8aoyBoRrkSgBxzY/4WOWkw1zeuLxG
         iFJpoyvDYkFWbYo5aB9A5q3PqcJBYxaEQOJ0PM12z7ymKh3fHFa7hDktzUYDp8e/jSEK
         Vfdc+EviALPSYsfrU5V9ywCEUTnr7x4L7j0Qw3N4LTs+RkoxW5iLIFdfEaFchi7A8OjD
         C1FzLS8sF/8X/sUnIeJUVgwJJSE/HqJtsYpRut13QBVa+aL4sBEFLgWocG379rVo+2g1
         yZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714671230; x=1715276030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgiFEAdpCrV5AujyVHGKwusyLDq0XIskfwqS/Zqb9mE=;
        b=qZkfprDJ6j3NomNUy57GAvVlKylf81hbuZBoGOkkcy1F6xmECie+huh8yHlFJWwBL6
         lMuZlpnMGjELdZdnBDT/ZPxRTqGNlJZF4aygV0+LvBv4yGiQy1/VMGDQNj+EnxzZUzAc
         vRaWgjO6MiiAv5AS6CJTCqV7p+LA0FcouUO5IJtnal97rF407/Dzs1rEXW8US5a3GNfG
         uLIRweK1WdLskX7axAL4POsU9eR7zW9a20NybuzElAXER39nbYmLzqbp4kKtSaorq48u
         7XO3XzU+itNSM6mSGSshQ2ftK+RSCDSyivlpQ/1QjTXD5l4zoIFBF9CZTvj/A7TDA1tx
         FY3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnwXCxQUlBT4vfLnpn6sC+9P0/HVPaTykRurSAsUF+PDoMDuCfVTHMSWIk9taULVHFjJbpCUZ5HNd3s0mpax9OAQRf
X-Gm-Message-State: AOJu0Yy7CMCiNhrigeEInHlDpWE1wHP+yIR7kvA2g+CedMnI6POAW5mu
	1ES/ezGUi+ax7SNbiFESkezXZo7P+kOOACz8BrrpqTHkjdpA2chjSY7G3E8X3zI=
X-Google-Smtp-Source: AGHT+IGt8c1opA2C0E2P+eprQukXZvwDKiwEqHsjgv8cKHCpAIId2uP4LXTpSE8TtGpEs6s6Gm8EYw==
X-Received: by 2002:a0d:dd88:0:b0:61b:33b6:41dd with SMTP id g130-20020a0ddd88000000b0061b33b641ddmr176792ywe.37.1714671230104;
        Thu, 02 May 2024 10:33:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c62-20020a814e41000000b0061aea696527sm304916ywb.96.2024.05.02.10.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 10:33:49 -0700 (PDT)
Date: Thu, 2 May 2024 13:33:43 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Dhruva Krishnamurthy <dhruvakm@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: using tree as attribute source is slow, was Re: Help
 troubleshoot performance regression cloning with depth: git 2.44 vs git 2.42
Message-ID: <ZjPOd83r+tkmsv3o@nand.local>
References: <CAKOHPAn1btewYTdLYWpW+fOaXMY+JQZsLCQxUSwoUqnnFN_ohA@mail.gmail.com>
 <20240501220030.GA1442509@coredump.intra.peff.net>
 <ZjLfcCxjLq4o7hpw@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjLfcCxjLq4o7hpw@nand.local>

On Wed, May 01, 2024 at 08:33:52PM -0400, Taylor Blau wrote:
> On Wed, May 01, 2024 at 06:00:30PM -0400, Jeff King wrote:
> > Bisecting show the culprit is 2386535511 (attr: read attributes from
> > HEAD when bare repo, 2023-10-13), which is in v2.43.0. Before that, a
> > bare repository would only look for attributes in the info/attributes
> > file. But after, we look at the HEAD tree-ish, too. And pack-objects
> > will check the "delta" attribute for every path of every object we are
> > packing. And remember that in-tree lookups for foo/bar/baz require
> > looking not just for .gitattributes, but also foo/.gitattributes,
> > foo/bar/.gitattributes, and foo/bar/baz/.gitattributes.
>
> Thanks for the explanation and bisection. I agree that 2386535511 makes
> sense as a likely culprit given what you wrote here.

Here is one possible approach, which is a partial revert of 2386535511.
I thought about suggesting that we revert 2386535511 entirely, but I
think that may be too strong of an approach especially if there are
plans to otherwise improve the performance of attr lookups with some
caching layer.

Instead, this patch changes the behavior to only fallback to "HEAD" in
bare repositories from check-attr, but leaves pack-objects, archive, and
all other builtins alone.

I should note, this is a pretty hacky approach to use the extern'd
git_attr_tree variable from within the check-attr builtin, but I think
that this does do the trick.

Alternatively, if this is too hacky or magical that check-attr does one
thing but every other command does something else, I would personally be
fine with a full revert of 2386535511.

Anyway, here is the patch:

--- 8< ---

Subject: [PATCH] attr.c: only read attributes from HEAD via check-attr

This patch is a partial revert of commit 2386535511d (attr: read
attributes from HEAD when bare repo, 2023-10-13), which caused Git to
start reading from .gitattributes files from HEAD^{tree} when invoked in
a bare repository.

This patch has an unfortunate side-effect of significantly slowing down
pack-objects, for example, when invoked in a bare repository without
using reachability bitmaps.

Prior to 2386535511d, pack-objects would only look at the
info/attributes file when working in a bare repository. But after,
pack-objects ends up looking at every "delta" attribute not just in the
info/attributes file, but for every .gitattributes file in each tree
recursively from the root down to the dirname of whatever path we're
inspecting. In other words, gathering attributes for path foo/bar/baz
requires reading .gitattributes, foo/.gitattributes,
foo/bar/.gitattributes, and foo/bar/baz/.gitattributes.

Restore the pre-2386535511d behavior for commands other than check-attr
(which was the intended target of the change described in 2386535511d).

If we want to cause pack-objects to use HEAD^{tree} as an attributes
source in bare repositories by default again, it would likely come after
some caching layer to avoid the performance penalty.

Reported-by: Dhruva Krishnamurthy <dhruvakm@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 attr.c                  | 7 -------
 builtin/check-attr.c    | 2 ++
 t/t5001-archive-attr.sh | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/attr.c b/attr.c
index 7c380c17317..33473bdce01 100644
--- a/attr.c
+++ b/attr.c
@@ -1220,17 +1220,10 @@ static void compute_default_attr_source(struct object_id *attr_source)
 	if (!default_attr_source_tree_object_name && git_attr_tree) {
 		default_attr_source_tree_object_name = git_attr_tree;
 		ignore_bad_attr_tree = 1;
 	}

-	if (!default_attr_source_tree_object_name &&
-	    startup_info->have_repository &&
-	    is_bare_repository()) {
-		default_attr_source_tree_object_name = "HEAD";
-		ignore_bad_attr_tree = 1;
-	}
-
 	if (!default_attr_source_tree_object_name || !is_null_oid(attr_source))
 		return;

 	if (repo_get_oid_treeish(the_repository,
 				 default_attr_source_tree_object_name,
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index c1da1d184e9..9b445fe33c6 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -188,10 +188,12 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)

 	if (source) {
 		if (repo_get_oid_tree(the_repository, source, &initialized_oid))
 			die("%s: not a valid tree-ish source", source);
 		set_git_attr_source(source);
+	} else if (startup_info->have_repository && is_bare_repository()) {
+		git_attr_tree = "HEAD";
 	}

 	if (stdin_paths)
 		check_attr_stdin_paths(prefix, check, all_attrs);
 	else {
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index eaf959d8f63..0ff47a239db 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -136,11 +136,11 @@ test_expect_success 'git archive with worktree attributes, bare' '
 	(cd bare && git archive --worktree-attributes HEAD) >bare-worktree.tar &&
 	(mkdir bare-worktree && cd bare-worktree && "$TAR" xf -) <bare-worktree.tar
 '

 test_expect_missing	bare-worktree/ignored
-test_expect_missing	bare-worktree/ignored-by-tree
+test_expect_exists	bare-worktree/ignored-by-tree
 test_expect_exists	bare-worktree/ignored-by-worktree

 test_expect_success 'export-subst' '
 	git log "--pretty=format:A${SUBSTFORMAT}O" HEAD >substfile1.expected &&
 	test_cmp nosubstfile archive/nosubstfile &&
--
2.45.0.1.g3e84e921a0a.dirty

--- >8 ---

Thanks,
Taylor
