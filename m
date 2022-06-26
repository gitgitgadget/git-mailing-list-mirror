Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A12C43334
	for <git@archiver.kernel.org>; Sun, 26 Jun 2022 12:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiFZM5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jun 2022 08:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbiFZM5S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jun 2022 08:57:18 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9EB1057C
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 05:57:16 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q18so5915556pld.13
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 05:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OyA7fSDMwIDNU1IadCpUYHXFMVuP81XxPCU94TG9Kyg=;
        b=NrtesgA16MY+89Z/zkjN2UkT9Ra3N582nLgmZ/6ai45+xZayqV0g4woK8scvgjJfg0
         yUG0LbVOO/g4SelAYYCY66dJ2DQPYgw7zixeR5L4zGqjB0FwCdurfKZZw3gYky4hSqkI
         CvArHHxq/E7chizrylXLlcfHJxAZ/tFSk3ixsuT2Tnsu1v7lmahniu9hJ/MCmKP8UuK+
         JEfeCHV42Ledxd9UBoAtL1wfMJEbL7RecTzy/gr99Pd7vx+mFgu6Ldvlt/ZtRmi/VtoW
         3ul+NO8oWcEj9ae+brFEmHnnBEubvqFfkE6THBQv6EVHg1FTa89LoBcIx1uRGBPmamOn
         Q2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OyA7fSDMwIDNU1IadCpUYHXFMVuP81XxPCU94TG9Kyg=;
        b=kIIzy5UrMwJFsL31o3e54zvtiosMTj/opdVYzTCHlmz7DNurCgSKQPr1YloNfe92uN
         neeUrewkNY2mzGNbWEJT4zECOyjKi2mosbgy0VJRt1sPlPEkK9tliddxYrfXr/k2bMcH
         fXU98qSy3k+KX8P7KNpflutY4gCvKx+cDRiE0Whly4SU7tqoBuc92ERhgP2pP5+4/Q/D
         7+FuvVbE7lrTxni8J6vUsmJtWcvWp91EX9+BHmjUCh6PKm25WdCjG7yTVHS0JYBq7VAt
         KuGRAr1/bXP9CauACzPNWHbKa9SztZj9eNtJwRlRaHX2iWHDhlX9h9EaBfxPDTZpQ2DA
         tonw==
X-Gm-Message-State: AJIora+vzgO8imvIcso2uLGH1DQhGcWqS0fcPSCAsyBBWKVczhewSvRy
        rla7HxQlmSY+ageJj6eMOTs=
X-Google-Smtp-Source: AGRyM1v7kim2dGLxWMXS4O50cBAIZLHKMoMe1uuJ5hQNOmqxoNyAYSHZEW1/CXmYBvqmeRKrFu0uHg==
X-Received: by 2002:a17:90b:388f:b0:1ed:3b:6c64 with SMTP id mu15-20020a17090b388f00b001ed003b6c64mr9953126pjb.34.1656248235389;
        Sun, 26 Jun 2022 05:57:15 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 200-20020a6214d1000000b00524f29903e0sm5202320pfu.56.2022.06.26.05.57.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jun 2022 05:57:14 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Git l10n discussion group <git-l10n@googlegroups.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Arthur Milchior <arthur@milchior.fr>, Arusekk <arek_koz@o2.pl>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>,
        Emir SARI <bitigchi@me.com>, Emir SARI <emir_sari@icloud.com>,
        Fangyi Zhou <me@fangyi.io>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Tran Ngoc Quan <vnwildman@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: [GIT PULL] l10n updates for 2.37.0 round 1
Date:   Sun, 26 Jun 2022 20:57:11 +0800
Message-Id: <20220626125711.14184-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the following l10n updates for Git 2.37.0.

The following changes since commit ddbc07872e86265dc30aefa5f4d881f762120044:

  Merge branch 'jp/prompt-clear-before-upstream-mark' (2022-06-21 10:07:50 -0700)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.37.0-rnd1

for you to fetch changes up to 71e3a31e40203e3ac9cc4bf5d5cac943963f1e8f:

  l10n: sv.po: Update Swedish translation (5367t0f0u) (2022-06-26 20:38:46 +0800)

----------------------------------------------------------------
l10n-2.37.0-rnd1

----------------------------------------------------------------
Alex Henrie (1):
      l10n: es: update translation

Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5367t)

Arthur Milchior (1):
      l10n: README: fix typo

Bagas Sanjaya (1):
      l10n: po-id for 2.37 (first batch)

Dimitriy Ryazantcev (1):
      l10n: ru.po: update Russian translation

Emir SARI (1):
      l10n: tr: v2.37.0 round #1

Fangyi Zhou (1):
      l10n: zh_CN: v2.37.0 round 1

Jean-Noël Avila (1):
      l10n: fr v2.37 round 1

Jiang Xin (9):
      Merge branch 'master' of github.com:git/git
      Merge branch 'master' of github.com:git/git
      Merge branch 'master' of github.com:git/git
      Merge branch 'fz/po-zh_CN' of github.com:fangyi-zhou/git-po
      Merge branch 'master' of github.com:alshopov/git-po
      Merge branch 'master' of github.com:ruester/git-po-de
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'master' of github.com:vnwildman/git
      Merge branch 'l10n/zh_TW/220623' of github.com:l10n-tw/git-po

Jordi Mas (1):
      l10n: Update Catalan translation

Matthias Rüster (2):
      l10n: de.po: Update German translation
      l10n: TEAMS: Change German translation team leader

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (5367t0f0u)

Trần Ngọc Quân (1):
      l10n: vi(5367t): Updated translation

Yi-Jyun Pan (1):
      l10n: zh_TW: v2.37.0 round 1

 po/README.md |     2 +-
 po/TEAMS     |     6 +-
 po/bg.po     | 33320 +++++++++++++++++++++---------------------------
 po/ca.po     | 33216 +++++++++++++++++++++---------------------------
 po/de.po     | 33153 +++++++++++++++++++++---------------------------
 po/es.po     | 33388 +++++++++++++++++++++---------------------------
 po/fr.po     | 34143 +++++++++++++++++++++-----------------------------
 po/id.po     | 36543 ++++++++++++++++++++++++++---------------------------
 po/ru.po     | 29500 ++++++++++++++++++++-----------------------
 po/sv.po     | 36191 +++++++++++++++++++++-------------------------------
 po/tr.po     | 32149 ++++++++++++++++++++---------------------------
 po/vi.po     | 32438 ++++++++++++++++++++---------------------------
 po/zh_CN.po  | 36898 ++++++++++++++++++++++++++---------------------------
 po/zh_TW.po  | 38987 ++++++++++++++++++++++++++++-----------------------------
 14 files changed, 181442 insertions(+), 228492 deletions(-)

--
Jiang Xin
