Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,UNWANTED_LANGUAGE_BODY
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48DF01F461
	for <e@80x24.org>; Wed, 21 Aug 2019 19:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfHUTSl (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 15:18:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33565 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbfHUTSk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 15:18:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id p77so5436497wme.0
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 12:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YVfeQYx2NkqyE6J8qU4sfnayQfPy8D/xAQ+WjoPsz60=;
        b=u2dK5NkRakqQyivd2k5bYmbNMGs5t13iHBEQ9I7IMb70tOlCiKAppiYA/99g/QOlJV
         8jsaEkWabzH0x+Odf1oHjFuC6aBqwTF5/MYF9eSwnPWD6VwA86ppt9XfgI4u5ZcHhkxL
         TGKyyckUTdehCr2FHMigKuszzI9/GtwkisHssS+zQ6twA4RW7DMd+Ep8zvwyWbk9Ka/V
         dNO4Ae9u1xBn+5wOjl+Zh+Y4C4t9PHi7KdNSl2CYleboTBDbyRcE2yiy9uO9uJkID8KV
         L7yy2lodScwc+A2iFsSVtUi/UtC884fXOpOLD7LtKkrKk2tNSBaXrU4+6Kxt88pZCGNX
         nqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YVfeQYx2NkqyE6J8qU4sfnayQfPy8D/xAQ+WjoPsz60=;
        b=lb7gKhnHI2lK+/n6AhBOc3umi+t2JiQrKvVJHiWKHtrpuJVSaHlK6iZn7ao4sbW0JT
         bpziCAbkdcHj31mJgIOtBwGlw/sBwDN+sdvmkOjC14d1NXk9VZnmr1kXcgjjZQpvyFgk
         AwuRtDbEpbmawr8Ja3V4UFFQbLwWx0UYjlw+1SdX2CXyiXZ6XW1gc1GaRZ75vkoe63Hj
         ef/EVGGQobGz+Qb/VWB6fLOHtlQ+NwK1z+HBCzeqyN9oirSRSFWnTJ3089NkhLf3kBPo
         bWPU0RlJeaCvCLRh9QcLRSqgDajhusqWNJ4JgX+VUW9/lhYFmA0WiQOxMy7aYjGfVQmd
         ySwg==
X-Gm-Message-State: APjAAAWhLvg738m9EiR+xZLy4TsK2IYk3dXK+XbUHe8+OoxhM37/zrOk
        Vk5Jai0HKaRh6sunx3cDA4E2mJG+
X-Google-Smtp-Source: APXvYqyGlt3mQF34fmr5NpQLjiC2oJ8ASkxep4S7dgbD8z5wxBUNJvf/vYPajud8TFVcWLW+EpLXDg==
X-Received: by 2002:a1c:3944:: with SMTP id g65mr1903388wma.68.1566415115194;
        Wed, 21 Aug 2019 12:18:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm22303710wrx.59.2019.08.21.12.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 12:18:34 -0700 (PDT)
Date:   Wed, 21 Aug 2019 12:18:34 -0700 (PDT)
X-Google-Original-Date: Wed, 21 Aug 2019 19:18:32 GMT
Message-Id: <dd3b5120077dd0414c62b8deaeaaffa40bc47736.1566415112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.317.git.gitgitgadget@gmail.com>
References: <pull.317.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] DEPRECATION: warn about 'git checkout -b'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, git@jeffhostetler.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Recommend that users use 'git switch -c' instead.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/.checkout.c.swp | Bin 77824 -> 0 bytes
 builtin/checkout.c      |   9 ++++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)
 delete mode 100644 builtin/.checkout.c.swp

diff --git a/builtin/.checkout.c.swp b/builtin/.checkout.c.swp
deleted file mode 100644
index f6dad4abb02c265ee66b3f6f76d00d59b9b524a4..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 77824
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%0D($Rh0-7;8R*3|qhA%&XMH
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
Ul^dyn{$I$!_h?IFGP36X2Rz^&;s5{u

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f894b9de1a..32c8edccaf 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1133,6 +1133,7 @@ static int switch_branches(const struct checkout_opts *opts,
 	void *path_to_free;
 	struct object_id rev;
 	int flag, writeout_error = 0;
+	int do_merge = 1;
 
 	trace2_cmd_mode("branch");
 
@@ -1159,15 +1160,20 @@ static int switch_branches(const struct checkout_opts *opts,
 		if (!new_branch_info->commit)
 			die(_("You are on a branch yet to be born"));
 		parse_commit_or_die(new_branch_info->commit);
+
+		if (opts->only_merge_on_switching_branches)
+			do_merge = 0;
 	}
 
 	/* optimize the "checkout -b <new_branch> path */
-	if (skip_merge_working_tree(opts, &old_branch_info, new_branch_info)) {
+	if (!do_merge || skip_merge_working_tree(opts, &old_branch_info, new_branch_info)) {
 		if (!checkout_optimize_new_branch && !opts->quiet) {
 			if (read_cache_preload(NULL) < 0)
 				return error(_("index file corrupt"));
 			show_local_changes(&new_branch_info->commit->object, &opts->diff_options);
 		}
+		if (!opts->only_merge_on_switching_branches)
+			warning(_("'git checkout -b <new-branch>' is being deprecated in favor of 'git switch -c <new-branch>'. Please adjust your workflow accordingly."));
 	} else {
 		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
 		if (ret) {
@@ -1867,6 +1873,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	opts.accept_ref = 1;
 	opts.accept_pathspec = 0;
 	opts.switch_branch_doing_nothing_is_ok = 0;
+	opts.only_merge_on_switching_branches = 1;
 	opts.implicit_detach = 0;
 	opts.can_switch_when_in_progress = 0;
 	opts.orphan_from_empty_tree = 1;
-- 
gitgitgadget
