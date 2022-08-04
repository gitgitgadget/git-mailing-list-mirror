Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929EEC19F29
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 01:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238989AbiHDBqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 21:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbiHDBqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 21:46:09 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147C55F9AB
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 18:46:05 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso1781525wma.2
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 18:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RhPe/2YGJzGbswB35npBDWGmS6OQlK0k/r1JD67kQvU=;
        b=Le2d42CAF/+OkhWoIcw6QibQvTRAobxM+f3XphRZIjulMSDNMxPgWaoQs0Gn1Bm3uw
         KirJeev7tzQOxTeXZx3ZNFCP+zzejb4nkRN6W5sP87Tm7qqfWgKXIK8AXbyhXoTrFY6S
         vtp+UzWMXxLTxcXRGagioXSAUpKgBAagYLoxkg2QG1eTcYftYzst7TGl6oKTp2f22JwA
         8UAg1RSHTM1x4fkNBtlMrBjmSXcvqYfaFKs8f8EsEWnI9DS5awX5fsG35T+42gb7tqvn
         Ds/Z/k4/Jq063wmqTkcNIhAj0PrUcw/YUqLY6FQ5m31V5t5qStglWacicsEYD8iS9Xqw
         AssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RhPe/2YGJzGbswB35npBDWGmS6OQlK0k/r1JD67kQvU=;
        b=b2zFY8KAzr3Okgn8V++3vILLLtfDwtPn3RLPaIkoIZagwlNgItzvRD7uAmI2/tsKVr
         6KfQuz1wm0nZxJtdCcmy5G6dt1J1IXwXVLVQ+8Zot9/gbdzGZQPWxSlZMgPeT9iq8UmL
         G1qE7ct7j/hrk9QUI5Q9ZQ+J2Up9L2OII5SjDXFO4GVlsh34eRv08UqqGugYxZDvV4dg
         AGYtgh9zoIM9gyD1eSlkdKlF7xz7b7kFfrpp8lxtnaBPbEE8CroIHSyNyAqlu6fH54Hv
         itOOagwoe4gfhIZ4rvG3Zu4TX24Dnm8daRv7Qoiz9aADclorrYKR/ISNkTtJ5DL/QAdo
         dv1g==
X-Gm-Message-State: ACgBeo0Ulvh59Hu7OtkCNd7hEAtl+nmobXXe+uXURY6RQ9oUMjp2IFim
        5+LaCx+Rsb9yS69+SYeyWad2AlWfk9w=
X-Google-Smtp-Source: AA6agR70vwt7+Zl+JK9+UoNJ6fpONp38nUvrIEoHn9qbdzZuPb0937eIp3d75M3wNV3unuv73hOtCQ==
X-Received: by 2002:a05:600c:1f16:b0:3a3:214c:a85e with SMTP id bd22-20020a05600c1f1600b003a3214ca85emr4464472wmb.95.1659577563358;
        Wed, 03 Aug 2022 18:46:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c320800b003a2d6f26babsm4105465wmp.3.2022.08.03.18.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 18:46:02 -0700 (PDT)
Message-Id: <14925c3feede27315a22645fc97e4546c1e6094e.1659577543.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
        <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Aug 2022 01:45:43 +0000
Subject: [PATCH v2 10/10] scalar: update technical doc roadmap
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update the Scalar roadmap to reflect the completion of generalizing 'scalar
diagnose' into 'git diagnose' and 'git bugreport --diagnose'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/technical/scalar.txt | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/scalar.txt b/Documentation/technical/scalar.txt
index 08bc09c225a..f6353375f08 100644
--- a/Documentation/technical/scalar.txt
+++ b/Documentation/technical/scalar.txt
@@ -84,6 +84,9 @@ series have been accepted:
 
 - `scalar-diagnose`: The `scalar` command is taught the `diagnose` subcommand.
 
+- `scalar-generalize-diagnose`: Move the functionality of `scalar diagnose`
+  into `git diagnose` and `git bugreport --diagnose`.
+
 Roughly speaking (and subject to change), the following series are needed to
 "finish" this initial version of Scalar:
 
@@ -91,12 +94,6 @@ Roughly speaking (and subject to change), the following series are needed to
   and implement `scalar help`. At the end of this series, Scalar should be
   feature-complete from the perspective of a user.
 
-- Generalize features not specific to Scalar: In the spirit of making Scalar
-  configure only what is needed for large repo performance, move common
-  utilities into other parts of Git. Some of this will be internal-only, but one
-  major change will be generalizing `scalar diagnose` for use with any Git
-  repository.
-
 - Move Scalar to toplevel: Move Scalar out of `contrib/` and into the root of
   `git`, including updates to build and install it with the rest of Git. This
   change will incorporate Scalar into the Git CI and test framework, as well as
-- 
gitgitgadget
