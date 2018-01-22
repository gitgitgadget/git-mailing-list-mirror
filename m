Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13E981F424
	for <e@80x24.org>; Mon, 22 Jan 2018 11:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751117AbeAVLEA (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 06:04:00 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41570 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbeAVLD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 06:03:59 -0500
Received: by mail-pf0-f195.google.com with SMTP id c6so3745095pfi.8
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 03:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6UL09GXftL3Qcw7hwwXVejlNXdP0FvsJ1OLN+ejiG0g=;
        b=dln4UzPnmnR1An6N22Ydx+HUPgdXnKd2VkyP5jepQMLRNae+sDAbdp7anZ1popVAZg
         85VlHI5LrKQYqlOkj7NxSUWteAAEcoCdWV9QmPtN19HmI5vAOOxPMFeBhoNaufzKGYPH
         29fRkXWkqqsS+AYrILs+g5347WcjEljMqeArfSSYJzLPeGHEDjSyA0hf08KdfKMSOsbU
         7iuU3GetPVHpXzF4kPAfycFrOiiplAI7OE5DEXLdJcLFkYhN9lcNoBjR7UztAPjxjDOx
         vibFKczm+0byg0ntHoKtLqNIIHiGHxjFhU7ladwZ+oGq6eBmZ1kcKZN3lAgRlAK+MeZH
         +vRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6UL09GXftL3Qcw7hwwXVejlNXdP0FvsJ1OLN+ejiG0g=;
        b=o9J4TMci59qWe3XRHSSiaV+xTw9hO194G8LUzsbCCtb8Gx2yB8nIP4KmSuenmjpMCs
         9AbZE6mawgoBFO0iA95kyNqxToOZSerFNW6Gc1y8JTHNeRtNgITkMgkeGndnhULZ1Z1m
         9ATTcy9JApVpYvptQZ3l3QxceDPtF/ucfrmFXFE2GhAx4gbDfPaoABtQyOAlPLRCW5X+
         g/iA6lkW1W2h8NS32NFC+i5dr9wOz+ACgj0kRcdeBcoqQjEQr0nRgUEWl03cRxFrGTyb
         KOaGKRd4ASzFeHi7DDtmt7RDeiIgn+LnmBLFriFFfVip5Jauaf24bSNofDLvTFwWq+pG
         EX0A==
X-Gm-Message-State: AKwxyte9RxW35iZ/Opz1IxNWvB2n39OW3+TM7XkwK5DAmIe/TahLg6T2
        S/o+Dl+T5vY/UvzsCP8KG+vsFw==
X-Google-Smtp-Source: AH8x224xjYK6oTF6ShmpwxT7MvVwMg63GPOSp2YLGy64zeVVLxIxV5OC6/U0B7V0HW1LERoDaZPf8w==
X-Received: by 10.98.35.14 with SMTP id j14mr8167870pfj.62.1516619038800;
        Mon, 22 Jan 2018 03:03:58 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id 184sm57092pfd.156.2018.01.22.03.03.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2018 03:03:58 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 22 Jan 2018 18:03:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/3] read-cache: don't write index twice if we can't write shared index
Date:   Mon, 22 Jan 2018 18:03:34 +0700
Message-Id: <20180122110334.4411-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.0.47.g3d9b0fac3a
In-Reply-To: <20180122110334.4411-1-pclouds@gmail.com>
References: <20180122110334.4411-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a0a967568e ("update-index --split-index: do not split if $GIT_DIR is
read only", 2014-06-13), we tried to make sure we can still write an
index, even if the shared index can not be written.

We did so by just calling 'do_write_locked_index()' just before
'write_shared_index()'.  'do_write_locked_index()' always at least
closes the tempfile nowadays, and used to close or commit the lockfile
if COMMIT_LOCK or CLOSE_LOCK were given at the time this feature was
introduced.  COMMIT_LOCK or CLOSE_LOCK is passed in by most callers of
'write_locked_index()'.

After calling 'write_shared_index()', we call 'write_split_index()',
which calls 'do_write_locked_index()' again, which then tries to use the
closed lockfile again, but in fact fails to do so as it's already
closed. This eventually leads to a segfault.

Make sure to write the main index only once.

[nd: most of the commit message and investigation done by Thomas, I only
tweaked the solution a bit]

Helped-by: Thomas Gummerer <t.gummerer@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c           |  5 +++--
 t/t1700-split-index.sh | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index c568643f55..c58c0a978a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2561,8 +2561,9 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		if (!temp) {
 			hashclr(si->base_sha1);
 			ret = do_write_locked_index(istate, lock, flags);
-		} else
-			ret = write_shared_index(istate, &temp);
+			goto out;
+		}
+		ret = write_shared_index(istate, &temp);
 
 		saved_errno = errno;
 		if (is_tempfile_active(temp))
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index af9b847761..d2a8e0312a 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -401,4 +401,23 @@ done <<\EOF
 0642 -rw-r---w-
 EOF
 
+test_expect_success SANITY 'graceful handling when splitting index is not allowed' '
+	test_create_repo ro &&
+	(
+		cd ro &&
+		test_commit initial &&
+		git update-index --split-index &&
+		test -f .git/sharedindex.*
+	) &&
+	cp ro/.git/index new-index &&
+	test_when_finished "chmod u+w ro/.git" &&
+	chmod u-w ro/.git &&
+	GIT_INDEX_FILE="$(pwd)/new-index" git -C ro update-index --split-index &&
+	chmod u+w ro/.git &&
+	rm ro/.git/sharedindex.* &&
+	GIT_INDEX_FILE=new-index git ls-files >actual &&
+	echo initial.t >expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.16.0.47.g3d9b0fac3a

