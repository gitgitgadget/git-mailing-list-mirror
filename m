Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BED268C7C
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908484; cv=none; b=V+LupOO8P+C7PWd8E2j4u7nK54+KpYlZq16fYhOhea4zgS5qaLK//67N3IcrvqxsrINW7DlPuN7HDS07yXqv0HgSrYbtk5xyQ28uKcDAXQkHcWOs5n62wll+zZkd6qP1NGqyHAPcAktgVTHD3g46Ukx36F2HCxM5dF5UQzn9BtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908484; c=relaxed/simple;
	bh=x6zEzZpx+bxNQ0VKz0w/3WuCDnWSaMjafPKN/NUggOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pLZ1MTKlWY2L4NlMdD1B6B6aVTMh/wD9WsWlBCqqXSArdlO47JUr9ZuAOEkvN/VdFmgK8eks5ZbXiaPxoybfBOBuuOMf+3+57u9um4xFIxFSg6pLr2X6nWhFVfOfUXv3JNhDN2xt3ziWLs1WYEoZMKrg1hsacdqdqL18yju1TGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KVp3S+YM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jtKM31NZ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KVp3S+YM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jtKM31NZ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C03D413838F0;
	Tue, 25 Mar 2025 09:14:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Mar 2025 09:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742908480;
	 x=1742994880; bh=RC+oEWj5k77m12uZbDBQ4gke2gQt2GP40yqO8tSB834=; b=
	KVp3S+YMum/WYMKpga5vhe7XauzDfWI6sZZaOOvky7mq0l54MVSvgI2iUKWJSm8s
	HpNowqJjXGYNd21fTFDgvbarMyCt67dQMkUF8EA3GINAGZ9wcOIMhC+cJXxefhak
	Mhak9YGLzrtgbvq9zlqEYEgdTljNQxR2d4xYny6cOIOIoit6qmYBgSVE+kmmDP9E
	tzM67fJ7llDjIphAk20KXHFLvQ+VdVj0BLqAYhAwMo27SOYsUPWN6HGLcKcW8PGj
	s1yCL4d/oY85wid9QW/UmfzLyihIA1ZCZ9bnroA1l/V+WouBL3Bys0RQR4Z1R4V8
	UMmJOlFvjrkRipceWe8bfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742908480; x=
	1742994880; bh=RC+oEWj5k77m12uZbDBQ4gke2gQt2GP40yqO8tSB834=; b=j
	tKM31NZgkNheuuUCM3X8gqAcFdR47TO5cwm4uW8NA0hW36NxOxvKUxQdS08qFxT1
	F6v5GPgywFrZED7S3HMd6PP29sJsJOtLq3/FCjf4Un/QNwWr+wOnnUkUQ1Z+5QXB
	dg4iI+vi5M4AsU+MYmdG9kvemYF7RjUFsXtFIL1i/UJFlS4xhlKaymhU9k8Yd5nZ
	Nu2NlfabIP9gLCCUsCCievxX0nAy1y2N8p+PS995+9Mr5LC0pjzVwwRozO1/rhQ+
	icAWu317Bq1dLMcOg+c2ooDgOcBKplw8Ln0HSLnXWKoTKQyT3qwRKsTKRU09ZXt3
	rJYVrkqk6t2thMYp0isWA==
X-ME-Sender: <xms:QKziZ66ncuFR0wo0hQuoK30GJYQejmUyY6vJ5oM6TZYF-EDk7tsP0g>
    <xme:QKziZz7V1cATs0ktDBil8vwaD8k4PonE48ouSv1MzK5rezP2eR8qr2XcRbNeKmOX2
    7YdFxyjYwLRPRU4Tw>
X-ME-Received: <xmr:QKziZ5fXKYm3R7boa9w2XwtqB3i2X6BJ7Nm8bfvw-EUSdHph3UMXB4iE4NLkfO5-sFa2l2i6HFG7lP3J5C6Bb60vSu4bqi8CKHwCThA_XtGdUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgt
    phhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjohhh
    rghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:QKziZ3LhmfTVteJ9teePYdUqXfrXZ4b0mcvZz_D1isxwAeGVvnNoBg>
    <xmx:QKziZ-ItbVNAAap2CgOWialJjcALOZTpT17upZU9R9yx95oOgpHkWg>
    <xmx:QKziZ4wx9GV0rYl3v02Re1j5KqNG7OqDm8Chpm0KIci4Kd8If80aFg>
    <xmx:QKziZyJyKlUCxZic5v7iUHx5ihsKxTvDxXHfzZ5nbZSjZgJg8fk6ig>
    <xmx:QKziZwg4KBOtgnAvKDYTnt2ghMRzYoSg2JaFrzvV6MMq60jtjuR2hSbr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 09:14:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cbba0eb8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 13:14:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Mar 2025 14:14:35 +0100
Subject: [PATCH v2 17/20] t0021: refactor `generate_random_characters()` to
 not depend on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-b4-pks-t-perlless-v2-17-4b87b8072670@pks.im>
References: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
In-Reply-To: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

The `generate_random_characters()` helper function generates N
random characters in the range 'a-z' and writes them into a file. The
logic currently uses Perl, but it can be adapted rather easily by:

  - Making `test-tool genrandom` generate an infinite stream.

  - Using `tr -dc` to strip all characters which aren't in the range of
    'a-z'.

  - Using `test_copy_bytes()` to copy the first N bytes.

This allows us to drop the PERL_TEST_HELPERS prerequisite.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0021-conversion.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 4a892a91780..bf10d253ec4 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -20,8 +20,7 @@ EOF
 generate_random_characters () {
 	LEN=$1
 	NAME=$2
-	test-tool genrandom some-seed $LEN |
-		perl -pe "s/./chr((ord($&) % 26) + ord('a'))/sge" >"$TEST_ROOT/$NAME"
+	test-tool genrandom some-seed | tr -dc 'a-z' | test_copy_bytes "$LEN" >"$TEST_ROOT/$NAME"
 }
 
 filter_git () {
@@ -619,7 +618,7 @@ test_expect_success 'required process filter should be used only for "clean" ope
 	)
 '
 
-test_expect_success PERL_TEST_HELPERS 'required process filter should process multiple packets' '
+test_expect_success 'required process filter should process multiple packets' '
 	test_config_global filter.protocol.process "test-tool rot13-filter --log=debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&
 
@@ -684,7 +683,7 @@ test_expect_success PERL_TEST_HELPERS 'required process filter should process mu
 	)
 '
 
-test_expect_success PERL_TEST_HELPERS 'required process filter with clean error should fail' '
+test_expect_success 'required process filter with clean error should fail' '
 	test_config_global filter.protocol.process "test-tool rot13-filter --log=debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&
 	rm -rf repo &&

-- 
2.49.0.472.ge94155a9ec.dirty

