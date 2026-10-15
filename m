Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CC8288C96
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792099503; cv=none; b=EIgB7keVvNbsm/nqf5iJ2GyKOcZiXxSrnLJJ/cGvbU8rcMlL/cz3ZxXroyA/eiUAE1aSFFXQ03gc5MPPQ9dOGv4Amx1qWcSBZ7EJ385TBE+8Hen2zbZ9r3DpXjok3Aith/0TS5oFgmeNN8TMTFJtSeHkAwf8Mix1NebCNm0RmJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792099503; c=relaxed/simple;
	bh=lgJWH+UkKTV7iEcU8kIiYBTR/0p065VzdD/U+pyZwYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=QL0qgvkbJXsvudx9mBbURKut8wgkEQYN441pMY9j6uArzBkbJtIkcGSvDjJCP3jsHEEy7iLxJj/uyoVoAyNQnEHg2HI84IbQFu9/SBTJKEcFgQBERDB/EEkQMLPivL1SJnpU+kEvA5CXc8Cvi+rZmWtSwH5TSPmAlChjA7H9Zeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izsM8DIH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izsM8DIH"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso24264465e9.2
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 14:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792099500; x=1792704300; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xBs86k+YPKoVZuNJqjSgetd+TVpPvFEeLZwCTxS2dHE=;
        b=izsM8DIHCuIaBOGyjP8MjzMEH8iInOC37maDCVYG9Hq/FE8G81U+LUrK6XumuiS3NY
         ZhqeeT/T2hW0tCSuzWDWyPCqzTr8cYrJMJLorU2l/t209RaDs+UYfD533rqrV8RyGMXm
         wkemJOl9E/3AynFciZA2BWRLMGMpBAJ+amX0XCleRVuW+/v3jFWnmrJuj641ulQZU1WO
         yAxIqyK8oismLKJZmRAaq09cGC5O57Uqkn/c2A2dc/kXnok2tE8rU1gJK704CYvMLUuH
         MyBF3U02fxo+u5Hd+AthvCJH0OscZqSGGaVZ4U7EIE4pFD8pal5YEkilbWEC72ACUMPL
         RfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792099500; x=1792704300;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xBs86k+YPKoVZuNJqjSgetd+TVpPvFEeLZwCTxS2dHE=;
        b=yKIHgh7QoirS20J9u1G1oxoSjBTR/zsjP6th4MPKvZUAUCEyMHs9zuPpWNbH2ili91
         +QW6L3YMs5E3xp4VKNgbI0LAs2K+MoQG/BPk4721cglX4kbxPqIuEy0QcDsc1v9gGyOA
         QyhDtmOcwS+bWBZpUO5gzEKtPSKHTg3Pmu7MyMClgB0+NesquIzpP3DPPHt2446sAoCP
         +5bWnqqBoArYxNWoDJu3kSIaMtprAPp+K845iEQRfdNBAUsxHVRweulWw2HglF4UdxAM
         jqRRvTp2gcbQZyy4Uq7qOdA0A/Ne8rUrnOrjGnk3CXJpF1dlFQSLVqM1pdcWqA1fzOdS
         dWYA==
X-Gm-Message-State: AFq9FYIpX9l38U61EAHx7T8WCBurHMeubK/zty+UiWUJVw0twzyVHYa2
	d3x7H2lVRO2L3g2KjaU1uNLnKoSWMRwhpIQnbQwWQ7VXfkowdx/Qtt3kwoULIA==
X-Gm-Gg: AYBFou1AyTajJYXvhwejW9nOY6JPXVzORVKwDPLSe5wLBYSLBzcFcesctuTszQMwFjK
	icNM1i3l+C5hiuhtw2AhPnMO0miyVel7dH6JFk4YjviPFOGscxQFKyzN55WijhIEH63v9FCO1z8
	+TQ6ixXVLEhTvvP5jSTjhogPHcayK8MjWel8IVULhomwTcP9vP7LnleQmaW0zJX4qlHjXpw9dTc
	tR2wvvgIojX5GZ9HY9OgmsFhgXKUoatpP1+cQ7Dbkvl+4uYS1nNcBdXVDN2EOtM4t7Rzn+bz/zF
	uJFm72pZJnJ6jmwF3x1Nkkf90mFoF1fki0fOecE3WNiSqzS6NfJEHzsIpTff3idlPAZMThMq8IR
	fgrcNVK3Q03TjhpIgLa1NWKJ3P3vpV7M9KQFulgKCBtgjzP39poBUOtORZybiPJ5Th/zetSBEq1
	ZbEgXMkciZZNlAXbR9gtE8EiWJzJ+AFaOL01cAbyJBi0h1vGIvnZRHDGtk/t09mAAcTEPJyltWK
	ODBxSbQ9tT4w2Mv4WIKYUeMupVYL/AYQbCKqw==
X-Received: by 2002:a05:600c:e557:10b0:4a1:8efb:c9ae with SMTP id 5b1f17b1804b1-4a18efbcae9mr262212875e9.23.1792099499975;
        Thu, 15 Oct 2026 14:24:59 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:5f7f:3a9f:80bc:18d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9c001dsm95750635e9.12.2026.10.15.14.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 14:24:59 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 15 Oct 2026 23:24:46 +0200
Subject: [PATCH v3] fetch: commit references fetched before backfilling
 tags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261015-799-shallow-fetch-with-tags-v3-1-90b6e38b98d2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ6CMBCF4auQrh3TaRFSV97DuChlSmuAGlpBY
 7i7oDFxxfIlL9//YpEGT5EdsxcbaPTRh34Zcpcx43TfEPh62UxwUSDnJZRKQXS6bcMElpJxMPn
 kIOkmQl2ISpKthLKcLcJtIOsfH/18+e54r65k0kquD+djCsPzkx9x/f1KarM0IiDIUtUFHniu7
 eHUdNq3exM6tpZG8Weh2LbEYuUCkZRGWUvzb83z/Abz9YiEJAEAAA==
X-Change-ID: 20261007-799-shallow-fetch-with-tags-d62b3efb29f0
In-Reply-To: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, 
 =?utf-8?q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>, 
 Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8785; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=lgJWH+UkKTV7iEcU8kIiYBTR/0p065VzdD/U+pyZwYs=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrRRKqOQZ6WTPVJByp39XchE7YSVVkaVJBuN
 B+zpiWstLO1wYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq0USqAAoJED7VnySO
 Rox/clkMAKQswfnTEyAWey9RrChsia3G6odkXg80Wm2VKw7+yAxbTnej3kLIRnn7wt9xEhCs43b
 fqLMXAHaBkOZhTgrppgdQKeZNgR13jQ9lcSAdxQz2pVSdS52HpNGAUofTJUazaa+enVBoYBTTTl
 WULIeK7GHVm7GkGwUMog51KsTBloc3DfYPkMsQvmfdGyqX8NDzqglCyZCm7eIkno+xfxQnF9lyR
 sWqQ+8m8uplWMhzStZroDqunW03/u0PMRRn496cd4UTcPQq0fTVRmh7JqpK1DlRGTCAUj0zGhJy
 5fbECGzq0wVAd2yGt4zlLREjwb2e1DNUZPTrveVGObT0qFmqrjMQIll2tdyR4UR9fu1/aLHX81Z
 ii6p3jt5/4xbirgY1T6tB3nt0ndPJyg/lLMPv1Ubh0uqheXKxqeUFxIru+gtTuTqyenEv9LaQfg
 XCL7o602Zfcb/wp8GfRupRx1g/JOuGxgc/JKVc25+99cLOrARyL4GspVeXdzFO6YYiYvnEZU/46
 nA=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 0e358de64a (fetch: use batched reference updates, 2025-05-19), the
fetch code was modified to use batched updates to provide a good
performance improvement. Batched updates are used both for the fetched
references and to backfill tags.

When using batched updates, the references aren't yet committed to disk
when we start backfilling tags. This means in situations such as shallow
fetching the negotiation during backfilling tags, the newly fetched refs
are not available for advertisement in the 'haves' section. This can
cause the server to send all objects the client already has.

The issue always existed when the '--atomic' flag was used, as both the
regular ref updates and the tags need to be part of the same
transaction.

Fix this by committing the previous batched update and initiating a new
one for backfilling tags. Use a separate error variable for tracking the
reference updates: One, it ensures that errors from the regular ref
updates don't cause a total failure. Two, if starting the transaction
for backfilling tags fails, only those updates are not made to disk. The
initial error is now printed straight away to clear the buffer for
further errors.

Add two tests, one which validates that the 'haves' are filled when
backfilling tags. The other, to test that upstream is still set and tags
are backfilled even if the main ref update is rejected.

While this does make it a little slower than master, due to two
transactions:

Benchmark 1: fetch: many refs (refformat = reftable, refcount = 10000, revision = master)
  Time (mean ± σ):      82.1 ms ±   3.3 ms    [User: 60.2 ms, System: 24.4 ms]
  Range (min … max):    77.4 ms …  89.4 ms    33 runs

Benchmark 2: fetch: many refs (refformat = reftable, refcount = 10000, revision = HEAD)
  Time (mean ± σ):      82.6 ms ±   2.4 ms    [User: 59.3 ms, System: 25.2 ms]
  Range (min … max):    78.1 ms …  88.7 ms    31 runs

Summary
  fetch: many refs (refformat = reftable, refcount = 10000, revision = master) ran
   1.01 ± 0.05 times faster than fetch: many refs (refformat = reftable, refcount = 10000, revision = HEAD)

It is still faster than not using batched updates:

Benchmark 1: fetch: many refs (refformat = reftable, refcount = 10000, revision = 0e358de64a9e014575d11ef884bfc9beb931e37f~1)
  Time (mean ± σ):      1.468 s ±  0.041 s    [User: 0.839 s, System: 0.587 s]
  Range (min … max):    1.427 s …  1.558 s    10 runs

Benchmark 2: fetch: many refs (refformat = reftable, refcount = 10000, revision = HEAD)
  Time (mean ± σ):      84.4 ms ±   1.7 ms    [User: 60.9 ms, System: 25.8 ms]
  Range (min … max):    81.4 ms …  88.6 ms    29 runs

Summary
  fetch: many refs (refformat = reftable, refcount = 10000, revision = HEAD) ran
   17.38 ± 0.61 times faster than fetch: many refs (refformat = reftable, refcount = 10000, revision = 0e358de64a9e014575d11ef884bfc9beb931e37f~1)

Reported-by: Mitja Bezenšek <mitja.bezensek@login5.org>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
The issue was reported by Mitja Bezenšek on GitLab's Git repo [1].

[1]: https://gitlab.com/gitlab-org/git/-/work_items/799
---
Changes in v3:
- Fix the early exit, so a failed transaction_begin() only skips the
  backfill.
- Keep the first commit's result separately, so rejections don't skip
  the upstream and remote-HEAD setup.
- Test that the backfill advertises the fetched tip as a have, instead
  of checking that the root object isn't fetched, which passed even
  without the fix.
- Add a test for the upstream setup when a main ref is rejected and a
  tag is backfilled.
- Link to v2: https://patch.msgid.link/20261012-799-shallow-fetch-with-tags-v2-1-4211e9a13d3c@gmail.com

Changes in v2:
- Add benchmarks between master and this branch to show perf regression.
- Instead of checking the trace file, simply check that we didn't fetch
  older objects in the test.
- Link to v1: https://patch.msgid.link/20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com

CC: Patrick Steinhardt <ps@pks.im>
CC: Justin Tobler <jltobler@gmail.com>
---
 builtin/fetch.c  | 38 +++++++++++++++++++++++++++++++++++---
 t/t5510-fetch.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b2decc6cfd..34fc37b58a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1923,6 +1923,7 @@ static int do_fetch(struct transport *transport,
 	struct strmap rejected_refs = STRMAP_INIT;
 	int summary_width = 0;
 	int follow_remote_head;
+	int commit_ref_ret = 0;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -2076,6 +2077,30 @@ static int do_fetch(struct transport *transport,
 		struct ref *tags_ref_map = NULL, **tail = &tags_ref_map;
 
 		find_non_local_tags(remote_refs, transaction, &tags_ref_map, &tail);
+
+		/*
+		 * As negotiation only reads references from disk, commit the references
+		 * fetched so far, so that the backfill negotiation can advertise them as
+		 * 'have's. Otherwise the server may re-send objects.
+		 */
+		if (tags_ref_map && !atomic_fetch) {
+			commit_ref_ret = commit_ref_transaction(&transaction, false,
+								transport->remote->name,
+								&rejected_refs, &err);
+			if (err.len) {
+				error("%s", err.buf);
+				strbuf_reset(&err);
+			}
+
+			transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
+								  REF_TRANSACTION_ALLOW_FAILURE, &err);
+			if (!transaction) {
+				free_refs(tags_ref_map);
+				tags_ref_map = NULL;
+				commit_ref_ret = -1;
+			}
+		}
+
 		if (tags_ref_map) {
 			/*
 			 * If backfilling of tags fails then we want to tell
@@ -2099,9 +2124,16 @@ static int do_fetch(struct transport *transport,
 	if (verbosity >= 0)
 		summary_width = transport_summary_width(ref_map);
 
-	retcode = commit_ref_transaction(&transaction, atomic_fetch,
-					 transport->remote->name,
-					 &rejected_refs, &err);
+	/*
+	 * The transaction may have failed to initialize, meaning there is nothing
+	 * to commit. Carry forward with other operations in such cases.
+	 */
+	if (transaction)
+		retcode = commit_ref_transaction(&transaction, atomic_fetch,
+						 transport->remote->name,
+						 &rejected_refs, &err);
+	retcode |= commit_ref_ret;
+
 	/*
 	 * With '--atomic', bail out if the transaction fails. Without '--atomic',
 	 * continue to fetch head and perform other post-fetch operations.
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 300bd5396d..0baf18e01e 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1942,6 +1942,23 @@ test_expect_success "backfill tags when providing a refspec" '
 	test_cmp expect actual
 '
 
+test_expect_success 'backfilling tags after shallow fetch advertises fetched refs as haves' '
+	test_when_finished rm -rf source target trace &&
+
+	git init source &&
+	test_commit_bulk -C source 10 &&
+	git -C source tag -a tag -m tag HEAD~2 &&
+	HEAD_OID=$(git -C source rev-parse HEAD) &&
+
+	git init target &&
+	git -C target remote add origin ../source &&
+	GIT_TEST_PROTOCOL_VERSION=2 GIT_TRACE_PACKET=$(pwd)/trace \
+		git -C target fetch --depth 5 origin &&
+
+	test_grep "fetch> have $HEAD_OID" trace &&
+	git -C target rev-parse --verify refs/tags/tag
+'
+
 test_expect_success REFFILES "FETCH_HEAD is updated even if ref updates fail" '
 	test_when_finished rm -rf base repo &&
 
@@ -2005,6 +2022,31 @@ test_expect_success REFFILES "upstream tracking info is added even with conflict
 	)
 '
 
+test_expect_success REFFILES "upstream tracking info is added with conflicts and backfilled tags" '
+	test_when_finished rm -rf base repo &&
+
+	git init --initial-branch=main base &&
+	test_commit -C base one &&
+	test_commit -C base two &&
+	git -C base branch foo &&
+	# Backfilling only takes place for tags which are not pointing at tips.
+	git -C base tag -a annotated -m annotated HEAD~1 &&
+
+	git init --bare --initial-branch=main repo &&
+	(
+		cd repo &&
+		git remote add origin ../base &&
+		mkdir -p refs/remotes/origin &&
+		>refs/remotes/origin/foo.lock &&
+		test_must_fail git fetch origin --set-upstream main \
+			"+refs/heads/*:refs/remotes/origin/*" &&
+		git config get branch.main.remote >actual &&
+		echo "origin" >expect &&
+		test_cmp expect actual &&
+		git rev-parse --verify refs/tags/annotated
+	)
+'
+
 test_expect_success REFFILES "HEAD is updated even with conflicts" '
 	test_when_finished rm -rf base repo &&
 

---
base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
change-id: 20261007-799-shallow-fetch-with-tags-d62b3efb29f0


Thanks
- Karthik

