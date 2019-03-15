Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0802E20248
	for <e@80x24.org>; Fri, 15 Mar 2019 16:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfCOQA0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 12:00:26 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:39007 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbfCOQAY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 12:00:24 -0400
Received: by mail-wm1-f44.google.com with SMTP id t124so6530747wma.4
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 09:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z+rLvUzHSP2IZk76mXTgDM2KCWQ+BW4ue1TD0Qiwpq8=;
        b=FdVzpoE73TnLLag58pFQh5yd6awzlk/W4cNfFj/bT43X4ACc0l+zjdwoKpeOFSOzer
         5cH6G5zaraw40JGUDlJ0lH1TmKL8BjKEG+jBgKiubYjhyfcq5E7/17fjMzvP+8LIU74k
         CXbXYr8Z3CeApuLC2FNW2/Nj6m9hD4Qywi+X+LC3FD6w7cTlQqFx+YyI+GdAn9ATPra1
         fK2YrNPWwLfpQeUUwuiw6VK6IQF3QKL/r19dLHBCE+BDsRAzeIAOOQfW+fJVST3/m0Op
         eikaPh4sLkgx1HIbM7ZRXKgl8kVWWSh7Ljj/WTw9hlnNsPTkdBUjyv9DU3UCHLaIDNeV
         xLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z+rLvUzHSP2IZk76mXTgDM2KCWQ+BW4ue1TD0Qiwpq8=;
        b=RWrM12MagQlYeytr7FXD99gqLbS7rLl74TGPtyjlg4c61TdLkvd2xw8ZuEqaIDr8Pv
         MTVIsBRWVROhp6sw7uSnLgnd7FsuIZ2lpxGhxHhWsnbZvUWAO6i2QRXpVM7dH0rn2naM
         xkgW5TfP2MJXBnLYFc6yLri77ZmmELlUXcUQd0cKSe8JmevI3Z6cLFUkhLhTc7gd+H6w
         GZxROIdriA5FPwcP9zV3i/Kri3C+DyFMLaCY6CO07E2F92B/Eh3qC2bPu6OLbE2mEQJR
         4lHaF+0H5vrOl2P0Ij7jBEcQE2gkwyT4nFIGU1LV5LuQTXG85XcSiVOwNViP4XjRMnkC
         C1BA==
X-Gm-Message-State: APjAAAUFEgkrYrjTIBIlWpQCzRNASy4ocRmFPoqZGx6DmqHgOCErFVtv
        XnpsYca/RNnHpO4caD46FvODXGTSGM4=
X-Google-Smtp-Source: APXvYqxG1WZSiPGrIUkcivYcRVzC+Jh7ao26V/TCIpRyAI6OIJ80r5+LSw8HDxIOwqnplh04F9F8NQ==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr2763231wmh.38.1552665621745;
        Fri, 15 Mar 2019 09:00:21 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a18sm467766wmm.14.2019.03.15.09.00.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 15 Mar 2019 09:00:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 8/8] reflog expire: don't assert the OID when locking refs
Date:   Fri, 15 Mar 2019 16:59:59 +0100
Message-Id: <20190315155959.12390-9-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190314123439.4347-1-avarab@gmail.com>
References: <20190314123439.4347-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During reflog expiry, the cmd_reflog_expire() function first iterates
over all reflogs in logs/*, and then one-by-one acquires the lock for
each one to expire its reflog by getting a *.lock file on the
corresponding loose ref[1] (even if the actual ref is packed).

This lock is needed, but what isn't needed is locking the loose ref as
a function of the OID we found from that first iteration. By the time
we get around to re-visiting the reference some of the OIDs may have
changed.

Thus the verify_lock() function called by the lock_ref_oid_basic()
function being changed here would fail with e.g. "ref '%s' is at %s
but expected %s" if the repository was being updated concurrent to the
"reflog expire".

By not passing the OID to it we'll try to lock the reference
regardless of it last known OID. Locking as a function of the OID
would make "reflog expire" exit with a non-zero exit status under such
contention, which in turn meant that a "gc" command (which expires
reflogs before forking to the background) would encounter a hard
error.

This behavior of considering the OID when locking has been here ever
since "reflog expire" was initially implemented in 4264dc15e1 ("git
reflog expire", 2006-12-19). As seen in that simpler initial version
of the code we subsequently use the OID to inform the expiry (and
still do), but never needed to use it to lock the reference associated
with the reflog.

By locking the reference without considering what OID we last saw it
at, we won't encounter user-visible contention to the extent that
core.filesRefLockTimeout mitigates it. See 4ff0f01cb7 ("refs: retry
acquiring reference locks for 100ms", 2017-08-21).

Unfortunately this sort of probabilistic contention is hard to turn
into a test. I've tested this by running the following three subshells
in concurrent terminals:

    (
        cd /tmp &&
        rm -rf git &&
        git init git &&
        cd git &&
        while true
        do
            head -c 10 /dev/urandom | hexdump >out &&
            git add out &&
            git commit -m"out"
        done
    )

    (
        cd /tmp &&
        rm -rf git-clone &&
        git clone file:///tmp/git git-clone &&
        cd git-clone &&
        while git pull
        do
            date
        done
    )

    (
        cd /tmp/git-clone &&
        while git reflog expire --all
        do
            date
        done
    )

Before this change the "reflog expire" would fail really quickly with
a "but expected" error. After this change both the "pull" and "reflog
expire" will run for a while, but eventually fail because I get
unlucky with core.filesRefLockTimeout (the "reflog expire" is in a
really tight loop). That can be resolved by being more generous with
higher values of core.filesRefLockTimeout than the 100ms default.

As noted in the commentary being added here we also need to handle the
case of references being racily deleted, that can be tested by adding
this to the above:

    (
        cd /tmp/git-clone &&
        while git branch topic master && git branch -D topic
        do
            date
        done
    )

We could change lock_ref_oid_basic() to always pass down
RESOLVE_REF_READING to refs_resolve_ref_unsafe() and then
files_reflog_expire() to detect the "is it deleted?" state. But let's
not bother, in the event of such a race we're going to redundantly
create a lock on the deleted reference, and shortly afterwards handle
that case and others with the refs_reflog_exists() check.

1. https://public-inbox.org/git/54857871.5090805@alum.mit.edu/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index ef053f716c3..c7ed1792b3b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3036,8 +3036,14 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	 * The reflog file is locked by holding the lock on the
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
+	 *
+	 * We don't pass down the oid here because we'd like to be
+	 * tolerant to the OID of the ref having changed, and to
+	 * gracefully handle the case where it's been deleted (see oid
+	 * -> mustexist -> RESOLVE_REF_READING in
+	 * lock_ref_oid_basic()) ...
 	 */
-	lock = lock_ref_oid_basic(refs, refname, oid,
+	lock = lock_ref_oid_basic(refs, refname, NULL,
 				  NULL, NULL, REF_NO_DEREF,
 				  &type, &err);
 	if (!lock) {
@@ -3045,6 +3051,13 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		strbuf_release(&err);
 		return -1;
 	}
+	/*
+	 * When refs are deleted their reflog is deleted before the
+	 * loose ref is deleted. This catches that case, i.e. when
+	 * racing against a ref deletion lock_ref_oid_basic() will
+	 * have acquired a lock on the now-deleted ref, but here's
+	 * where we find out it has no reflog anymore.
+	 */
 	if (!refs_reflog_exists(ref_store, refname)) {
 		unlock_ref(lock);
 		return 0;
-- 
2.21.0.360.g471c308f928

