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
	by dcvr.yhbt.net (Postfix) with ESMTP id 784E81F4C1
	for <e@80x24.org>; Sat, 26 Oct 2019 21:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfJZV7N (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 17:59:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45433 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfJZV7N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 17:59:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id q13so6010313wrs.12
        for <git@vger.kernel.org>; Sat, 26 Oct 2019 14:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=fdf46Jbqy/H3ojbfSa5vCcGzPmeacdIsA8Hulz0+3Z8=;
        b=QS8V61n1Vdq5I3ItLwEqNPe2Vi3rgaOsQIT4mdflPJ81TdM+DUNMav1iF2sw1j3a4D
         B3I5Y4HG3hH/2NaUooLcpNoXp5t7dqCU6eeGFFl9LGEGA2toZkjOT8qVntndADano0P+
         lRoOwPCgXW7oAX2bda8pS6G+ovJsq0CEqKKPBkeyowwvo53yyT/JH3wdqF0roFA8Vb2Y
         tBerQsIy1j0J5PF626IuY4sFMUY5ney2pbKJSMJ/GHKn7j5Lzsl3VecsMbN3ZvUrfaw7
         NYrldcXCORjDsjdvw6obYppg3wEll5mcjzU5Opbxp3G6vOc9OlTpyHHOLyHYcj/vq+PC
         kEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=fdf46Jbqy/H3ojbfSa5vCcGzPmeacdIsA8Hulz0+3Z8=;
        b=XUADxwL+SDAN5/LhiWl0DZAeYKNdYPzxjCacxH84+Pg8k8nt3SmC/SYz7oiSm9BBTV
         ygaRU6OnUByA+cQcysm+LhGRjaESZ3e7PYaRMW1+ABRe7oa+WUTjpIzMAaRHHCIRX61E
         CGpFuFHuNx2GMrxtw5nbaE/aHd3sZRivJna7lpSDyScP3lbVEJdX23ugW3TYiWjUyhqy
         en1jEik8Zivh2UqfAQCUIR1q2Bz3DMpuzRGaCplMx61h4H/m/WEDx+cm06KEXwgruXs9
         i574TbW0mqade6zEjcbMOOc/5Ck/12ceYDE+BXf6drQ2OsoXTd8EESqDnnOBcX5KEWZI
         Q5rw==
X-Gm-Message-State: APjAAAU3pHsPMdr5/IaMNyrJcaEzVMt1gdolTa7dWqQaKYomHJWIJT8X
        hr6jdP0w16fH0dvW9dZyNywlZQ17
X-Google-Smtp-Source: APXvYqwFPMUJ5jZX9Uj+cCrcwbQyC/qaGTXPHBJS76uh2rO2E4J072oUW3eH8UTI7XxM2Po8LT2bKw==
X-Received: by 2002:a5d:6402:: with SMTP id z2mr8865252wru.211.1572127151384;
        Sat, 26 Oct 2019 14:59:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm6415618wrs.66.2019.10.26.14.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Oct 2019 14:59:10 -0700 (PDT)
Message-Id: <fd022f88f54f6cf0feb61965b2dc47bca64c0937.1572127149.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.432.git.1572127149.gitgitgadget@gmail.com>
References: <pull.432.git.1572127149.gitgitgadget@gmail.com>
From:   "qusielle via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Oct 2019 21:59:09 +0000
Subject: [PATCH 1/1] add: respect `--ignore-errors` when `lstat()` reports
 errors
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        qusielle <31454380+qusielle@users.noreply.github.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: qusielle <31454380+qusielle@users.noreply.github.com>

"git add --ignore-errors" command fails immediately when lstat returns
an error, despite the ignore errors' flag is enabled.

There could be files that triggers an error on stat(), when other files
proceed correctly.
Issue can be reproduced when running git under Cygwin and some target files
have utf-8 long names (200+ utf chars). Windows can handle them, but all
operations on them failed under Cygwin.
Issue can not be reproduced with usual latin/numeric only names.
For example, create a file with 220 'й' letters by Windows Explorer,
then in Cygwin:

 # Here and below "ййй..." means the line of й copied 220 times.
$ echo -n 'ййй...' | wc -c  # check the real size
440

$ ls -la
ls: cannot access 'ййй...'$'\320': No such file or directory
-????????? ? ?              ?        ?            ? 'ййй...'$'\320'

$ ls й*
ls: cannot access 'ййй...'$'\320': No such file or directory

$ stat й*
stat: cannot stat 'ййй...'$'\320': No such file or directory

In my perspective, it's okay to skip these problematic files when ignore
error flag is specified, but official Git terminates entire git add command
when such files come up. But with proposed patch it is the desired behavior:

$ git add --ignore-errors .
error: ййй... can only add regular files, symbolic links or git-directories
 # All other files have been added correctly.

Signed-off-by: Qusielle <qusielle@gmail.com>
---
 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 133f790fa4..67237ecd29 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -801,7 +801,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 int add_file_to_index(struct index_state *istate, const char *path, int flags)
 {
 	struct stat st;
-	if (lstat(path, &st))
+	if (lstat(path, &st) && !(flags & ADD_CACHE_IGNORE_ERRORS))
 		die_errno(_("unable to stat '%s'"), path);
 	return add_to_index(istate, path, &st, flags);
 }
-- 
gitgitgadget
