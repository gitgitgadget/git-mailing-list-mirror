Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8783C1F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 19:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbeKSFZo (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 00:25:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40296 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbeKSFZn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 00:25:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so3182454wmf.5
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 11:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zh9nhdgB/pWsQCooUfn625BBA+tTw/23WGjZ96VuWF0=;
        b=hrM726OVOOUd7MimNhzlj/KHbep81Py/Zn/zwP8EnP3MCtbBQ2YTI6cESKqK/bDjur
         BIq9YOWlunOOm5aK1c4hdsDhXPY/6e5kmzpAr1paldUzfD2z+2a/26yLDXkTk/5GAX4g
         dZPOCD4UBAEf8aZ8AG+iCzGfNKhXupSIXMyjVND2MI7zjRNHtQxILpiQfbIFymxiTr/Y
         DvIVqnwcNB+jbc1iePVXWEWgBsce7yrXQP+TrbHGVN1niuab9iXhKXw8QkedCyAvrAKB
         /cH6aWH6asvXo4ksKcFktbcgwS1HOOmrSd6nS1Il8S267SxpiY94CGxDOHVKAFVkBrgb
         5oWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zh9nhdgB/pWsQCooUfn625BBA+tTw/23WGjZ96VuWF0=;
        b=l1ENW/sOR+0pG64k+V8mdFd4aBBlCtHM1J60drk48xZb8RdzxfFk3xBNfePqHkRgq/
         d59Wby6NSrdBskvzU8A9VKV52+OzF5KAggcZILYBAYtogH+XBWRVfYWDEVokxpiVjr5u
         Y+dHzXTkxXCSoLldM8wUCzpMCG1LvxhaZhs3JS2xSGQKTPv3Kdj7wXpd26mQws9Vk8XD
         YTORkcT7xZaRyBGzmj5/VFFTBrChMnoJkaMYLq+bikOv5HtIeDtK5Avpl1azW1foEj6E
         WzfhUWAjcnF4Jo8bVvNUMBQ8oGJtbeTQ4zhmwvHUxf9h7F2EkSQB6reUi4UHlK5QFBZP
         30cA==
X-Gm-Message-State: AGRZ1gK3dnbQyTy2NHXCWEiDasbHCMXzsGQm0YPVDFC67VsTwt+JPiqL
        ueSFrmbhL1KwXB5hhQXz9EdZQrsg
X-Google-Smtp-Source: AJdET5csDFmikHgulOCMj3t93mhcyh6OGdUNIGHJMVy56q/UlGVFlXJN4U8TH6Bcd7yMc1v9c5USHg==
X-Received: by 2002:a1c:e58c:: with SMTP id c134mr4692839wmh.124.1542567877675;
        Sun, 18 Nov 2018 11:04:37 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id t17sm5640041wme.43.2018.11.18.11.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 11:04:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3] read-cache: make the split index obey umask settings
Date:   Sun, 18 Nov 2018 19:04:29 +0000
Message-Id: <20181118190429.15581-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <87efbi1tk4.fsf@evledraar.gmail.com>
References: <87efbi1tk4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the split index write out its .git/sharedindex_* files with the
same permissions as .git/index. This only changes the behavior when
core.sharedRepository isn't set, i.e. the user's umask settings will
be respected.

This hasn't been the case ever since the split index was originally
implemented in c18b80a0e8 ("update-index: new options to
enable/disable split index mode", 2014-06-13). A mkstemp()-like
function has always been used to create it. First mkstemp() itself,
and then later our own mkstemp()-like in
f6ecc62dbf ("write_shared_index(): use tempfile module", 2015-08-10)

A related bug was fixed in df801f3f9f ("read-cache: use shared perms
when writing shared index", 2017-06-25). Since then the split index
has respected core.sharedRepository.

However, using that setting should not be required simply to make git
obey the user's umask setting. It's intended for the use-case of
overriding whatever that umask is set to. This fixes cases where the
user has e.g. set his umask to 022 on a shared server in anticipation
of other user's needing to run "status", "log" etc. in his repository.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Here it is with a rewritten commit message & adjusted comment as
discussed in the v2 discussion.

 read-cache.c           |  3 ++-
 t/t1700-split-index.sh | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 4ca81286c0..e7e77e780b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3150,7 +3150,8 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		struct tempfile *temp;
 		int saved_errno;
 
-		temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
+		/* Same initial permissions as the main .git/index file */
+		temp = mks_tempfile_sm(git_path("sharedindex_XXXXXX"), 0, 0666);
 		if (!temp) {
 			oidclr(&si->base_oid);
 			ret = do_write_locked_index(istate, lock, flags);
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 2ac47aa0e4..fa1d3d468b 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -381,6 +381,26 @@ test_expect_success 'check splitIndex.sharedIndexExpire set to "never" and "now"
 	test $(ls .git/sharedindex.* | wc -l) -le 2
 '
 
+test_expect_success POSIXPERM 'same mode for index & split index' '
+	git init same-mode &&
+	(
+		cd same-mode &&
+		test_commit A &&
+		test_modebits .git/index >index_mode &&
+		test_must_fail git config core.sharedRepository &&
+		git -c core.splitIndex=true status &&
+		shared=$(ls .git/sharedindex.*) &&
+		case "$shared" in
+		*" "*)
+			# we have more than one???
+			false ;;
+		*)
+			test_modebits "$shared" >split_index_mode &&
+			test_cmp index_mode split_index_mode ;;
+		esac
+	)
+'
+
 while read -r mode modebits
 do
 	test_expect_success POSIXPERM "split index respects core.sharedrepository $mode" '
-- 
2.19.1.1182.g4ecb1133ce

