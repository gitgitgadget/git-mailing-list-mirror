Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A49BC1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 00:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfKSAWa (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 19:22:30 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:38420 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfKSAVj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 19:21:39 -0500
Received: by mail-pj1-f54.google.com with SMTP id f7so1994610pjw.5
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 16:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ma8wYbi4y13isC8Qt6aM+ni9R/rwX8lNYPqbnybI9A4=;
        b=MS3/2r1iDLf5Z4KXoXqbqpcLox3U/q2KUqTk2r64sMxPyAl5pb6KzWB0Q+NJ34vBsI
         /HlRqQQ1MIN5Z/OY4h010tmtWz1GS7ISGWDUUodWyIFiNOsm0NcbAgTHMuC5n7UXDF9i
         9wIC2yiotRw8vtklHMcx/Cr1pKEOwl2y2Blmaa33SMq9IUWap/xu8PRKglbqy7U4k0F9
         RS1uGq0IAZ3l/0PlbTnpzxBjP5+XZEGVu063JkY60r7uHZ4i+chGweDSL3pAmkDXmtIg
         WLRy5PGsZ/UGSAwtqJlqToGZSPn5fLn8DpGQzBj/jRFtqlUxqIR8RnOa/FQMVj7cuoYJ
         r4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ma8wYbi4y13isC8Qt6aM+ni9R/rwX8lNYPqbnybI9A4=;
        b=pnkmhzzsRrRl7uHikwOn7YgqL8J98UPVKr6cQMcSoUVFRaDPUlDLUF2onPS1EhzvJO
         hyyOAtGuWlq08b91BvkAPCeEJHObx5C7gF1RGRHRr4hZZQ+8JpZYGaR3pDjxPrMx9tZ1
         9/GhObCGvhY3k4HOA2WjrfkxIp+9Z73RqQc39X7HzR85KNWNXC/F81zwww46/QkpZZvD
         1w7TaKAk2xK76fX4DCq1VygtcP02lH1UgEAILCev0Ac07o83pxJERjI4olqVMtyK81P6
         1FgPKcQG8EiClBtzPi9IFZDpM3iDYXT9mtCySYPbwh5//kNut9QxdBI3JJkj+2pbLKbM
         C4yw==
X-Gm-Message-State: APjAAAX/zNGUqB5EdA3d1jA+6f14jyGFDCui8T+Qroc3Pai2rj8Wk7Y9
        Cm3eKjjvvS/T2YgDs1kltOADEXNx
X-Google-Smtp-Source: APXvYqyZZ3qPbq3mJUY443gCQjdk5ie8qhSqVSjt/yuCY5kWdFcId4mj70o46LAGsftaIfy3YyYXRQ==
X-Received: by 2002:a17:90a:8a0e:: with SMTP id w14mr2314566pjn.7.1574122898095;
        Mon, 18 Nov 2019 16:21:38 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id y6sm20312931pfm.12.2019.11.18.16.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 16:21:37 -0800 (PST)
Date:   Mon, 18 Nov 2019 16:21:35 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v4 11/11] squash! pretty: implement 'reference' format
Message-ID: <580aa7c88c0b18d752f9aa951166a2c82dbcd031.1574122784.git.liu.denton@gmail.com>
References: <cover.1573764280.git.liu.denton@gmail.com>
 <cover.1574122784.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574122784.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note that we explicitly special-case `--pretty=reference` to use
`DATE_SHORT` by default in get_commit_format(). Although this isn't a
very elegant way of doing this, it has to be done this way because we
implement `--pretty=reference` as a user-format and, after this
function, it is treated as a normal user-format. This is the only part
of the pretty codepath where we can actually tell that we are dealing
with a "special" format so we have to do it here.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Notes:
    This patch implements the overridable `--date` for `--pretty=reference`.
    The only reason I'm hesitant about squashing this in is, as described
    above, that this patch isn't very elegant. I'd welcome suggestions on
    how to possibly make it more elegant.
    
    Also, if we squash this in, we could drop the "pretty: provide short
    date format" patch. We'd only need to update the test cases to stop
    using `%as`. Thoughts on that?

 Documentation/pretty-formats.txt | 8 +++++---
 pretty.c                         | 8 +++++++-
 t/t4205-log-pretty-formats.sh    | 9 ++++++++-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index ccd0921123..1a7212ce5a 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -68,9 +68,11 @@ This is designed to be as compact as possible.
 	  <abbrev hash> (<title line>, <short author date>)
 +
 This format is used to refer to another commit in a commit message and
-is the same as `--pretty='format:%C(auto)%h (%s, %as)'`.  As with any
-`format:` with format placeholders, its output is not affected by other
-options like `--decorate` and `--walk-reflogs`.
+is the same as `--pretty='format:%C(auto)%h (%s, %ad)'`.  By default,
+the date is formatted with `--date=short` unless another `--date` option
+is explicitly specified.  As with any `format:` with format
+placeholders, its output is not affected by other options like
+`--decorate` and `--walk-reflogs`.
 
 * 'email'
 
diff --git a/pretty.c b/pretty.c
index 88a3bc621d..8bb4b1d67f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -99,7 +99,7 @@ static void setup_commit_formats(void)
 		{ "full",	CMIT_FMT_FULL,		0,	8 },
 		{ "oneline",	CMIT_FMT_ONELINE,	1,	0 },
 		{ "reference",	CMIT_FMT_USERFORMAT,	1,	0,
-			0, "%C(auto)%h (%s, %as)" },
+			0, "%C(auto)%h (%s, %ad)" },
 		/*
 		 * Please update $__git_log_pretty_formats in
 		 * git-completion.bash when you add new formats.
@@ -187,6 +187,12 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 		save_user_format(rev, commit_format->user_format,
 				 commit_format->is_tformat);
 	}
+	/*
+	 * --pretty=reference is special; it should use the short date format
+	 * unless otherwise specified
+	 */
+	if (!rev->date_mode_explicit && !strcmp(arg, "reference"))
+		rev->date_mode.type = DATE_SHORT;
 }
 
 /*
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 9a9a18f104..a8ef3784cf 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -830,8 +830,15 @@ test_expect_success 'log --pretty=reference' '
 	test_cmp expect actual
 '
 
-test_expect_success 'log --pretty=reference always uses short date' '
+test_expect_success 'log --pretty=reference with log.date is overridden by short date' '
 	git log --pretty="tformat:%h (%s, %as)" >expect &&
+	test_config log.date rfc &&
+	git log --pretty=reference >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=reference with explicit date overrides short date' '
+	git log --date=rfc --pretty="tformat:%h (%s, %ad)" >expect &&
 	git log --date=rfc --pretty=reference >actual &&
 	test_cmp expect actual
 '
-- 
2.24.0.420.g9ac4901264

