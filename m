Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 275A91F404
	for <e@80x24.org>; Fri, 19 Jan 2018 14:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755823AbeASOUP (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 09:20:15 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:41635 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753841AbeASOUN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 09:20:13 -0500
Received: from lindisfarne.localdomain ([92.22.6.159])
        by smtp.talktalk.net with SMTP
        id cXWWeW8PQbjdZcXWcepurB; Fri, 19 Jan 2018 14:20:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1516371611;
        bh=WY/0O8cCZTK92dF8wVfNyRZbhzG2AFRxzcyIyXMGo+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=Jw0oHXXgT+JSu58n15fWppgMfzGMqGztLuCEDV+6XQ9kJVAhGFC8czg05Im1BdWSY
         o3f/dPeYiiw85gnTOXLCkwH3Y9T5qR3Gi9rPKeMGew5ZS2in9m7UdZ5GwIVol+uO8F
         wchl4HX1TsoyRhi5PTyv4WWI0q6PFm++2uvlDlI8=
X-Originating-IP: [92.22.6.159]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=zHCrIP3pJrCm+L4FAUKT3Q==:117
 a=zHCrIP3pJrCm+L4FAUKT3Q==:17 a=evINK-nbAAAA:8 a=eLUAofUqUhd0yx5ow4EA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/2] sequencer: run 'prepare-commit-msg' hook
Date:   Fri, 19 Jan 2018 14:19:38 +0000
Message-Id: <20180119141940.5421-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <CAKdAkRSuNhEri+3eUbX8iVjr0JUyADSJBtgL==VjNwgKwe3Xqw@mail.gmail.com>
References: <CAKdAkRSuNhEri+3eUbX8iVjr0JUyADSJBtgL==VjNwgKwe3Xqw@mail.gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfDU2vwTDBYF+CQY83KyD9OhdNh66Xoz2ZvpciCPa44NFOn/euw09x7lRaLv7gjy//Auulxzlz2wxC5FnIeMYlvpVTFt0AlZ3RqbX2OZEj6OkU+5Rv695
 JjTwCTYW0sTTXysRbtovxG9J5Wb96eNG5MNYus3YaUe/zyBBSeSCd980ForEJFzOj7lDCtcZJQwjCe59CzinWz/KX6lrwC3HgdWZoiqKkpIZXQvqlfbr3HX6
 0dcTKPgr6EFC8lzzAfQ7MMrfssPXboOWmdaV+hwXLyg0QzYj3Lz8Zk9g2Xy+Cczf85B+ZyfgKCd74HgMgHHyhRFocGKEl7X2G96bkxGDzPM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

These two patches add some tests and fix the sequencer to run the
'prepare-commit-msg' hook when committing without forking 'git commit'

Phillip Wood (2):
  t7505: Add tests for cherry-pick and rebase -i/-p
  sequencer: run 'prepare-commit-msg' hook

 builtin/commit.c                   |   2 -
 sequencer.c                        |  69 ++++++++++++++++----
 sequencer.h                        |   1 +
 t/t7505-prepare-commit-msg-hook.sh | 127 +++++++++++++++++++++++++++++++++++--
 t/t7505/expected-rebase-i          |  17 +++++
 t/t7505/expected-rebase-p          |  18 ++++++
 6 files changed, 215 insertions(+), 19 deletions(-)
 create mode 100644 t/t7505/expected-rebase-i
 create mode 100644 t/t7505/expected-rebase-p

-- 
2.15.1

