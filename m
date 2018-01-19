Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24C6E1FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 00:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932645AbeASAAw (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:00:52 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37345 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932394AbeASAAv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:00:51 -0500
Received: by mail-wm0-f51.google.com with SMTP id v71so233154wmv.2
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GDMVAU2/x2chnsLBt4T+2tFxohr+lVprVqOvqnc+Jk0=;
        b=vJmM2+Xg3gNR4RtAr6r0cAb/N5Esa2svO7SA637nO0onN3St+AiZcWtj07JcP74kcl
         OI8XtX1v2OgXItjZfp2kyjI4QOqt/cxFQ3Zzjc+XnNFRzWoi/V5Eash0rsStTFrN/qv0
         q52VLFfA8+VgnTdUAuF8MuoQ6+yXwTNeJMSOKXhy6sF7fHeUlcgK+bBOVBGzakPCsZFR
         yvMlP3VhdthQfUKTqPQjMmtH3d7cz0v3oLX3dwqE+r8rZs7lV2RTIL0xMjHumG4z+q/v
         MeBS/FaMxtlzs9ysWOJVJpWzR8d2vNPAuzw9b5iSPnyD7zzQnEUAlMFU2k9uLjIF4UUq
         GR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GDMVAU2/x2chnsLBt4T+2tFxohr+lVprVqOvqnc+Jk0=;
        b=e21B5/YmtVJY9kaWJaykqvhTI8g7A9VFsPD8mwtMAh672Jkqq0xlWFis//mNUn49oQ
         TUoQApnkfkdcBxMrAYgtagN4d934BFmnP3o0TTlOhJZqda29+MqLF7tCW5qTytoMtZZF
         pPE4ISJqiS62/jxAUjccU2BT+Gtnq4uKaXM00x9rgS8aVLtCpDiOPjG90L9K41JeMv7B
         Ek+ffEpd1AnVTbgr0PNWETpE/xOkocq5/59J648alv9FzvWbCQL8R9L+/9TPHfJXHdSZ
         VmI2Gn1w9h1zEKSDRtbsjSaqjoJ52PLc2OzeWLcvlx+CKmuiB0EG90IPCCgpWuWoSRB0
         9rUg==
X-Gm-Message-State: AKwxytco3vIEYoRFnfKNERBzkrNCp8W5MLPZI6me4spgJYuOVC9hF75R
        ybqTbucYGtwjSjGSTluoCGH4bG92
X-Google-Smtp-Source: ACJfBoteE3iINVI+YKjxHgWjoMyRSRJmyFxecpAyqcyagbG3MhT58smCxJSsBI2oxJ22MeP8nyD07A==
X-Received: by 10.28.66.198 with SMTP id k67mr5936880wmi.74.1516320049878;
        Thu, 18 Jan 2018 16:00:49 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b48sm17706481wrd.69.2018.01.18.16.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 16:00:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/11] document & test fetch pruning + WIP fetch.pruneTags
Date:   Fri, 19 Jan 2018 00:00:16 +0000
Message-Id: <20180119000027.28898-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <87po6ahx87.fsf@evledraar.gmail.com>
References: <87po6ahx87.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Giuffrida noted that the git-remote docs were very confusing,
and upthread I said I wanted this shiny related thing in 11/11.

Along the way I fixed up fetch tests & documentation to hopefully be a
lot less confusing.

I think 1-10/11 of this makes sense for inclusion as-is (pending
review etc.), 11/11 is broken currently, but review / comments on it
welcome, particularly the CLI / config interface / docs etc.

The bug causing it not to work is less of a "I can't figure this out"
and more of a "I won't have time again for hacking in the next couple
of days, and wanted to see what people thought", but if someone wants
to see what I'm screwing up there and do my homework for me that's
also most welcome.

Ævar Arnfjörð Bjarmason (11):
  fetch tests: refactor in preparation for testing tag pruning
  fetch tests: arrange arguments for future readability
  fetch tests: add a tag to be deleted to the pruning tests
  fetch tests: double quote a variable for interpolation
  fetch tests: test --prune and refspec interaction
  git fetch doc: add a new section to explain the ins & outs of pruning
  git remote doc: correct dangerous lies about what prune does
  git-fetch & config doc: link to the new PRUNING section
  fetch: don't redundantly null something calloc() gave us
  fetch tests: add scaffolding for the new fetch.pruneTags
  WIP fetch: add a --fetch-prune option and fetch.pruneTags config

 Documentation/config.txt        |  21 ++++++-
 Documentation/fetch-options.txt |  18 +++++-
 Documentation/git-fetch.txt     |  49 ++++++++++++++++
 Documentation/git-remote.txt    |  14 +++--
 builtin/fetch.c                 |  38 ++++++++++--
 remote.c                        |   2 +
 remote.h                        |   1 +
 t/t5510-fetch.sh                | 125 +++++++++++++++++++++++++++-------------
 8 files changed, 216 insertions(+), 52 deletions(-)

-- 
2.15.1.424.g9478a66081

