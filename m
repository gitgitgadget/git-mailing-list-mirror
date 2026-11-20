Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177382;
	b=kRS5i6o1jf/sc2wlu2a53tGLRJemLguMMnl2mag1lGNFw1xK3eHM9NIVIid+81uuiFby
	 FxJBnZUvfFIfqX3n6oQX0aC674JGZkBCIM13HgJVGbRFDypSP332j6sEogaytXTlb/gQf
	 iPW4Z2A4q+ch4FYYPvNz9vcvU3LsT6qRK1e2JoC92i0gj3yMqvx9RFZHwdgmKyAYAK8Ia
	 a903CVhpmmPQQOUGVR5E+TRyFGGVrhQ0BUzuCi2JuKP3t0pe85u0wprWIxQK6xliRpz6b
	 IxCPsEGoN5QN6/bbmyeIr4YraAP0dFV1XJekFY8RCaZZqXgmdCReee809VmObW1sr7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177382;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer;
	bh=vZDD1oEamSNJ3pRatuONGfJkUaP4I+FygrRamOt5ong=;
	b=EcDcKtJ8ZrOPyIoybm2mj0UUClz/7tU7ODyO2T9rBZyZdw0m+G9qTY3a/6gYpaPj7YEs
	 Q7bGydSUTqaeFvQSLWCjSFKOmSxfrpQU3AOn5GLpEdAFZZtmT6UycIUMLsU6aGiq5Anzs
	 Et/cSiDPF5Lmbi3KZfQ0mncDN4n0m86NYbcDjLtoMa2xyFShGy2PUg2i7RzxJnAEK95pm
	 qWKR6gSzov4JMM4ubLAL0L8uJH/zbj8kwOmWpLxq/61jtMvMEs7LXBoeQRNXWBCwId3zv
	 MMCCl4AC/FVh9Nir13DHHz81XEUZNoIZlowryexIrUxtAgz4t9ZOipSMKF4XA7n69rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Xv+qyNCB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="4S4/b5ue";
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE67B606A332
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 12:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE67B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Xv+qyNCB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4S4/b5ue
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 05A721400202
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 07:23:01 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 20 Nov 2026 07:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795177380;
	 x=1795263780; bh=vZDD1oEamSNJ3pRatuONGfJkUaP4I+FygrRamOt5ong=; b=
	Xv+qyNCB9JisTa4FacBhwgPKivEmeV9aT9kSx6EUVVHsDB3RSowjy6qN7R5nZ9PI
	HB6Q42Rjap/ZZx8ggdRHN5m9Twx9mfeNxZF/IyhX6p1Y0mv2dO8tN7esrUsKDy7Q
	G9PX4IUlW6cn3gDHGsLwsGcHChDtFzzMqZLHDp2KSS8UwuidtzZLRhj7InKSplzR
	TXhwvomNz1wmx76630NTmGzISf4g5mC0bf2UOYfMaCz83jfVW8fJ7DvOj7b/UgTZ
	cB3rAqzYzsZkn8g8qROjGBxTIPXjHtxR5T7PYQK1Lyk0yVTqgfVS5ZkvwHzmBB/5
	3mAD/S0w8jvvSOQm0YC9aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795177380; x=
	1795263780; bh=vZDD1oEamSNJ3pRatuONGfJkUaP4I+FygrRamOt5ong=; b=4
	S4/b5ue8yhU19CCbtZoZ4pERLlBmoxLyhX+sj1c5S3MNCAK/cl/f3GLAc8NqSCEd
	f61CK9seCQMtmD9gGL6WxJ2hGzgobc5JVzltBT9xDs4N4kIsly9AsNIkyyd8CWHn
	18rk4XEdaE7ZQY3V03qHXi0At63BWuNEqUHiKqqBFDJE1InEjHDG1vkKVh7AtnV8
	Utz3lBasYAItr21PNt8nK0MvWdR94zjBP+UOQOZe+pG6g0TJaCIRzR1Qojtfo/jo
	KxdU7Mza3fJlzWk2N7gAIoabVD0jG+IL9U6nGcHZjo+JuNNZ14y4eNy867s5Nh1W
	BHW8wVVu3VusqdMtat8Kw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795177380; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:gZ/MISe4qqwdujEAyAtYoT7S5pvzQt9brRCxjCunMoW73Jl
	3u2fRhX2M3gqhJcUOWun894WYEq7p9oFMQtvtvDE9HU6fJQBuSkX9KCGYv2Y0JmD
	7pCgFbxt3R814I+9d5NfqWVPCucfVX93BcSonvNror34gzuO0zk9PHlkeKY1x7re
	+tNEYR52uyNTJHQyElkTlEkKM2gZ43XqwhPy23tiOG6YCdKRXU94uUTp4wB1gz/0
	EQCaQZ1WdfY4lQWUpWICPeJJYKEOzWKILUCGVghHa3oN+R3IG63JQ+BNtrCmrihO
	e5uHYWR9fN2bMJKK1O/LGTjZVPSEEhvn4nAqeTQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:yhgZoB+JiwcCb+iRdA3sbdHOjKYAnaQCKMUt8IEHVZM=:dvMlE5NkKJa7SB1rlU2v18yy5e+5rEkJo8rxEEZ2Usc=;
X-ME-Sender: <xms:pDsAa7VB1uP9TYaGKXA93dpjgFsEByL-5eWHJsw2e4rDic3dJDsjpg>
    <xme:pDsAa5k3suJhzzFRCUzekJCgYlyT9F72ZhmK1GcKVIP9qmWv2_005kwu4Ly0BuFyh
    2qqeyv0UF0H1g1Ioo8_jk-sAQAAVJwP5LNDnKSEmv9zzMMXc0PUj_0>
X-ME-Received: <xmr:pDsAa1AYKsdVLfGuAmDMCw-tiDcJHTH2ZuwzJ95y1cearROGEOCO3_0JkPOtCdCQ9on3J2c>
X-ME-Proxy-Cause: dmFkZTGrQypjBewqUyFVmk6gSvcS2qPHj5ICj+sZIM2NdxKzCOIUyVNa5MNP3ZGMOKZGxO
    RqaW5yrEyMXr0/86aV19ellgKi4YS/9clslbzOdejLNCg2yIWVCyiTLc6U08+q0lXNqEjG
    2zViWTF+3u52jleB4Rdm7BqINtXCubacUMqSHkqdCPiHiz8mhH080/2h0AZ/Ff6BKg3eQQ
    JDusP7ErJv0HNOHBZLeEjdyZxRjrhflpYNvJG7tbMcjxvUVZ3BvS7KcfSWGLdoQz+UVvQK
    3GdojUbgK04Tfv4B1Y6760CE6ndwsl3Mo8z/0OiAMZ8nkzfNG+fAKaBHSR1gbJc3Y2S2Se
    r+CAWPIxTwNpfyXwPTTNsLEYyHWfooV0TrS3k6y3jLhHEzv2OmENHgBAebupXQ3L1zVodv
    Gdl9iVk2Q+xDFXIUIKTA9mmTM6pq1in6otZN2pqwEoTMqrh/u9LYuM1g2buzNCNVPJeXKj
    nQ5/pVkXjnMzvGEoKkvRmY7hDnX23Z+Np9jmPn//RhFcWpZFfiUMmShc7VKdsGnl2L43AD
    b/7FbJ42QJh2rVx/4b5n/v62rgq4sjTPb2g8UBdwH5iU2MmA6sdSeYPpBDcZWtFfDryI6w
    3ZxOzgTtXqMuCrjqK1PBYdPqs6kWL7RPZg5dTlJwiAHdPysdE8vr/G0X4nbQ
X-ME-Proxy: <xmx:pDsAaxeDXpA6JOxnXDCk_pfMDvCpnWz5OtQk5932kXtD_6EwD7FXeA>
    <xmx:pDsAa4L4_hZR-nt328v90ttG4Ps7CX3t2U_Qei0KiwDrR16NdUyzvg>
    <xmx:pDsAa8eGRE8RWLAOCLw_fkfk5m68zoTmxae7I37YYpM3nRlVqQdgSQ>
    <xmx:pDsAa33fTP6J6x4b9D-MGbqXYtoQfo_TMWhoh1CBFcOK5pPBYfEFOw>
    <xmx:pDsAa2tO_9j3G1aYW1IURE1hxEqvJKOE8XwAVKiASMftrsOFOQ2u-FKo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 07:23:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c6e4b394 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Nov 2026 12:22:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/7] Introduce pluggable commit graphs (pt.1)
Date: Fri, 20 Nov 2026 13:22:48 +0100
Message-Id: <20261120-pks-odb-pluggable-commit-graphs-v2-0-31f2341a9932@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOQQ6CMBREr0K69psWDYIr72FYlPa3fAXatEA0h
 LtbMK5dvmRm3iwsYiCM7JotLOBMkdyQID9kTLVysAikE7Oc54UQgoN/RnC6Ad9N1sqmQ1Cu72k
 EG6RvI2ClVVVczoZLZGnFBzT02g33+stxah6oxm12S7QURxfe+4VZbLmfrfhrmwVwkOXJKGEML
 3l5S40j9axe1/UD59HEHt0AAAA=
X-Change-ID: 20261110-pks-odb-pluggable-commit-graphs-e9dc9674f0ae
In-Reply-To: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
References: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

this patch series contains the first half of patches required to make
commit graphs pluggable. Originally it went all the way, but now that I
had to iterate a bit and add another patch on top I figured that it was
growing too long te be properly reviewable.

So I've split it up into two parts now, where the first half refactors
some existing interfaces for writing commit graphs. The split is
somewhat arbitrary, but I think the simplifications are sensible by
themselves. Later commits start to split out some functionality, and
those are less sensible as standalone commits.

This series is built on fbd2d1e765d (The 18th batch, 2026-11-09) with
ps/commit-graph-write-refactor at a9993c1000d (commit-graph: modernize
function names, 2026-11-04) merged into it.

Changes in v2:
  - Add another commit on top that fixes verification of trailer hashes
    with commit graph chains.
  - Drop the second half of this patch series.
  - Link to v1: https://patch.msgid.link/20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (7):
      commit-graph: verify all trailer hashes against the chain file
      commit-graph: simplify linking commit graph chains
      commit-graph: simplify reading a single commit graph
      commit-graph: expose function to validate a commit graph chain
      commit-graph: decide mergeable and chainable layers by depth
      commit-graph: introduce common exit for `write_commit_graph_file()`
      commit-graph: derive layer infos from the passed-in chain

 builtin/commit-graph.c        |   2 +-
 commit-graph.c                | 392 +++++++++++++++++++++---------------------
 commit-graph.h                |  29 +++-
 t/t5324-split-commit-graph.sh |  43 ++++-
 4 files changed, 256 insertions(+), 210 deletions(-)

Range-diff versus v1:

 -:  ----------- >  1:  ae21d1f3f72 commit-graph: verify all trailer hashes against the chain file
 1:  4b71373957e !  2:  2f66d4e3517 commit-graph: simplify linking commit graph chains
    @@ Commit message
         move the logic that creates commit graph chains into the object database
         backend.
     
    +    While at it, align on error semantics so that we return 0 on success, or
    +    a negative error code otherwise.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## commit-graph.c ##
    @@ commit-graph.c: static void validate_mixed_bloom_settings(struct commit_graph *g
     +int commit_graph_link_base(struct commit_graph *g,
     +			   struct commit_graph *base)
      {
    --	struct commit_graph *cur_g = chain;
     +	struct commit_graph *layer;
     +	size_t n = 0;
     +
     +	for (layer = base; layer; layer = layer->base_graph)
     +		n++;
    - 
    ++
      	if (n && !g->chunk_base_graphs) {
      		warning(_("commit-graph has no base graphs chunk"));
     -		return 0;
    @@ commit-graph.c: static void validate_mixed_bloom_settings(struct commit_graph *g
     +	for (layer = base; layer; layer = layer->base_graph) {
      		n--;
     -
    --		if (!cur_g ||
    --		    !oideq(&oids[n], &cur_g->oid) ||
    --		    !hasheq(oids[n].hash, g->chunk_base_graphs + st_mult(g->hash_algo->rawsz, n),
    +-		if (!hasheq(oids[n].hash, g->chunk_base_graphs + st_mult(g->hash_algo->rawsz, n),
     +		if (!hasheq(layer->oid.hash,
     +			    g->chunk_base_graphs + st_mult(g->hash_algo->rawsz, n),
      			    g->hash_algo)) {
    @@ commit-graph.c: static void validate_mixed_bloom_settings(struct commit_graph *g
     -			return 0;
     +			return -1;
      		}
    --
    --		cur_g = cur_g->base_graph;
      	}
      
     -	if (chain) {
    @@ commit-graph.c: struct commit_graph *load_commit_graph_chain_fd_st(struct object
      				line.buf);
      			valid = 0;
     @@ commit-graph.c: struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
    - 			free(graph_name);
    - 
    - 			if (g) {
    --				if (add_graph_to_chain(g, graph_chain, oids, i)) {
    -+				if (!commit_graph_link_base(g, graph_chain)) {
    + 				 * Verify that the loaded commit graph's
    + 				 * trailer matches the chain file.
    + 				 */
    +-				if (!oideq(&g->oid, &oids[i])) {
    ++				if (!oideq(&g->oid, &oid)) {
    + 					warning(_("commit-graph chain does not match"));
    +-				} else if (add_graph_to_chain(g, graph_chain, oids, i)) {
    ++				} else if (!commit_graph_link_base(g, graph_chain)) {
      					graph_chain = g;
      					valid = 1;
    - 				} else {
    + 				}
     @@ commit-graph.c: struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
      	validate_mixed_generation_chain(graph_chain);
      	validate_mixed_bloom_settings(graph_chain);
 2:  4bb8ff6fa1e =  3:  ffb6990ae3d commit-graph: simplify reading a single commit graph
 3:  4aad503c320 =  4:  34305bc50b8 commit-graph: expose function to validate a commit graph chain
 4:  49519777c15 =  5:  d804b3849d7 commit-graph: decide mergeable and chainable layers by depth
 5:  12c196a0e7f =  6:  6ac9b939507 commit-graph: introduce common exit for `write_commit_graph_file()`
 6:  f4939bcbfb6 =  7:  4dcadeeb182 commit-graph: derive layer infos from the passed-in chain
 7:  0c573b55aa9 <  -:  ----------- commit-graph: split out check whether writing commit graphs is allowed
 8:  7dba71d2756 <  -:  ----------- commit-graph: split out logic to write a new commit graph layer
 9:  fe09c3e053a <  -:  ----------- commit-graph: mark incomplete commit graph chains
10:  49a716b9b22 <  -:  ----------- odb/source: make commit graphs pluggable
11:  f9242d70dfa <  -:  ----------- odb/source-files: move logic to derive commit graph paths
12:  e46670fb75f <  -:  ----------- odb/source-files: internalize logic to derive commit graph paths

---
base-commit: 0c2ef2cc2023eab2fe8bc54d542fe4f93314f186
change-id: 20261110-pks-odb-pluggable-commit-graphs-e9dc9674f0ae

