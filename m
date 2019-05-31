Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BFB71F462
	for <e@80x24.org>; Fri, 31 May 2019 06:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfEaGrI (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 02:47:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35235 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaGrI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 02:47:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id n14so8163697otk.2
        for <git@vger.kernel.org>; Thu, 30 May 2019 23:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ISV5il3ppBoyc7W3kxhiiBHxO7gtqAyWtFoMdPm9XFY=;
        b=Re6TOVipsgLfQIqveD3MhvyfOUEJ1ToZElJv7R5rNkLb+xU4ttoQNe79Z29o5Lik9Y
         P1p+qhZc3PodYl9e00crTVQy3jtBhbcfy5Ketq/Br4FgNOIzNRnCK/v08AbhMnIXqsR0
         heRSD6orzuIY7U6mo+g20XN3cVk/T+PMyhRkcXgfv2yteQKep2iHzGxJCvy3XZwx9vHJ
         maFCJsbzfjgZ/ZE+v0beADpA0I/eU670KhxKv+CGi+kT5CRCDBHxBWVKtvCOPyoPsFjo
         Eem4fDWMiFbTm4sxTSksol/P8iqqEidgcexMg9Bk+MQudMY9Nly/wUhK4xIc12mPddCz
         2QBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ISV5il3ppBoyc7W3kxhiiBHxO7gtqAyWtFoMdPm9XFY=;
        b=Syv78iGaPjOJVa5tW3eDlCsH2cUw9uo4douu1QxSJA3apQ+BjnQMK0mrwgAwdDIHPZ
         4w+MzPpgPMuw84gU31IfGp0n3Wd4ufWiie3kf6hym6bADtKXA0Dok/MIP6zKA6hNEcfs
         /tT/fcp340cM1M4tDBFIpk0PkgCY/cC/TpIHXPzTCpqSm/H7UhMpmhhLw3903UYMJsrh
         xvU8YRmHFYmNSImYuis4bxnFoiSPf3J0l1uffRtfeKG/zNX7zaMvI9w89s6d7C5dlRJH
         z0vx8fRR0+N6bhkhbCEKHs5iYnOp2jlkIRWrLlfvCSk+LoETyEVTG/6TaJ2HZU12Rkml
         yW0w==
X-Gm-Message-State: APjAAAXM1KOM1FHz98SxsFyYgnY/1GtHM91saCKP9PKdLO2w0DauQZi0
        LZI/RSXJvaarNHjZbFEQv+xT8oplqeJ61w==
X-Google-Smtp-Source: APXvYqzeD1l2FZUg5nWy2TUZ0qf/GlsSOWTt/VE0MGHsaXVoxO/ImSODsIANr4t7bCBQivxZYDrSWg==
X-Received: by 2002:a9d:4f0f:: with SMTP id d15mr349942otl.52.1559285227262;
        Thu, 30 May 2019 23:47:07 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.26])
        by smtp.gmail.com with ESMTPSA id s110sm1945156otb.34.2019.05.30.23.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 23:47:06 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
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
Subject: [L10N] Kickoff for Git 2.22.0 round #2
Date:   Fri, 31 May 2019 14:46:52 +0800
Message-Id: <20190531064652.18837-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.21.0.3.g3ece05c5f4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.22.0-rc2 introduced 6 update messages, and let's start new round of git
l10n based on the following commit:

    l10n: git.pot: v2.22.0 round 2 (6 new, 3 removed)
    
    Generate po/git.pot from v2.22.0-rc2 for git v2.22.0 l10n round 2.
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
