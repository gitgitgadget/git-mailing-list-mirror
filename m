Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884859;
	b=2ht7glKEjwWLFk6VP7LGTgdkgL0mqOvapHQuM9yAoz8DDqxLm7g50y3qb6I2sHF/Osw8
	 IXthHFV5Qx3dUho/pAvDx06BRoW8woDoviLRLphcRDnQMwHoCGcIPpl7GCpfNJyIrylnr
	 98Jz9JLwAK/bRYioXbuEe1xruF3W9TLOPPqz4BQaCDOfIK+vT0eMlZrU5xK8AF6Z0AsPD
	 rGLvDX5U3MXxhzv3z75CKlnigWZHk6ensdnWuXOX6fsykN9gBx0t3d+TqRmvT+KVKJ083
	 m9YLkQ6Z+4CBzuu42ujPslJ/fHiGx/qvCvFaN5IsDDZTmOwUsRI+kYSmGonkZ7OZ2bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884859;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5P5H+zAUCIrTJK9BtnrfZpI8pdfW93qokcQ1Us3/Zmc=;
	b=BXUIHlq7wNmk/vgBdhTiI4Fb4IP95wtSbuCiNIA4IcGzLcWGFaWiNqxGb7sI9GfuqDc9
	 wvDqldRz93lRXRVqScgrl31y6gLjFlZuYVRW5j9Pvh6ifx98QIJDbwJHxTUaRHX6xWjJX
	 8BedqQsw8+kB9yh+BljvglmBY+nbLajG70tdvnAy+0jVmc8nZDQSidLgBclXCqD4Ysm0x
	 A/a4dWhnoQFDv0PRJIy9c8FonxOf1NErrvnrDStiajttlNinXyI2R7omVfoi6dPh+XxLk
	 kG6yelmvir+LcoieiV1PcdAXGEL+q2FFU7KVK5kEH+VbYEtCWW1i6F2nEZX56T6ZkYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=WPTQAPIp;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="w/PslnkF";
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD85606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 13:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BD85606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=WPTQAPIp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=w/PslnkF
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 4DD54EC05B5
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 08:20:57 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 05 Nov 2026 08:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793884857; x=1793971257; bh=5P5H+zAUCI
	rTJK9BtnrfZpI8pdfW93qokcQ1Us3/Zmc=; b=WPTQAPIp9/N/syOfsef/AOURhl
	6BwXvkKPkfLlI4AfZZKxxp/gS0cR4P1Vsk6aecS18VKX/Ov+2RI3lK6djXmJFk0r
	W/Dl/AoazNtCDUJznAjEtqFo/vLnLzZYiPhPfhaTApoa0YXXOBkpnyYuwxnn+3Ma
	QRlyFxCgHjG3XHY2KvA+NaCJgsjvP7P/Qf1O9a4sKDhC4J/icoNgElVy5d6k6sj6
	vD9Kg+mK5ow38TlkJwcjOvLLHyiJqk5CCQIXUNGk22OcRfBJcLHH+QTXUFtGQ8Rf
	IkqpUZgvfeCr4phhwcTjBf5hliQZEf0J9qYYY5MlVyIXYFGnFytM7//889UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793884857; x=1793971257; bh=5P5H+zAUCIrTJK9BtnrfZpI8pdfW93qokcQ
	1Us3/Zmc=; b=w/PslnkFjerTtDTkPJFZhaXUHkgqricYKvCYkH/8i2HZKmjityV
	9UDkPmYmEOOPWCa8uxq9qSh8LgSPtpVaRX0KmWb4b0ozgeu9q2AeyMw/A5LzS/OA
	rcjansJgulWdUp5K8o9oA4a4vf+ZawwDDjqa9CvsuDAofSrpy5op5BRjbGPrhp3A
	rI4Hik3kQbPJkcMoSvE3zU9pCo7lDs3tjpZUewYKT4M0xpUKeNs7tbSvQTQ4D4QA
	5G5N3dbaZD8hx5hckqEF1SG2CEWKPQq5ZyNFADEmhIAak3VT2mUvY3/yHfitKVVT
	7iGuv3DDL6m5JrP7WHZWOLCeQkisbawlQfw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793884857; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:AY7iTbT6FqndVZwACpmY2bDkhBvo3O63yu/uKBaIMVIEMjC
	MIoW3j9bP9rymbKTNEefgXxXSUQM5u+dH5X1AovTSKkX0O2oqGyrqBCCAFUC8CYX
	pzKQlm/J/BTEUlPXeMnBO9LS84lPDB0k44Kxt1NEoUg3MnwlJ6QVNuyHSvk85fFK
	LSQkJRjN4cO0kC8UOMCUqYRKOAI4w7CuczmFM9qWNuiaGpFs7Fce0a2Dl8I8LCUd
	GDIcJWg7DXA3o9+USTTHHSEy734ykrX7NAEViBHeaA4mYXZKre7ZfgHwGf1TwhaG
	O1WgE/nn6opGHsrVUoWTM+YXIU6GTw8nt0YqG5Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6dLKAa5PKwa3FO5zNo71kcGDctXh/Nv48YR+Vs+WJrg=:EYzZ0WQrvjIOd5jVD4QMamlx3HUbWVdhMLs6CwDUIWs=;
X-ME-Sender: <xms:uYLsanf4y-kkp6-7YAHTx9bgRc7Q9xbzvExuRsu6UDbfYmuVhlssiA>
    <xme:uYLsajNUW-XOe24Q7pyoJx4ohcmDf1r8CiwknRLqi-ovEvnby0Kw5tlfBp0BiBRxl
    -7bJz8Rebk7DyGjL0wnCZeDku2FMGvtZlgeY0MXz6oNBwAbv6AsCQ>
X-ME-Received: <xmr:uYLsauKh1cLqQLcAHUjZlddouil2JpX6wnoTtar7qFZl9upeLmZ52w>
X-ME-Proxy-Cause: dmFkZTGa4XUlq6LzOgKtXw4cv9SbzB2wNBfJAaFZIp/kqq8taY54WLkooJ06ntfEVQ2xIv
    ruXQGsTepHPLQhz7356Evtuv7BQOKwAMEi8m0960I3YFfVtwgZljRonth+oTlWvfmb1dsB
    PcVJuvof4MYkKAV4qYPRDUZ3Ue6rYLYDKX/2UaY2MAp5BbYqHTrpshG5Ee3ya9IlkdJN41
    nPxORseCmhZ1Z1ShCg7gw48vTD/NWGQzoBx5tJ1mUz46xLLGD7DSoq75stPxbDGxtEYIM2
    kRGJ0rYB0/gjiyRSBLOUJ7GlnUafb5LISA4EcktI4KUvoKHcx6SZlMoko3Q3tDMvkBi8nO
    nnPGoDwBl9tKpkUM5k/KW7yEvdTIaaUF5xKV+3OEcwqefA2yUYTXE1kLeeg56yaQp1aqIH
    Q1XJS8pcI6pMilRLmoa5pkcF6uqiRvy4YakAiXsjWj9JWCQVvZ7GZqRYY1RafDUpxjeR59
    D1rGN0JqyhQn7GfnSfnWqA+A9v4OHv+ZeauDKcAYzxX8d3QQN1G2fp2tO/LTtCV47ju4n3
    lLn/fRGY/sI0Tc6gymEU2KIlPdWKGm8ZV8any2fmbhAFMxrJ6wWPSF3bgQylvMfgwxlCom
    h32AmhM4EtGW6I3LLas8Vcv/Piu8nHaT5CvbVFlS8c/3mMMJ099v7SvzRvyA
X-ME-Proxy: <xmx:uYLsakFCmUT0tHU-bpPgWUvX5UqRfgtwk63KLJhxeQDHDBHeaPdUoQ>
    <xmx:uYLsamQZekJjLEKYju1C4SH-ckzU0E6jQ0R7zdfMe9jKhkSizgHmuA>
    <xmx:uYLsagGTlL5HdMJnvkAR8ndkcxqW5VSA5m5cJpMuakvvb1q-zWqk8A>
    <xmx:uYLsai8w1t99Zzja1_GDWq3mtnhKxcDIypzL3_3PTE9iwLuqWTIh_A>
    <xmx:uYLsasuw9s3alpLb97N0Oc1rT-ee3yfOLbHrayAuMqPKtR_1HlTK2do9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 08:20:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cd7dd8fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Nov 2026 13:20:53 +0000 (UTC)
Date: Thu, 5 Nov 2026 14:20:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson <krka@spotify.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/10] commit-graph: move remaining write parameters into
 options
Message-ID: <auyCsmn6Hx_uc6zq@pks.im>
References: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
 <20261104-pks-commit-graph-write-refactorings-v1-6-d013d9401a59@pks.im>
 <CAL71e4N4BvO=eMfO0wnJ9=gGbfTRz5ayWFZULoN1dGSF7uCZAA@mail.gmail.com>
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
In-Reply-To: <CAL71e4N4BvO=eMfO0wnJ9=gGbfTRz5ayWFZULoN1dGSF7uCZAA@mail.gmail.com>

On Wed, Nov 04, 2026 at 06:49:50PM +0100, Kristofer Karlsson wrote:
> On Wed, 4 Nov 2026 at 17:15, Patrick Steinhardt <ps@pks.im> wrote:
> >
> >                 if (graph_write_mode != GRAPH_WRITE_TIPS)
> >                         write_opts.flags |= COMMIT_GRAPH_WRITE_REACHABLE;
> > +               else
> > +                       write_opts.commits = &updated_tips;
> 
> Ah, this touches on my previous patch cef2d8c4cb
> (fetch: write commit-graph using updated refs only, 2026-10-07).
> 
> My only nit would be that the if/else also covers the skip case,
> so one of the branches always fires for it.  A switch would make
> each mode set exactly what it needs:
> 
>   switch (graph_write_mode) {
>   case GRAPH_WRITE_SKIP:
>       break;
>   case GRAPH_WRITE_REACHABLE:
>       write_opts.flags |= COMMIT_GRAPH_WRITE_REACHABLE;
>       break;
>   case GRAPH_WRITE_TIPS:
>       write_opts.commits = &updated_tips;
>       break;
>   }
> 
> It doesn't matter for correctness since the skip case never calls
> the writer, but it looks easier to reason about to me.
> 
> But that's just a preference, I don't feel strongly about it.

I was wondering whether we want to maybe introduce a tagged union where
it becomes implicitly clear that some of the options only apply to a
specific mode. Something like this:

diff --git a/commit-graph.h b/commit-graph.h
index 2156499a688..8d53f80f179 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -160,7 +160,6 @@ enum commit_graph_write_flags {
 	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2),
 	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 3),
 	COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS = (1 << 4),
-	COMMIT_GRAPH_WRITE_REACHABLE  = (1 << 5),
 };
 
 enum commit_graph_split_flags {
@@ -170,9 +169,18 @@ enum commit_graph_split_flags {
 };
 
 struct commit_graph_write_options {
+	enum commit_graph_write_mode {
+		COMMIT_GRAPH_WRITE_ALL,
+		COMMIT_GRAPH_WRITE_REACHABLE,
+		COMMIT_GRAPH_WRITE_PACKS_INDEXES,
+		COMMIT_GRAPH_WRITE_COMMITS,
+	} mode;
+	union {
+		const struct string_list *pack_indexes;
+		struct oidset *commits;
+	} mode_args;
+
 	enum commit_graph_write_flags flags;
-	const struct string_list *pack_indexes;
-	struct oidset *commits;
 	int size_multiple;
 	int max_commits;
 	timestamp_t expire_time;

I wasn't really sure whether that complexity is really worth it, so for
now I decided to not pursue it. I think I still tend to stick with that
decision for now, but it's maybe something to keep in mind for the
future?

Patrick
