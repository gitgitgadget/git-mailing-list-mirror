Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3597E1F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934713AbeF3JJN (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:09:13 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:32928 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934818AbeF3JIs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:08:48 -0400
Received: by mail-lf0-f48.google.com with SMTP id u14-v6so3419830lfu.0
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMjr5IAr8F2z+VYG65tsvkOvXrRUIaCOzHLFDHfPbDQ=;
        b=uADalIs8ypv+QYWq9LPz6B0rxDs1RmtytyXcUWy0Y8bPFCP4xwXCWdgf1QckJpUe7g
         kvvvdHlXoV2JO0G5jNwupkhr7ZPrVjzhJHLERDjq006fOrriFgPJ+w9nTfSFWn50BfL1
         HDAGAvel0fCa4zgxr0SCgUOwv5+L5ike2nl+Ga9bmC2hc6elYUD8Ko4u3ALXMA5wUIbv
         R1Y4F+C0HApwnVELxFR6KVjfvvqV962lf3tt/+P9RswA8R+evfhbA5ZeLRPM+ZWfGPye
         qnThqLHy231n6/NUxLJpBJ6//y0jbIYClIIfyMv6f1uy+o+CVqzXf26rTT7RyxjwOg3v
         YpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMjr5IAr8F2z+VYG65tsvkOvXrRUIaCOzHLFDHfPbDQ=;
        b=ZrIYxdNbbyJx7ii51zS9c3rNDaq0HDswSGCt1p+dlWI7g/3hvXLpYzp4I2BkeOjlZp
         IDbUiuwUQUJ04+gDNVlyKuTfiWEWR/14kdmF9/+4pV+olz7HHi4tbliUCqZ2wo1qQxzv
         RXS3JVX1o1UUZXvjdF3tY1R2a8n1luTVq6ent82mNOwyO0kKxL8BNw1YtSmFPAbve5YA
         RM/BCSiaTigmy6USrueExW0m83QynE9janvdZ0YSHFRKlcuoT27xSbTGlYOuvvRFjSm2
         zBZLnf33QraX5EwgGybsrXQKSrSuaZR03DY7t+xncwIbejfwiTbLoQivvVtpi0Q8IgpX
         axUA==
X-Gm-Message-State: APt69E2e229qWqXgP4+rGevkooTwxC3dW1o5ZsvF0lBzMaf+5tOiiT52
        gOxlLpRT18uQeH3vYngrTYKj1w==
X-Google-Smtp-Source: AAOMgpfLJp5gj9+OA8oc6LvCQaZPVXa1/EhF15qibrOwtrA0Gz73n53VO265SyM8cDBJ4fFKC9k2nQ==
X-Received: by 2002:a19:c64c:: with SMTP id w73-v6mr11238599lff.2.1530349726518;
        Sat, 30 Jun 2018 02:08:46 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q5-v6sm1831508ljq.33.2018.06.30.02.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:08:45 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 19/23] replace-object.c: mark more strings for translation
Date:   Sat, 30 Jun 2018 11:08:14 +0200
Message-Id: <20180630090818.28937-20-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630090818.28937-1-pclouds@gmail.com>
References: <20180630090818.28937-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 replace-object.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index 801b5c1678..ddc1546b8c 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -17,7 +17,7 @@ static int register_replace_ref(const char *refname,
 
 	if (get_oid_hex(hash, &repl_obj->original.oid)) {
 		free(repl_obj);
-		warning("bad replace ref name: %s", refname);
+		warning(_("bad replace ref name: %s"), refname);
 		return 0;
 	}
 
@@ -26,7 +26,7 @@ static int register_replace_ref(const char *refname,
 
 	/* Register new object */
 	if (oidmap_put(the_repository->objects->replace_map, repl_obj))
-		die("duplicate replace ref: %s", refname);
+		die(_("duplicate replace ref: %s"), refname);
 
 	return 0;
 }
@@ -69,5 +69,5 @@ const struct object_id *do_lookup_replace_object(struct repository *r,
 			return cur;
 		cur = &repl_obj->replacement;
 	}
-	die("replace depth too high for object %s", oid_to_hex(oid));
+	die(_("replace depth too high for object %s"), oid_to_hex(oid));
 }
-- 
2.18.0.rc2.476.g39500d3211

