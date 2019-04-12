Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14B6B20248
	for <e@80x24.org>; Fri, 12 Apr 2019 19:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfDLTv1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 15:51:27 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:41537 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfDLTv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 15:51:26 -0400
Received: by mail-oi1-f201.google.com with SMTP id z6so5084787oid.8
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 12:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HGoZo+LtvhLV7YhQALJmn2XxUtVoEuubybAtsvquRzE=;
        b=eVtJsnXm9mnjAuP2N/a5yU3UUdOywWmL7N0+rPwn1rkXWT1MHT7KqSuKhBdg+ZL0jy
         FQXXImRnC0gEgDKd/4DK37/GRtlFDMsjG6iPUxBiDGTGly7v7fq2/AwaHkve+9Mij9BE
         hyT2qZt6vsclqtLA144RYhsRepVcLvGonjVn5bWxnmOnZ6pt/FKhprevFNtVMdSZpPoh
         UxBM9RvOaqoAf4QsCqHeoNTax9eJabWgROHMcp9boem/hCkSWZCCjUw9UTjwRcnmdkgB
         UbVMIshwyeN+ag4/zK/uTa+zsujxnyTsM6V+IX96Kiww7fNfePw5q/zpDytmdCX1Gx48
         /lqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HGoZo+LtvhLV7YhQALJmn2XxUtVoEuubybAtsvquRzE=;
        b=V8ViR0ljtaMhHa/peQIk/P+RZgjmJMU2vlE4a+h+o7hd6f8jDpiFyF2fRnboajm8gb
         LPgGBPiFWv7oW0Yr2drHnJustzZ+nzCBFoo3zO3ZpWaN+lTkEkCKqgoV46bw5TyD5gP2
         odDmn563e2d86oeCxLZni5wMUSy5YYKSzFX+NrkNNFLPYkTShkCJ9H4JisPYHNCr4Zad
         yHaXOsEjEOy/YnizYGlygZ1bzLw4rp8xrOk02yW6htNxy1Vbx50grxWOqS7NueO8ja9s
         X0vavm6s+n8icTCbReOTc5u5P+ctQzDbLQwYY/0LCpE0WB3msWlfyQKglTuvbMRNVrhE
         7/Yg==
X-Gm-Message-State: APjAAAXIgcfxNDxZByqKWxz7+vvIKsTMcfXuAI7Sv7T06f75mU8ZWkth
        ggUwgWR/YKaI75JTpoV1WUko6XVy5gW4GuDbGLN/toC3mxn4Bjx/rSbTlF0aLtzaF5fz5G7KI9k
        +16WSiNe/MLGczdQQg4T9o9X2brUtLq/8jeK84PzSgoejDh0XFUxzAxa6TsrGAZKAbzpdde2b7u
        4m
X-Google-Smtp-Source: APXvYqyHFt9OGRke1a3IZYC5FjuCCM4211ETkYqgsXpZqhQvqPcBXLfckGbexujcIbEj68Y490mmTIuDGYFncZlROByq
X-Received: by 2002:aca:3841:: with SMTP id f62mr5718053oia.9.1555098686014;
 Fri, 12 Apr 2019 12:51:26 -0700 (PDT)
Date:   Fri, 12 Apr 2019 12:51:20 -0700
In-Reply-To: <20190405204413.93900-1-jonathantanmy@google.com>
Message-Id: <cover.1555098572.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190405204413.93900-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v4 0/2] Server options when cloning
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Junio, for spotting the test_must_fail interaction with
environment variables. I've updated that, and I also noticed that the
first patch's commit message title should say "die" instead of "warn",
so here is another version.

Jonathan Tan (2):
  transport: die if server options are unsupported
  clone: send server options when using protocol v2

 Documentation/fetch-options.txt |  3 ++-
 Documentation/git-clone.txt     |  8 +++++++
 builtin/clone.c                 |  6 +++++
 t/t5702-protocol-v2.sh          | 41 +++++++++++++++++++++++++++++++++
 transport.c                     | 10 ++++++++
 5 files changed, 67 insertions(+), 1 deletion(-)

Range-diff against v3:
1:  63049081c9 ! 1:  598b2de016 transport: warn if server options are unsupported
    @@ -1,6 +1,6 @@
     Author: Jonathan Tan <jonathantanmy@google.com>
     
    -    transport: warn if server options are unsupported
    +    transport: die if server options are unsupported
     
         Server options were added in commit 5e3548ef16 ("fetch: send server
         options when using protocol v2", 2018-04-24), supported only for
    @@ -22,7 +22,7 @@
      '
      
     +test_expect_success 'warn if using server-option with ls-remote with legacy protocol' '
    -+	GIT_TEST_PROTOCOL_VERSION=0 test_must_fail git -c protocol.version=0 \
    ++	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 git -c protocol.version=0 \
     +		ls-remote -o hello -o world "file://$(pwd)/file_parent" master 2>err &&
     +
     +	grep "see protocol.version in" err &&
    @@ -40,7 +40,7 @@
     +
     +	git init temp_child &&
     +
    -+	GIT_TEST_PROTOCOL_VERSION=0 test_must_fail git -C temp_child -c protocol.version=0 \
    ++	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 git -C temp_child -c protocol.version=0 \
     +		fetch -o hello -o world "file://$(pwd)/file_parent" master 2>err &&
     +
     +	grep "see protocol.version in" err &&
2:  f59b8244eb ! 2:  48bdd462c4 clone: send server options when using protocol v2
    @@ -105,7 +105,7 @@
     +test_expect_success 'warn if using server-option with clone with legacy protocol' '
     +	test_when_finished "rm -rf myclone" &&
     +
    -+	GIT_TEST_PROTOCOL_VERSION=0 test_must_fail git -c protocol.version=0 \
    ++	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 git -c protocol.version=0 \
     +		clone --server-option=hello --server-option=world \
     +		"file://$(pwd)/file_parent" myclone 2>err &&
     +
-- 
2.21.0.392.gf8f6787159e-goog

