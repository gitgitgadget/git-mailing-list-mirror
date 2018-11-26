Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 967921F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 19:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeK0Gd0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 01:33:26 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34517 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeK0Gd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 01:33:26 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so14526469lfc.1
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 11:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=02ZfUcn4VlloQoeFgzHTtkO07MG5EP9BuZJLa019vd0=;
        b=d8sI460/GUT1bnRmfShofI6ZQKHc8oQkOM0ykQHXI7kQAj2pXN4yhoHDPORdhia1Uc
         iqEFfjKsNl8MLmgrck/SgPZQdkRu9G3ABf6S3mfhdvn3X70AFHSI3sZrkQf2DyawfAPO
         A5EaB7pLPx2b0VjSt/EJVJyWnEZrS4cN3xkkMr6MzA+mE7FBMsebFty+NCMheYRISTkB
         KvMSf4sZPLkz9E0rDhQA2XDe4+515sFCZG2PE0HEmg2qQXyn/yqqxi6vA5LOCEPE/URl
         /qI2tkrX5zdvFw5JOivkc4Q3Tax3kC8XTN7zPR+Hp8l6DBbls0J84F0gFXe2M+NAbe1z
         eCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=02ZfUcn4VlloQoeFgzHTtkO07MG5EP9BuZJLa019vd0=;
        b=hm4BrdN7uzQwhajSw5all+X9tZYzl/4lgGj87nL9cIn6NXIhdtzUgv5cDVPwtbmipG
         U8pRODFXGApNgexTi64zjYpDsbOhLyIs9fKYoUtva03/PusDZUa3wI5KtmOESFXY8DxJ
         NwgQBOdyZXqM9Uzg8PxGbf8rsvogPbIVwtdSErKyaWBRUzOA6cN9lYf/U7gT8wToRXwW
         SHweBFaOCStCfS5nK1G+rOfexi8gofrO+knAyx8H/o/41ZCRlSMn/h4nWwJNhv4/ZaMv
         +cD9LPsefsQVjbNpEOeZWMQWC9C1h44mPy2otMyaIOUTsfDShiB/knklOfPF1jW5MNyQ
         /kJA==
X-Gm-Message-State: AGRZ1gJS5QEZlZyVFJf/U27CGN4yEQzyQ32h52HrEaXusGk7PVbbrpV6
        A08kPGLLKgEX8ao9UucMkkw=
X-Google-Smtp-Source: AJdET5cF6YaSMXeBy+mB2F0RmSSTZ+siaGjj7RNhyGRASZrfe/B/W47wY/VeEKV+EtC9Bj8jRs4Cag==
X-Received: by 2002:a19:d486:: with SMTP id l128mr16149079lfg.114.1543261095577;
        Mon, 26 Nov 2018 11:38:15 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id p91sm202564lfg.4.2018.11.26.11.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 11:38:13 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        bert.wesarg@googlemail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        drizzd@gmx.net, git@matthieu-moy.fr, hellmuth@ira.uka.de,
        jjensen@workspacewhiz.com, jost@tcs.ifi.lmu.de, kevin@sb.org,
        per.lundberg@hibox.tv, sandals@crustytoothpaste.net,
        eckhard.s.maass@googlemail.com
Subject: [PATCH v2 0/2] Precios files round two
Date:   Mon, 26 Nov 2018 20:38:02 +0100
Message-Id: <20181126193804.30741-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1327.g328c130451.dirty
In-Reply-To: <20181111095254.30473-1-pclouds@gmail.com>
References: <20181111095254.30473-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's see if I can make everybody almost happy with this.

Patch 1 is not that much different from round one except now with
tests. It is still about "precious" attributes that prevent content
loss with "git clean", "git checkout <ref>" or "git merge".

Patch 2 goes Ævar and Per are pursuing. It adds an opt-in config that
turns all ignored files precious, but only for unpack-trees
operations.

Nguyễn Thái Ngọc Duy (2):
  Introduce "precious" file concept
  unpack-trees: support core.allIgnoredFilesArePreciousWhenMerging

 Documentation/config/core.txt   |  6 ++++++
 Documentation/git-clean.txt     |  3 ++-
 Documentation/gitattributes.txt | 13 +++++++++++++
 Documentation/gitignore.txt     |  5 +++++
 attr.c                          | 12 ++++++++++++
 attr.h                          |  2 ++
 builtin/clean.c                 | 20 +++++++++++++++++---
 t/t1004-read-tree-m-u-wf.sh     |  6 ++++++
 t/t7300-clean.sh                | 29 +++++++++++++++++++++++++++++
 unpack-trees.c                  | 20 ++++++++++++++++++++
 10 files changed, 112 insertions(+), 4 deletions(-)

-- 
2.19.1.1327.g328c130451.dirty

