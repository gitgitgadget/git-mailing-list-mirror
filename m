Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397BD286D7B
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334290; cv=none; b=lJCOeU27UaGfAVu4JTknNL5E/XVWFk3NfsYQzoNToY2xvN2YGw+JErJ3tr8rEd0vr5W2b9bl48PRXZmCzlf7Gl1iQ+TnLabhKYQOZJcjz//VTaY5RBcV1KbPiYN0fnudqUoAKqqqkjStXYWLPfen1+rr+PQiJtOKxnwcGC++4/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334290; c=relaxed/simple;
	bh=26xY9c31TN2MYUpc1OZq234iEBEpHUd1WQOthCi8lbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZJHGtWejZw2fOTuq8PzKzOPSNaFMO6LpwPa9vOSaANvHrfRwYPUhFcJJT0pwx5SHeiojWiba82sdbRXQ7nc35XTJEWzb7nMVMQ6Y9BnFEo+bJ0YXetokBe5hJcSON5nLYLnQfR45j6DasIEaxyhWWlCcl8fNTC3/afLgYIXMsYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CN+C/dWP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gTHFsTq3; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CN+C/dWP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gTHFsTq3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2B14F1D00471;
	Wed,  1 Oct 2025 11:58:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 01 Oct 2025 11:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759334288;
	 x=1759420688; bh=O4bTKxy2SU1o067RsirRXk4IowTwiXB/YxEfx+xbxvw=; b=
	CN+C/dWPStE4OGl/POU1PTO9uxY/lkhG/L6Mbz8OgkVhS9sqIvRz+H1kygdPddQV
	XyAsSpFdNmQ+4vxsEwgFVfvwNlqvaCFNJibPpzUbtZ0hp5CTO9sMoYzNSnRgCO/E
	nRgNTLrddlj5zfBdD1Wmz1NdWy+7bAaQoZRqNp8gHIPe0fObYnr5Nrqihwcs0p9T
	tcb0IM7h9lZ3Rin0Ao1qz6bzPjyN0w5CvghDBC2eqPAAxFmGZxEIhX8ORvoxcEH7
	rCy6TOob99I/tE31I6EA/1s2Uki8Pg5bTDQX9+QJxMa/Ize5VTRVz9q75RyxcdCb
	4E3KxHWOB4RZjZHV/Cyf5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759334288; x=
	1759420688; bh=O4bTKxy2SU1o067RsirRXk4IowTwiXB/YxEfx+xbxvw=; b=g
	THFsTq30pL1aMQzLAEiXXh4jhvWbO/nRr/ljgeg/CptRuUK94iIo4CjP20XkOy00
	9LzVS+awCn3EYlP4GIKiU4AvLsGVoguP077T91s/Imkijzq4P/mm5jP7pgX23BSf
	88rppT3jaGhrtjwATNIXhDGOpVDqMNzvl8PtFe1yBfzpdEHb9K+hHx+xcOuym6Kj
	qSpRTi6lO7n0vcvk00SUH4/aPyagZSpQ6YRwrAiX+sMOT0OK/3MyY63JJ4F9jDe6
	pDaG0aWTi5OrAUShSHNo0fd30zBhMrMCiFHj2BYe8Y4AG1aVppIDkgqdUsex1P6Q
	i1pSIYQkgdNwCNesY62AA==
X-ME-Sender: <xms:j0_daNL8MhQsOdVHXIzykTjeuyYd7zLCbWMo2WGbKaXiMYMzHfPD-g>
    <xme:j0_daINM2yRDYHsP4ujprdEAdvbrMlrydqCYepmfgwYvJYShWYEo30EBTU2i-4V_D
    b4-3MEi8ci-DABV0VBGD4L8lrhV625ebGyn96i_VKH5AsUdOP6u>
X-ME-Received: <xmr:j0_daL4Dbm4gF3DbGzZt5TWc_IpVJEJJ_CmlbMibLZx9YoEpv8O6siKa9GpEBIX_2X2NNAR8RDIivp68M6Rdi2u7etCMLh8P4TqzJLSOIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgv
    vgdrfhhrpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:j0_daK5pRYgJ66ttwWO6hHhnOZMIulLivc5_VFPZG36HRtY-6mroIA>
    <xmx:j0_daJHhJtu5mkP69Xi2y9EsL8BtGcy8M1pRgQWCSLtWh2YGcJmb3w>
    <xmx:j0_daKVOms4Nyg7BkI01OeIBJNxXodmb-Yn8Zv-WlE8ADAZp4p4pjw>
    <xmx:j0_daNUKO7OceNG9sNx15Clc67lzxTg-49gBotgYLvJcCc7z9YUeqA>
    <xmx:kE_daPn0L6UG0I7ZPIqjICMF4jmcC_OoFZRHP9V6QdpbOvbEJe7MLszO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 11:58:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8f298b2b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 1 Oct 2025 15:58:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Oct 2025 17:57:33 +0200
Subject: [PATCH v4 07/12] add-patch: split out header from
 "add-interactive.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-b4-pks-history-builtin-v4-7-8e61ddb86317@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
In-Reply-To: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.2

While we have a "add-patch.c" code file, its declarations are part of
"add-interactive.h". This makes it somewhat harder than necessary to
find relevant code and to identify clear boundaries between the two
subsystems.

Split up concerns and move declarations that relate to "add-patch.c"
into a new "add-patch.h" header.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 add-interactive.h | 23 +++--------------------
 add-patch.c       |  1 +
 add-patch.h       | 26 ++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/add-interactive.h b/add-interactive.h
index da49502b76..2e3d1d871d 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -1,14 +1,11 @@
 #ifndef ADD_INTERACTIVE_H
 #define ADD_INTERACTIVE_H
 
+#include "add-patch.h"
 #include "color.h"
 
-struct add_p_opt {
-	int context;
-	int interhunkcontext;
-};
-
-#define ADD_P_OPT_INIT { .context = -1, .interhunkcontext = -1 }
+struct pathspec;
+struct repository;
 
 struct add_i_state {
 	struct repository *r;
@@ -35,21 +32,7 @@ void init_add_i_state(struct add_i_state *s, struct repository *r,
 		      struct add_p_opt *add_p_opt);
 void clear_add_i_state(struct add_i_state *s);
 
-struct repository;
-struct pathspec;
 int run_add_i(struct repository *r, const struct pathspec *ps,
 	      struct add_p_opt *add_p_opt);
 
-enum add_p_mode {
-	ADD_P_ADD,
-	ADD_P_STASH,
-	ADD_P_RESET,
-	ADD_P_CHECKOUT,
-	ADD_P_WORKTREE,
-};
-
-int run_add_p(struct repository *r, enum add_p_mode mode,
-	      struct add_p_opt *o, const char *revision,
-	      const struct pathspec *ps);
-
 #endif
diff --git a/add-patch.c b/add-patch.c
index b0389c5d5b..9d0890fc49 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -3,6 +3,7 @@
 
 #include "git-compat-util.h"
 #include "add-interactive.h"
+#include "add-patch.h"
 #include "advice.h"
 #include "editor.h"
 #include "environment.h"
diff --git a/add-patch.h b/add-patch.h
new file mode 100644
index 0000000000..4394c74107
--- /dev/null
+++ b/add-patch.h
@@ -0,0 +1,26 @@
+#ifndef ADD_PATCH_H
+#define ADD_PATCH_H
+
+struct pathspec;
+struct repository;
+
+struct add_p_opt {
+	int context;
+	int interhunkcontext;
+};
+
+#define ADD_P_OPT_INIT { .context = -1, .interhunkcontext = -1 }
+
+enum add_p_mode {
+	ADD_P_ADD,
+	ADD_P_STASH,
+	ADD_P_RESET,
+	ADD_P_CHECKOUT,
+	ADD_P_WORKTREE,
+};
+
+int run_add_p(struct repository *r, enum add_p_mode mode,
+	      struct add_p_opt *o, const char *revision,
+	      const struct pathspec *ps);
+
+#endif

-- 
2.51.0.700.g236ee7b076.dirty

