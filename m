Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792441037;
	b=BKCSEE+2nlx3oBM2/Hf/mxlufMSovO34Pcd3LgP9UznASYmG8ywyYoRk+KDuXL1d/39w
	 8EVZde0DFM/TXovoMIhkYCxP1ctQH8muX/29/28ytNpi3Mt7RsuQHO7kuJITvDJJ8DpGr
	 tfdDb6eWn64ijjnQFUJIdM1LUyd1odsALRpAOL0uQUM954NQ6IBBGb4JXCCDKavE0KlXu
	 SpN0qVlTM09AAPu8fUI+gmMeUNUrf7yjIS1Bu7esflAgtPcLzHi/M78+VqEZGxmAGbt9D
	 v+pW8ynsvD53VhiC3AvYj+d86H9fNvsK9TsX3xJjPenlZmwGPROpCy+EsaszkjqpkiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition;
	bh=hqaLOJ4XCEj3IyoKT+SEnlFBnRoLBdtJOoMuPqK4qXM=;
	b=oVfuUXfd2dsQfemwqn4spPoEDg3En4EK8ktWD+L45MpBXenIPtivana/cO9yKCRXALNQ
	 kJxt7FJYbfpiwyA+UKXi2C9LHRUYu/FCfVM59mGnReSo1bEmtIhPG1nAmdhjk86yjPD0x
	 gODLDqAHBytUffOv7s3FT5L5gFc20SRA0jTYTxvLUWVQZOa2jYV8+s/Gf2vzx7sGcitwb
	 Vl1PWpy3hzTVkAtscLDgwVCCboi1B5jfuBu4W8CwQbk4jMnXzNnqsImyIhspKw5WA+WuQ
	 04rUiiTm8rQhXq6LXcCYI6Qxv+PAoS5GjhV0qKkrpPUPI8K9EyccdHQbPcAJjbAmIKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=JA80pW0Y;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4C2606A31C
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 20:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF4C2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=JA80pW0Y
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-706113e92f9so712038eaf.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 13:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1792441036; x=1793045836; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:date:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hqaLOJ4XCEj3IyoKT+SEnlFBnRoLBdtJOoMuPqK4qXM=;
        b=JA80pW0Y7WIP7pFOInd9zthnwMmE9NE+OlIVvJnLm2A/PzaemlKTUcVRkNSQ8/ymAF
         3c+yxlQSH8kCE9p0CAP3Z1AyVOeDa1pONBwRA21eEihLDMLNBKNQVB1lkr8ehMUaW14e
         UTGxzuI4l7VyObCgBy3OUqoGFSCPNCbIcOh2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792441036; x=1793045836;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hqaLOJ4XCEj3IyoKT+SEnlFBnRoLBdtJOoMuPqK4qXM=;
        b=OrCcpalHxN/jbDWlu3tkvjbgxski4K+Fr+Dj5Nk/DcE3PVUegOYYUCmS2R5IGDo2tN
         Ct/zeikv2E+cghEa4jbf931DflW4nx8MYF1cqQEpqReuvLXC3pBTCI7B4qooEuqAsgoC
         d1qSGnuaIuQHVNMqiPdSs3C0w91MbeY/NEGQ/anL9LQhjtQfePiC3lv+pcRyKsL/d2cg
         9aCKpD/vMRGby/107VJQRLHbVfdN3zuRonsTEY2vHVGsRgY/ICJQI30dFS80ywvU6JF/
         WQQ4wNMBKUtZXDkiYGruBmOT3PIpEWozFhUiYC1TTZ1Wtgr2A1muveGr7Mv6EIB1cfWm
         JqTA==
X-Gm-Message-State: AFq9FYLvTeFMU0Jo/5NhoenhHYwY01X0gHLjdWSwmHvxHTQZJsOEctw6
	70XDesqEuYtdOUUJ+qmUo8INQm025AB4MBihzrwPF74DnzO3AoC3cNEMrKoMEEqRQb9IkTYqnht
	QPWSobxA=
X-Gm-Gg: AYBFou3HQPQhEtzDDDpvQfptzP3/539tNkpxq9K4l6pvYXSjbFHeZF5bmawll+QbbL1
	4w4hrxaTrB4iyQ5CqBtDqnLEhZtHoLpnlJabPtWguJRAp4AIISniVMzQq30hw/LFtfvlOgojhoO
	1F2pvD8zQKXuWRUWFTvCHPOS94yullCTr0Bh04Lnl9dDHXM5x7iIf4ApAs95qxDFvEryteYL0kV
	WpgkgoCxKXaDhyoRPdzto6igOJu35EDggrWk9C8jcue+5Z7mbSlpxm0Jq6IwmKseuBVimwdTWIG
	0yR46bcDSQ5CaQT8s/ioC3Ihfc/up9qz592NrT17Fisf9Ey5C198vpagWiLzr0GlziDodRxvwg1
	axR5F9Y8LgYip59HbHXj+2FFrEBqe7ldxKz6sAHi8KPNxsguuhjonzOySL4sfNDTPc77T+YeThe
	aUEAjfrDvUsKeVU/4Evq/gh/rswZU03j7LnwSq6BrG1ZifEn27RSamarjuBBS2rMM7igDSKrQM9
	QiyhRBQNz+VMwT2NsALuTwXUSpkgWUxUfgXxOymTw7GjB9nwGAoy1ULrUk80obfpeQaB8jxDBdX
	/z11Fe4Z
X-Received: by 2002:a05:6820:1624:b0:6f4:d9d4:3940 with SMTP id 006d021491bc7-70352297c47mr6169830eaf.6.1792441035736;
        Mon, 19 Oct 2026 13:17:15 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7018f3d5d84sm8321235eaf.8.2026.10.19.13.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:17:15 -0700 (PDT)
From: Taylor Blau <ttaylorr@openai.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date: Mon, 19 Oct 2026 15:17:07 -0500
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Derrick Stolee <stolee@gmail.com>, Ted Nyman <tnyman@openai.com>,
	Daniel Reynaud <dreynaud@openai.com>,
	Aaron Friel <friel@openai.com>
Subject: [PATCH] negotiator/skipping.c: parse parents before queueing
Message-ID: <dc3dfa3647c42da9170bf3289f4e8a4a8a55c8e2.1792441003.git.me@ttaylorr.com>
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

From: Taylor Blau <ttaylorr@openai.com>

The skipping negotiator sorts its queue by commit date, but
`push_parent()` can add a parent before parsing it. Its date is still
zero, so old ref tips go ahead of it.

For example, suppose a topic branch is one commit ahead of master.
Skipping offers the topic tip and skips master's tip. Master's parent
then waits behind old ref tips. With enough old refs, negotiation can
end before we offer that recent common ancestor.

Parse each unseen parent before adding it to the queue, so the queue
uses its actual date. If parsing fails, leave the parent out of the
queue.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 negotiator/skipping.c                |  5 ++++-
 t/t5552-skipping-fetch-negotiator.sh | 33 ++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index db90fa77b53..ed6e88b59b4 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -125,7 +125,7 @@ static void mark_common(struct data *data, struct commit *seen_commit)
  * entry has the correct flags and ttl.
  *
  * This function returns 1 if an entry was found or created, and 0 otherwise
- * (because the entry for this commit had already been popped).
+ * (because the commit could not be parsed or its entry had already been popped).
  */
 static int push_parent(struct data *data, struct entry *entry,
 		       struct commit *to_push)
@@ -151,6 +151,9 @@ static int push_parent(struct data *data, struct entry *entry,
 parent_found:
 		;
 	} else {
+		/* Parse the parent before using its date to order the queue. */
+		if (repo_parse_commit(the_repository, to_push))
+			return 0;
 		parent_entry = rev_list_push(data, to_push, 0);
 	}
 
diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index 96e224168eb..7a0b9b32474 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -223,4 +223,37 @@ test_expect_success 'do not send "have" with ancestors of commits that server AC
 	have_sent b2.c1 b2.c0
 '
 
+test_expect_success 'recent ancestors are sent before old ref tips' '
+	rm -rf server client trace &&
+	git init server &&
+	test_tick=2000000000 &&
+	test_commit -C server --no-tag base &&
+	test_commit -C server --no-tag parent &&
+	test_commit -C server --no-tag main &&
+	git clone server client &&
+	test_commit -C server --no-tag to_fetch &&
+
+	git -C client checkout -b topic &&
+	test_commit -C client --no-tag topic &&
+
+	# These old tips have known dates, but the recent parent has no ref.
+	# Without parsing parents before queueing them, its date is zero and
+	# all of these tips are sent first, delaying it past the first batch.
+	for i in $(test_seq 32)
+	do
+		old=$(echo "old $i" |
+			GIT_AUTHOR_DATE="1000000000 +0000" \
+			GIT_COMMITTER_DATE="1000000000 +0000" \
+			git -C client commit-tree HEAD^{tree}) &&
+		git -C client update-ref refs/heads/old-$i "$old" || return 1
+	done &&
+
+	test_config -C client fetch.negotiationalgorithm skipping &&
+	trace_fetch client origin &&
+	git -C client rev-parse HEAD HEAD~2 >expect &&
+	sed -n "s/.*fetch> have //p" trace >haves &&
+	sed -n "1,2p" haves >actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
-- 
2.56.0.187.gdc3dfa3647c
