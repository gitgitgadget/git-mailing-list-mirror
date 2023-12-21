Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC565822C
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWCzl13o"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c39ef63d9so10200775e9.3
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 08:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703176870; x=1703781670; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XxHqJWvbMaJ8kSLADFR194AUuAUgfHnTsU1sdJ8Qlg=;
        b=PWCzl13oanh9iNJaHhRJ3bn18QA87sqPxbb0V+HiVwIYhE1HggT6fKVU0stCnEwUBO
         MrRd824UbZ3WlaGWu0eNXE8FaAp8n8t2xkCiarB19esu9asmamZcaadFjnZkwE/yeO/X
         99MAY07GesWYl10FL4zJJGuHDLtW3LgdIbQuOE8mveIcp/G3cTxFjkux+m2d4SeSjdj/
         QMB5SmGNSpr4Bz+RvyjGQYwL7M2OnklJvyURVtMnKvt+6OXFNEw8aNV0up1Pf5zAzN0g
         pkwRtq3Ct6JAnXEnRYfwXsxfV6OpGCIpzBAEHMrd4pWpI9kWgy2AG2//Fa0aDa/VIGqW
         MX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703176870; x=1703781670;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XxHqJWvbMaJ8kSLADFR194AUuAUgfHnTsU1sdJ8Qlg=;
        b=d07DUFrmkvFyyVP1lvSMMkS2boRHfjUHLKqZ6OEQ+qx71TEQHmH6ishW40JD8CZTDe
         KfiEoplX0IPv6khYcTNHPDAf3eK0nmU1DGkKnUNMHZqjDd/2NYvX5I/ckQH1zL0YGvVh
         SjiPos7ZSXtJFyQYv+qviZHLj6+LLq4OQvGqRT0QB0W1rMQ4Q0HNKBLJXAj+SJdpgoc1
         9V6SmiXh8kpYOL2wtMdmkPJfrnfwS3ksG9I/4hjie93Tt0kH9Zs81QK1SVFEYk98Yxjv
         w2hzAs06iI0CLLMoRAmdyfp0VGRx36HpUcbsXOp5bs9Z3Ns9S7EZjlpZvWexrFg342OU
         IeTA==
X-Gm-Message-State: AOJu0YyxVqs6sf5bUbZ2aziVNmRHmZ/ijxLOcQouPoRS1QpO+G87JqYQ
	opxRq9HdYcdZzaET5ZJD8fIuQZbAYYU=
X-Google-Smtp-Source: AGHT+IFZ4E5HBgim5sgmPTeAY8uqQ8kHgGOcitjJstTqZqPVT11bIuhNZBEcgpcov2n4C5QzwO0gCQ==
X-Received: by 2002:a05:600c:5106:b0:40c:a5d:860d with SMTP id o6-20020a05600c510600b0040c0a5d860dmr1043968wms.169.1703176870429;
        Thu, 21 Dec 2023 08:41:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w20-20020a05600c475400b0040b4fca8620sm11668905wmo.37.2023.12.21.08.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 08:41:09 -0800 (PST)
Message-ID: <eac2211332f754c5f4127a58aafb9882bfe939e8.1703176866.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
	<pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 Dec 2023 16:41:00 +0000
Subject: [PATCH v2 4/9] SubmittingPatches: discourage new trailers
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
Cc: Elijah Newren <newren@gmail.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Josh Soref <jsoref@gmail.com>,
    Josh Soref <jsoref@gmail.com>,
    Josh Soref <jsoref@gmail.com>

From: Josh Soref <jsoref@gmail.com>

There seems to be consensus amongst the core Git community on a working
set of common trailers, and there are non-trivial costs to people
inventing new trailers (research to discover what they mean/how they
differ from existing trailers) such that inventing new ones is generally
unwarranted and not something to be recommended to new contributors.

Suggested-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 Documentation/SubmittingPatches | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 32e90238777..58dfe405049 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -356,8 +356,9 @@ If you like, you can put extra tags at the end:
 . `Tested-by:` is used to indicate that the person applied the patch
   and found it to have the desired effect.
 
-You can also create your own tag or use one that's in common usage
-such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
+While you can also create your own trailer if the situation warrants it, we
+encourage you to instead use one of the common trailers in this project
+highlighted above.
 
 [[git-tools]]
 === Generate your patch using Git tools out of your commits.
-- 
gitgitgadget

