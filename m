Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55CE21F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 23:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbeKMJVZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 04:21:25 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:43328 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbeKMJVY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 04:21:24 -0500
Received: by mail-pf1-f178.google.com with SMTP id g7-v6so5031354pfo.10
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 15:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FRWGA22dzFQWCZOJChCzjX6OjwzYf5Iw7DwovKavuRs=;
        b=i1KJZhpvE3cYjMyYTpvvxcfkrrNf0FPj2XsYYv2gPnEx376CLhYU970S1A5cXpirgo
         FkPbwdPXDCoXY32FFgBwXaZs7W6saEmBCe+r2UWeF5abdp5nUhPcMJ5hnQpGpgRXkSx1
         7jdwt70GgcvWJIGARnIGRAJDSOVbBIiQvmu2DUaUdOPoMIG0Hf4PgSe01ZnkQHMDY5ma
         l1BB4enKfLCRRN5cya5cBgjrmB1NGkkPHQh6Gz4OYfmdTA1eUPpryZU/d7hWwCgKKQd4
         ur0gybEOc/C2AvQMmSyudSyyBQOesXZ7DtmBPyOP6OCY3qDe43BMmyOZ4+jQAY83sdFh
         tduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FRWGA22dzFQWCZOJChCzjX6OjwzYf5Iw7DwovKavuRs=;
        b=gjVT2oeee5AXdl/wSsmfgGJyXVFg0OxiTKFfFVtoTxNDRaXPN93vJpMFdiolCWMBME
         5u6dKbiuP4VmDeZjGloY4dgn3coOwS/jLDfFl0hiIn6NZuvPwJiacOagYKZseVw5s0fx
         PZyDbiStukbHTQGk9zAnhE9tWvgkgx6zpWBhmgXZrl9uxUxOX6vz17Ih7U76gEdKGWdS
         dw1x2qyOz2zkt+c0nUmQLRMTxtqgstg109/f6Oh7I8et1S0yt0qjyJIM7hOBSZMYJyG/
         vfkfipTUJpeC+nE5ZJ8Xak5hBx9yj4oQh1e56z3vIxvz2+K2YyWAF74ArtfVqeYVhiX5
         nRog==
X-Gm-Message-State: AGRZ1gI8ekCV2fw9YTkcAedojLSmVUZ1EfYqC/Nc1x9++AfOgVwbQsm3
        BqjtHJZrytKYEancv8PA+yEHAkRj
X-Google-Smtp-Source: AJdET5fqQ4kJNvhn1K+AKIkVk2kMDOUT++1QAQD8VtfEPBoCEQv38FfhpqoaJRaZR0891TBB/NqJJA==
X-Received: by 2002:a63:d208:: with SMTP id a8mr2525408pgg.77.1542065162996;
        Mon, 12 Nov 2018 15:26:02 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id k25-v6sm4063171pfj.13.2018.11.12.15.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 15:26:02 -0800 (PST)
Date:   Mon, 12 Nov 2018 15:26:02 -0800 (PST)
X-Google-Original-Date: Mon, 12 Nov 2018 23:25:53 GMT
Message-Id: <7b2f5e37f4dca7cafb4d6ea5eebafc31e120a339.1542065154.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.75.git.gitgitgadget@gmail.com>
References: <pull.75.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 5/5] status: rebase and merge can be in progress at the same
 time
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since `git rebase -r` was introduced, that is possible. But our
machinery did not think that possible, and failed to say anything about
the rebase in progress when in the middle of a merge.

Let's work around that in the minimal fashion.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 wt-status.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 187568a112..a24711374c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1559,6 +1559,7 @@ void wt_status_get_state(struct wt_status_state *state,
 	struct object_id oid;
 
 	if (!stat(git_path_merge_head(the_repository), &st)) {
+		wt_status_check_rebase(NULL, state);
 		state->merge_in_progress = 1;
 	} else if (wt_status_check_rebase(NULL, state)) {
 		;		/* all set */
@@ -1583,9 +1584,13 @@ static void wt_longstatus_print_state(struct wt_status *s)
 	const char *state_color = color(WT_STATUS_HEADER, s);
 	struct wt_status_state *state = &s->state;
 
-	if (state->merge_in_progress)
+	if (state->merge_in_progress) {
+		if (state->rebase_interactive_in_progress) {
+			show_rebase_information(s, state_color);
+			fputs("\n", s->fp);
+		}
 		show_merge_in_progress(s, state_color);
-	else if (state->am_in_progress)
+	} else if (state->am_in_progress)
 		show_am_in_progress(s, state_color);
 	else if (state->rebase_in_progress || state->rebase_interactive_in_progress)
 		show_rebase_in_progress(s, state_color);
-- 
gitgitgadget
