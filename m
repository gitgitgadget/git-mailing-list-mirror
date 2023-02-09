Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD79C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 15:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjBIPpg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 10:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjBIPpd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 10:45:33 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CAC60E7E
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 07:44:59 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id b9so814958ila.0
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 07:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhNQlDKUjRXmK5rcweYMF5p62ggFuazYB7/5iE0iZ7Q=;
        b=BJkEH5n5k790MtGUzEKmdhJ8XRFrtihp6GX1Pu2yQ6wDmHFeD2mD0iRh/zmyjbzYrk
         cW/61Na6EoJcz4UTFafneRrf9TBBfd/F4RsGqPmAONAjPMzTTaBviZ9mbiraIeBN7+vY
         pGAUiZrTYDkU9tT7feohQm5HdMnFa+3Ciex4lBismb61yJnCrxed9d4jnGn8WehCNeSK
         SJOYCaazCuhliXH5lQgVStrlCmQoa2um7hiA7TEGiLVVYeSSrBcdlTGPXYAZckcDFeMf
         bNmbgaD8RBoMTptBc7IEiu37EgareMwnBWaJQwQeMLzTYQ5anpOyy0RZA6W0fweI1nYx
         wKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhNQlDKUjRXmK5rcweYMF5p62ggFuazYB7/5iE0iZ7Q=;
        b=hlAIP5prj0YkJj6MXduTFwI80ENraTrmuWLgz8TuTNks6/gkJn83yD2HSqQNHbNvzM
         08VYIfV96PpeoYoxlQcQ2OIkQt+16+Z9o+dXQmOO4/ly1TaidGj1MmlqMTYcE5gAkQOJ
         VX0mLDq4h1Dx9186GR0lhDyUYsSSt917dMvdnNaSdvQOzBw/aVAJ5lDcv1AW484ZCHqy
         gmF2PRYLbgcnMR/IDng3KVu5pLO/qZ8DfaPj/TEuXLZR2kxxzW8NGFD8Kj45XKwCoQaf
         rfM+Arpy9pRVaPn/6k83wn/i0gkCbJlWpP70tSBVlZga5U1kKwoKfDrvjGlOpy02RZT1
         FxWA==
X-Gm-Message-State: AO0yUKWdQwDJxW4lzAfUesZre0tlnO2WIeucz7SN27bcbLT/CzQrSjKk
        WYaicJPT92FWN4Cc239sy7cN2Tv0zCnIvw==
X-Google-Smtp-Source: AK7set994EbY7HFzmbHjFHZr7+D+ydrZ9yOrJC2614MaLILBWtXqAIF6rJu079W3S+JF/uGUx8Z/wA==
X-Received: by 2002:a92:7b04:0:b0:313:d7fc:4c09 with SMTP id w4-20020a927b04000000b00313d7fc4c09mr9156130ilc.18.1675957488290;
        Thu, 09 Feb 2023 07:44:48 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id a1-20020a92d581000000b0030c0dce44b1sm563570iln.15.2023.02.09.07.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 07:44:47 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [PATCH v5 2/3] t4113: indent with tab
Date:   Thu,  9 Feb 2023 10:44:16 -0500
Message-Id: <20230209154417.10763-3-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230209154417.10763-1-cheskaqiqi@gmail.com>
References: <20230206211823.8651-1-cheskaqiqi@gmail.com>
 <20230209154417.10763-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As Documentation/CodingGuidelines says, the shell scripts
are to use tabs for indentation, but this script
uses 4-column indent with space. Fix it in use tabs for indentation.

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t4113-apply-ending.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
index 41526ca805..a470c9ce7b 100755
--- a/t/t4113-apply-ending.sh
+++ b/t/t4113-apply-ending.sh
@@ -25,12 +25,12 @@ echo 'b' >>file
 echo 'c' >>file
 
 test_expect_success setup '
-    git update-index --add file
+	git update-index --add file
 '
 # test
 
 test_expect_success 'apply at the end' '
-    test_must_fail git apply --index test-patch
+	test_must_fail git apply --index test-patch
 '
 cat >test-patch <<\EOF
 diff a/file b/file
-- 
2.39.0

