Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 289431F404
	for <e@80x24.org>; Mon,  1 Jan 2018 22:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbeAAWzH (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jan 2018 17:55:07 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37794 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752296AbeAAWyx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jan 2018 17:54:53 -0500
Received: by mail-wm0-f68.google.com with SMTP id f140so58290497wmd.2
        for <git@vger.kernel.org>; Mon, 01 Jan 2018 14:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wosXIb8419TCHOOFSsY3h2KIXeHdTBLETaSlfHCCWGk=;
        b=L5nnocwfDlWOqSDnWAV8wcHvXyNg92LMz0KcI8phbfd9jJI5PE+JJXodZC6rb4U/P2
         cLixLRAH/ZJEFCjxDvAnuTKXM2z1lc6G/Y/dmj7bO+zgTZIou6cgg/YaUIAoI7ojvhaT
         qnz+fFmDdRSAiKsu4RqTEn7ddOYWjgy1JdOThcB+jz1SKBtnZHxPGcVPsQiXZ7t7c06E
         dOO+ecLTwjOgKjyxdr2V/QpSQvlJyDB9ai0c3Wi1/hVYESgcOQTvt6PUxH7uk+uJTwVW
         O042fvfDanlC3InEoFAJ73G6HnoYqH5Z32wKgRcnGXgWTROyxkKj7hCWY/24LXTcCGoY
         fQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wosXIb8419TCHOOFSsY3h2KIXeHdTBLETaSlfHCCWGk=;
        b=iKj2ABRtFztBRh4peWCeD7nsGshEUwNxpy6w5HKi2GvfPjz+E7amrsmaMUG2Jt4Dlg
         vzSlMbUpqPKlqbX87vCIEaLNI8Kk2TH5/RvOPdZyaeqYQmTUmoYmLuf2nm6pKXuH5VJE
         kDKz9JZHbNuwILvGucj5PShQ5DfhCgd1jRzv37kCbYJ/qKhD4UVKhe4oU5WdpbkliK2B
         w0+Emdn7ZREnWZ8mpg79k8qulyyJOlhwp6+sfdGNVpb3WBwJep+25t3yxCWdOVHrEF4B
         qN2kIDh0Td8CoIGyxt6jkG7vIR8NtnOG4CVXxbnws2GZHQ865W2rWICfjddt/fpQ28WQ
         r6Ig==
X-Gm-Message-State: AKGB3mK6c9Oz20TST2Fgxy+sglsHAUXotsdCbZ2VywuWHkWbO34ySKca
        u2URoIkeBQgDnhV9hSlY3Z4=
X-Google-Smtp-Source: ACJfBoviB5K8bj9D3biBTlnKz27RstOqn2hWUvWqCX+dAgvK2Gh+BftzJmwOE1iC054I3fyoUxPzYw==
X-Received: by 10.28.6.21 with SMTP id 21mr31967524wmg.73.1514847292552;
        Mon, 01 Jan 2018 14:54:52 -0800 (PST)
Received: from localhost.localdomain (94-21-23-100.pool.digikabel.hu. [94.21.23.100])
        by smtp.gmail.com with ESMTPSA id d7sm54186061wrd.54.2018.01.01.14.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jan 2018 14:54:52 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/4] branch: '--edit-description' is incompatible with other options
Date:   Mon,  1 Jan 2018 23:54:45 +0100
Message-Id: <20180101225448.2561-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.67.g3a46dbca7
In-Reply-To: <20180101225448.2561-1-szeder.dev@gmail.com>
References: <20180101225448.2561-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'--edit-description' is incompatible with 'git branch's other options,
but the check for conflicting options doesn't look for this option.
As a result 'git branch' doesn't error out showing usage when
'--edit-description' is used in combination with other options, but
e.g. 'git branch --list --edit-description' lists all branches and
doesn't edit any branch descriptions, while 'git branch
--edit-description --list' edits the current branch's description but
doesn't list the branches.

Look for '--edit-description', too, when looking for conflicting
options.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 8dcc2ed05..32531aa44 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -662,7 +662,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		list = 1;
 
 	if (!!delete + !!rename + !!copy + !!new_upstream +
-	    list + unset_upstream > 1)
+	    list + unset_upstream + edit_description > 1)
 		usage_with_options(builtin_branch_usage, options);
 
 	if (filter.abbrev == -1)
-- 
2.16.0.rc0.67.g3a46dbca7

