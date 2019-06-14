Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D577F1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 06:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfFNGvB (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 02:51:01 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40977 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfFNGvA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 02:51:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id 107so1645905otj.8
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 23:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xn2wauLqNTwn2qvnoZH18yUruBwwT5C7lIkzl9ZKPj0=;
        b=uKMd+nrSRBIVXyPIWrxAi1qmE78151iRMNVWhDYWrAbUaJ0AhjdH8EDdblXoNpnKLo
         NjdW1Yq+vGjPSg3fRJ86SkKQFryc8S8dKZZEIvDQtyr3mUTj2axalQ0bUTm82K8sA2p0
         Ik45iFUnhnxWADq9gNEJ3S4xaH5JQkf+xNQFev7TBX6Ep38d+dD6qBC96Qtfxkv+ueSF
         uG/wI8a9QEIV8PsmkmBcDlDuuyuSnB1+LmWnuSvbwOLZPkChL0ETkBtqoKT4gAsApiDs
         dJwIHs9o5u7EJrnj7Y1ajpDCKoEvttek8LUg3GCszY3jEgirxGVqw+KYxIT9XH5a0CfX
         Dl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xn2wauLqNTwn2qvnoZH18yUruBwwT5C7lIkzl9ZKPj0=;
        b=cZgY22r6KZu5sB2sEbb/PTvDo75jBndmeXd92v59lJvSdrVoXLgWD/MqF5VJUaFEtx
         W4TBoHwwEMk5/ewqazpRXyedAKQ9nrdza1H/7MKNuuIx3eJdaZo/aJlyfKZJUE2n25dS
         TbtOMCj/7uqTYL6sGzmNLur17k5fgUoTmuuqcrlviJWTbh5X9LP6YUzSBBj6se+YHqId
         3aqplbJ+hDnPxEksPf4l88N/ufBZNsuCbiL7pu5L68QQeknFTF4pv6mHU2m6KCgvQvJ3
         LtpDGXExIXaoJbrcLu0ygV0kY6pVOutCLzs91Dd6AGcizCHK7oI4iu1whXg+FAER3dYe
         F7wQ==
X-Gm-Message-State: APjAAAUXirqTld4KJ4F3Onxj1puZJEE+R24kSqBLYpGbsMBd0VwAKcdL
        7xZQNUUOHdq49QpObKzCd7JB4+n0Vow=
X-Google-Smtp-Source: APXvYqxiAhUlVGcsFOCmBH4WBkByM6TCiTK7wiUwcVrN9+FI7whYVKAaTEC/UK7d46JmJ+YgjX0Omg==
X-Received: by 2002:a9d:70da:: with SMTP id w26mr2162763otj.270.1560495059986;
        Thu, 13 Jun 2019 23:50:59 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id e78sm839055oib.50.2019.06.13.23.50.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 23:50:59 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/5] completion: prompt: fix color for Zsh
Date:   Fri, 14 Jun 2019 01:50:51 -0500
Message-Id: <20190614065051.17774-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.22.0.rc2.dirty
In-Reply-To: <20190614065051.17774-1-felipe.contreras@gmail.com>
References: <20190614065051.17774-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need PROMPT_COMMAND in Zsh; we are already using %F{color} %f,
which in turn use %{ and %}, which are the equivalent of Bash's
\[ and \].

We can use as many colors as we want and output directly into PS1
(or RPS1) without the risk of buffer wrapping issues.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-prompt.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 983e419d2b..b57a9c96cb 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -88,7 +88,7 @@
 # If you would like a colored hint about the current dirty state, set
 # GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
 # the colored output of "git status -sb" and are available only when
-# using __git_ps1 for PROMPT_COMMAND or precmd.
+# using __git_ps1 for PROMPT_COMMAND in Bash, but always available in Zsh.
 #
 # If you would like __git_ps1 to do nothing in the case when the current
 # directory is set up to be ignored by git, then set
@@ -506,9 +506,11 @@ __git_ps1 ()
 
 	local z="${GIT_PS1_STATESEPARATOR-" "}"
 
-	# NO color option unless in PROMPT_COMMAND mode
-	if [ $pcmode = yes ] && [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
-		__git_ps1_colorize_gitstring
+	# NO color option unless in PROMPT_COMMAND mode or it's Zsh
+	if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
+		if [ $pcmode = yes ] || [ -n "${ZSH_VERSION-}" ]; then
+			__git_ps1_colorize_gitstring
+		fi
 	fi
 
 	b=${b##refs/heads/}
-- 
2.22.0.rc2.dirty

