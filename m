Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19F8921847
	for <e@80x24.org>; Wed,  2 May 2018 00:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753494AbeEBAbm (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:31:42 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44061 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753438AbeEBAbk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 20:31:40 -0400
Received: by mail-pg0-f68.google.com with SMTP id 82-v6so9323504pge.11
        for <git@vger.kernel.org>; Tue, 01 May 2018 17:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=HvC/0+76/wdExk0fhtf7+k8mJODHa9QN6WbHXYTZ6fU=;
        b=L2xXRkwsIV5/vmMi6AjpCS1D54dttJUB76XMPu1t1j2KMKVp3x/9zFXS8T0/MudXGc
         r3NpwhD438T1j4nU2aunzeLmNTG7V8MN6k666PP4akTnLxh85gz50KrmM8pdRKdSPyaq
         NgA1mXesEjcFasRc0ZQUxaJEhIAyvOzCubRGFEoPIAIrLuXRHZM1PVKyo0Tkg94+xlic
         UN1YDR57kStPNlpY6jtP29dE4xjcRH7nq537mZCF1kphkWTiIydbVa2cndKcS+5r9O2/
         k8xsr1dmFN5vdWIIxtRAZQXSG9KYvWJ8mFSE2kIdGI2zbPUqpxOD04R5jm6XvHUL7euR
         qj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=HvC/0+76/wdExk0fhtf7+k8mJODHa9QN6WbHXYTZ6fU=;
        b=R3WNTLo1Cr1g4n91dxCSB3suvTK8FR8FMOqp0IFtILiruxiZhSaNC09nnrnHo02+Rj
         lQk+nSZgSJ0FqAmqqzSpZlMXL10MHhzpteNZcmjWPa9vdgOmImeF7u3LGfCyuVjcYVe+
         39BuB4EI0f4l1C6C/rn1+GEgsLWsyco8vuTRmWB25McyN1R8dX2im29BfL78IM3/+0v9
         TsCgMkDWTul/ElIgCo6oo3lAkzsFOiYanIY6o0yHMt7AxXhUuQMsJxUymEUrhhNf4vMj
         28K3pb1TDWL/jTrK/Pc/uCfXQY4KOxq2fv6jZ0VG/HP2twYBl9KtwebAOxzE61LHlgWF
         vm9A==
X-Gm-Message-State: ALQs6tCgHvmQlqJI9GRB1tBZHe7KEbsU8vqFyo33RYex8czFzvkxKsLN
        NMgCms61CjAhiTszpGP9Q3cnrhDeGZA=
X-Google-Smtp-Source: AB8JxZo7HYclhSNxkFj3KoXT3Tyzzx3NGL9jUPsLGJ8J7dRAweDCW6nUUTNGiaETmg6pSZAatvcUXw==
X-Received: by 2002:a17:902:57d8:: with SMTP id g24-v6mr18335116plj.337.1525221099873;
        Tue, 01 May 2018 17:31:39 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id s6-v6sm6306585pgq.19.2018.05.01.17.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 17:31:37 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, bmwill@google.com
Subject: [PATCH v2 1/3] upload-pack: fix error message typo
Date:   Tue,  1 May 2018 17:31:29 -0700
Message-Id: <177c6eb7058adc1996f0595ddc3cc848c91b578f.1525220786.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <cover.1525220786.git.jonathantanmy@google.com>
References: <cover.1525220786.git.jonathantanmy@google.com>
In-Reply-To: <cover.1525220786.git.jonathantanmy@google.com>
References: <cover.1525213052.git.jonathantanmy@google.com> <cover.1525220786.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a typo in an error message.

Also, this line was introduced in 3145ea957d2c ("upload-pack: introduce
fetch server command", 2018-03-15), which did not contain a test for the
case which causes this error to be printed, so introduce a test.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5701-git-serve.sh | 14 ++++++++++++++
 upload-pack.c        |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 72d7bc562..1b4b13cc2 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -173,4 +173,18 @@ test_expect_success 'symrefs parameter' '
 	test_cmp actual expect
 '
 
+test_expect_success 'unexpected lines are not allowed in fetch request' '
+	git init server &&
+
+	test-pkt-line pack >in <<-EOF &&
+	command=fetch
+	0001
+	this-is-not-a-command
+	0000
+	EOF
+
+	test_must_fail git -C server serve --stateless-rpc <in >/dev/null 2>err &&
+	grep "unexpected line: .this-is-not-a-command." err
+'
+
 test_done
diff --git a/upload-pack.c b/upload-pack.c
index 87b4d32a6..c4456bb88 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1252,7 +1252,7 @@ static void process_args(struct packet_reader *request,
 		}
 
 		/* ignore unknown lines maybe? */
-		die("unexpect line: '%s'", arg);
+		die("unexpected line: '%s'", arg);
 	}
 }
 
-- 
2.17.0.441.gb46fe60e1d-goog

