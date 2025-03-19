Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207A11F0988
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403793; cv=none; b=l/zYi9JouoUfdixdhpbRnZqF6+U1HXfj1sSDbiIKjGGwNiI1bg2zgp8ehhL1Pb+3BMvpq++DRWxohhjIg46bcGEFnbglXXA8mMX4z/0UGVp3CPgWjKa2HEKRmI4quBzHb0J8HL0OL9XArJznLn6T7oHA2lzT7qg44bc2xEymV1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403793; c=relaxed/simple;
	bh=Vj0uBa7WXh5jt0XfKEcfijla9nCZvF0KceQkoGgim7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4ieARD2x+wzEBDpL2SDj4V2wmLvONx+xXRl18pg5AOEwi535YNKdfXtRv1u3YcJJcI/zd1ekZXcjwgvhp0pcGkLlG5NDUtV5/0eePAQulwkx1ATkw31ljXxNitBqwgY2ii8IubSoiQ42lZff70KLVyjQTC19g1S3YFBWBU/zEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAHwQtJg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAHwQtJg"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223a7065ff8so59148355ad.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 10:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742403790; x=1743008590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvpayGurnGJck1Q4MoMZed0M77RIJAD4D6/4qgmq6vQ=;
        b=NAHwQtJghMLhsCA7n9HbYX62VSz/Z8hqjGX28vj+/I/xar7hu8sxQmdHhsamYWyu7+
         pcZve9INOWX6NZt7QDPQmLmciLtBrbkXw4N6avEKzvmmdgPSpZz6Du+1yBdA+PiWaIGj
         M3HviKgpEbkwdccvOYFjfOLDaYB8RekEaF1Q/j248qy4ZwTK+iECLjhbzK4aXZ/DEEIZ
         /XdkC0jeuWgejFtOEtRNn8henCwTvszbzFOCgPp8F4p9+VL4vtkByf2kH72h9BzV82Wa
         +yvYhWZHfV/DKssSOswQHE1UU30y+bSfpICtfsTx41HJCRwvXJ9wKtGySiEntUESO0BI
         KJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403790; x=1743008590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvpayGurnGJck1Q4MoMZed0M77RIJAD4D6/4qgmq6vQ=;
        b=fWE2H0GXfC0Kxrikgs4OK84DMC74YSlx/Un31sxR0x0gezsTKaAFxESreYS1ghOYhk
         drjp+9iNG8PuG6HIwzpti+BjsTanlFKfEc35bfugzb4tI9S0TUEKEQt/1IpdzHb5A0FP
         PFBvb23cx14YadoWrwi95F4sPl7zcAlZKhhrM+HycI3hlKHDKXl1zzB1+zmWCOeEhoCz
         sIFVRITuBDlbQVihMsvZn5zJSFSeXDh+KBluzjU/BSZKPAUpPoFmTivegDffp/0VuI/K
         prb5nPJfgoF06fRqfGCpoqC1akOQr9jSfGRCS7BBRI7aST4iu25MJv++CHxD3GwnyKkz
         SOJw==
X-Gm-Message-State: AOJu0YwFt6dh2HjT0432JVCG71kFa51VldSLlzf9LTOTHBaAkqDCIKSv
	y+BJGCY7Hnjq12qO21xceLbp1Tv0K+1NCf2akTvI5KmZSPyqCobhgVy1wO7J
X-Gm-Gg: ASbGncuSixKSHZH6hB599/A0JZlEw+F8fi/QlI2NvhmkHwBL89GokP8oN53mpQrNeWh
	7+cT6147/w/L/u/ePYjxfexzvqFK1dwyw2bHDMifU/LnFh6IT3IYH6DrQYmEO/yKso0PbkF+tM7
	zegk4mD7ds/egknDLZzlX5QcCMCyzYN69LeAEdGEJ4zlLX5zg6rnXaS9qd+p3nxuE76+ZKXArRZ
	6IXZuYi+/Lnm0h0gwg3tyiMGZVqb7nhdU/Yft+lOmAPD9T5BbIST8T2k8jiRO3dY/T9Yir9i/Hl
	CetPMCkc1/yJ/exR877hic3V8QiFl4TDIrMgdbj2B9eDsIZqlutPqs/WRydp2NJoLeyEpYOA9ux
	7qIs=
X-Google-Smtp-Source: AGHT+IEQ7x76/pegNneM6X/7g9tkjeSkt8ZWx9oRGcBOAsNMnLOi8lTqHPMXLAVpop/3H/Wfma/iKw==
X-Received: by 2002:a17:902:d2cf:b0:226:252e:b6ef with SMTP id d9443c01a7336-2264981d649mr56267095ad.7.1742403790038;
        Wed, 19 Mar 2025 10:03:10 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c005:b018:5841:514c:af52:5598])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a40a7sm117110335ad.59.2025.03.19.10.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:03:09 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	gitster@pobox.com,
	jayatheerthkulkarni2005@gmail.com
Subject: [GSOC][PATCH v2] Remove outdated mentoring mailing list reference
Date: Wed, 19 Mar 2025 22:32:44 +0530
Message-ID: <20250319170244.32912-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <xmqqa59j8gml.fsf@gitster.g>
References: <xmqqa59j8gml.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

and clarify tutorial prerequisites

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index afcf4b46c1..7b856be41e 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -13,6 +13,7 @@ the Git tree, sending it for review, and making changes based on comments.
 
 This tutorial assumes you're already fairly familiar with using Git to manage
 source code.  The Git workflow steps will largely remain unexplained.
+This tutorial also assumes you know/understand C programming.
 
 [[related-reading]]
 === Related Reading
@@ -40,13 +41,6 @@ the list by sending an email to <git+subscribe@vger.kernel.org>
 The https://lore.kernel.org/git[archive] of this mailing list is
 available to view in a browser.
 
-==== https://groups.google.com/forum/#!forum/git-mentoring[git-mentoring@googlegroups.com]
-
-This mailing list is targeted to new contributors and was created as a place to
-post questions and receive answers outside of the public eye of the main list.
-Veteran contributors who are especially interested in helping mentor newcomers
-are present on the list. In order to avoid search indexers, group membership is
-required to view messages; anyone can join and no approval is required.
 
 ==== https://web.libera.chat/#git-devel[#git-devel] on Libera Chat
 
-- 
2.48.1

