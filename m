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
	by dcvr.yhbt.net (Postfix) with ESMTP id 70D911F462
	for <e@80x24.org>; Wed, 24 Jul 2019 15:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387541AbfGXPOs (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 11:14:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43657 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387503AbfGXPOs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 11:14:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so47379579wru.10
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 08:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kNbnHs5dDLqIf09O6FJBDLByNgiFYv8kfJWGBltb8k8=;
        b=f4yswGsViYgbV2gBmOlrU7cPEAeF5jNbY2dgbWauTFisMlewgW26Y9JvX5Ax1+wxfZ
         rITfxezEx8n2KfkEa0V3t2NrW9YYIls0MZVCpcFBfPnKUdHa/0Srkk+Cc6YsWqVNb9WE
         4OWUlDjlFdaZjzTgafvWV7p89NuuG63whf6zWKdKtfc6tuA1FWrK0J6dLv0g79clypsf
         KswWTQAWMC9hB5CmhtTYmnzvxu1XVmRuxUkBO0BX5D4pWJIEmiM5Kw67mmZYsXNX05nm
         A+9qizpORDxAQj6UQX9GKel+nsWYT0fNBeTkyM8ApCZAxv+KZW6NeIPyVTDsLrJjwmXb
         LDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kNbnHs5dDLqIf09O6FJBDLByNgiFYv8kfJWGBltb8k8=;
        b=SoUNjel7YRhfny+pXfVaiVV38Yp1WJo4xPTKhgr4KlrEWzFg+bgRDhu+TuSNLs9BIG
         ejzX6c1jOaMetaDDV/fJ6kkN4QaIbqxbcLXQH1vFyxa0afkffhIroH0tXYb3P2YsDsEH
         3z93OuKhVZvya0e53wOG+nG/TUDOaiH/O+wbtVAm7lpkJAWaU2/oEJrQGUxJn2yS5s9d
         beb2/CW1rC2PDWzJzXQQiQV4szNmop2MCRI1VBoi/7Jv8SnfrHvr7z2kgfKIsw3h4XUX
         eMSR0n8pFfR1gQmdo0T87iXfpbetbMWIopZy3bZja24mLaMd5Qxxyibfk7O+4cRRsQL9
         i+NQ==
X-Gm-Message-State: APjAAAXHf/cHHM10F6YmnGE3Yh9cOmNVaXaHVnotw7xS0E9k6+jOEMTW
        5tqC0fHN+5fYrKoEEdqGuiR5nCTz
X-Google-Smtp-Source: APXvYqz47lnqNYxuJi2a6B2/DCJt6wCyJ5rUe1EapNOjDkrHRwcYFTahj2afGWxTkbuIune6mKgWFA==
X-Received: by 2002:adf:9f0e:: with SMTP id l14mr82522112wrf.23.1563981285856;
        Wed, 24 Jul 2019 08:14:45 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c78sm66970530wmd.16.2019.07.24.08.14.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 08:14:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] grep: PCRE JIT fixes
Date:   Wed, 24 Jul 2019 17:14:12 +0200
Message-Id: <20190724151415.3698-1-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190721194052.15440-1-carenas@gmail.com>
References: <20190721194052.15440-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's a couple of patches fixing mistakes in the JIT code I added
for PCRE in <20190722181923.21572-1-dev+git@drbeat.li> and
<20190721194052.15440-1-carenas@gmail.com>

This small series proposes to replace both of those. In both cases I
think we're better off just removing the relevant code. The commit
messages for the patches themselves make the case for that.

Ævar Arnfjörð Bjarmason (3):
  grep: remove overly paranoid BUG(...) code
  grep: stop "using" a custom JIT stack with PCRE v2
  grep: stop using a custom JIT stack with PCRE v1

 grep.c | 46 ++++++----------------------------------------
 grep.h |  9 ---------
 2 files changed, 6 insertions(+), 49 deletions(-)

-- 
2.22.0.455.g172b71a6c5

