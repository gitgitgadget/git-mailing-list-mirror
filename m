Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 22577 invoked by uid 111); 5 Nov 2007 12:03:36 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 05 Nov 2007 07:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754673AbXKEMD2 (ORCPT <rfc822;peff@peff.net>);
	Mon, 5 Nov 2007 07:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754565AbXKEMD2
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 07:03:28 -0500
Received: from pan.madism.org ([88.191.52.104]:52833 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792AbXKEMD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 07:03:26 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 97AA92888A;
	Mon,  5 Nov 2007 13:03:25 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 6DFC38525; Mon,  5 Nov 2007 13:03:24 +0100 (CET)
From:	Pierre Habouzit <madcoder@debian.org>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 2/4] Some better parse-options documentation.
Date:	Mon,  5 Nov 2007 13:03:22 +0100
Message-Id: <1194264204-3475-3-git-send-email-madcoder@debian.org>
X-Mailer: git-send-email 1.5.3.5.1531.g59008
In-Reply-To: <1194264204-3475-2-git-send-email-madcoder@debian.org>
References: <1194264204-3475-1-git-send-email-madcoder@debian.org>
 <1194264204-3475-2-git-send-email-madcoder@debian.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org

---
 parse-options.h |   37 +++++++++++++++++++++++++++++++++++--
 1 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index 3a470e5..65bce6e 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -22,6 +22,41 @@ enum parse_opt_option_flags {
 struct option;
 typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
 
+/*
+ * `type`::
+ *   holds the type of the option, you must have an OPTION_END last in your
+ *   array.
+ *
+ * `short_name`::
+ *   the character to use as a short option name, '\0' if none.
+ *
+ * `long_name`::
+ *   the long option name, without the leading dashes, NULL if none.
+ *
+ * `value`::
+ *   stores pointers to the values to be filled.
+ *
+ * `argh`::
+ *   token to explain the kind of argument this option wants. Keep it
+ *   homogenous across the repository.
+ *
+ * `help`::
+ *   the short help associated to what the option does.
+ *   Must never be NULL (except for OPTION_END).
+ *   OPTION_GROUP uses this pointer to store the group header.
+ *
+ * `flags`::
+ *   mask of parse_opt_option_flags.
+ *   PARSE_OPT_OPTARG: says that the argument is optionnal (not for BOOLEANs)
+ *   PARSE_OPT_NOARG: says that this option takes no argument, for CALLBACKs
+ *
+ * `callback`::
+ *   pointer to the callback to use for OPTION_CALLBACK.
+ *
+ * `defval`::
+ *   default value to fill (*->value) with for PARSE_OPT_OPTARG.
+ *   CALLBACKS can use it like they want.
+ */
 struct option {
 	enum parse_opt_type type;
 	int short_name;
@@ -32,8 +67,6 @@ struct option {
 
 	int flags;
 	parse_opt_cb *callback;
-	/* holds default value for PARSE_OPT_OPTARG,
-	   though callbacks can use it like they want */
 	intptr_t defval;
 };
 
-- 
1.5.3.5.1531.g59008

