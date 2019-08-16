Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 448571F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 09:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfHPJRX (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 05:17:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41905 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfHPJRW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 05:17:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so2649635pgg.8
        for <git@vger.kernel.org>; Fri, 16 Aug 2019 02:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4vJgHKBimwwzIVCZSpLAq+Y7Kshiqwh08DKvSY0teYI=;
        b=caiWPnswUe4wA8U89x9J4BsefagXxG5mePDls8lr33lqLzVduu75srtYVaZaCVl+re
         75esRwnIKSXCu3UbTgdLQVf/Aw0Cl1qvADLZNaRPI2Wd07sx32A4vQvkG2jPcyO94l99
         wMfT7omsiZ99UhaCaWPRMKwGIdfH5ajF61vtdo6XcQspWEjUyZ2F6yc4Zp/AD71RTpuj
         yU4EFpbBLKD7XYE1tZw34f8EOUMXriO8THZ1G/HQsRWATzY6AQ1V5qsBsFXy9tSWGypX
         M0jyKfttAvIJ5ab97LXb4R3sgYihk18HZkwGSUa2FcIV1mb+3Z04kIFEZtDdIF8h09/F
         MyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4vJgHKBimwwzIVCZSpLAq+Y7Kshiqwh08DKvSY0teYI=;
        b=jy1oRzfkg70LGm8OYdGrtmlIeWCmPO7yIsRWcY1U3mtEu/X4S4c6QfMnhpogZMt7uj
         jGOPCbQsqgjBnPoa8Zj53XYhznpG+1UwzTyQsVxAuE7fRFBdXwdNSIGX0j8c1IUVjeek
         n5L9rcQtTKNBA5DKqHmBjKcoBDREH9UZdhPvbShG/3mhDt9llDK5M+Z84QHQr2ynj+yk
         LGKPMQo/DNV2g1QtYpmfNiw0u4ph75/2Wx+AqUeBlOSLuwQbyaOsy+ocdiOYntOjS3Tt
         BfyXLYvFrCyZl1QyUJGRLeHjCYhyIbbvdUvno2FLm1aFIMliRtYQzveVUvgCytvXEIOL
         sqzw==
X-Gm-Message-State: APjAAAULuoTTQbNQ7iex4u6xlES3a1w5YaBDsD6XnlRt8DVIsotY62hw
        EzHz8mWQ/tIjNNIfKElsYKA=
X-Google-Smtp-Source: APXvYqxoSlz6P7fzE0eJxYAtNCwXri+3QJJT2sQPdSkocvRNGuwe0bxk7RbjiMuPPXCA6g4g31XZuA==
X-Received: by 2002:aa7:9e0a:: with SMTP id y10mr9692732pfq.93.1565947042270;
        Fri, 16 Aug 2019 02:17:22 -0700 (PDT)
Received: from localhost.localdomain ([2408:84e1:64:421d:25ba:428d:c223:7d41])
        by smtp.gmail.com with ESMTPSA id h195sm7623427pfe.20.2019.08.16.02.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 02:17:21 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Carmine Zaccagnino <carmine@carminezacc.com>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Christopher Diaz Riveros <chrisadr@gentoo.org>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias Ruester <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?q?Philipp=20Wei=C3=9Fmann?= <mail@philipp-weissmann.de>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [GIT PULL] l10n updates for 2.23.0 round 2
Date:   Fri, 16 Aug 2019 17:16:36 +0800
Message-Id: <20190816091636.2846-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.26.g2046ddf5e5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the following l10n updates for Git 2.23.0.

The following changes since commit 2e27de94d485a6da0c8e264c165e55100f1a13a8:

  Git 2.23-rc2 (2019-08-09 10:15:39 -0700)

are available in the Git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.23.0-rnd2

for you to fetch changes up to a6cd2cc485b9ba73934a059245aa9de7e68a2d4c:

  l10n: zh_CN: for git v2.23.0 l10n round 1~2 (2019-08-16 16:59:17 +0800)

----------------------------------------------------------------
l10n-2.23.0-rnd2

----------------------------------------------------------------
Alessandro Menti (3):
      l10n: it.po: update the Italian translation
      l10n: it.po: update the Italian translation for v2.23.0
      l10n: it.po: update the Italian localization for v2.23.0 round 2

Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (4674t)

Carmine Zaccagnino (1):
      l10n: it.po: remove an extra space

Christopher Díaz Riveros (1):
      l10n: es: 2.23.0 round 2

Dimitriy Ryazantcev (1):
      l10n: ru.po: update Russian translation

Jean-Noël Avila (1):
      l10n: fr v2.23.0 round 2

Jiang Xin (11):
      Merge branch 'master' of https://github.com/Softcatala/git-po
      Merge tag 'v2.23.0-rc0' of git://git.kernel.org/pub/scm/git/git
      l10n: git.pot: v2.23.0 round 1 (130 new, 35 removed)
      Merge branch 'update-italian-translation' of github.com:AlessandroMenti/git-po
      Merge branch 'master' of https://github.com/Softcatala/git-po
      Merge tag 'v2.23.0-rc2' of git://git.kernel.org/pub/scm/git/git
      l10n: git.pot: v2.23.0 round 2 (4 new, 6 removed)
      Merge branch 'next' of https://github.com/ChrisADR/git-po
      Merge branch 'update-italian-translation' of github.com:AlessandroMenti/git-po
      Merge branch 'master' of https://github.com/vnwildman/git
      l10n: zh_CN: for git v2.23.0 l10n round 1~2

Jordi Mas (2):
      l10n: Update Catalan translation
      l10n: Update Catalan translation

Matthias Rüster (1):
      l10n: de.po: Update German translation

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (4676t0f0u)

Philipp Weißmann (1):
      l10n: de.po: Fix typo in German translation

Trần Ngọc Quân (2):
      l10n: vi.po (4676t): Updated Vietnamese translation
      l10n: vi(4674t): Updated translation for Vietnamese

 po/bg.po    |  6418 ++++++++--------
 po/ca.po    | 11579 +++++++++++++++++------------
 po/de.po    |  6445 ++++++++--------
 po/es.po    |  6628 +++++++++--------
 po/fr.po    |  6333 ++++++++--------
 po/git.pot  |  6200 ++++++++--------
 po/it.po    |  8426 +++++++++++----------
 po/ru.po    | 23280 +++++++++++++++++++++++++++++++++-------------------------
 po/sv.po    |  6565 +++++++++--------
 po/vi.po    |  6847 +++++++++--------
 po/zh_CN.po |  6323 ++++++++--------
 11 files changed, 52890 insertions(+), 42154 deletions(-)

--
Jiang Xin
