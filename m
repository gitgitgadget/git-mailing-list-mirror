Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900D7237168
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870526; cv=none; b=tZXkf1cHG0NwhYjC5LYOh3U2Dd8zTLvoffZAM/XXFe6o9IYJEk92H7QRWX/OTdVQwvQZ5U8rynrrNh3Uklk374+rkXIHfRzN2S9ACVcrFoFbdZL4jSK/XPujC3hKGK/FrHgwiDROqjAPF1TPwmQIfnsnxAmMvajnlRTeccLbBa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870526; c=relaxed/simple;
	bh=ZpzGdY65hEHKrcX5W16hW7WWqWUek51eTOPC5DIXvXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rpI9bUmpyTJ90ejz/Cra4vhKZ9rlMef36hp1M2vciBFXPtWW+NxkZlYO+THg+8qQfvYr+ran/Qol0dpElIStZhWRulRlST3MIYhK6rp82YNhdUd4kpTkwK6VcrwmVreUHtB4po8pIMiHUBDm9EpGlPd8mlBcCCWJEHf9wqeTfZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mp1meG1Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ziyrq1TF; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mp1meG1Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ziyrq1TF"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 89E9B114022F;
	Tue, 18 Feb 2025 04:22:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Tue, 18 Feb 2025 04:22:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739870523;
	 x=1739956923; bh=0sXYiPZWX3259kZz3WP2j3CFxx+mqwtdzt20NxVskgc=; b=
	mp1meG1ZQNIu219zQEuOUh3XwDQuaisj1Pb2ylEf9cwjT68mwVuH9ViIuTua83Mv
	PMtQrxiK4IUIGxzfkDQL+PKIqQs6Y+90nsH5A+N2wvaUnmWsIh4Imp4BYweHaI5Y
	+BzaASxGu9QQEWFg2k25KzRGl249jTtWuDLS0aQcsCi7uvBqznTf4gU9rSTrl5xM
	jGYxKUlFVpg1txQR+fhhSN/OPAt0pYlzlcwF3lwzwlu8uDP4ZMF4NoCGXZrLZGrR
	AtLgcaLFclh0L9KM0smiVkdUiMNsx26BLLTc2HLapeqB3VyF1WuLpMylhfz86nn8
	GJjcg9oKZDZXos2tUGAHeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739870523; x=
	1739956923; bh=0sXYiPZWX3259kZz3WP2j3CFxx+mqwtdzt20NxVskgc=; b=z
	iyrq1TFuxAsVB+cOl74a+ejirye4+aMS/jZR0f8CEjfA2oRVwjjKaKScBD0CPq/q
	vWkHwfgnmpvr2KfROZc8z6zmGoMWRpezjWsUwMIbZDgCBgEh3wwLYw9iG3AGv2nL
	GaKlI5vtr8jtReXij6tN551oRzGUamxhWL98x2ClKE7PqCDoqo6zF23mftYJMGQl
	BS3bjePziqOfqS9YiL9szPgWcFLR8WYFOVH73v+4FLZt7cPh8IeYT/Nits9YbMoj
	k7FwjjqqI4ZIQQSbAnbXsPjkQ9xHRPblVOIZSmLGSO5/k0XirF+/Q9gXwlotOESK
	/L1dcc0iwpugBuRqNl/Uw==
X-ME-Sender: <xms:O1G0ZwJaFlRAkOGleQXHERpmSVsHr-9GgW_Zy_ZDLoK1iAS59Xv7oQ>
    <xme:O1G0ZwI7MOAGGCfRJYFPrS_WnGmiQO-H0WiS4z9kOggEKT5oEpaAWZKyaUAgakxXn
    fZnVxu-rqTN6KY84g>
X-ME-Received: <xmr:O1G0ZwtExeKR6T5d_C453D0WP6ba9m5KzbIhuStF9aiF-ycfJQke-yw3E2fWx9GIrPmWAa6y64NPbLVN3-f6r1kQhMS6RU0S3CNpW2kdThw3-990>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoh
    epvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:O1G0Z9ZGJ1LS_Zt044IiifCEzNs6UxVZMVip_i3D8eEJ2-uviGngPA>
    <xmx:O1G0Z3Yx6WFulTem4VEOhWc39JmmbJZglhWHb0fTaPLMnCs5-yS1Aw>
    <xmx:O1G0Z5CvaKAVtHaKLPExqRMpcRsPOJfjyfpRuTHoBLHJELo6O-GNkw>
    <xmx:O1G0Z9axq4Ud3sitlFy-VponbeLIzulte69yCNn6laEZJcRDW9yinQ>
    <xmx:O1G0Z8NDtrpwO4J9H0LVsu5CK5ZLGjZMxeH5iwJLouX2FDibBiM6qKK_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 04:22:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d3c2228e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 09:22:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 10:20:47 +0100
Subject: [PATCH v6 11/18] reftable/system: introduce `reftable_rand()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pks-reftable-drop-git-compat-util-v6-11-8c1f39fb4c02@pks.im>
References: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
In-Reply-To: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

Introduce a new system-level `reftable_rand()` function that generates a
single unsigned integer for us. The implementation of this function is
to be provided by the calling codebase, which allows us to more easily
hook into pre-seeded random number generators.

Adapt the two callsites where we generated random data.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c  | 4 ++--
 reftable/system.c | 5 +++++
 reftable/system.h | 6 ++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index c33f0c3333a..08893fd454f 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -523,7 +523,7 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
 		close(fd);
 		fd = -1;
 
-		delay = delay + (delay * git_rand(CSPRNG_BYTES_INSECURE)) / UINT32_MAX + 1;
+		delay = delay + (delay * reftable_rand()) / UINT32_MAX + 1;
 		sleep_millisec(delay);
 	}
 
@@ -688,7 +688,7 @@ int reftable_stack_add(struct reftable_stack *st,
 static int format_name(struct reftable_buf *dest, uint64_t min, uint64_t max)
 {
 	char buf[100];
-	uint32_t rnd = git_rand(CSPRNG_BYTES_INSECURE);
+	uint32_t rnd = reftable_rand();
 	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x",
 		 min, max, rnd);
 	reftable_buf_reset(dest);
diff --git a/reftable/system.c b/reftable/system.c
index adf8e4d30b8..e25ccc0da3c 100644
--- a/reftable/system.c
+++ b/reftable/system.c
@@ -4,6 +4,11 @@
 #include "../lockfile.h"
 #include "../tempfile.h"
 
+uint32_t reftable_rand(void)
+{
+	return git_rand(CSPRNG_BYTES_INSECURE);
+}
+
 int tmpfile_from_pattern(struct reftable_tmpfile *out, const char *pattern)
 {
 	struct tempfile *tempfile;
diff --git a/reftable/system.h b/reftable/system.h
index d02eacea8f0..bb6a7e6285b 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -14,6 +14,12 @@ license that can be found in the LICENSE file or at
 #include "git-compat-util.h"
 #include "compat/zlib-compat.h"
 
+/*
+ * Return a random 32 bit integer. This function is expected to return
+ * pre-seeded data.
+ */
+uint32_t reftable_rand(void);
+
 /*
  * An implementation-specific temporary file. By making this specific to the
  * implementation it becomes possible to tie temporary files into any kind of

-- 
2.48.1.666.gff9fcf71b7.dirty

