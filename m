Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C67B820248
	for <e@80x24.org>; Tue, 26 Feb 2019 12:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfBZM2w (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 07:28:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41302 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBZM2w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 07:28:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id n2so13732255wrw.8
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 04:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kfUMm3MAFPGSOOV1UuukCdIccT6AJkR1Rnw4tSGesvo=;
        b=mX2pxnxl3maX+q0ROE6HLQQhx9VpKp4ndJfQxBWj/pyZIbSyE09nvtbVE/xJM4V2Kb
         Fu1oCf/QXDWpJOFcNcEkknEZd6q7ZEAFJBiKOEctjviXLNIcfEKgTgQ7F9IgiN298LF9
         IlRG+AEjHjzmjzPxaIcU2ipfEgEQBR1wEiHEGUr+6YOYK4RzeeD3lSRtZYk+ErkVIXhQ
         rKehv2N8ax5QNG6xoHVCOtNxy+rUyvm8ro78LGyHACD2alTTJB7CiwPVdY6uMiy0apu/
         OJlC7OjPD8o/BN5Q2x5XZR84u2CM3q/UiuwNLbo98JllAjKsXtgGPsDkLDqdIO2VvwVX
         WalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kfUMm3MAFPGSOOV1UuukCdIccT6AJkR1Rnw4tSGesvo=;
        b=iiW24s76J0Zsk0sHc1M5vcmiebUYjkxNRkDMHl6UhOzvLzVRrZPE8I5CPlNeyTrp5c
         WWSBfCsd2DVndvQo62iK/AHIxaURnKoSPYfqa2xH0E7oNwz81PSxec/KdOm/o+TASryn
         POjyttHLsepb+Hf4S6SXhHmwo/CL1KwzsBOlJXsXtH6+Ip9FiYUVCdjb/ao5Gcops22s
         USNsG2axmnZrbUg5a9Anu9SWxfHZxoKs3qEvVkwzAvshIsYf8esnhNmF7rcRqw+PiKPW
         eTMHZwHsqrWjPhz+tir6EEdkp6noDioQKn/RzWQRHw0RXJK4iQ8lkYnKtRQmGmXDmuey
         p7nw==
X-Gm-Message-State: AHQUAubdaEUpnJ6/PpRU/Hjn+G+A3Ko14wV7ovWEp06iHSrY/+cMzMPf
        l+XwA+8yabenPnMLx3hGg89tYmTQdis=
X-Google-Smtp-Source: AHgI3IZJy2KrtK5enxf22Za0Vc/HVHFOgAYalli+8wKyLziT1xJ2c8D2u1rOpt/8IkAx4/YORuqZZg==
X-Received: by 2002:adf:fd07:: with SMTP id e7mr17644574wrr.175.1551184130027;
        Tue, 26 Feb 2019 04:28:50 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6sm2733165wme.24.2019.02.26.04.28.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 26 Feb 2019 04:28:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Matheus Tavares <matheus.bernardino@usp.br>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v3 0/5] clone: dir iterator refactoring with tests
Date:   Tue, 26 Feb 2019 13:28:24 +0100
Message-Id: <20190226122829.19178-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b
In-Reply-To: <20190226051804.10631-1-matheus.bernardino@usp.br>
References: <20190226051804.10631-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's still active review going on for the "v2"[1], in particular
Duy's comments coming in as I write this. This doesn't address any of
that.

What it does do is have a better version of my patch to add tests for
the current behavior. It now doesn't reply the on SHA1 prereq anymore,
and we can test the dotfiles without needing the SYMLINK prereq.

I also moved it to the front of the series just to document/make sure
that we start by asserting testing functionality. I ran a full test
suite run for each of these patches and they all pass.

The only other change is getting rid of an unused "struct stat st"
variable which errored out under DEVELOPER=1.

1. https://public-inbox.org/git/20190226051804.10631-1-matheus.bernardino@usp.br/

Matheus Tavares (4):
  dir-iterator: add flags parameter to dir_iterator_begin
  clone: copy hidden paths at local clone
  clone: extract function from copy_or_link_directory
  clone: use dir-iterator to avoid explicit dir traversal

Ævar Arnfjörð Bjarmason (1):
  clone: test for our behavior on odd objects/* content

 builtin/clone.c            |  69 ++++++++++-------
 dir-iterator.c             |  28 ++++++-
 dir-iterator.h             |  40 ++++++++--
 refs/files-backend.c       |   2 +-
 t/t5604-clone-reference.sh | 151 +++++++++++++++++++++++++++++++++++++
 5 files changed, 249 insertions(+), 41 deletions(-)

-- 
2.21.0.rc2.261.ga7da99ff1b

