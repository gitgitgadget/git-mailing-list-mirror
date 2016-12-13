Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1B941FF40
	for <e@80x24.org>; Tue, 13 Dec 2016 09:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753077AbcLMJWj (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 04:22:39 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36788 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752456AbcLMJWg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 04:22:36 -0500
Received: by mail-pf0-f194.google.com with SMTP id c4so5778840pfb.3
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 01:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Ak/5TL78AgZ5948j1Dqn8SpdZHrQ/217pthjojSHeK0=;
        b=wUTVYJAy6h8iJS5hIb1u+W+uWl1EGoJ0iRRDR4NQr3PJo6PokcwkA2HEK8/Iewcv/5
         gvJM6h7NocQ3A8yr9txNvOpOhzODdW867XxyEK/imsSqjogJA4Tj+MhMGZ7w+6dprcYr
         SJF4bWFza3xOWUMvkCf3lRT01b5U2wyaZ1PnN+UJwqaLhSG2556ZD4uctWzgv969wn3s
         1go5H6NNh4/hOLATPj58LPJxDesYKcURChMaJWIbJoCOXCN9wk5ihp713jENg9kFmcGs
         BTDRZkwuOMUUBjxtn6NHIl3POdyp4NS5WG2+3gzSsfrgAjWHw79BHGsI1JGCjWhiiYXR
         6yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ak/5TL78AgZ5948j1Dqn8SpdZHrQ/217pthjojSHeK0=;
        b=IxppCBZN9yybyoPFZGUVb/y8CDMBljxDYaUyBwIIvGu1WCvI4uf5rdzFxSuNliHOVP
         Po3c9tFE3ecM+CD069jawMJqAfFx92j1TXhnunB91cCtdFUycAR9dT9IbkaAucXx447z
         l86ZzSUqwcGgpoz+wTVHLsxCBFyXxn8Vdv+uHBzfgQGeduERqs6X4JN73thwpPV484LO
         s+f6WQ9PR/2uXIGPxuzOQBmHLkeBPU2xtDC8P9fhYK1Wvsw+7IFupQLvAzFcYNFPY+P+
         9bAGx5BMMEQj5EsW3G3c8yGY0P1mxdLA+XPC3vtvqo3Ikx4UXknfzXKANLun9qTLn3ij
         AxSA==
X-Gm-Message-State: AKaTC02ZJcYDDd7nh3nHSQjRWgo9kjuQJ1H/9J6qx16ZxFXo8R4vsQHjF5A6lI/E6TX0KQ==
X-Received: by 10.84.218.8 with SMTP id q8mr194978909pli.138.1481620955749;
        Tue, 13 Dec 2016 01:22:35 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:7966:ce03:97ae:8cb])
        by smtp.gmail.com with ESMTPSA id u3sm49594747pfk.3.2016.12.13.01.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 01:22:34 -0800 (PST)
From:   Chris Packham <judge.packham@gmail.com>
To:     git@vger.kernel.org
Cc:     gitter.spiros@gmail.com, Chris Packham <judge.packham@gmail.com>
Subject: [RFC/PATCH] Makefile: add cppcheck target
Date:   Tue, 13 Dec 2016 22:22:25 +1300
Message-Id: <20161213092225.15299-1-judge.packham@gmail.com>
X-Mailer: git-send-email 2.11.0.24.ge6920cf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add cppcheck target to Makefile. Cppcheck is a static
analysis tool for C/C++ code. Cppcheck primarily detects
the types of bugs that the compilers normally do not detect.
It is an useful target for doing QA analysis.

Based-on-patch-by: Elia Pinto <gitter.spiros@gmail.com>
Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
I had been playing with cppcheck for some other projects and happened to
notice [1] in the archives. This is my attempt to resolve the feedback
that Junio made at the time.

In terms of errors that are actually reported there are only a few

$ make cppcheck
cppcheck --force --quiet --inline-suppr  .
[compat/nedmalloc/malloc.c.h:4093]: (error) Possible null pointer dereference: sp
[compat/nedmalloc/malloc.c.h:4106]: (error) Possible null pointer dereference: sp
[compat/nedmalloc/nedmalloc.c:551]: (error) Expression '*(&p.mycache)=TlsAlloc(),TLS_OUT_OF_INDEXES==*(&p.mycache)' depends on order of evaluation of side effects
[compat/regex/regcomp.c:3086]: (error) Memory leak: sbcset
[compat/regex/regcomp.c:3634]: (error) Memory leak: sbcset
[compat/regex/regcomp.c:3086]: (error) Memory leak: mbcset
[compat/regex/regcomp.c:3634]: (error) Memory leak: mbcset
[compat/regex/regcomp.c:2802]: (error) Uninitialized variable: table_size
[compat/regex/regcomp.c:2805]: (error) Uninitialized variable: table_size
[compat/regex/regcomp.c:532]: (error) Memory leak: fastmap
[t/t4051/appended1.c:3]: (error) Invalid number of character '{' when these macros are defined: ''.
[t/t4051/appended2.c:35]: (error) Invalid number of character '{' when these macros are defined: ''.

The last 2 are just false positives from test data. I haven't looked
into any of the others.

I've also provisioned for enabling extra checks by passing CPPCHECK_ADD
in the make invocation.

$ make cppcheck CPPCHECK_ADD=--enable=all
... lots of output
    
[1] - http://public-inbox.org/git/1390993371-2431-1-git-send-email-gitter.spiros@gmail.com/#t

 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index f53fcc90d..8b5976d88 100644
--- a/Makefile
+++ b/Makefile
@@ -2635,3 +2635,7 @@ cover_db: coverage-report
 cover_db_html: cover_db
 	cover -report html -outputdir cover_db_html cover_db
 
+.PHONY: cppcheck
+
+cppcheck:
+	cppcheck --force --quiet --inline-suppr $(CPPCHECK_ADD) .
-- 
2.11.0.24.ge6920cf

