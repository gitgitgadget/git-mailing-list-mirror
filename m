Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B461820D0A
	for <e@80x24.org>; Wed, 31 May 2017 10:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbdEaKmc (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 06:42:32 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:36872 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdEaKmb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 06:42:31 -0400
Received: from lindisfarne.localdomain ([92.22.34.189])
        by smtp.talktalk.net with SMTP
        id G154d4KIzcpskG15Ad2uBR; Wed, 31 May 2017 11:42:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1496227349; bh=EGhLrrfBK98VHH0z8y+Uv5uOOHBRWeX2jzKRt4qdHgw=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=mb9b3w6137eN9xzmnugzYIQkuO+HM8hA1MtXMBo4qYlgG8dxv3GEFwx/RGPGOq5C3
         F/9khzljUJh5wKup/rTXqY7V6DJ+FWmIWdcsQQnAxgWzgBLAXObSXvp/xEmAxbBEd3
         yoQdLRARzfKK/pSQbexQY/vu9xofVFeWvAlqwdvY=
X-Originating-IP: [92.22.34.189]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=vjpdqwq13QoU7KiiDtdC/A==:117
 a=vjpdqwq13QoU7KiiDtdC/A==:17 a=evINK-nbAAAA:8 a=F0p0gTOZ3vSGSInigKoA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/3] Add regression tests for recent rebase -i fixes
Date:   Wed, 31 May 2017 11:42:10 +0100
Message-Id: <20170531104213.16944-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfC9ToEAP1+tML7rto6U9d9jKPPD4XGPljL5TlUAJg8yTWx2x/1nqykoJy3rruneIOflQQ6cvtHehk9wb0wju9wRkqng5YG260qgBH/8RRG3nnY7EjbPB
 lHoRbt+bBYT8ums1NYtEHPTW6M5PdaH0+oK7kjWWYoMTDxCbMKED09ACXlkjbV0u7ZRk76bpTvuModCHovElwT0IOCAdjMjfGROE1QErrD5JIoWtTWA7YdUe
 B1XpDkJB93xxi9q+b8dCzRIfgJ0FprYSKK4YD8xCd57cOpbxzk2eve3WEQj91JxI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

These patches add some tests for the fixes I sent the week before
last. The output tests check the messages for stashes that apply and
fail for all three variants of rebase. They are quite strict but I
couldn't think of a better way to check that the output is correct and
doesn't contain anything it isn't meant to (such as the output of git
status).


Phillip Wood (3):
  rebase -i: Add test for reflog message
  rebase: Add tests for console output
  rebase: Add tests for console output with conflicting stash

 t/t3404-rebase-interactive.sh        |  7 +++++++
 t/t3420-rebase-autostash.sh          | 20 ++++++++++++++++++--
 t/t3420/expected-fail-am             |  8 ++++++++
 t/t3420/expected-fail-interactive    |  6 ++++++
 t/t3420/expected-fail-merge          | 32 ++++++++++++++++++++++++++++++++
 t/t3420/expected-success-am          |  6 ++++++
 t/t3420/expected-success-interactive |  4 ++++
 t/t3420/expected-success-merge       | 30 ++++++++++++++++++++++++++++++
 t/t3420/remove-ids.sed               |  6 ++++++
 9 files changed, 117 insertions(+), 2 deletions(-)
 create mode 100644 t/t3420/expected-fail-am
 create mode 100644 t/t3420/expected-fail-interactive
 create mode 100644 t/t3420/expected-fail-merge
 create mode 100644 t/t3420/expected-success-am
 create mode 100644 t/t3420/expected-success-interactive
 create mode 100644 t/t3420/expected-success-merge
 create mode 100644 t/t3420/remove-ids.sed

-- 
2.13.0

