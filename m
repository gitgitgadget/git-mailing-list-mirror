Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E076F1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 19:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752920AbeADT1h (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 14:27:37 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36817 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbeADT1g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 14:27:36 -0500
Received: by mail-wm0-f47.google.com with SMTP id b76so5314098wmg.1
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 11:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6/vkcGqhSZjMLfhuXeEGuS65l5K1CN4VG4rZDOcuV7c=;
        b=sgFCuaqwvG6s18sytYyaAPX68nrbqKVDy8cB7Z9oIib74F77rcd4vLgQB8xM9xwdpA
         U+JXy21w8E3N1K7sSRKWROtJrlVoTlenR7rubfO6rpUr/kd2kAR1H3vFu+CxJVhy8EY8
         garWewMfxWgquzekfks00BijOS4qWRdBEB/+iBcTUFd0Wef66aW/EaAh5Uz/nAY6fci0
         vO6820WhzHT1F/bmyAfpAVX2o6uPS9jtslwbabuWxOYG//dWERKOwdvcnaRmJpWrAfh+
         PrkBVn1PJ8neVreCk+1ECEyTV/sag/rKJ7h096aVXAGdRguuBsdnazIS8cW4PbbjnJUh
         WIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6/vkcGqhSZjMLfhuXeEGuS65l5K1CN4VG4rZDOcuV7c=;
        b=DPMkvC1sU6Sb5N9pp8boe+R8sIFhLpcWALzNhJTd4SoQGv717eTpjs0HwgAvAGRS86
         vcWOuPP1il5xS0rSR/0zMezY5JoK+rCf2+hGhjaHMZBcJtUFmt/fLqV1z1cFYs2A+Rag
         y3fmRASyyFBbRVyLAXN9Iz7/NOt4xWg28c7/Ejryq9fneWq0WeqaRuC3C1Vxxw2QkBI0
         kTT3WebAZgJiPV5Dr/WF53SiQ3eTi8R/ph8uzW/RMwZulmUbk+4GQ86pVa3kEfTpp+M9
         eEcxJgsJd/WcZZp5PFzuOfnW7AmMA4wdyZDS6uA8m1ZBKXoHzO69ygYtyPakWq8E+xG1
         aeDQ==
X-Gm-Message-State: AKGB3mKxfpoOu9jUwM8CXgJz5a1pUTd46YQcd0tzlAiaG/GVcFsQeKZY
        47L3h1PX62RfabttlvKbD/dO5Uk+
X-Google-Smtp-Source: ACJfBotYzotXywsclWxCdBqoebzWZisDt/suDMD2u0jcCPfa/FakfqML2+tPXKWEKnx/s6i2bTvZcg==
X-Received: by 10.28.4.85 with SMTP id 82mr495504wme.36.1515094055004;
        Thu, 04 Jan 2018 11:27:35 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k19sm2783838wre.92.2018.01.04.11.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2018 11:27:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/7] increase wildmatch test coverage
Date:   Thu,  4 Jan 2018 19:26:50 +0000
Message-Id: <20180104192657.28019-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180104115058.GF29210@dinwoodie.org>
References: <20180104115058.GF29210@dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes errors in v3 that caused failures on bash & on Windows.

Ævar Arnfjörð Bjarmason (7):
  wildmatch test: indent with tabs, not spaces
  wildmatch test: use more standard shell style
  wildmatch test: don't try to vertically align our output
  wildmatch test: use a paranoia pattern from nul_match()
  wildmatch test: remove dead fnmatch() test code
  wildmatch test: perform all tests under all wildmatch() modes

No changes

  wildmatch test: create & test files on disk in addition to in-memory

Rephrase the commit message a bit.

Change $10 to ${10} for portability.

Skip tests that would create a file with "\" in the name on Windows
(or rather, where we don't have the BSLASHPSPEC prereq).

 t/helper/test-wildmatch.c |   2 +
 t/t3070-wildmatch.sh      | 777 +++++++++++++++++++++++++++++++---------------
 2 files changed, 534 insertions(+), 245 deletions(-)

-- 
2.15.1.424.g9478a66081

