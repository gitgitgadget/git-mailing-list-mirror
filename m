Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74898314D07
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700516; cv=none; b=cYEGoI/AxZCz2SfOf1nG/VWvNE8/hWIBYY7qIebOQ+p3t4uxel7rFetls0aTpmigmQ0HvfYja8SGRYRf/B0Qk47EDa8X5dr4SdK5wJp6vCY8934wAqYOjUNocrHvGVjUlwT5oEEHijT4blvU9wQGpgut2u3wKnd4OnFfRVgikIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700516; c=relaxed/simple;
	bh=+hy1ZZpMpkcNIOMA4OccEWtvxcafbzDaPMN4jH1Ht7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EW9GILh/IegzhQBcvllipC94b2f/14h3D+kpO1QmCGvYb6l0zu4DzqMM9tKFAQprXf7EhGc2AN8j4SzcI91L1yDxKOKkeR7JPp3pL4uKm4vM2a+2ZbBswuTvz+EpQLcT4sPy5w1tVk78PeDF1iAD52GkSNj92wb2y1N0UxENBkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cuhBS5py; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xmYA6CiI; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cuhBS5py";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xmYA6CiI"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 8F64F1D000CF;
	Tue,  6 Jan 2026 06:55:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 06 Jan 2026 06:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767700512; x=1767786912; bh=cfKt/y1UMx
	hmm09aWZY2Hq1+qighWwJwFM90BAe3IIU=; b=cuhBS5pyUdklQ/jSStQFkCY496
	ZJOmRfydihuF9/+Z4QvO/yiDGsMgmkRm4TOFUOA7dX63ifjwnGRKaTMRy5w5DNKc
	FWLcnpDSwe/PKWTeHpxvnp+aBR0301EDukwzT3v2rM1rr5r+dcDuBhOI7SLTuYPe
	JV5X0S2FyY1KRn5xE3oEyuEIxWA6EiRV2OObbmtQ4p92mLnKDavTYzJB4tibDBPS
	FgAKhY8GChLawwIRjRtuZ6/YeHVqGYc4efoWW7Jasv+tBitdFWXNQzDKqx7GQyI+
	aIZdKxR8qh0JfrzaIxTPmtHs8vBpS1bBdXk/6kiNbMrUTfwZul+FpQYtIz6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767700512; x=1767786912; bh=cfKt/y1UMxhmm09aWZY2Hq1+qighWwJwFM9
	0BAe3IIU=; b=xmYA6CiIbDVoog9RGYWfshncGN+MeT5yx0Y52wu5s+Nmki+Fdms
	JeVoAKlQK/qPcSohSDE3qOK/OOhcs+9OnRanxzZhaMTc3BN/9IeUjBI7yUE7gA7W
	LVUX0U5H3uW1A03s2DOYvHIluE4KvhLqTCLnskiBrBjDb4OXX2GFKX1bZGCJK1Xc
	9p/+q1o9TpszQmEjHZQdwehQQaPmg5P1mtT0bXGqbWjMsi+CYvSolqqJvnLe3Tc5
	pg6tLOwoeFxb52AGZY177F8mdUCOW4fWhNBbvXYIia5QhYMNDUTyGjafa9IihZw4
	8G94rpPZh5byvm7NkNOH5gozu1vYIbAtFqQ==
X-ME-Sender: <xms:IPhcaRQLxCNrGOzbV7eRVvNxZO61iWboMHV_vzal8YyfRXd7gyJD9g>
    <xme:IPhcaRxwC047mKE75McKjfjOphhxiMRB6JNPpUj9yRUBLvqtLlfgjtcVmFWePTcgu
    v5V6YmWhUgR9WRseNhhDyVdraOucWPP_DkjkwIQV7t-QjvEsG8zAA>
X-ME-Received: <xmr:IPhcab3xUZGJXIY9EwUiDW49RXTMRSLG-N3JgqT-ZqlXhYdsH6doEkAxdEh75ynL2FYGU1T7s-_s2kzncuZ0QOunbelyGGdXtuB1mhhX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekgeeuhfdtveelvdeiffeitdegleehjeehueeludetiefhgfduveeghffftefgnecu
    ffhomhgrihhnpegtohhmmhhithdqghhrrghphhdrrghuthhonecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhn
    vggtohdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:IPhcaX7JbxixZTsyuvpw4SA55NJEBcqYN00UJOv2UZaRFJFyFiUDLw>
    <xmx:IPhcaWU0CYj5kzqJjqPyCtwLcuKwFbXJRNV0qNc8OzPRvFZvyxA2dg>
    <xmx:IPhcaeBasGIuG3_PDe01jbeQ6LIBtZ3Vw3Scm_LDFojznnXAPHrsYQ>
    <xmx:IPhcad4EJwWoCFiHukKng0sD8rPOTbT_NeyD313BockhlJuZ-jsijw>
    <xmx:IPhcaTXGUKk70fwvpFQSHDL34e98oz1FixlPXLlVdXIRzvTcp-WB46hp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 06:55:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 377bb227 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 11:55:09 +0000 (UTC)
Date: Tue, 6 Jan 2026 12:55:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/2] builtin/gc: fix condition for whether to write
 commit graphs
Message-ID: <aVz4G-gRf-mA2N56@pks.im>
References: <20251211-odb-related-fixes-v2-0-bdf875ce51fc@pks.im>
 <20251211-odb-related-fixes-v2-1-bdf875ce51fc@pks.im>
 <CAOLa=ZSZ9PKCi=vQY8WKhwAHVZT-keA5XOXBMVrB4ZW+u2uNhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSZ9PKCi=vQY8WKhwAHVZT-keA5XOXBMVrB4ZW+u2uNhg@mail.gmail.com>

On Tue, Jan 06, 2026 at 03:27:29AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > When performing auto-maintenance we check whether commit graphs need to
> > be generated by counting the number of commits that are reachable by any
> > reference, but not covered by a commit graph. This search is performed
> > by iterating through all references and then doing a depth-first search
> > until we have found enough commits that are not present in the commit
> > graph.
> >
> > This logic has a memory leak though:
> >
> >   Direct leak of 16 byte(s) in 1 object(s) allocated from:
> >       #0 0x55555562e433 in malloc (git+0xda433)
> >       #1 0x555555964322 in do_xmalloc ../wrapper.c:55:8
> >       #2 0x5555559642e6 in xmalloc ../wrapper.c:76:9
> >       #3 0x55555579bf29 in commit_list_append ../commit.c:1872:35
> >       #4 0x55555569f160 in dfs_on_ref ../builtin/gc.c:1165:4
> >       #5 0x5555558c33fd in do_for_each_ref_iterator ../refs/iterator.c:431:12
> >       #6 0x5555558af520 in do_for_each_ref ../refs.c:1828:9
> >       #7 0x5555558ac317 in refs_for_each_ref ../refs.c:1833:9
> >       #8 0x55555569e207 in should_write_commit_graph ../builtin/gc.c:1188:11
> >       #9 0x55555569c915 in maintenance_is_needed ../builtin/gc.c:3492:8
> >       #10 0x55555569b76a in cmd_maintenance ../builtin/gc.c:3542:9
> >       #11 0x55555575166a in run_builtin ../git.c:506:11
> >       #12 0x5555557502f0 in handle_builtin ../git.c:779:9
> >       #13 0x555555751127 in run_argv ../git.c:862:4
> >       #14 0x55555575007b in cmd_main ../git.c:984:19
> >       #15 0x5555557523aa in main ../common-main.c:9:11
> >       #16 0x7ffff7a2a4d7 in __libc_start_call_main (/nix/store/xx7cm72qy2c0643cm1ipngd87aqwkcdp-glibc-2.40-66/lib/libc.so.6+0x2a4d7) (BuildId: cddea92d6cba8333be952b5a02fd47d61054c5ab)
> >       #17 0x7ffff7a2a59a in __libc_start_main@GLIBC_2.2.5 (/nix/store/xx7cm72qy2c0643cm1ipngd87aqwkcdp-glibc-2.40-66/lib/libc.so.6+0x2a59a) (BuildId: cddea92d6cba8333be952b5a02fd47d61054c5ab)
> >       #18 0x5555555f0934 in _start (git+0x9c934)
> >
> > The root cause of this memory leak is our use of `commit_list_append()`.
> > This function expects as parameters the item to append and the _tail_ of
> > the list to append. This tail will then be overwritten with the new tail
> > of the list so that it can be used in subsequent calls. But we call it
> > with `commit_list_append(parent->item, &stack)`, so we end up losing
> > everything but the new item.
> >
> > This issue only surfaces when counting merge commits. Next to being a
> > memory leak, it also shows that we're in fact miscounting as we only
> > respect children of the last parent. All previous parents are discarded,
> > so their children will be disregarded unless they are hit via another
> > reference.
> 
> Yikes. So we never go down the path of the first N-1 parents? Does that
> inversely mean, commit-graph generation would be slower now in
> repositories with lots of merges, since it is fixed to follow all paths
> correctly?

Yeah, this was quite broken indeed. I don't think that the fixed walk
should result in a significant slowdown:

  - We stop walking the parent chain whenever we see a commit that is
    covered by the commit-graph.

  - And our walk of commits that are not covered by the commit-graph is
    bounded by "maintenance.commit-graph.auto", which defaults to 100
    commits.

So in practice, the cost should be negligible.

There's going to be some exceptions thoulgh. Most importantly, the
complexity of the computation scales directly with the number of refs as
we use `refs_for_each_ref()`. So if you have a gazillion refs I'd expect
the performance impact to become noticeable. But that's already been the
case before this commit.

We may want to revisit this in the future if we ever notice that this
does become an issue.

> > While crafting a test case for the issue I was puzzled that I couldn't
> > establish the proper border at which the auto-condition would be
> > fulfilled. As it turns out, there's another bug: if an object is at the
> > tip of any reference we don't mark it as seen. Consequently, if it is
> > reachable via any other reference, we'd count that object twice.
> >
> 
> So if an object is at the tip of N references, we'd count it N times
> right?

Yeah, exactly. Let me rephrase that slightly.

> > diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> > index 6b36f52df7..a2b4403595 100755
> > --- a/t/t7900-maintenance.sh
> > +++ b/t/t7900-maintenance.sh
> > @@ -206,6 +206,31 @@ test_expect_success 'commit-graph auto condition' '
> >  	test_subcommand $COMMIT_GRAPH_WRITE <cg-two-satisfied.txt
> >  '
> >
> > +test_expect_success 'commit-graph auto condition with merges' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		git config set maintenance.auto false &&
> > +		git commit --allow-empty -m initial &&
> > +		git switch --create feature &&
> > +		git commit --allow-empty -m feature-1 &&
> > +		git commit --allow-empty -m feature-2 &&
> > +		git switch - &&
> > +		git commit --allow-empty -m main-1 &&
> > +		git commit --allow-empty -m main-2 &&
> > +		git merge feature &&
> > +
> > +		# We have 6 commit, none of which are covered by a commit
> > +		# graph. So this must be the boundary at which we start to
> > +		# perform maintenance.
> > +		test_must_fail git -c maintenance.commit-graph.auto=7 \
> > +			maintenance is-needed --auto --task=commit-graph &&
> > +		git -c maintenance.commit-graph.auto=6 \
> > +			maintenance is-needed --auto --task=commit-graph
> > +	)
> > +'
> > +
> 
> This doesn't test the fix around double-counting tip objects, no?

Hm, true. I initially used `test_commit()` here, which uncovered the
double-counting as it creates lightweight tags by default. Let me revert
back to use that function so that we exercise this again.

Thanks!

Patrick
