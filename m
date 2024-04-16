Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B978013AA37
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 23:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713308529; cv=none; b=VUo6GSUUBjEwgLp/Ej3D//i4WS0VWQ/anASLibTwzj9C9yxG5FiYzD+6BuIy9OCAOf9/tBxLwZDRCNmSjqmPHzGS7mg4e+8PxvtWRe52PzPBctEe4S5IE9agiFj2oKUzMLzs1PBRTDN95G6mNqLdHH5+3GmXHHnl67wAOYGaaUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713308529; c=relaxed/simple;
	bh=3IfJr66Hv3JkMkSP2jtPdUbNbjWoEYtSQmob50dYzI0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HskirZAGekxOM7SU96ipq/fnhRtYyddx/SXqVr+b8OstF/i6pY3OCl7I74haSi+dxS0+27jCD+4N7Te3rZt/puoSt9SVFQ2k/4SNufw9vQwMW4DaEVt/e+kIjMPjLK5OBABjsApw2sqjTuJLleCIg9WS9mCSSHHkzFvbL2urN5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AW/TGU5j; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AW/TGU5j"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-417e327773cso1197215e9.1
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 16:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713308526; x=1713913326; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dotXuEnx+0BKqnk1B9bF1hsL60NvxpDJtQhf2HNdqdE=;
        b=AW/TGU5jH9W4Kagct4FQngU51IZMBjADzysJ98J3JhJVUFf0g5bVtagqD1JZ1pxkcP
         909obY3UPSRvaMownp7NsMNekSXLggq/G9ZaQNMtInclMK8xr8gxFZDASw7TAD5Q2OIe
         137O44ZXP/5eb1MIB45VVuKGQF4LUAEb2fQEoepjL0FEnQtjBz/q5tMSocr67m4wrVLH
         TOo5zvDJVpCnHCQ6MHymdUQfsUzH02SbznCx1IAdI2WDIFn7lnXum9AAf6H78kta71b6
         Jf3PK/lDGUD4Mi0wfMFAOaT1Uxe6xIMenN0Cz+cDVbVJBqLwV1GBUih6P2duMDVMH48d
         PhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713308526; x=1713913326;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dotXuEnx+0BKqnk1B9bF1hsL60NvxpDJtQhf2HNdqdE=;
        b=d3o+BAkJPZyeA/pWtq6vPxM/lMRoC2pCqa9cBMqUJWAJNBr+9bop4U7Sytx4pLt2fY
         eWsCPGcEKhzAzIGFk7W74i0P8D1bYAOpzfCl2J9aPVfBKno5DgWMZk1c5nGHwvHnpcU0
         TGyuZsOzmXjdR1XgsjenMgq4v5HXFPuYhyWMsIE9Mxi0dpSXM/Dw28KQGXm9Jzp/a26L
         r4AnGXLaGT0rvoNusC8NZbJFijHsaESXCQvqZe6Da6ImA/jfRmrxu807nuaawOd+/3x+
         wru82N/0a1woXVHSk1hTRjou4GLX41WfFXJLlVbrxmLRHrPfu1+YSrOxMMaAg6iMt5J3
         XV0A==
X-Gm-Message-State: AOJu0YwOBCOpj9g1BTYgAI/EnxiRpsoSK//NXNBJzmQ/8+8Il9uXhltj
	dd+zssr9Zix7USIsNZ16jdG7g3QtZKTmzabp/Rqja3o4yMp2X1UQDjw1HQ==
X-Google-Smtp-Source: AGHT+IG9TDB/YFnzsogIRYcdgwBYr2z+3eVKTZe5CPAgADpef0ygertWMWehEA+ZNpp79XVMPw8lKA==
X-Received: by 2002:a05:600c:56d4:b0:418:2981:c70f with SMTP id ju20-20020a05600c56d400b004182981c70fmr537429wmb.19.1713308525809;
        Tue, 16 Apr 2024 16:02:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n26-20020a05600c3b9a00b00418a2ce884bsm402602wms.32.2024.04.16.16.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:02:04 -0700 (PDT)
Message-Id: <8f44343c482dd2c343b6c449479c5c35dcdbbc50.1713308518.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
References: <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
	<pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Apr 2024 23:01:54 +0000
Subject: [PATCH v5 5/8] SubmittingPatches: discuss reviewers first
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Kipras Melnikovas <kipras@kipras.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

No matter how well someone configures their email tooling, understanding
who to send the patches to is something that must always be considered.
So discuss it first instead of at the end.

In the following commit we will clean up the (now redundant) discussion
about sending security patches to the Git Security mailing list.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 68 +++++++++++++++++----------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index b684bdd03a1..a110f94db4f 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -397,6 +397,41 @@ letter.
 [[send-patches]]
 === Sending your patches.
 
+==== Choosing your reviewers
+
+:security-ml-ref: footnoteref:[security-ml]
+
+As mentioned at the beginning of the section, patches that may be
+security relevant should not be submitted to the public mailing list
+mentioned below, but should instead be sent privately to the Git
+Security mailing list{security-ml-ref}.
+
+:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are +
+not part of the core `git` binary and must be called directly. Clone the Git +
+codebase and run `contrib/contacts/git-contacts` (you must have Perl installed +
+in your system).]
+
+Send your patch with "To:" set to the mailing list, with "cc:" listing
+people who are involved in the area you are touching (the `git-contacts`
+script in `contrib/contacts/`{contrib-scripts} can help to
+identify them), to solicit comments and reviews.  Also, when you made
+trial merges of your topic to `next` and `seen`, you may have noticed
+work by others conflicting with your changes.  There is a good possibility
+that these people may know the area you are touching well.
+
+:current-maintainer: footnote:[The current maintainer: gitster@pobox.com]
+:git-ml: footnote:[The mailing list: git@vger.kernel.org]
+
+After the list reached a consensus that it is a good idea to apply the
+patch, re-send it with "To:" set to the maintainer{current-maintainer}
+and "cc:" the list{git-ml} for inclusion.  This is especially relevant
+when the maintainer did not heavily participate in the discussion and
+instead left the review to trusted others.
+
+Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
+`Tested-by:` lines as necessary to credit people who helped your
+patch, and "cc:" them when sending such a final version for inclusion.
+
 :security-ml: footnoteref:[security-ml,The Git Security mailing list: git-security@googlegroups.com]
 
 Before sending any patches, please note that patches that may be
@@ -490,39 +525,6 @@ patch, format it as "multipart/signed", not a text/plain message
 that starts with `-----BEGIN PGP SIGNED MESSAGE-----`.  That is
 not a text/plain, it's something else.
 
-:security-ml-ref: footnoteref:[security-ml]
-
-As mentioned at the beginning of the section, patches that may be
-security relevant should not be submitted to the public mailing list
-mentioned below, but should instead be sent privately to the Git
-Security mailing list{security-ml-ref}.
-
-:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are +
-not part of the core `git` binary and must be called directly. Clone the Git +
-codebase and run `contrib/contacts/git-contacts` (you must have Perl installed +
-in your system).]
-
-Send your patch with "To:" set to the mailing list, with "cc:" listing
-people who are involved in the area you are touching (the `git-contacts`
-script in `contrib/contacts/`{contrib-scripts} can help to
-identify them), to solicit comments and reviews.  Also, when you made
-trial merges of your topic to `next` and `seen`, you may have noticed
-work by others conflicting with your changes.  There is a good possibility
-that these people may know the area you are touching well.
-
-:current-maintainer: footnote:[The current maintainer: gitster@pobox.com]
-:git-ml: footnote:[The mailing list: git@vger.kernel.org]
-
-After the list reached a consensus that it is a good idea to apply the
-patch, re-send it with "To:" set to the maintainer{current-maintainer}
-and "cc:" the list{git-ml} for inclusion.  This is especially relevant
-when the maintainer did not heavily participate in the discussion and
-instead left the review to trusted others.
-
-Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
-`Tested-by:` lines as necessary to credit people who helped your
-patch, and "cc:" them when sending such a final version for inclusion.
-
 == Subsystems with dedicated maintainers
 
 Some parts of the system have dedicated maintainers with their own
-- 
gitgitgadget

