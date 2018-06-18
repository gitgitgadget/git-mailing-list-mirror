Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EBE31F403
	for <e@80x24.org>; Mon, 18 Jun 2018 10:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933178AbeFRKqR (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 06:46:17 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54017 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933111AbeFRKqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 06:46:16 -0400
Received: by mail-wm0-f67.google.com with SMTP id x6-v6so13222026wmc.3
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 03:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PVNMLERhGCuZilklWnhacHLhfJapVBflV2tb5b9TwRQ=;
        b=HOgZwZMigcsRlEB37T8jPCiNwKEP4U5rzKcslRKTGP1JTfA5kOBYm24XgDR9/NCDkz
         nHQmxqLloQTR8+x4EWsAavAeTlv9knZjgSdenasfWGaBKfvvK5riimMAr4XvftXY2Af+
         mmC+mThOihU4nMmZJjS/fabC3d6FoPfCnPcaNG2edxLpXiQbJCMKNrvNzg7kUWhZbD95
         lZE+6WTz6BiSGO5IQdrN/g5rpGNBTGtNCZ0Y7afl1y82qpjwAouv+W7fMGtpv6Ueshma
         qytpPAQB3WwuVdppKLKiLoHdKYwPeJDGGUsEtsIsDmOevvpUo+HEeGU53PT5EWfRotNO
         gdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PVNMLERhGCuZilklWnhacHLhfJapVBflV2tb5b9TwRQ=;
        b=HKoEUmlmdMWx7gPq0ieXi31VvYaZbOZloJ/1iAyQif36gb4VwTDxS3vXd7yPnFIYK0
         gaO8El5R3pvqOrMz/vcB2Z9zt4bPpjsphD1OD3gC5Zdxqdgx6w5lqvqtApBCl+1e4bcl
         Diyz69oIkvi00i+z6lQoev/jFQCoOMqAmmB227ss1zYQi8qgmU0SNAUiFUclWnvgIdDh
         2Arjdxc9ifT2lxYF5OHN+CGh5AI5Ft8/wilEbRA/NivPceIY4ZqWkO3rPRdXIi5PIOiq
         Hut27zosNpHHn+PCNu2WnCHUJ6gDgN3rHz1ObR9EsjuNCiKZsTsbezg1Pwj+U6PcPTV6
         7UhA==
X-Gm-Message-State: APt69E3J3HFb9S0a8qZZXDEW6RWxNuKwq6C7s5PhukkA8JzOWlJ72vU6
        Jweld9BmllXojH4xAWKjoPU=
X-Google-Smtp-Source: ADUXVKJYnEXAQMFSE3ZDHbP/kHFSQwh2PK8ppwaZvP8cG4fp0FYWkPRu6RbI2hsX1aQJSLi+zX2g2g==
X-Received: by 2002:a1c:5c82:: with SMTP id q124-v6mr8765493wmb.24.1529318775179;
        Mon, 18 Jun 2018 03:46:15 -0700 (PDT)
Received: from localhost.localdomain (x590dbf37.dyn.telefonica.de. [89.13.191.55])
        by smtp.gmail.com with ESMTPSA id r2-v6sm9910467wmb.39.2018.06.18.03.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jun 2018 03:46:14 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] RelNotes 2.18: minor fix to entry about dynamically loading completions
Date:   Mon, 18 Jun 2018 12:46:09 +0200
Message-Id: <20180618104609.12342-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was not "newer versions of bash" but newer versions of
bash-completion that made commit 085e2ee0e6 (completion: load
completion file for external subcommand, 2018-04-29) both necessary
and possible.

Update the corresponding RelNotes entry accordingly.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/RelNotes/2.18.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.18.0.txt b/Documentation/RelNotes/2.18.0.txt
index 7c59bd92fb..4d9c038b07 100644
--- a/Documentation/RelNotes/2.18.0.txt
+++ b/Documentation/RelNotes/2.18.0.txt
@@ -104,7 +104,7 @@ UI, Workflows & Features
  * The command line completion mechanism (in contrib/) learned to load
    custom completion file for "git $command" where $command is a
    custom "git-$command" that the end user has on the $PATH when using
-   newer version of bash.
+   newer version of bash-completion.
 
  * "git send-email" can sometimes offer confirmation dialog "Send this
    email?" with choices 'Yes', 'No', 'Quit', and 'All'.  A new action
-- 
2.18.0.rc0.207.ga6211da864

