Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22F2F1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 03:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfG3Dfb (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 23:35:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34641 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfG3Dfa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 23:35:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so29069374pfo.1
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 20:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0iZAKnoe3/XOfc/gVZY/ixEagTotV7suGEYd6AvlPrg=;
        b=NKlM19+dvN0GAvZoKCIrXznp52E71sXby0BNwNrryP5kupacMgEZma136to2vrEyQV
         MYlUfgZ4GJxCnYLKPpTQrNd8/rbpgZV90uGMRXLd2tXtRk9oPh2MImK68fr1370S2t1W
         lQSGEroL2r07coe6SGZC2/nwD0fAVkrI4m94r43owmV1ehF+AsmgZYOBaw7SYrj48Bw5
         UcKR30eduPdHo6BOHZh3olIQG1h1OWGVQF1b+ziN2cgx2WwzWTt7c52cZSZ520DTJbi1
         gaQqY9h5j8FTbYraOBG8N4s1/6tXBuBUFd4VXMXscqrbZilcG1aJKvZROWJwWPPx+o54
         WqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0iZAKnoe3/XOfc/gVZY/ixEagTotV7suGEYd6AvlPrg=;
        b=pxHipsaXdyo1MPPsdNtdvMI0lVFX08JD0Rvm+LiVzFuebK3yN7MDSZXmA6qQxZA5PV
         H8RoluEEojbRj/6FuisIcl+e7f74L1Tv8uJdA3S281whBffvnVbFuSdd6/fEQvIME+a0
         RV2t6hL3J/e/D+/KUvzNpnLbtikFYmCw4V+6vVL1jTLVI4bWOMBUX/NLdZnX7TxzD2D7
         MCak/td4kd51FcGrJnEqzqPDdHtWV8hvTYN+Q4sgX2ubaJUKRDMDygk5y72LQVtJXWYf
         A+b9kuH8cnrsjbCOeAUZNQXY4ftv4nrwa/jtEjpGfPFJeprFxKqz7KqacTY9IB4MuX//
         RZ1Q==
X-Gm-Message-State: APjAAAXQL+//S1mqiSTffWne48CbTuNI5YvvoeY2cJZtY1SiCxZXXfTz
        V+WUGX+VLRotl8mxzpcoOLNOSFxJueupTQ==
X-Google-Smtp-Source: APXvYqxZDvat8sNYLPqBagVNFuLfYFG3O2PTsic1h5vgbJSb7bUBt40+vAQ3OBGtUaU9llTACH49SQ==
X-Received: by 2002:aa7:9713:: with SMTP id a19mr21851603pfg.64.1564457729976;
        Mon, 29 Jul 2019 20:35:29 -0700 (PDT)
Received: from localhost.localdomain ([2408:84e1:127:d445:e497:ab85:3e79:1772])
        by smtp.gmail.com with ESMTPSA id h1sm79914780pfg.55.2019.07.29.20.35.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 20:35:29 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff for Git 2.23.0 round #1
Date:   Tue, 30 Jul 2019 11:35:12 +0800
Message-Id: <20190730033512.7226-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.22.0.2.g659c9b496c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.23.0-rc0 has been released, and it's time to start new round of git
l10n. This time there are 130 updated messages need to be translated since
last update:

    l10n: git.pot: v2.23.0 round 1 (130 new, 35 removed)
    
    Generate po/git.pot from v2.23.0-rc0 for git v2.23.0 l10n round 1.
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
