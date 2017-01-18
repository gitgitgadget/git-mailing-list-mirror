Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C8A120756
	for <e@80x24.org>; Wed, 18 Jan 2017 00:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbdARAEZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 19:04:25 -0500
Received: from mga06.intel.com ([134.134.136.31]:59468 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751909AbdARAEY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 19:04:24 -0500
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP; 17 Jan 2017 16:03:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,247,1477983600"; 
   d="scan'208";a="55122130"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.35.174])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jan 2017 16:03:56 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 1/5] doc: add documentation for OPT_STRING_LIST
Date:   Tue, 17 Jan 2017 16:03:41 -0800
Message-Id: <20170118000345.31196-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.403.g196674b8396b
In-Reply-To: <20170118000345.31196-1-jacob.e.keller@intel.com>
References: <20170118000345.31196-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Commit c8ba16391655 ("parse-options: add OPT_STRING_LIST helper",
2011-06-09) added the OPT_STRING_LIST as a way to accumulate a repeated
list of strings. However, this was not documented in the
api-parse-options documentation. Add documentation now so that future
developers may learn of its existence.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/technical/api-parse-options.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 27bd701c0d68..6914f54f5f44 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -168,6 +168,11 @@ There are some macros to easily define options:
 	Introduce an option with string argument.
 	The string argument is put into `str_var`.
 
+`OPT_STRING_LIST(short, long, &list, arg_str, description)`::
+	Introduce an option with string argument.
+	The string argument is stored as an element in `&list` which must be a
+	struct string_list. Reset the list using `--no-option`.
+
 `OPT_INTEGER(short, long, &int_var, description)`::
 	Introduce an option with integer argument.
 	The integer is put into `int_var`.
-- 
2.11.0.403.g196674b8396b

