Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0EC41F424
	for <e@80x24.org>; Tue, 24 Apr 2018 00:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932655AbeDXAJH (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 20:09:07 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38825 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932615AbeDXAJG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 20:09:06 -0400
Received: by mail-pg0-f65.google.com with SMTP id b5so9495499pgv.5
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 17:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VMPV9cOyUtYoGivAJ6pciZy6Uf0fZ4VkKFtpZpyBvgk=;
        b=Qo7TSZMN39UNo5bkQjJAMww/N8Xe/euLtq88DUpFRUpfAShPd3tSyAO11L/HGwUSJK
         /pKrYBCrkPebWv2B7406qwp5UqQo8zfhTITdLpWaiEW26ZNbdzzUZ8dylRiOgN5nTKhr
         zZhH2DB47YXpm7NDPV56TE5znCM/Ng5hrTkvk1Qrpfxz35EYgHU7nlE7DkBGpanF26GK
         Ogu3aE2GC4Nif+VNgXwvzxn2xCrYAnhzlb9xQIV9ZJwcSvwR2ihxb4OKPtVUfDcOsJZO
         QuFEmTNvI4puJIxNsQC72f2OASjVK/fQOWKzxhrpgSiIosNGGoa1v8vC3dwj2XXdFgBe
         9hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VMPV9cOyUtYoGivAJ6pciZy6Uf0fZ4VkKFtpZpyBvgk=;
        b=r1cNCcyskRw1PkckXHiZUrQk6+C3yd9jhwtg9liGKJUAJKVCBdJGYexlSWw+2i/mYO
         icoctabxZ69fqYZp7ftl0djaqzUeXZkgmry2I87vQcOgBQZO+L6m8rbwXZnJZp2BmVai
         kQXfZPgjLd8+mEumFEarhVaIl/1ek7ACnjsnDohLJxPv38mUITn/Oe0I4r8Wq7V1rgdX
         ehd53DcXoZDEuzwx6xTQM0GBhB8790s8y6L2/l8D3fgunWAzicEugkLs56UGnOhYsj4A
         hKxCbWi2XLRJzWaqAVKC63TCszvg1nzwgNi+pW+Xcz43KoLg7uoBSubjvAnJ0f7nwduY
         nrwQ==
X-Gm-Message-State: ALQs6tCDSRCWbcAm8VZNtd/AwSjWipSbNTwHw2g5mUvev9UhgUW09CXR
        CrznExi7lyzzqo9++N1OSzcki/1G1mQ=
X-Google-Smtp-Source: AIpwx48FxyQAREBdtNi+DYE3oz07+iNvrAiCYDGDH92aEEJS5mt0kmZpmWhODxGKpqJKuvim840Ffw==
X-Received: by 10.101.100.132 with SMTP id e4mr13335257pgv.102.1524528545464;
        Mon, 23 Apr 2018 17:09:05 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id l129sm19430927pgl.89.2018.04.23.17.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 17:09:04 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/3] Colorful blame output
Date:   Mon, 23 Apr 2018 17:08:57 -0700
Message-Id: <20180424000900.175235-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a revamp of
https://public-inbox.org/git/20180416220955.46163-1-sbeller@google.com/

Junio had some issue with that version, as it would collide config and command
line options. This is fixed now by introducing another option.

Thanks,
Stefan

Stefan Beller (3):
  builtin/blame: dim uninteresting metadata lines
  builtin/blame: highlight recently changed lines
  builtin/blame: add new coloring scheme config

 Documentation/config.txt |  27 ++++++++
 builtin/blame.c          | 129 +++++++++++++++++++++++++++++++++++++--
 t/t8012-blame-colors.sh  |  48 +++++++++++++++
 3 files changed, 200 insertions(+), 4 deletions(-)
 create mode 100755 t/t8012-blame-colors.sh

-- 
2.17.0.441.gb46fe60e1d-goog

