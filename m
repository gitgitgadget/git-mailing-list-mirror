Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793058581;
	b=fIrp8i/jUIuEesFMbE+F35gglN7b+udpaS0mbaharDjKs3JHlcBDj3GRV/Q+ChpqaTPz
	 xKGqMrkBRsngiNM5aN/TR0Wkm5zb0d2+9OtO1N3cLhllbKKtAQBUxFsRvp0Uk3aVq3ekQ
	 lvQkbhXxB952SuHT9gQDdtCh89z/9wcBcV42PFDS3YWGdwf3ZTaGSMtLBAzVpoI2OZ0CH
	 YdMpkulQRVN0YgMuqhI2yEeAZKMn2TB5VAnaVTfB8UVlTZSn/4UT+nu6M27c46l29ee9y
	 Egg4f1dckDsdkJHfkTJn1r9DmjzYOPsMRCtYVo6R+6m2p6HHiB+Qvw1oKB3KvZUUitw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rMXrfRcTTuutfsXhdXf6Lkc4cOSn6817zfH2f3n76hI=;
	b=Ho1JJLz+daNAFmMy8Jac+zEw2IFTEor7V0B0KLWHYN/TuBgpW47ZLLs47VK1LleOF2Yd
	 4a1DTF9l7rrUUGdUYJsb/LKZAr6oDy1XBQnAQSKnowrfMpdvnQpsv2MRGAFxVymbDVdFa
	 7ccuCK6bescSJGo/snJRdnDfq8RTRGiivrFpP9GBztRgSN6fEyClqOdxo5kolK4JYMGxF
	 Z61AHXcIFRCVfHISQChCklSG6/yZmp3DIY0ViFb+8e694rqyX5IlYSQvhFAbETtUKKjDx
	 DcKgkjSfc3uRX0Y2PXGe2xl2Ctan2j+ImRe+OpPl3KAZh3G81sRzQfuXR7eFdxo2FYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=ZnqQdSYg;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07457606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 23:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07457606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=ZnqQdSYg
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93efc0452b5so236177385a.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 16:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793058580; x=1793663380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rMXrfRcTTuutfsXhdXf6Lkc4cOSn6817zfH2f3n76hI=;
        b=ZnqQdSYg9dwC3FcnAHjqli1dlZzTxvWpnOmDLiZpPy/SqB4t1YU7DZ8O/TiWwJXVV/
         viizeNYfwamOUmbTXE30vgt1ZWN1gBnNd8COlKbanvvIGdYBjix/QGz1loFPr4Y1KQnr
         YIQdzwHc9y+fHh43aosOmRXqquXX54UlKdVYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793058580; x=1793663380;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rMXrfRcTTuutfsXhdXf6Lkc4cOSn6817zfH2f3n76hI=;
        b=svMVmrEgGek5h+qGFxHpl8Dno9NZyE9qdfOLBD2R6QdOF4xh/w/CQre3EI6EUEdq1z
         5iSX2sOheRFjjZYgg3kz99SCSm78N7/MMewYafYBdrv9Iwn8NctIg/bzCZP5c6CZt7/9
         2xyVCq04VsmC3ZYij1qUTUt8VnFL9grbZyXyg0E4DhF75UL5Is+u7KHCFUOvrwYXrdxb
         y0HwWFAg0YQgHNR3s4eLKV0YLfm6qdOib8uCujDijtrp9h3XIbIQr6bxED5rIDUf0lcO
         sM/do4xmh1W09AWa4a6l4+K0G0igO/aZ96Bud+ctYirUgEaBfZsLevJlpqioQjF7fl3b
         A0uw==
X-Gm-Message-State: AFq9FYKRji0ITHXJJ6nRxgXjLbntkiwouGt47Gypk1xVp+ahsCe9TTdC
	edajls4U/oAy6XrayPREU+Z40nIwtcvZgIy50D1r74hikp4LwhRnD10h649d5wSsvGRex5tnl4W
	sMCMYzlY=
X-Gm-Gg: AYBFou13sD7KoukKPA3HM89BM9hnqsPHY8QBeFT65+tKhoZU5PZ0E0VNYe0GMDoxYnF
	+B/FhVQq62BQfWRCxeYIBFmeujxyL/Tp0BbxEM0Wd1PBXcr3WsMD938Pz2EltuVA151L8i1yDgY
	Un2fax7sdLwpgy1laiRy/SsO2zZKgKHrO0v3W8uxWCD1WKQtCTn50QAgSXWZkcStdRzd8UZVBa6
	kuUB+7C0MNwYU+xZVi0//N87bFoylAro75b/Hf/9KU+N8GycI6i4jZT/bS3V/JD13y87Vo4OTKU
	ZAVmZhipOqaN+RCAWeC4hjnpvg0RjjQLu8Ml6cljELVtoZC1LfCsq0PWSYq7qHXQoVPn9vI4ZnV
	ZRkV+SD9AKietkJlxsXV2E88KI4VOqL4Pw4wQCMLW1zDXnp0EDgVn4ZZDd7j6ahPNBQ8b4TscS3
	SDj0HElCR1Xkv3ztmu3Ka/Mh4xORN9wxl2kNwId8mhjjkPUGkoWnDvGyRex9oz0DVrhVctIrOOd
	6WRzFEXJOW8fPLNLl31flKmrIKCTPDOKeXAfxb+Pi2pYPgm6eN+qOk04fUv0kAXQKRO4ObMzD8e
	xTb9AutOJzSoTYWfhq0eyoLyGuC3ReU8jXthBvCCrjhA03N/JXIS59a1bNujXG6obTc4vB0Z4xj
	cYZQX5DnT/ZbAJnHp7KsgvtTxFLMvKjpmKgHXVkikNw==
X-Received: by 2002:a05:620a:3181:b0:93f:3576:d428 with SMTP id af79cd13be357-940ef914191mr1344566385a.22.1793058579867;
        Mon, 26 Oct 2026 16:49:39 -0700 (PDT)
Received: from com-79390 (vpn-eastus-02.tradc-corp.com. [20.102.114.220])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f06690c0sm829886685a.11.2026.10.26.16.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:49:39 -0700 (PDT)
Date: Mon, 26 Oct 2026 18:49:37 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Derrick Stolee <stolee@gmail.com>, Ted Nyman <tnyman@openai.com>,
	Daniel Reynaud <dreynaud@openai.com>,
	Aaron Friel <friel@openai.com>
Subject: [PATCH v3 1/2] negotiator/default.c: mark commits seen only after
 parsing
Message-ID: <5a6af9166354f0c0d0c229f0ed57b495af24090c.1793058562.git.ttaylorr@openai.com>
References: <dc3dfa3647c42da9170bf3289f4e8a4a8a55c8e2.1792441003.git.me@ttaylorr.com>
 <cover.1793058562.git.ttaylorr@openai.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1793058562.git.ttaylorr@openai.com>

rev_list_push() sets SEEN before parsing a commit, but leaves the commit
out of the queue if parsing fails. This makes SEEN describe an attempted
insertion rather than a commit that was actually queued.

mark_common() relies on SEEN and POPPED to decide whether a newly common
commit contributes to non_common_revs. If a missing parent is marked SEEN
and later reached while acknowledging one of its children, mark_common()
subtracts it even though rev_list_push() never incremented the counter.
This can stop negotiation while other non-common commits remain queued.

Set the requested flags only after parsing succeeds. Successful
insertions are unchanged, and a failed parse no longer marks the commit
as queued. This also lets the skipping negotiator follow the same order
when it starts parsing commits in rev_list_push().

Add a negotiation-only fetch test that fills the first batch with commits
above a missing parent, leaving an older, unrelated tip queued. The ACK
for the first branch must not stop negotiation before the second tip is
sent and acknowledged. Before this fix, the second tip is omitted and
the negotiation-only fetch fails.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 negotiator/default.c   |  3 +--
 t/t5702-protocol-v2.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/negotiator/default.c b/negotiator/default.c
index 19cdf3808cf..32cba7ed8d9 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -26,11 +26,10 @@ static void rev_list_push(struct negotiation_state *ns,
 			  struct commit *commit, int mark)
 {
 	if (!(commit->object.flags & mark)) {
-		commit->object.flags |= mark;
-
 		if (repo_parse_commit(the_repository, commit))
 			return;
 
+		commit->object.flags |= mark;
 		prio_queue_put(&ns->rev_list, commit);
 
 		if (!(commit->object.flags & COMMON))
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 7e69ba7f843..b1768cbdbc5 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -912,6 +912,37 @@ test_expect_success 'file:// --negotiate-only' '
 	test_grep "$COMMON" out
 '
 
+test_expect_success 'negotiate-only continues after ACK with a missing ancestor' '
+	rm -rf server client &&
+	git init server &&
+	test_commit -C server --no-tag b &&
+	git -C server branch b &&
+	git -C server checkout --orphan a &&
+	test_commit -C server --no-tag missing &&
+	missing=$(git -C server rev-parse HEAD) &&
+
+	# Fill the first batch with this branch, leaving b for the next one.
+	for i in $(test_seq 16)
+	do
+		test_commit -C server --no-tag a$i || return 1
+	done &&
+	git clone --no-hardlinks server client &&
+	# Force a parse failure in the client. Keep the parent on the
+	# server so it can acknowledge the branch normally.
+	rm "client/.git/objects/$(test_oid_to_path "$missing")" &&
+
+	# ACKing a must not count the missing ancestor as a queued commit
+	# and stop negotiation before sending b.
+	git -c protocol.version=2 -c core.commitGraph=false \
+		-c fetch.negotiationAlgorithm=consecutive -C client fetch \
+		--negotiate-only --negotiation-tip=a --negotiation-tip=origin/b \
+		origin >out &&
+	git -C client rev-parse a origin/b >tips &&
+	sort tips >expect &&
+	sort out >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'file:// --negotiate-only with protocol v0' '
 	SERVER="server" &&
 	URI="file://$(pwd)/server" &&
-- 
2.56.0.187.g9e9ae442333

