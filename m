Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 375811F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbeACATS (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:19:18 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:45763 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbeACATN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:19:13 -0500
Received: by mail-io0-f196.google.com with SMTP id e20so448562iof.12
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xT/03yD81x4hlLaf230rbKVRiPKwXv3Qzl7bOyXqV3o=;
        b=VgunahF+ZYZelT7pG+AScFbhIKiKlvOwj5DKZRSBCM0sHdmHCHKcMVoVuInxkP5rMu
         Ju+DjYcvWcfsVxXaeWxnLB44EyS7wsX1Twsu9IBkUtAC2T419ig34DIVDgXDDmX+iVQK
         K7Us3TqPFMsZ9NS4bYixSxsL+aO5qHAs/6RPhUVAtCxIvDSFuTXUiv48tUODapOkvioQ
         3sqMLHeeKAJDiEkBj/JBBQ7E1dc4RfrrFgtjKXjVCD3LMDhyxdZw8ztSntGjzY1TJB97
         44/TOQk4NzpeOgJlNYQVvBDm804tVKcK9WKHTmpt+6I1eKijBjmObabH9SdNgVGokCSN
         f/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xT/03yD81x4hlLaf230rbKVRiPKwXv3Qzl7bOyXqV3o=;
        b=pdwK75u1fRc1f6Y1pC6uYlerUkaGL228XcqrYp4NZ3QunegO77aNS7alSZOqAzKnvL
         Gm3xxvSk3EzNFZUpyKVPF3evJdtLxGHITabdgVKHKLn+0z5Fb9x4/qYQGolVF1QZMmUL
         MOgdrgd8aQ+y1AM1rFuCVXupYOjnUoBFWKhDyAzUDoAr+6i1oHdNP4yKkLCSXTE7lWe6
         4ZoqVB1aDjhCGsP5nYcL+HXnvlaV2tRUEdW8O8ZhIZbfKfOq3Fd4M38uW9EuWYkNoEkF
         JxI2V6SQ23UqjenhzLnvWY5Z2BzFO13SV8Xg0XeOU59Qt2g/3EdryOBdTlVDXHw9/shg
         dzjg==
X-Gm-Message-State: AKGB3mIgXri7ZmrMcAbsgh+gdzluPAPaeG5d7n5oKlVVdSPch1ISpHzq
        Yf/8sFqap3tRHYq8ljitKmMCX08EIzk=
X-Google-Smtp-Source: ACJfBouqFQxIYEenZAHMoimFYTxFpF34ShQGUD8gMNS+56TaflEqcDuWCq+2bGGFIvni36rauY7aKA==
X-Received: by 10.107.47.215 with SMTP id v84mr11218169iov.206.1514938752365;
        Tue, 02 Jan 2018 16:19:12 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:19:11 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 21/26] transport-helper: remove name parameter
Date:   Tue,  2 Jan 2018 16:18:23 -0800
Message-Id: <20180103001828.205012-22-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 266f1fdfa (transport-helper: be quiet on read errors from
helpers, 2013-06-21) removed a call to 'die()' which printed the name of
the remote helper passed in to the 'recvline_fh()' function using the
'name' parameter.  Once the call to 'die()' was removed the parameter
was no longer necessary but wasn't removed.  Clean up 'recvline_fh()'
parameter list by removing the 'name' parameter.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 transport-helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 4c334b5ee..d72155768 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -49,7 +49,7 @@ static void sendline(struct helper_data *helper, struct strbuf *buffer)
 		die_errno("Full write to remote helper failed");
 }
 
-static int recvline_fh(FILE *helper, struct strbuf *buffer, const char *name)
+static int recvline_fh(FILE *helper, struct strbuf *buffer)
 {
 	strbuf_reset(buffer);
 	if (debug)
@@ -67,7 +67,7 @@ static int recvline_fh(FILE *helper, struct strbuf *buffer, const char *name)
 
 static int recvline(struct helper_data *helper, struct strbuf *buffer)
 {
-	return recvline_fh(helper->out, buffer, helper->name);
+	return recvline_fh(helper->out, buffer);
 }
 
 static void write_constant(int fd, const char *str)
@@ -586,7 +586,7 @@ static int process_connect_service(struct transport *transport,
 		goto exit;
 
 	sendline(data, &cmdbuf);
-	if (recvline_fh(input, &cmdbuf, name))
+	if (recvline_fh(input, &cmdbuf))
 		exit(128);
 
 	if (!strcmp(cmdbuf.buf, "")) {
-- 
2.15.1.620.gb9897f4670-goog

