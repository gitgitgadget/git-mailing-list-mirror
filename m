Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E61620248
	for <e@80x24.org>; Thu, 14 Mar 2019 12:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfCNMfG (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 08:35:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37459 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfCNMfG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 08:35:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id y15so5680427wro.4
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 05:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+WADQxBhoTqWIZ9NHjihkjBLU5lRPCm9pM4d6ii9r+I=;
        b=qTzEQCF5mjMv9gnd6D0Y93gFGG2OoofZSZBkN4idd8po4F/u8JJjF6ZCrO4LCOoa63
         4yTkQ7VakkHjb4c5qXofFFeIwqR7NwzZWVHx81ugkt2ACM8Gbklc5P1He27sU56QNFZP
         Z5jvFQsgN1+5KKYhs54gWen6oXjvEM98xeXIYOuCBmp4RpGr4okXHiYYztnEBvLD7Aur
         /7Z+BM4kjlg25jzl5mvs7FyHGRz6Qi74y/vA+pukhycvaOmVycW7w8iv/LfyQm9N0+8j
         0isv0iqMUVP9BkViFOhX3CBhJ3oL1BbkTmG1M6KABGu7qi5yzCP2ImfpvROehDQ1rJ1Z
         uwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+WADQxBhoTqWIZ9NHjihkjBLU5lRPCm9pM4d6ii9r+I=;
        b=BXyJqdpAuZChZHXcFDiaOQLW1xMQEzKqP3WpCG1R0rQtfBnDIW8kmIScsIWRdR/vxR
         nPhFevMQL3A72uMgEdGR5bYmS9NGJorR25zhlIhHaz4tavAxuFZ7O/Jpccw0Ge444HnF
         kqcCCbpwRtDiinCn3tE8Yo52PF6xBgntYKOSPffG3TsBgLYYFXy9DgLkrjs9WWvFTatr
         gBR98vWwDa6MSEraBwGYBIS4a+iP4A1eGOQlzjAqe8GejV7V/LliSxoghCiSLXkltomv
         gWXj8rcHa8MrKlkmLqBqPDHl9RJ77fPK9mlxH9GJLgX4+vpyDHXjD7gURNEqyqmJerL0
         DPAw==
X-Gm-Message-State: APjAAAW50Ny0kClbF0pgm3yXkjVTKHXrD6b7s7bs4Z8tjX6OOeWf4INk
        GXTHZrR+VztsbYFgb7yHe9H14MhUa2Q=
X-Google-Smtp-Source: APXvYqzkLEZJRbs2HTwoBDqXxK5uSPC/YJaS+xr+6yX+iP5zN+tJxovSEXdkP6iIbmnX2zE1Pl8RVA==
X-Received: by 2002:a5d:4b05:: with SMTP id v5mr21652473wrq.323.1552566903761;
        Thu, 14 Mar 2019 05:35:03 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p6sm42374095wre.63.2019.03.14.05.35.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 14 Mar 2019 05:35:03 -0700 (PDT)
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
Subject: [PATCH v2 7/7] reflog expire: don't assert the OID when locking refs
Date:   Thu, 14 Mar 2019 13:34:39 +0100
Message-Id: <20190314123439.4347-8-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190313235439.30439-1-avarab@gmail.com>
References: <20190313235439.30439-1-avarab@gmail.com>
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

