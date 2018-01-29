Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F85F1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeA2Wh6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:37:58 -0500
Received: from mail-qt0-f201.google.com ([209.85.216.201]:39492 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752064AbeA2Wh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:37:56 -0500
Received: by mail-qt0-f201.google.com with SMTP id a21so9466144qtd.6
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=eEceEjb0hpsEDRiSJQJBsRU+W3eBhbda9muQFXU7dIY=;
        b=LG3vhKym1WnjkRHuu4lK3mO+9GzSu6ZIaE15EiI+e8+nl/7PRs4urhfaBMRLQtEOyQ
         FCzNtrdqJw0v9wZ5IUUExRC8zA9hpHjV6QcEp57d40Poe2ANQEPn0RQtuRT0Iq2pkTzb
         33DTNvJLJze6YwhMIGJHt8HLN15moaC/ptczdmjkGuye/1vXxeYmkVLNAEQX4zMkkimh
         oZKAFgv7HuYcHKrzJXDUA20ZrFNSv46adjv2ajlwSeLrcd+9KahoYQkTXKoCa2jy4jxs
         AhlMbf3+W4Tcz2iUpVnizH+6yAzEndhj9/5VxdwONsJ3jIk1RLpzjgfG/e064WIqWjNd
         Qctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=eEceEjb0hpsEDRiSJQJBsRU+W3eBhbda9muQFXU7dIY=;
        b=JDY+ybPLsvZBB/NdZBPXAlOAYCRttTrddlorRYXoQJynwgsuk47eEH0rmODuXUcbwC
         mhNUTb8pEbJpwNBlWOOtLNL2iYQ00V7U4UnPXgCqv0jJqt0+SL+KHM1BD8ZW7St8z8tC
         KXRH48yxud8dZLedyHcbmKUtGG5Iedwz+WL0LuHVg3+bw/5nRZxvjjLu89LSj28kBDSE
         Ka8za0JhG69lUeokYibGNOhEhx/Aiy6EyEa9D27Y8TkEBLmW/JIEHEslII19yNQGxjBh
         GVIjPEkwacnm9u+uexAHgYNWFkSDfhJvIB3Rh5jLQim1WhTt25otYdQ/n9NPORVwkLMb
         DSXg==
X-Gm-Message-State: AKwxytc8QEZp8N8aLyEvs2hJebECTOBNH1IA6jNLjVxE1ALVx+0bfPnd
        Xq3BC1JSRQ8rGkbDMT2KSCs7TNtMN+1OwRZnDw3qcOOIytbdrdM1HiZPCNiLwrxsHvk/r8TsQKt
        rb9AjXSRiiOMEBMO99nhy8gcbR+McT6Do6+j+sLw7sb8DRvSOAja3heT2qA==
X-Google-Smtp-Source: AH8x2271wO73MdXr421xKRfAOsxidIRQmDYQxXdC0m6NJyKv40EUYwibn4IPpV5qeU7alWbN//GSk/qsIWA=
MIME-Version: 1.0
X-Received: by 10.200.18.129 with SMTP id y1mr18350885qti.55.1517265475268;
 Mon, 29 Jan 2018 14:37:55 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:36:57 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-7-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 06/37] diff: rename 'this' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 diff.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 0a9a0cdf1..d682d0d1f 100644
--- a/diff.c
+++ b/diff.c
@@ -2601,7 +2601,7 @@ static long gather_dirstat(struct diff_options *opt, struct dirstat_dir *dir,
 	while (dir->nr) {
 		struct dirstat_file *f = dir->files;
 		int namelen = strlen(f->name);
-		unsigned long this;
+		unsigned long sum;
 		char *slash;
 
 		if (namelen < baselen)
@@ -2611,15 +2611,15 @@ static long gather_dirstat(struct diff_options *opt, struct dirstat_dir *dir,
 		slash = strchr(f->name + baselen, '/');
 		if (slash) {
 			int newbaselen = slash + 1 - f->name;
-			this = gather_dirstat(opt, dir, changed, f->name, newbaselen);
+			sum = gather_dirstat(opt, dir, changed, f->name, newbaselen);
 			sources++;
 		} else {
-			this = f->changed;
+			sum = f->changed;
 			dir->files++;
 			dir->nr--;
 			sources += 2;
 		}
-		this_dir += this;
+		this_dir += sum;
 	}
 
 	/*
-- 
2.16.0.rc1.238.g530d649a79-goog

