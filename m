Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542C0C433F5
	for <git@archiver.kernel.org>; Sun, 23 Jan 2022 12:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbiAWM3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jan 2022 07:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiAWM3b (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jan 2022 07:29:31 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4254EC06173B
        for <git@vger.kernel.org>; Sun, 23 Jan 2022 04:29:31 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o64so13597480pjo.2
        for <git@vger.kernel.org>; Sun, 23 Jan 2022 04:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUp3oW8WgCyZ/HpcxWgcZqNca0ebQPKl+ffyXeDO+II=;
        b=TRjzOFwN+dvDvKaY6rZGexj85M/uiiJwcEI/YVyHMmFzJMJ28E8Nzm14KqZ6gleajp
         b+ZpUTaBXAp4BrlMAxTFqqNWe8CJSYSXhJQgmZJwT06TnoK4/RwInupQaXjMo7M+fm+p
         h1zm0+v+ZKI3miqgWqRrwi+3gW06yWzrrnslce+oM+su5NH8d5szxV/sER0/RSIMa4U+
         RB2jqRHLpM0uzJOiLM2LrHV09ZLZ1MmUBbdqAM6oBJv4cBDASAYm2T/DK7wNZyYWrTWf
         NKQY3VsclOYO/MZw0IkFl2djY55D1ie9TH3geixG/OMFA3Cc3MajOKx7RJmcdhgv7Gzw
         zrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUp3oW8WgCyZ/HpcxWgcZqNca0ebQPKl+ffyXeDO+II=;
        b=W8hoEqiw2H/u1NFWWfTn9BdsMJiq29kOThT9eaEKpAEwMrY4i5XxcAuL2E4mm0RSmB
         QziIwxPLP0kSS8sPeL3tJanGeu471GKsJyPYvyF4eQechvIXxeWuyqA/yDvERBy90xwB
         dwDkjNHpb/PsdqaPgAFuqz7ivzo1RW+aKy2wVHLlRHZ9kYXy+BnK0HdNkrw95pKOnIJK
         Fggad/8FI8wbqtYUq8IrWyYE70fknqGhgsv2f3SNvmNhRWucFznKUOcnoUqsfvt30RqD
         zj2PDyw3DYHenzklq7+cIsobFV616RPIL5CMcUSpcXU7cpj17jxeUcfEPrtkRxWvnAxp
         O/yw==
X-Gm-Message-State: AOAM532M2e/nnjBEBt5PDIltCZ6xXQBRwDm9RnMtC+3+pnUOfWgaCtCU
        1HO9Y0boPV9mmcv19PojLz0=
X-Google-Smtp-Source: ABdhPJyZ9IPKVdZJUF5FdRQpJuAF9vdgGyyZXLiVwrHsOnppocUuxXOxLVUwpgL/Xtupb6kLyIRmEw==
X-Received: by 2002:a17:902:9306:b0:14a:18ab:298c with SMTP id bc6-20020a170902930600b0014a18ab298cmr10320396plb.87.1642940970692;
        Sun, 23 Jan 2022 04:29:30 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id w4sm9347523pgs.28.2022.01.23.04.29.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jan 2022 04:29:29 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Git l10n discussion group <git-l10n@googlegroups.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Arusekk <arek_koz@o2.pl>, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Daniel Santos <daniel@brilhante.top>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Emir SARI <bitigchi@me.com>, Emir SARI <emir_sari@icloud.com>,
        Fangyi Zhou <me@fangyi.io>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?J=C3=BCrgen=20Kr=C3=A4mer?= <jkr@jottkaerr.de>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: [GIT PULL] l10n updates for 2.35.0 round 2
Date:   Sun, 23 Jan 2022 20:29:25 +0800
Message-Id: <20220123122925.22967-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the following l10n updates for Git 2.35.0.

The following changes since commit df3c41adeb212432c53d93ce6ace5d5374dc6e11:

  Git 2.35-rc1 (2022-01-14 15:26:53 -0800)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.35.0-rnd2

for you to fetch changes up to 9e2b35d7643cc26f61094d80c8d5f512eb467981:

  l10n: Update Catalan translation (2022-01-23 09:40:52 +0100)

----------------------------------------------------------------
l10n-2.35.0-rnd2

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5195t)

Bagas Sanjaya (2):
      l10n: po-id for 2.35 (round 1)
      l10n: po-id for 2.35 (round 2)

Emir SARI (1):
      l10n: tr: v2.35.0 round 1

Fangyi Zhou (1):
      l10n: zh_CN: v2.35.0 round 1

Jean-Noël Avila (1):
      l10n: fr: v2.35.0 round 1

Jiang Xin (8):
      l10n: git.pot: v2.35.0 round 1 (126 new, 142 removed)
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'fr_2.35.0_rnd1' of github.com:jnavila/git
      Merge tag 'v2.35.0-rc1'
      l10n: git.pot: v2.35.0 round 2 (1 new, 1 removed)
      l10n: batch update to fix typo in branch.c
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'l10n/zh_TW/220113' of github.com:l10n-tw/git-po

Jordi Mas (3):
      l10n: Update Catalan translation
      l10n: Update Catalan translation
      l10n: Update Catalan translation

Jürgen Krämer (1):
      l10n: de.po: Fix translation for "'%s' is aliased to '%s'"

Matthias Rüster (1):
      l10n: de.po: Update German translation

Peter Krefting (2):
      l10n: sv.po: Fix typo
      l10n: sv.po: Update Swedish translation (5196t0f0u)

Trần Ngọc Quân (1):
      l10n: vi(5195t): Update for v2.35.0 round 2

Yi-Jyun Pan (2):
      l10n: zh_TW: v2.35.0 round 1 (1 fuzzy)
      l10n: zh_TW: v2.35.0 round 2 (0 untranslated)

 po/bg.po    | 6281 +++++++++++++++++++--------------------
 po/ca.po    | 9522 +++++++++++++++++++++++++++--------------------------------
 po/de.po    | 6332 +++++++++++++++++++--------------------
 po/fr.po    | 6661 +++++++++++++++++++++--------------------
 po/git.pot  | 6009 +++++++++++++++++++------------------
 po/id.po    | 6719 ++++++++++++++++++++---------------------
 po/sv.po    | 6681 +++++++++++++++++++++--------------------
 po/tr.po    | 6379 +++++++++++++++++++--------------------
 po/vi.po    | 8645 ++++++++++++++++++++---------------------------------
 po/zh_CN.po | 6911 ++++++++++++++++++++-----------------------
 po/zh_TW.po | 6627 +++++++++++++++++++++--------------------
 11 files changed, 37060 insertions(+), 39707 deletions(-)

--
Jiang Xin
