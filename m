Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A40601F403
	for <e@80x24.org>; Tue, 12 Jun 2018 20:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933483AbeFLUWT (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 16:22:19 -0400
Received: from siwi.pair.com ([209.68.5.199]:25839 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754325AbeFLUWR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 16:22:17 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EE2BC3F4129;
        Tue, 12 Jun 2018 16:22:16 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9E4EB3F40E6;
        Tue, 12 Jun 2018 16:22:13 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v9] json_writer V9
Date:   Tue, 12 Jun 2018 20:22:00 +0000
Message-Id: <20180612202201.94733-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Here is V9 of my json-writer patches.  Please replace the existing V5..V8
versions with this one.

This version has been rebased onto v2.18.0-rc1 rather than 2.17 because
of changes to the test-tool setup.

I've incorporated all of the suggestions on the V8 version, including Eric's
suggestion to make the test tool read test data from stdin rather than using
command line arguments.

I also incorporated Eric's PERLJSON lazy prereq suggestion and squashed the
perl unit test into the main commit.

Jeff Hostetler (1):
  json_writer: new routines to create JSON data

 Makefile                    |   2 +
 json-writer.c               | 414 ++++++++++++++++++++++++++++++++
 json-writer.h               | 105 +++++++++
 t/helper/test-json-writer.c | 564 ++++++++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c        |   1 +
 t/helper/test-tool.h        |   1 +
 t/t0019-json-writer.sh      | 331 ++++++++++++++++++++++++++
 t/t0019/parse_json.perl     |  52 ++++
 8 files changed, 1470 insertions(+)
 create mode 100644 json-writer.c
 create mode 100644 json-writer.h
 create mode 100644 t/helper/test-json-writer.c
 create mode 100755 t/t0019-json-writer.sh
 create mode 100644 t/t0019/parse_json.perl

-- 
2.9.3

