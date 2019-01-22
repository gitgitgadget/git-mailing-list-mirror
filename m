Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 852811F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfAVVWS (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:22:18 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:44708 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfAVVWS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:22:18 -0500
Received: by mail-ed1-f45.google.com with SMTP id y56so20497477edd.11
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B57zKY0tVpm0sPzJeIH5jILjY5u/zvtFyxc81Xdjcq8=;
        b=HYc+HuzzFv2EATzffeg93IM/3HMDXoSzjLiz8DGCA94OKfpvQVhtyoeZTQP8Vyu4nZ
         j3jWa90JYE328/oQ+DaIql/PrjVI6HdJC/f0UHIerpeoQrGXInscMn3tlH75+FSfU4rH
         rlQiym0n12dZME8J654To5iIxdjrT3Osi2ng9iXdRbHYVylKUwDTe9qv6xxyg4yPm8dc
         2omvrdOO8UR5+TPeYqS9HlpwSnBX+Ti3Ng8nZl/YHA9ueQSLvxFpLC3Xw8Xtmq4wg+jk
         W4NIHmCFr368FcNxfsPcZAhotsu8vlmBoZm0mpG/Y4/ldANZy7CwD/dnvgCfToUGZtJw
         BqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B57zKY0tVpm0sPzJeIH5jILjY5u/zvtFyxc81Xdjcq8=;
        b=XQ+SRnBy4YFhRjQh/sV27eJPAL2a5vsto1pB3634YllHoo8DEeXG9k1j5vNRuOWd2R
         VGIoCpOlTXOzBGuBaAHZQIFfV4XLwmBiNYYT5rxCRnQOmn2Zj2z/kzbehdKbyrmJ3/Jx
         Vqteo6C1ZmkqdM6OQrrIIHGHp1yftqp0V/GKVjuaJ/aFr7ZPoRqOEAGU9jOV+ydnHpnO
         KUvvw2FReko77IQ7S/0aYqJxbb/Rt3FLNbzGQXo/bsy4UYfyLRuhKfVXTxdoOZJXmIsv
         lN82YTPkicmnN3u9soQ6kBeTueDnNZ0/6Fzf86rgOKGydsCox9Xxu6XlXxzCs1FSJ/W3
         HoSQ==
X-Gm-Message-State: AJcUukcrye9ps3Vsqe7YoHbVTFFazyewE0kYtCCQq/lFnRYryGwyzBHp
        oB4+wkM2m2o0ERrjNtU3tgUs+i6N
X-Google-Smtp-Source: ALg8bN59Ems7p7c0NygG0GSrCGqAPGZthkKwtewRIGMHOk+K86d8jVKSoVRxYcdWYjW7BxhR+8I1+A==
X-Received: by 2002:a17:906:9613:: with SMTP id s19-v6mr103459ejx.109.1548192136206;
        Tue, 22 Jan 2019 13:22:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k11sm9417731edq.51.2019.01.22.13.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:22:15 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:22:15 -0800 (PST)
X-Google-Original-Date: Tue, 22 Jan 2019 21:22:01 GMT
Message-Id: <978b9ebf0d263327e30ade48e1685077bc78cc81.1548192131.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 04/14] trace2:data: add trace2 regions to wt-status
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add trace2_region_enter() and trace2_region_leave() calls around the
various phases of a status scan.  This gives elapsed time for each
phase in the GIT_TR2_PERF and GIT_TR2_EVENT trace target.

Also, these Trace2 calls now use s->repo rather than the_repository.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 wt-status.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 0fe3bcd4cd..7c5ba4e902 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -748,12 +748,23 @@ static int has_unmerged(struct wt_status *s)
 
 void wt_status_collect(struct wt_status *s)
 {
+	trace2_region_enter("status", "worktrees", s->repo);
 	wt_status_collect_changes_worktree(s);
-	if (s->is_initial)
+	trace2_region_leave("status", "worktrees", s->repo);
+
+	if (s->is_initial) {
+		trace2_region_enter("status", "initial", s->repo);
 		wt_status_collect_changes_initial(s);
-	else
+		trace2_region_leave("status", "initial", s->repo);
+	} else {
+		trace2_region_enter("status", "index", s->repo);
 		wt_status_collect_changes_index(s);
+		trace2_region_leave("status", "index", s->repo);
+	}
+
+	trace2_region_enter("status", "untracked", s->repo);
 	wt_status_collect_untracked(s);
+	trace2_region_leave("status", "untracked", s->repo);
 
 	wt_status_get_state(s->repo, &s->state, s->branch && !strcmp(s->branch, "HEAD"));
 	if (s->state.merge_in_progress && !has_unmerged(s))
@@ -2291,6 +2302,12 @@ static void wt_porcelain_v2_print(struct wt_status *s)
 
 void wt_status_print(struct wt_status *s)
 {
+	trace2_data_intmax("status", s->repo, "count/changed", s->change.nr);
+	trace2_data_intmax("status", s->repo, "count/untracked", s->untracked.nr);
+	trace2_data_intmax("status", s->repo, "count/ignored", s->ignored.nr);
+
+	trace2_region_enter("status", "print", s->repo);
+
 	switch (s->status_format) {
 	case STATUS_FORMAT_SHORT:
 		wt_shortstatus_print(s);
@@ -2309,6 +2326,8 @@ void wt_status_print(struct wt_status *s)
 		wt_longstatus_print(s);
 		break;
 	}
+
+	trace2_region_leave("status", "print", s->repo);
 }
 
 /**
-- 
gitgitgadget

