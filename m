Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6697A1F453
	for <e@80x24.org>; Tue, 18 Sep 2018 13:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbeIRTRE (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 15:17:04 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:42169 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeIRTRE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 15:17:04 -0400
Received: by mail-pf1-f182.google.com with SMTP id l9-v6so1045892pff.9
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 06:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZHwOutL2FnlpK2b3AepCBG0hJaIE3OXjEdyh97IsnU0=;
        b=LEF3MlAKse5Qw0ZMA830ShoEB+p9f7FcEh8nAu7eGCz54wNaiWKnSLqFY4Uavsp+nr
         TEKLD417/wlcVe2nailCIzUGyt/TwuEmfZKeGMQI4DnyGS1gRfbFL6HU4ZfpK1l12eZ6
         0byIKZESOKQxBTkxNsZY6LyMo07AuT5Rsnj5MV423v5HRTLuGbt/7h+iwI5wcc1hIdP4
         iMsKz/NzWRaP7yGyNalFwscxcUqYxmSDd0QtgXMzb+KpEoiIPJ412uhuZotXHQzo/1Md
         RV/4eNAkoeVcB8gu7cF/VuS2Ra6bGRxHFvWKhXX4TkZeKL0765b6GFkc4SyYCIgNzImg
         GUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZHwOutL2FnlpK2b3AepCBG0hJaIE3OXjEdyh97IsnU0=;
        b=dh3udMYBUWXKAUDsgk5hRx4kopa9hR4kc6BxWKdrODUUXMTLxYlwWwB3AqDZik/q7w
         louiTyPOII/igDAbMSC3/0nmwLJkcUDvjKbLgitABF0JzfgABMsx7rHwWKWGMT/IGlwh
         ySVML9fJHUv3GaNDE2DxzEXOjUHBGM2qrH5y+u/UObe3iRPOUwzFe7o6aTn9AX70vVV7
         4QHh5pkwUmaFEO/neYyplj+mfWin7NklC9vAansstKEU6Jp2GA6UdPMIEeAP3ryAHLUy
         eZ0nZOJqyYVRKBeFjej3Rtbju75hDDKRk1aMJ3cwkI+99u2x13v6tDpH7Vf35BKK3ofH
         CtDw==
X-Gm-Message-State: APzg51CGcTsMd1yJHhyCKLYAfpQJsvy/NfUQJjCHS5GiPzhipuOqsWGj
        +/DIEwY7Ook3zY5JTnusAflk6pq2
X-Google-Smtp-Source: ANB0Vdaot/C69QD4ravSuu6LBIGd7Mc0c5ReT9R5kp1E75mTyM3mAWK44GY5IMJwJE0cposvPBKhzw==
X-Received: by 2002:a63:d645:: with SMTP id d5-v6mr28073191pgj.450.1537278263529;
        Tue, 18 Sep 2018 06:44:23 -0700 (PDT)
Received: from localhost.localdomain ([180.245.188.101])
        by smtp.gmail.com with ESMTPSA id i5-v6sm31600591pfe.140.2018.09.18.06.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 06:44:22 -0700 (PDT)
From:   Shulhan <m.shulhan@gmail.com>
To:     git@vger.kernel.org
Cc:     Shulhan <m.shulhan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Wink Saville <wink@saville.com>
Subject: [PATCH 0/1] git-rebase--interactive.sh: fix trailing spaces on empty $todo
Date:   Tue, 18 Sep 2018 20:44:10 +0700
Message-Id: <20180918134412.32766-1-m.shulhan@gmail.com>
X-Mailer: git-send-email 2.19.0.446.g26223adc4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For someone who use editor that display trailing white spaces, issuing
interactive rebase will print two empty lines at the end of rebase with the
last line contains tab,

  #	However, if you remove everything, the rebase will be aborted.
  #
  #\t
  # Note that empty commits are commented out

The character "\t" in above example is white space tab.

The "make test" was run succesfully but I can't reproduce/test manually with
non-empty $todo (I have no idea how to do it).

Shulhan (1):
  git-rebase--interactive.sh: fix trailing spaces on empty $todo

 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.19.0.446.g26223adc4

