Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 657EB2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbcHHVEQ (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32957 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbcHHVEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:09 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so17871044wme.0
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OhJDZh2EmByKsIHxjIUW0PN8ul2jagR4CQEimEbiaYA=;
        b=h+Cu080hImeNBWlPjwIxEQBLv+qrmWlhlKW2JrEVYZNS+3UlkNvvvKxh5zYLjm+7hW
         KTd1cyT+vxQt4ip1pBhVS7tCr0Rkanx3zV9tJxxkTYZZkwX/zHGXgPyPfLDdOd1wF+Qs
         y3hEEB+fwMfQP4wTA+16yqaJjypGYa6LNusVs2je4LiySBb7BNVjPQ+H5VWvyxjUU7k3
         1mS0eK9BIf4W7/gsA2FVibqkCX1/bjRJJuoWEONhzPVouAbgGf1IISwGZqprLzqFa2Wd
         zBu05/XhVd+PrceA/uwlSwM0fKBZVq/2qMwF0BKz5pAzSYHCRDVIafmnsCONhKWZq7/t
         0ZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OhJDZh2EmByKsIHxjIUW0PN8ul2jagR4CQEimEbiaYA=;
        b=PPEwJNdW+1o9vxpudPTYcpQyOKQoFhb1RIopcUCTEyVT81n/C0/Wafp1Ti6rzOrqly
         bDZ9DcWqzDvGMVbxpVOhp81sKVMbO4pnSlk85sbzYJ3ZpknjCqx+3K4S3nYaquFQDYot
         tm1yI6ptgmeUd383vwAsR+csfXyNFHEDNqWVEg5j3OE1xJWWjeklrMnVNyrdYGRx9X/n
         jUhp5761wrinel7+OyknZ9N5nOHhIKh+VU65Rhf28Nlx6PzokpQFYKPAjdrR0L7p3p9W
         yKF/WZCmS/ZBqCRkiimcjZ/FMTY/uZSPsQ/n+zIHBAC7PfM518/kn9/WiMHypnOXdavC
         MROw==
X-Gm-Message-State: AEkoouthjLk5bfAOTI/uGHRumz3PYNR/AiUO8+8n1zJEtNuFFaE5n+u34oMPi2gS43LXeQ==
X-Received: by 10.194.186.231 with SMTP id fn7mr86557672wjc.164.1470690248410;
        Mon, 08 Aug 2016 14:04:08 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:07 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v10 12/40] builtin/apply: make check_apply_state() return -1 instead of die()ing
Date:	Mon,  8 Aug 2016 23:03:09 +0200
Message-Id: <20160808210337.5038-13-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", check_apply_state() should return -1 instead of
calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 61fd316..bb89e07 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4551,17 +4551,17 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
-static void check_apply_state(struct apply_state *state, int force_apply)
+static int check_apply_state(struct apply_state *state, int force_apply)
 {
 	int is_not_gitdir = !startup_info->have_repository;
 
 	if (state->apply_with_reject && state->threeway)
-		die("--reject and --3way cannot be used together.");
+		return error("--reject and --3way cannot be used together.");
 	if (state->cached && state->threeway)
-		die("--cached and --3way cannot be used together.");
+		return error("--cached and --3way cannot be used together.");
 	if (state->threeway) {
 		if (is_not_gitdir)
-			die(_("--3way outside a repository"));
+			return error(_("--3way outside a repository"));
 		state->check_index = 1;
 	}
 	if (state->apply_with_reject)
@@ -4569,16 +4569,18 @@ static void check_apply_state(struct apply_state *state, int force_apply)
 	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
 		state->apply = 0;
 	if (state->check_index && is_not_gitdir)
-		die(_("--index outside a repository"));
+		return error(_("--index outside a repository"));
 	if (state->cached) {
 		if (is_not_gitdir)
-			die(_("--cached outside a repository"));
+			return error(_("--cached outside a repository"));
 		state->check_index = 1;
 	}
 	if (state->check_index)
 		state->unsafe_paths = 0;
 	if (!state->lock_file)
-		die("BUG: state->lock_file should not be NULL");
+		return error("BUG: state->lock_file should not be NULL");
+
+	return 0;
 }
 
 static int apply_all_patches(struct apply_state *state,
@@ -4747,7 +4749,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
 
-	check_apply_state(&state, force_apply);
+	if (check_apply_state(&state, force_apply))
+		exit(128);
 
 	ret = apply_all_patches(&state, argc, argv, options);
 
-- 
2.9.2.614.g4980f51

