Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93BC520248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfCUNRq (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:17:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42962 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfCUNRq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:17:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so4165716pgh.9
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JGGuFn7quapFT4WMuLe3k3Iou/uAlQ03Kny5BUAXE2Y=;
        b=Kq3DxIKo5yrJ3r8j4ovlrTydH5aCSgY0zgfqXrkK8hqT+fvMmaBwce0GWd/vAb6M+k
         eNl22zrS2/KTKbL/UNkCnIJiEgtIUDrJiE7HKqZSCHTJygt9m8000I2CE8POwAVKN6NE
         sLqu6gu2OZq5gpOu4jzIp52Qd3mK727lhQ1aPXA1Oq8SGS0oK09FkKwu4ch+DqplEDzt
         F9U2zFGXhMlQVR5UIhXUDdrcxedhkQZi4PlXfcEbrdq0to7+k9NoboF31vnsBMvL1gvN
         P4CJmGrsbmiF3uNPGTFYzENvB4ob7IoYrXlJ6Xm7joJUmdVeZG+Mt+8mwLbjYVMN+ikx
         mWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JGGuFn7quapFT4WMuLe3k3Iou/uAlQ03Kny5BUAXE2Y=;
        b=HjosduzLZnpwK6KgkzZL5m4kliz7d5Ozq2PVlmsAQLMz9ZpznNIClwxCa5xVDK+W69
         5isrL1HDjJgbazclGgZTMYmE0nZmMF23aqJNTuTcysW9CixZ2iQJZqpgFappPZRCbbif
         GTvordJ8i5FzWUkFF5nDniHxoQABcXa0bpJcoHPGK9r1R4GCbYyezCfjGWqsBI+rpdER
         6Sg6iDipbbrylkr+j7FEAKOsKFKH6xKzYCBN7PVr5bfe9WpvXgYO7kXtPmPgaWosWu/1
         UdsrStibzvys5A+wxmEenxWYWXEIxXPRAuYCtW2A9cqb7CgHMQtBr3vnmrz0qOZnbPAT
         21wg==
X-Gm-Message-State: APjAAAVrGqJBQIRUkfk9Q9h/3r4FxWtrb1DAE32wREkJBTjkPJl8WsbR
        sECCKkKMMOx9g1SYvrPbKAg=
X-Google-Smtp-Source: APXvYqz2CWmDGDVOz5Sqn6iSECbgHKa25IkPjMjRv9uVqo+Sandb7jcFaXdurecvVY+UUVsWBnn5zg==
X-Received: by 2002:a62:ee13:: with SMTP id e19mr3282261pfi.224.1553174265615;
        Thu, 21 Mar 2019 06:17:45 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id a2sm5853751pff.58.2019.03.21.06.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:17:44 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:17:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v5 05/26] t: rename t2014-switch.sh to t2014-checkout-switch.sh
Date:   Thu, 21 Mar 2019 20:16:34 +0700
Message-Id: <20190321131655.15249-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190321131655.15249-1-pclouds@gmail.com>
References: <20190317124926.17137-1-pclouds@gmail.com>
 <20190321131655.15249-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old name does not really say that this is about 'checkout -b'. See
49d833dc07 (Revert "checkout branch: prime cache-tree fully" -
2009-05-12) for more information
---
 t/{t2014-switch.sh => t2014-checkout-switch.sh} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/t/t2014-switch.sh b/t/t2014-checkout-switch.sh
similarity index 100%
rename from t/t2014-switch.sh
rename to t/t2014-checkout-switch.sh
-- 
2.21.0.548.gd3c7d92dc2

