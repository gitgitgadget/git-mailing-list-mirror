Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D6A720373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754110AbdCMVoF (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:44:05 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33363 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754010AbdCMVn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:43:58 -0400
Received: by mail-pg0-f52.google.com with SMTP id 25so70831981pgy.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 14:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hHSxCHMg7o64OLQ/WoePc6dnCpiiQzH1YPSdMAsstJE=;
        b=L7GvhSqMlcdktenMAnQVpDtgd/8ynjZm0uspHjtS/tKpkobIZILo9yzTnEQdTsZflJ
         kq7pnIx5tKBxt0xzqY+eGuZqf1fKzVR133+uy4Jkn11k+EG/pXCX9KBL3KBYKC987SJ+
         4GPgvVVOZ6WOB75yFG5HRw49Lsj3iD8fqiaEXgXaTxTSc4OyinofolKZu2uANendsWY9
         ukxhsxOhwmC8HHhNaIWt5cHVraRDsoXjCYhr4c30gRQp1LL5oOEyKwAb79BteFtvYrlJ
         uzzqxUOCxvh0jw4SlyyqmhInmG5qwzlrC4iCvSlMadY54vnxlRmFnY8Ce5w01nocGB5x
         hotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hHSxCHMg7o64OLQ/WoePc6dnCpiiQzH1YPSdMAsstJE=;
        b=k3gcXteBMmt2ijWPabYLP5hZ+NwV4Qb3HfJ3UYDb6RTRyLh9ro3+Nf7/n07mgSPnfg
         WTdM6pqPnJuQquwKfXo6dyf0jglupxYFF+mDTMZVLdGcW24xZHoV+0r2bRrifAMTd/Jg
         yuJTK5EMTogqbL00kzKuYR/9PConPyncFaVR0TELAu9XilY2WkRLSM3BwbRpzXcAsbmz
         sEX4YmFVegrNOX6ILrJLSmL9T4Bt7emoZXDO4QviZOpe6E0V4Irc2SDikzSruc8w4Jon
         l8aLY8uJm1VD/GeYw2M0q1QmMjBRZxkS3XSpJO7XKm55Rum1Ip7pId4UQn1b0iJgMlJm
         VbTw==
X-Gm-Message-State: AMke39k7G1QfPFugdnoLV4uO9J0ZINhn4YvpbiQ0mS4tIDUN4hkVn5Esc17WR1CipCP0hmxY
X-Received: by 10.84.136.34 with SMTP id 31mr50322274plk.52.1489441437508;
        Mon, 13 Mar 2017 14:43:57 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm34525937pgj.59.2017.03.13.14.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 14:43:56 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v3 08/10] completion: clone can initialize specific submodules
Date:   Mon, 13 Mar 2017 14:43:39 -0700
Message-Id: <20170313214341.172676-9-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170313214341.172676-1-bmwill@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fc32286a4..eb13433d5 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1212,6 +1212,7 @@ _git_clone ()
 			--recurse-submodules
 			--no-single-branch
 			--shallow-submodules
+			--submodule-spec
 			"
 		return
 		;;
-- 
2.12.0.246.ga2ecc84866-goog

