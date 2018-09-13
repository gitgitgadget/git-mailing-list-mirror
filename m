Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C24331F404
	for <e@80x24.org>; Thu, 13 Sep 2018 09:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeIMOfg (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 10:35:36 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:38278 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeIMOfg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 10:35:36 -0400
Received: by mail-wr1-f45.google.com with SMTP id w11-v6so4850010wrc.5
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 02:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=myitcv.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=trmzI1DQqBjht1vx5G800xBmAjGSJx6IsDR38Y38wMY=;
        b=ew64GA6SXHvVo3H0rOSS3wvw3gkDshCU2SeUYdq9BSAxzi++qDDPyCyyJJMBcSSaSn
         ySfvzH6D2JvUXYLtvj1e9zkT2MFRRSPXqW+zbRAQkzyA95CsBIbBhNeGnBkCgwbESB1Q
         644NT9zGb0lraKlZoggLDOsaGzem59sTMpi05Up1CVxtbiwAb+z76jI+3FEVc9FJ/N+l
         yFvuk0snf/1JurqIf8P8q1f5cLZ56laA6J4VJRw9zz7+GfZmZRVESphw/XiSG9ufdzGT
         O92KuFpjM2oq9Z9L3S7g5l/ExvQgAfoQ6ZdKBcu3WEfLYQwROA9llgiPgbobH8qOElBR
         rXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=trmzI1DQqBjht1vx5G800xBmAjGSJx6IsDR38Y38wMY=;
        b=pSSHwxRYT600gWynPyrqj+9usX0KXWqVUAfQbuDDxf7wxJsPZcjdx3uC+41Si/XZSz
         WDb5reEA9xEpevmi7E+QPQGVfMjzdGpUy2lgjlokujwHs2nFm/3JiFv7Ka93GO6NML1F
         wLb18tf4mgGsyOdPvQX2t1B9/v932ATpR5CJQEX6MuxJPhgKYb5Pk78dmTQWIkCXaB2d
         k7V2D1OX4j7OeAkTLv/ghMAwjZCWKiJSR4NR+hNrHC43VRTk4GFZIjUz6ugcf0bKyby+
         ahqSFfaYtDWpAi9YK1tvvp4dBVuxq5EGv0qchSvTRBafn1vn2oBVPv+8NfF2uMI42XjG
         A8Hg==
X-Gm-Message-State: APzg51DqwHCvAOgwZURB4jJq1fn/i/DQvVJF2QnVmLVbgAJCpO8u7q8y
        rQkQDu76irvG9mIrdrB+Dpq4NvefE80=
X-Google-Smtp-Source: ANB0VdbGMSK/KRKKafcOjmXvac/CHcSxCaaIpdkEMhB+8b3c4EGoIFKOEmKmTklA8K04lgwXG9Jt8w==
X-Received: by 2002:adf:a789:: with SMTP id j9-v6mr4766793wrc.277.1536830816482;
        Thu, 13 Sep 2018 02:26:56 -0700 (PDT)
Received: from myitcv.localdomain (cpc130678-camd16-2-0-cust931.know.cable.virginm.net. [82.37.251.164])
        by smtp.gmail.com with ESMTPSA id v5-v6sm2159669wru.60.2018.09.13.02.26.55
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 02:26:55 -0700 (PDT)
Received: by myitcv.localdomain (Postfix, from userid 1000)
        id 8F5AB4E2F8A; Thu, 13 Sep 2018 10:26:54 +0100 (BST)
From:   Paul Jolly <paul@myitcv.io>
To:     paul@myitcv.io
Cc:     git@vger.kernel.org
Subject: git-credential-libsecret not prompting to unlock keyring
Date:   Thu, 13 Sep 2018 10:26:54 +0100
Message-Id: <20180913092654.8317-1-paul@myitcv.io>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <CACoUkn5ZVo=3-XMPRihx-R7Rn281p9K_Q-ybuDCPJsqoS8CsJw@mail.gmail.com>
References: <CACoUkn5ZVo=3-XMPRihx-R7Rn281p9K_Q-ybuDCPJsqoS8CsJw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Apologies, forgot the crucial details post that log:

This turned out to be an error unrelated to git or git-credential-libsecret.

Apologies for the noise (and the badly threaded reply earlier).


Paul
