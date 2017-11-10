Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5BBD1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 23:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbdKJXNV (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 18:13:21 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:56691 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbdKJXNU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 18:13:20 -0500
Received: by mail-pg0-f68.google.com with SMTP id z184so3068026pgd.13
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 15:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=WRQqg02DtXMpWRKm/hfHfEuxOJReoxxsZWM5yPt8RNk=;
        b=eCRlun+JCoh4ORpDnn+0txBqyX3U+3hn9CjzSocNvoelOCl0ZcLWsm/8bheN2SEhJI
         9f8/nsJNQH/JcZfAc9yDq3xzDk1/J4h7hY5cZGYvyE7pvojEf/H9akz05xhAFO7VHOq3
         yVfqp1aIY7iZ1p4NTWopj6BTWKx8fR+B+NC4KyPLV2N64v2UAfhoGZ5NewAE3gb2KszB
         NalXPHXcf+pE/SZQ57U4sBcR9MV9r6Vm/M27mpo75gKB2oByiMSwbyf84X0QugTL61Po
         pnY8utOUFgh98tB+oxcotBQnzhAQqrSefb9oBFVgtgX38/9PfqV7Nl3GTDcIlCpCQonm
         bvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WRQqg02DtXMpWRKm/hfHfEuxOJReoxxsZWM5yPt8RNk=;
        b=YAjH48pxWc3Nd2biSfTADKPFsS1uZnRCvi/wWEU3A9oLEVeEtszufXMGBYnjyhr3vf
         1/VO//W7frM+8kUqY8FL1pz6j5nkgzkCr/DMEwI5gknmmG1+SQdYqUmKynq/x8aAJgT0
         A+qJrxB0W5eFQkpd9khUdMzI+v8vj4XrkhYJPOKLtpl9WEKpv5LybD6RUx8TPDanvtBJ
         tD28DKtPhwUBJqfbUwj5p0XkdEsauD/6nMcAmTN2arP4UWk8VXXkni4u3ewUza5LLQ9s
         /Qq/8wvWzZMa1MxhZJegZ/xGh9J9GwIr/oqAGpfl/RoC+Z6e02HwfZp8iW/23q93FV4b
         Z6JQ==
X-Gm-Message-State: AJaThX7FjUX1ouzC8TGte3PJIB5XbAV0Vs/Mrn+0sv6baMe9Tz8AJxU+
        7JuwvdaZKwyMXvNA0j6tD+JPxJA=
X-Google-Smtp-Source: AGs4zMay/m7rx+JjVzG0hbVUy/Ex1B96RocvdAXSiebQvyKx1gyap5NOoz0UjxKLQFwsfw5SlMIeKw==
X-Received: by 10.84.129.132 with SMTP id b4mr1897827plb.412.1510355600052;
        Fri, 10 Nov 2017 15:13:20 -0800 (PST)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id f6sm16248063pgo.11.2017.11.10.15.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2017 15:13:19 -0800 (PST)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH 0/2] Convert some stash functionality to a builtin
Date:   Fri, 10 Nov 2017 15:13:12 -0800
Message-Id: <20171110231314.30711-1-joel@teichroeb.net>
X-Mailer: git-send-email 2.15.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been working on converting all of git stash to be a
builtin, however it's hard to get it all working at once with
limited time, so I've moved around half of it to a new
stash--helper builtin and called these functions from the shell
script. Once this is stabalized, it should be easier to convert
the rest of the commands one at a time without breaking
anything.

I've sent most of this code before, but that was targetting a
full replacement of stash. The code is overall the same, but
with some code review changes and updates for internal api
changes.

Joel Teichroeb (2):
  merge: close the index lock when not writing the new index
  stash: implement builtin stash helper

 Makefile                |   1 +
 builtin.h               |   1 +
 builtin/stash--helper.c | 516 ++++++++++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 134 +------------
 git.c                   |   1 +
 merge-recursive.c       |   9 +-
 6 files changed, 532 insertions(+), 130 deletions(-)
 create mode 100644 builtin/stash--helper.c

-- 
2.15.0

