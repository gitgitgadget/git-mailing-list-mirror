Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3914A377EB9
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960577; cv=none; b=Ry3KTQv/Wh/SLpWrD8Bjj2lZue6rvortr1j8Voxa5pXwIqcrm8503PPpGcP7CiHYkfRKCKSmTb45L/XggoANFBvB7+snjT0ZNpk3GUwdGUtwz3wPxl0XLx3i4fZoopjiT+RXrii3bqkySqOofzFKzKEDi35MkMxRg/AKn5TJNFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960577; c=relaxed/simple;
	bh=LqrWVxm5hRegQo67dlT9BNkrsEHa8+M1Lj4VGhx2+lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJshW3geh78qWKDLEtI9gDZiswPKFC5JoFsnmq7C6IuYnX0OQNPRPMZUHfgQ1vK/BSb4yTiOWrFl9UXg44vevttm470UQIuqtrSV7MVUaPbhRXny56D2orHAsv3p2GCLqs38WZvcHkAspcz/sWJECtjs4IkFCOXquuim/ptTUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tj5D61zP; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tj5D61zP"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79ab3e26cceso63368387b3.3
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 09:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776960575; x=1777565375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ld7oYUXhtbOmZgCicPn8nfEtNfl3j2226NtwNaBw6Os=;
        b=Tj5D61zP3LKASdjiXyWoPw9KH8HXrPBkeS4SN3XrAQ0vNkCAutk7bAKFPTj/UbAaqa
         brc7KE02SxpB9nUjK+Ij1Nw5IOv33acBUa6JQe4ZykD2oJtfqt9garreWYOOoGprbbrC
         iiPeUGCsMA6uzEU78CLWC4BfO6P3Bo1VPbW9Vm2mFNVRTbPG9Hb/wrELvAOVLdEibHF4
         PTV4e5UEiyLBouXPjjlwc6YKWpwBJ5klWZ75Z8IkUp7qyCn5dzGgVngMcw6abTvSa0Iz
         6tU6aWO1LggcDXB0dvMufClS78b6bRZZfIabYAExr36qnO56PLHPCjUBTQpnPO/k3WWf
         L1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960575; x=1777565375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ld7oYUXhtbOmZgCicPn8nfEtNfl3j2226NtwNaBw6Os=;
        b=ox6hc2l/FKuhAQsvK8DB8AiJ1Aq/BfXWMBsL1Yy7U1+YZR/AEzk5Azfq7ggNXRrXBd
         wbtVm4tQnnlFEQ9+Qgl1Vo/JkMniAYj4YUZ4WalIJWtZcEhysTRKdJTbJas+dFLRCtE/
         N0AbpAAlYZxBZ7a7RMoPQ2Rn0Y+QqO2AB4O9r2DsslQbOowQjepPyFp9lIgGpio9Qvsr
         A29cWtRq6TacaMDE6jhZgncinKGAkyAZRLD28w3fIoEGKnW/TNyuMiZrGiTf9K5DF8PO
         ZEz2yfNTemNyUy2DJcXpil7K8AMfDzZ+U1EO/21FhgUODZx4Hxq7xlGKbuCkJCoxVWCC
         cOAw==
X-Gm-Message-State: AOJu0Yyo2IlYkTxNFtM1UaRoPWf4vFO96E3SBHyZLJ6NMs1DbD+LEn02
	BcDDzqO/FjAKs+C9luUC1doB700E7+LHWPIB4shPqiQC2hrmcPgNYeuyIFYGLmUr
X-Gm-Gg: AeBDietwilK91DWV9t5qKWWIo0HU0JVqjfCu4SgeGbGq/tCYj//2TIqxjAAOUbM8PQA
	E/nrIvh/lPBMPxv48q4rDemtxwQXibHY2S9kgF/zfFJj4XEcynp9uKeXmVQBylJxituUZFRQuhL
	kJ0PNQj/1ka9zGLpPSqHXRGasZ7MwF9+Q9supgMgJmsKspggUYVmB0Vv/XDGp7e+ZWcA1I442l7
	dj5iInq2WE2xY59HaE4jIIi5LEawhmNyGmvgcMq7p1sgyTXHD0Bmm4rYQC8N7OnvfQNEHdzS0ZQ
	6v30yLFHQs7zp5sPAN8qRkTt17lvPtnr6eLpCeF4NFfrgsF/spnPcy1WvpunOQ9hF5JpI5QpQTZ
	Bk65hgIxnQyzpCH6QKgl8F2XpCGxZDyuPKu5zfuVrb+O++ZX1kBtZ+udqDfqJ9yAkJTgodb3OAU
	vOAF5kkulBLXafskhiZwXPXFG4PWK1rooPKLrxmQW5vPwQA/1rvld0MdAW6ca9iPeWSgbk/A==
X-Received: by 2002:a05:690c:3511:b0:7b2:6177:2acc with SMTP id 00721157ae682-7b9ed0202a7mr276908067b3.46.1776960574987;
        Thu, 23 Apr 2026 09:09:34 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:737e:f405:338f:9bbf])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7baeeaa2cb5sm51083997b3.21.2026.04.23.09.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 09:09:33 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3 3/8] doc: am: revert Message-ID trailer claim
Date: Thu, 23 Apr 2026 17:08:27 +0100
Message-ID: <20260423160832.114816-4-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260423160832.114816-1-belkid98@gmail.com>
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
 <20260423160832.114816-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

I claimed in 3c18135b (doc: am: say that --message-id adds a trailer,
2026-02-09) that `git am --message-id` adds a Git trailer. But that
isn’t the case; for the case of a commit message with a subject, body,
and no trailer block:

    <subject>

    <paragrah>

It just appends the line right after `paragraph`:

    <subject>

    <paragraph>
    Message-ID: <message-id_trailer.323@msgid.xyz>

It does work for two other cases though, namely subject-only and with an
existing trailer block.

This is at best an inconsistency and arguably a bug, but we’re at the
trailing end of the release cycle now. So reverting the doc is safer
than making msg-id act as a trailer, for now.

Revert this hunk from commit 3c18135b except the only useful
change (“Also use inline-verbatim for `Message-ID`”).

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-am.adoc | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
index 403181baa9..14f83a8920 100644
--- a/Documentation/git-am.adoc
+++ b/Documentation/git-am.adoc
@@ -84,11 +84,10 @@ OPTIONS
 
 -m::
 --message-id::
-	Pass the `-m` flag to linkgit:git-mailinfo[1], so that the
-	`Message-ID` header is added as a trailer (see
-	linkgit:git-interpret-trailers[1]).  The `am.messageid`
-	configuration variable can be used to specify the default
-	behaviour.
+	Pass the `-m` flag to linkgit:git-mailinfo[1],
+	so that the `Message-ID` header is added to the commit message.
+	The `am.messageid` configuration variable can be used to specify
+	the default behaviour.
 
 --no-message-id::
 	Do not add the Message-ID header to the commit message.
-- 
2.53.0.155.g9f36b15afa

