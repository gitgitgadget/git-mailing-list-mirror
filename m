Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57370ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 16:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiHaQDH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiHaQCn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 12:02:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290C5B6D0B
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:02:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n17so18889076wrm.4
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=+sA02ZlHH203KZ20PCvybxVgbV54HnngBsC+EL6Obxw=;
        b=PFaoU0Wqy4dcniH/IS+H7geKYZuQTOoFoXVxmOP6iziHeKEUWJhQYlXBtb9XKFstxZ
         btCasodI7Tk44/S2TvLuoWTXC/nj/Od5AWOE/CD/nvf6LXXy1fEqpWAuh5vxWjDZh4TK
         KEvk/7bIV4VzbaYxmGcK58y92eLncZQZzEF8k2Qa0boXo7bR+xDc613dA3H0Zdj4uRUA
         FMgIqTX6IC164jWrApnP3oZ9Zo0GV6K41dVoXp7UYO7AZcF4Uez8IcDklwdOxFb9Nv+s
         8sixvcscs2blqctLE/kS661kudjMYouD2jfZ/piB+gQZYDqYllLn2l/6OGqMJujYUhv/
         95kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=+sA02ZlHH203KZ20PCvybxVgbV54HnngBsC+EL6Obxw=;
        b=1lOW/gGxnKMV2LSk0vDlPsHG8D51jDxVqQH8FZgXmMpGJgr95OCXAz5zLVX02XRWCi
         8S4mc1vt0+QfdiotqVX9864Ad5OHm1jAY9qQCCCQLrwL7d9ZjLkVf53Y05yBZ63p6+O4
         w4oHFd5yXCDk1RMTaCAcwMOGF2tLmJT00mnc//cRwoms1ojp5eV8sKAuEF0RV3ahy9Pe
         p84LGKEzavdbsoZxnhu4cF8nMPh087CL3MECerTGDUlGYCGhKTku+UIf5QZkFezC/DOT
         f4AYSnJ68IA7aqNvmD/7r4s3iJeRBMLoFrx2VYCy9+Xaf40LjK4dQgnYRcbmLSp3pUqY
         UhBQ==
X-Gm-Message-State: ACgBeo04NnKUati2gVaNH344RqgnAVmZCpwcJstQewaAhHDBmO4JbJwJ
        ybvaw+nzrbRRMHa5p6F0CkUTnmeC7pY=
X-Google-Smtp-Source: AA6agR6VxmLiNnNqeOG12HbfZmhUg8GjMju/UTidC69ZOSuQURH06ccGpXQxXc+ULAFSEs3A2ej3Lw==
X-Received: by 2002:a05:6000:381:b0:221:7540:b1ee with SMTP id u1-20020a056000038100b002217540b1eemr11780538wrf.307.1661961753401;
        Wed, 31 Aug 2022 09:02:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c284a00b003a531c7aa66sm2628554wmb.1.2022.08.31.09.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:02:31 -0700 (PDT)
Message-Id: <fcf73e775746b102a4d5196c5ebbb06467e08cf6.1661961746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 16:02:18 +0000
Subject: [PATCH 1/8] scalar: fix command documentation section header
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        gitster@pobox.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Rename the last section header in 'contrib/scalar/scalar.txt' from "Scalar"
to "GIT". The linting rules of the 'documentation' CI build enforce the
existence of a "GIT" section in command documentation. Although 'scalar.txt'
is not yet checked, it will be in a future patch.

Here, changing the header name is more appropriate than making a
Scalar-specific exception to the linting rule. The existing "Scalar" section
contains only a link back to the main Git documentation, essentially the
same as the "GIT" section in builtin documentation. Changing the section
name further clarifies the Scalar-Git association and maintains consistency
with the rest of Git.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index 1a12dc45077..505a1cea0fd 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -161,6 +161,6 @@ SEE ALSO
 --------
 linkgit:git-clone[1], linkgit:git-maintenance[1].
 
-Scalar
+GIT
 ---
 Associated with the linkgit:git[1] suite
-- 
gitgitgadget

