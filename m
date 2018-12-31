Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 151631F770
	for <e@80x24.org>; Mon, 31 Dec 2018 00:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeLaAbx (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Dec 2018 19:31:53 -0500
Received: from fed1rmfepo202.cox.net ([68.230.241.147]:50473 "EHLO
        fed1rmfepo202.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeLaAbw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Dec 2018 19:31:52 -0500
Received: from fed1rmimpo209.cox.net ([68.230.241.160])
          by fed1rmfepo202.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20181231003151.DOYZ21918.fed1rmfepo202.cox.net@fed1rmimpo209.cox.net>
          for <git@vger.kernel.org>; Sun, 30 Dec 2018 19:31:51 -0500
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 77034B8321A;
        Sun, 30 Dec 2018 17:31:50 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090210.5C296377.0026,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=VcdDw2h9 c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=2ur7OfE09M0A:10 a=WDhBSedXqNQA:10 a=Z4Rwk6OoAAAA:8 a=ybZZDoGAAAAA:8
 a=wvb-bRsGpiuY9AZUTBoA:9 a=HkZW87K1Qel5hWWM3VKY:22 a=0RhZnL1DYvcuLYC8JZ5M:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     git@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] Add 'human' date format
Date:   Sun, 30 Dec 2018 17:31:47 -0700
Message-Id: <20181231003150.8031-1-ischis2@cox.net>
X-Mailer: git-send-email 2.20.1.2.gb21ebb671b
Reply-To: alpine.LFD.2.21.999.1807071502260.18818@i7.lan
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Added documentation and tests for the previously submitted patch.  The
previous patch was rebased and the conflict in cache.h was resolved.

Range diff for Linus' original code:

1:  74e8221b52 ! 1:  dd8ea66414 Add 'human' date format
    @@ -26,6 +26,10 @@
     
         Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Rebased lt/date-human to git version 2.20.1 and resolved a conflict.
    +
    +    Intentionally did not change logic or add documentation/tests to the
    +    original commit so that the sign-offs would still be legitimate.
     
      diff --git a/builtin/blame.c b/builtin/blame.c
      --- a/builtin/blame.c
    @@ -46,13 +50,13 @@
      --- a/cache.h
      +++ b/cache.h
     @@
    - struct date_mode {
    - 	enum date_mode_type {
    - 		DATE_NORMAL = 0,
    -+		DATE_HUMAN,
    - 		DATE_RELATIVE,
    - 		DATE_SHORT,
    - 		DATE_ISO8601,
    + 
    + enum date_mode_type {
    + 	DATE_NORMAL = 0,
    ++	DATE_HUMAN,
    + 	DATE_RELATIVE,
    + 	DATE_SHORT,
    + 	DATE_ISO8601,
     
      diff --git a/date.c b/date.c
      --- a/date.c


Linus Torvalds (1):
  Add 'human' date format

Stephen P. Smith (2):
  Add 'human' date format documentation
  t0006-date.sh: add `human` date format tests.

 Documentation/rev-list-options.txt |   8 ++
 builtin/blame.c                    |   4 +
 cache.h                            |   1 +
 date.c                             | 130 ++++++++++++++++++++++++-----
 t/t0006-date.sh                    |  24 ++++++
 t/t4202-log.sh                     |  24 ++++++
 t/t7007-show.sh                    |  25 ++++++
 7 files changed, 196 insertions(+), 20 deletions(-)

-- 
2.20.1.2.gb21ebb671b

