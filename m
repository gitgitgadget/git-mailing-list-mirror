Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFFF71F462
	for <e@80x24.org>; Fri,  7 Jun 2019 10:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfFGKIa (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 06:08:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45740 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfFGKI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 06:08:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id bi6so236649plb.12
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 03:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5D51w+ZW4xSta3P6nft67P0jTq26qUfPl7J+6IZ/SNo=;
        b=UUFQ1wFnTpzTblDqRoOnsGP4jjNfICO79KArsuLNDLv1eOZOSWjdXmqthhDIbuStV9
         vUZjBiT4xoXoUZfUpaPyndBBcrcPgqDUcK/xokys5xAHkOvSuiS/3G7C1Cu/bGjBQyW4
         tU0pZnIf2gK3lwEUPVrtzm018LJ63pG+Lb79hc+cXeZORbmvmjpz60ke8gk11c0Nc3Ju
         6Ew6y08Sq9Mp8QJYF4ek2WlIdVSKBx03KnEB8OX38OibRCaetk9xYluBBmcBvEoYnLV1
         4R2el/JqSbJ1kk6TvhJQQv3kZpzfly2WbMj0uIaIMDfAzTRn3zHKrp47KJs6ECFeNZuo
         oiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5D51w+ZW4xSta3P6nft67P0jTq26qUfPl7J+6IZ/SNo=;
        b=C+pMWx3jEMy7V9BSb3l7NfvZkGju/COzFbn57XNWCkeMni4fW5rRes3Ajl7OZcj6hp
         5rqIYDoYOVFJI0ji4zYspk/9POxvZUxpwrDb4Db8ALFWELuN29PmmRR0qq3ERnqZPdhz
         dDf05DNpUnFksZ9RG/qG5wz3Ij4nt8b54yV+Z9J4OVSEBrFfIJiu+5LZ2dKiNJM3QBlM
         2GR0fK7xtzwVVvmQNi2ucqAb2QCXmePcjL6cF7mK/g3k1VKL2mscd0LWGjnFp59DjLQ5
         obitb2yCHOL1EoElUb1fllJPweQLX3Eh+dHrVdLjPnVp9MUmi728eqRAyITjaayRDi83
         QvGw==
X-Gm-Message-State: APjAAAUfulj389IA8qWQRVTeEVW6y2dfC3QZUOpudlk49P1jP77c3Q9e
        /wxl7Od/WD82RX551WYMqBnMl8IWn6NAdA==
X-Google-Smtp-Source: APXvYqxg+KtxYL+PjzIxUCt77FFN5ABkGAFdMryVyhq8etBY4cvivFhiifx+xp+FYK+iSQWJiWyJZw==
X-Received: by 2002:a17:902:903:: with SMTP id 3mr28976962plm.281.1559902108644;
        Fri, 07 Jun 2019 03:08:28 -0700 (PDT)
Received: from localhost.localdomain ([2408:84e1:60:d401:65c5:bc73:cd52:9a5c])
        by smtp.gmail.com with ESMTPSA id g17sm1926545pfb.56.2019.06.07.03.08.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 03:08:27 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        =?UTF-8?q?C=C3=A9dric=20Malard?= <c.malard-git@valdun.net>,
        Christopher Diaz Riveros <chrisadr@gentoo.org>,
        Fangyi Zhou <me@fangyi.io>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Tran Ngoc Quan <vnwildman@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: [GIT PULL] l10n updates for 2.22.0 round 3
Date:   Fri,  7 Jun 2019 18:08:12 +0800
Message-Id: <20190607100812.24413-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.22.0.rc2.14.g03eb6640cb.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the following l10n updates for Git 2.22.0.

The following changes since commit 74583d89127e21255c12dd3c8a3bf60b497d7d03:

  Git 2.22-rc3 (2019-06-03 11:25:12 -0700)

are available in the Git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.22.0-rnd3

for you to fetch changes up to 0cdb8d2db2f39d1a29636975168c457d2dc0d466:

  Merge branch 'fr_review' of git://github.com/jnavila/git (2019-06-07 16:51:09 +0800)

----------------------------------------------------------------
l10n-2.22.0-rnd3

----------------------------------------------------------------
Alessandro Menti (1):
      l10n: it.po: Updated Italian translation

Alexander Shopov (3):
      l10n: bg.po: Updated Bulgarian translation (4577t)
      l10n: bg.po: Updated Bulgarian translation (4580t)
      l10n: bg.po: Updated Bulgarian translation (4581t)

Christopher Díaz Riveros (3):
      l10n: es: 2.22.0 round 1
      l10n: es: 2.22.0 round 2
      l10n: es: 2.22.0 round 3

Cédric Malard (1):
      l10n: fr.po: Review French translation

Fangyi Zhou (1):
      l10n: zh_CN: Revision for git v2.22.0 l10n

Jean-Noël Avila (3):
      l10n: fr.po v2.22.0.rnd1
      l10n: fr.po v2.22.0 round 2
      l10n: fr v2.22.0 rnd 3

Jiang Xin (15):
      l10n: git.pot: v2.22.0 round 1 (270 new, 56 removed)
      Merge branch 'master' of https://github.com/vnwildman/git
      Merge branch 'master' of git://github.com/alshopov/git-po
      Merge branch 'master' of https://github.com/Softcatala/git-po
      Merge branch 'master' of git://git.kernel.org/pub/scm/git/git
      l10n: git.pot: v2.22.0 round 2 (6 new, 3 removed)
      Merge branch 'master' of git://github.com/alshopov/git-po
      Merge branch 'master' of https://github.com/vnwildman/git
      Merge branch 'master' of git://git.kernel.org/pub/scm/git/git
      l10n: git.pot: v2.22.0 round 3 (3 new, 2 removed)
      Merge branch 'it-l10n-wip' of github.com:AlessandroMenti/git-po
      Merge branch '2.22' of https://github.com/ChrisADR/git-po
      l10n: zh_CN: for git v2.22.0 l10n round 1~3
      Merge branch 'master' of git://github.com/alshopov/git-po
      Merge branch 'fr_review' of git://github.com/jnavila/git

Jordi Mas (1):
      l10n: Update Catalan translation

Matthias Rüster (2):
      l10n: TEAMS: Change German translation team leader
      l10n: de.po: Update German translation

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation
      l10n: sv.po: Update Swedish translation (4577t0f0u)

Ralf Thielow (1):
      l10n: de.po: improve description of 'git reset --quiet'

Trần Ngọc Quân (3):
      l10n: vi.po(4577t): Updated Vietnamese translation for v2.22.0 round 1
      l10n: vi.po(4580t): Updated Vietnamese translation for v2.22.0 round 2
      l10n: vi.po(4581t): Updated Vietnamese translation for v2.22.0 round 3

 po/TEAMS    |     8 +-
 po/bg.po    |  7688 ++++++++++++++++++++++------------------
 po/ca.po    |  8989 ++++++++++++++++++++++++-----------------------
 po/de.po    |  7399 ++++++++++++++++++++++-----------------
 po/es.po    |  7336 +++++++++++++++++++++-----------------
 po/fr.po    |  7702 ++++++++++++++++++++++------------------
 po/git.pot  |  7415 ++++++++++++++++++++++-----------------
 po/it.po    | 11094 ++++++++++++++++++++++++++++++++--------------------------
 po/sv.po    |  7229 ++++++++++++++++++++++----------------
 po/vi.po    |  7342 +++++++++++++++++++++-----------------
 po/zh_CN.po |  7143 +++++++++++++++++++++----------------
 11 files changed, 44506 insertions(+), 34839 deletions(-)

--
Jiang Xin
