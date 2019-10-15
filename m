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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B8A21F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 09:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfJOJGj (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 05:06:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37137 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfJOJGj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 05:06:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so12062025pfo.4
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 02:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z+V3gh7RsiwKissOWqhzfFZziqx3l9b4hRqeC4UdPEs=;
        b=jYCNNsZKF1prCQ24zjcAFYT1ZlqYE6FR3kG18/c7nIXfn57kzbm+SWZQprpwJpgT93
         61trjqdP0pwsBuooceB9SCojsKlLvIMjbvKKSt+G4wqOEnDP2dpjHzQUsVflbslXy0H3
         Dk1Ut2eI3Qx2atw904+ZdrGcd1DUfNLSQoPQTj7/3m74snfQpRqbP0+uQbwLqubX0FyZ
         EKBp6cfoIRhdJjmq6FT/qcQQRb+jUW++VLUpAksDWsgq2Ci7EX9uDea1PnBPo5DnVeKf
         vI9IUFSeG7zF++8sSl/IzBGyltEbMI8p8Q2K+iRuPvv46Go1N+OqMnCbnUjTXmJMKehj
         EhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z+V3gh7RsiwKissOWqhzfFZziqx3l9b4hRqeC4UdPEs=;
        b=KMFYnerSMWgYWWTyRQ8HQnKUG4WRrhrGCuCTgbgnt/ssBFbm5GBUBz9tTDsLSt+F6g
         cDKEPHmfnoh0SSHlFAiiOGzOWABsFmEsGKWqAb5qzft0XmZ0M7iKhOxn29AShLvbfMhD
         VMGldrPfE4NBi+jo9T6tya5ZpZM+UvmKwhA7uamQ4lNFjlmoKd7Nm+QeYL4MVsKPDCvH
         WSPiX5qLhU6Wv2RU/DrG+7H2+7zH1UwdTylovldRvgsubxRi7UAFWKGACB0Wrkp3ZuwX
         sUJ31TYeP/d9be0ZupGdWj7xvAs2MB4Wg4LNsZvcg9zhfpV9O3w/osBiWWCgy04FDa4P
         I0Ag==
X-Gm-Message-State: APjAAAVkQRe+/0UBIDsAoR45Z5YTW4FQWyLj6CklWa7uVQi+uKCXqUgT
        CW2i/KqNB2d21p/6MKruqwWb/joV
X-Google-Smtp-Source: APXvYqwmhoUpIAnMg4GC4IFOZ15ysnnsRVQsbe5nIqeLLQcBEs5BjIEwh6wYyBBdeE0/ibm19XycVQ==
X-Received: by 2002:a63:ea45:: with SMTP id l5mr24048802pgk.189.1571130397700;
        Tue, 15 Oct 2019 02:06:37 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id c8sm24356162pfi.117.2019.10.15.02.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 02:06:37 -0700 (PDT)
Date:   Tue, 15 Oct 2019 02:06:35 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v6 1/3] format-patch: replace erroneous and condition
Message-ID: <9d41068e73f54cbac82267a6ebd2f13cf343c076.1571130298.git.liu.denton@gmail.com>
References: <cover.1558492582.git.liu.denton@gmail.com>
 <cover.1571130298.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571130298.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 30984ed2e9 (format-patch: support deep threading, 2009-02-19),
introduced the following lines:

	#define THREAD_SHALLOW 1

	[...]

	thread = git_config_bool(var, value) && THREAD_SHALLOW;

Since git_config_bool() returns a bool, the trailing `&& THREAD_SHALLOW`
is a no-op. Replace this errorneous and condition with a ternary
statement so that it is clear what the configured value is when a
boolean is given.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 44b10b3415..351f4ffcfd 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -835,7 +835,7 @@ static int git_format_config(const char *var, const char *value, void *cb)
 			thread = THREAD_SHALLOW;
 			return 0;
 		}
-		thread = git_config_bool(var, value) && THREAD_SHALLOW;
+		thread = git_config_bool(var, value) ? THREAD_SHALLOW : THREAD_UNSET;
 		return 0;
 	}
 	if (!strcmp(var, "format.signoff")) {
-- 
2.23.0.17.gd2208d9060

