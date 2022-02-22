Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30390C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 11:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiBVLoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 06:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiBVLoI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 06:44:08 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E4D139CEF
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 03:43:43 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id f8so16792726pgc.8
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 03:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jqNptx1bkXVEo1T0zqqKdobwXn0DoiSCVLI5FpVYzpU=;
        b=gWs0hGRO7AiOwmoFKOHy2faCNoQqhTc1fohUclg9jA7hKWGVq1Z2jH1BvsJsd0b+EG
         pZKDdBnkxyBSJDWeswlUUQXdkb+mv6oPYdnGqeef0fCISNuRCtPnrQBl5df3VsShFk6Z
         2mtBF3v9XLo1++7yj+nZUvz+ORKJ6R3InFy6yPQx3aCWqgz/cqV6ss68RTzPf7c+3ySm
         S6hedVm4aQ5qSOc5H+NKcrEdlHF/h2Rb8M+e+qguwO8OdrH0/ncZYnoDqFlRCknWLCjU
         iGVsydww0GImbNdqttVvGTbgm8uzekaIhu3tGldW4EaHxe9oeGwoiKHJWgQ8mIR6sIVn
         H1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jqNptx1bkXVEo1T0zqqKdobwXn0DoiSCVLI5FpVYzpU=;
        b=t7NEnTwH19N/AC7nFzZqaPaAoanWIrY3T9MIpF+TH0HNT+50mvwVCKDzoxDH5D1GKC
         IQyFXNwyXcQ7GYhlGX+gt7vPwJbmPMyRUk7KSB9icdAIP/BqT76RXNUVhR+uBNhQ9v3g
         Z1qkD2yOCMl5thVBXu8II2j6PcKQYV+Dcl/iNEZ2WDcNglXfe97PeUipFdib/M4WCM6k
         qZZ8ntDtkdG1aoMdlTHaClN5pKLLhlbAeDDbBAE8V0KyD9D28IW7HcyAPsyYJjX/U+nr
         KrVciW0gxh5QlA1Sb7rKaafu0/JX39Z/NFgLj4LJpcTeT7LXnqN49ehDaM2/3gL85jzA
         B2YA==
X-Gm-Message-State: AOAM533ACb+fwJY6XI9+dffWryaXrwMWz6QrC8ZHQ8bMnPpPujUUOfsy
        P1qsHO/6oMLYTAgp3D9q2c0mq7Pyilz+VgoAn3s=
X-Google-Smtp-Source: ABdhPJzL89qBGDuL7rgH6muynY+CodeDnuNuZDQYg3hgt6uVLnUl8r8qG/ZHo+Dq/sxLebFpoguo/Q==
X-Received: by 2002:a05:6a00:9a2:b0:4e1:a01d:cc4d with SMTP id u34-20020a056a0009a200b004e1a01dcc4dmr24392454pfg.40.1645530222932;
        Tue, 22 Feb 2022 03:43:42 -0800 (PST)
Received: from DESKTOP-MEF584H.localdomain ([103.108.4.196])
        by smtp.gmail.com with ESMTPSA id p14sm12372430pgs.46.2022.02.22.03.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:43:42 -0800 (PST)
From:   Shubham Mishra <shivam828787@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, Shubham Mishra <shivam828787@gmail.com>
Subject: [PATCH 2/2] t0003: remove pipes
Date:   Tue, 22 Feb 2022 17:13:13 +0530
Message-Id: <20220222114313.14921-3-shivam828787@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222114313.14921-1-shivam828787@gmail.com>
References: <20220222114313.14921-1-shivam828787@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

pipes doesn't care about error codes and ignore them thus we should not use them in tests.
As an easy alternative, I am using a tmp file to write from git command so we can test the exit code.

Signed-off-by: Shubham Mishra <shivam828787@gmail.com>
---
 t/t0003-attributes.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index b9ed612af1..51f9f6503c 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -205,15 +205,15 @@ test_expect_success 'attribute test: read paths from stdin' '
 test_expect_success 'attribute test: --all option' '
 	grep -v unspecified <expect-all | sort >specified-all &&
 	sed -e "s/:.*//" <expect-all | uniq >stdin-all &&
-	git check-attr --stdin --all <stdin-all | sort >actual &&
+	git check-attr --stdin --all <stdin-all >tmp && sort tmp >actual &&
 	test_cmp specified-all actual
 '
 
 test_expect_success 'attribute test: --cached option' '
-	git check-attr --cached --stdin --all <stdin-all | sort >actual &&
+	git check-attr --cached --stdin --all <stdin-all >tmp && sort tmp >actual &&
 	test_must_be_empty actual &&
 	git add .gitattributes a/.gitattributes a/b/.gitattributes &&
-	git check-attr --cached --stdin --all <stdin-all | sort >actual &&
+	git check-attr --cached --stdin --all <stdin-all >tmp && sort tmp >actual &&
 	test_cmp specified-all actual
 '
 
-- 
2.25.1

