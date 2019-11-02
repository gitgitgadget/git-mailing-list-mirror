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
	by dcvr.yhbt.net (Postfix) with ESMTP id 86D7D1F454
	for <e@80x24.org>; Sat,  2 Nov 2019 13:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfKBNfq (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 09:35:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45067 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfKBNfp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 09:35:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1so8187550pgj.12
        for <git@vger.kernel.org>; Sat, 02 Nov 2019 06:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QT489gbm0ZHtyqlBTX3nj3p9v8sgp8SND2fExHljkHY=;
        b=lY7wcL6xUMlw1OxXvNRlTFJR0rIXCJYZBvzeIHsRKdaAeD808xbVxZzCXzsCjKuFWQ
         pFu3s4ptl5LSi0X3WhU5laj/kmAmhaDLbJNe9xmtz8pzuixHz7z4kewFq7jSGLbPwUEm
         YKpBQCOyD7KXwwVE4C4XxfZWVKn+US/EnZZdXx7CBlTt5/UwRG/LMyoul9SM8+UQy1WP
         WsAlQozeP9xEiYmU5gctlUws5GO7dWTnwbuY3bGq9Y/77rX9P941yp5t2Rp0Digd43Pr
         xs6V/QEDByteQj/MxwTbUKWkp/16PacoVtmsvFSn36hWRpxDtAEkDVMPH7llyb+1pddE
         gF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QT489gbm0ZHtyqlBTX3nj3p9v8sgp8SND2fExHljkHY=;
        b=nCFc9kP4up9UFlRPAb0IY61S6mJhFKr5APGAxKx4dL9H06RhJuvIoCmJgdEa0fpvyY
         y4bwTXdWUenzvjgNxFeXNJTAtBgYtnejbY/u+ppewDASCd5bt2bWudOaS8UWWr/1g1vG
         2Aty7hgEWSBDc7I5UHTPlaaSO3uA9dG+KgT3PEfKZXTCr1Lzg8u7KVZXFwDbXBuPRJRJ
         h9/DGyGF7nfDV3ZdZT49jrwN+nMmpIUWE7cFBkja1hVJz3sYo8eh85uWelLX1KJYoWkV
         +aNu6jREf5O40QJkIg2nAAe3yRi2kA3/wb/cyimC1NTub5wg0FsMZNfdDXQnOquG9Bcc
         AJ3g==
X-Gm-Message-State: APjAAAUWgAVxVFP0tt2/1Dr0oCFvMa7Mvlastyr7FJd4rFUdfO7z19nQ
        /j4vZ1WWhs6BeRmsfU0HZlQvUenU3rLzmw==
X-Google-Smtp-Source: APXvYqxn5uYBxCiwytDDbleSz17g+6MAU0wp2jp9rw8Aej4yZb4LjMz5eumT+oG9PP3u9JXhhFu1/Q==
X-Received: by 2002:a63:4553:: with SMTP id u19mr19604249pgk.436.1572701744929;
        Sat, 02 Nov 2019 06:35:44 -0700 (PDT)
Received: from localhost.localdomain ([112.17.238.238])
        by smtp.gmail.com with ESMTPSA id a6sm13078113pja.30.2019.11.02.06.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Nov 2019 06:35:43 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Christopher Diaz Riveros <christopher.diaz.riv@gmail.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [GIT PULL] l10n updates for 2.24.0 round 2
Date:   Sat,  2 Nov 2019 21:35:13 +0800
Message-Id: <20191102133514.66294-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.24.0.rc1.15.g6fdcd7fc59.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <worldhello.net@gmail.com>

Hi Junio,

Please pull the following l10n updates for Git 2.24.0.

The following changes since commit 566a1439f6f56c2171b8853ddbca0ad3f5098770:

  Git 2.24-rc1 (2019-10-24 13:34:03 +0900)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.24.0-rnd2

for you to fetch changes up to a5cd71ca4a7c58ba507bf36dc36febbae8043361:

  l10n: zh_CN: for git v2.24.0 l10n round 1~2 (2019-11-02 20:51:12 +0800)

----------------------------------------------------------------
l10n-2.24.0-rnd2

----------------------------------------------------------------
Alessandro Menti (2):
      l10n: it.po: update the Italian translation for Git 2.24.0
      l10n: it.po: update the Italian translation for Git 2.24.0 round #2

Alexander Shopov (2):
      l10n: bg.po: Updated Bulgarian translation (4693)
      l10n: bg.po: Updated Bulgarian translation (4694)

Christopher Diaz Riveros (1):
      l10n: es: 2.24.0 round 2

Jean-Noël Avila (2):
      l10n: fr 2.24.0 rnd 1
      l10n: fr v2.24.0 rnd2

Jiang Xin (10):
      l10n: git.pot: v2.24.0 round 1 (35 new, 16 removed)
      Merge remote-tracking branch 'git-po/master' into git-po-master
      Merge branch 'master' of github.com:alshopov/git-po into git-po-master
      Merge branch 'master' of github.com:jnavila/git into git-po-master
      Merge tag 'v2.24.0-rc1' of github.com:git/git into master
      l10n: git.pot: v2.24.0 round 2 (1 new)
      Merge branch 'l10n/it/update-italian-translation'
      Merge branch 'next' of github.com:ChrisADR/git-po
      Merge branch 'master' of github.com:vnwildman/git
      l10n: zh_CN: for git v2.24.0 l10n round 1~2

Jordi Mas (1):
      l10n: Update Catalan translation

Matthias Rüster (1):
      l10n: de.po: Update German translation

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (4674t0f0u)
      l10n: sv.po: Update Swedish translation (4695t0f0u)

Trần Ngọc Quân (1):
      l10n: vi(4694t): Updated translation for v2.24.0

 po/bg.po    | 4989 ++++++++++++++++++++++++++++----------------------------
 po/ca.po    |   60 +-
 po/de.po    | 5044 ++++++++++++++++++++++++++++----------------------------
 po/es.po    | 5220 +++++++++++++++++++++++++++++-----------------------------
 po/fr.po    | 4994 ++++++++++++++++++++++++++++----------------------------
 po/git.pot  | 4924 ++++++++++++++++++++++++++++---------------------------
 po/it.po    | 5034 ++++++++++++++++++++++++++++----------------------------
 po/sv.po    | 5240 ++++++++++++++++++++++++++++++-----------------------------
 po/vi.po    | 5040 ++++++++++++++++++++++++++++----------------------------
 po/zh_CN.po | 4978 +++++++++++++++++++++++++++++---------------------------
 10 files changed, 23301 insertions(+), 22222 deletions(-)

--
Jiang Xin
