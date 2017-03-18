Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B1A52095D
	for <e@80x24.org>; Sat, 18 Mar 2017 04:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751023AbdCREzH (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 00:55:07 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33969 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750712AbdCREzG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 00:55:06 -0400
Received: by mail-pg0-f67.google.com with SMTP id b5so12479844pgg.1
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 21:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vvu9/891i3MGqzOLOjGxvodZU3V3L+yl6o0qLaAIplk=;
        b=FnE5P89YJ2c6ePUZOlIboL/jV7/cTjwiFjJLjY0PjI/v257wHoKAr++QIix7ZAuzBj
         YYoHqMnBZVmY+83ylmYoNeTEvJun6J3QLXRiyIS07DefL4hoyB6zs1m0XLjPt302sSiB
         cHZNjAN9wxOW3/45RxYwwyA8I6oUrSPbb3CoFEfR7jRAkfCcc1n/R7Z5lIKBbtYJRjaw
         pfj7fmAdQMsRIURuUuc23gohWGedeFD88esmTAbkToltm7LBHxiDqxZnMoEwY7awyMVV
         oxSQpoqKLaIxEP0RaxQ+sy107vj6T+Cn89DgbnVcpJpqtJ1Z9WrnARd7X8rxrrSGumfM
         4Kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vvu9/891i3MGqzOLOjGxvodZU3V3L+yl6o0qLaAIplk=;
        b=R9MHeMD13P1Ocfgzmnc92zSv6UeDIuErw6gM0yOT7tIR4ClyYHdhHsxCFyO9SQxYxd
         96Lh08JLvBGM0AhmRE4R2JVXynr3VxGQ7L9q+2OH9J5eaAs2+wBh5RGmrFPKvqtZFMO+
         0qbyV00h9sVNvgA6vCyRko2roECnhAB+ZhadZbPSoRZxNJILoa4RqOw9acFEPEQWY+QG
         Xt+jXFsHy3fPuEUbtcUQnYM+kmOZJaY2iGNCN63b9DckzJ/DztlkAacN0qfczKPGspnS
         mX4rh+lMl9YfoTZ5k/kVW0iMBi04um+nktituMZT6NmHQ5D/HXbVGDOl5cBJBV1S+nBO
         Vt5A==
X-Gm-Message-State: AFeK/H3fKUSS2djIHKGE/eDGG4VUvkPudAgsJ0VbxbGMMrBB5hbXscce1F61nYAIiDvnNg==
X-Received: by 10.99.60.76 with SMTP id i12mr19929908pgn.30.1489802661242;
        Fri, 17 Mar 2017 19:04:21 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id u80sm19191591pgb.32.2017.03.17.19.04.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 19:04:20 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 09:04:15 +0700
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
Subject: [PATCH v6 03/27] files-backend: delete dead code in files_init_db()
Date:   Sat, 18 Mar 2017 09:03:13 +0700
Message-Id: <20170318020337.22767-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318020337.22767-1-pclouds@gmail.com>
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

safe_create_dir() can do adjust_shared_perm() internally, and init-db
has always created 'refs' in shared mode since the beginning,
af6e277c5e (git-init-db: initialize shared repositories with --shared -
2005-12-22). So this code looks like extra adjust_shared_perm calls are
unnecessary.

And they are. But let's see why there are here in the first place.

This code was added in 6fb5acfd8f (refs: add methods to init refs db -
2016-09-04). From the diff alone this looks like a faithful refactored
code from init-db.c. But there is a subtle difference:

Between the safe_create_dir() block and adjust_shared_perm() block in
the old init-db.c, we may copy/recreate directories from the repo
template. So it makes sense that adjust_shared_perm() is re-executed
then to fix potential permission screwups.

After 6fb5acfd8f, refs dirs are created after template is copied. Nobody
will change directory permission again. So the extra adjust_shared_perm()
is redudant. Delete them.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0a6d2bf6bc..0ef80c51cc 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -4110,10 +4110,6 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 	 */
 	safe_create_dir(git_path("refs/heads"), 1);
 	safe_create_dir(git_path("refs/tags"), 1);
-	if (get_shared_repository()) {
-		adjust_shared_perm(git_path("refs/heads"));
-		adjust_shared_perm(git_path("refs/tags"));
-	}
 	return 0;
 }
 
-- 
2.11.0.157.gd943d85

