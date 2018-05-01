Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE9C91FADF
	for <e@80x24.org>; Tue,  1 May 2018 22:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeEAWWb (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 18:22:31 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:45080 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751080AbeEAWWa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 18:22:30 -0400
Received: by mail-pf0-f171.google.com with SMTP id c10so10043807pfi.12
        for <git@vger.kernel.org>; Tue, 01 May 2018 15:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=tFMvk1i/NksiF3SbDVke0XDDj+ixZs0650+vRInuYYk=;
        b=giQ9s4Kwv6o88Qpa6O+EhRBReCndcL/pyO5ziqgkfW6SxJZNLYGUQiOaFCshtci/ja
         eg2qMtCvjQFG9n11K1TxJ+HqWUBbQMD9WSfwpPef4/6jVqBlzASo/SWLKUDjSuFqH3qZ
         0L7pW3XxAiCdMokHubBWNF4sgQWZuZN/slFeio91s7IAKlOBP5ci8S8JI1YsTpnJ4ZsG
         5ny9zsd9/krIq6CSZ2snHRjBY2L8m8tt44HxqOYLdMO2Pz88HaT766viGABer0MLPrMv
         YMgT4tFsPwWQwRCgTp3oQwxB4PJTkxbuS4zhyDE+4WBywCQ2dVWJenlAazWyW8IhiKFg
         WXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tFMvk1i/NksiF3SbDVke0XDDj+ixZs0650+vRInuYYk=;
        b=A7ArW4ZZf6D1HorUK1Ucc9D5dyDQcPh2HSoMMk6fHTkyGTvw2jBYTdvHUHeU1HLzAW
         g6RvQXXKSK6+e9l4K0uuBadbMDY0uMfVR4F5SO6the2IlkP4wOqKz6s4ObFeS3yICXpN
         x34OFwtaXq222+xCuXjB9V3RorLvKcPveOZpYu8JQ25r4+G+tTg0itn3OmUxCliXP5ID
         myiYj7wcyAyR9/jnqnozBFVq7wrQWDInGFATavKKG4djiLJ7x4+6TEsDZCHXlVTJQ6vY
         VJDnWnoAQs1gNtSdki/jM5i6UcONHPqC6/+uuwkIeV7w8mX+72kSvuSWsheMIm9peg6R
         9fkw==
X-Gm-Message-State: ALQs6tDYf70u+DwZQy1/kkPIam5wG5IY/CsroKq6miMG2kxObeOkQe0S
        bBWchT+PAm4hG0Sjfofe3tmvKtSDmhQ=
X-Google-Smtp-Source: AB8JxZqSQkgf6qsAs1v6UidnAobNbaUVZB/kyZeF4+606CYvx+/VQqz3a9SRlzU7eFJQ4onsb9jTAw==
X-Received: by 2002:a63:7a07:: with SMTP id v7-v6mr14208005pgc.343.1525213349456;
        Tue, 01 May 2018 15:22:29 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id u72-v6sm17192975pgb.16.2018.05.01.15.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 15:22:28 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 1/2] upload-pack: fix error message typo
Date:   Tue,  1 May 2018 15:22:20 -0700
Message-Id: <15e1fa5e6167932d878aa08e81d541c403935172.1525213052.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <cover.1525213052.git.jonathantanmy@google.com>
References: <cover.1525213052.git.jonathantanmy@google.com>
In-Reply-To: <cover.1525213052.git.jonathantanmy@google.com>
References: <cover.1525213052.git.jonathantanmy@google.com>
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
 t/t5701-git-serve.sh | 15 +++++++++++++++
 upload-pack.c        |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 72d7bc562..abbe5b19e 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -173,4 +173,19 @@ test_expect_success 'symrefs parameter' '
 	test_cmp actual expect
 '
 
+test_expect_success 'unexpected lines are not allowed in fetch request' '
+	git init server &&
+
+	# Custom request that tries to filter even though it is not advertised.
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

