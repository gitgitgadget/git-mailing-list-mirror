Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFDE31F403
	for <e@80x24.org>; Tue,  5 Jun 2018 16:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbeFEQeR (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 12:34:17 -0400
Received: from siwi.pair.com ([209.68.5.199]:18159 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751748AbeFEQeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 12:34:16 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3106B3F4863;
        Tue,  5 Jun 2018 12:34:16 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BE0543F415C;
        Tue,  5 Jun 2018 12:34:15 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v7 0/2] json-writer V7
Date:   Tue,  5 Jun 2018 16:33:56 +0000
Message-Id: <20180605163358.119080-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Here is V7 of my json-writer patches.  Please replace the existing V5/V6
version of jh/json-writer branch with this one.

This version cleans up the die()-vs-BUG() issue that Duy mentioned recently.
It also fixes a formatting bug when composing empty sub-objects/-arrays.

It also includes a new Python-based test to consume the generated JSON.

I plan to use the json-writer routines in a followup telemetry patch series.

Jeff Hostetler (2):
  json_writer: new routines to create data in JSON format
  json-writer: t0019: add Python unit test

 Makefile                    |   2 +
 json-writer.c               | 419 ++++++++++++++++++++++++++++++++
 json-writer.h               | 113 +++++++++
 t/helper/test-json-writer.c | 572 ++++++++++++++++++++++++++++++++++++++++++++
 t/t0019-json-writer.sh      | 274 +++++++++++++++++++++
 t/t0019/parse_json_1.py     |  35 +++
 6 files changed, 1415 insertions(+)
 create mode 100644 json-writer.c
 create mode 100644 json-writer.h
 create mode 100644 t/helper/test-json-writer.c
 create mode 100755 t/t0019-json-writer.sh
 create mode 100644 t/t0019/parse_json_1.py

-- 
2.9.3

