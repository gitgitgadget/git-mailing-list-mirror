Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE14B1DE2B5
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175873; cv=none; b=hW6TwdH59ce2EmgR0zxWrhpyBIA4QCC99AYm28MUrfk4QVW/KxBt/5Cor+B75P/4R6rD+mANQQpDzziRd/91eb1Rni2wHLP/R+5KOulTk1SryPJrR2sqw9MkR56aeuOX7jQSizQ5iTlMzfcmaQ3Di8fd7agpcSJmvbzNUTfwhv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175873; c=relaxed/simple;
	bh=rijwRUiJyjEX4hcfG3dSJ5G2UEUqv7VuepRVtQIyAQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ekm9YuYQzkJOqph4Ouhopg53AglgnxXJzjC2i+KiJZTO4eVdMOFwQha3+4ic86fgUzBEhAbCcPPlL8Sn0Y85+hpVYGyYfxIGsWyQ/XsaOjL4OtUGSn2uCXwLRu6nMl46L4wdHgEC143GquEfKGG4OAyf3tre/u1nSyiizOzPTU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UL3YnhjZ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UL3YnhjZ"
Received: (qmail 27101 invoked by uid 109); 22 Jul 2025 09:17:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=rijwRUiJyjEX4hcfG3dSJ5G2UEUqv7VuepRVtQIyAQc=; b=UL3YnhjZ5K0DnYPTNEapmgjeaMUaIO3G5mgoKfRRdC1n7elZ4G2nWRhywceIEWb7TsWFadzc4YQZOhsHMT1EdlqdSl0io4V03YUwuZvzvE3MGnQZFT/qZdXUSPAW8en7zrF9cQ1nDCp8zJ9q2Zf9rz/clv9llhkl9Smg6040kTyI7SNuYbfSVck/I1SWDF0ieAiUj4emv5yyFSEWAoLvCW2pWCF0Pc+cWdDdcO8Dq5sTgSERhWAv7UpsjJTl0hjfp8zSHHuS3Gx4opMIZ/rvyrFlT6vM8FZ7IHHkvacPho0Tlia+Ke8fR6/+ocxZSEQM98mTdx+HM7nOjAecpsFkgQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jul 2025 09:17:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27191 invoked by uid 111); 22 Jul 2025 09:17:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jul 2025 05:17:55 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 22 Jul 2025 05:17:49 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= <dilyan.palauzov@aegee.org>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: git treeless-clone + wait =?utf-8?Q?+_?=
 =?utf-8?B?cHVsbCDihpIgcHJvYmxlbSwgYWdhaW4gcHVsbCDihpI=?= OK
Message-ID: <20250722091749.GA864077@coredump.intra.peff.net>
References: <e7a2fdff63d9a90ef4dc1341fa642fff5197b64a.camel@aegee.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7a2fdff63d9a90ef4dc1341fa642fff5197b64a.camel@aegee.org>

[+cc Jonathan Tan]

On Tue, Jul 01, 2025 at 12:24:05PM +0300, Дилян Палаузов wrote:

> the problem is that when I do a treeless or blobless clone and some
> time later git pull, git prints many, many lines that it tries to
> fetch data, then I interrupt with Ctrl+C, then do git pull again and
> then it completes.  However I never tried to precisely document this
> until now:
> 
> On 26 June 2025 I do
> 
> $ git clone --filter=tree:0 https://github.com/git/git.git
> …
> $ git show --oneline
> cf6f63ea6 (HEAD -> master, origin/master, origin/HEAD) The fourth batch
> 
> 
> Today I do 
> 
> $ git pull
> From https://github.com/git/git
>    cf6f63ea6..83014dc05  master     -> origin/master
>    74e6fc65d..83e99ddf4  next       -> origin/next
>  + bc3287e71...a842a7780 seen       -> origin/seen  (forced update)
>    fefffbb31..7af8e2e03  todo       -> origin/todo
> fatal: You are attempting to fetch cf6f63ea6bf35173e02e18bdc6a4ba41288acff9, which is in the commit graph file but not in the object database.
> This is probably due to repo corruption.
> If you are attempting to repair this repo corruption by refetching the missing object, use 'git fetch --refetch' with the missing object.
> fatal: could not fetch 5e66731277a4d791043dc51e2804dc0b496c523b from promisor remote

I took a look at this a few weeks ago and came up with a reproducible
recipe:

  git init repo
  cd repo

  url=https://github.com/git/git.git
  git fetch --filter=tree:0 $url cf6f63ea6bf35173e02e18bdc6a4ba41288acff9:refs/heads/foo
  git checkout foo
  git commit-graph write --reachable
  git fetch $url

That final fetch ends up spawning a seemingly endless (though I suspect
actually finite) series of child fetches. Looking at the callstack, it's
coming from fetch_submodules(), which wants to do tree diffs in the
fetched history looking for changed submodules. But of course we don't
have those trees, so we fault them in one by one.

Which certainly seems non-ideal. But what is more interesting is that
while doing so, we eventually hit that same fatal error:

  fatal: You are attempting to fetch cf6f63ea6bf35173e02e18bdc6a4ba41288acff9, which is in the commit graph file but not in the object database.

I tried swapping out $url for a local copy of the repo (to stop
hammering poor GitHub's servers). But it doesn't seem to reproduce. That
plus the apparently-random time of failure makes me think it's a race
condition.

And there is something interesting happening in the background here:
each of those sub-fetches may kick off an asynchronous "git maintenance"
run. Which will find something useful to do because we're building up a
big pile of packs. So it eventually tries to repack.

And so it seems our race is that fetch sees the commit in the commit
graph but sometimes _not_ the actual packfile (because it got repacked).
Usually we'd try to re-scan the packfiles for exactly this case. But the
caller in deref_without_lazy_fetch() does not do so. It calls
has_object() without any flags, avoiding the re-scan, like this:

          commit = lookup_commit_in_graph(the_repository, oid);
          if (commit) {
                  if (mark_tags_complete_and_check_obj_db) {
                          if (!odb_has_object(the_repository->objects, oid, 0))
                                  die_in_commit_graph_only(oid);
                  }
                  return commit;
          }

This is due to 5d4cc78f72 (fetch-pack: die if in commit graph but not
obj db, 2024-11-05). I'm not sure I fully understand all of the details
of that commit, so I don't have a solution. Maybe it should be passing
HAS_OBJECT_RECHECK_PACKED?

Normally I'd worry about performance, since fetch is often asking about
objects we don't expect to have (and that re-scan is expensive and
normally just confirms that no, we don't have the object). But in this
case we'll only hit this check if we called lookup_commit_in_graph().
Which implies we _do_ expect to have it (or it's a weird state where the
graph file is stale). So maybe it would be OK to use that flag in this
call?


I don't think this race is strictly limited to using filters. It's just
that it's a convenient way to start a big string of fetches that will
race with repacks.

Whether or not fetch should avoid kicking off that big string of
fetches, I don't know. Passing --no-recurse-submodules obviously dulls
the pain. Perhaps the default behavior ought to be different in a
tree-less repo. Or maybe those tree diffs should be done with
lazy-fetching turned off (there is no point in recursing for a version
of a submodule whose parent tree we don't even have!). But I think
that's all orthogonal to the race.

Hmm. So I actually was just intending to write up my notes from a few
weeks ago. But I think I may have talked myself into the idea that this
patch is the right fix:

diff --git a/fetch-pack.c b/fetch-pack.c
index 5e74235fc0..7288e2d251 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -142,7 +142,8 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
 	commit = lookup_commit_in_graph(the_repository, oid);
 	if (commit) {
 		if (mark_tags_complete_and_check_obj_db) {
-			if (!odb_has_object(the_repository->objects, oid, 0))
+			if (!odb_has_object(the_repository->objects, oid,
+					    HAS_OBJECT_RECHECK_PACKED))
 				die_in_commit_graph_only(oid);
 		}
 		return commit;

I'd like to hear what Jonathan Tan thinks, though.

-Peff
