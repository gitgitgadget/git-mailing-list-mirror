Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4251BECAAD4
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiH3Jd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiH3Jcw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:52 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C83FDCFF9
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:36 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11eb44f520dso11116228fac.10
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=LqSQCnVeE2gvRPhlpaUtKCEbH9Zrzc3pPAdhPF+hAvI=;
        b=brNFrzrvM5B2T71Hc9LAUpTQWVUxtQppVdcOdLcaxw9Mqe5ACK0tb+IeCPvRi8fFfi
         JcvADGd9yywjiZk0DyMriRd9TWz3LWApzO+Qw5k6CUAqqT/AvVy+aD34qb6evQ7Em31U
         a2YWXicAPcV2LPmL5kH+EwjM5p/uxD4iJgIwHE6FjLcRl7WIanm0AafYOG6WmHl6+e8H
         AYF7vaSvJMdfrwZqNQs9svLog8reyDeFH48tUfwdtiVaPTD5SEOnIlvzT073rf1Z69bE
         jC/+zQ9svqUeN1A2/mfAlbvNDoTu/z7a44fDYuVG33lUN4QUqm+jgeaNI/D6DKAVT2o9
         KHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=LqSQCnVeE2gvRPhlpaUtKCEbH9Zrzc3pPAdhPF+hAvI=;
        b=DrFqA+Fo5uynq1B7RvDsd3d3420xk7L0Hb1hKXmRfnJ+9FIITd70jbLuYzjg7iyM2M
         cAbWAOv1tYtDjNM+EDdW6axHRGjORaAIR0yoW6uVwC1sjB5bhZGK30UPAiTyIY3YQZLu
         /K4KcNrIkMh1t/AgH7Y+lcFJrKW9BtHBZokc20AbxSx6Fu8yLxEddt8yU1AUGzMihzkK
         1kSvmKcBtRpqIXfLdSoETBFSKSK5pBlN3p4SYaPW3jAwAyrgeGZwRf5ciw+mDUmJVeaJ
         DxjNT0rKnYtJ6TpIIFPKsTDmVJdbOFP1vgediePYxLWLntFN/z1S2/RM5YHzmIYlinqj
         U2JQ==
X-Gm-Message-State: ACgBeo0lvPujIcaoTvOJL5Oocr1XAOidUqCVNQ28fTK0xZUK11xVB/2w
        zvuBY7xgnfQqt8NOHnX+GFGhsjhOrCA=
X-Google-Smtp-Source: AA6agR7QCz8CEqMA12qlhYTt3VEXntovg1ojfTZa1MXR/04cBAsjIl/S7CfR0QbSApV3xRnbMlrYSw==
X-Received: by 2002:a05:6870:d7a5:b0:11d:a0b:f62b with SMTP id bd37-20020a056870d7a500b0011d0a0bf62bmr9245115oab.190.1661851956516;
        Tue, 30 Aug 2022 02:32:36 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id h7-20020a4abb87000000b00435a8024bc1sm6401965oop.4.2022.08.30.02.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:35 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 33/51] test: completion: add missing test
Date:   Tue, 30 Aug 2022 04:31:20 -0500
Message-Id: <20220830093138.1581538-34-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once the correct suffix in __git_complete_config_variable_name() is set,
we can add the test again.

Now it should work even in bash < 4.0.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh     | 7 +++++++
 t/t9904-zsh-completion.sh | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 91dfb618c1..e1e9c6e365 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2503,6 +2503,13 @@ test_expect_success 'git config - value' '
 	EOF
 '
 
+test_expect_success 'git config - direct completions' '
+	test_completion "git config branch.autoSetup" <<-\EOF
+	branch.autoSetupMerge Z
+	branch.autoSetupRebase Z
+	EOF
+'
+
 test_expect_success 'git -c - section' '
 	test_completion "git -c br" <<-\EOF
 	branch.Z
diff --git a/t/t9904-zsh-completion.sh b/t/t9904-zsh-completion.sh
index d0795ee014..42917833e8 100755
--- a/t/t9904-zsh-completion.sh
+++ b/t/t9904-zsh-completion.sh
@@ -1071,6 +1071,13 @@ test_expect_success 'git config - value' '
 	EOF
 '
 
+test_expect_success 'git config - direct completions' '
+	test_completion "git config branch.autoSetup" <<-\EOF
+	branch.autoSetupMerge Z
+	branch.autoSetupRebase Z
+	EOF
+'
+
 test_expect_success 'git -c - section' '
 	test_completion "git -c br" <<-\EOF
 	branch.Z
-- 
2.37.2.351.g9bf691b78c.dirty

