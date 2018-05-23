Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF5B51F42D
	for <e@80x24.org>; Wed, 23 May 2018 22:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934921AbeEWWUi (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 18:20:38 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:36321 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934666AbeEWWUe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 18:20:34 -0400
Received: by mail-wr0-f174.google.com with SMTP id k5-v6so17137121wrn.3
        for <git@vger.kernel.org>; Wed, 23 May 2018 15:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EpeLmyjykkVbkVLwcMMc/Y05Ec6iwHp0/lcYSKLsfFw=;
        b=Nv+VX/88+XefvXfKUzjYYpAm7iavbpaRBQ+B+IGMkFNvxUSWoMy7PdUla7Q1qZmK69
         84J3eMsedFeyHlZV6wtgIotzJ42CJ4iciTN0PFbpAr5T8jHrsCQ4NYDhFzZt+xRt3IUp
         kmI2J8Gif02jnIg6tvlXjmn3hKXWVkRRJJwmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EpeLmyjykkVbkVLwcMMc/Y05Ec6iwHp0/lcYSKLsfFw=;
        b=CIMuH7+PqrCuMkB2fUPe9eclRq6YAWaAcKhEam5b/ZXkIh4b1XpXDPtYQDzJeoXQDh
         oj5eWFoToPdTHIh6Mn5rhSMkuS7T1rhN1rgV+5BZqqasCc2HdP8rfBKKRWIS3wX/jLZV
         DdEVKNKrh6COwjWEvPWaSZ5gThaA3OALbAawx6cu+3Nt119VxjQcLG156VSYX2r5oBQO
         Ls7sarfE//9tfiLkVciT2RytzzD3fqluFN3/FmKePrfd+iYbmnxGHLCK/x6jN0JW988N
         1jXMXop0oWKePRFzLHdFD1n+ve3U6tjfhBS32xzaNvsS1zSIS5wd9wobYxrjh6jmIggQ
         Xv0A==
X-Gm-Message-State: ALKqPwdA2gGWMJPomM9RBTi072q3sVrsddlA3OmpZTjLDUgE5oydUkj2
        FlvNQnEdJOccTUciY1GaMIRzBubDbLY=
X-Google-Smtp-Source: AB8JxZo0+pOOa9uRrIk3OPk3XAwe6ozZhiLhLPiYqhZZRbRG0UM3nBo6RJHxfqZ3n7cKFQUehGr2Cg==
X-Received: by 2002:adf:a789:: with SMTP id j9-v6mr3683070wrc.95.1527114033079;
        Wed, 23 May 2018 15:20:33 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id q2-v6sm20858994wrm.26.2018.05.23.15.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 May 2018 15:20:31 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Andrey Mazo <amazo@checkvideo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv6 0/1] git-p4: unshelve
Date:   Wed, 23 May 2018 23:20:25 +0100
Message-Id: <20180523222026.6609-1-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This just removes the verbose print change, which will end up causing
conflicts later since it's also being fixed in another commit.

Discussed here:

https://public-inbox.org/git/BYAPR08MB38455AFE85AE6B04EB31EF92DA6B0@BYAPR08MB3845.namprd08.prod.outlook.com/

Luke Diamand (1):
  git-p4: add unshelve command

 Documentation/git-p4.txt |  32 ++++++
 git-p4.py                | 213 ++++++++++++++++++++++++++++++++-------
 t/t9832-unshelve.sh      | 138 +++++++++++++++++++++++++
 3 files changed, 347 insertions(+), 36 deletions(-)
 create mode 100755 t/t9832-unshelve.sh

-- 
2.17.0.392.gdeb1a6e9b7

