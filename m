Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 638C71F461
	for <e@80x24.org>; Mon, 15 Jul 2019 22:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbfGOWpB (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jul 2019 18:45:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35434 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730912AbfGOWpA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jul 2019 18:45:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id s1so2093726pgr.2
        for <git@vger.kernel.org>; Mon, 15 Jul 2019 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3QvtWsxQ5Tq2b0Qw9+MJXQWEWI5kGOvPqOV8qh2H+iM=;
        b=SkRk+SvaTW8vO9qFDRpqRjtWEihTQXYG4P+qT/XMEqD/acqKDQzrSdFRPUaJNZgrsu
         z3Zhywd9fknKcjDNqgm3ROdq388RAb6I2IUeNeN8T/95YIh83m689MSnTEk5HtCLkQq0
         8NA//HVU/yOMQL6i3KXJBJuUqREFLBUQhXD9LMMYxXqWQZ6m8NGSYasdSUtKSg943f6X
         uB/jnwnQQzFj10dYevbCGsdPlfdFMYVwYQ6lHzIYfKeu64JJdF2lxL/5mNYHUPhRorRw
         AXRyoZf74gxUpQfwW5/3b3ySR1+ymSILDbJ/gn97mxOMU5tKVmMli7bFxocFhR9rn8MQ
         6T5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3QvtWsxQ5Tq2b0Qw9+MJXQWEWI5kGOvPqOV8qh2H+iM=;
        b=IeP6+/ECKHgfOdCvI38E6X/QfkO6cz3y4khIz/hweSESoHndVs+AvwKhuQB6R9I8Cj
         +G090hEVe9WV6ryOE3KF0PeBtDIldEincukVbUXruVVsihpiHSZGaBxDYU+tbrEZ8U6G
         hf7kRXusvXn3Rqa2PJ/dUl/E/dhEryPYOxovAQ8Qji56wM/YOE0D7szVJiipmbF+78+D
         mfuicwYMjiPYV7ytRDrzQLNFtUy+AZkSmiTWQbn7Jawxt4BrET7jM/wc05VogZbNmtMz
         KJBIr4WtX1Omk3q37eFnpwFK9OUwsjhsMEWjjCPr48kf/JUdINO5vH7s1VJlZeOga+aH
         LttA==
X-Gm-Message-State: APjAAAWAmO/BeRNPG2NO6aSy4eiDt5YXbbWAT0ntuffIZIJ4Y0mrWcCs
        rC+36hejUzSFHMHALyioQ6gcr3x0AA8=
X-Google-Smtp-Source: APXvYqzaZhNJ8mbzRhTYj9y7PQ4qOaWwMq0mMYyJVZqyIYqmMf95EYngHHoEc8bY7lSPVEiS0GV0AA==
X-Received: by 2002:a17:90a:2627:: with SMTP id l36mr32690267pje.71.1563230699930;
        Mon, 15 Jul 2019 15:44:59 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.215])
        by smtp.gmail.com with ESMTPSA id 33sm24907882pgy.22.2019.07.15.15.44.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 15:44:59 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, phillip.wood123@gmail.com,
        rohit.ashiwal265@gmail.com
Subject: Re: [GSoC][PATCH 1/1] rebase -i: add --ignore-whitespace flag
Date:   Tue, 16 Jul 2019 04:12:17 +0530
Message-Id: <20190715224217.18556-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <xmqqd0ib3q8x.fsf@gitster-ct.c.googlers.com>
References: <xmqqd0ib3q8x.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On Mon, 15 Jul 2019 15:08:30 -0700 Junio C Hamano <gitster@pobox.com> wrote:
>
> Doesn't it also come from handling OPT_STRING() via parse_options(),
> which gives a pointer from argv[], freeing something that is not
> allocated in the first place?

Ah! The path from cmd_rebase__interactive! A simple workaround could be:

diff --git a/builtin/rebase.c b/builtin/rebase.c
index c55957c31f..afe376c3fe 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -525,6 +525,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
        argc = parse_options(argc, argv, NULL, options,
                        builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);

+       opts.strategy_opts = xstrdup_or_null(opts.strategy_opts);
+
        if (!is_null_oid(&squash_onto))
                opts.squash_onto = &squash_onto;

