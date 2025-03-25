Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE001F12F9
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742945541; cv=none; b=mmnqY59xSR/GQvPZUC88UyW6OZEOepCOF6jGrSi3UIISX6Qk5Nkz9/vZ6ZgRqTDQkbSLscxXedpBiMeCgFP98PXorbGg+ymwJQX6yqaCOoN1tkkm81PfNNE9gHn8t7yp7QaGP5/9ip3kK5lajD15mSLhONy89O/lUvnv3IVuCvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742945541; c=relaxed/simple;
	bh=5eDboXlLY48klQSRh7ROAxKsGF5oZ0kBcpqQ2u9roxg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aGPIEe7sOKsujhNrd27HxDz4J8WnnQdjDxsRHFkMiP2Ic+DPH9fguBtrypzzzCUpe/adCkAbO0nl83UAzGSUldn5j/9L3fjLQ1Hu/I8dWiCIs0ETQadVov5Z2gE+2uW+huZo399W9cW8ZxmHtFa0QdrSWEdI3j4GdK1MPQy4jFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2MyLR/u; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2MyLR/u"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3996af42857so207479f8f.0
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 16:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742945538; x=1743550338; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nZguIGcg25DdMGIUwc0IS/mZSObQwqLnttu/HYceu4=;
        b=Z2MyLR/uHua/4h6wHhsNmw7p6Sd4etvpctYEpXpo/4EVxCnHcLtZYgam9m5uRKjXLn
         5HQwDQcQ3f5f3QqtyWRmWDdDkXA46PC13q4S0gRRfO6FGij1/PxQU4in/exUFnyZH6qZ
         VWccM0r16j/9t4jTS0QFMNDmgzEK/df23fqzqpixWCtWVsOe2XAAqj42x0JXKgiZFJuC
         2i/oz5LQT8C6qp9C8LMDIlWUn+y63MAKtqIF4oGuhqt9pwSdFgclAfCSVZEXnnk9eGwN
         HvW+u6VVTyAY0eHUYitp3n1h9bGydmCzs833anqdOkB3kK2tYsRKLCrkTutbWDkIaepH
         7V1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742945538; x=1743550338;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nZguIGcg25DdMGIUwc0IS/mZSObQwqLnttu/HYceu4=;
        b=ndGnKory19K4XtKxFKGHbOy615EgXjacZAredI3/VHfTU5mxCMqbCda3OB3WPMJH8A
         I+Y6sQ9eCREreGoVX+B1ladpUvhGZ1GaO5JBCfUPgdo7dc+yykOzSTEh0+6WYUJlIT1Q
         /s+zC40rFwWIu9qrCvYI2J64glxPf1Dk3SClHodaWRPK1JH/xdhw3PMDjLBI1RBhQC8i
         s4xOJUAsgOBfPi1n46iTQFQQJUlHglGX8+FF1gtSL4YJqqxJL1Enemd3HrRn+O66HMMP
         ilSUzCRFdff62FoXOSyUr/s8PV2ddwzWDBHCeQLLZWcLk67sRJLqT/ZNPblnuE7SHCks
         XuVg==
X-Gm-Message-State: AOJu0YwSlAve2v91eRE2S1RU+wb4rZl61o1i0G4m2FXLwDG0uRRMqYA8
	cqHtnrCS3QegVkk+bkhOI1oBL/71fPhAldL1YPGcOUHloEdW6k0f0uxYLA==
X-Gm-Gg: ASbGncuvw/ND0U8qY6Vn/VnuXnmtglRhemjs5XS70vGS9d1BvnduJ/HTy75f++qDlua
	sAMAev2GOaax+iTkamL6w1k3HRq5oHIOWvBbWCa4VSlPb2qRwf6y5ZgRu+OPjDUh7Uw/ooI4aMa
	EErYtYYF0ZLJHG0GIUCU/9gcngRBCRPsAHPbXAtxPwXCxTWVe9KKFGMoLB9+JC86NJ8ZsxM3cgm
	aCIAc40TslD3JWaN/GyAJ/heZrJZ3XRzf5IGCLmrlTL+De2Z28Tc9NE2peY7rQ1QIbPjtFhQxmm
	A2p2ET+ceItY/vwdDc28A+IhYo3pJiZINCZ2f0fwKITq+mcR/9Z3kMS9
X-Google-Smtp-Source: AGHT+IHGHXqcSYOEgE9U3GlG9Zo39R69pVms+QwfQOa0wf+MkTeVdFppuIqltswTGE79mz3YOsVG8A==
X-Received: by 2002:a05:6000:2112:b0:391:2a79:a110 with SMTP id ffacd0b85a97d-39acc48cb13mr1238563f8f.29.1742945538007;
        Tue, 25 Mar 2025 16:32:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9efc9bsm14776528f8f.87.2025.03.25.16.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 16:32:16 -0700 (PDT)
Message-Id: <37ff88b8275cf4d6b0c715a99f4572e70d6e3729.1742945534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
	<pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Mar 2025 23:32:06 +0000
Subject: [PATCH v2 02/10] rebase: avoid using the comma operator unnecessarily
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Karthik Nayak <karthik.188@gmail.com>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The comma operator is a somewhat obscure C feature that is often used by
mistake and can even cause unintentional code flow. Better use a
semicolon instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index d4715ed35d7..62bdf7276f7 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1843,7 +1843,7 @@ int cmd_rebase(int argc,
 	strbuf_addf(&msg, "%s (start): checkout %s",
 		    options.reflog_action, options.onto_name);
 	ropts.oid = &options.onto->object.oid;
-	ropts.orig_head = &options.orig_head->object.oid,
+	ropts.orig_head = &options.orig_head->object.oid;
 	ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
 			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	ropts.head_msg = msg.buf;
-- 
gitgitgadget

