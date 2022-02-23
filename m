Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB569C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243951AbiBWScU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243908AbiBWScK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:32:10 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FB34B86D
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:25 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id w13so13813147wmi.2
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=x8+sZRlT+5AjxhkuyEq88suJEF1Kw89D8eIrUkKrH5U=;
        b=WkKQjfmKYp66FUkrRCSUwahp80R1IjxJwHxBCLyXM+gQqPh3Q2WLXVC9sDHby7Fq+l
         ZvckKtcOvT85AilyULd6+x5Y0g6k7tDwMTs6tE9T4fDU6YGyGesqxBNsbfqD2/hrNWpy
         NS/jK9/lFJmefc2obfK1qTHmop8q6OD/upCe71PurR2/HWAA1Q31vIQBJM6bBMCyBS9b
         aXFfbvyxnXviPa0fEERDt3L60atip7trvABw6ixJiZTAgk+osl9F2y2kl/DZgIFOi5bh
         adSlBlRgmSmqa2bvhP9v25+RYSBFAbRnjX6zc/viRCPBHX19J9gQPIxGkMsM4zUfxxrq
         abVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=x8+sZRlT+5AjxhkuyEq88suJEF1Kw89D8eIrUkKrH5U=;
        b=YRJbt9RGjKQEYPsyNnXp3YjiBLHZreEHZWd62XtTdiCMUU80wWarQ0tU0fI3GkQI9B
         8+npU803Ai4PgumZFIdRzHbYExHoo0FO0g5Vrm32o8YIfYhJq8Y6xdCVUEgLRYPmTjGJ
         Fd+4EoUKk2BlRKvCSbu0IwXoWk0Lt9VY3GugKIbYYg533NvGLzf09+Z4WiTakuUc75l0
         itlCVbcAP30EAHJLnRPB8LiUdL0KpN7bopnQZHZSGjHQoPHQjww9dhJi88DdcHVhe50C
         gbvgu3y2vTJoPuwQpOzXTILN5252FuvWTYIy+r+2nm9CPq9/YqNxXmLhQP+mXw1Iwy8v
         QdgQ==
X-Gm-Message-State: AOAM530VLxDnN8S9mhJm1n24LMJdW6yWBI5gHJke6gw6QnJBYs+2Hufp
        pQIEjUgpSb0lPzCV/lLmdrkNgFIzBoc=
X-Google-Smtp-Source: ABdhPJxds8X5tPkA0A4tvVaayPdxzOECqGYr3LTrsb8dwyCmVWYdSfoygFbdiXKOPd2iy/0Kr4rJyQ==
X-Received: by 2002:a05:600c:215:b0:37c:729:f84d with SMTP id 21-20020a05600c021500b0037c0729f84dmr8626045wmi.131.1645641083834;
        Wed, 23 Feb 2022 10:31:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u15sm457012wrs.18.2022.02.23.10.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:23 -0800 (PST)
Message-Id: <cf184fd1d34b5613fd1e28fd5da75a475c25884f.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:30:56 +0000
Subject: [PATCH 18/25] connect.c: refactor sending of agent & object-format
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, aevar@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

Refactor the sending of the "agent" and "object-format" capabilities
into a function.

This was added in its current form in ab67235bc4 (connect: parse v2
refs with correct hash algorithm, 2020-05-25). When we connect to a v2
server we need to know about its object-format, and it needs to know
about ours. Since most things in connect.c and transport.c piggy-back
on the eager getting of remote refs via the handshake() those commands
can make use of the just-sent-over object-format by ls-refs.

But I'm about to add a command that may come after ls-refs, and may
not, but we need the server to know about our user-agent and
object-format. So let's split this into a function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 connect.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/connect.c b/connect.c
index eaf7d6d2618..9d78d681e95 100644
--- a/connect.c
+++ b/connect.c
@@ -473,6 +473,24 @@ void check_stateless_delimiter(int stateless_rpc,
 		die("%s", error);
 }
 
+static void send_capabilities(int fd_out, struct packet_reader *reader)
+{
+	const char *hash_name;
+
+	if (server_supports_v2("agent", 0))
+		packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
+
+	if (server_feature_v2("object-format", &hash_name)) {
+		int hash_algo = hash_algo_by_name(hash_name);
+		if (hash_algo == GIT_HASH_UNKNOWN)
+			die(_("unknown object format '%s' specified by server"), hash_name);
+		reader->hash_algo = &hash_algos[hash_algo];
+		packet_write_fmt(fd_out, "object-format=%s", reader->hash_algo->name);
+	} else {
+		reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
+	}
+}
+
 struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     struct ref **list, int for_push,
 			     struct transport_ls_refs_options *transport_options,
@@ -480,7 +498,6 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     int stateless_rpc)
 {
 	int i;
-	const char *hash_name;
 	struct strvec *ref_prefixes = transport_options ?
 		&transport_options->ref_prefixes : NULL;
 	char **unborn_head_target = transport_options ?
@@ -490,18 +507,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	if (server_supports_v2("ls-refs", 1))
 		packet_write_fmt(fd_out, "command=ls-refs\n");
 
-	if (server_supports_v2("agent", 0))
-		packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
-
-	if (server_feature_v2("object-format", &hash_name)) {
-		int hash_algo = hash_algo_by_name(hash_name);
-		if (hash_algo == GIT_HASH_UNKNOWN)
-			die(_("unknown object format '%s' specified by server"), hash_name);
-		reader->hash_algo = &hash_algos[hash_algo];
-		packet_write_fmt(fd_out, "object-format=%s", reader->hash_algo->name);
-	} else {
-		reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
-	}
+	/* Send capabilities */
+	send_capabilities(fd_out, reader);
 
 	if (server_options && server_options->nr &&
 	    server_supports_v2("server-option", 1))
-- 
gitgitgadget

