Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80AEE1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 07:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390624AbfBOHuS (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 02:50:18 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42018 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfBOHuR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 02:50:17 -0500
Received: by mail-pf1-f194.google.com with SMTP id n74so4443393pfi.9
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 23:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EUpFbwtG1VL5zS4RqXf5ZOy6+PEFWF1/wTJNVaUoubU=;
        b=EXlTOmMm4Jlp8Dp7KIRrLuaq6sqfu9FQRNM4LdiDJ8zvXK+UR6fLM3yUDk8ErMNAZz
         d89AKXYI2XmIu0s6iMrMdcrKj27QDVL8i/aWRyRhp+A7f+5tmbqSzdXPAQ1yzcYgeO/T
         63XSUnu8R0oN7N8th3c0saejmXRgNx9rEjKnrxZ9w2G3bB6v30lVC3nbVscho++KRw/+
         GHqYn/8HekNjKPtN7XGRGfS53UuRuIgItOxloQz1Muvi3hz07s3LA080qYzg7hSS8e5w
         Lbmas9ZFjM5KMDjU3xLVaEXVqkD9wSSxpMAxnjZlwHQwDSYIJGI4M1eUgN8Nt6QnU87N
         IgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EUpFbwtG1VL5zS4RqXf5ZOy6+PEFWF1/wTJNVaUoubU=;
        b=oDRyJTv0yeykwQf7IG5P9eSAM6FWPpNzm7nbfQ3XkDBlnTuxfjlxYND2pNCZwq44+H
         hwTytJzN3cO7PXhXK9JX4KlW4zOgflWLbnlSIy9UD8LVzOo/K5f/Nhiu9P0pX0DvHBEn
         UDy6R0Pa7H74Rlat2Gt3pSHb/vuyJXYY06KpC9xG6Qs130pqpfpjRMEr3zu85LXXbwS/
         365nWhONJNxC3WWvWHEqmsJsZdEQrFG8GwCdEX8V0OA2oqS+N79upiu2aDBb6isp/5Dk
         mMALbyMv1YZQ08t1vy9vBvhwBBCUgTvQcD5hPursMvjJrBmtgEwkSbUtGDlqf2m2QqbJ
         ge2A==
X-Gm-Message-State: AHQUAubGabNIMpSxdYfprGI2OHkJX3sGTeQmEHdmiQxeJJQ11OGORRBm
        +2io/npdehrX3RNv4oVWafPiQxB8QYq38A==
X-Google-Smtp-Source: AHgI3IZ+mfCYDf4X2WuVkfNu12foAGixr33kqIkeY7devI629d6k2wQjR7DgkDmEzVrCHOWzVzAWFg==
X-Received: by 2002:a63:2209:: with SMTP id i9mr8034789pgi.325.1550217016958;
        Thu, 14 Feb 2019 23:50:16 -0800 (PST)
Received: from localhost.localdomain ([2408:84e1:43:c917:9dbb:5ce9:2c19:a70a])
        by smtp.gmail.com with ESMTPSA id l19sm8277628pfi.71.2019.02.14.23.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 23:50:15 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff for Git 2.21.0 round #2
Date:   Fri, 15 Feb 2019 15:49:57 +0800
Message-Id: <20190215074957.11667-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.38.ga5fda54cc5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.21.0-rc1 introduced 3 update messages from commit 32ceace39f
(Fix typos in translatable strings for v2.21.0, 2019-02-11).  let's start
new round of git l10n based on the following commit:

    l10n: git.pot: v2.21.0 round 2 (3 new, 3 removed)
    
    Introduce 3 update messages for v2.21.0 l10n round 2 from commit
    32ceace39f (Fix typos in translatable strings for v2.21.0, 2019-02-11).
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
