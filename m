Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605771F453
	for <e@80x24.org>; Thu, 25 Oct 2018 14:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbeJYWy2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 18:54:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45396 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730791AbeJYWy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 18:54:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9-v6so10006019qtj.12
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 07:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=V3a6vw/htfr0lng81/Za2j+nittw7+yxJiBY97dukUE=;
        b=ti79o5VUYkYdyP3JgV1+w3Y4hJ4jYVmoXQ7MO/R0YJ4mP5CL8S8JtFe7eXCFx7w+Uz
         BSTyEtWvQFzsJmztuiT+V9zLHt8aPMd05xTJ42jjnNwdkl7x7Su0qgJZNVkBqnTiyZaB
         OmMGtfqBk9+rDkTeDtwhu/ww457EXrv7rym/c2zyEZ+YwFRfE+tiMaYJp4g3U5ronlEO
         60G0DkECsT/va3d51eRYKXuQrPe0OYgRZIGPDG5gondiZaZeTn9OkA55hkALv/U1iBfJ
         18GOiIY1D0rKNQgeZZhx1n1xMaAAM3yyNKHU920hsIGMHhVDvEdmeifU96uVBpqVTyGu
         qUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V3a6vw/htfr0lng81/Za2j+nittw7+yxJiBY97dukUE=;
        b=t/t/9J5FmpWlL41IVlHdlPmnasfl6smtVpECOIJGUSNMIKRjzF9USpdbovZYfZgxHI
         Kwpe8/dkF3fysLYOQXIYMTJp/plaIylpo4GARB8pxxS6Udx3sX+djUV6AWM4lacsj1NZ
         GeC9LBeZzNaexI1wNRpAJ/PLEMKu49tqL5+5xH1e0f3PZBE6DQ4Z6SXRkqSdpGoC4gPL
         HFYo2diwrGtm0d+Flvem8VQoCWI2I4h/UXs0trde4NThUDimZda/YyFRbsH3eJsAnD8c
         F51AM8DkCzb/5QDCEPgAxItVT2Ypv+e7D9TWlb0m1cbFfCVivcAWKrzubE77perop1Ih
         eBHQ==
X-Gm-Message-State: AGRZ1gLKeJQXScj3cVDvr6+ojvIbjx2Rwd6A2KU+n6ADCSXPLZpBfILD
        bGCQgFb7bw2vb6WlCoE7OJhT5xJKzrQOOQ==
X-Google-Smtp-Source: AJdET5cyLBU1jyjwufkk7j8fgXvszydwedLUp5Qmn/o/RwcArqNEZ3DIE3mj2S5L62UHq8MxD9aOBw==
X-Received: by 2002:a0c:e414:: with SMTP id o20mr1685553qvl.175.1540477289351;
        Thu, 25 Oct 2018 07:21:29 -0700 (PDT)
Received: from oxygen.dhcp.hunter.cuny.edu ([146.95.23.190])
        by smtp.gmail.com with ESMTPSA id 18-v6sm6398796qtm.13.2018.10.25.07.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Oct 2018 07:21:28 -0700 (PDT)
From:   Khinshan Khan <khanshan501@gmail.com>
To:     git@vger.kernel.org
Cc:     Khinshan Khan <khanshan501@gmail.com>
Subject: [PATCH] Move upstream status from gitstring to f
Date:   Thu, 25 Oct 2018 10:21:25 -0400
Message-Id: <1540477285-18308-1-git-send-email-khanshan501@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Upstream status should be spaced even if other statuses don't exist
for consistency of view. Eg: if a repository is freshly cloned, the
prompt shows "(master=)" but with an additional status like a change,
it'll show "(master *=)". Now it'll show "(master =)" and accounts for
other states as well.

Signed-off-by: Khinshan Khan <khanshan501@gmail.com>
---
 contrib/completion/git-prompt.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 983e419..4715d33 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -517,8 +517,8 @@ __git_ps1 ()
 		b="\${__git_ps1_branch_name}"
 	fi
 
-	local f="$w$i$s$u"
-	local gitstring="$c$b${f:+$z$f}$r$p"
+	local f="$w$i$s$u$p"
+	local gitstring="$c$b${f:+$z$f}$r"
 
 	if [ $pcmode = yes ]; then
 		if [ "${__git_printf_supports_v-}" != yes ]; then
-- 
2.7.4

