Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E12E1F403
	for <e@80x24.org>; Sun, 10 Jun 2018 15:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753435AbeFJPNL (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 11:13:11 -0400
Received: from p3plsmtpa06-02.prod.phx3.secureserver.net ([173.201.192.103]:35040
        "EHLO p3plsmtpa06-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753375AbeFJPNL (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jun 2018 11:13:11 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Jun 2018 11:13:11 EDT
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id S1uNfeU0REJZQS1uhfyRGT; Sun, 10 Jun 2018 08:05:53 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Cc:     Max Kirillov <max@max630.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v8 0/3] http-backend: respect CONTENT_LENGTH as specified by rfc3875
Date:   Sun, 10 Jun 2018 18:05:18 +0300
Message-Id: <20180610150521.9714-1-max@max630.net>
X-Mailer: git-send-email 2.17.0.1185.g782057d875
In-reply-to: <20180602212749.21324-1-max@max630.net>
X-CMAE-Envelope: MS4wfINaGW6V5TOmid0PJkwa21BuaFqfhxbAfOT8MLltE80pNJgyIIB6OA95uZ9gUuK4bcCdLk4D1Ubnu650nzhd/6DHV9dxCrk+Rg8hDIQJXYvTcSJCwwCq
 x765z3IZrdiNCMbB8AZxa9lqhd5t5FN7ZgcSQVo80AqLX9yCiUIF7LAImzMic5ec0QtltzMtLFvSXOAmos+beCAY0V33e3KN2267moH3fSLh2UTdiVnmIvuQ
 f9Vd0zG2T2+o70CHMgViUKIEbGdjiiXSfZxcVnjzdwtJDQb/cCm0/ZhU4lKj5FUEeLAEA6hj2JMsvE/DcQ2EDkMDx6gS8IEmhB9TvT6MPflp7g8uDLRaoyaV
 3PnYvt22zllm5U0vctrcvBECHYY/4hjoc6l+TdH7tiv/jF6N9ps=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Did the fixes proposed for v7

Max Kirillov (3):
  http-backend: cleanup writing to child process
  http-backend: respect CONTENT_LENGTH as specified by rfc3875
  http-backend: respect CONTENT_LENGTH for receive-pack

 config.c                               |   2 +-
 config.h                               |   1 +
 help.c                                 |   1 +
 http-backend.c                         | 100 +++++++++++++--
 t/t5562-http-backend-content-length.sh | 169 +++++++++++++++++++++++++
 t/t5562/invoke-with-content-length.pl  |  37 ++++++
 6 files changed, 295 insertions(+), 15 deletions(-)
 create mode 100755 t/t5562-http-backend-content-length.sh
 create mode 100755 t/t5562/invoke-with-content-length.pl

-- 
2.17.0.1185.g782057d875

