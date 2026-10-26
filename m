Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019883;
	b=17wuyMXjg50J5X0ITykFZ5qDX/2Qceh9vEPjYgAwXEYRShdYUAT0e3xS0HwUrQ79LsmI
	 lt4arCSGvECwdY8LgHzyXSxB3IPYhGhPipQExteSrS0DrlP3wN0PR1G7wkqSWuf6jrKIv
	 ww8YnBIjf2mhW9OueeMcCwHEWPOTXbFmlGQQ+n6iYLbBrkp/pGpMtldzNqQtzK4DXTwPa
	 DGFEBak8Qj2Ix/cOJmytxC/EbSlGORsMyjSP6rt+kjaAEe50K3niLkv90q0OZ+f0VQBpO
	 rTP2rErJAuRDew5mojJXZv0gfulxXMwi4TeeHK8Q4LGjfJvAvvjdh/cXugdWNMdLjKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019883;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NucSRFLYXbjUAsmmKQXfGPjDcE86IrbRn44IFAgDDb8=;
	b=TMgiSLQRS9rl/KyLUGKmvphfqmhr7IIQlNTnAPDoyaspWuzjXkyDxVg/yRF/1ZJXjSSD
	 RJ04TNfCjXIrLSGWML+qBDxzWBx0JI86bPKMZqkDOjhDRDeDcWnfABU2RACeS3jK/WX9f
	 oGLj+BKBgNlOb+sp2r72E/wcnvK7+/qQidHnFw72l63JP2wZNHmHNGQFVEFXkYlcAHw6t
	 gMzzRJRVSQF4VpE1hJPowo4haXW9iVEjkV28DfhiwkPLtaY0k5GU1s0o0YjDHN+1bxhYk
	 5J1laLFKzPGZsfdmubRFkYO3MltcGxfKj3eArA6F5o8+/kT6FUgz4V2AZKGgogjqeVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=temperror header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=jHM+gqyu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bQN3fKGV;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7196C606A335
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7196C606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=jHM+gqyu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bQN3fKGV
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A1A441400A1C
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 09:04:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 26 Oct 2026 09:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793019876; x=1793106276; bh=NucSRFLYXb
	jUAsmmKQXfGPjDcE86IrbRn44IFAgDDb8=; b=jHM+gqyuggUUJMKkydnumkELzq
	r43S/TKR2TmRdZu+2oECKclAA9xANajq+c41C+fmWc1BLRMaecAhQUeb7eK/WUo1
	u6m1244WZxo5/T+/LybZn+MMzwpFGnnOfNagr4db3H7psZTXqiUW3aMzs0Oiti4O
	zARKEhNtg8yvAtTIO2Joszyb28pDooh2MC1yJxAgJ7SDRekuN7Xa7vVY7N29obyz
	N2qzzRcjQLilzmsXvyZWvItUKxwvsFlcwxxufAN5xsmPHpZJ9/1UVEEiYhr/q5Ro
	9Gtp9WU0RfprhWhuODfZzjbbwWyJshcwbWuYg/fiTuwFhNHWxtpUFxRzt8sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793019876; x=1793106276; bh=NucSRFLYXbjUAsmmKQXfGPjDcE86IrbRn44
	IFAgDDb8=; b=bQN3fKGVLrrYTN5Ur8AZAdC0/Krx+pgHBSuorB2wn9zit51yWe+
	uDEaOkA4uIzAFkJXH1fvgtDn3eQq1U/gB9mnHGVBwcm4Qx8KvATvoyP7xa90zG/I
	cEwMaG5hQKapmCqH3sJXVXP1qo9vaCBjfxqR2u8xZimlcMi771A76nYnf/LPv5q6
	38RI/FyHXdef/EVuMXMH5FJ0TVA5Rc8F35NSTKeRvG7mpSynp4/URvdQBqduNHD5
	/6TmwUT0d7g5VhZC1O+DTEjopAs3UXehNyVywoCdw8nOtRvILjYzCDIeCALj4u4m
	XHjwHI14A3WF6qNeH6kSn7XqFkuHearyv8g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793019876; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:TZXO84wnqIUQ0cWrHSyDrYq6oNGjlo3Zt0YtogqM3POT/H+
	tuIi1/Xvmiziy+yx35gUJ73fbDSBwg9HbO/5k4V2O67K+Ur+DOoozD2hdJhhtQuB
	sK2gJsgSDIpvv+6hmskTzJSPWMvCelr/qRx6OEaH5Qj4gtM9yXTt0DRR2er1vatt
	o4hLrNBpDj+J4cVCmTEVoEc4HMvPKn81rYoqI5M6+wLuCsNJlVQsnYys31gxAWRO
	XRbOnOTuWjVzJW/zuqI5JxHQdkEbjivYVSx20rTW4dHIH7SGNXTmwCs9ghamao3g
	/Soc2c+wJgNzyuTo1dw6F5cvHxE3Zaqz8zqynfQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:a0l/YCXjrhYPYPVIyWYyWSsJXUeyl73LI2uRg+c09Qk=:pOe6oQ0r3KsqNNFJHbiwsEx7UljZIMJVTDvqGXm0B8U=;
X-ME-Sender: <xms:5E_fasfA0FcCfY9WZjS3_qIfFT4eqtsghqFD0dZGwwHn6YXAoQjKVw>
    <xme:5E_fakN-HBOIcb7AM-2OsLnRc4xt6Dx9uOuVTQQQgHr1B_0I0oclv2QLIQkC5iQsW
    zQFYvfYTbrKs0xp7YYJZrkiUpqK2f-Bkt9kwijKtHwHyQRM-Tx5>
X-ME-Received: <xmr:5E_farLqnnAyo05ktpI2wYO23yCatuPt4QKqHo4kr7B-Lf_Q6siSeA>
X-ME-Proxy-Cause: dmFkZTGxZyfN4A92yK1jhM5Qj/59U7q6xfMAOu0KuNFM85IU8fpQx61vGeNy4k+veLiH9g
    XhXMAgf3LqTthesFrbG9PNFUy+/bmitU4f1FgkeTBHu7CljtiNwveefr10UKGuBmbBzOFd
    vc08uXlOWshARTuhW/6ALI+tAzgLibtz6Yd/FHXYxSVwbJXZPz6xjqn9pWwh4d56TE+gfj
    7bZ0f2u1pe/ETDVW4GVv9qrfw+AYkGBV4a0zXU198Qal7GrXe+zOu82h/IuHWkxh2Bcv12
    5lPMv3w430jwXohhvmzyV95l6aQXPrPDqr35Z4v7Q7np0m8uuIS4A4zjH/bDQh+vAqbcZt
    yAm0YLDAsYPJMiyS3z3P18xCiDwFyNtVGc6dNpVdLnpom9/FnmSP+OsubRrMfq4aBXQvyW
    1QxEji44uoD8OoLCOE3bmJjPYi4kdWZmNjdNc70tayw1cSQ60UUeMoMk5QLVmONgLeg67D
    1+T4oXDbvU1I9EWLn6NVN62Qz2oKpBPqURkAdIQ0j19wnBCKCimi3LLIfLEAhNnwFnLuM3
    lhmTyebi6ACkGsj7QD3GDXu582RG1WdIIz+hoeYj0+taXgci6gmJRZHhoABEwgboHoe87Q
    1R/vGh/i6aOYuoGQI1tbkHpmKUruc3/qVduGDtxFJc16qZRnMI7YNqNaSOjg
X-ME-Proxy: <xmx:5E_fatEieJo9mYr05oDF3cWAVx7NYB27Y7aFd8YUGMPxvn28jHIAkQ>
    <xmx:5E_farQW4fR8p8DpTz2iA3pIZ5nOtNLzzVBEOMtte5X-bc483bXeVg>
    <xmx:5E_fahFOxCEE4Ti2-yPzA1zO5zkalOybkmM1XZWT-89kZnWZHlBfXg>
    <xmx:5E_fav81-U_aHFqgODiW5wIZaT0LKVpfcqJRxZ5G-VZYDe6gdsZB2A>
    <xmx:5E_fajMw8Et_NCVxm-ze-kONxddm6JufPIW1E3-fhPJZ2siS2pXUBlio>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 09:04:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d7d9ec58 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 13:04:33 +0000 (UTC)
Date: Mon, 26 Oct 2026 14:04:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Daniel Zoghalchali <daniel@latchkey.dev>
Cc: git@vger.kernel.org
Subject: Re: [BUG] 2.56.0: filtered --unshallow of a moved ref aborts in
 pack-objects (should_include_obj) via inherited GIT_SHALLOW_FILE
Message-ID: <at9P0ctULX1BBD8y@pks.im>
References: <CAJwQ=KQynymg4CJOLkyebACYVQa+LhXB2UifniTASkLyArWejA@mail.gmail.com>
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
In-Reply-To: <CAJwQ=KQynymg4CJOLkyebACYVQa+LhXB2UifniTASkLyArWejA@mail.gmail.com>

Hi,

On Sat, Oct 24, 2026 at 10:59:55AM -0700, Daniel Zoghalchali wrote:
> Hi,
> 
> Since v2.56.0, a fetch that combines a tree filter with --unshallow
> (or --deepen) aborts in a non-partial shallow clone when the fetched
> ref has moved past the local tip:
> 
>   BUG: builtin/pack-objects.c:5098: should_include_obj should only be
> called on existing objects
>   error: pack-objects died of signal 6
>   fatal: could not finish pack-objects to repack local links
>   fatal: index-pack failed
> 
> v2.55.0 completes the same fetch. We hit it in CI, where a job checks
> out a single commit at depth 1 and then unshallows its branch, which
> by then has moved on.
> 
> Reproduction (offline, any Linux):
> 
>   set -e
>   W=$(mktemp -d); cd "$W"
>   git init -q -b dev seed
>   for i in 1 2 3 4; do
>     mkdir -p seed/src; echo "$i" > seed/src/f.txt
>     git -C seed add -A
>     git -C seed -c user.name=t -c user.email=t@t \
>       commit -q -m "c$i"
>   done
>   git init -q --bare o.git
>   git -C seed push -q "$W/o.git" dev
>   git -C o.git config uploadpack.allowFilter true
>   git -C o.git config uploadpack.allowAnySHA1InWant true
>   git init -q co
>   git -C co remote add origin "file://$W/o.git"
>   TIP1=$(git -C seed rev-parse dev~1)
>   git -C co fetch -q --no-tags --depth=1 origin \
>     "+$TIP1:refs/remotes/origin/dev"
>   git -C co checkout -q -B dev refs/remotes/origin/dev
>   git -C co fetch --no-tags --filter=tree:0 --unshallow origin \
>     +refs/heads/dev:refs/remotes/origin/dev

Thanks, this reproducer works for me.

> The last command dies as above with 2.56.0, both Ubuntu 24.04's
> git-core PPA build (1:2.56.0-0ppa1~ubuntu24.04.2) and v2.56.0 built
> from source. It succeeds with v2.55.0 built from source. With 2.56.0
> it also succeeds when dev has not moved past the checkout, with
> --filter=blob:none, or without a filter. --deepen=N with the same
> filter aborts the same way.
> 
> What happens:
> - fetch-pack runs "git --shallow-file '' index-pack --promisor ...".
> - The pack names the local tip as the parent of the new dev commit, so
>   index-pack's repack_local_links() starts "git pack-objects
>   --exclude-promisor-objects-best-effort".
> - Since d43b9acb05 (setup: unify setup of shallow file), --shallow-file
>   is applied by exporting GIT_SHALLOW_FILE, so that grandchild inherits
>   the empty shallow file.
> - The grandchild no longer treats the local tip as a shallow boundary.
>   It walks to the tip's parent, a promisor commit fetched without trees,
>   and is_not_in_promisor_pack_obj() hits the BUG on that parent's
>   missing root tree.
> - Before d43b9acb05, the grandchild read $GIT_DIR/shallow and stopped at
>   the tip.
> 
> To confirm this, we wrapped only the repack child. Unsetting
> GIT_SHALLOW_FILE for it makes 2.56.0 pass, and setting
> GIT_SHALLOW_FILE= for it makes 2.55.0 fail the same way, at its
> builtin/pack-objects.c:5004.

Makes sense. Even though I think that the bug isn't actually that we
started propagating GIT_SHALLOW_FILE, as we now basically behave like we
do it with all other global variables, too. And if we were to execute a
non-local command like git-receive-pack(1) we already know to unset that
value again via `local_repo_env`.

What's fishy is "builtin/pack-objects.c:is_not_in_promisor_pack_obj()",
which explicitly checks whether a given object is in a promisor or not.
But in the case where we assume that an object may be a promisor object
we know that we're running in a repostitory that may not even have all
of its objects in the first place -- that's the whole ponit of a partial
clone after all. But when `odb_read_object_info_ext()` returns an error
we simply `BUG()` right away, which does not make any sense to me.

> Separately, the BUG() is reachable without the environment change. On
> 2.55.0, a filtered --unshallow of the local tip, followed by a
> filtered fetch of a moved ref, also dies there, because the walk from
> the local tip reaches promisor commits whose trees were never fetched.

Yeah, this bug has the same root cause and I was able to reproduce it,
too. And indeed it confirms my above take as it already exists before
the change to how we propagate GIT_SHALLOW_FILE. So overall, I think the
fix is as simple as this:

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ca3a891dfbc..e634173fb1f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5085,7 +5085,7 @@ static int is_not_in_promisor_pack_obj(struct object *obj, void *data UNUSED)
        };

        if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info, 0))
-               BUG("should_include_obj should only be called on existing objects");
+               return 0;
        return source_info.source->type != ODB_SOURCE_PACKED || !source_info.u.packed.pack->pack_promisor;
 }

I'll think a bit more about this and send a patch tomorrow. Thanks!

Patrick
