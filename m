Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7532620A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 16:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeLHQhQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 11:37:16 -0500
Received: from 0x63.nu ([109.74.10.199]:48514 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbeLHQhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 11:37:16 -0500
Received: from ip6-localhost ([::1] helo=moveme2.lan)
        by 0x63.nu with esmtp (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gVfbK-0000Dk-KE; Sat, 08 Dec 2018 17:37:10 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Anders Waldenborg <anders@0x63.nu>
Subject: [PATCH v4 0/7] %(trailers) improvements in pretty format
Date:   Sat,  8 Dec 2018 17:36:40 +0100
Message-Id: <20181208163647.19538-1-anders@0x63.nu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181028125025.30952-1-anders@0x63.nu>
References: <20181028125025.30952-1-anders@0x63.nu>
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updated since v3:
 * multiple 'key=' matches any
 * allow overriding implicit 'only' when using key
 * minor grammar and spelling fixes
 * documentation restructuring
 * Helper functions for parsing options

Anders Waldenborg (7):
  doc: group pretty-format.txt placeholders descriptions
  pretty: allow %(trailers) options with explicit value
  pretty: single return path in %(trailers) handling
  pretty: allow showing specific trailers
  pretty: add support for "valueonly" option in %(trailers)
  strbuf: separate callback for strbuf_expand:ing literals
  pretty: add support for separator option in %(trailers)

 Documentation/pretty-formats.txt | 260 ++++++++++++++++++-------------
 pretty.c                         | 104 ++++++++++---
 strbuf.c                         |  21 +++
 strbuf.h                         |   8 +
 t/t4205-log-pretty-formats.sh    | 111 +++++++++++++
 trailer.c                        |  25 ++-
 trailer.h                        |   4 +
 7 files changed, 400 insertions(+), 133 deletions(-)

-- 
2.17.1

