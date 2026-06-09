Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DCA233942
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780972345; cv=none; b=TXSlwpvIhOm/W5q4QCg8MvfyTkqF+FXn4d8j2RkzPZF0PVmAxd0S7BLx/peBfmT/3hZsFADz5lXNLp877dLZObeph0na9diKdLqDapxsHAJjKSXXHNTSu1fS1YbfbvieO9HKXnyl1F/qroZGVLbCWUZwmNgV1txKb3r5IJsviz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780972345; c=relaxed/simple;
	bh=HsjULw8/EMFGrz+vXDu4JGlwoYGVmFhirPyaYE7t8wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a8su8kS5GZIfqX5xmmlGSt4qjzWdBjZcVr/uonuoJzxfV2QPeP9OkCRs3jvBYBwl/lVq4OKLNdGv8kU3zzjB7Ejd0Z7957Gha9rQxwuKY4jm9vYQOYACPxiW+kR4KDhvd7Ue9RJdFim0Sw4EIaGITHNrjZ0M82cesCgvP36dDWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNumOjax; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNumOjax"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ce9df4732cso52735646d6.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 19:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780972343; x=1781577143; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TfNMWF7tJbhVj/IYr5cDCAosnp1qCT5daHavwJqg6r4=;
        b=XNumOjaxgCvYRhHjjCWcyUaA2Qr3t8TDAS5d1J2SPR5xoTBlplKQXoYf6/v/ao2DZ4
         l4inggm3dXjmgz2GUo9/et6qI1luhmAusImDrMWlN8y3ytmLHWEasLFB9xwrxAfGPaow
         W7h9xF39KD4/ECqP5bFmu3a5ClYD3QOWL3eaRRK3FangSFhg8ScnyOi3p9p9LtYpSRg4
         EM7PsbjgLCPby6knWQMmIM31LzCjRq3g/Owh87P/RCdea5WdxdpwRZ099y4fu0YmQOL3
         02vTSTgaeRZ/g3uLFf/SJAZ9aHNwsLmAl24qmt5yqPPlZ1Susm2B78c/wQpZdRMSm8fN
         r0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780972343; x=1781577143;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfNMWF7tJbhVj/IYr5cDCAosnp1qCT5daHavwJqg6r4=;
        b=hHhrsqh4GBFuD9oZN06ty9vl3JIFbu3Kcxs5zhHXvyoSwrMqLh9CjkROASecCgWAz8
         pwR7itikjZ9qpDUYegaq/T5RILyeuoN3u+priPNdGr0v1LhvmyQE4dv2whvljBdOP1yb
         88OXS4jQfdCg0vWBMU783FhXjR7x/2Y+mPBbe26FwUbAzPkOhwYic2PQCKBehzoQfY3c
         lDq3XTVEBJXoywsQ2/Fl6pe4fa5Dipxcw4LrAtxdLnUuIZtiEU5kSDRverHg9gSidbkv
         5F3QvsB+zRVeFQruoWFw5ul0tsRIQp4b+U/NH7hTm3Pi4MHAAMrvSISbJlucXZEw5/Md
         Pt8Q==
X-Gm-Message-State: AOJu0YywZnyYxG1I37j/AMJfMLzGhGV8jSXN2MdPaoIytgzOVEAPSpXh
	Z//7fwUZ6R2q660ijrdUde2rtXQ+JZ73GO99NWXs0v7osKBZWCQOHggk
X-Gm-Gg: Acq92OFytaMNjKqxnI40Lpxsf3U5OF5S30500UY9Juiwb/m8tLpNguiB1dn5aQyUNtD
	PS3r3/7MvOZdGhO6hxgswa7bvfOGtdf+OLpV+f/g/dTmnTruNsLm0SD0WFzJ/OvmvoElJ/ItqQZ
	YV5J/emjfazsOWJ9hv7w+AR7VGanMTmsH2/nzIJvGqctbCK5iNGxV12XJhhjyCwyMHL9+OWToBb
	UN8bSE0G+wtrW1CnObWvWAq/lE+A54XCLVixnSffs+Ym7o/EjtfFR74NCI0zSTSuGWJR8RUAGj+
	52G3WMMBtj99r+0vgxCHtcB0vSYlK6np6xZAOoS/cI1FZ5H8bAsUIvj2NcjVkEFr5CfpT3H8LR+
	VOjE7k0GBOlvs4c0LIiJ0sHnpChX7fMSma1VhuLgHy/Zu9mfpSSqOObqYwDF8cl7ts+hK2Na32Y
	bhIidwLGQZzroWddTdBsq9JxEAT8SSqfnWPYIkyWfko3AvA2FUL3gYwyOqRxk3stQcayZzhZ6Km
	+SB14DbuTogCBsKc9UraD+kcqxdtQ3CRiR9MDB9Sl5x0Y6IflkZs+ktKHJqhJrrqP57yAm4CK+r
	bToVIfG3xbCg2m3XjAv7EHzUPyfS6gS2F8RdHzv+3gcduZnE/0klq7zCIN/NNLxHnyW6SjW82g/
	j
X-Received: by 2002:a05:6214:1242:b0:8cc:ebc0:6ebf with SMTP id 6a1803df08f44-8cee613caa7mr307361616d6.29.1780972342892;
        Mon, 08 Jun 2026 19:32:22 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([209.249.37.132])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdb915csm188078706d6.14.2026.06.08.19.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 19:32:22 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 08 Jun 2026 19:32:14 -0700
Subject: [PATCH v2] describe: limit default ref iteration to tags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-describe-tag-ref-scope-v2-1-256fd36dca32@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNSw6CMBCGr0Jm7Zi2SCGuvIdh0ccIY8SSFomGc
 HcLHsDll//xLZAoMiU4FwtEmjlxeGZQhwJcb54dIfvMoITSQosaPSUX2RJOpsNIN0wujIS1F8K
 QPAlTNZDHY474vR9f2x+nl72Tm7a3rdFzmkL87OZZbr2/klmiRF2VXpXKNtpWl24w/Di6MEC7r
 usXNMejg84AAAA=
X-Change-ID: 20260607-describe-tag-ref-scope-7d00ae140a58
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Patrick Steinhardt <ps@pks.im>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1780972338; l=3454;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=HsjULw8/EMFGrz+vXDu4JGlwoYGVmFhirPyaYE7t8wo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAD9DI6xYoAETtpSsiYEJD57D3isDmgIjcPaAW2CAnxxTVJkJ8IcwSydsUMj6qBQdpYpHKSzcQP
 FuxuJ/0NaEQE=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Unless --all is given, get_name() rejects every ref outside refs/tags/.
The rejection happens only after the ref backend has enumerated the ref,
so repositories with many other refs spend most of a simple describe
invocation visiting refs which cannot affect its result.

Commit 8a5a1884e9 (Avoid accessing non-tag refs in git-describe unless
--all is requested, 2008-02-24) moved this rejection before object
lookup, but left iteration unscoped. Pass the existing refs/tags/
restriction to the iterator unless --all is given so the backend can
avoid unrelated refs.

The benchmark checkout had 120,532 refs, of which 330 were tags. With
`$repo` naming the checkout, `$commit` an exactly tagged commit, and
`$parent` and `$this` the two binaries, I ran:

    hyperfine --warmup 3 --runs 15 \
        --command-name parent \
        '$parent -C $repo describe --exact-match $commit' \
        --command-name 'this commit' \
        '$this -C $repo describe --exact-match $commit'

The results were:

    Benchmark 1: parent
      Time (mean ± σ):     171.7 ms ±  18.5 ms    [User: 23.9 ms, System: 133.6 ms]
      Range (min … max):   142.3 ms … 198.3 ms    15 runs

    Benchmark 2: this commit
      Time (mean ± σ):       9.9 ms ±   1.1 ms    [User: 3.3 ms, System: 4.7 ms]
      Range (min … max):     8.8 ms …  13.1 ms    15 runs

    Summary
      this commit ran
       17.35 ± 2.63 times faster than parent

Both revisions were built with -O3, -mcpu=native, and ThinLTO using
Apple clang 21.0.0 on macOS 26.5. The machine was a MacBook Pro
(Mac16,6) with a 16-core Apple M4 Max (12 performance and four
efficiency cores) and 128 GB RAM.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v2:
- Exercise the performance test with both ref backends.
- Keep the ref count local to its setup test.
- Report native hyperfine output for an exact-tag lookup.
- Link to v1: https://patch.msgid.link/20260607-describe-tag-ref-scope-v1-1-653d232b86b5@gmail.com
---
 builtin/describe.c       |  3 +++
 t/perf/p6100-describe.sh | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index 1c47d7c0b7..3532c8ff22 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -740,6 +740,9 @@ int cmd_describe(int argc,
 		return ret;
 	}
 
+	if (!all)
+		for_each_ref_opts.prefix = "refs/tags/";
+
 	hashmap_init(&names, commit_name_neq, NULL, 0);
 	refs_for_each_ref_ext(get_main_ref_store(the_repository),
 			      get_name, NULL, &for_each_ref_opts);
diff --git a/t/perf/p6100-describe.sh b/t/perf/p6100-describe.sh
index 069f91ce49..ed9f1abe18 100755
--- a/t/perf/p6100-describe.sh
+++ b/t/perf/p6100-describe.sh
@@ -27,4 +27,19 @@ test_perf 'describe HEAD with one tag' '
 	git describe --match=new HEAD
 '
 
+test_expect_success 'set up many unrelated refs' '
+	ref_count=10000 &&
+	git tag -m tip tip HEAD &&
+	for i in $(test_seq $ref_count)
+	do
+		printf "create refs/heads/describe-perf/%05d HEAD\n" $i ||
+		return 1
+	done >instructions &&
+	git update-ref --stdin <instructions
+'
+
+test_perf 'describe exact tag with many unrelated refs' '
+	git describe --exact-match HEAD
+'
+
 test_done

---
base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
change-id: 20260607-describe-tag-ref-scope-7d00ae140a58

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>

