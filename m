Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3CA2200B9
	for <e@80x24.org>; Thu,  3 May 2018 23:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751137AbeECXrP (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 19:47:15 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37727 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbeECXrO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 19:47:14 -0400
Received: by mail-pg0-f67.google.com with SMTP id a13-v6so14222066pgu.4
        for <git@vger.kernel.org>; Thu, 03 May 2018 16:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=iCyNuGZGeMP6qmCENY+440ChyfydG7pOf9Gn44oc6/o=;
        b=Nl6c3ulY3XlB/iw/7ucfhpYr2Bbn/2vDnde4T4Y9VtKk+iQgEeQeKNrHMoSSMcjcUP
         ygyIxsEKNJ9qSrsJxW6DHmsGim94UDdSD9aaK7mc19xJfOO03iNmCcnYdg46/PNvCifs
         I7bVR2wiHTCGSsPEEkVovlYfscWF0OJH/NzfEybgSKH1kdguep9if4dA6Sidj7ir4N8B
         M4TLtqAV7NQBbhT6+qgaQ4cfG3FJznhwEiXfmoQDl/ql/cub5UIf5HeTExyPr3TSOabY
         UEIvwpPObKALlc462/z2k32eFXtCM/AIQo7k1DO6iJ/JfaopZtBUjESNNRiB0Xr4rRZz
         1KBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=iCyNuGZGeMP6qmCENY+440ChyfydG7pOf9Gn44oc6/o=;
        b=GOyATcUF9On95mkw1/Dguf/TC2FKZzznVgBDdeFYtjX4BNC5B/C+ToEo8jsJInrkud
         IzHcca63IIX5Hk5hxROWxKijmcTTvP2KW8DD2EIPmFvdWuDBpV/RkltsxXR3mlCFqowf
         6BdbpnGZBxCzzUgfWS+kxTP4aud855NGO/+d9+pDk+9jvVjh7FKcftoxD8O7tByUs0HF
         ZBUtLjNs5tJUZ8HCEer/oVdSmaDVJM7yF3NyQ+oAuQi8qFSGALDmU3zFSUM//PwOcWcr
         bKQJhiv88AcFpnisUQGOMgzq4tvfmBXtVYmWmEkHl71fhNx6jq2CYB0iT/vcoBUBrc6d
         q8gA==
X-Gm-Message-State: ALQs6tDmY7zF/1ByadkOXkbEB4lXrrMMnXQ011MtcH61+LL/uR1ugXAj
        67HobrnSSsnTPDik3HIOU3e0JLB8/QM=
X-Google-Smtp-Source: AB8JxZqvwtvU9iGPoKBaNeg45m6Qdhx6fsGICPsfwIhpnR9CcslSrFxH+50dSWU8jw4txx/EvFMuzg==
X-Received: by 2002:a17:902:264:: with SMTP id 91-v6mr25505387plc.341.1525391232949;
        Thu, 03 May 2018 16:47:12 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id a67-v6sm7924669pgc.23.2018.05.03.16.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 May 2018 16:47:11 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Subject: [PATCH v3 1/3] upload-pack: fix error message typo
Date:   Thu,  3 May 2018 16:46:54 -0700
Message-Id: <182d1575765b611111a24a38c1397e2a99a2adab.1525391172.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <cover.1525391172.git.jonathantanmy@google.com>
References: <cover.1525391172.git.jonathantanmy@google.com>
In-Reply-To: <cover.1525391172.git.jonathantanmy@google.com>
References: <cover.1525213052.git.jonathantanmy@google.com> <cover.1525391172.git.jonathantanmy@google.com>
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
index 72d7bc562..6439f7792 100755
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
+	test_must_fail git -C server serve --stateless-rpc <in 2>err &&
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

