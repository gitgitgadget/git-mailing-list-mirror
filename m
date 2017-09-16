Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE70B20A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbdIPIJD (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:09:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33684 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbdIPIIg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:36 -0400
Received: by mail-wm0-f67.google.com with SMTP id 187so4515355wmn.0
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DicLBJxOtH19Zbam87HxX/LRhWNp6sS0R4u3rqMiMwo=;
        b=ZHQ7NTjt+Xd1j/EGT2kDCUG3yOOYap3WcdxOjedai2XMcS66ZkKJpA4/sMDURmpa31
         ikNCfMM1mMZGci9pXioClUwB3afQTvSHokq597XpxsLx4doKd3bjhDNIqKnu7xRi1Vah
         2gFPIzlK6Wv/0+md8Pdbppf6+8Rq7hFznxv/FeYSet4ijV7c0OWb/ZbwLWY8twzG8ZuM
         Y43nOm15+XLucXjpbBRfipx6ausDmOuGgG7UjhBuUwg5iZbuHqGdqYq8Pxt5rqy2Hi67
         2myt7cds8MoWq0PByn4Uo9WBphGG2vS5citW0hezOW6uJcbqwKIvvcJ8Zjf03mOtzo/y
         A3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DicLBJxOtH19Zbam87HxX/LRhWNp6sS0R4u3rqMiMwo=;
        b=p4tQ1D/NhNzx7cUxyUgL9trLvK5ZVnZWSk/6SBgmt6kwEiATI3OAcUnBgR/UQolxO0
         ichwuiDGVwFgyITR2cSeU2CbTw9Pv6TOvcjeXBiGlTLxBxm747B0RBbfOQW1PxanGFaA
         2OBb3RKEXtbSUhtGM6ClLyiB+gWOvTpNGAbPXHuCxVPM3TXgLhw1Fq9la+O95D9PNe6b
         JL5wMhRYm00YJEKzvg4T8N9RD4a8VBj6pzRPxnjqABgUnmysGVwwJNZTuyIT2mI8XIZO
         zQt1lVU3pZb/4KnESDeYabVn5gWz8VRReHlXNBBgZya3CGrp4ngeymij4jlZI1KYSzEn
         rppw==
X-Gm-Message-State: AHPjjUjWh+sBcZ9rdWpRNAkg43rQxd2T6Z2UKgbi21C+CsDHLcFenA03
        cxWoQPiE4E0eGZE8
X-Google-Smtp-Source: AOwi7QAZEjAAk3BizareJe+sqww5meZuXWr3LiEqv7mujDs4U9V3yfF4bvXfDZ+CqW4VJenxLYWZmA==
X-Received: by 10.28.217.134 with SMTP id q128mr4883265wmg.116.1505549314937;
        Sat, 16 Sep 2017 01:08:34 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:34 -0700 (PDT)
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
Subject: [PATCH v6 36/40] clone: add --initial-refspec option
Date:   Sat, 16 Sep 2017 10:07:27 +0200
Message-Id: <20170916080731.13925-37-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option makes it possible to separate fetching refs when cloning
in two parts, an initial part and a later normal part.

This way after the initial part, mechanisms like the external odb
mechanism can be used to prefetch some objects using information
that has been made available during the initial fetch.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/clone.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 2e5d60521d..57cecd194c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -57,6 +57,7 @@ static enum transport_family family;
 static struct string_list option_config = STRING_LIST_INIT_NODUP;
 static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
 static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
+static struct string_list option_initial_refspec = STRING_LIST_INIT_NODUP;
 static int option_dissociate;
 static int max_jobs = -1;
 static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
@@ -107,6 +108,8 @@ static struct option builtin_clone_options[] = {
 			N_("reference repository")),
 	OPT_STRING_LIST(0, "reference-if-able", &option_optional_reference,
 			N_("repo"), N_("reference repository")),
+	OPT_STRING_LIST(0, "initial-refspec", &option_initial_refspec,
+			N_("refspec"), N_("fetch this refspec first")),
 	OPT_BOOL(0, "dissociate", &option_dissociate,
 		 N_("use --reference only while cloning")),
 	OPT_STRING('o', "origin", &option_origin, N_("name"),
@@ -869,6 +872,47 @@ static void dissociate_from_references(void)
 	free(alternates);
 }
 
+static struct refspec *parse_initial_refspecs(void)
+{
+	const char **refspecs;
+	struct refspec *initial_refspecs;
+	struct string_list_item *rs;
+	int i = 0;
+
+	if (!option_initial_refspec.nr)
+		return NULL;
+
+	refspecs = xcalloc(option_initial_refspec.nr, sizeof(const char *));
+
+	for_each_string_list_item(rs, &option_initial_refspec)
+		refspecs[i++] = rs->string;
+
+	initial_refspecs = parse_fetch_refspec(option_initial_refspec.nr, refspecs);
+
+	free(refspecs);
+
+	return initial_refspecs;
+}
+
+static void fetch_initial_refs(struct transport *transport,
+			       const struct ref *refs,
+			       struct refspec *initial_refspecs,
+			       const char *branch_top,
+			       const char *reflog_msg,
+			       int is_local)
+{
+	int i;
+
+	for (i = 0; i < option_initial_refspec.nr; i++) {
+		struct ref *init_refs = NULL;
+		struct ref **tail = &init_refs;
+		get_fetch_map(refs, &initial_refspecs[i], &tail, 0);
+		transport_fetch_refs(transport, init_refs);
+		update_remote_refs(refs, init_refs, NULL, branch_top, reflog_msg,
+				   transport, !is_local, 1);
+	}
+}
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
@@ -892,6 +936,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct refspec *refspec;
 	const char *fetch_pattern;
 
+	struct refspec *initial_refspecs;
+	int is_initial;
+
 	packet_trace_identity("clone");
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
@@ -1059,6 +1106,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
+	initial_refspecs = parse_initial_refspecs();
+
 	fetch_pattern = xstrfmt("+%s*:%s*", src_ref_prefix, branch_top.buf);
 	refspec = parse_fetch_refspec(1, &fetch_pattern);
 	free((char *)fetch_pattern);
@@ -1114,6 +1163,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	refs = transport_get_remote_refs(transport);
 
 	if (refs) {
+		fetch_initial_refs(transport, refs, initial_refspecs,
+				   branch_top.buf, reflog_msg.buf, is_local);
+
 		mapped_refs = wanted_peer_refs(refs, refspec);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
@@ -1173,9 +1225,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	else if (refs && complete_refs_before_fetch)
 		transport_fetch_refs(transport, mapped_refs);
 
+	is_initial = !refs || option_initial_refspec.nr == 0;
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
 			   branch_top.buf, reflog_msg.buf, transport,
-			   !is_local, 0);
+			   !is_local, is_initial);
 
 	update_head(our_head_points_at, remote_head, reflog_msg.buf);
 
-- 
2.14.1.576.g3f707d88cd

