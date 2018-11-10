Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8340F1F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbeKJPdZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:33:25 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34214 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbeKJPdY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:24 -0500
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so3387834ljd.1
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gyAcZv8dZeP/dYnqcYiqwhaJ2pPVanQu9V4U7viRChg=;
        b=WZ6HhXWT0E/00CeexeBPMIzLSaQoZx6Utf2XHu3hsSSlRC+mweSnJQMJB6RuhWHzK0
         dlYG9v1G0IylKCvRV/E4LmdBTk8/EVEtyxhAvQfbaagryIzUdukaSnSNC3CdgkJpEatd
         fTJsddyqE241ETpESJpH99GSK/zsZjhRlVhFy08Q4o6hWzeE3ogeA2rTFUZC+bLW1qyc
         8vrxGhvlFBX83MP+Qp6UEvLx3ng1C9EgU73HFbaHJuE8mdWvIiYoWwPJM+aTHuz24I6y
         BEz7nX7xyA2s1+Nzu3GKBKCwdBK4HPFfBqWDwZ1bQWl00XUpw/xhYOXX7Ikv/IQrVUzP
         Sb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gyAcZv8dZeP/dYnqcYiqwhaJ2pPVanQu9V4U7viRChg=;
        b=pF0shSQ3R+RvWc63hhgR3anU9i7KOL8jGNhwS3/9+MQB2FIsqdc/yU/TCOJ3kzLivU
         Iv4Iz1+mwYk6Vo2u4GtqrnNz6Cb0NYDrVWpR3pzxncqjRwxB/mQCuvrTpcYyQgq95HnK
         KkGGe942uGCM7JIm4tyfFIHanbvQnsr3UloXxp7qYJgwf3bcQ64tPIqNjS2SzlybWOKo
         l5DxEBlo9TZctIlSixPp7Cu2c7ui8iJd7/4RcD/PRbp5jcPYZTzhv8ktyNThkcrRCSKn
         5M76CIEzSy+Rb9fRvHswFKw9N5Tj3rTlaLFSYWMnNiC9WbauYzWdsRwzb3MzD6+MJJTe
         qQ3A==
X-Gm-Message-State: AGRZ1gLq7eHQ1Gcas+ny58HkbG7+dd0GTaQVcjmqPgyXOzAZuhgznv7z
        1V4Bcfan6FNWjgxr82q/7XmQTXH/
X-Google-Smtp-Source: AJdET5dliZ2BvxJDNjY3Gu7l5f/56bKcGjr7tpoXtNug4aD3fyylwuYQ7Txgn7Fa6iHaI+JkKcKjhw==
X-Received: by 2002:a2e:8596:: with SMTP id b22-v6mr968852lji.122.1541828977407;
        Fri, 09 Nov 2018 21:49:37 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h3sm144445lfj.25.2018.11.09.21.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:49:36 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 17/22] line-log.c: remove the_repository reference
Date:   Sat, 10 Nov 2018 06:49:05 +0100
Message-Id: <20181110054910.10568-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110054910.10568-1-pclouds@gmail.com>
References: <20181110054910.10568-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 line-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/line-log.c b/line-log.c
index d1d429d738..24e21731c4 100644
--- a/line-log.c
+++ b/line-log.c
@@ -479,7 +479,7 @@ static struct commit *check_single_commit(struct rev_info *revs)
 		struct object *obj = revs->pending.objects[i].item;
 		if (obj->flags & UNINTERESTING)
 			continue;
-		obj = deref_tag(the_repository, obj, NULL, 0);
+		obj = deref_tag(revs->repo, obj, NULL, 0);
 		if (obj->type != OBJ_COMMIT)
 			die("Non commit %s?", revs->pending.objects[i].name);
 		if (commit)
-- 
2.19.1.1231.g84aef82467

