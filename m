Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 275711F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 11:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeKRWGD (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 17:06:03 -0500
Received: from 0x63.nu ([109.74.10.199]:54748 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbeKRWGD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 17:06:03 -0500
Received: from localhost ([127.0.0.1] helo=moveme2.lan)
        by 0x63.nu with esmtp (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gOLVw-0003J7-UW; Sun, 18 Nov 2018 12:45:21 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Anders Waldenborg <anders@0x63.nu>
Subject: [PATCH v3 0/5] %(trailers) improvements in pretty format
Date:   Sun, 18 Nov 2018 12:44:22 +0100
Message-Id: <20181118114427.1397-1-anders@0x63.nu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104152232.20671-1-anders@0x63.nu>
References: <20181104152232.20671-1-anders@0x63.nu>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updated since v2:
 * Allow trailing colon in 'key=' argument
 * Clarify documentation on how matching is done
 * Rename option to "valueonly"
 * Make trailing matching a callback function
 * Avoid copying match string
 * Simplify generation of "expected" in tests
 * Rename function to strbuf_expand_literal_cb
 * cocci suggested fixes



Anders Waldenborg (5):
  pretty: single return path in %(trailers) handling
  pretty: allow showing specific trailers
  pretty: add support for "valueonly" option in %(trailers)
  strbuf: separate callback for strbuf_expand:ing literals
  pretty: add support for separator option in %(trailers)

 Documentation/pretty-formats.txt | 26 ++++++++---
 pretty.c                         | 68 ++++++++++++++++++++++------
 strbuf.c                         | 21 +++++++++
 strbuf.h                         |  8 ++++
 t/t4205-log-pretty-formats.sh    | 78 ++++++++++++++++++++++++++++++++
 trailer.c                        | 25 ++++++++--
 trailer.h                        |  4 ++
 7 files changed, 206 insertions(+), 24 deletions(-)

-- 
2.17.1

