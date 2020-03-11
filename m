Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by archive.lwn.net (Postfix) with ESMTP id 022717D910
	for <lwn-git@archive.lwn.net>; Wed, 11 Mar 2020 15:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgCKPa3 (ORCPT <rfc822;lwn-git@archive.lwn.net>);
        Wed, 11 Mar 2020 11:30:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42286 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbgCKPa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 11:30:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id n18so3347543edw.9
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 08:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z9N2FiDasB1GTcgWKXWKR9bvOx5vlMiXWpRaFb+0keQ=;
        b=GrBln3u1J9uWYnLnc5w53DOUA0IdlfZGCB1SS0oBacjPerUbxXAa8YzDYm8LaW3fIY
         +z4e4NLqB+TR2VgIpfuJelFTGGTpe0cDJywOB5jwq/i2eJ0cmQf7e8JbkDDDNK0ewBhV
         J0kOUOPl1Cf1jCYX5rBGjDQfoQrgArBztbNxBCh2j44ksyBCKriX2dUhi6lXah6xQ9e9
         WvFAQJlu7LhzZr1PbVJoU8ql93PBkFkGdE9T5BnSu/6+ionPa2BsI+r7/FoMEVzyDDM+
         jDvXk/oByjNSsAhsyB6nhLDzvVWBk0Z1ZIkusi8Yea79RO/q6T3paKooed9xcJ+eZW/c
         uNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z9N2FiDasB1GTcgWKXWKR9bvOx5vlMiXWpRaFb+0keQ=;
        b=PN2oQBzxgcFq80R7lCb9UlQRY3vQDZOwdi0WoidBDj4L5W8hTbsCcqPWg8M7FF+2tF
         lftI5B3A9Tn5e01vLcZIoocwB1RCDKR9oEmrWUCof20HTd7sVqEvYGU+ht6rBYUdRg2w
         p3rxopEB4LWa9vkqDarOn+eeTGzFebFV5iTylLzglPEhi8Tw8WZkSpHaJFUQ/ZBqYCXr
         c4aUoJCbz3CoZinXVKOcrN5iBswTaj5n+vpn/8EueTr+6Z3t49kMCjNTWt596JqFiO2n
         WqlOwFoK0XjkptRBGZaISP9FvOByQIl8o/byEdZaGgKQJJNGN+BP2vP+Z8pHlvSWxgCK
         3qrw==
X-Gm-Message-State: ANhLgQ3a2UWIVcYVB0MbnXg56V0++MdOtmj11eq/QmdFoxiun50nKoiK
        msZQf5lBxRfHOXj7EdqAVbAR+OaZ
X-Google-Smtp-Source: ADFU+vsv2CBKiNFEYu8eu5Ws+5menrtR6LlgkDOAs/reG7NVnpZj9d5L8yxFEGxUAUCWMR2NlE6guw==
X-Received: by 2002:aa7:c7cd:: with SMTP id o13mr3531628eds.138.1583940625956;
        Wed, 11 Mar 2020 08:30:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dk4sm2505979ejb.74.2020.03.11.08.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 08:30:25 -0700 (PDT)
Message-Id: <84b89d7843527d7b1f3e00f122dc1e82f1ced381.1583940623.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.722.v2.git.git.1583940623.gitgitgadget@gmail.com>
References: <pull.722.git.git.1583903621.gitgitgadget@gmail.com>
        <pull.722.v2.git.git.1583940623.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Mar 2020 15:30:22 +0000
Subject: [PATCH v2 1/2] sequencer: clear state upon dropping a become-empty
 commit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://archive.lwn.net:8080/git/84b89d7843527d7b1f3e00f122dc1e82f1ced381.1583940623.git.gitgitgadget@gmail.com/>
List-Archive: <http://archive.lwn.net:8080/git/>
List-Post: <mailto:git@vger.kernel.org>

From: Elijah Newren <newren@gmail.com>

In commit e98c4269c8 ("rebase (interactive-backend): fix handling of
commits that become empty", 2020-02-15), the merge backend was changed
to drop commits that did not start empty but became so after being
applied (because their changes were a subset of what was already
upstream).  This new code path did not need to go through the process of
creating a commit, since we were dropping the commit instead.
Unfortunately, this also means we bypassed the clearing of the
CHERRY_PICK_HEAD and MERGE_MSG files, which if there were no further
commits to cherry-pick would mean that the rebase would end but assume
there was still an operation in progress.  Ensure that we clear such
state files when we decide to drop the commit.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 sequencer.c             | 2 ++
 t/t3424-rebase-empty.sh | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 7477b15422a..e528225e787 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1957,6 +1957,8 @@ static int do_pick_commit(struct repository *r,
 		flags |= ALLOW_EMPTY;
 	} else if (allow == 2) {
 		drop_commit = 1;
+		unlink(git_path_cherry_pick_head(r));
+		unlink(git_path_merge_msg(r));
 		fprintf(stderr,
 			_("dropping %s %s -- patch contents already upstream\n"),
 			oid_to_hex(&commit->object.oid), msg.subject);
diff --git a/t/t3424-rebase-empty.sh b/t/t3424-rebase-empty.sh
index 98fc2a558a0..e1e30517ea6 100755
--- a/t/t3424-rebase-empty.sh
+++ b/t/t3424-rebase-empty.sh
@@ -123,4 +123,12 @@ test_expect_success 'rebase --interactive uses default of --empty=ask' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rebase --merge does not leave state laying around' '
+	git checkout -B testing localmods~2 &&
+	git rebase --merge upstream &&
+
+	test_path_is_missing .git/CHERRY_PICK_HEAD &&
+	test_path_is_missing .git/MERGE_MSG
+'
+
 test_done
-- 
gitgitgadget

