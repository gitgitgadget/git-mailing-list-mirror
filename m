Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994336;
	b=2usNdAN4go96WvHf6vdAt1ibFhghN30Z/+Fo+pmT8JV6x2DRcLo4sXw0zfbBy4lE3Iwr
	 Mtx733lBkaHoqlfB0Bp/p5ut77fM2fIPj8bGPzUty6fjdPjV2bp5oN0UHbQ61B7QEcZvW
	 2p2LFoXcjFz8ozS4Fnv9E3jEOjwHxiLJZbCH86nfpXPnvrdXULScMJi4z2av9zeXz0pJv
	 cW4givXQ5UMBde99xgEKvabGTAkk9clH+Y1vp//O6tQBUCElJxu295yg3jRVuJrvISByx
	 96G9YLL1s1w8A9aXwy4eprzrOz9rJbS2F0zYJwacFK2EQkEUT8qcKL/5SqwwCkvEr2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994336;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=T/+dkZY25SbPLsBucwuRP3WVc7RrChBs67kwCoka5i4=;
	b=AeUr05aAhRBstXU5IGx1hfWLgXbgjFklzM2yB+CbnQnbFANwfMw7pHbrqQOtvz0pqGJM
	 heF4FJTenlv9BAvFdGEUpOMzI9Kha9bI1YOmnX0LYxkS4IhlRSgHwolwIjt2FDM6ty5bM
	 ZQc1dVICvASLmwyZg4ltN6yDH1L9ZzGOWuUPFBFjc57d0fVbNOosM6BG5F5Nk4j3l11lu
	 nBtw4jhDbEJ2Qs2M+v2IXECcoFKQ2Zah8/J0ORECdx6UZqznpowf/Dm5j/enVtXJ62ijU
	 hTvcKtrXrp2BiTgmgcV5SXASYvI5ovhmFwTILMfucQEbQOBDys3C+UN/MxqzjYFVPVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=U+wi5FIv;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="319ZLWj/";
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C5606A32F
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 09:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 491C5606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=U+wi5FIv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=319ZLWj/
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 69AABEC0074
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 04:32:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 18 Nov 2026 04:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794994335;
	 x=1795080735; bh=T/+dkZY25SbPLsBucwuRP3WVc7RrChBs67kwCoka5i4=; b=
	U+wi5FIvqLLR3ZlI/ykazMK1Hz/e462nJ9V49N5AdJOE5QmvNxwvFZU4oEsmIjda
	OezGC59Z6R5npsV6efow45XXjcG9uK/2GiVuz5XuJoCsUEP/g1sbrGNYCq1gGNxg
	TWadjv5adgpMRD9VRGi5c1RLUzg+4JMj831a/adgzHTWx1DXmZl1O750YtqRJJVS
	vMdXUPpM+EjW8RgVddHGgW02djdlYsqSZ3OYr4rJgCgbhy4o9syBfKZMLZRf6yHV
	iGhMBeJoqKShipm7EYhVJKPV/qF+yWa6nABSv6B6UeaOdQ/Qc+NsugpbZikI0fSv
	8nff/CEX0BQ60RTanzzBNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794994335; x=
	1795080735; bh=T/+dkZY25SbPLsBucwuRP3WVc7RrChBs67kwCoka5i4=; b=3
	19ZLWj/BPa8mXB++V2tXT2omFNz+amk0294eTPh31C4macHDc/Awo2jrYUYMosm3
	SfSig2Xw6wnL/atA6hSuqtKBsTxqA8L1aDoMg5KPjmjhNBhIhnXfslE14feuifFI
	oZWncqHHvoEn0PQFOhrcNerw9iD90u6ipHg4QvKnffC29LKr9Q6mX+dhn3KmcVPE
	C8ecaLOWKw0Zuc50VcSGXBqOjOsxku+XZkPFKJ9LBPWVNvTxixDWxivfd4PZ9+dA
	vLvsMAA8kqMRFsSW872EVVutx5+UYmJ8cSQ/0VUNCrhZz6OaMMBEXcg3VKxP/ukp
	KVZRoAV4bhOmHtDox3p0w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794994335; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:L6cSVaSoOvIvmA4/4tUmq6vB9NPZJNZoqd8sdyipyfCtF+R
	GNNtFpKUbDh9EM6BV+9jZuNP5g3vTYZhgSjZNDcz3zNJqB+hPguy/7bRt/yPZwKW
	ZwruqxdD+YgjWCWaghUKqaagjYQkBcZzUUoEGac9/q85Ho8G8vRzzyNkHvgYtLma
	ZoexbwaEz0OnOAcnm4IcxMuv0OJs/IIHTRWnJbtks2DYs5qyC0QzUAtKnNzTxfXM
	E7+HvT3CaoeHDk+N3sx9T8lrEX8h+kZpnTSXIKsewGdVEWuj5NcvsTB+hzyyrtZq
	bbw+h7+TK9bNOvG5G8b0iDCWOKjGiz1nOldfKOw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qQTgN/YVUp8vwY9sfecJCs0BmtHr7OwNlm0DWm4kpJA=:OmfXabySH7uY6ByqA7Q5Fs1DTdvRRrilL1pVGRRv5C8=;
X-ME-Sender: <xms:n3D9av171ZHhCYz1WBBHFY6x-VJu7ilD6K2ETn04VFDv69gP44yIxw>
    <xme:n3D9alAtJz9-d_bP1QTlM81P-hMweVEEBY1hCL88h2_7qX_cSLFMGZzLH8HYzGFu6
    yVujs1bPRNm7GJ_c9aIAJ6vIOA1-z25yu9VPBz3CpFVCOBprCNgX1U>
X-ME-Received: <xmr:n3D9aliWRrgEKf1EecnzCqI1Vr4lpgRxzTnyPu62Uj3KWZxquOLkeA>
X-ME-Proxy-Cause: dmFkZTGos3cH2MMxLRYrfwPxZGS9m9Ny5S7pKB/kSAa4EE6FvvAfVQEZtB3aVEg8Kb8y3B
    JGHm5omVMloAWUoywH2hFE/EPXKzqKz9yUz1dyO/6qgyKfAoCmZ2jbghNlvvfidIoQBHys
    HaX+6BVMKvGdX90YgYfq5oeOmpMwPKiweTHU9+yq6u+FN2NDO1KMZ0thJ+d9X+0H/zV1qz
    /hweY4wSeBoPniInuNVjsJI9GxS0ScD9xKoi9wbS2xbmh6S//wBiNte2YF0GVaHnGRBcra
    /VAbDih7YRh7XGiufRzDPuvb+dYMGYz5/KjVLrDrRt4VRptlI0NAdVcLVceTvYaXjKd2ll
    HAF6306h6CE9fZ6tc434QM5RiJdj6nUa6Pgkcz+V6F98ziXIc3oG++YvZMlenuf2pCbVf8
    43H2P5CjOYRRtoriZ0EVAL3z6Js5qwwbQMPHLXiEf2KV2EvXFsTg0eBUXhshCQ5jgZm42S
    3Q4TSzHMhbee/vgo4HkaHNT8PwfFls995K50K/kdPozAr83Dh6zv98cvQgih/ZWtR1h0wZ
    xho9/8wjRgFg3yQAZ9K47J4Bm15CUib/nlCI5yZxsLjqiPiFEPsjsnNDXJUUv1x6hPQ7uc
    vrigYvDTdpw+KmreeZ//UmbdIQkcO2ULjGhnrGeBBnIF3UcwHE70LMgFnT5Q
X-ME-Proxy: <xmx:n3D9ap-UtjJQphy_1K8LIEK9BoKA90jxxu2xJkR_J8QLY9a6H1m_sg>
    <xmx:n3D9ah8X_SaSSyUmrgWvE1yEDmHLVVnKxsOC1BFV26ICkH7yUJS3gg>
    <xmx:n3D9aiCfx_BAcf0ydR0fmElOWCMO9ZaD_z4-Q9YzZ02NVFPfifNwGg>
    <xmx:n3D9ahyKdF51g6lDDUQkwjZAs36oB1Y_GPZAqieAVAiSwp-3PDkLkw>
    <xmx:n3D9atFJhaed0AN77I58IUyQWJPNUVv_1PvaS19ugwJ5pLYoU9Bl_HRS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 18 Nov 2026 04:32:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a15f3a0a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 18 Nov 2026 09:32:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 18 Nov 2026 10:31:02 +0100
Subject: [PATCH 3/4] builtin/maintenance: only consider `gc.reflogExpire`
 for "--auto"
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261118-pks-reflog-expire-performance-v1-3-10b9263566a8@pks.im>
References: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im>
In-Reply-To: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The "reflog-expire" maintenance task is responsible for expiring reflog
entries that are older than either "gc.reflogExpire" for entries that
are still reachable, or "gc.reflogExpireUnreachable" for those that are
not reachable.

When executed with "--auto", the condition that we use to trigger this
task verifies whether the number of reflog entries that we would prune
is larger than "maintenance.reflog-expire.auto". This is evaluated by
walking the "HEAD" reflog, where we then check every entry by calling
`should_expire_reflog_ent()`. That function will then check whether the
reflog entry refers to a commit that is reachable or not, and depending
on the outcome compares against either "gc.reflogExpire", or against
both "gc.reflogExpire" and "gc.reflogExpireUnreachable".

To decide reachability the caller has to call `reflog_expiry_prepare()`,
which amongst other things also performs a reachability walk for a given
refname. But we don't do that in the "reflog-expire" maintenance task,
and hence every single reflog entry will be considered unreachable and
thus we'd consider many reachable entries prunable even though they
won't be pruned. So we overcount the number of prunable entries quite a
bit and will thus trigger `git reflog expire` even though it won't do
anything.

Now we could easiliy fix that by calling `reflog_expiry_prepare()`. But
in the case of auto-maintenance it has the big downside that we now have
to perform a reachability walk in the foreground, and that may be quite
expensive. The whole point of those auto-conditions is to use heuristics
that are fast to evaluate though so that the time we have to block is
reduced as much as possible.

Instead, adapt the heuristic to only evaluate reflog entries against
"gc.reflogExpire". This of course means that we're now undercounting the
number of prunable entries. But as part of background maintenance that
feels like a reasonable tradeoff, and a user that really wants to prune
unreachable reflog entries can either execute git-maintenance(1) without
"--auto", or they can run `git reflog expire` directly.

In any case, the consequence is that we only spawn git-reflog(1) now in
those cases where it would indeed prune entries. And in my own working
copy of "git.git" that I use daily that results in quite a performance
improvement:

  Benchmark 1: git maintenance run --auto (commit = HEAD~) (10 runs)
                  mean     ±       σ          min     …     max
    Wall Time    385.2 ms  ±     1.9 ms     382.7 ms  …   388.6 ms
    Memory       116.8 MiB ±     0.1 MiB    116.7 MiB …   117.0 MiB

  Benchmark 2: git maintenance run --auto (commit = HEAD) (10 runs)
                  mean     ±       σ          min     …     max
    Wall Time     17.9 ms  ±     0.7 ms      17.2 ms  …    19.6 ms           -95.4%  (21.5x faster)
    Memory        81.0 MiB ±     0.1 MiB     80.7 MiB …    81.2 MiB          -30.7%  (1.4x less)

Note that this improvement can be observed after every single command
that triggers auto-maintenance, so this is overall quite an important
optimization.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 68cb04a672d..d4a1f337a29 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -282,19 +282,31 @@ static int maintenance_task_pack_refs(struct maintenance_run_opts *opts,
 }
 
 struct count_reflog_entries_data {
-	struct expire_reflog_policy_cb policy;
+	struct reflog_expire_options opts;
 	size_t count;
 	size_t limit;
 };
 
 static int count_reflog_entries(const char *refname UNUSED,
-				struct object_id *old_oid, struct object_id *new_oid,
-				const char *committer, timestamp_t timestamp,
-				int tz, const char *msg, void *cb_data)
+				struct object_id *old_oid UNUSED,
+				struct object_id *new_oid UNUSED,
+				const char *committer UNUSED,
+				timestamp_t timestamp,
+				int tz UNUSED,
+				const char *msg UNUSED,
+				void *cb_data)
 {
 	struct count_reflog_entries_data *data = cb_data;
-	if (should_expire_reflog_ent(old_oid, new_oid, committer, timestamp, tz, msg, &data->policy))
+
+	/*
+	 * We only evaluate whether the entry is older than `gc.reflogExpire`
+	 * and ignore `gc.reflogExpireUnreachable`. Evaluating the latter would
+	 * require a reachability walk, and that's simply too expensive in this
+	 * context.
+	 */
+	if (timestamp < data->opts.expire_total)
 		data->count++;
+
 	return data->count >= data->limit;
 }
 
@@ -302,9 +314,7 @@ static int reflog_expire_condition(struct gc_config *cfg UNUSED)
 {
 	timestamp_t now = time(NULL);
 	struct count_reflog_entries_data data = {
-		.policy = {
-			.opts = REFLOG_EXPIRE_OPTIONS_INIT(now),
-		},
+		.opts = REFLOG_EXPIRE_OPTIONS_INIT(now),
 	};
 	int limit = 100;
 
@@ -315,14 +325,13 @@ static int reflog_expire_condition(struct gc_config *cfg UNUSED)
 		return 1;
 	data.limit = limit;
 
-	repo_config(the_repository, reflog_expire_config, &data.policy.opts);
+	repo_config(the_repository, reflog_expire_config, &data.opts);
 
-	reflog_expire_options_set_refname(&data.policy.opts, "HEAD");
+	reflog_expire_options_set_refname(&data.opts, "HEAD");
 	refs_for_each_reflog_ent(get_main_ref_store(the_repository), "HEAD",
 				 count_reflog_entries, &data);
 
-	reflog_expiry_cleanup(&data.policy);
-	reflog_clear_expire_config(&data.policy.opts);
+	reflog_clear_expire_config(&data.opts);
 	return data.count >= data.limit;
 }
 

-- 
2.56.1.831.g720f3f5937.dirty

