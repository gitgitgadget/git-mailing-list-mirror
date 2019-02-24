Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BFC120248
	for <e@80x24.org>; Sun, 24 Feb 2019 07:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfBXHQy (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 02:16:54 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43362 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBXHQy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 02:16:54 -0500
Received: by mail-pl1-f193.google.com with SMTP id m10so3004730plt.10
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 23:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZAqmzbIlhPhTzrtvjIUKoSZai5YRXv2g4giZO9XKaBw=;
        b=TA5iWkLOTlGwFysV2kWLr+upV/46B4Lm2r38IqiiGXUeNAkR+fNwrTJ3+lTmxZL0YO
         38ewoXXAoJbwKU3DGanm3Faq5zf763l6ysVTr8K9M+2bK/m8+idua2MSx1MWDBghLcj1
         fTk5HCFycUxrs2YKzzvblwEUpCAk/s3Z5/gko+zuwHAv+nK1b8DgVaWpXTuh7mXcrumV
         cXfTcwtKnW6GdRvO/J6SWZ8mM9O7Znk3MVO+/HJ2j93lvXMXHvQibRaamyzvSvJgbJt/
         v3ycAVMz1VjY9qm4SEUImHz9Auhfc2ZTDAgprmZTaZACnT9QSs29H6Eh0lk1VOOnEYPw
         ifWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZAqmzbIlhPhTzrtvjIUKoSZai5YRXv2g4giZO9XKaBw=;
        b=n71AEgpkNcAMOisNcgQSK6pl9PRgcOGZZaNyZrc34d32jE8hPlUyoFDIJ9458PRbFy
         L07mMPvK+vwrra6BLtunrGmtEllSVnqOnPoCK2AgDQZUnBYCQNli6xcwLMwjbizOLdUd
         BKhTiuUe2oKc4IVwMf1vN3IDclYSk7fu/Jw3saWjRaLiKzZ6fY5ol2HYDbdlYedch/q7
         Grj/XiyFdOsS+VA58pObvlUhe5yS8RRQRZ1l3OkKWVR5A9bkBt+3fZarToeGi8Y+fckF
         utrvViWyZDNKhLUgQqS4MXg2ChlWlZJLpaR3tigITYIU0bOsrUKEaiAHJw8zexQTqGcJ
         G/Cw==
X-Gm-Message-State: AHQUAua5XQwVHInUb/PU+Baupx2AOJb8Xnsg4RlbUu0gSTWsKud0IXXI
        PSNvBXRaMDexSYs86PxZJ64=
X-Google-Smtp-Source: AHgI3IaPf3jSPmZmbYPL+pkZU6/PacLj2F7jimwdkFw1voVKS3Fhkqp9mo4OT2M1yG9mVGBi4wTOxA==
X-Received: by 2002:a17:902:9a98:: with SMTP id w24mr12495392plp.247.1550992613026;
        Sat, 23 Feb 2019 23:16:53 -0800 (PST)
Received: from localhost.localdomain ([124.64.19.102])
        by smtp.gmail.com with ESMTPSA id o25sm9235334pfk.185.2019.02.23.23.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 23:16:51 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Christopher Diaz Riveros <chrisadr@gentoo.org>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Fabien Villepinte <fabien.villepinte@cdbdx.biz>,
        Fangyi Zhou <fangyi.zhou@yuriko.moe>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Sebastian Staudt <koraktor@gmail.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Vasco Almeida <vascomalmeida@sapo.pt>,
        Zhilei Han <linusboyle@gmail.com>
Subject: [GIT PULL] l10n updates for 2.21 round 2
Date:   Sun, 24 Feb 2019 15:16:30 +0800
Message-Id: <20190224071630.5639-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.19.g6993b9cd58
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the following l10n updates for Git 2.21.  These updates come
from nine l10n teams (Bulgarian, Catalan, German, Greek, Spanish, French,
Italian, Swedish and Simplified Chinese).  Jimmy contributed the essential
translation for Greek and formed a new l10n team.  Alessandro made the first
contribution for Italian since 2013 and became the new Italian team leader.

The following changes since commit 2d08f3deb9feb73dc8d21d75bfd367839fc1322c:

  Merge branch 'ea/rebase-compat-doc-fix' (2019-02-14 14:28:22 -0800)

are available in the Git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.21.0-rnd2

for you to fetch changes up to ab8f4f5d73caaf2713346b456de095df690e8cf5:

  l10n: bg.po: Updated Bulgarian translation (4363t) (2019-02-23 23:29:23 +0200)

----------------------------------------------------------------
l10n-2.21.0-rnd2

----------------------------------------------------------------
Alessandro Menti (1):
      l10n: it: update the Italian translation

Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (4363t)

Christopher Díaz Riveros (1):
      l10n: es: 2.21.0 round 2

Fabien Villepinte (2):
      l10n: fr.po Fix some typos
      l10n: fr.po Fix some typos from round3

Fangyi Zhou (1):
      l10n: zh_CN: Revision for git v2.21.0 l10n

Jean-Noël Avila (1):
      l10n: fr.po v2.21.0 rnd 2

Jiang Xin (11):
      Merge branch 'master' of https://github.com/Softcatala/git-po
      Merge branch 'master' of github.com:linusboyle/git
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: git.pot: v2.21.0 round 1 (214 new, 38 removed)
      Merge branch 'master' of git://git.kernel.org/pub/scm/git/git
      l10n: git.pot: v2.21.0 round 2 (3 new, 3 removed)
      Merge branch 'fr_2.21.0_rnd2' of git://github.com/jnavila/git
      Merge branch 'master' of https://github.com/Softcatala/git-po
      l10n: zh_CN: for git v2.21.0 l10n round 1~2
      Merge branch 'bg-submodule-helper-typo' of github.com:pclouds/git-po
      Merge branch 'master' of https://github.com/ralfth/git-po-de

Jimmy Angelakos (1):
      l10n: el: add Greek l10n team and essential translations

Jordi Mas (2):
      l10n: Update Catalan translation
      l10n: Fixes to Catalan translation

Nguyễn Thái Ngọc Duy (1):
      l10n: bg.po: correct typo

Peter Krefting (1):
      l10n: Update Swedish translation (4363t0f0u)

Ralf Thielow (1):
      l10n: update German translation

Sebastian Staudt (3):
      l10n: de.po: consistent translation of 'root commit'
      l10n: de.po: fix a message for index-pack.c
      l10n: de.po: fix grammar in message for tag.c

Zhilei Han (1):
      l10n: zh_CN: fix typo of submodule init message

 po/TEAMS    |     9 +-
 po/bg.po    |  6799 +++++++++-------
 po/ca.po    |   199 +-
 po/de.po    |  7203 +++++++++--------
 po/el.po    | 21468 +++++++++++++++++++++++++++++++++++++++++++++++++++
 po/es.po    |  6789 +++++++++-------
 po/fr.po    |  7376 +++++++++++-------
 po/git.pot  |  6725 +++++++++-------
 po/it.po    | 24299 +++++++++++++++++++++++++++++++++++++++++++++++++---------
 po/sv.po    |  6811 +++++++++-------
 po/zh_CN.po |  6720 +++++++++-------
 11 files changed, 69785 insertions(+), 24613 deletions(-)
 create mode 100644 po/el.po

--
Jiang Xin
