Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BD9A1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 16:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeCOQor (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 12:44:47 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45619 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbeCOQom (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 12:44:42 -0400
Received: by mail-lf0-f65.google.com with SMTP id h127-v6so11151879lfg.12
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 09:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HVjnoz1drTDHOUo+1z6XbgWjprA7565PrwSDS0RByOk=;
        b=LAW/TRkYWxSDeCmHNBM1Df+iX+wFWgl+nBzS6D819xzI5EUEen0wxGTj5IUiIVnwtt
         nJtKeZDLm1VIlKp0GL2OQqpEyfGpUQIOFVgDAVv8luIekO5Zl4b302CjB256eQOIrQtl
         ktqLD852W+//pAvC+QdAsLnS+maqLJz5cW6aWMUpt0QXDIK9ID8Zz79ZRoFQH7jqTjcT
         mG3jJOMLv09w2dZtvv0bunBAnlDMHdv0OLXTDj65qdiiB+uvXm87BZA4ASGbSqqYXZgr
         EvC28fsZILup62+r+8PD9TrgEZRJmziWLp+JrHA5lEZvUH1kM/Hoyb3PyU82LNiC7gfP
         4Xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVjnoz1drTDHOUo+1z6XbgWjprA7565PrwSDS0RByOk=;
        b=I2y7O5jbowJw5ZETiSh+sSSBm2EBao3B886wMe7TNwre2g8iAZr95XnUVBcGAgz0DM
         f75GDrJHUp2bIfc2MBYB0VUjwkEp7PmIctg2dZZpP8NznTi5zEZoALPZ8sIpJ5DNOXq+
         4p2Qo0We5ldHwJWEtNyBogK6FziQQny+Gzq3H5sHZ+ckf7J8iOEYbh98Co48jMKo2RAr
         rLflo9Pn9Jrm2qVomgsTsHd5v9q7GS/rIEihXoHobmKiI7kHGSZTaTBWAE14UNnRQLjc
         8HS543j7XHdn4CpomE2/3bkyeEaZyhYHTmXHs2yKJER6ArVPVXpRotd9W7tfAt6ZaiF4
         +hjw==
X-Gm-Message-State: AElRT7GkA61vVXRXtHWYijua0V0r/uqD5Vr+ymosT54n8AYx4EEOjQms
        fsk2OQVbo5A7GRCWL367LvQ3FQ==
X-Google-Smtp-Source: AG47ELv2eTD6K+rSDIY1lj1A803O+CA2f2DyEJ5JcAf1/4IQBjMFPc7DwQtW85SGTCl2oLgPqEHFwQ==
X-Received: by 2002:a19:5e50:: with SMTP id z16-v6mr3435167lfi.108.1521132281497;
        Thu, 15 Mar 2018 09:44:41 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u24sm1037406lju.32.2018.03.15.09.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Mar 2018 09:44:40 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] worktree: delete dead code
Date:   Thu, 15 Mar 2018 17:44:11 +0100
Message-Id: <20180315164412.14697-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180315164412.14697-1-pclouds@gmail.com>
References: <20180303033918.15751-1-pclouds@gmail.com>
 <20180315164412.14697-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This "link" was a feature in early iterations of multiple worktree
functionality for some reason it was dropped [1]. Since nobody creates
this "link", there's no need to check it.

This is mostly used to let the user moves a worktree manually [2]. If
you move a worktree within the same file system, this hard link count
lets us know the worktree is still there even if we don't know where it
is.

We support 'worktree move' now and don't need this anymore.

[1] last appearance in v4 message-id:
    1393675983-3232-25-git-send-email-pclouds@gmail.com
    and the reason in v5 was "revisit later", message-id:
    1394246900-31535-1-git-send-email-pclouds@gmail.com
[2] 23af91d102 (prune: strategies for linked checkouts - 2014-11-30)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/gitrepository-layout.txt | 5 -----
 builtin/worktree.c                     | 8 --------
 2 files changed, 13 deletions(-)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index c60bcad44a..e85148f05e 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -275,11 +275,6 @@ worktrees/<id>/locked::
 	or manually by `git worktree prune`. The file may contain a string
 	explaining why the repository is locked.
 
-worktrees/<id>/link::
-	If this file exists, it is a hard link to the linked .git
-	file. It is used to detect if the linked repository is
-	manually removed.
-
 SEE ALSO
 --------
 linkgit:git-init[1],
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 670555dedd..e55edf2aa5 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -101,15 +101,7 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 	}
 	path[len] = '\0';
 	if (!file_exists(path)) {
-		struct stat st_link;
 		free(path);
-		/*
-		 * the repo is moved manually and has not been
-		 * accessed since?
-		 */
-		if (!stat(git_path("worktrees/%s/link", id), &st_link) &&
-		    st_link.st_nlink > 1)
-			return 0;
 		if (st.st_mtime <= expire) {
 			strbuf_addf(reason, _("Removing worktrees/%s: gitdir file points to non-existent location"), id);
 			return 1;
-- 
2.16.2.903.gd04caf5039

