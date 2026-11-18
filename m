Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994334;
	b=ZhzgkV+Y+nNu1OkalSKEPuRp80vL8OAn3/FFiLH67B4fH24G6Eh8FTwUpUjsBbon7u7g
	 52UHAF58v3ypFe2knjvJBvNtGnKGmaTJkZCx/bcSPFzr9VCUJlXqMGdG3SUz2KtnBmJpM
	 HqmCHd9GP+atBxa738p71wmWZG7LUilZEm4+WfIWdxoaZ0aT5Ew60ZREFcSVmgEaKMTv7
	 bkhSDxIqY9+QSDoe6XoPQjsGDkNTUt/uThLsA4JRC+87idigRNSJIyLyaigl7YTJodSDO
	 Suk/sfptApWPRa6990+E07RhFwbYO5oWmUmnj9tZkl23KKIOMgPAQWmAX8XN7q28EFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994334;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=+BuLvrZr/YTcQ1XUJH9sYoSxgEPlcv6A0ofW+zDIK0Q=;
	b=UOIdB4VuLG+1V9p4Ld1SNQE4XWKFe7TYvlevupgKd7zR7w9+qcSjx4Owgrqelop68pdI
	 QPKWG/zylQkgyJH/4o2I63Hy95peACYSdZjTfM5tE1TY1Mcw7mICEmoGbjgxGNQZJP8S5
	 k3Tiv0pwA3PN65D1k6vJKgAZtby2b8gJG20DJ964RuOn2791KaKJmVmameTnPjSWPsnGd
	 gcwKhsDAOaJgdCviamaHm8JW7KKKUg/xDlu1+eXFXecvFIZYsId1vU4/Cxm5Okdr829U3
	 b2Lo++R77MMKE79KOwqZLXxJadTGAmNBwn7KqKGrXL43wJzXgo7QTGbE0l/XvCVtcKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Vbvw3gEI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hjlkonh5;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AB0606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 09:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88AB0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Vbvw3gEI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hjlkonh5
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A55C314000F1
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 04:32:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 18 Nov 2026 04:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794994332;
	 x=1795080732; bh=+BuLvrZr/YTcQ1XUJH9sYoSxgEPlcv6A0ofW+zDIK0Q=; b=
	Vbvw3gEIsGGOCTu5hRAqlqepTRliEhr5vzp8Zzf57JHteuVm5dQFngMOceXRN4Qa
	gUf9APn1gqQx0GDfSnvEIiLAFJON44b+a6vWL2OwDo5sG2QaJQt1uS609bOM+0iI
	x7GiGuKLbqB8nOBg3WJ6mT0VIVIzyTbwq7teWM34xcTwqEQUnWK5EAibc6Ltb3L1
	e6S1i5VvxV8oPqzEjDyoGqNlY/SojIbRwev3gzwo4K/N2ea5K/u+pDa6xFt9PHBG
	sqLj8t+JrCbcMtDZZMi5N0sJeX0RS/pJqdxfpTW7dBGNwXShHg4E9XzyLtV/NUMP
	cBc8D4NjMG3W+F9iQvVjvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794994332; x=
	1795080732; bh=+BuLvrZr/YTcQ1XUJH9sYoSxgEPlcv6A0ofW+zDIK0Q=; b=h
	jlkonh57rfjr4UZJSmIJouM7Oac3kO5M2QO4d3LjgZ6vZgSvmcYu0dM9d+ncQdey
	JSSvcudLxCKCDU9X2mV+P+otCI0ImqEYe4dbQo1CazG7qFYzmy0elDz387JSPoBv
	Jt9oIaab9Cx9Gd7ejj6MFUk+kH54rBe5wY0LD01knuCylORaJF8+kPFHS/xbjlaN
	7fV+XOvlWrko82L78FIVYWpwWhrGPITOirhIFAQKzxtqhuuaUY1CpSEdl5JUmh48
	ewj3x4S2QvZf9htgZ1nWwLFTQfyxi0Jr5CO54khNyaUmKzFSDnYSTb5GoqFrfBD1
	OmZLdxQjep01OWVeEL8iw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794994332; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:UfCSF9tT18bWPTrMMkYw7BcyLyR9LX5rbm/RTEyBTpe9T7t
	umoiTOaxqgBZBc7ZJ48fuQ0yJPuWEBcNtl2eKvT3ScfiV2sx9RgLUqcr0UnTf/6+
	jWPrh6fAE+gcCU/2pUfgBrzmYNlSAHninr6Mi/n9YSEZ9sFBbHbF/Xia1vln5Xb0
	Do8adaN92IEhGnMqEXr2fLAv28fzLgHqWV/2h3VwbaYL83FGUVt2nAlW0UsQxIYn
	BQr4jt9hjP4Jux47UJC7yrYhaP85x9fBQWVFHve9Nysglpt8WV3rREIPsqluBW6N
	9EZXLbiWmcUy8kZ9/EWdoZp3YQw4mnvn0Bg+AxQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:fzzYV2QS+ovrvQ6U963rSS9x6Ld2zhGzfkphWLxaXys=:Y0pY7vsS2eJ09Gw/ga2NNDETYJYhRjhUmtGp3UikMtA=;
X-ME-Sender: <xms:nHD9al9b5AUwZJX-vzhFifu3IQ6xZRs20mPzBD5ZUQYNgrhsHHdrPw>
    <xme:nHD9agpWhvCYRpBNcu_efnYc3Yl_KUxKWOyLA5Zd12sx-NfLahVEXQOpJVQ53udIl
    qmNBX9FM_2f2G7eaRCFQZeK_reEAm0MSgc9eMrIuJpWihzHK1kfyQ>
X-ME-Received: <xmr:nHD9aooJ2pOYYXvjxv_KcMNaWSVjM_7lRvhH9wOn4npV3zhucfh0QA>
X-ME-Proxy-Cause: dmFkZTFih1SXnpawd5iO/A2jJwxeb9fIYZ4n1BIOBIT5OGAuLmCkrHxpjTUzi9Yq8UeYRn
    R2wAuOMFojdp8mBoy85bo9fi2fO3jrKA7WjypSkCcpxNHKh38M9YSRAQyw6n54QWzQjIKh
    K4kSr41b9ND12cTo4FHws8isdOQcvY7sk7bvDi6CjQRNA+GRbBOiWisX2QrGZLRcf2LyZA
    qQWXMYOUCj8XGwH5OaWuPoH9CM5HMgepbzHTtFc0vmmkriM9/sjR87gkoWmU4jSYJnX8AX
    6g2P6GgO5DXtwl0Vt2yhvcxOn6TN5D3kGvwynHrBd8LlWDWNSKX5zYN7JPAAFEbWrVjGg8
    WXJpKOHqE2gxvLZ9UhBLWcz68kD7WmuzfpjSBbyWZt1RRSVrJ/vGOaZ3Z7X9Dp0H+ilX2X
    jMKhkhyYw22JB+capoW5i9i+611miot2YfqzDVym3ZYYdnvMLQMq9HZSjhCt6duhr0Wb9t
    w11waiF0qMAjcqvneJ9HTb1Z4c2pRxPvGUn+Fm8A8+tTmK3da7vOnMtPef7WxNysp42Bo/
    r2gDUtXHVq59RtpBrCpAMleEzgSAYHFoUzBkrh+6y+mLEjxnyG3XCxZ7dFyqzQWrFAZJG9
    jamybWwqDRSNnrNK5BDbGw9FdNppE+LpmAhKfGEQmdb/Agdn+zRXAY1eu0TQ
X-ME-Proxy: <xmx:nHD9aumMFbirgVW5c1dR2egej-ISeZkOy13BEJpf_1UZ65QUcUYw2A>
    <xmx:nHD9aqFKt1NQIrOLp-EBUfZ0uoPdLwwWMAnQreZyhMDia0RpMLqTuQ>
    <xmx:nHD9anpZLn7jWBBengNljxLc_9SFvuTkCmP1qju0kHP80s2JZPs84Q>
    <xmx:nHD9am6-lrXte7FGRwDhfiODqpIG3wqkAsUnsDviVzptkz8jTCUl_g>
    <xmx:nHD9apvoGoRv4PeW78xz1wE5IMdUeNF2zhkCV9_QY4SUYgLaEYjRvMTd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 18 Nov 2026 04:32:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 62286cdb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 18 Nov 2026 09:32:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 18 Nov 2026 10:31:01 +0100
Subject: [PATCH 2/4] refs/reftable: don't write new table when expire is a
 no-op
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
Message-Id: <20261118-pks-reflog-expire-performance-v1-2-10b9263566a8@pks.im>
References: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im>
In-Reply-To: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When executing `git reflog expire` we may of course end up not expiring
any reflog entries because none of them are older than "gc.reflogExpire"
or "gc.reflogExpireUnreachable". But even so, the reftable backend would
end up writing a new table to disk anyway that contains basically an
exact copy of the current reflog. And with the "--all" flag, that would
happen once per existing reflog. This doesn't result in any correctness
issues, but it is of course a lot of pointless busywork.

Skip writing and committing the new reftable in the case where there
aren't any changes, which results in a nice speedup:

  Benchmark 1: git reflog expire --all (commit = HEAD~) (10 runs)
                  mean     ±       σ          min     …     max
    Wall Time    736.0 ms  ±    11.7 ms     720.0 ms  …   752.3 ms
    Memory       117.2 MiB ±     0.1 MiB    117.1 MiB …   117.3 MiB

  Benchmark 2: git reflog expire --all (commit = HEAD) (10 runs)
                  mean     ±       σ          min     …     max
    Wall Time    370.3 ms  ±     3.7 ms     363.4 ms  …   375.6 ms           -49.7%  (2.0x faster)
    Memory       116.8 MiB ±     0.2 MiB    116.5 MiB …   117.1 MiB           -0.3%

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c    | 15 ++++++++++++---
 t/t0610-reftable-basics.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 4216a18684d..e2027bb9c02 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2607,6 +2607,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	struct strbuf referent = STRBUF_INIT;
 	uint8_t *last_hash = NULL;
 	size_t logs_nr = 0, logs_alloc = 0, i;
+	bool has_changes = false;
 	unsigned int type = 0;
 	int ret;
 
@@ -2696,17 +2697,25 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 				    logs[i].value.update.message,
 				    policy_cb_data)) {
 			dest->value_type = REFTABLE_LOG_DELETION;
+			has_changes = true;
 		} else {
-			if ((flags & EXPIRE_REFLOGS_REWRITE) && last_hash)
+			if ((flags & EXPIRE_REFLOGS_REWRITE) && last_hash &&
+			    memcmp(dest->value.update.old_hash, last_hash,
+				   ref_store->repo->hash_algo->rawsz)) {
 				memcpy(dest->value.update.old_hash, last_hash, GIT_MAX_RAWSZ);
+				has_changes = true;
+			}
 			last_hash = logs[i].value.update.new_hash;
 		}
 	}
 
-	if (flags & EXPIRE_REFLOGS_UPDATE_REF && last_hash && !is_null_oid(&oid))
+	if (flags & EXPIRE_REFLOGS_UPDATE_REF && last_hash && !is_null_oid(&oid)) {
 		oidread(&arg.update_oid, last_hash, ref_store->repo->hash_algo);
+		if (!oideq(&arg.update_oid, &oid))
+			has_changes = true;
+	}
 
-	if ((flags & EXPIRE_REFLOGS_DRY_RUN)) {
+	if (!has_changes || (flags & EXPIRE_REFLOGS_DRY_RUN)) {
 		ret = 0;
 		goto done;
 	}
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index a7027458395..d808f1887f6 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -912,6 +912,36 @@ test_expect_success 'reflog: expiry empties reflog' '
 	)
 '
 
+test_expect_success 'reflog: expiry without changes does not write tables' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit A &&
+		test_commit B &&
+		test_commit C &&
+		cp .git/reftable/tables.list expect &&
+
+		git reflog expire --all --expire=never --expire-unreachable=never &&
+		test_cmp expect .git/reftable/tables.list &&
+
+		git reflog expire --all --rewrite \
+			--expire=never --expire-unreachable=never &&
+		test_cmp expect .git/reftable/tables.list &&
+
+		git reflog expire --all --updateref \
+			--expire=never --expire-unreachable=never &&
+		test_cmp expect .git/reftable/tables.list &&
+
+		git reflog expire --all --dry-run --expire=all &&
+		test_cmp expect .git/reftable/tables.list &&
+
+		git reflog expire --all --expire=all &&
+		! test_cmp expect .git/reftable/tables.list
+	)
+'
+
 test_expect_success 'reflog: can be deleted' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&

-- 
2.56.1.831.g720f3f5937.dirty

