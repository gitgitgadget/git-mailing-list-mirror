Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFD7920136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933976AbdBQOE6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:04:58 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36141 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933938AbdBQOEz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:04:55 -0500
Received: by mail-pf0-f196.google.com with SMTP id 19so4180605pfo.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=61yl6VjZ7z2glLGfXwCPVpse2Adurksv0JTAUEpJ720=;
        b=eHkAIFJAjMkbc1PjWp5YjOv+CyL6+rp8DqukkKJbt1hKlXXaYmlJ9tsOAcAZso8eu0
         NBUIJoy9oreXxgxFYrYm/vG93DrbZsiItBLfW/6E85VEwuGIBhy91B8ovoKIs0mPavOB
         eqwByK0T8NtK9Vi39WhQ2aZZXDN8ZWXRMJTUgAtInLHvn/e8uDDoIVn2cR2uAmd5Mmx7
         Z3ucNLrje6lhNz7TtnbJNx+XderCGdXipIu9XD9xMo3sD05ZyFf2yJOSHY54Ksv1JS3s
         htkH0kGKihNx2c95H8QglksKUcyG5Joo2h8mofYZdJs4+ICb/STYKix700Wi4rjy7d48
         L1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=61yl6VjZ7z2glLGfXwCPVpse2Adurksv0JTAUEpJ720=;
        b=UNsDw2EnraZ1mqDjxFz8MmFoQOc3Us6R6Ds9JXbFGB2NmfwTCPu8d0YPEpLy8ia+GW
         XnVuzISGTLfBH0EteARzaTJPo8YjInh5GZSKuX2zH9Vd3glQ8R95EjUVChTzOAJFwsqm
         PaJ3ykTHCJNZ5JDdFHAwWN4916giXEc8p5nAYMzn4O84P/z3GROJQLApDPQ5yk8NVEMd
         /wvzhRWoYoOJFEaSoYNadw9nElCqEG8h5TZO3Wpj0kYvXLtbuglRJx1fTuDHhFO5rrrX
         GF3Qj1TN3ZfLepuJ86lZ805vgaDpYu6bvJpU2VjT2aurbykXcE1DNwBF0SwJWsrzBAOH
         6EJA==
X-Gm-Message-State: AMke39ntgZbN4OpWGmF19/CJ+SEzjzAsGgwKeSYounT/2FAt0/boYlKVNefJoAtnvR9XKw==
X-Received: by 10.84.218.129 with SMTP id r1mr11384546pli.6.1487340294949;
        Fri, 17 Feb 2017 06:04:54 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id d68sm19967633pfj.92.2017.02.17.06.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:04:53 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:04:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 00/16] Remove submodule from files-backend.c
Date:   Fri, 17 Feb 2017 21:04:20 +0700
Message-Id: <20170217140436.17336-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170216114818.6080-1-pclouds@gmail.com>
References: <20170216114818.6080-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 only changes 07/16 but it's kinda important because I broke
packed-refs. packed-refs' path became $GIT_DIR/packed-refs instead of
$GIT_COMMON_DIR/packed-refs and as a result the majority of refs will
disappear in linked worktrees. Interdiff

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 685ea5c14..82be3f90f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -938,9 +938,11 @@ static void files_path(struct files_ref_store *refs, struct strbuf *sb,
 	va_start(vap, fmt);
 	strbuf_vaddf(&tmp, fmt, vap);
 	va_end(vap);
-	if (is_per_worktree_ref(tmp.buf) ||
-	    (skip_prefix(tmp.buf, "logs/", &ref) &&
-	     is_per_worktree_ref(ref)))
+	if (!strcmp(tmp.buf, "packed-refs") || !strcmp(tmp.buf, "logs"))
+		strbuf_addf(sb, "%s/%s", refs->gitcommondir.buf, tmp.buf);
+	else if (is_per_worktree_ref(tmp.buf) ||
+		 (skip_prefix(tmp.buf, "logs/", &ref) &&
+		  is_per_worktree_ref(ref)))
 		strbuf_addf(sb, "%s/%s", refs->gitdir.buf, tmp.buf);
 	else
 		strbuf_addf(sb, "%s/%s", refs->gitcommondir.buf, tmp.buf);

Nguyễn Thái Ngọc Duy (16):
  refs-internal.c: make files_log_ref_write() static
  files-backend: convert git_path() to strbuf_git_path()
  files-backend: add files_path()
  files-backend: replace *git_path*() with files_path()
  refs.c: share is_per_worktree_ref() to files-backend.c
  refs-internal.h: correct is_per_worktree_ref()
  files-backend: remove the use of git_path()
  refs.c: introduce get_main_ref_store()
  refs: rename lookup_ref_store() to lookup_submodule_ref_store()
  refs.c: flatten get_ref_store() a bit
  refs.c: kill register_ref_store(), add register_submodule_ref_store()
  refs.c: make get_main_ref_store() public and use it
  path.c: move some code out of strbuf_git_path_submodule()
  refs: move submodule code out of files-backend.c
  files-backend: remove submodule_allowed from files_downcast()
  refs: rename get_ref_store() to get_submodule_ref_store() and make it public

 path.c               |  34 ++---
 refs.c               | 144 +++++++++++----------
 refs.h               |  13 ++
 refs/files-backend.c | 349 +++++++++++++++++++++++++++++++--------------------
 refs/refs-internal.h |  28 ++---
 submodule.c          |  31 +++++
 submodule.h          |   1 +
 7 files changed, 348 insertions(+), 252 deletions(-)

-- 
2.11.0.157.gd943d85

