Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41EAC1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 06:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbeKHPmz (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 10:42:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36181 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKHPmz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 10:42:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id a8-v6so41003wmf.1
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 22:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/5+b6JMLkixhCimVKvHDD/i2HkSUU08QBrk+yZM+0F4=;
        b=SSMjG0QYgdhSweD9ZqactT4BMO6YWxLj1CEMuvpq7pklesn9v78HotfLXe4oO49n4M
         yWQdW/EyQ5TWdomtywTmDQuQn36G/uNpnTOroH5tmVYnnUqXJeD2cdumKL68Fd4Le8aw
         R3oe7iBn7nSOff9YgA0Ja2qAG4Gu2ZhLJVSpDg4ldBXkkZfisD4UCB1g74T6cxyosvGH
         5baFopxaOp69GvGiCdb+zAoIOe7xXMI67Dynau1sUKsFdILEEY5zT6+mgCFYlHQxkNDE
         78+O9M9Ue/iyMV0vnrRy8vV/Nl4CVowuEr7NUkdb0++YtMIrlKR7Pus/irSo9BsSCqVg
         LHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/5+b6JMLkixhCimVKvHDD/i2HkSUU08QBrk+yZM+0F4=;
        b=CJYX015J8k8BiQ6x+QYqkgTq3dIF4g0MnAqt7QT3+k6iaqe0YF8VIC+rWbYfQp3lv3
         ofRSAp9dCX3ztMe9T69nPG4uaDPaKUghNl/bWfJbEJANa8XD1Sv+Ts55MaxXMEWOi0xD
         orInnH4TDhjHykvAnneXi+CRFeZUSZwqiKgvpRRDV5RdxhfmUnZhLUlOjc6AkMv811Cj
         xjvEkFwZ4DonA/bClQ6VZBkAricKBHQOAVjL4JW4PYgkeREvwPMJ8RWHh7lJB5QzRbhA
         ybqnwmI0m/hfrlYOpFjaFMUfZ+ZZgv89y5eWrrdrnTjXkmWVOK5m9XCe0T1j6scMxX/B
         aoig==
X-Gm-Message-State: AGRZ1gI4TADE4kA5fKlfyLc+PsaypC02yxUv24mUjOk4fEOeDBtxOz+b
        HFawk8i0YgiPRuu/nvUF2cU=
X-Google-Smtp-Source: AJdET5cPSokWifc0r2ShnjRNwODrRBBGKfsyak10SinA5hchgZIiixLwv9CIBEDwDW3S/N2bNkz5Lw==
X-Received: by 2002:a1c:992:: with SMTP id 140-v6mr2385689wmj.136.1541657341906;
        Wed, 07 Nov 2018 22:09:01 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v10-v6sm5628629wrq.4.2018.11.07.22.09.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 22:09:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Nov 2018, #03; Wed, 7)
References: <xmqqy3a5b4x2.fsf@gitster-ct.c.googlers.com>
        <20181107130950.GA30222@szeder.dev>
        <CACsJy8CuYgX9yFisJerf9C_6-hyyZD8DjzTsQ7v-uKpbm5LvQQ@mail.gmail.com>
        <xmqqpnvgbkvd.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 08 Nov 2018 15:09:00 +0900
In-Reply-To: <xmqqpnvgbkvd.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 08 Nov 2018 07:09:26 +0900")
Message-ID: <xmqq36sc85j7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Not surprising. The i18n series makes fsck output localized strings
>> and without updating grep to test_i18ngrep, new tests will fail. If
>> 'pu' was passing before, I'm ok with just ejecting this series for
>> now. Then I wait for the other to land, rebase, fixup and resubmit.
>
> Let me first see if I can come up with a merge-fix that can be
> carried around during the time this topic cooks, before talking
> about dropping and reattempting the series.
>
> For a change like this, a time-window in which the codebase is
> quiescent enough may never come, and because the changes go all over
> the place, mostly but not entirely repetitive, it costs a lot, not
> just to write but also to review them.

I have configured the machinery used to rebuild integration branches
so that the following is squashed in when the nd/i18n topic is
merged.

The part that touches t1450 needs to be split out and squashed when
nd/per-worktree-ref-iteration gets merged, *if* the nd/i18n topic
needs to jump over the other topic, but I'll worry about it when it
happens---I think per-worktree ref iteration series that is in next
should be ready enough that we do not mind having nd/i18n waiting
for it.

Anyway, here is what is in refs/merge-fix/nd/i18n, which gets
cherry-picked and squashed into the merge when nd/i18n is merged.

 t/t1450-fsck.sh                    | 8 ++++----
 t/t5616-partial-clone.sh           | 2 +-
 t/t5703-upload-pack-ref-in-want.sh | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 8a5f4c7189..2e5e979336 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -109,7 +109,7 @@ test_expect_success 'HEAD link pointing at a funny object (from different wt)' '
 	echo $ZERO_OID >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail git -C wt fsck 2>out &&
-	grep "main-worktree/HEAD: detached HEAD points" out
+	test_i18ngrep "main-worktree/HEAD: detached HEAD points" out
 '
 
 test_expect_success 'other worktree HEAD link pointing at a funny object' '
@@ -117,7 +117,7 @@ test_expect_success 'other worktree HEAD link pointing at a funny object' '
 	git worktree add other &&
 	echo $ZERO_OID >.git/worktrees/other/HEAD &&
 	test_must_fail git fsck 2>out &&
-	grep "worktrees/other/HEAD: detached HEAD points" out
+	test_i18ngrep "worktrees/other/HEAD: detached HEAD points" out
 '
 
 test_expect_success 'other worktree HEAD link pointing at missing object' '
@@ -125,7 +125,7 @@ test_expect_success 'other worktree HEAD link pointing at missing object' '
 	git worktree add other &&
 	echo "Contents missing from repo" | git hash-object --stdin >.git/worktrees/other/HEAD &&
 	test_must_fail git fsck 2>out &&
-	grep "worktrees/other/HEAD: invalid sha1 pointer" out
+	test_i18ngrep "worktrees/other/HEAD: invalid sha1 pointer" out
 '
 
 test_expect_success 'other worktree HEAD link pointing at a funny place' '
@@ -133,7 +133,7 @@ test_expect_success 'other worktree HEAD link pointing at a funny place' '
 	git worktree add other &&
 	echo "ref: refs/funny/place" >.git/worktrees/other/HEAD &&
 	test_must_fail git fsck 2>out &&
-	grep "worktrees/other/HEAD points to something strange" out
+	test_i18ngrep "worktrees/other/HEAD points to something strange" out
 '
 
 test_expect_success 'email without @ is okay' '
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 336f02a41a..9643acb161 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -281,7 +281,7 @@ test_expect_success 'upon cloning, check that all refs point to objects' '
 	test_must_fail git -c protocol.version=2 clone \
 		--filter=blob:none $HTTPD_URL/one_time_sed/server repo 2>err &&
 
-	grep "did not send all necessary objects" err &&
+	test_i18ngrep "did not send all necessary objects" err &&
 
 	# Ensure that the one-time-sed script was used.
 	! test -e "$HTTPD_ROOT_PATH/one-time-sed"
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 3f58f05cbb..7053899cb5 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -208,7 +208,7 @@ test_expect_success 'server is initially ahead - no ref in want' '
 	cp -r "$LOCAL_PRISTINE" local &&
 	inconsistency master 1234567890123456789012345678901234567890 &&
 	test_must_fail git -C local fetch 2>err &&
-	grep "ERR upload-pack: not our ref" err
+	test_i18ngrep "ERR upload-pack: not our ref" err
 '
 
 test_expect_success 'server is initially ahead - ref in want' '
@@ -254,7 +254,7 @@ test_expect_success 'server loses a ref - ref in want' '
 	echo "s/master/raster/" >"$HTTPD_ROOT_PATH/one-time-sed" &&
 	test_must_fail git -C local fetch 2>err &&
 
-	grep "ERR unknown ref refs/heads/raster" err
+	test_i18ngrep "ERR unknown ref refs/heads/raster" err
 '
 
 stop_httpd
-- 
2.19.1-856-g8858448bb4

