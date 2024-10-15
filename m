Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9481CFEA9
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992730; cv=none; b=LRJuUihmn51gbNc5CmoIh4Q36mGVsHrQlyiYC08D0105UlywF0/RkM2AHLHLp8g0QN9JWU5mwm8no/Q5J1VoKsw5OsEmgFJAA7bv0azN1NJv1RVPKsb4bve43TaFh/F7PWJs9G8FgSNT3kh7+ITXW7E/nNNwPJ0htBKHjFlh1SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992730; c=relaxed/simple;
	bh=Jy5H8rd/HsHj6nvgVLd3dUgL5Y3/moeUXfdhK3b1uEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOY9vY5evj1dKt9a2xCg31YfLlVBO9GI1voc6pVQuSavGIL8vnuo92V6DCrz/OsIZsQLFh0BhNwMpqn3T7I4Rxeo0xp0Ni8S8/owgWWoRqyLws+9ZipV0M5tXp3dvXW5usr6M4dWRuAxXvCB/d6OmtjiaElMDuL1kYthQ2pGju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ajumpqXe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SezRGqy4; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ajumpqXe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SezRGqy4"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 1293A11400B7;
	Tue, 15 Oct 2024 07:45:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 15 Oct 2024 07:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728992727; x=1729079127; bh=+Pe2v1qzcY
	1ZGDdQ+1cWhvEwUASL9kaRlE/RiwKSBV8=; b=ajumpqXe+i7v2UGS+H9mokbFGB
	ZehEwG5ClZZ2IPrcf42mtxYIGVzTxNNH7WpbV1ozrfPtWIFDM4rM9gfPxam3jZkB
	ATPAIMRHxOGW+83IPdZQl8FPqyy9EF3hLq7J/jBKZxqorEjSnkC4PUR0v8LYZoj3
	tQk6rxoTvU7WeKAf3pCfObvQxQRsgmSbOwD+T3QlW6kEAvN+T/QUljNAWx2f4AMn
	NTUv9hZjxH1NC2p/jMvcsYqvgufi/iE4VhPq84YpvBp7SeBnaIUEvveh+UCLHfYp
	ez1zxT7YBwB5q9LC3KfBYrDTHJ3qShL6ea7nB8BX2WODDFl8BqZw03DqO4QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728992727; x=1729079127; bh=+Pe2v1qzcY1ZGDdQ+1cWhvEwUASL
	9kaRlE/RiwKSBV8=; b=SezRGqy47gxs4IqDO7Q4DZQNJSjBIoO3vCjVsEm5/cFs
	YkVGUPQBsL+Np+mvtZkeSqEYUq1HNu0YATxw/CjWFbxjid+6elKrEcza9cyfTDx9
	WEmtn+eZ32qx8rQbcYC50Xr7Gtzol+SndKQI0qag10Io5SVJQpmh8TR2ZHEqtItP
	zfSw/+SMaf3Cdxawl+IsNMX6RFbEZHWSkM1LdRMXnhJNe+pQuhbdjA/Cp+N53QXi
	qnyz34QrrsuxTW3UAb+lZH13Ti7w22o/dIECCrCWt6wmBADLS5CIxtjCedZgl/7o
	OLRsm3C+PC1OFBIByXLYvx63fSJ195L9ifwrC1WVAQ==
X-ME-Sender: <xms:11UOZ9ALlzkmYe-w3ivtvdHzuswdn_lHRh8HMqBlvC1sYxFdnbE_lA>
    <xme:11UOZ7gDo8Uq0ZQs_uJnm0cn_U0pYHE-sqU9G4uPzOT16SOT-Xd4diFsONVZNJUJD
    lKAR7SuHMcJbvVI3Q>
X-ME-Received: <xmr:11UOZ4k9wJA3rXf6to6zoSZioXICmbqedlRckCrpzORKq0TQBQmmHu7dnLhMGmbKRewCm4K--3pY9NqG0486BmFB4GrDhBKvQ7zOYRa1I4t8HA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:11UOZ3y1UiavRu9fQcrqJMb2TTfRD_ivKKduKDhBR4bbVd7EnE1akg>
    <xmx:11UOZyRy2LJU2mkw-yI0ADW1neUrG_weTLVVzSxi6sx2eaKZEVXZ0w>
    <xmx:11UOZ6aNy442HLynrNGnsQnD216OLFrNNK-XonJYm9Xem_lag4KPFg>
    <xmx:11UOZzQFlKnbDycH1Cf65nwyyoBGJAmCsa2yc_Vpjdj-PFCbkxx5OQ>
    <xmx:11UOZwfC3U1D0EmQ8sdR9rEsT87HAn20V1KQkNPyuMtUWF65hqLhlnd1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 07:45:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8f4c07e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 11:44:12 +0000 (UTC)
Date: Tue, 15 Oct 2024 13:45:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 06/10] t3404: work around platform-specific behaviour on
 macOS 10.15
Message-ID: <1daadd82766a59577580dc386b91a942b0df6e15.1728992306.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1728992306.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728992306.git.ps@pks.im>

Two of our tests in t3404 use indented HERE docs where leading tabs on
some of the lines are actually relevant. The tabs do get removed though,
and we try to fix this up by using sed(1) to replace leading tabs in the
actual output, as well. But macOS 10.15 uses an oldish version of sed(1)
that has BSD lineage, which does not understand "\t", and thus we fail
to strip those leading tabs and fail the test.

Address this issue by using `q_to_tab` such that we do not have to strip
leading tabs from the actual output.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t3404-rebase-interactive.sh | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f171af3061d..7ce75237803 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1917,18 +1917,17 @@ test_expect_success '--update-refs updates refs correctly' '
 	test_cmp_rev HEAD~1 refs/heads/third &&
 	test_cmp_rev HEAD refs/heads/no-conflict-branch &&
 
-	cat >expect <<-\EOF &&
+	q_to_tab >expect <<-\EOF &&
 	Successfully rebased and updated refs/heads/update-refs.
 	Updated the following refs with --update-refs:
-		refs/heads/first
-		refs/heads/no-conflict-branch
-		refs/heads/second
-		refs/heads/third
+	Qrefs/heads/first
+	Qrefs/heads/no-conflict-branch
+	Qrefs/heads/second
+	Qrefs/heads/third
 	EOF
 
 	# Clear "Rebasing (X/Y)" progress lines and drop leading tabs.
-	sed -e "s/Rebasing.*Successfully/Successfully/g" -e "s/^\t//g" \
-		<err >err.trimmed &&
+	sed "s/Rebasing.*Successfully/Successfully/g" <err >err.trimmed &&
 	test_cmp expect err.trimmed
 '
 
@@ -2178,19 +2177,18 @@ test_expect_success '--update-refs: check failed ref update' '
 	test_must_fail git rebase --continue 2>err &&
 	grep "update_ref failed for ref '\''refs/heads/second'\''" err &&
 
-	cat >expect <<-\EOF &&
+	q_to_tab >expect <<-\EOF &&
 	Updated the following refs with --update-refs:
-		refs/heads/first
-		refs/heads/no-conflict-branch
-		refs/heads/third
+	Qrefs/heads/first
+	Qrefs/heads/no-conflict-branch
+	Qrefs/heads/third
 	Failed to update the following refs with --update-refs:
-		refs/heads/second
+	Qrefs/heads/second
 	EOF
 
 	# Clear "Rebasing (X/Y)" progress lines and drop leading tabs.
 	tail -n 6 err >err.last &&
-	sed -e "s/Rebasing.*Successfully/Successfully/g" -e "s/^\t//g" \
-		<err.last >err.trimmed &&
+	sed "s/Rebasing.*Successfully/Successfully/g" <err.last >err.trimmed &&
 	test_cmp expect err.trimmed
 '
 
-- 
2.47.0.72.gef8ce8f3d4.dirty

