Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A52B51F404
	for <e@80x24.org>; Mon, 27 Aug 2018 19:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeH0Xbh (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 19:31:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37834 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0Xbg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 19:31:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so124829wrr.4
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 12:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rvRMbLUKocGeBQ7ERohVq1PSFQLi+rDviHwHAycDy8Q=;
        b=dQo6sNPVVrdlecGQyEDFafQv2QeCD3/aP9tVkArwPWLl/aX7WAJalhV3gqSd/sqC67
         M/ZQQNZqSfM8FCZzYvyvpA5X2LBMsV28voOxGFtOLLVpzNI2OGlqT8bHiMP4U0Jm9ZAR
         0nqTanI6ez/as/vxeY0cOe5pN0NjPrbMvFKKzijrgF1PGcf8vyDu4gMgCeHWSY7GqyPA
         Ty0VVqNoqz2lq5x8paFrKpR20sLUAAeQPk6/N7CJxK/vf5O534Bsgi+OtP7qEaWIAJHy
         /CP4/RzQc1xFl5cSNFAirepUGnM4DEeufSVwdWGUnPle9g8hGW8T92RPAmRXRXUF9iXA
         TMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rvRMbLUKocGeBQ7ERohVq1PSFQLi+rDviHwHAycDy8Q=;
        b=bfcVD8k2pvT45aWruwxrBN9FetMKvD2KTjDfZ1BUWtk76pjFxytLl73hm5HplBxe0c
         Dc/5PyRzE9duqBZMTWj7V3BbS0W73VTMYLXiJ7O6w4v1YQsHukedfsPGk4wNa/1peXaN
         mgZhD+tCidqGyWTjJHXK3sxMThS329EBbdqcwCmEdd+lprBrjjn4Gi9BhP0nsTw1rrXs
         qK7T19h4B6fuz6/23+cD37kyQqbEb1A+JxCXI4N03vMe+X90bWLxhp0Xy3GRs9HM+vHs
         8m5hGHtM63MR20mYAQu1xUVRqblr8Kh8SgYcu61iY029XW87J8Nozz6Qzq4DK74l0E8R
         fGGg==
X-Gm-Message-State: APzg51BpYHuJteUL+UxGdCUxDdPisMeGczriAKLt+zBqlg6l2jLanMyn
        cz3fB+Z5B+t8uav/orXHD+zXcMJGR6Y=
X-Google-Smtp-Source: ANB0VdZwMN0zS1jHrrWugVMn/zsEKxJkPhIw+J5ZvjXEGKR9Fcvq1GCMiAYbhFOnLlW8pzs2tkWyvQ==
X-Received: by 2002:adf:ef89:: with SMTP id d9-v6mr9499403wro.195.1535399015899;
        Mon, 27 Aug 2018 12:43:35 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q135-v6sm121958wmd.4.2018.08.27.12.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 12:43:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/7] fsck tests: setup of bogus commit object
Date:   Mon, 27 Aug 2018 19:43:17 +0000
Message-Id: <20180827194323.17055-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <20180827194323.17055-1-avarab@gmail.com>
References: <20180827194323.17055-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several fsck tests used the exact same git-hash-object output, but had
copy/pasted that part of the setup code. Let's instead do that setup
once and use it in subsequent tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5504-fetch-receive-strict.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 62f3569891..6d268f3327 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -133,6 +133,10 @@ committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
 This commit object intentionally broken
 EOF
 
+test_expect_success 'setup bogus commit' '
+	commit="$(git hash-object -t commit -w --stdin <bogus-commit)"
+'
+
 test_expect_success 'fsck with invalid or bogus skipList input' '
 	git -c fsck.skipList=/dev/null -c fsck.missingEmail=ignore fsck &&
 	test_must_fail git -c fsck.skipList=does-not-exist -c fsck.missingEmail=ignore fsck 2>err &&
@@ -142,7 +146,6 @@ test_expect_success 'fsck with invalid or bogus skipList input' '
 '
 
 test_expect_success 'push with receive.fsck.skipList' '
-	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
 	git init dst &&
@@ -169,7 +172,6 @@ test_expect_success 'push with receive.fsck.skipList' '
 '
 
 test_expect_success 'fetch with fetch.fsck.skipList' '
-	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
 	refspec=refs/heads/bogus:refs/heads/bogus &&
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
@@ -204,7 +206,6 @@ test_expect_success 'fsck.<unknownmsg-id> dies' '
 '
 
 test_expect_success 'push with receive.fsck.missingEmail=warn' '
-	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
 	git init dst &&
@@ -232,7 +233,6 @@ test_expect_success 'push with receive.fsck.missingEmail=warn' '
 '
 
 test_expect_success 'fetch with fetch.fsck.missingEmail=warn' '
-	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
 	refspec=refs/heads/bogus:refs/heads/bogus &&
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
-- 
2.19.0.rc0.228.g281dcd1b4d0

