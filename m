Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503634;
	b=Sg8+0rTg3H4BfQeLZ4AWpQT82UU3ZgoTaegsQtahfmg8NAtQbtTkzLExH3pNXHQMxBG+
	 N19JdYm39OrMFYZf6FMz9D83w/lX6p6JSIk00HNLYl+lG548KczfmHrmflhe8VGQ7eH4H
	 9NmAlGkGTHoTEP43GDLtv3InBSacEg7lU7T+zdtn7Ea4s8e/y5e5r/PQYTOo7D8GVpW7F
	 oKf/TUbpIosjTwwFXMIltferneSTgCEl0kR2zGtTmiagr3Qmr0qESTieQHBc08ih+8hyV
	 q7HvTuXchgtT/+6pCUHmgdK7JJSgiXktnQujiCgpAgJJtp7bCtXiEqw5M7pgxomXEIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503634;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=v2WeF8pIXcdFBoEywPxbASiM/WiVMyJ1r9o57ZN6uoE=;
	b=ROzKiCvhdAOCfli1tosApOyyFPHVf13n6iUulo7bO3RyvkmHKovGs1+XXanPZCcikBYM
	 prLc2Ax532IceOc88xhCTRO3s4r6FX0l66VtL1RJVWwq1YtJZRFv+jgEtvE0kiW0SbdMr
	 oLHFezmE8tFNMdCspayCQRQlO709UrurDQFGaM0scjeU0LX5h/Gz7n55DL+hGXID/Wtim
	 Lgi8abRFqKT2emnSnIob+bybXEGwx+8AL5VSq7UAOeLgzsTJf7IPITLN74Y+NLsX/J4g2
	 smTkAUP5E2aRlrZSv3uxckX4eFNA0a4L3OqrcApQsDaX+gGLq7XQK/07IqB6WmkI9Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hxJmpwQi;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEA2606A32D
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFEA2606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hxJmpwQi
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-81ae6aefdceso2899235a34.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792503633; x=1793108433; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v2WeF8pIXcdFBoEywPxbASiM/WiVMyJ1r9o57ZN6uoE=;
        b=hxJmpwQi9XJiDBg9FEjI6RWnL/Qm9CRRJWDqE3TdpaXwN6UVLxZk0yp3FPoHMztvLZ
         7iHKXF1AEmR2ZvuBjmzM4Ul2OyVqn6zENzJEDnyQg2BodA0GerMhx2e0BDhBPedsIAZe
         14F01CDOCf/k5+Ap2I/cnFjB/BobZaZEqSlwV/u8jdVSiijx/XjolqIjwwKz48ilU5UM
         9dWF+HSmBXHdvJBZNrZKd6cqHd0KEOmPY0Ig++1r/4ZNsxxrw/WLZWehFDtS3I4MwyBe
         3IqRF6Q3Ys0WDAMaBlfk+Ja/zfY7d8ynbUBbkHeMts8pAuKW2g+ammk0TYByI3tqihla
         svLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792503633; x=1793108433;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v2WeF8pIXcdFBoEywPxbASiM/WiVMyJ1r9o57ZN6uoE=;
        b=QxNAxAz4AJz+SJRKXghfE/FPeLUP9J2419oKAuInciG/gA0lNwNsqXZdzu0+Zef0lC
         vXbWuVg91VZn8wWhevfYjpqySVhuhH5F94yVwoNo+vQTEXiRJXv/CXgTHDriD5lJIUmG
         ggIs56mDBq/HH92z6n3Wfs0kbRKnZdqMLuJYjAcIRjY8WZwnXGcJ+FH1EEp/cjwiNkhw
         ER9nAi6aIFUqI+5o+/hC6e4AG4ZkEx4K+TS59C5S/r+PKHmFQIgqPfsEGBEKA/O0/2y1
         HG1U35qDU3vUDfoL8uvRAsJ5ou/zAEDOOf2fm8j6BB79OONc95cofTSN9Uqj28xrM0+h
         6X3Q==
X-Gm-Message-State: AFq9FYI6u/PumQC77Nf8eGUigt6qY3YOfT4IF3+K7D9d7YDtWQR3P433
	5wDetC+A/Vhju1QfK2Wd++/vlqNCkQCnM3XFulr5pE/uiRh7kzclArIAtQ2SQw==
X-Gm-Gg: AYBFou0l/7QwIJme6VfLkuL6N36svwKwR/OF4KskQWiQwbkzk8TfJ9mfEG1APPtqP/A
	f+W6yFjAWtuK88JreaFCRsqko/6aQ7sZdZ1NpfRTiXCFH6Nf1gcVCLLDtsF9jPePPX62WYMv+dn
	BZnjvV5kbSzxB/kCKxGsYMEi3NY9EuW5NCFtcw1iYETdVG3dZUxY2Q+mHPrtaEFRRGfS+9i4Jdr
	t1Ec0cjgoB8gbeksVpEWakKlpMuxTboevTjc9xIY8RIydx3ooHImaz3qntN39ezj5Ii1tPYr3l8
	xpee/5nFWb5ufoX5WAm4UEuTnTAn7YjbNAsCqM2i70pc8gtNXJYrxzHjuPy/iLrAL04Boc4w3yu
	lhwBkUrLRlagNiVtniDkaWCyeEnaZMucNdbpBCrcCV4x0A/8dX2rk9//uxZTT88ZTAyDmfw1+WU
	a1IEcWJaQ93P2x6Jqtz7cDTfzlsNj/tZvRmeGxkBvV9yWgXgBcUG4Mzwmeyi16VvXvog5hFXwCF
	w==
X-Received: by 2002:a05:6830:a141:10b0:845:8d86:9f8d with SMTP id 46e09a7af769-8458d86dbcamr6187527a34.8.1792503632652;
        Tue, 20 Oct 2026 06:40:32 -0700 (PDT)
Received: from [127.0.0.1] ([40.74.204.255])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8490e8cfbc8sm5566929a34.6.2026.10.20.06.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:40:31 -0700 (PDT)
Message-Id: <pull.2455.v2.git.git.1792503631364.gitgitgadget@gmail.com>
In-Reply-To: <pull.2455.git.git.1792275106640.gitgitgadget@gmail.com>
References: <pull.2455.git.git.1792275106640.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Oct 2026 13:40:31 +0000
Subject: [PATCH v2] upload-pack: fix slow fetches from a shallow repository
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Fetching from a shallow repository with a long history can hang. In a
homebrew-core clone with 900k commits, fetching one new commit into
another clone took 7 minutes. The same fetch over protocol v0 takes
about a second.

Over protocol v2, the server goes through all of its history to work
out which of its shallow commits to tell the client about, and a
history with many merges makes it go over the same commits again and
again. Protocol v0 lists all shallow commits and lets the client sort
them out.

Do the same in v2 when the client does not ask for a depth. This also
makes `git clone --reject-shallow` refuse a shallow repository over v2
in every case, as it already does over v0. For `git fetch --unshallow`,
which still needs to go through the history, visit each commit only
once.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    upload-pack: fix slow fetches from a shallow repository
    
    Fix git fetch hanging for minutes when the remote is a shallow
    repository with a long history.
    
    Changes in v2:
    
     * Fix fetches with sideband-all by writing the shallow lines through
       the packet writer. Add a test that clones from a shallow repository
       with uploadpack.allowSidebandAll set.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2455%2FHaraldNordgren%2Fupload-pack-shallow-walk-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2455/HaraldNordgren/upload-pack-shallow-walk-v2
Pull-Request: https://github.com/git/git/pull/2455

Range-diff vs v1:

 1:  4f4192120c ! 1:  8b0cb4c0e0 upload-pack: fix slow fetches from a shallow repository
     @@ shallow.c: static struct commit_list *get_shallows_or_depth(struct object_array
       				**depth_slot = cur_depth;
       			}
      
     + ## t/t5537-fetch-shallow.sh ##
     +@@ t/t5537-fetch-shallow.sh: test_expect_success 'clone from shallow clone' '
     + 	)
     + '
     + 
     ++test_expect_success 'clone from shallow clone with sideband-all' '
     ++	test_config -C shallow uploadpack.allowSidebandAll true &&
     ++	test_when_finished "rm -rf shallow-sideband-all" &&
     ++	git clone --no-local shallow shallow-sideband-all &&
     ++	(
     ++		cd shallow-sideband-all &&
     ++		git log --format=%s >actual &&
     ++		test_write_lines 4 3 >expect &&
     ++		test_cmp expect actual
     ++	)
     ++'
     ++
     + test_expect_success 'fetch from shallow clone' '
     + 	(
     + 	cd shallow &&
     +
       ## upload-pack.c ##
     -@@ upload-pack.c: static void send_shallow_info(struct upload_pack_data *data)
     +@@ upload-pack.c: static void send_wanted_ref_info(struct upload_pack_data *data)
     + 	packet_writer_delim(&data->writer);
     + }
       
     - 	packet_writer_write(&data->writer, "shallow-info\n");
     ++static int send_shallow_graft(const struct commit_graft *graft, void *cb_data)
     ++{
     ++	struct packet_writer *writer = cb_data;
     ++
     ++	if (graft->nr_parent == -1)
     ++		packet_writer_write(writer, "shallow %s\n",
     ++				    oid_to_hex(&graft->oid));
     ++	return 0;
     ++}
     ++
     + static void send_shallow_info(struct upload_pack_data *data)
     + {
     + 	/* No shallow info needs to be sent */
     +@@ upload-pack.c: static void send_shallow_info(struct upload_pack_data *data)
       
     --	if (!send_shallow_list(data) &&
     --	    is_repository_shallow(the_repository))
     + 	if (!send_shallow_list(data) &&
     + 	    is_repository_shallow(the_repository))
      -		deepen(data, INFINITE_DEPTH);
     -+	if (!send_shallow_list(data))
     -+		advertise_shallow_grafts(1);
     ++		for_each_commit_graft(send_shallow_graft, &data->writer);
       
       	packet_delim(1);
       }


 shallow.c                |  3 ++-
 t/t5537-fetch-shallow.sh | 12 ++++++++++++
 upload-pack.c            | 12 +++++++++++-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/shallow.c b/shallow.c
index 8e244a5669..921db5e17a 100644
--- a/shallow.c
+++ b/shallow.c
@@ -209,7 +209,8 @@ static struct commit_list *get_shallows_or_depth(struct object_array *heads,
 				*depth_slot = xmalloc(sizeof(int));
 				**depth_slot = cur_depth;
 			} else {
-				if (cur_depth >= **depth_slot)
+				if (depth == INFINITE_DEPTH ||
+				    cur_depth >= **depth_slot)
 					continue;
 				**depth_slot = cur_depth;
 			}
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index f323ceebd2..140d5c2dba 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -43,6 +43,18 @@ test_expect_success 'clone from shallow clone' '
 	)
 '
 
+test_expect_success 'clone from shallow clone with sideband-all' '
+	test_config -C shallow uploadpack.allowSidebandAll true &&
+	test_when_finished "rm -rf shallow-sideband-all" &&
+	git clone --no-local shallow shallow-sideband-all &&
+	(
+		cd shallow-sideband-all &&
+		git log --format=%s >actual &&
+		test_write_lines 4 3 >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'fetch from shallow clone' '
 	(
 	cd shallow &&
diff --git a/upload-pack.c b/upload-pack.c
index 197bcfa279..e6dc19526c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1709,6 +1709,16 @@ static void send_wanted_ref_info(struct upload_pack_data *data)
 	packet_writer_delim(&data->writer);
 }
 
+static int send_shallow_graft(const struct commit_graft *graft, void *cb_data)
+{
+	struct packet_writer *writer = cb_data;
+
+	if (graft->nr_parent == -1)
+		packet_writer_write(writer, "shallow %s\n",
+				    oid_to_hex(&graft->oid));
+	return 0;
+}
+
 static void send_shallow_info(struct upload_pack_data *data)
 {
 	/* No shallow info needs to be sent */
@@ -1720,7 +1730,7 @@ static void send_shallow_info(struct upload_pack_data *data)
 
 	if (!send_shallow_list(data) &&
 	    is_repository_shallow(the_repository))
-		deepen(data, INFINITE_DEPTH);
+		for_each_commit_graft(send_shallow_graft, &data->writer);
 
 	packet_delim(1);
 }

base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
-- 
gitgitgadget
