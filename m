Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB00520248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfCQMuK (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:50:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39211 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMuK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:50:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id i20so9408325pfo.6
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HaZ3FmyRKKPnqsy962OiL3ByQMdKTWDTe177tuIQ6vY=;
        b=itbRTXByTAm1Xa84FQaWdmYegSmvh/Ldrqc21ZmJDFaXNAgFGfemzdT5q9q06/nji1
         RhrdLeA7VRt2IsX1333DmST1H9pabGolxkhlzHIBnnxJiR2IIYJCiI7i1I/EB3OQHjYa
         1aCEu2zJ4lJ/jJkteoWZIkvrg9abtoQ3cBsfLo7Ttl8ffxQsuGUPRHo0GTJoSPP7Hf23
         rqBVS43saJvTtYNWv5DXptkp9XFJGZlL+/HkFTot/vPk5TzkWoY9sph1XEhxIL50h3/Z
         SSRYyONK1qYvQmAKOutjfsS4fGKV3MaxYt/iLpGgXNzBrFMBeBHX8YwyNYkvy7FWEPCM
         PvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HaZ3FmyRKKPnqsy962OiL3ByQMdKTWDTe177tuIQ6vY=;
        b=K9X5UtEKp0oHjbuBZccp+yfJm9muj56Jq7YcQOsv+LBRsVSsADv9/ffYUVUagrlcl8
         utsBDfExqlGRImQktFcGXDG2k+UehBfDINJDcJPu+SqYGyjV6CCuXSHqmbRSIEyZbD9R
         lR/74MYl83TJ1SfZkauPRKmY/Uo5+7DxyVYRnV3CkUpF1E8AY+/yVl0x+ctOC7PCBqCc
         TnjXKAtImuyAYSxZHd/BFOycK14yZaQ807om7k1C2A0IjP3FBvQ0PAE+TFvig/SGGSXj
         8Zi4hPmooiWRwVdJlB5pBertahiH9+kDIu/iK8Vv0nYSHLsk9f0Ms5MAYqeWhd8ZWQ+o
         Vjyg==
X-Gm-Message-State: APjAAAUVHyBsuoRuUUC/xLNpdfU8JYrsV1i1H1lSwZAaBBBH3PvAOSRC
        Uy5oGGWlmaomkDpfhDryshA=
X-Google-Smtp-Source: APXvYqzKxfjh2JjHTd8yPvXC96RAHZxdeWK4fCcCr3OdMZvkLZFLTYIvbHSF0OywkpLDjHSHqNAstg==
X-Received: by 2002:a65:4204:: with SMTP id c4mr12970841pgq.136.1552827009864;
        Sun, 17 Mar 2019 05:50:09 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id z6sm32718304pgo.31.2019.03.17.05.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:50:09 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 19:50:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, phillip.wood123@gmail.com,
        rybak.a.v@gmail.com
Subject: [PATCH v4 05/26] t: rename t2014-switch.sh to t2014-checkout-switch.sh
Date:   Sun, 17 Mar 2019 19:49:05 +0700
Message-Id: <20190317124926.17137-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190317124926.17137-1-pclouds@gmail.com>
References: <20190308095752.8574-1-pclouds@gmail.com>
 <20190317124926.17137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old name does not really say that this is about 'checkout -b'. See
49d833dc07 (Revert "checkout branch: prime cache-tree fully" -
2009-05-12) for more information

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/{t2014-switch.sh => t2014-checkout-switch.sh} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/t/t2014-switch.sh b/t/t2014-checkout-switch.sh
similarity index 100%
rename from t/t2014-switch.sh
rename to t/t2014-checkout-switch.sh
-- 
2.21.0.548.gd3c7d92dc2

