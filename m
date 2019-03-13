Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E70620248
	for <e@80x24.org>; Wed, 13 Mar 2019 23:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfCMXzJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 19:55:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53338 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfCMXzI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 19:55:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id e74so1043549wmg.3
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 16:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P58E3RtRX+RvtVyX7qgjbwssFev43I7rdlsp7gXh4wM=;
        b=e6sxEhYaTUqS5N6htfnwzkraHhC10sygE60EYYhB/7sNeJeoGi7aZddfg2CFTOnyzK
         5Td5a0v6JfLyhUx4si6ZnL46w5LVUu18EKXXu0VcXPM0Np8pCvELkePlu/xjUOrAd7DT
         f4s3diZzMiLTkwUZtwWB9+fb40XJ4X1joyCkBNfUNDsOV/JUSaCd7IPoX1q8WspLPxOH
         QTNHmkuAVeR3KEXLoXG6WsZNXchBStlO5MIIEXmpYk+SpFJhWX/8uNBh0Cxkkvec4ZtE
         AtDYOCWqpHVhmT2g/zWEoRD1B3mHdHjJ26LJnokLXrwR/resflqt+1YFmktx3ER7Botu
         VMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P58E3RtRX+RvtVyX7qgjbwssFev43I7rdlsp7gXh4wM=;
        b=Vu9Pu436RsT4wiFadpTVTrMcnzgKC1oKJkodu+nUzX+q24cBKmM7Fl1WfQhYmPRyon
         rYpH66JCym++KkIqxGZEQEqoFd2f1TBId/DGeIJEe7PQKNRqUWMTVl02PDOzL5DHjJd5
         7DpTcv2hAk7vUNaIDX1QpCmcm7s4O7l3Kt25xGUfAdE9jsJpjDPbSBvqpw71+/rVjjQU
         ZsQn3A2HUMG1em65Cn6GtIPiahwhbUSgT7OshGXVo3OjRo9YVNu9d2/GlMS07AnRamG3
         lAdbncRPnaJ2TmlVgr9NzopS6S5Rj2MEvjNLITQa+B6FP35gyfh9ROtVYiTl8wnj1kVi
         Wy/Q==
X-Gm-Message-State: APjAAAU5Xkt5CwawCrtnm3fX34Oli3saROXkl3+7uJxCsevKs3NIi1lf
        AP1pub/Nje5UGbjXkLtl3GWQSVWNx2A=
X-Google-Smtp-Source: APXvYqy81wEf1z7RskA50UJyq7kIId52uAJfj9/ybyVezLaAb8rpoGazuMbq+vbJgNuE50upmZ6phg==
X-Received: by 2002:a1c:9c02:: with SMTP id f2mr400224wme.91.1552521306353;
        Wed, 13 Mar 2019 16:55:06 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b10sm9998566wru.92.2019.03.13.16.55.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 13 Mar 2019 16:55:05 -0700 (PDT)
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
Subject: [PATCH 5/5] reflog expire: don't assert the OID when locking refs
Date:   Thu, 14 Mar 2019 00:54:39 +0100
Message-Id: <20190313235439.30439-6-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <87imwmbv7l.fsf@evledraar.gmail.com>
References: <87imwmbv7l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The locking protocol for reflogs involves getting a *.lock file on the
loose ref[1] (even if the actual ref is packed). This isn't needed to
expire the reflog, and needlessly results promotes reference update
contention to hard errors in e.g. "gc".

During reflog expiry, the cmd_reflog_expire() function first iterates
over all known references, and then one-by-one acquires the lock for
each one to expire its reflog. By the time it gets around to
re-visiting the references some of the OIDs may have changed.

This has been the case ever since "reflog expire" was initially
implemented in 4264dc15e1 ("git reflog expire", 2006-12-19). As seen
in that simpler initial version of the code (and the same is the case
before this change) we subsequently use the OID to inform the expiry,
but never needed to use it to lock the reference associated with the
reflog.

Thus the verify_lock() function would fail with e.g. "ref '%s' is at
%s but expected %s" if the repository was being updated concurrent to
the "reflog expire".

This made "reflog expire" exit with a non-zero exit status, which in
turn meant that a "gc" command (which expires reflogs before forking
to the background) would encounter a hard error in such a scenario.

If we instead lock the reference without considering what OID we last
saw it at, we won't encounter user-visible contention to the extent
that core.filesRefLockTimeout mitigates it. See 4ff0f01cb7 ("refs:
retry acquiring reference locks for 100ms", 2017-08-21).

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

1. https://public-inbox.org/git/54857871.5090805@alum.mit.edu/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index ef053f716c..4d4d226601 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3037,7 +3037,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_oid_basic(refs, refname, oid,
+	lock = lock_ref_oid_basic(refs, refname, NULL /* NOT oid! */,
 				  NULL, NULL, REF_NO_DEREF,
 				  &type, &err);
 	if (!lock) {
-- 
2.21.0.360.g471c308f928

