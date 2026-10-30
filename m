Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382003;
	b=ilMGhF5Sgsx0hwsYkM9A3LpUiJyAa64Ru9aPPN0nTQSa4JBCw+/L8nB4glDZG7Af8UyA
	 bRz7Z0xISuoRkwaZR9h1u1WGNnlGh9CgI/MjRy6WMoFEZ0eLiOkN1nlq8voWNLj/kYS7+
	 YicBSgtSaSEk2Fu1toipwGYo69csJfXn1Kd8bWAYCbVqzoMZMh236YGPC7JbgygSuiz7D
	 F/uz9Bo186rFyaNnGn1KKuS8O7riA5CktlVK4OMgwmC7iOK+B/Ay0i9SNIqpUm+N6w6Hz
	 u8HpRki5ZoqknZhhzEDnnYgVKgqatpxaK057xhpMeKGEUfctpuTZJbq6S8zk+2W7f8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382003;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Zdd+EYkZOlWWt3j5siJcWKzNlEE5FXvwjdgv6/7GMAI=;
	b=3DU6Rw+7ZHdafzOaOHMImRU/4zxWXgZCcvfrNTUNkPMzsa2bFi21VQ0TxHRuJokTecPh
	 oqtk3hCr7C2eQRmcQ/PpIZorE5+yw2Wb8Jo8T7XBKruVDajJYyRinw9Ac0QQMaXddIVBz
	 Abtr6W8iHRRgSvh3zNcmpwHuv8CBVua68wkLlxXHSUy+3rUBPluDjjZI8hTLfktjkFZYF
	 Rcp2sSGcdp5GQNGUv77vdCogNWgJ0wlRb/1HE5ks5rdHARcIZfUo7Pi5Fpr3i4Advjw0F
	 snfhVajdmwLU0VCDjqS1Hc6622ICwM+wlxdkFhUcCJD8+538+ANgkps162/YyRwNFPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=hBerO0oj;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Dc+mITGb;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CEE606A329
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 17:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0CEE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=hBerO0oj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Dc+mITGb
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 106471D00078
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 13:40:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 30 Oct 2026 13:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793382001; x=
	1793468401; bh=Zdd+EYkZOlWWt3j5siJcWKzNlEE5FXvwjdgv6/7GMAI=; b=h
	BerO0ojWzv1sYlTQ/G/YFRd7BjenlPBrIeRAVAqIFL+sF6QI93ho+CIawe/TmWGO
	lT7SRmptLMsVKKYGYpEVXbF07EGavyqTbNwkY0xPLL5av7tmB3i0qirIiGIDr79t
	AVCvSil89UkWnU0LId8J0nICjhqtRXKUryJWqzTYXsrqlfZ0Q6PLcBQdjSAptEku
	ZiyT3W8LdpyDhEg0bOi3+bVoFBnmbT75os/sicnNnYFoKFq9Mebk547RJ5IdrlZh
	+i3Eo2uwYXPIehGaIL7lq9nu1Qb5BODmLUU5u6bGq+Cfy+C02ELqEeCgMIGBrXwk
	6FP90TsRlmaeN6jMqMbwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1793382001; x=1793468401; bh=Zdd+EYkZOlWWt3j5siJcWKzNlEE5
	FXvwjdgv6/7GMAI=; b=Dc+mITGbOL6Isf6xtDmJHQdj79GXvetunL+1Lwl3lH9m
	Dd3zndCcTjh45Ok0lkRfmSFR6zObbqcGOpLuwj1+uyNarPqUGxq8xN+GZnfw+XK/
	QMrlayvMcaac1Rii8zSU+vdHR11u2fbzpw51UXURimdRlzCJJCKtRZL1wjyPgiQj
	/PgTCyJ9AyWNB807q0CctNI1cc0C4x1D1bPCfEipF0XgopNYkOOpwS3oMIheIP4N
	ze+xiYafsQwsBaqNvS6t1lBDxeWQNdQIdtOnD0XZZX4h+eLbOl1e7pIV+ykl2nEY
	ofP41BVi0l+v59BXaV7hg/kehvNGaLkEne+yNdc3iQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793382001; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:EYsWR8FGhGzN+siQQR/R5rHb9Zb4vvjdE6yzLLhaOT0gsSh
	ghGC8AQmYcpwu8o9ptTiu7F4SbtILE5eot/W4bU58GOh8Y2H8egZTt07yz4KZqLE
	CFR8J4jlq6mrc9IIqvEr79g4bt4LpNJ4NBphlR/pGRjI0AkK3s+RTfAkrbIEoOt4
	9n6+XDYa8Ra8m0Lisnueap9vZUKk4PxtRgJIdRMDg2cAkRJ8Qyv91GOT9qGNP2sB
	Yhg42/jqSYH5GjsXLRgNQRgx2IB4nATy01BJHuq0pRuCpPwS3vLgsqkBY90tFBfk
	R/89lOMaWJDZS4TPizGRBn1c5HqCur6kVwCDzlw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:krwe6Y2wQM9qE2w+/OMaXaFxv4U0bRtkPtHvU1kl6WY=:JX+dS9eZJQEx6Ecc+S54IsINLdYrFZmrX8CoI2RZaJQ=;
X-ME-Sender: <xms:cdbkaltZPKmvLlz1f-uSnuVuJIFo5xczAAF9zyv3UDrfiwn63f4CDg>
    <xme:cdbkakdtcWkQ3YzVssAjO_pw7S6imvFjf-kjDbEgCavEGTc9tfyr8139xOyMxT8Bg
    2tB_1-gLKl81Wixk8KSkLd4RJmgJSuFDGJhUlb7uqzH2OE-Vx_hroQ>
X-ME-Received: <xmr:cdbkamZHNlHZdfJ_keplkvsB5Bmens3gIkIpq0T8KAPcC6xHFOOLDngPfSLeAhNS3O3a_pkz7Vtiqeh5IrjTvjOuHsm5ahWl1jYI>
X-ME-Proxy-Cause: dmFkZTES3TQjvhT6JGxcQNqra5Fje/GmahBRK2K5UBap7web+fxi8llJ2UQwMHhz4o0Wk4
    u1gSVYlNvxziRqdWFFEdVU0gnOBvfSNDKg7b8p1KwZVlp/wx+Rligg3XtLOsnRLHNisBPJ
    R319bxIG4V5vfZhBJ9sIoZvBMJKa9fcJW0AxsCCu6itePzJNX3dHxtIoWNP4fK3cf/GP3q
    2JOD+s+bQ9JDoGHtixt4mZh9cl5ozb971FLY5mR5gCy/sLuE8x19+n4Ok/RWwLPI8Y5rVf
    XZ5vyawgOYICQv3CdI5BdQjI5NPto+nWBi8U9HYq7645bDA6rrUQBuKgHCBy8J0x+/ICft
    F1solBmoz7bwc+ZbnZFyJN3jRYJ4KgIYTh7U0jN1RmRBgFCtB7S4+nzEd2Q9NBXhRnkzaX
    HjXD5yhDwOJPkVj6fSDGze3QGO1gC1caLyM52ryUJJiSKAbjVLps4zYzv1mdno9KFJEfxj
    oONQhgzogUIJpUVQkdiZwXqiLiJ1EVdZu2Eq0FS9+KtlB5yBuhCmiiT8NUcDDd5VNR7ywc
    Odp89YJxCmmiwoAd3hiVxlHU87Dxg80k112a5adlaGSbpiVLWgeHLdHncr2n/4NGXZin4o
    z4V/ON7XpfX1j1kt5UgsKSff07cU9vJyRAw8PH24z4eCpK0nDRmav86LgQig
X-ME-Proxy: <xmx:cdbkanVTJMYjUSLcBb7Y9Ud-PIXGKfn_mTisLlN0GcBFfyEuXQrXpQ>
    <xmx:cdbkaogkFVDjCytkU01T6zUMxJDfw5K9S9p1XO8tce_bwlH3ErNXEw>
    <xmx:cdbkalWpylKSZM7yc343z7oWU23xCpyDTXtv74RXi8t62EPs_pjQzw>
    <xmx:cdbkavMpXQBXgGNFdvyYpFPHLGK9PYgTolR-i5YJ0GdxEVIeMA-sHg>
    <xmx:cdbkahEx-Cus_5aIdjlyA7lRnKtWqt7HzmelViWoMAO9H6kJNAFQiNLB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 13:40:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/4] add -i: hide init/clear_add_i_state() functions
Date: Fri, 30 Oct 2026 10:39:54 -0700
Message-ID: <20261030173956.585250-3-gitster@pobox.com>
X-Mailer: git-send-email 2.56.0-486-gd49ba3b80a
In-Reply-To: <20261030173956.585250-1-gitster@pobox.com>
References: <20261030173956.585250-1-gitster@pobox.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "add -i" machinery is encapsulated in run_add_i() function,
which uses init_add_i_state() to initialize the machinery, does its
thing, and clear_add_i_state() to tear it down.  External callers
have no need to call anything other than run_add_i(), starting at
d51b61f5da (add-patch: remove dependency on "add-interactive"
subsystem, 2026-03-02) refactored the code paths involved.

Make init/clear_add_i_state() file-scope static functions, and
"struct add_i_state" type as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 add-interactive.c | 11 ++++++++---
 add-interactive.h |  9 ---------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 3cf8a1dbf8..9a00daf9f9 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -19,14 +19,19 @@
 #include "prompt.h"
 #include "tree.h"
 
-void init_add_i_state(struct add_i_state *s, struct repository *r,
-		      struct interactive_options *opts)
+struct add_i_state {
+	struct repository *r;
+	struct interactive_config cfg;
+};
+
+static void init_add_i_state(struct add_i_state *s, struct repository *r,
+			     struct interactive_options *opts)
 {
 	s->r = r;
 	interactive_config_init(&s->cfg, r, opts);
 }
 
-void clear_add_i_state(struct add_i_state *s)
+static void clear_add_i_state(struct add_i_state *s)
 {
 	interactive_config_clear(&s->cfg);
 	memset(s, 0, sizeof(*s));
diff --git a/add-interactive.h b/add-interactive.h
index eefa2edc7c..47f67ede82 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -6,15 +6,6 @@
 struct pathspec;
 struct repository;
 
-struct add_i_state {
-	struct repository *r;
-	struct interactive_config cfg;
-};
-
-void init_add_i_state(struct add_i_state *s, struct repository *r,
-		      struct interactive_options *opts);
-void clear_add_i_state(struct add_i_state *s);
-
 int run_add_i(struct repository *r, const struct pathspec *ps,
 	      struct interactive_options *opts);
 
-- 
2.56.0-486-gd49ba3b80a

