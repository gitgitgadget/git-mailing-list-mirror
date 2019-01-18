Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B4311F453
	for <e@80x24.org>; Fri, 18 Jan 2019 09:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfARJhG (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 04:37:06 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:44098 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfARJhF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 04:37:05 -0500
Received: by mail-wr1-f47.google.com with SMTP id z5so14152523wrt.11
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 01:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zXSvj85e0xtwe9r+TJvinX1HozDwmdv3tbWgNxDle5I=;
        b=ZC5vSYXEcLAUmAAKuzSYA3I9adh4Zt8xW0NNTyWEb7F4NGXevcL82luDHBuU2mCcdu
         ANz7hmEIg2j/5+egTGqfzG02MiELdbDph/VhK0/xd+d8KQOs9W4HOov6RqbTzqku/ga4
         kRMsl9e0TycjDmFY3XBUs9rjLPumSz9/U9GyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zXSvj85e0xtwe9r+TJvinX1HozDwmdv3tbWgNxDle5I=;
        b=WfV75ahxfDuwcc16fPPKWqHqXde0Jn0elu/e0SiG0zxB9qTyfeNoAaOcIJsIT/eCpi
         la3fLso45VMPEzDI6bNWgCwwKiKGepJX2mycMBV9m4yXrqj7oWLWPKuUV0Au2pIfBNpV
         AUpG9s7KFAK/3Q5wDwxpNP2o4TG1EhCf3pH9RrqgOhO3aHQbj58b1YrMjJYy/tfU6LfL
         e7g5chjrLoOewR1e3h65N6tR4snZW82le7RFbrBHjkfee7fI63TLrwNpFP+CN1axg21q
         ogsN4WlluJ1r+6g44CmiEkPs3bRcbo4LJJGhAIeoRhpULhAAYD2kaDj7IC+y1bNykO55
         XcGA==
X-Gm-Message-State: AJcUukdm5CIw5uu8AE73MXNx593hcHeEiZ0AE6t3/6zrGdE970l/0h1u
        ZsFMCozF1b7oW3emutmEe0yicSl7xWc=
X-Google-Smtp-Source: ALg8bN55NBKWxlJHDdyzZ1f+nI/9hSKx/fPHGFqGCUM0XkxGIw331Z+0wGs/D4GzqS2B97MUVLeNOw==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr15253494wro.208.1547804223993;
        Fri, 18 Jan 2019 01:37:03 -0800 (PST)
Received: from ethel.local.diamand.org (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id x10sm103962059wrn.29.2019.01.18.01.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 01:37:03 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andrew Oakley <aoakley@roku.com>,
        Romain Merland <merlorom@yahoo.fr>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vitor Antunes <vitor.hda@gmail.com>,
        Andrey Mazo <amazo@checkvideo.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 0/2] git-p4: shelved change update with move/copy
Date:   Fri, 18 Jan 2019 09:36:54 +0000
Message-Id: <20190118093656.16521-1-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.100.g9ee79a14a8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This updates the patchset to support copy, as suggested by Andrey.

Luke Diamand (2):
  git-p4: add failing test for shelved CL update involving move/copy
  git-p4: handle update of moved/copied files when updating a shelve

 git-p4.py                |  2 ++
 t/t9807-git-p4-submit.sh | 57 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 56 insertions(+), 3 deletions(-)

-- 
2.20.1.100.g9ee79a14a8

