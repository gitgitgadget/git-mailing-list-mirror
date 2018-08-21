Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084B81F954
	for <e@80x24.org>; Tue, 21 Aug 2018 23:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeHVCuf (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 22:50:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38308 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeHVCuf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 22:50:35 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so397296wmi.3
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 16:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fMaxX7viv0j+B4FWwwrA4foYZVtw7dbDZ13Gx2Ck210=;
        b=D3UUhW1vf2pR6tXX1vTmU0E/dD7Y7AJ+CdPAuVlHK8PcrISB5z3TFM8/VfnOVPW6X2
         ahyz0SFC8d8yttMw5bzNObqdvbCxL/QgU4hq0HuYelGfCF/IYuwperjQJgTlQjl9oRvq
         kIEV1KbzzMyNjvK0eaCZk/EJlQjgjp5v1b4+OqKqNyfpPnNTMyiEKpdrdv4I7+YuWIHc
         qs01ycxUDd8AZ/jkTGusHzUjlnoBp6q2CUhN8rRHOKmYziGeBct8dv7kad3tWumEyUZX
         Zo6dAJf5grtUSJFpzE3jgbYdjMSct5meNiPSGZvfV4ou5Y41P/lKeZ/u/Y0+BasGXJc6
         0qrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fMaxX7viv0j+B4FWwwrA4foYZVtw7dbDZ13Gx2Ck210=;
        b=JcofIKQJOrAniviMiTnUMAlIzISCC/qOQvYPsYj8j6f/xGZ7JgVpCKoWqtqntitqvX
         iNmAWIc1qo623B00iOj+onChjNjDSbLgNWM20WOQoWVry2suTms5FWBAc6gdYZ2rJzBY
         Kb0/6f/2Nrkw0r/hQq9iMPY8S0KPShym+yIZdqOTwia+Ass+pJ7679yFZCfD5bmk0Z83
         uF2qNZgKDYTGCQGk1j+/OV4FXuib2MROe3Ghh+czz9W3BkF6JzJ+swvBOhgJ7AsDvR+a
         Kk27qX6BiPB9b7wIGTH2yoKQnHNJn7aPkVAgrQCYC2PSMegn7fUZ4slXVmFnWDXXxmnD
         ZHMg==
X-Gm-Message-State: APzg51D14NuxtWskHQNhNJC6K5DbRlWdCUbkkZQYvGgx7Kfit4+uKVtH
        7kR+uqbNpeD3he9nJsVnFJE=
X-Google-Smtp-Source: ANB0VdZb8gl5RuRFBbIpUH0e83E30GKq1Y9nyGqiG4nZ9gunJmdCfdUZqR/hxBEt0dFdrifVkqMLMA==
X-Received: by 2002:a1c:14c3:: with SMTP id 186-v6mr778488wmu.21.1534894101317;
        Tue, 21 Aug 2018 16:28:21 -0700 (PDT)
Received: from localhost.localdomain (84-236-78-30.pool.digikabel.hu. [84.236.78.30])
        by smtp.gmail.com with ESMTPSA id l72-v6sm1166880wma.17.2018.08.21.16.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Aug 2018 16:28:20 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t7501-commit: drop silly command substitution
Date:   Wed, 22 Aug 2018 01:28:11 +0200
Message-Id: <20180821232811.3610-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.136.gd2dd172e64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test '--dry-run with conflicts fixed from a merge' in
't7501-commit.sh', added in 8dc874b2ee (wt-status.c: set commitable
bit if there is a meaningful merge., 2016-02-15), runs the following
unnecessary and downright bogus command substitution:

  ! $(git merge --no-commit commit-1) &&

I.e. after 'git merge ...' is executed and expectedly fails, the test
attempts to execute its output:

  Merging:
  80f2ea2 commit 2
  virtual commit-1
  found 1 common ancestor:
  e60d113 Initial commit
  Auto-merging test-file
  CONFLICT (content): Merge conflict in test-file
  Automatic merge failed; fix conflicts and then commit the result.

as a command, which most likely fails, because there is no such
command as "Merging:".  Then '!' negates the failed exit status, the
test continues, and eventually succeeds.

Remove this command substitution and use 'test_must_fail' to ensure
that 'git merge' fails.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t7501-commit.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 51646d8019..d766bf34c4 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -677,7 +677,7 @@ test_expect_success '--dry-run with conflicts fixed from a merge' '
 	git checkout -b branch-2 HEAD^1 &&
 	echo "commit-2-state" >test-file &&
 	git commit -m "commit 2" -i test-file &&
-	! $(git merge --no-commit commit-1) &&
+	test_must_fail git merge --no-commit commit-1 &&
 	echo "commit-2-state" >test-file &&
 	git add test-file &&
 	git commit --dry-run &&
-- 
2.19.0.rc0.136.gd2dd172e64

