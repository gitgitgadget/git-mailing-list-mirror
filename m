Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232FEC433EF
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 12:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0588D610A8
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 12:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhKNMc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 07:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbhKNMc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 07:32:56 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91020C061746
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 04:29:56 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so10691001pjb.5
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 04:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zGBEHymChBI3FMIb0tp2xTuDk8i+5o3lVXNO09E0Yko=;
        b=N/VcWOi5W1SBSBjrPr2CxRCa6D5xQYbSr/MEra0F55S9cNyJ2vjqgYRkG6TGFhoWnQ
         w05u2B0u44kxtX8UTS6AaEI3BrvGWX5BUSM8MSgXExoPlEKhYcm4UWxVi2L9K5xX53CR
         MaqjSTHZEowu0/GD5GjRjZO6eC5GEL5lQUvS2B/SfVFdMEppMPOp0gqRjnJNNO1XJkYn
         +HYKV+cAlFhZoPucg+xMF7kcbDPunPsEvsKT7XuHmUPZ0lWBRpjbn/3r01owtQaJBJ6S
         q0XRB1uOoWK4O6g7lJwgCTBHkKnVuXl/uYF1AnNo2yhX35Ffi0fXhwPzwJcvdkOqbpgA
         dlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zGBEHymChBI3FMIb0tp2xTuDk8i+5o3lVXNO09E0Yko=;
        b=YP5bHD4rs3O0N383zvd/aUCohxPHKjI4Wb/E1IT8DAL8bCCnC7dY5ajuQxW+oAY8tl
         61Kyc+G0MeKnrgrjx4iXEofq+Q3awCa2OBAkXOyqXx0hPJbOlqKAttVo/fH/rvKXx6zq
         +klLSvaSQUfmxY8O5mnJ+nQaI5HVrEYOy90EOib27Hffnn/7OWbShSayO5CNAOGu3fQx
         DcTk858by/KWBX9VodRkglnWqzpwvPdXI5TBgmxhUWyIjUU3y5Pb77EHfsUyChRFNKeQ
         dGEMibvOd5pi4Cl6DN1OWp62OHS2rtj8eI//YMfHc9H5ArH1fQcvWR5YfYjLKQf+EZi2
         6EGg==
X-Gm-Message-State: AOAM5313Avr1YNiygaCaKZXT73j/2GidsfHEFklrHxru37bGziV0Jvvj
        Tnxc4DmGAyXrIctEeQClkwg=
X-Google-Smtp-Source: ABdhPJxNHuFcAZ75xjiA5OIeHTzWBquAQjOlKcCML7vxmvGxFlWQpshCVhSSQCSVgMQZCu8p2/jlsA==
X-Received: by 2002:a17:90a:c297:: with SMTP id f23mr54826501pjt.138.1636892996047;
        Sun, 14 Nov 2021 04:29:56 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y18sm9485843pgh.18.2021.11.14.04.29.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Nov 2021 04:29:55 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Git l10n discussion group <git-l10n@googlegroups.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <daniel@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: [GIT PULL] l10n updates for 2.34.0 round 3
Date:   Sun, 14 Nov 2021 20:29:52 +0800
Message-Id: <20211114122952.11564-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the following l10n updates for Git 2.34.0.

The following changes since commit 6c220937e2b26d85920bf2d38ff2464a0d57fd6b:

  Git 2.34-rc2 (2021-11-09 13:19:51 -0800)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.34.0-rnd3

for you to fetch changes up to 5a0724ad3ec51d8f75cf139c4d82dbcf55766b9d:

  l10n: it: fix typos found by git-po-helper (2021-11-14 19:40:41 +0800)

----------------------------------------------------------------
l10n-2.34.0-rnd3

----------------------------------------------------------------
Alexander Shopov (3):
      l10n: bg.po: Updated Bulgarian translation (5230t)
      l10n: bg.po: Updated Bulgarian translation (5210t)
      l10n: bg.po: Updated Bulgarian translation (5211t)

Arusekk (2):
      l10n: pl: Update translation
      l10n: pl: 2.34.0 round 2

Bagas Sanjaya (3):
      l10n: po-id for 2.34 (round 1)
      l10n: po-id for 2.34 (round 2)
      l10n: po-id for 2.34 (round 3)

Christopher Diaz Riveros (1):
      l10n: es: 2.34.0 round 2

Daniel Santos (3):
      l10n: pt_PT: update translation table
      l10n: pt_PT: change email
      l10n: pt_PT: cleaning duplicate translations (#2)

Emir Sarı (3):
      l10n: tr: v2.34.0 round 1
      l10n: tr: v2.34.0 round 2
      l10n: tr: v2.34.0 round 3

Fangyi Zhou (3):
      l10n: zh-CN: v2.34.0 round 1
      l10n: zh_CN: 2.34.0 Round 2
      l10n: zh_CN: v2.34.0 round 3

Jean-Noël Avila (3):
      l10n: fr v2.34.0 rnd1
      l10n: fr: v2.34.0 round 2
      l10n: fr: v2.34.0 rnd 3

Jiang Xin (23):
      Merge branch 'new-mail' of github.com:git-l10n-pt-PT/git-po
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'master' of github.com:git/git
      l10n: git.pot: v2.34.0 round 1 (134 new, 154 removed)
      Merge branch 'fr_2.34.0_rnd1' of github.com:jnavila/git
      Merge branch 'fz/po-zh_CN' of github.com:fangyi-zhou/git-po
      Merge branch 'master' of github.com:git/git
      l10n: git.pot: v2.34.0 round 2 (3 new, 3 removed)
      Merge branch 'fz/po-zh_CN' of github.com:fangyi-zhou/git-po
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'l10n/zh_TW/211104' of github.com:l10n-tw/git-po
      Merge branch 'pt-PT' of github.com:git-l10n-pt-PT/git-po
      Merge branch 'master' of github.com:git/git
      l10n: git.pot: v2.34.0 round 3 (1 new)
      Merge branch 'master' of github.com:alshopov/git-po
      Merge branch 'tr-2-34-r3' of github.com:bitigchi/git-po
      Merge branch 'fr_v2.34.0_rnd3' of github.com:jnavila/git
      Merge branch 'l10n/zh_TW/211111' of github.com:l10n-tw/git-po
      Merge branch 'master' of github.com:ruester/git-po-de
      Merge branch 'po-id' of github.com:bagasme/git-po
      l10n: ko: fix typos found by git-po-helper
      l10n: it: fix typos found by git-po-helper

Jordi Mas (3):
      l10n: Update Catalan translation
      l10n: Update Catalan translation
      l10n: Update Catalan translation

Matthias Rüster (1):
      l10n: de.po: Update German translation for Git v2.34.0

Peter Krefting (3):
      l10n: sv.po: Fix git-po-helper breakage
      l10n: sv.po: Update Swedish translation (5210t0f0u)
      l10n: sv.po: Update Swedish translation (5211t0f0)

Trần Ngọc Quân (2):
      l10n: vi(5210t): Translation for v2.34.0 rd2
      l10n: vi(5211t): Translation for v2.34.0 rd3

Yi-Jyun Pan (2):
      l10n: zh_TW.po: v2.34.0 round 2 (0 untranslated)
      l10n: zh_TW.po: v2.34.0 round 3 (0 untranslated)

 po/TEAMS    |     2 +-
 po/bg.po    |  8696 +++++++++++++++++++++---------------------
 po/ca.po    | 12013 ++++++++++++++++++++++++++++++----------------------------
 po/de.po    |  8395 ++++++++++++++++++++--------------------
 po/es.po    |  9583 ++++++++++++++++++++++++----------------------
 po/fr.po    |  8373 ++++++++++++++++++++--------------------
 po/git.pot  |  8103 +++++++++++++++++++--------------------
 po/id.po    | 10280 ++++++++++++++++++++++++-------------------------
 po/it.po    |     6 +-
 po/ko.po    |    10 +-
 po/pl.po    | 11613 +++++++++++++++++++++++++++++++-------------------------
 po/pt_PT.po |  3725 ++++++++----------
 po/sv.po    |  9006 ++++++++++++++++++++++---------------------
 po/tr.po    |  8372 ++++++++++++++++++++--------------------
 po/vi.po    |  9049 ++++++++++++++++++++++---------------------
 po/zh_CN.po |  8853 ++++++++++++++++++++++---------------------
 po/zh_TW.po |  9068 +++++++++++++++++++++++---------------------
 17 files changed, 63829 insertions(+), 61318 deletions(-)


--
Jiang Xin
