Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB22729D26B
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779694; cv=none; b=W05aiKprraen+DFXVXby+juyc7ecpJ0UZPGTkHj7AIc1XQww5KgN6xg1fOeSwL/3kFkS5bCXppZ0FVsIxbiC8hNMZqjXRNKGyKbnmn2ZvbPN24mq7yXV3Vvlmuw82nVVcdqeiWZOTfuqtHE3hVb2f9NkBXaWh25wA8CuHrIv4dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779694; c=relaxed/simple;
	bh=Qv/Ahj9T8Qf+PukiJB+2+yG7J++h8OHq9wTpnTdleJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nhtDSRGbbQ2uUfvxxp2StWSVBdZt2wsqdq6XZJ5eG1KKn8o2b/EmMZdihlO9Kgp5IdLWKFSzEbjAJjCsbmRYen0FQvun5EaN5gXau49n9i4QWr5ac/LQKkl/cKRqmLH++8d+lQPTEQHxqWUMOqgKXp+aPGVIa/knA3m6Bh8AEkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VWoE3ZF1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X5uqgotE; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VWoE3ZF1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X5uqgotE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1FC281400151;
	Fri, 30 Jan 2026 08:28:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 30 Jan 2026 08:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769779692;
	 x=1769866092; bh=WVVUBpJde3Gs9Y7TGkahbWybytskKolI0nvCCi+OsfY=; b=
	VWoE3ZF12Df0Cs85HFmq1nI0hkLHtgAAdR0rzMpFFa7oHHlfuBB7OSf9pD1gwKRr
	APAlAYYBKPgRXaq7sWfSWK2TO+L9KKqjg38nUzr72uKlpiJXTZVeIerw6AT8D4fS
	l+HYKkyaNURlkLQDqsBOpViKbPngfQypce6S9NMUqP5GFrcuR8mjG6IjWUxp5EEQ
	rwV95HhqZPJIDj7mOFx/txZ4nZnyqdrfnOlMDn4En5vvEtQfiKlh8PVKx9zu7vt0
	8Gf/CIL6IEVDzUnlYFvDGHwgxkgO32cIaAmU5zpjAkII2cWL0Njv/JKcTItT+ncv
	IHxUhyrVh33JIs4+oH09IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769779692; x=
	1769866092; bh=WVVUBpJde3Gs9Y7TGkahbWybytskKolI0nvCCi+OsfY=; b=X
	5uqgotETgvFYeUT5f8UfEuA9pJe79lUrifg+sX3poY7Oo9A2NH0ZrG9Y+BQdL2TN
	/E4YB6PTimdaG/cHgqYG//GN22VfaErp5p3sUi75/9nJ7/NRcNsY9CfKd22x1u6f
	Rzms8BlKFBCcrUbb9UiclDYnfa1rFJJi9Tirqn1vqeNW6N95aPlvSkXQR5yVEDC9
	JsKdPt0DEF02sFv4VvbUDTaGwgZWFj0mMWD1oSt02jkaI0wGQFlYXBlqSsUCA0ku
	HCMOwsmmtVBhsaBfWuh08pw8VI2dAORaOzo/0s6+mKaqnZkQTcshNZbR8f+cWJ60
	0UUGE1wBFuFFC1XaiU1vA==
X-ME-Sender: <xms:7LF8aetNxgfY0KfUI6loUTLbaySJBfu-mPDEv22q3gWj9hbxwHK0-g>
    <xme:7LF8aZfup_CO8hDr7gFF03cfmZfidQESDs0ZiGDfNANCIAIQpxD4Tt52t9rER4vq-
    K4XfLrPOoCC2Zv4dkhg7wd945RSmHcuJLAQC2OZxshJ601FqlHTsw>
X-ME-Received: <xmr:7LF8aXY2WXH35VIgHNeQKrLG830n_Q8JLmdinpRnpqvseEnnaZwX7iYu3BrgHhXTmRUg45a4Ms-g8J30a0a8M0uYNOCRIhkhTN5s3JusVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeludeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7LF8aUV9jBrUzvCzzF2tV-CvSLdSlr7sNhLFgiiHF1eRyp8Fadn8Lg>
    <xmx:7LF8aRjSv8FXoC9GC6GJBJWc8NR_-3X3P7IYwi6NT5oExn1w75ZGYw>
    <xmx:7LF8aaXvJfHfujk9wNZuLiafCxaGFDWu-tRoB9mC2WQfCCGO6L3HTw>
    <xmx:7LF8aQP6JaCznEm29w4DZmjM96ESeHGUXxP48l-6ELsAmGBbdgI45Q>
    <xmx:7LF8aW0_p-e8LQ6YMrU1lZz36OoQ3IvwL0NzRvI_z8vL4mgVgqfNA1hi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 08:28:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8df33991 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Jan 2026 13:28:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 Jan 2026 14:27:43 +0100
Subject: [PATCH v2 2/4] pack-bitmap: fix bug with exact ref match in
 "pack.preferBitmapTips"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-2-0449b198a681@pks.im>
References: <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-0-0449b198a681@pks.im>
In-Reply-To: <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-0-0449b198a681@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

The "pack.preferBitmapTips" configuration allows the user to specify
which references should be preferred when generating bitmaps. This
option is typically expected to be set to a reference prefix, like for
example "refs/heads/".

It's not unreasonable though for a user to configure one specific
reference as preferred. But if they do, they'll hit a `BUG()`:

    $ git -c pack.preferBitmapTips=refs/heads/main repack -adb
    BUG: ../refs/iterator.c:366: attempt to trim too many characters
    error: pack-objects died of signal 6

The root cause for this bug is how we enumerate these references. We
call `refs_for_each_ref_in()`, which will:

  - Yield all references that have a user-specified prefix.

  - Trim each of these references so that the prefix is removed.

Typically, this function is called with a trailing slash, like
"refs/heads/", and in that case things work alright. But if the function
is called with the name of an existing reference then we'll try to trim
the full reference name, which would leave us with an empty name. And as
this would not really leave us with anything sensible, we call `BUG()`
instead of yielding this reference.

One could argue that this is a bug in `refs_for_each_ref_in()`. But the
question then becomes what the correct behaviour would be:

  - Do we want to skip exact matches? In our case we certainly don't
    want that, as the user has asked us to generate a bitmap for it.

  - Do we want to yield the reference with the empty refname? That would
    lead to a somewhat weird result.

Neither of these feel like viable options, so calling `BUG()` feels like
a sensible way out. The root cause ultimately is that we even try to
trim the whole refname in the first place. There are two possible ways
to fix this issue:

  - We can fix the bug by using `refs_for_each_fullref_in()` instead,
    which does not strip the prefix at all. Consequently, we would now
    start to accept all references that start with the configured
    prefix, including exact matches. So if we had "refs/heads/main", we
    would both match "refs/heads/main" and "refs/heads/main-branch".

  - Or we can fix the bug by appending a slash to the prefix if it
    doesn't already have one. This would mean that we only match
    ref hierarchies that start with this prefix.

The first fix leaves the user with strictly _more_ configuration
options: they can have prefix matches by not appending a slash to the
configuration, and they can have ref hierarchy matches by appending one.

Apply this fix and clarify the documentation accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/pack.adoc |  7 +++----
 pack-bitmap.c                  |  4 ++--
 t/t5310-pack-bitmaps.sh        | 35 +++++++++++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh    | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/pack.adoc b/Documentation/config/pack.adoc
index 75402d5579..929d781552 100644
--- a/Documentation/config/pack.adoc
+++ b/Documentation/config/pack.adoc
@@ -161,11 +161,10 @@ pack.usePathWalk::
 
 pack.preferBitmapTips::
 	When selecting which commits will receive bitmaps, prefer a
-	commit at the tip of any reference that is a suffix of any value
-	of this configuration over any other commits in the "selection
-	window".
+	commmit at the tip of a reference that matches any of the
+	configured prefixes.
 +
-Note that setting this configuration to `refs/foo` does not mean that
+Note that setting this configuration to `refs/foo/` does not mean that
 the commits at the tips of `refs/foo/bar` and `refs/foo/baz` will
 necessarily be selected. This is because commits are selected for
 bitmaps from within a series of windows of variable length.
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 2f5cb34009..8d3b5ac037 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -3334,8 +3334,8 @@ void for_each_preferred_bitmap_tip(struct repository *repo,
 		return;
 
 	for_each_string_list_item(item, preferred_tips) {
-		refs_for_each_ref_in(get_main_ref_store(repo),
-				     item->string, cb, cb_data);
+		refs_for_each_fullref_in(get_main_ref_store(repo),
+					 item->string, NULL, cb, cb_data);
 	}
 }
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 6718fb98c0..7ef91b502c 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -466,6 +466,41 @@ test_bitmap_cases () {
 		)
 	'
 
+	test_expect_success 'pack.preferBitmapTips can use direct refname' '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+
+			# Create enough commits that not all will receive bitmap
+			# coverage even if they are all at the tip of some reference.
+			test_commit_bulk --message="%s" 103 &&
+			git log --format="create refs/tags/%s %H" HEAD >refs &&
+			git update-ref --stdin <refs &&
+
+			# Create the bitmap.
+			git repack -adb &&
+			test-tool bitmap list-commits | sort >commits-with-bitmap &&
+
+			# Verify that we have at least one commit that did not
+			# receive a bitmap.
+			git rev-list HEAD >commits.raw &&
+			sort <commits.raw >commits &&
+			comm -13 commits-with-bitmap commits >commits-wo-bitmap &&
+			test_file_not_empty commits-wo-bitmap &&
+			commit_id=$(head commits-wo-bitmap) &&
+
+			# We now create a reference for this commit and repack
+			# with "preferBitmapTips" pointing to that exact
+			# reference. The expectation is that it will now be
+			# covered by a bitmap.
+			git update-ref refs/heads/cover-me "$commit_id" &&
+			git -c pack.preferBitmapTips=refs/heads/cover-me repack -adb &&
+			test-tool bitmap list-commits >after &&
+			test_grep "$commit_id" after
+		)
+	'
+
 	test_expect_success 'complains about multiple pack bitmaps' '
 		rm -fr repo &&
 		git init repo &&
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index faae98c7e7..40d36118bd 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1345,4 +1345,40 @@ test_expect_success 'bitmapped packs are stored via the BTMP chunk' '
 	)
 '
 
+test_expect_success 'pack.preferBitmapTips can use direct refname' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		# Create enough commits that not all will receive bitmap
+		# coverage even if they are all at the tip of some reference.
+		test_commit_bulk --message="%s" 103 &&
+		git log --format="create refs/tags/%s %H" HEAD >refs &&
+		git update-ref --stdin <refs &&
+
+		# Create the bitmap via the MIDX.
+		git repack -adb --write-midx &&
+		test-tool bitmap list-commits | sort >commits-with-bitmap &&
+
+		# Verify that we have at least one commit that did not
+		# receive a bitmap.
+		git rev-list HEAD >commits.raw &&
+		sort <commits.raw >commits &&
+		comm -13 commits-with-bitmap commits >commits-wo-bitmap &&
+		test_file_not_empty commits-wo-bitmap &&
+		commit_id=$(head commits-wo-bitmap) &&
+
+		# We now create a reference for this commit and repack
+		# with "preferBitmapTips" pointing to that exact
+		# reference. The expectation is that it will now be
+		# covered by a bitmap.
+		git update-ref refs/heads/cover-me "$commit_id" &&
+		rm .git/objects/pack/multi-pack-index* &&
+		git -c pack.preferBitmapTips=refs/heads/cover-me repack -adb --write-midx &&
+		test-tool bitmap list-commits >after &&
+		test_grep "$commit_id" after
+	)
+'
+
 test_done

-- 
2.53.0.rc2.206.g60c1bca835.dirty

