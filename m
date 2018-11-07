Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1CBA1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 12:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbeKGVwX (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 16:52:23 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:52372 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeKGVwW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 16:52:22 -0500
Received: by mail-wm1-f47.google.com with SMTP id r11-v6so1129767wmb.2
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 04:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ByzrL2qRnxHXNwZ2CGlpzFnUFs+LOgB3HiemNDWF8UI=;
        b=R/qJRNKiD0X5/s3D8iGb25Y4VUiFPeu7ANiSEMDkVoZzbQTuXwQ2G9fRSireLA60xZ
         rUCU+ZsWVkkJdIA29iVBEfWYM3Po2nyJFrYP7a5qsITZY2fNnrRT+qukgt604JH/zcnI
         FHMsMCzruzARmTvOVt9GjfmU6m6othARSqFgharxeKHTnJDqMdeprIL2t/taqYyvAFC2
         bJnJMxqu1C5gN+rJnaRQY3L9UeUHNS8UEAWQnhUK8Yis3NhT/V2KjnPJSEcVlq92sVFo
         N046kznsKYT5gwcXbGKDyEeOwAEZP5VUw35xmzfeUVnoSG7i05DlaRa7f9GrwUnUHfVd
         2Fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ByzrL2qRnxHXNwZ2CGlpzFnUFs+LOgB3HiemNDWF8UI=;
        b=m46XlK/A6dFU4i53MTYrhT2qSwU8SIy8dkcMBHoWNJaam2az5W1cBK+H43Ft7RHlEY
         MX7AEiy1/pg/mcwVMAConBkPedlPRiPVVRxUIgrn/RuhE3D5/HeqL5TufEE+gXO94X1p
         uB3Qgs+zXsvJ2meo4t9oQzzB39t263YF+25PqduxX+/OqV3MvyhUEf3OX70wD9yjuFjV
         WVjB5AQmXQJXdrcuwkCRpU+2fzL7te4gpAyMC05he4p7WzKTbX9u/vVmIrzrtHr0DzpM
         9TqtG8dpUNJ1N+lVE4JPOEeUsPz3aWMKT5bx/knLrPc2hKghMKr7yAQAPAi7AF9GPphB
         Bfhg==
X-Gm-Message-State: AGRZ1gLTNvP9E9jYeL141m84cjxhxLo1DpA9bvZd0SLhb0HUlj8kuzoP
        bQqbVpndBWDvTL7kgDtUQdj0+qp1oj4=
X-Google-Smtp-Source: AJdET5e08TF/cPVXIllCr7fQjk0Xc0jn0ULwPWtPkT9n09Dgm35R4+tXrydNFsunwPz4iRHTJsCGIA==
X-Received: by 2002:a1c:9a0d:: with SMTP id c13-v6mr1715184wme.65.1541593331870;
        Wed, 07 Nov 2018 04:22:11 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y21-v6sm550936wma.36.2018.11.07.04.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 04:22:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/2] range-diff: doc + regression fix
Date:   Wed,  7 Nov 2018 12:22:00 +0000
Message-Id: <20181107122202.1813-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0
In-Reply-To: <nycvar.QRO.7.76.6.1811071202480.39@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1811071202480.39@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As Johannes notes this --no-patch option I wanted to add is something
we had already, but is it turns out it was broken.

So this is an entirely rewritten v3 (not bothering with the range-diff
for it) which a) documents the output stability of stuff like --stat
and the like (there isn't any) b) fixes the regression & adds a test.

I did try various other diff options and they all seem to work.

Ævar Arnfjörð Bjarmason (2):
  range-diff doc: add a section about output stability
  range-diff: fix regression in passing along diff options

 Documentation/git-range-diff.txt | 17 +++++++++++++++++
 range-diff.c                     |  3 ++-
 t/t3206-range-diff.sh            | 30 ++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.19.1.930.g4563a0d9d0

