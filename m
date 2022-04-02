Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B3AC433F5
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 16:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357855AbiDBQNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 12:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357797AbiDBQMx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 12:12:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCC360063
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 09:10:59 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id f6-20020a1c3806000000b0038e4a0fc5easo3110199wma.3
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 09:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MeEzhbEHtTaBVg6MOBhhPaE+R0IoY5wZDi9UCIaHSQg=;
        b=qQ3mmZGmrwO2VkGXezDqzD2SnKGJgygyFIraTsYqVcBP0Bnca1L1uANe/p+h52d8mu
         mUVv/IgvsZX6yOTuCg/5mK9fnmHOOcRYRW97HcwxmzMZh5eqU2HxHzostQftPV8nRpm6
         9N+dwwEQy1Zr0btmsWnCG9cfQo5dHXw8c75t2AV8KECFocLKXy5sy+PpFIvjYptew061
         7tiNnQf/qeXfLUIQnKwe2JuPQ30J8jfRCiDaeKkDbUIxZT/8whE3G2pW5jzYfKhwGSOa
         EUqbBytJtMCI+fSUx60JwU5kXv1encO1/n7RrS+fbzgo1zJK5YjWx7KCD7yfGU0PcdHx
         bjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MeEzhbEHtTaBVg6MOBhhPaE+R0IoY5wZDi9UCIaHSQg=;
        b=p2ov/WU1xGDSPp3UeonIIBIb+00atJJMzJGwGtJXejkCZw1Bh19dCCT/KWp0p2PyUv
         B6oVjZsEFJDHyrjU34JRTSJ0TjcciJEYSqEK3qOygesSRM3od6QJkxz5AHtHY1hqlbl1
         4/3NByFpI5mOoP5lGi74iW04HzxM8KlqS0Ap16rsMdnhSyRdEvY2g9DwfDhR8DaMR9nG
         ia4zvymG0VAVYVwk1ys96kh5KusCj1OAfikPN3FRrXXL/ew/HW2HoV4ZzjIdNyd/eoZK
         lhBu6CKwp9I8s6aQG0w559cCtQ5DH2rr/3Z5Gbfj68/MNAvz0GHE7g4DTrZkmxlNnee5
         sDcQ==
X-Gm-Message-State: AOAM532fKdc627otcpHMe9ftb7y+r9Kbg1P9aGp1d1sVWnmei8b5jvO5
        i7AWj9DaydRFPNALh/0dlKjqK3eZHws=
X-Google-Smtp-Source: ABdhPJwwMtgXx9+67ULxuUy9zkX9Iq86V2sUZZ9QVa1y90D5Qud3rBsrTprnOqSBFIDp1oGsJrnlKQ==
X-Received: by 2002:a05:600c:19cd:b0:38c:b84f:41fb with SMTP id u13-20020a05600c19cd00b0038cb84f41fbmr12898049wmq.137.1648915856795;
        Sat, 02 Apr 2022 09:10:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n23-20020a05600c3b9700b0038b7c4c0803sm13904268wms.30.2022.04.02.09.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 09:10:56 -0700 (PDT)
Message-Id: <03022a2fcd14bad453925c616d86bc2f69926456.1648915853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1181.v2.git.1648915853.gitgitgadget@gmail.com>
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
        <pull.1181.v2.git.1648915853.gitgitgadget@gmail.com>
From:   "Bagas Sanjaya via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 02 Apr 2022 16:10:49 +0000
Subject: [PATCH v2 2/6] sequencer: factor GIT_AUTHOR_* from message strings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Bagas Sanjaya <bagasdotme@gmail.com>

Factor messages containing GIT_AUTHOR_* variable.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 sequencer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 84eed9e96bc..647f5efa656 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -848,17 +848,17 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 	for (i = 0; i < kv.nr; i++) {
 		if (!strcmp(kv.items[i].string, "GIT_AUTHOR_NAME")) {
 			if (name_i != -2)
-				name_i = error(_("'GIT_AUTHOR_NAME' already given"));
+				name_i = error(_("'%s' already given"), "GIT_AUTHOR_NAME");
 			else
 				name_i = i;
 		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_EMAIL")) {
 			if (email_i != -2)
-				email_i = error(_("'GIT_AUTHOR_EMAIL' already given"));
+				email_i = error(_("'%s' already given"), "GIT_AUTHOR_EMAIL");
 			else
 				email_i = i;
 		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_DATE")) {
 			if (date_i != -2)
-				date_i = error(_("'GIT_AUTHOR_DATE' already given"));
+				date_i = error(_("'%s' already given"), "GIT_AUTHOR_DATE");
 			else
 				date_i = i;
 		} else {
@@ -867,11 +867,11 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 		}
 	}
 	if (name_i == -2)
-		error(_("missing 'GIT_AUTHOR_NAME'"));
+		error(_("missing '%s'"), "GIT_AUTHOR_NAME");
 	if (email_i == -2)
-		error(_("missing 'GIT_AUTHOR_EMAIL'"));
+		error(_("missing '%s'"), "GIT_AUTHOR_EMAIL");
 	if (date_i == -2)
-		error(_("missing 'GIT_AUTHOR_DATE'"));
+		error(_("missing '%s'"), "GIT_AUTHOR_DATE");
 	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
 		goto finish;
 	*name = kv.items[name_i].util;
-- 
gitgitgadget

