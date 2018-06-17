Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FACB1F403
	for <e@80x24.org>; Sun, 17 Jun 2018 11:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936763AbeFQL4w (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 07:56:52 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:40939 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936744AbeFQL4v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 07:56:51 -0400
Received: by mail-pg0-f51.google.com with SMTP id w8-v6so3271488pgp.7
        for <git@vger.kernel.org>; Sun, 17 Jun 2018 04:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B9nySIVol9G0LiR3sdsjRrwoZ+aYOEYcG1N64Nkp5fo=;
        b=OoKOLq4UUpGYjO4taHZgOgn3lGxXni+jtiIlbTGTomEUnnlx+AOzPAkB/x/W8rQZrF
         9awyA/Y5f86efGxYWk4afTLGPTU813rzNDANPNsg0OUX1cT9F0xms9uitrYleY+os8yv
         grjwPcsj1Axhw3G4XHTnFJpV54IMP+/ofSaW7LiFyTe3vPih9I6WqfawzmNDIETazz7y
         ygg+2tTn2LZZF1xWTZTYtRJ3M0ySpr1ajUS40bBGucdSingZFsWU1TUSqYDO67/rjD6B
         sgMwxJB91arX7eJhY5/54Mwj8pF5PtcdSDslqbo5X0Ao9KzxCPVncPz7IYn/uoAVbEQp
         bW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B9nySIVol9G0LiR3sdsjRrwoZ+aYOEYcG1N64Nkp5fo=;
        b=BQg87vTQPQCs6pC5Bm6uaB5x5PtoBBmvZkUOeJpiBOr5brB+7gmBICghx0mklgYAvn
         ytl51KoInw3nqOL0lWywOeUTRMUkaVymzKDzDT/PMeiho6kjt1B0IXsNkB6xWwLCUq7v
         Tr5vaXAuEJT2kd5jha15GlciwhQlH5aJgAba2mUh1yGjg/AvLBtu8SNibWZFAMN9Vepp
         dXbbKr6zIcufuzufUX3dkc5o+K90VBU4/K5Khxg4g8ZlABxMhLMBGk0hzjeibqUFDNub
         aaWfd3hZXIVk5W4tYpevPQlQhuaEfhb0W/7XqYItHCRHNGmreRrCu3Ht7T1GKGTCEUdO
         tIBA==
X-Gm-Message-State: APt69E2A8603lftO4sqfVT+nMjgCbgdKpN1cLXE7CybriNLU+1zdeq79
        egJQM/kHkLKcStxpClqzy+0=
X-Google-Smtp-Source: ADUXVKJA1ciHAntew1wIf0cHrFA3qzMFtDMg+9ipqZiv0So7RBlz7ybIcdhQsUv2vBNgk0n+/TkA8Q==
X-Received: by 2002:a63:449:: with SMTP id 70-v6mr7746862pge.229.1529236611109;
        Sun, 17 Jun 2018 04:56:51 -0700 (PDT)
Received: from localhost.localdomain ([117.209.147.247])
        by smtp.gmail.com with ESMTPSA id q200-v6sm16924844pgq.9.2018.06.17.04.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 04:56:50 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        "Robert P . J . Day" <rpjday@crashcourse.ca>
Subject: [PATCH v2] t3200: clarify description of --set-upstream test
Date:   Sun, 17 Jun 2018 17:26:27 +0530
Message-Id: <20180617115627.32524-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69
In-Reply-To: <xmqqin6l461s.fsf@gitster-ct.c.googlers.com>
References: <xmqqin6l461s.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Support for the --set-upstream option was removed in 52668846ea
(builtin/branch: stop supporting the "--set-upstream" option,
2017-08-17). The change did not completely remove the command
due to an issue noted in the commit's log message.

So, a test was added to ensure that a command which uses the
'--set-upstream' option fails instead of silently acting as an alias
for the '--set-upstream-to' option due to option parsing features.

To avoid confusion, clarify that the option is disabled intentionally
in the corresponding test description.

The test is expected to be around as long as we intentionally fail
on seeing the '--set-upstream' option which in turn we expect to
do for a period of time after which we can be sure that existing
users of '--set-upstream' are aware that the option is no
longer supported.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
Changes since v1:

	- update the test description as suggested by Junio

	- updated the commit message to be clear about period upto
	  which we should be testing this.

 t/t3200-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 6c0b7ea4a..e98dbfc1a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -884,7 +884,7 @@ test_expect_success 'test --unset-upstream on a particular branch' '
 	test_must_fail git config branch.my14.merge
 '
 
-test_expect_success '--set-upstream fails' '
+test_expect_success 'disabled option --set-upstream fails' '
     test_must_fail git branch --set-upstream origin/master
 '
 
-- 
2.18.0.rc1.242.g61856ae69

