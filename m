Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B32E1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 21:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfA1VvH (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 16:51:07 -0500
Received: from 0x63.nu ([109.74.10.199]:44890 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbfA1VvG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 16:51:06 -0500
X-Greylist: delayed 1027 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jan 2019 16:51:06 EST
Received: from ip6-localhost ([::1] helo=moveme2.lan)
        by 0x63.nu with esmtp (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1goEXR-0002Au-RS; Mon, 28 Jan 2019 22:33:53 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Anders Waldenborg <anders@0x63.nu>
Subject: [PATCH v5 0/7] %(trailers) improvements in pretty format
Date:   Mon, 28 Jan 2019 22:33:30 +0100
Message-Id: <20190128213337.24752-1-anders@0x63.nu>
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

Updates since v4:
 * Coding style fixes
 * Reuse git_parse_maybe_bool for bool parsing

Anders Waldenborg (7):
  doc: group pretty-format.txt placeholders descriptions
  pretty: Allow %(trailers) options with explicit value
  pretty: single return path in %(trailers) handling
  pretty: allow showing specific trailers
  pretty: add support for "valueonly" option in %(trailers)
  strbuf: separate callback for strbuf_expand:ing literals
  pretty: add support for separator option in %(trailers)

 Documentation/pretty-formats.txt | 260 ++++++++++++++++++-------------
 pretty.c                         | 113 +++++++++++---
 strbuf.c                         |  21 +++
 strbuf.h                         |   8 +
 t/t4205-log-pretty-formats.sh    | 117 ++++++++++++++
 trailer.c                        |  25 ++-
 trailer.h                        |   4 +
 7 files changed, 415 insertions(+), 133 deletions(-)

-- 
2.17.1

