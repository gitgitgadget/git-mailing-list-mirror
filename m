Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8347C433FE
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A2560F6F
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242395AbhJ0OIC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 10:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242388AbhJ0OIA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 10:08:00 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553FBC061745
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 07:05:34 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k7so4322130wrd.13
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 07:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vF4oUcGtBQ7rtIPiKXj0P5iXeyH657HIik8HUHMPXB8=;
        b=NTkyxvV/pkE1sRB46yKsWbRMvMVpRGs3CZqCmKotzg3M/LNY46xvtBAeMkFIG+fL7Z
         GacXz3H4F6dr6EuQ4P6Qd1smrhybRYWIveFKLcilSDfurbcO2dpY3VPILia2QupIt3ts
         fMTT/d6Q8NAsVOYAOqqji2rMPUpQUZrWNOf6U5D6LEimdnD7cOVM6mZW1XvXkHMH1AKb
         AJF0SFuQQzIOOG03iByBaJhEKBZ9ugV0Q+aw2QH/1jgOCiTXfqJhN9YbY/QUsuMEBejc
         43gV3y0QqclH6txV2TsECBElXADUmzp53SK0X3uRCr19lukMXs68BBkoSAu6j/4mvZOF
         B9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vF4oUcGtBQ7rtIPiKXj0P5iXeyH657HIik8HUHMPXB8=;
        b=LZuJhQ4X1K41fFCUF+xuDslTMYrgLfimud9D/J1m7Fll8egStdXmgb83KfkwjSVR5E
         SnGKNCjgfPgjDIZQz26q9yevX4UZrxFPuyFsf6m35mCrKr4CgPlU7bQC6ZU9sry0ZkZf
         CV1vPKe79ltmmw7HWOEuCIbP7Htt2KzlgRgO+ZyRQCNxreMVoylgm/P2Nz9oDdfhKbit
         TqKCAXxcvIHLWpwMwbozFKK+yp2jKyQOLdMBvc9HZQblVwSnc9NZOpFTEDqyQr9sP4Jk
         5VBX27niSlYvoPwWLsTT01wmpBR/TrmW6ApNaS20iO7V1ZfxIidbm9QjtK4hZ9ogiKoa
         ArUw==
X-Gm-Message-State: AOAM5329+f6X096AazP4YCjAo8e7iO6d/UVP6PFI+blBkS+pgOWFumXl
        JTMcMCXQn5lG6UcYRR3tdJKspPApj1I=
X-Google-Smtp-Source: ABdhPJx4+Js1BVPWYWx/dSqNmsalxJjV7P4FjXEMTbQhDJJDO8lwHy+n/ifc9hZsJqCf3fOIm4fb1Q==
X-Received: by 2002:a5d:5287:: with SMTP id c7mr42236158wrv.236.1635343533014;
        Wed, 27 Oct 2021 07:05:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n68sm3477096wmn.13.2021.10.27.07.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 07:05:32 -0700 (PDT)
Message-Id: <6c95f11f110be63dafa10dde5067b6e7eeff1a53.1635343531.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1063.git.1635343531.gitgitgadget@gmail.com>
References: <pull.1063.git.1635343531.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 14:05:30 +0000
Subject: [PATCH 1/2] docs: fix places that break compliation in
 MyFirstObjectWalk
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Two errors in the example code caused compilation failures due to
a missing semi-colon as well as initialization with an empty struct.
This commit fixes that to make the MyFirstObjectWalk tutorial easier to
follow.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/MyFirstObjectWalk.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index 45eb84d8b48..bf0a7c1f766 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -65,7 +65,7 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 	const char * const walken_usage[] = {
 		N_("git walken"),
 		NULL,
-	}
+	};
 	struct option options[] = {
 		OPT_END()
 	};
@@ -697,7 +697,7 @@ First, we'll need to `#include "list-objects-filter-options.h"` and set up the
 ----
 static void walken_object_walk(struct rev_info *rev)
 {
-	struct list_objects_filter_options filter_options = {};
+	struct list_objects_filter_options filter_options = { 0 };
 
 	...
 ----
-- 
gitgitgadget

