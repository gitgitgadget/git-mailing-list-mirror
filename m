Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 476E8208E9
	for <e@80x24.org>; Fri, 27 Jul 2018 14:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbeG0P7t (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 11:59:49 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55678 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730714AbeG0P7s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 11:59:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so5474563wmc.5
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 07:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GLZogffY88bXmZjTPNTX11CN/ee95nBCezJnDT4QCAA=;
        b=LsYfX6vFAKH1ZCli/uwnARMlANYCgAoAcduRapap6oo1UuBMls34Fr/T+o8zhZ5WZH
         9AqsifSoznHsHEGrQsqSnjQ2PnK7yhh7T5/W8Aoyo0lfXMqhdtY+5MUCPlFvFiPRfNol
         wGjVmbWlsX+gZQEPxWCHvJnwy/4IKUZk+jjWbefz3hEMZ4jkcEKnEugmpbIF+u/rz/bx
         eWyvR0vnnUPD+AVBpJqsPHmziIeC1ie3M/cwrTm59dzl2hjzUQFHiLXkgUQEyaZgzKgN
         AD+ru3yjk4qymls4IjvwAKKeYFECEGb+63okTbmq6VGBszkfv8wviujyhrjh71X4Nd8l
         sa1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GLZogffY88bXmZjTPNTX11CN/ee95nBCezJnDT4QCAA=;
        b=ipjgn7Dtz5qX7UX9O2P33/brA0uOmSU9YWO6BymIkKmMScW+mjkOARkjAlc8B9nqmG
         B4p/QAumMBuY6uqHNcD+7OUTe/eNGO9N4PxGHb7WRZjR7UPJH+PqCejkOqricQcfLOwq
         9tZAR+7Qh2GZd7qkxV62zfJHOQklrNrGoCau1iVYj2g25D0BSNuPGEVdvw/S33rkiMx4
         1qHx8SNh9AxwaFpCDNiZLRRC3nbWNn0/OkVlZm3wpKNURGCGYuzxPIFLasOt5kf98dh2
         mXtSj1qEIofAS2qHfC8r+xqOnuiyhf73owBazEEAOtG4fuFJ+c9UDTYCWL0o2hF9pnL0
         ys8Q==
X-Gm-Message-State: AOUpUlHlQri19hF4r8hvUOonMUnHVQDsuIQ+/32gj+5dujPVTaO/vX8f
        posWZrMb8QcgRDl02IMFM8j1Wcf4KDg=
X-Google-Smtp-Source: AAOMgpe+mYyq5+V6LcRWN+NhUqmqGh4jleHZVAv7jQa3ZD9gTqiHA6sqD6bckXgOpZ8qbhvLPEi6Qw==
X-Received: by 2002:a1c:e5cd:: with SMTP id c196-v6mr4439280wmh.101.1532702254156;
        Fri, 27 Jul 2018 07:37:34 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j16-v6sm3005479wme.8.2018.07.27.07.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 07:37:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/10] fsck: doc fixes & fetch.fsck.* implementation
Date:   Fri, 27 Jul 2018 14:37:10 +0000
Message-Id: <20180727143720.14948-1-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180525192811.25680-1-avarab@gmail.com>
References: <20180525192811.25680-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's been a couple of months since I submitted v2 of this. This takes
into account all the feedback in the previous thread
(https://public-inbox.org/git/20180525192811.25680-1-avarab@gmail.com/).

To recap, this series is mainly about implementing
fetch.fsck.<msg-id>, so you can turn on transfer.fsckObjects=true and
still allow "fetch" to fetch a whitelist of repos.

I wrote this because I turned transfer.fsckObjects=true on internally
while the .gitmodules security issue was still under embargo, but then
found that we couldn't clone various repos with historical issues
anymore.

It's now 10 patches instead of 5. I rolled the spiritual successor of
https://public-inbox.org/git/20180529211950.26896-1-avarab@gmail.com/
into this series (as documentation, not tests), and noticed many more
things along the way that were already broken or not tested for.

Three of those come after the "fetch.fsck.*" implementation, not
because they rely on that new feature, but because now fetch.fsck.* is
one of the three modes (along with fsck and receive) that we'd like to
test.

Ævar Arnfjörð Bjarmason (10):
  receive.fsck.<msg-id> tests: remove dead code
  config doc: don't describe *.fetchObjects twice
  config doc: unify the description of fsck.* and receive.fsck.*
  config doc: elaborate on what transfer.fsckObjects does
  config doc: elaborate on fetch.fsckObjects security
  transfer.fsckObjects tests: untangle confusing setup
  fetch: implement fetch.fsck.*
  fsck: test & document {fetch,receive}.fsck.* config fallback
  fsck: add stress tests for fsck.skipList
  fsck: test and document unknown fsck.<msg-id> values

 Documentation/config.txt        | 138 ++++++++++++++++++++++++--------
 fetch-pack.c                    |  32 +++++++-
 t/t5504-fetch-receive-strict.sh | 126 ++++++++++++++++++++++++++++-
 3 files changed, 255 insertions(+), 41 deletions(-)

-- 
2.18.0.345.g5c9ce644c3

