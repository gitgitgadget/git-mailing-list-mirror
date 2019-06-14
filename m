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
	by dcvr.yhbt.net (Postfix) with ESMTP id 816931F462
	for <e@80x24.org>; Fri, 14 Jun 2019 06:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfFNGvA (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 02:51:00 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33829 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfFNGu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 02:50:59 -0400
Received: by mail-oi1-f196.google.com with SMTP id j184so1218636oih.1
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 23:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sGMKNfJjY2nXbFbu/gCmlnC8WzykFhIPlYpEtSj9Zk8=;
        b=QxqwfHnZSruH+nJxgeMjrjNzEEyhUGPzbz/R98pRyKOpqGXKF8Szhj4DN0hehy4F4q
         ZkLvsNj5Uloyf8VlFjJX43uwJ9YRYOJieFc7Dgkk6w/A3lMx/3CAyCjbB4Q7ZIwPjWQr
         RIE7dVdK/rksBCHWv+bNERDpGlVbi6bCPyxj2OgmZ1N2GYjM0tUXv+VoT9k0L1txpzal
         AH9MsRNP6qKHucjsdKGQw8BreBl70msJReS4EWR3L/eV6ACalGunPj0a7kplFLGFvL34
         tz1E0oLWrzdcMXMzwZgIB/yDTres5msCHX/fUfUiK32XnEC8x8Mmmxm3iduhH9a3TOn9
         1j5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sGMKNfJjY2nXbFbu/gCmlnC8WzykFhIPlYpEtSj9Zk8=;
        b=jHHu8C9h3xSCp/QjGQ0zvZlwq7mjuXXqizwz+L8PW0VPGm3G6ZolgwR5Oy8a/ft6B5
         2vHn28nlmn2KRe52EkHwySIzfxYyIKOwfSPc24PH76+vkN9nTP2u8iCJfKJtyy+FoC0B
         /sW5rds7CAZ4U6IHgRrBDiaGixCZhIS9qtr+ekYYyEgiX6tCUcOhLLsqLazVVITRupcE
         cDRHQMv41PThZg7Y+db21vrtP//AvzIA352UHXkWJE/IckAqxQV6L2v0mbn0Na8oAN5g
         dsZ9OWvIhGC6ghRdmdNbsEX0S5ftuzneWWeRfHAPxBMl+9VYILu2XAI6jTBB7LNYkj4G
         Nyvw==
X-Gm-Message-State: APjAAAVSva04dQzTVyuIApCb/1alvbqe1OakHxKFxraIwNxEFOxlY73T
        VmpFIdazXKSgUgI2P23BTQNki5fijvc=
X-Google-Smtp-Source: APXvYqzaqHN4YBuDtJnUTFiTXHo8yPklxTr15h3JXsYThRmw8Y36P1NWYUz9NRarvSkx3HtUj07zJA==
X-Received: by 2002:aca:7507:: with SMTP id q7mr885431oic.87.1560495058796;
        Thu, 13 Jun 2019 23:50:58 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id t206sm826414oig.30.2019.06.13.23.50.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 23:50:58 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/5] completion: zsh: improve main function selection
Date:   Fri, 14 Jun 2019 01:50:50 -0500
Message-Id: <20190614065051.17774-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.22.0.rc2.dirty
In-Reply-To: <20190614065051.17774-1-felipe.contreras@gmail.com>
References: <20190614065051.17774-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes we want to use the function directly (e.g. _git_checkout), for
example when zsh has the option 'complete_aliases', this way, we can do
something like:

  compdef _git gco=git_checkout

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 58b3b5c27d..92b956d5de 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -227,8 +227,10 @@ _git ()
 
 	if (( $+functions[__${service}_zsh_main] )); then
 		__${service}_zsh_main
-	else
+	elif (( $+functions[__${service}_main] )); then
 		emulate ksh -c __${service}_main
+	elif (( $+functions[_${service}] )); then
+		emulate ksh -c _${service}
 	fi
 
 	let _ret && _default && _ret=0
-- 
2.22.0.rc2.dirty

