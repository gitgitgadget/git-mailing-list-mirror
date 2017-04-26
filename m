Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4636207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 23:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032534AbdDZXNH (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 19:13:07 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34738 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032526AbdDZXNF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 19:13:05 -0400
Received: by mail-wm0-f68.google.com with SMTP id z129so840147wmb.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 16:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6fGyTanHkmSeY/qw7tdBf3troiy7uklA3z4K/xyPw5s=;
        b=jL7BHvQPBtTQDDwHZgdwQGUO20JgOfAu4ttlw1kDRuMDFwAPzG/zcIc6Gf++h1klQf
         O1dmwcvqKGAX8bZLnitIHkdVbrccEzc5KCpcxOVhL3SaKDRe01FeYDqGtTU/uHqLtQKT
         QWQKyPZQU9Xh2VL2zfvFWiZHnrIuoaM4RY/078+uGDJnW36NXOE/DUq5kDlXBobgN87W
         C0oZPCxEggGRZBt5vGGfqZ9eTJKV1sM1x5xipmaXHuEtqtQwgzrgYZbMYpgZ1WwIezhz
         6dIV/Eb6sjvf89J9nSS4aHwaBzD8OTAStnW6o/qaq4I4ioW8HqG28X1UEHuBm6D44Ndv
         bFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6fGyTanHkmSeY/qw7tdBf3troiy7uklA3z4K/xyPw5s=;
        b=oXTTf6fhZQ+Qn61MIxCTuVbil8lppPDwALeK2EuaU7fA0eLPy0lKjf1wIC/CwV6q+p
         Rf9QjO/8iL+rIbJAkYXlnodXaBSKezwOGc3pWCldIgTGJlwHbpKraxG10FagMZ9NfMTz
         qvbXXQ42r+ubOco/iPEhYZ8Txp2TeGaQbxanBJNrvpV/PtaiKnt4cu29SBT21L1SKvJl
         94hfOtgtf1KfNWh7ibgXf6Lt5uN+fRg8Hjts5dnX5OpRjBYHdUCsWws+x9Z6Tz0hsVE4
         cTJCEg3iLLaL73GNihziAIqsrkZm06wMgO5+gx58mxEaMsTSNf/jbwGiBKTv9453QGVz
         ilnA==
X-Gm-Message-State: AN3rC/6pe27lVqfr0R2Pq2GnnJ60kiWM640R/SEAYbz/DrEBApYEFcKX
        0fNiLIQvKDVlL/uT9zA=
X-Received: by 10.28.22.78 with SMTP id 75mr138426wmw.85.1493248379102;
        Wed, 26 Apr 2017 16:12:59 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 133sm1053097wms.22.2017.04.26.16.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Apr 2017 16:12:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/5] tests: rename a test having to do with shallow submodules
Date:   Wed, 26 Apr 2017 23:12:34 +0000
Message-Id: <20170426231236.27219-4-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170426231236.27219-1-avarab@gmail.com>
References: <20170426231236.27219-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the t5614-clone-submodules.sh test to
t5614-clone-submodules-shallow.sh. It's not a general test of
submodules, but of shallow cloning in relation to submodules. Move it
to create another similar t56*-clone-submodules-*.sh test.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/{t5614-clone-submodules.sh => t5614-clone-submodules-shallow.sh} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename t/{t5614-clone-submodules.sh => t5614-clone-submodules-shallow.sh} (100%)

diff --git a/t/t5614-clone-submodules.sh b/t/t5614-clone-submodules-shallow.sh
similarity index 100%
rename from t/t5614-clone-submodules.sh
rename to t/t5614-clone-submodules-shallow.sh
-- 
2.11.0

