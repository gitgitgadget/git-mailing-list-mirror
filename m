Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DED2F1F576
	for <e@80x24.org>; Tue, 23 Jan 2018 10:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751388AbeAWKY5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 05:24:57 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:26330 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbeAWKY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 05:24:56 -0500
Received: from lindisfarne.localdomain ([92.22.6.159])
        by smtp.talktalk.net with SMTP
        id dvkzej0JImITadvl6e8jXq; Tue, 23 Jan 2018 10:24:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1516703094;
        bh=5zhlYMDTyhchrL3Av4wez2d9ChKMy1UcAWBzGFWq7Gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=bIDlN+E4d7gp18JReyx0QGAW/qAFTRkHry0JLj6+5Jr7JXGhLo4jq5Tpe8o2I85sr
         PQa2hiXPS9FjvMOww66ZueNW+VEkYU9LqV19MlRs+/ZWl9hcd+JgEoeELuDCZOKXWB
         Q42W0pFQcUxWXxmYsc91SA1x2JS1wjhTSl2kmOkY=
X-Originating-IP: [92.22.6.159]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=zHCrIP3pJrCm+L4FAUKT3Q==:117
 a=zHCrIP3pJrCm+L4FAUKT3Q==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=m6pjHNm8sNV1TzHxhsEA:9 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: =?UTF-8?q?=5BPATCH=20v2=200/2=5D=20sequencer=3A=20run=20=27prepare-commit-msg=27=20hook=E2=80=8B?=
Date:   Tue, 23 Jan 2018 10:24:18 +0000
Message-Id: <20180123102420.19911-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <CAKdAkRSuNhEri+3eUbX8iVjr0JUyADSJBtgL==VjNwgKwe3Xqw@mail.gmail.com>
References: <CAKdAkRSuNhEri+3eUbX8iVjr0JUyADSJBtgL==VjNwgKwe3Xqw@mail.gmail.com>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfK2DhMMZsCvPOm4iRlHQTf6ohuOqlKxyfO5DTyY/9lqJxlKdF65+MhXc9rWw2UWSDHDYpJmO8O2ADqUW7b/57hSK4TpRP9shIpv/vgy8NBkzsQ8fUWhm
 8kDfm1TyOeLTpO8zTcEOM4XXy43pAgtwhiGHh5Obd5NJD1Q/C0oBPCHytvvbBUGJuFz/C5/fmmiUzNnJzeqFjviOtd3AReUXKMMXxvddFG4iGE546Q3fMcIe
 +C+jomGT2WBmaxOCV0eg9mT+wQn9XapkiSb7Okvf8cFEe9qfsPio0SXLB5BfEdoEBLt45Zit+HsOLy6yrtsD7y3gujhWnYgnDeTdBO0Y4napsF+L3JxxgYQQ
 MpdrV4juPq1SkGSoMW01nCMIhu6L+kHDSIyjgrc4j1uqMgPW59he3yCFrB10FGSSHTg7DTmP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

I've updated the patches in response to comments, there are just a
couple of small changes. Thanks to Ramsay and Eric for their reviews.

Best Wishes

Phillip

Original cover letter:

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

