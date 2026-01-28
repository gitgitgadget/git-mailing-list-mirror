Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A557B33A008
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590177; cv=none; b=uNw81b/slnuPzbQnN1nnCRn9wyyuNLkwOHhjjNoUH0N/1wyLszapbcjux63kE22lLJb58l8LPcofViAxPThBQw1H7jodTdKCFf52frg7XgBiK/RPnQfeF1JbFFbq6DfF4q1xZnhT5f1/lhN7BGRmz+aVIz7BfCBDJMTOZZqrIBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590177; c=relaxed/simple;
	bh=UqLRdctqNKOX67b26u6FSX1W20MQLEvpUkLoIu3X4ZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RhUsElBMy9DDb3UI/AknFFB1NM2BypyoWKzxfdhiFuMKMvhhSonIOidVfVt8mmdlVdEofX3JtLPmagQmaOlJa+eC6M1eGNvnW9fiHRF82zBH5LotlAQmC+sCALBS6Rki6ZupZ/3iVgRApO0YcZ+tIvwFauAXT7SPWFTCe6LiGxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eE9jkT75; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KIgFmFdH; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eE9jkT75";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KIgFmFdH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 50624EC0174;
	Wed, 28 Jan 2026 03:49:34 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 28 Jan 2026 03:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769590174;
	 x=1769676574; bh=9fnZSjLE/mkY/eZShbmhUXU6Z/TriPeLZaDWo91Ns14=; b=
	eE9jkT75ga6j/HaazjbZzveNEd/eJoYqufTHYVVl4o/cGBVax4NW/Ti/IPBrpPUk
	Kqa48zboGz05u8w1auWamsqHd0tweTzHi7iuDz5kjxht+sqQvvwa0EVN1Y4PVUHP
	an/toVot0mykhXwp2EnsxiquYFP4PTYJN+i+p7s/SbijVo17K/xkpI+ZV+IAkYls
	4g1zHn8y9V9O8i94b7peJ3XnClgSLekgZ7UBu4ibitm1ThLxCae3ulFbaxOyWEd+
	0mCAr1R4t7yEQLOaWsKqtefROlSTI/INqtPTvf9CVK4t/BHL/A59tclc+Y2vMwxT
	04nHynek+8O6CO44acHSRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769590174; x=
	1769676574; bh=9fnZSjLE/mkY/eZShbmhUXU6Z/TriPeLZaDWo91Ns14=; b=K
	IgFmFdH1FLl5/9bbFWlDXXm8Jjx0tUtw6+TyAahOc5yvhbjziE15O3sOhHzY4TGK
	TbgVwBj9l28lgPgGK+4vUaa/459fk+8apHYrn+HTCJ3nUhvU7jL1MB825yjQcNVi
	blQjoYlcAn9b5TKHStTLbMv0d/poUSkv0mgMlkteq5qsep1p0TZ7oe+uf3aDCidt
	Q9Le9CYp5J/+brJDf/3dzED4AxpGckdQA8BjOvWhv6BCNuaQwn1NfJ5zXkG02563
	Uh5y1+Rfbz9qd8CehDg7vSbsKKbk8Abme2IRirS4v3JpejTTgMSGs2JmvvCFRi0K
	I+RSyFIMezIivRUzE2q5w==
X-ME-Sender: <xms:ns15adF4-o2Ki-bUaQhk0xsEp9d8jQDSfhmuCCvvvv4sL2VwOJA7pA>
    <xme:ns15aYXWcPORrb2jT8T3Qs0SD5az6sz3mjRFVANz6kwufQNlSKh_Bqhu6YSGetnMD
    3TBzOcGLPtBu5rvk_qtnjctm3h0e_KH4mdmKqS3X4isCYqSWQBisg>
X-ME-Received: <xmr:ns15aczKq1SFw8Q5rkXC-Zb86qI5SHolpVksH4qBBcmq2NAEXySaPKkGRUSWAg6dIiR2vH9bISno55z2_3e4gVEB_6HXza4c1vph_oqq0QA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedvleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:ns15aePpQmm_vImS7Q1N02d_uvth2cY4dG9NP19mhSBuW28XSiijDw>
    <xmx:ns15aV4FqlC-gmvO7cKqKV0B71KJK85L1AdC-9sE5E7A-U4PSmKk0A>
    <xmx:ns15aXOodi04xdFQgVsdYpSBWaOJcaQ7loMKOTv2P2cDyv7caHxjGw>
    <xmx:ns15abm9ddYJL1J46us6hUFW7AU6brNfN_bhfe2YH3Re7Hxh0qg0BQ>
    <xmx:ns15afMdntMeAJv6RGjVMRqnu8tIq-8NPlQBG64tX7Zs-gmchb0ib6kL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 03:49:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ffcfc605 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Jan 2026 08:49:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 28 Jan 2026 09:49:21 +0100
Subject: [PATCH 2/3] pack-bitmap: fix bug with exact ref match in
 "pack.preferBitmapTips"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-2-deccae3ea725@pks.im>
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
In-Reply-To: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
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
a sensible way out.

The root cause really is that we try to trim the whole refname. We can
thus easily fix the bug itself by calling `refs_for_each_fullref_in()`
instead. This function behaves the same as `refs_for_each_ref_in()`,
except that it doesn't strip the prefix. Consequently, it correctly
yields also exact refnames.

One resulting weirdness is that two refs "refs/heads/base" and
"refs/heads/base-something" would now match if the user configured
"refs/heads/base" as bitmap tips. One could arguably change the
semantics of the configuration such that a string without a trailing
slash needs to be an exact reference match, whereas a string with a
trailing slash indicates a directory hierarchy. But such a change would
potentially cause regressions with dubious benefits, so this issue is
ignored for now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap.c               |  4 ++--
 t/t5310-pack-bitmaps.sh     | 35 +++++++++++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 2 deletions(-)

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

