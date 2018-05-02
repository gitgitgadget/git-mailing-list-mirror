Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4CB21847
	for <e@80x24.org>; Wed,  2 May 2018 01:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750921AbeEBBEU (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 21:04:20 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39140 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbeEBBET (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 21:04:19 -0400
Received: by mail-qt0-f194.google.com with SMTP id f1-v6so16496856qtj.6
        for <git@vger.kernel.org>; Tue, 01 May 2018 18:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kJnHxGAIR3PL0tNr1FKJeXHog7ZlubiRmK2Gn3z9/cw=;
        b=e/6WWRHH8hUOSjusCuC1jFlNL0NmfM/UPAbQK3A02cIz2s6gL1CU6mjmGuFGBOJgrX
         JBlVhObItwdY7Uzn/ul/wamxWyI2ROTpzcrdq0Orak3TlwlO/I2AGcnmRheveuFzyazC
         Y+i0rGm4QbDfJ55bJHh5zf4v/yXecvOTt2QAulsN9QEbXDJ9bO3AgKBO4d4LTC6vqveF
         60IBOsLBmcaBwMt/CDnPXez2yzxMGwGMTwz7tb0EkqG2LymIy1eyJDWa/xwMMhxWC1lm
         7N0F2rfW8fnd+hwabixujI7WLc+wJpVifOzYd4o/gZHM8JN5Q+unJa0GoCYv/YyLU6kY
         pEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kJnHxGAIR3PL0tNr1FKJeXHog7ZlubiRmK2Gn3z9/cw=;
        b=bXmpCiuy7HV9vSfTSnF2RUJF3+hD2IwRjfG+BKo9FiRhf3JjP3Ydk4KOa1WMl0e51b
         McuHCGNSe7dEwKJfKgn99PX3uMCk6byAiM4KDxQL4GnZJXxPNgkpOY/eSf2pLn/POqCF
         Bz2tvxpXWMJ0jH76NrE7teT04/r8Mav9lUNP9mYymcwrPoxP1UTRx5EGmj2taE603wSa
         F2fuwDXUKnH159A2f5MbwOxLRqaOVj9eCs7+EiY5HS2kfjmfHqgDNsvJtL7OInNoI6qm
         pDZoPvGF4qTjraKF9YPfgFj1gLZ9tvkY+MBm/1UYDO1JZoXxwfmM/mHSfkAnovvyL8Va
         AVFA==
X-Gm-Message-State: ALQs6tClduBdX8WHOA6RiZ4Sq5R9fMrXsyN/9JA+KLBwuT//qInpPg2u
        t1mURHSAfjND+h0qwlduM93kS0ER
X-Google-Smtp-Source: AB8JxZrATRCnw7phvcFAW/zWbY7NQF0B8HLph83flPIaEJ9GlbtIwhXxafkhJ/d8Rqs3Ua4BCjzMgQ==
X-Received: by 2002:a0c:9557:: with SMTP id m23-v6mr14711098qvm.142.1525223058520;
        Tue, 01 May 2018 18:04:18 -0700 (PDT)
Received: from localhost.localdomain (64-121-142-251.s4089.c3-0.eas-cbr1.atw-eas.pa.cable.rcncustomer.com. [64.121.142.251])
        by smtp.gmail.com with ESMTPSA id p8-v6sm11076835qtp.73.2018.05.01.18.04.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 18:04:17 -0700 (PDT)
From:   Casey Fitzpatrick <kcghost@gmail.com>
To:     git@vger.kernel.org, sbeller@google.com, sunshine@sunshineco.com
Cc:     Casey Fitzpatrick <kcghost@gmail.com>
Subject: [PATCH 0/3] Add --progress and --dissociate to git submodule
Date:   Tue,  1 May 2018 20:55:25 -0400
Message-Id: <20180502005528.19740-1-kcghost@gmail.com>
X-Mailer: git-send-email 2.17.0.1.ge0414f29c.dirty
In-Reply-To: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
References: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches add --progress and --dissociate options to git submodule.

The --progress option existed beforehand, but only for the update command and
it was left undocumented.

Both add and update submodule commands supported --reference, but not its pair
option --dissociate which allows for independent clones rather than depending
on the reference.

This is a resubmission with comments from Stefan Beller and Eric Sunshine
addressed.

Casey Fitzpatrick (3):
  submodule: clean up subsititions in script
  submodule: add --progress option to add command
  submodule: add --dissociate option to add/update commands

 Documentation/git-submodule.txt | 17 ++++++++++++++++-
 builtin/submodule--helper.c     | 16 +++++++++++++---
 git-submodule.sh                | 21 ++++++++++++++++-----
 t/t7400-submodule-basic.sh      | 16 ++++++++++++++++
 t/t7408-submodule-reference.sh  | 17 +++++++++++++++++
 5 files changed, 78 insertions(+), 9 deletions(-)

-- 
2.17.0.1.ge0414f29c.dirty

