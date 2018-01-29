Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE28F1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbeA2WkY (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:40:24 -0500
Received: from mail-yb0-f201.google.com ([209.85.213.201]:54366 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752137AbeA2WiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:09 -0500
Received: by mail-yb0-f201.google.com with SMTP id v135so6582511ybe.21
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=QtnOM5lZ6mjzWKWt2V1ZPb4En8pzprGLPCIcXb5iWPY=;
        b=m3OiVHuMIzmNF4gMnAF0lx+z1j6B7eBOOU2+/6MpyoxZ4AJK+yD/7+FtQ5zcxQpZPi
         RKYjwItDn7ldtrOq7IJzIefexBhwwn4A+TJMrgO03KD/UDuD2TuSmOrx+RAMH/pUF+2r
         uTaON5aadI6Z+jYi82Q+Zjg4Gz3ZchXXlqcd/KXv8oGykrt3ektlRQSU+v0v/0cuOzE3
         OylYSy9Xp/OaJUU6xHYEB4v1QlYHDU/diw+4VqnWTxvCIdyxMHZdfF2/e8oM1hrtazSr
         UTk8PjmqIW50YUdiERJWaY44P7+1tMbSTDKEsV1NNFlKP0G3GlY9VxMdmJzo/bhFQQja
         rDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=QtnOM5lZ6mjzWKWt2V1ZPb4En8pzprGLPCIcXb5iWPY=;
        b=gmyUzXWtlcE/umETYZ98KHuILyPPsNqaRUZxVFufu/TpuGVqDl563K0ILCKWZhLsLY
         8rE3QorQIbKk4KjJQK/h14RVX5VieIkkztE7KxhmHNNsCIp4YLoNZK5+ogFqUIyCmxk7
         JCd4O7lBma+TywbpwDFtm6jRp/Z8p1tCB3tlctE/fQlf7+lrOGeN55t5tesBqiwpKMDt
         Ftn1EPy+6N9m7ThcoR9rJ65SeBDmHp9ZtvammCMvYv+MSY33pmfNEAI2HJuA9N4mhsjs
         zzrD2DYqNZd7pjOOFEe28o1egcF0de0jH/zGs8LwiJEwMaDZd7Sh6i6akNeUdTQC+MNO
         l3SA==
X-Gm-Message-State: AKwxytcGACS3xfbsY8xKt9hRGVciJWOFmd0ThTrrEKW3GmP5sdSQHwMH
        MX9+gOKDJY3Vm8Tzs5C4NMcD7R9PBIGRZqFVbtAzBY8jYfHm5o+Q1J5hOVtTl3p80uFnz8+xG/T
        r61N9fAjROQeVzB14kD4Jim5z3cyZ45HXgFF0ZqP4d1Ohy4rc/cBr45aJdQ==
X-Google-Smtp-Source: AH8x224XM7Igp0g6pdKqpnd/iQS52z/Wj/J6cT3Ncr1D77jfXo54Bf4IGvnPVCSTZOAGRrks8GqbmgpXroI=
MIME-Version: 1.0
X-Received: by 10.13.255.70 with SMTP id p67mr13030692ywf.138.1517265489170;
 Mon, 29 Jan 2018 14:38:09 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:03 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-13-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 12/37] reflog: rename 'new' variables
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
 builtin/reflog.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 223372531..c1bcab5c5 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -289,20 +289,20 @@ static int should_expire_reflog_ent(struct object_id *ooid, struct object_id *no
 				    const char *message, void *cb_data)
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
-	struct commit *old, *new;
+	struct commit *old, *new_commit;
 
 	if (timestamp < cb->cmd.expire_total)
 		return 1;
 
-	old = new = NULL;
+	old = new_commit = NULL;
 	if (cb->cmd.stalefix &&
-	    (!keep_entry(&old, ooid) || !keep_entry(&new, noid)))
+	    (!keep_entry(&old, ooid) || !keep_entry(&new_commit, noid)))
 		return 1;
 
 	if (timestamp < cb->cmd.expire_unreachable) {
 		if (cb->unreachable_expire_kind == UE_ALWAYS)
 			return 1;
-		if (unreachable(cb, old, ooid) || unreachable(cb, new, noid))
+		if (unreachable(cb, old, ooid) || unreachable(cb, new_commit, noid))
 			return 1;
 	}
 
-- 
2.16.0.rc1.238.g530d649a79-goog

