Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4914720A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbdIPIIx (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:08:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35083 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdIPIIh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id e64so4517705wmi.2
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0aUN6VrqfWoI5QHTm9eq5b53HZ/QJE2xTzsL/DlNBOQ=;
        b=Sj7XWHRK2ickns55LmlOGDhojL5Rrjf7zdzzYmfx7mhaFUUw+W+xfFqk7XqSYwFi7i
         EyzhEYScjMWsUbBA0WFisOg/7qskVfmyJXpo75kX2HXQtJrvqcX2l7dOtPoY0/h4KSu+
         bo+1p2ZccmTAuqcpyhnKmELN0tf81Tn7LTGHyIDWYQ2hmGXvgssdNPY2pZQ7YPza5jYm
         yQ9K0ibzPaaZBwH/0PDpHnBm5iWJ2Yh0Q+vPdamnpYYnoMAtM3a/TRa2PNYPKlhJSNwI
         JkrsRcG33INNmpgbcpmGvd2ZThlNPyaYAfF/2+rpk+2jo/L7LzM1SFDpfNyFmDW/td2T
         HNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0aUN6VrqfWoI5QHTm9eq5b53HZ/QJE2xTzsL/DlNBOQ=;
        b=FEkUtvL6ZkHxicOHyDtT0o1NQZ1XkMH0eO4YSimSuof6dDGqe3A/GD/MpXbhvMpwlQ
         i/nwsnN0Ow6RtnYgl7hoKW5gT7l3qZThnCL1u0LkGh8oUVNDUpls1OLSlHMe6L2h0cbk
         RlKRicUhnbt2M+cxqUioSiumaTD5atSNnvXp0C2yS1iojoimRi1xAi+q/Azpq8/PrQgv
         OaYWMzcQPpfG5GT+4D/xg+nCKYvNagbwwc4ePGTBQE5Qeq4rylWM7ZOcaE7vozO2+yVk
         uC8HmHz7ircEI9SeQYhi3K9S82I6d9hgwj7WCewKEw6Z4t58ZCjcNte8z6S2myqKoQIr
         Fz0Q==
X-Gm-Message-State: AHPjjUjnLk97v+4KiRL+y4vrBPpt9+k2xk5Z+kejmb8zT1c9hf0am6QE
        0cLx+Oj1u6rzkjE1
X-Google-Smtp-Source: AOwi7QBvfYrRJlS7Vp6uvI8s/cvHYVQSR6/KpG+3V0+6mv0fwDJGBc5p1+gv27mFZ/IX6Ez4y9wS/w==
X-Received: by 10.28.165.1 with SMTP id o1mr5072062wme.31.1505549316203;
        Sat, 16 Sep 2017 01:08:36 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:35 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 37/40] clone: disable external odb before initial clone
Date:   Sat, 16 Sep 2017 10:07:28 +0200
Message-Id: <20170916080731.13925-38-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make it possible to have the external odb mechanism only kick in
after the initial part of a clone, we should disable it during the
initial part of the clone.

Let's do that by saving and then restoring the value of the
'use_external_odb' global variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/clone.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 57cecd194c..323b73016e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -938,6 +938,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	struct refspec *initial_refspecs;
 	int is_initial;
+	int saved_use_external_odb;
 
 	packet_trace_identity("clone");
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
@@ -1083,6 +1084,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
+	/* Temporarily disable external ODB before initial clone */
+	saved_use_external_odb = use_external_odb;
+	use_external_odb = 0;
+
 	if (option_bare) {
 		if (option_mirror)
 			src_ref_prefix = "refs/";
@@ -1166,6 +1171,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		fetch_initial_refs(transport, refs, initial_refspecs,
 				   branch_top.buf, reflog_msg.buf, is_local);
 
+		use_external_odb = saved_use_external_odb;
+
 		mapped_refs = wanted_peer_refs(refs, refspec);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
@@ -1207,6 +1214,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					option_branch, option_origin);
 
 		warning(_("You appear to have cloned an empty repository."));
+
+		use_external_odb = saved_use_external_odb;
+
 		mapped_refs = NULL;
 		our_head_points_at = NULL;
 		remote_head_points_at = NULL;
-- 
2.14.1.576.g3f707d88cd

