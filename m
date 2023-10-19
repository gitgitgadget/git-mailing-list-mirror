Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4A92FE3A
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SixJ+zSL"
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7950912D
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 08:27:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4083f61322fso14498815e9.1
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697729268; x=1698334068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3kimNNYWoqBwfTCPtYxbhkrkDRujBhE+wKsXyBleEaI=;
        b=SixJ+zSLdn0akl0L89EyhNUfZslxdka90+2OXogdGqUXILs54J4AlmMy1QUgbpZD7w
         kMlrxcbfePwq1bYb9rb2rrI+hDbgDxXgcPCjci6U0mjN0Sc7ZdurydDdlMLW01n1IOuI
         DD4ghMNrQv9iQ3mDw+Xi+qAstHtknTdBJ6rXCSwtAZT7ZSFodB3OgoI5X7OiQkMtM9HD
         +0l9DJ5+ecNp4w4cXLCr674Fr7dWJaOXCS5CjFSTGnRriQAr3S5OPruNMv8TT99O2W7j
         e6nkCWexNdxpdcDpalpAQtkpPSpX+LWkAY0IO8ffoKDe1B9sqtTTEui0LRlN4qBtPHPn
         ba6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697729268; x=1698334068;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3kimNNYWoqBwfTCPtYxbhkrkDRujBhE+wKsXyBleEaI=;
        b=HiqrBSbcozo8+OgSBx+GshG0ON6/ruC5UBmdLsphtr/xfnvuIdwvsD6zttbV3nmzEc
         t8wTR0uS6s7EvYhIbeHTZYIeJrLjnAjc+JjeiOIGlJPS0DDKnZNtIFEztdZDOPoroZZs
         a/MdYeXLkbw7C03JaTezAli/mo0IFMtauzoTXDnMKLGFsIndCjM68DpzUffM8ieTYBO+
         vXTjImChZvX930KTsM3rV+amAOD9y0qs3k0EluDfMCxP6hZCIWWd+e3rd2Cd48B9WCic
         VSzsF0JfrnoejUGwwlmDlYhq1CeN664GXbXbLPUY1c0GVG0vS0F77eJS8exFIT8d1Ydu
         Au4A==
X-Gm-Message-State: AOJu0Ywvg/fqpTCgspapQUOjxYHw9d7tltTo4FF1c+ieuWJicqG2vG09
	u/M0MRmwWAH22HircjZtm4E=
X-Google-Smtp-Source: AGHT+IGVXoYuq2PvDOG1o3iDOy4lOFfw/xwhfinOmWvYzzfvqVCfXs06s/7YAanF9jtq6nY8ylbc5A==
X-Received: by 2002:a05:600c:5122:b0:408:3bbd:4a82 with SMTP id o34-20020a05600c512200b004083bbd4a82mr2199057wms.15.1697729267527;
        Thu, 19 Oct 2023 08:27:47 -0700 (PDT)
Received: from localhost.localdomain (host-2-102-115-95.as13285.net. [2.102.115.95])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040641a9d49bsm1022117wmq.17.2023.10.19.08.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 08:27:47 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: gitster@pobox.com
Cc: calvinwan@google.com,
	git@vger.kernel.org,
	johannes.schindelin@gmx.de,
	linusa@google.com,
	phillip.wood123@gmail.com,
	rsbecker@nexbridge.com,
	steadmon@google.com
Subject: [PATCH 2/3] fixup! artifacts-tar: when including `.dll` files, don't forget the unit-tests
Date: Thu, 19 Oct 2023 16:21:50 +0100
Message-ID: <20231019152726.14624-3-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.42.0.506.g0dd4464cfd3
In-Reply-To: <20231019152726.14624-1-phillip.wood123@gmail.com>
References: <xmqqh6mzwe24.fsf@gitster.g>
 <20231019152726.14624-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 075d8e4899..e15c34e506 100644
--- a/Makefile
+++ b/Makefile
@@ -3597,7 +3597,7 @@ rpm::
 .PHONY: rpm
 
 ifneq ($(INCLUDE_DLLS_IN_ARTIFACTS),)
-OTHER_PROGRAMS += $(shell echo *.dll t/helper/*.dll t/unit-tests/*.dll)
+OTHER_PROGRAMS += $(shell echo *.dll t/helper/*.dll t/unit-tests/bin/*.dll)
 endif
 
 artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
-- 
2.42.0.506.g0dd4464cfd3

