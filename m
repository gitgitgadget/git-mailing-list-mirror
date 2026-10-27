Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084591;
	b=3E3uxV+o4o7aqbmCflYz5/1dWAX5Gr5mCd5ERIKQU9qUaxW6HT477/qygkWE5V5RviTq
	 ploDFf/UloIh28r11ZuZXOdV7BTPeHk45oXPPhQt98n3b+wbqDjl+EhAd+PmaLrK/YpVs
	 VjQLJweeJCR953McnxTES2vohwJGxWk336Q+OUR3A4SHV09YhjAgWD4Orx/fllbk55ke/
	 EpSHGh5fFDEmf57y80ipVxabpYOdJD8Hg4BD0k2ZdLLKmYHJgpAxd51Q/HcJ9D4ujWV6B
	 gnPbb2/lHGVNFqtlxDvLdWxAQIYb+7CNRHxf0kvuqyDZlE8J3iXL+SHv28tSl/SfVvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084591;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CrEe0QdHldRCtHNuwmrX2oKEpg1GgsKdLEZ5BUUmDo4=;
	b=GFqZgdG++ORY2ZuTZEIsNJYehwP7yg5rL5OA5lo6StyK0/IoQBkOEkFwMzp6dgn9YibW
	 yH3ZMzJ3TtfCh5AuloSLEPAacTbbMNAj8igSHIyHT1xhyLPHPmal0Lqzd4tOzAgcsuPcm
	 GgXjUfHPD9HUPR0riEXINdtXeWvm0EJz/g01t9JayAkX7MeK9E95yEZcLhcn4TRLCgUnV
	 CpGgABwixdXpxV46RjKXtOV7UhtILxPS6/PQilMEPV6K/qlVkS+KpB82tWnPdd5jb2jEl
	 6fLmuI6xdBldFUAczM/+tbb7ssRfO/llkMxd7kbsZKE7gSSGmty57nsmaAG4+ZAKlhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=p7sZOl6Q;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=pN7oSg+i;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDF6606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 07:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEDF6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=p7sZOl6Q;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=pN7oSg+i
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 38E9D7A00A7
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 03:03:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 27 Oct 2026 03:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793084590; x=1793170990; bh=CrEe0QdHld
	RCtHNuwmrX2oKEpg1GgsKdLEZ5BUUmDo4=; b=p7sZOl6QRrlOs5PuRnsnu+4aW6
	VxPkA7sYrZNE2WGb7cLhs+IphlCTQJV2coMwZJuJPiK08y8PqfogWhdAsKyZnIAn
	xPKSL1n/R9TXbRXCa8mt0R3iGpngLToYDaqvhpmfBuLFFn326o0Am0No0X2xG+i3
	vWnFHKY8knsnWoNICjStE3Tx5WpMcdisd0NkTW16shqtoOdPLUmsnqklQ6OWCJcJ
	crv9lYXX7zw+TyJb9e3QEc39O4gAIv8o4eEKhHh4+8p0BN8YLZu//VmmTG3HZGY0
	yfcDECgByQfz0q9vuKx+JRqEJRXvlcB2DQymd6rB6Ldi9IucPfEUOL25bpsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793084590; x=1793170990; bh=CrEe0QdHldRCtHNuwmrX2oKEpg1GgsKdLEZ
	5BUUmDo4=; b=pN7oSg+iH3qTzA+tPxZKDBgckJAma0zApKJwkdNVZPsyy+AD8EF
	ea+jeBF5U0JbN51GHY/hWJiJaW3DsgKHJCiQQM52bd5KeuhxoGx/1vORE0UVsd0t
	klyUUyS1nNWCAL9jD1zGnknt5qaUNfcLBahUREJlzyNtTC7S0e+sJ6uk9dLzwFIL
	czi3WpgaHpnPc/oDRX6t4My+xNDI6FdtT7rFEAdcupjI0FJMv0AY1PLUxeuS/8wD
	nbtikxgnUbR2p0VI1/mbXgVfYffSI2spmZdeMtAVZTPrDgwslmMOhH/RaDLIghBf
	Vlant0g1Q5ssMgTMfjoBWiPpl4c+rVeNnfA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793084590; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:F4oigAjI/KxK5dSD118C6A+8gwOtMZkMWyxJ81YXkMFkXtl
	VPCbS69z+stVO0IVBe0hCPueJupBj8AcT3gbtYTQ0ZsBhpo7njqwygFSnlZ0R9aq
	kG7ng+4m3Y5jwwipyAQbF7SHVY1omT2Qj4G3kWSq6sFMUU+XPIlsz9RiKPhReAWb
	UA7bPblAW8gRZwVzuvEUOZrpiC9RiwD2tLfe+C17IgmCdPeyqhk1tKfKbtxAnCVZ
	HHs41jwoTv1WKM3W4j7+yNSwCoRVxsNmcqJI35XUIVWzAYK+D1zno7lUfY6F2NOz
	O+Yhg4bVkjfnF56J+hiDk0beRlt7dHlkzERX2eQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:fo/2HdoXAf6n6tUYd2Fg8+EPEffuuQuaSv4yGKLzRtk=:geeqiyk4FSOWi6AJqwG/KuptWGs2lilbs8QukTA/C+w=;
X-ME-Sender: <xms:rUzgapnevM-BLYxTXR5lFlRKO0zFJWaNr51VQEIEWkbvopoDS-Snwg>
    <xme:rUzgaq3cB98n0m-SVvUXVoCAqPkQW7d3eMUaZCgEIs16E8EItbSHvR-xBYeOHw5AP
    W7qgJyKOELeBPQISP70AAGMYzYUGS-6CH8Xc2DSCibFkdNr8qGOM7c>
X-ME-Received: <xmr:rUzgatRZYbCqWw8ioCQhkTlOE7NU3nR7IAtSKeGk3T1sjvP1CZkauQ>
X-ME-Proxy-Cause: dmFkZTFMaUyysz+NBAlNuntVBAiZegYd2z9Dk5NcmPAv2gD9Iqtv+J5oipTBFidCLutodY
    CPVo/rJo/nASmps/lY5sFexVo+qBPytXgFUkN2s1dvhrMOCOeEdfRfDB3k9SKtU7TIOvCV
    fO0KH8t+knr3EktjOC8EBRv0phAVxmfE16U2QFC3QYiMi9IPGWPO1oJId+DCrTXmG0kO8d
    ekWKYsXXILyIoWsDQe/lcHks/C5pAIZcddz2M+/yb5TYSbaDTruEkoIuVLdUw+cjQxcr3P
    zZsjzQNpkb4Tua8TbAOV9gG6H/TNUE23xV6dr31cRgaw4J7kZBailVghSClAgEQNPuOVi+
    tzH+3UeN0oXjtaS/qnZx/QGfe8d5DAivpYagIG80CmL2E7hJb69KAjpdrRhaVniy41nUrP
    MeAJxYyZ2DKGBF8ECG1eyE/O8RFrwWShE5Ek6NWm80rLFwULfhEiJyKh7Or/itM3qkhauB
    nW/Yt9gzirw41Q2EwE863lz7qKAq0gI/owt7ZSd1mD1KRgDjRDwXPY4I0v3pYQNkphIqMQ
    FWextlDWiVYQAuATPsdZE0sEmUXBuso/425iytDz8V4Gd7Xfl/jie8P27BsxC653gnd2Wi
    4b/UpY/WbdQizJzFdD+GcK8fKwC+ZUq1QcsbVKMzGNbCronFlS10FvNVzoAQ
X-ME-Proxy: <xmx:rUzgaksAcl_S1DannrbLILL6tO3fiUFGMg74R1Cy06xM0c9_WNJA-w>
    <xmx:rkzgaqb_t0iJvo_2BSoOJ5conwbPkMcK44D0C31oRvfSWfvXjjoD0g>
    <xmx:rkzgahvppoQfN2-tz6q7Rl-IKbvXBSNJng4hMG6uLq7_0f4v9Y9EBg>
    <xmx:rkzgakE1-JpSOai-ml4Xki4LCgBiJnlZmeBfvTj1Qr__FqAb3UAyHw>
    <xmx:rkzgaiVbbsQCGl1oyeL-g8ek8frch6AydmPqL_2hoUZOJRmwfg9qsfU8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 03:03:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id be9ba552 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 07:03:08 +0000 (UTC)
Date: Tue, 27 Oct 2026 08:03:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Daniel Zoghalchali <daniel@latchkey.dev>
Cc: git@vger.kernel.org
Subject: Re: [BUG] 2.56.0: filtered --unshallow of a moved ref aborts in
 pack-objects (should_include_obj) via inherited GIT_SHALLOW_FILE
Message-ID: <auBMqRatQLqerRte@pks.im>
References: <CAJwQ=KQynymg4CJOLkyebACYVQa+LhXB2UifniTASkLyArWejA@mail.gmail.com>
 <at9P0ctULX1BBD8y@pks.im>
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
In-Reply-To: <at9P0ctULX1BBD8y@pks.im>

On Mon, Oct 26, 2026 at 02:04:30PM +0100, Patrick Steinhardt wrote:
> On Sat, Oct 24, 2026 at 10:59:55AM -0700, Daniel Zoghalchali wrote:
> > Hi,
> > 
> > Since v2.56.0, a fetch that combines a tree filter with --unshallow
> > (or --deepen) aborts in a non-partial shallow clone when the fetched
> > ref has moved past the local tip:
> > 
> >   BUG: builtin/pack-objects.c:5098: should_include_obj should only be
> > called on existing objects
> >   error: pack-objects died of signal 6
> >   fatal: could not finish pack-objects to repack local links
> >   fatal: index-pack failed
> > 
> > v2.55.0 completes the same fetch. We hit it in CI, where a job checks
> > out a single commit at depth 1 and then unshallows its branch, which
> > by then has moved on.
> > 
> > Reproduction (offline, any Linux):
> > 
> >   set -e
> >   W=$(mktemp -d); cd "$W"
> >   git init -q -b dev seed
> >   for i in 1 2 3 4; do
> >     mkdir -p seed/src; echo "$i" > seed/src/f.txt
> >     git -C seed add -A
> >     git -C seed -c user.name=t -c user.email=t@t \
> >       commit -q -m "c$i"
> >   done
> >   git init -q --bare o.git
> >   git -C seed push -q "$W/o.git" dev
> >   git -C o.git config uploadpack.allowFilter true
> >   git -C o.git config uploadpack.allowAnySHA1InWant true
> >   git init -q co
> >   git -C co remote add origin "file://$W/o.git"
> >   TIP1=$(git -C seed rev-parse dev~1)
> >   git -C co fetch -q --no-tags --depth=1 origin \
> >     "+$TIP1:refs/remotes/origin/dev"
> >   git -C co checkout -q -B dev refs/remotes/origin/dev
> >   git -C co fetch --no-tags --filter=tree:0 --unshallow origin \
> >     +refs/heads/dev:refs/remotes/origin/dev
> 
> Thanks, this reproducer works for me.
> 
> > The last command dies as above with 2.56.0, both Ubuntu 24.04's
> > git-core PPA build (1:2.56.0-0ppa1~ubuntu24.04.2) and v2.56.0 built
> > from source. It succeeds with v2.55.0 built from source. With 2.56.0
> > it also succeeds when dev has not moved past the checkout, with
> > --filter=blob:none, or without a filter. --deepen=N with the same
> > filter aborts the same way.
> > 
> > What happens:
> > - fetch-pack runs "git --shallow-file '' index-pack --promisor ...".
> > - The pack names the local tip as the parent of the new dev commit, so
> >   index-pack's repack_local_links() starts "git pack-objects
> >   --exclude-promisor-objects-best-effort".
> > - Since d43b9acb05 (setup: unify setup of shallow file), --shallow-file
> >   is applied by exporting GIT_SHALLOW_FILE, so that grandchild inherits
> >   the empty shallow file.
> > - The grandchild no longer treats the local tip as a shallow boundary.
> >   It walks to the tip's parent, a promisor commit fetched without trees,
> >   and is_not_in_promisor_pack_obj() hits the BUG on that parent's
> >   missing root tree.
> > - Before d43b9acb05, the grandchild read $GIT_DIR/shallow and stopped at
> >   the tip.
> > 
> > To confirm this, we wrapped only the repack child. Unsetting
> > GIT_SHALLOW_FILE for it makes 2.56.0 pass, and setting
> > GIT_SHALLOW_FILE= for it makes 2.55.0 fail the same way, at its
> > builtin/pack-objects.c:5004.
> 
> Makes sense. Even though I think that the bug isn't actually that we
> started propagating GIT_SHALLOW_FILE, as we now basically behave like we
> do it with all other global variables, too. And if we were to execute a
> non-local command like git-receive-pack(1) we already know to unset that
> value again via `local_repo_env`.
> 
> What's fishy is "builtin/pack-objects.c:is_not_in_promisor_pack_obj()",
> which explicitly checks whether a given object is in a promisor or not.
> But in the case where we assume that an object may be a promisor object
> we know that we're running in a repostitory that may not even have all
> of its objects in the first place -- that's the whole ponit of a partial
> clone after all. But when `odb_read_object_info_ext()` returns an error
> we simply `BUG()` right away, which does not make any sense to me.
> 
> > Separately, the BUG() is reachable without the environment change. On
> > 2.55.0, a filtered --unshallow of the local tip, followed by a
> > filtered fetch of a moved ref, also dies there, because the walk from
> > the local tip reaches promisor commits whose trees were never fetched.
> 
> Yeah, this bug has the same root cause and I was able to reproduce it,
> too. And indeed it confirms my above take as it already exists before
> the change to how we propagate GIT_SHALLOW_FILE. So overall, I think the
> fix is as simple as this:
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index ca3a891dfbc..e634173fb1f 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -5085,7 +5085,7 @@ static int is_not_in_promisor_pack_obj(struct object *obj, void *data UNUSED)
>         };
> 
>         if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info, 0))
> -               BUG("should_include_obj should only be called on existing objects");
> +               return 0;
>         return source_info.source->type != ODB_SOURCE_PACKED || !source_info.u.packed.pack->pack_promisor;
>  }
> 
> I'll think a bit more about this and send a patch tomorrow. Thanks!

And here it is: <20261027-b4-pks-pack-objects-repack-links-with-missing-objects-v1-1-f50f90651274@pks.im>

Patrick
