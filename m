Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B55501F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754315AbeFYQmo (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:42:44 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46761 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752579AbeFYQmn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 12:42:43 -0400
Received: by mail-wr0-f195.google.com with SMTP id l14-v6so9297596wrq.13
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 09:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k4hfed77kxiH96eZl5zSLvO6MG4IrAcwr2irF5hgcRI=;
        b=Z4TKG8Pa6Hp0kIEoPwLCAz4sbRMNPm1vzlzQs7IJhNcw5Mf8Sl3JWgg9+nqgXnFQVE
         ygmXTl+rf8vvOnGCAfCfzOp3Jz41oRrSVXcvPrkDiNfNYlyxsVRNmktUgklC6FfiQJIE
         u84nmLpCo4NS9gse23dXibC6SnIXTy0F82m07NOyHX496lmHE6Ms9yQ74CkS4YRzJCNY
         1tGeJ21+mH9su5u35dVilwfC72F3dyMas/OHCJGlGaJkLKx2dNetYUbz8cwkDEZ9eChj
         CB2sAICW5dHf7f7xhOWQBGvBq4dMav3bJ7lDDqjuYr1Natgdpkq1uhKDTFW/YQkTWCH/
         PYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k4hfed77kxiH96eZl5zSLvO6MG4IrAcwr2irF5hgcRI=;
        b=DDPbOf7WwPTMAKFfkEPM9s46fBf2mnC3prgOZXFK6Gehyre9fZ0SlygBHQ0JwJ0jwY
         qaMJ5Hgw8MGVpM5lCWLsQ8RceARWkdBrhFAr6TLsmzlEOaJTyiNgmfBgkRTrG/qnUy0T
         YlxJKAwD8CrlF3ww3l8dhEPmhpOAyxzFy9ChFhha8nBOBDGCe5BqKAEp0AEErLE4G9wH
         KtXgF/H0x+hz0lVHBZpSKihDM8Sh7l0wJiqWTp9D4Iw2YYfLr4T95HDytfecq4bIoKuv
         iadsOALLjVDQz9t8Ny6OLnFwhdos0/j1Z0qRFg3RwlHSJ8fBY5+ntpvqYd15CdY9gSm1
         L9YQ==
X-Gm-Message-State: APt69E17Wgw8VHeA1xQVbUTobMIY11fYFzWF/SpiHjzg/vMrzSj0TmrC
        aMamrn0vMITl87EDD/Ao1OsjsY4I
X-Google-Smtp-Source: AAOMgpfY6sYVHuxmvKoKCQgIaFSSufKCaGm/6sciepa3fz4horaCQbo1HJN00KY2CN/jYkSxknHTRA==
X-Received: by 2002:adf:8989:: with SMTP id x9-v6mr10577511wrx.78.1529944962050;
        Mon, 25 Jun 2018 09:42:42 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com (5-13-160-71.residential.rdsnet.ro. [5.13.160.71])
        by smtp.gmail.com with ESMTPSA id d14-v6sm2912904wro.24.2018.06.25.09.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 09:42:41 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, joel@teichroeb.net, gitster@pobox.com
Subject: [PATCH v6 0/4] stash: add new tests and introduce a new helper function
Date:   Mon, 25 Jun 2018 19:42:23 +0300
Message-Id: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.13.g506fc12fb
In-Reply-To: <20180405022810.15796-1-joel@teichroeb.net>
References: <20180405022810.15796-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

This first series of patches does bring some changes and improvements to the
test suite. One of the patches also introduces a new function `get_oidf()` which
will be hepful for the incoming patches related to `git stash`.

Thanks,
Paul


Joel Teichroeb (1):
  stash: improve option parsing test coverage

Paul-Sebastian Ungureanu (3):
  sha1-name.c: added 'get_oidf', which acts like 'get_oid'
  stash: update test cases conform to coding guidelines
  stash: renamed test cases to be more descriptive

 cache.h          |   1 +
 sha1-name.c      |  19 ++++++
 t/t3903-stash.sh | 169 +++++++++++++++++++++++++++++------------------
 3 files changed, 123 insertions(+), 66 deletions(-)

-- 
2.18.0.rc2.13.g506fc12fb

