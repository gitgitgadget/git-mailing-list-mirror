Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EB720E310
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076390; cv=none; b=CwfYMfWzJAJlLzQ3l7H4Kn1flisUm/HDUI6+KSlxLPqBphtRxjHs+w1bt0oKhYReyk2i2ij6pr09QdcmS1ZldIlrsCqHEW4omOZRsmLyksHnpIYnVbdiCsJO+7CeSTggeYXbfjLAx4fd2bU2/JLGZE2QkIlrvbsnf+0Qcnk+BIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076390; c=relaxed/simple;
	bh=5eDboXlLY48klQSRh7ROAxKsGF5oZ0kBcpqQ2u9roxg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mwApqsJBPcZpK3V24DBGKLJoVIzfTAiMdoGatI7TrrRkGnkFYnRXODe2IWXRntOTK7Lk4l/Y7AV77QU9MnPSZxer9Pup7sxcvryDCEoBj368ZM2KA6dpQkf53tJer+RsU82h/tckkC5XURVy2YKILkLx5FyW7ndzMvLAU8EueVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcJX5F+G; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcJX5F+G"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso5458015e9.0
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743076386; x=1743681186; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nZguIGcg25DdMGIUwc0IS/mZSObQwqLnttu/HYceu4=;
        b=fcJX5F+GC5DJIFWzjPIG8tPOHXBifw20AdMRvX9FaDfwjUoqk2fNwlgk2x+lUSlUg0
         dw5tqLj5FA05cl99dkOMdvaPz2dEXVTlbGG9xwXMdbMxwpsqCKBiUD+fldGCTfocAzEv
         UJBobBUVhHbWK7MKLg3V3tSNyKms4WCrboV38U42K5yh0FKp1nfs9hfNbYhUgyQArm8F
         5+RhX4+pAdCN8jPos0A6KdunuDzgW9+orJZ7oOwIZIBhXFSHfIHgXju6YNXXe7FZlaG8
         VD7StORgw97gZ/8pSMy+bBDo1HxZPfnHwAvSW3rtZykhoRSei5SPHYshmDld6pdAfCk+
         YiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743076386; x=1743681186;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nZguIGcg25DdMGIUwc0IS/mZSObQwqLnttu/HYceu4=;
        b=ZNDpt+m9EHbCV0j9xL88IiQbKcaR4MX3cQgec1BLXNNKXZifXpbBdbZL91Ph+SyFKk
         nkoZJOF/+uvqnCfV6JzKt37y/iem273Dg5mzlzRNYH0OTmyh2k/U7VFRzHrye1HDSZBj
         CQJtP0xzqqINKLim2FZ1KpRaAguPwQRNFuhkCqJj7sYwH3WbTuK3EP/vCgc6GV1rFgkf
         kEk57qMamc81GlZX6hG8jiGOqyF2WGaZ0BSjjZWahvervu6Dh/LfuW2u7gX6kKptHIdn
         bo2PBtTmK0HwQRkWHnCIDeEc7VnVtbMN0gLMEQMmcmUgevG10q/C9FnquFk+i80+k97T
         kNAQ==
X-Gm-Message-State: AOJu0YyIt7X/WcICAI5p3hV7CkrIU050RoYkwuRNT1F4oNYUZqiotTkj
	SDWKxEaT1n5l0mkenbVqo5u2lcC8kN8NNazgkgU6HqSeYMO+Hu8O73oagQ==
X-Gm-Gg: ASbGncslX+fdHhDWP4e5nyK1r6BgRy945vncxCr7B19ecvYTv1oHaBiz66ukzrMxm3o
	ri+xS/KDQYUSB+Wa6eabklVTm8x8btMsX9eXjwpoh9Xuz6F3N9jfFmBwd2yYn5MZyRzkZRfMlKN
	tbQ4USRZ083h6IHqY/ep7W+13YzP/qXuhCNYwhaTy21ZHyr5KWJpPCmDwqQT/Ng79mt7yR4D64C
	7bSn2WaxrJzo8+3ZjvqbRxFbTZt8K4nKXRRXOeMV32QkhoI5YtkiwV4EofpOG2Adam8M/B2BVjD
	eYkUB2d1iDGoWghOvvJ4xazz9ARBnIPav75Eny587mZatg==
X-Google-Smtp-Source: AGHT+IFUV04OFWW2eN6di4TjVKBULV7bFj4KorqhjWvAv6d5fMUVZzPZP2l7fMGdytTyN66N+4Ec5A==
X-Received: by 2002:a05:600c:1da5:b0:43d:b33:679c with SMTP id 5b1f17b1804b1-43d847c40e3mr32007925e9.14.1743076386363;
        Thu, 27 Mar 2025 04:53:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82e836a8sm34670465e9.14.2025.03.27.04.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:53:06 -0700 (PDT)
Message-Id: <37ff88b8275cf4d6b0c715a99f4572e70d6e3729.1743076383.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
References: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
	<pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Mar 2025 11:52:55 +0000
Subject: [PATCH v3 02/10] rebase: avoid using the comma operator unnecessarily
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
    Taylor Blau <me@ttaylorr.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Chris Torek <chris.torek@gmail.com>,
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

