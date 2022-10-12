Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833E2C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 19:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiJLTnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 15:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJLTnk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 15:43:40 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A573792CC
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 12:43:38 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u10so27729515wrq.2
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 12:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygUrA/ZQ0LND0Po0ST8vzEkeu8CQCN00tfEgol0rL/c=;
        b=XvDuq/elcGi3tgBSy5HB+hIeJheOkWMc5TxcYkchIo1iCzpwIWvLpqcuS4BnA5aWYG
         lSbsu9dL9+B8rtPs6GYKy3k+1ZSrNIoZAwfXZqEI5xRMq/YrllOKTKZTQC7myF6mcm+R
         iTEEHymWokw5pfZQyp2UwYMO7IcxNZzYEZG67i0psF5ec7r/oIKNxLQtb9DSeNeqsb9N
         EWOkHqmtFU0MFiZHH/hT6BzDzeSlNxDtMVUJk3Im3+m1HHkkWTho3aueYp0qUGKynzBe
         2emI0fFJfnWJgG8U8Ag77ORkKgsZRsEYp+OAYtwDbhbHOygq+S0kxCfiuVlD2e8bga7b
         OQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygUrA/ZQ0LND0Po0ST8vzEkeu8CQCN00tfEgol0rL/c=;
        b=Svy2pUxySHroSABasIOQqj5D96mPpghta+d69G6aj7egdKhuC15ZBGE6VGl87UMjJ6
         BAW9UbZ6IBYy3k4UKQH09GMGFV1LwLvEYUu+7FVlw5p7BbX4aBLXfRIdowz4wGdVMNtq
         9xl9NuyhWydsHfLcFo0DEHx6nkLzzWSziRLN3yIfvlO/yiSLw88USeiOhHbaPbafNLFD
         c/sKmtJtzkWCmLHt/xPFZXJVdMF5raCjufiRqiLDe9F/JSSMEEWXC2d6HNz7y+vum11D
         l90UxaxyQv900hFvNf/34lX+/FyiCSBfQrMTy1zbZz/L8AzSn5Hp6GIHjk652iFCrRDk
         5iRw==
X-Gm-Message-State: ACrzQf0PcO1w1Z25fG+yJSLBn3ArxEYXLSUz0Ptee1jbholeZBc1DuRQ
        P304iOjElA8K1OzSbn4PFoVtfVdZ0K4=
X-Google-Smtp-Source: AMsMyM4e3bbRMv48nZaCdlE8VS/YhNno8rbJEhpw0hDXC/s38i+6MsTbwcbvOmdcIuSoTg7wbukeOA==
X-Received: by 2002:adf:f407:0:b0:22e:5848:f6b with SMTP id g7-20020adff407000000b0022e58480f6bmr18777231wro.46.1665603816836;
        Wed, 12 Oct 2022 12:43:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j12-20020a05600c190c00b003a601a1c2f7sm2761468wmq.19.2022.10.12.12.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 12:43:36 -0700 (PDT)
Message-Id: <8c0f40aed7e7f7044b9233053ce3ab258f9b634f.1665603814.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1360.git.git.1665603814.gitgitgadget@gmail.com>
References: <pull.1360.git.git.1665603814.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 19:43:33 +0000
Subject: [PATCH 1/2] t0033, t0035: test for included config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Protected config should consider [include]-s. Add failing tests that
describe the behavior we want; they will pass in the next commit.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 t/t0033-safe-directory.sh       | 9 +++++++++
 t/t0035-safe-bare-repository.sh | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index aecb308cf66..720d6cdd60b 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -71,4 +71,13 @@ test_expect_success 'safe.directory=*, but is reset' '
 	expect_rejected_dir
 '
 
+test_expect_failure 'safe.directory in included file' '
+	cat >gitconfig-include <<-EOF &&
+	[safe]
+		directory = "$(pwd)"
+	EOF
+	git config --global --add include.path "$(pwd)/gitconfig-include" &&
+	git status
+'
+
 test_done
diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-repository.sh
index ecbdc8238db..aa6a6a8c3fd 100755
--- a/t/t0035-safe-bare-repository.sh
+++ b/t/t0035-safe-bare-repository.sh
@@ -51,4 +51,13 @@ test_expect_success 'safe.bareRepository on the command line' '
 		-c safe.bareRepository=all
 '
 
+test_expect_failure 'safe.bareRepository in included file' '
+	cat >gitconfig-include <<-EOF &&
+	[safe]
+		bareRepository = explicit
+	EOF
+	git config --global --add include.path "$(pwd)/gitconfig-include" &&
+	expect_rejected -C outer-repo/bare-repo
+'
+
 test_done
-- 
gitgitgadget

