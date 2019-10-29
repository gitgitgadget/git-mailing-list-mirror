Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 428241F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 08:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfJ2ITv (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 04:19:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42955 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbfJ2ITv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 04:19:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14so8987555pgi.9
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 01:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VHsZStNjA73Ae4uFiJi/g7h897WcLJ+U162SE+386R8=;
        b=ZMaOoeynpMnEJa61s7FgfP47+FB5KKexEL7SiJiaQ9sZY2MsTF5oW8m6Ng3NvEoiTk
         p6fQYl7PsEQ8QAT/nQqXHC1ysygWsU8Y4xq4bY3F7cvd350nBmOXHxlU/kvmfa0feNRB
         41A3fSbm5og4HsGMYYYFESqP+Vi9am2KvZpxYpceDDFC+T/HFhgMDI/SbOJFNEFrDw/G
         NIVAkCfsrZ0qJ0MOcY6y1xHpqzLcngZ6Nt1LXvpFrA81IJNIMtYvIibJbE2sJcjUHfl+
         2ugM/evvkmhxvfaO4a3EeA4LoaJnElVAs8iJwi+HYiqykjM6DlBwizmENicZvtoATE7o
         67ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VHsZStNjA73Ae4uFiJi/g7h897WcLJ+U162SE+386R8=;
        b=NyXGyZv9c5tjd/89CPO33vuVbohU0Z0aTPS0kxrkY2koFEBKqOf+JiuyDt23CFxhxs
         +rX9X1R/TuCJHjV4GMn9GOKLdT8rNFyWlyFz/uMaqZLyxcAHFqoP2KCwzBKJAMPs+Xhu
         7Oh8g4ahF9UKBw4XxlFKhYjrjAlWQ+guyfrB1vYSV4utYMEFXFCRuF7ePhxrz3lYNdAX
         ZPTZev4K3r+/315194fr+ksv8b3K6/Jmjmpru7En4LCzplPr9qbHyrM1I50TjhtrOMud
         YarqCRkjcAPXOX78QadfgsLsIPh5gKR3eSHvTv2ssHoMzvhPzpjUXLTQ7LPK3caVpwgg
         UeMA==
X-Gm-Message-State: APjAAAUIZkhKlNsfMGLo/yCCVcJH10gOXXJ2d8n52yH8Na0SsGza2RSh
        urDYhcnF+JTCZymcxetwFzUZNm34
X-Google-Smtp-Source: APXvYqwZAKl0A9smw7TtlAMsK0Xb07QQz4fZzBdq4h3w3pp1K/meOUhryLYpQKNUMIASR84WLREBWg==
X-Received: by 2002:a17:90a:17e1:: with SMTP id q88mr4823979pja.134.1572337188595;
        Tue, 29 Oct 2019 01:19:48 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id f7sm13405211pfa.150.2019.10.29.01.19.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 01:19:47 -0700 (PDT)
Date:   Tue, 29 Oct 2019 01:19:45 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] git-diff.txt: document return code of `--no-index`
Message-ID: <3f6d132663cacde01df68bfe88c6ef108cf6cf74.1572337045.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to the end of diff_no_index(),

	/*
	 * The return code for --no-index imitates diff(1):
	 * 0 = no changes, 1 = changes, else error
	 */
	return diff_result_code(&revs->diffopt, 0);

However, this is not properly documented in git-diff.txt.

Shamelessly steal from the `--exit-code` text and give it to the
`--no-index` documentation to explain that the return code is similar to
diff(1).

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-diff.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 72179d993c..1e363bd200 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -36,7 +36,10 @@ two blob objects, or changes between two files on disk.
 	running the command in a working tree controlled by Git and
 	at least one of the paths points outside the working tree,
 	or when running the command outside a working tree
-	controlled by Git.
+	controlled by Git. With `--no-index`,
+	the program exits with codes similar to diff(1). That is, it
+	exits with 1 if there were differences and 0 means no
+	differences.
 
 'git diff' [<options>] --cached [<commit>] [--] [<path>...]::
 
-- 
2.24.0.rc0.197.g0926ab8072

