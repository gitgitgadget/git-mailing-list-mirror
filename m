Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9700F3D72
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 04:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Js6m7A8C"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-336f2c88361so1236034f8f.3
        for <git@vger.kernel.org>; Wed, 27 Dec 2023 20:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703739330; x=1704344130; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XxHqJWvbMaJ8kSLADFR194AUuAUgfHnTsU1sdJ8Qlg=;
        b=Js6m7A8C0VHu5mWqP5f6uR7JopVDiXHp8MHO0CAzaL+3f/4lTVVTX+ztkxflrmVvls
         biD/16kCbBl3HlT7IgBGpVoJaYPb6QXZmRQh+3/bARkk0ABqN9l9UQFZ4IQke8pTaXaK
         hC9nhQz6k8yESmahzAlDFTUIt8SOa5kjllCtoTELi5Fz8diBDAk7wqFmldvSY0B1PxS2
         q/h7s6h0ec8XdIMWsT2/YIDyxMA3puODW1ppQOg9bRTCXMjRQA97KRx5kcs+ZI/v/+dL
         Z9pnMfEiX3S2gJ2jssA25j7Al78jImpbe0rx751FCvSd71xLZkrCZ7vZwLGZIZtcTUfq
         vT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703739330; x=1704344130;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XxHqJWvbMaJ8kSLADFR194AUuAUgfHnTsU1sdJ8Qlg=;
        b=nxEhh9hi+JpjNvi3G+geqNQLR4SE9jWkQVRpz7VnDUTqO/wZzjGi8/oiedRbWucBOv
         K0Y4iMxRy+rGT4BchO9ppue9nt+2IvV9RYJn7mOLFD2dY9iH/6SIdI6jbEjlZDlW7HxW
         faBwy6Mkvvj9+RoP1AmAqX70Ec8N+1lfrulf+F2/KKw/j0jV7pT1BCaH1AktO+sqtczV
         PEPzunvPflK+Iz+62NdmplOOhctpM9jU3wtYxpIyQOPW3kFvBWZI9k/zAtw6hQYUdDTk
         FUVP1oQljZD44rPYWH7qn9vPLfrKVdcbxMym31VjICLSN2qj5VSLbAydjRWfKVXE1qfV
         yYAA==
X-Gm-Message-State: AOJu0YywpDuEHtoDLFHSeHcgRJFVyUNe0afcIrJIHRTxBDLvmb/VSvph
	Ta/S6b1qqLbKACDTUCvnD6BIYBQtP3g=
X-Google-Smtp-Source: AGHT+IHoq63cqkqlsDbxNCWJh2o1j6j0D7WcEQ8bDluF2wQdTjT7b7Q8Cnnz84hS2WE6xzlq72mmQQ==
X-Received: by 2002:a05:600c:4e8f:b0:40d:5f55:5e9 with SMTP id f15-20020a05600c4e8f00b0040d5f5505e9mr928103wmq.92.1703739330130;
        Wed, 27 Dec 2023 20:55:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id hn34-20020a05600ca3a200b0040d1bd0e716sm25765430wmb.9.2023.12.27.20.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 20:55:29 -0800 (PST)
Message-ID: <eac2211332f754c5f4127a58aafb9882bfe939e8.1703739324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1623.v3.git.1703739324.gitgitgadget@gmail.com>
References: <pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
	<pull.1623.v3.git.1703739324.gitgitgadget@gmail.com>
From: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Dec 2023 04:55:19 +0000
Subject: [PATCH v3 4/9] SubmittingPatches: discourage new trailers
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
    Dragan Simic <dsimic@manjaro.org>,
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

