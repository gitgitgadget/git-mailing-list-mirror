Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64B3420248
	for <e@80x24.org>; Wed, 13 Mar 2019 23:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfCMXzB (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 19:55:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33155 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfCMXzA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 19:55:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id c13so5579835wmb.0
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 16:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xHRyI15TQ7fbILvWf6ZODgacC2LwBlPrikh0/R57BQg=;
        b=HRkmZVTf0TGFh5jjscez10KIbUwgBvkT+LgBXuT2GhZo48YwuoiXt8AGCjt4e/T1Ha
         eYLqOA5A/Ba/iyqwARDmZYZeZlbMZvERgKqhpjyeXR2XGjWDj/a0AigrUzx6ukwPk38y
         UaI1yEjf01ctp/pQtYZ4heMR++R31Yg8E8H7noVyPz4g9063HpLaa/YnDeSisZrNIlUo
         jPSxsqG99EAlBoTqIILx1ccjnzK78f2ushTKRLuZljhaYf4HuRqLl+y9vqPXPdbAdGgi
         llofPmvCfU1h7gHfEqpigWUkWD54SMnoPIbRDpAjCMENax4ISwipEKrr/JBsqjL5WDet
         pZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xHRyI15TQ7fbILvWf6ZODgacC2LwBlPrikh0/R57BQg=;
        b=VD3rDsJWUJGgJt2tFCk3v6x7dHQZNq0vBNZN7Y8kvdgOmz3jDtZP973ZrB+PbRxtQL
         LKyoc4LthiXgTZTRcSu4Lg5PRqlF3T5fSSl6lm5k5RUMQOsK2lgS/6v7M9Kyx+0MtOaD
         N8694o1IWiaAiOzsqDCOr2MfLi4fzDryT1Cv2L0DRMhjO5ifMNkNEvREQ4mqvwoFEn5s
         jVBAp2KE2NW1KjncQCjxF2O3St5iFWMcIGJK50YdtFKmYSy3g8yXM5JUp5R+pz0yJWPf
         wZe5WBWC8zL11I+iOUFOUS7y+q07xJn64YCSg4ysQLwNa/hAT0gaKj6cgE9xvCAeZhiV
         B/mg==
X-Gm-Message-State: APjAAAXV3W5IbXseevLQUnsoFTT5bt4LElzRynKYBt5lDYqavj/rThta
        FvShlcMKIr2t4OwRezBR7WPTbVqa
X-Google-Smtp-Source: APXvYqzJ+uHHCfwnipPe7cPaaE98K7zeldwCsPVR0wOnj7uk1Vp/pd0yS6iRKH+Xhed+hHMrMbgukQ==
X-Received: by 2002:a1c:1a43:: with SMTP id a64mr428352wma.73.1552521298546;
        Wed, 13 Mar 2019 16:54:58 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b10sm9998566wru.92.2019.03.13.16.54.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 13 Mar 2019 16:54:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] gc: minor code cleanup + contention fixes
Date:   Thu, 14 Mar 2019 00:54:34 +0100
Message-Id: <20190313235439.30439-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <87imwmbv7l.fsf@evledraar.gmail.com>
References: <87imwmbv7l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[45]/5 fix a couple of issues I noted upthread. While I was at it I
noticed a few things I could clean up in [123]/5 that I figured I'd
send alongside this.

Ævar Arnfjörð Bjarmason (5):
  gc: remove redundant check for gc_auto_threshold
  gc: convert to using the_hash_algo
  gc: refactor a "call me once" pattern
  gc: don't run "reflog expire" when keeping reflogs
  reflog expire: don't assert the OID when locking refs

 builtin/gc.c         | 33 +++++++++++++++++++++++++--------
 refs/files-backend.c |  2 +-
 t/t6500-gc.sh        | 19 +++++++++++++++++++
 3 files changed, 45 insertions(+), 9 deletions(-)

-- 
2.21.0.360.g471c308f928

