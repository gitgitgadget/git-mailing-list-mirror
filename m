Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CA8F1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 00:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391705AbfJQAxp (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 20:53:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45388 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390010AbfJQAxo (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Oct 2019 20:53:44 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8C7E361C47;
        Thu, 17 Oct 2019 00:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1571273623;
        bh=lmjjv3oiXsPr7ZloqSVOf7Kc+lHCMgGF2gUmMqZ7dQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=jprBQTudAizCZVYYdFhq1pSm6T3bzGcgT5u3wlZrmEGWGeuTmuu7ShfRLm3g9R7rG
         ZECoN1EmVYsK8wRW+MUeRIuiGaY58gfjxMUpSXhz5IzJwvHZRI5hH9muLd9WXzOyTI
         VCOszPMy3P27K5Q5OS049m2X/sYMYJ4hvjD/acZdROUGZppkhgSdAiyEm2RmLRlmkR
         /YLtoDgDSXwxfSbgvcP9RAAdaor4nTDPwG5bn1x91zKEKQVNx6NjvhpK2uqxLtOIa3
         2XjopSHNouZLjw0+Ef//o7ZirFlDvX6gHykWBa9CP6esuho2w45SO6bJJSvKQpOoEw
         luXrRxE36sgZEiDlsUFMC2UG6kuIrGoRkUeLIteckklBmIfTF7Py5CnNvZ0Frw01XH
         ajHy3HIqAlac9S7nhr3XP/7+alG3HJqm3J1V5ItjFjuwal7Uo+s1VeW5V8AiTEFv1L
         qrXHrL9iUXjMWCemOb8ryhrr+ewJcfMuPoLqAs4+uq9QwOEbLYx
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] doc: provide guidance on user.name format
Date:   Thu, 17 Oct 2019 00:53:28 +0000
Message-Id: <20191017005330.9021-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c
In-Reply-To: <20191017005330.9021-1-sandals@crustytoothpaste.net>
References: <20191017005330.9021-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's a frequent misconception that the user.name variable controls
authentication in some way, and as a result, beginning users frequently
attempt to change it when they're having authentication troubles.
Document that the convention is that this variable represents some form
of a human's personal name, although that is not required.  In addition,
address concerns about whether Unicode is supported.

Use the term "personal name" as this is likely to draw the intended
contrast, be applicable across cultures which may have different naming
conventions, and be easily understandable to people who do not speak
English as their first language.  Indicate that "some form" is
conventionally used, as people may use a nickname or preferred name
instead of a full legal name.

Point users who may be confused about authentication to an appropriate
configuration option instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-commit-tree.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 4b90b9c12a..c794843634 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -92,6 +92,12 @@ if set:
 
 (nb "<", ">" and "\n"s are stripped)
 
+The author and committer names are by convention some form of a personal name,
+although Git does not enforce or require any particular form. Arbitrary Unicode
+may be used, subject to the constraints listed above. This name has no effect on
+authentication; for that, see the `credential.username` variable in
+linkgit::git-config[1].
+
 In case (some of) these environment variables are not set, the information
 is taken from the configuration items user.name and user.email, or, if not
 present, the environment variable EMAIL, or, if that is not set,
