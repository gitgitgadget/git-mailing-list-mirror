Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 624131F667
	for <e@80x24.org>; Tue, 22 Aug 2017 21:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbdHVVfF (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 17:35:05 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33839 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbdHVVfE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 17:35:04 -0400
Received: by mail-pg0-f47.google.com with SMTP id s14so15239092pgs.1
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 14:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zV/JYU20zsNYhWZOl0b+P9CYI7XdBTmtwRtPvKKmkPE=;
        b=gaQWL7oVyYnjwsn4yMuE7uf+wdhbRmbZ/vmR5akoqn1xGOXboWVnQ0gMDKHrtBuex6
         +Lwnc16U0CmOZv8+4/g4jQRXqnylUkhcyf/vwhI7zPes+ubA15IDBvWq600I0nwCyrbv
         fOlJO4GHhAm0HwzLJpn1aXC9hzWJ5Pk6nyQWgAT4GgyBtGHfYhP2c6eXcA03rcBEMziX
         nNvUQQ+DUvCz8kNtB1InhTPdJ4inGTUkYo52+VkEXbWQhvTBJaVboZjhP5AUR7+wpk24
         WHIT3mIJ+qwofTMIzVTVGk0UARYNuN1sBNH4YReGm/OsOzHklg59Fuc0Qp/by/qg/l9d
         o3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zV/JYU20zsNYhWZOl0b+P9CYI7XdBTmtwRtPvKKmkPE=;
        b=D2rUO4VtejGUkqPQozfAlRhzfsgJqHk1z0mwNyebv+7DObWXnq66DY8xqAsarddRX9
         9UeGveolwYtpFMygY9sjsZBbxtyVaQ3O2IKeRTbSD6g7IcMrqGXoGcHJUrdIdS0f8/qx
         ZVJNx6kZM0qtkK096vrD+Q2V7HPtE77YRHPuwgGdtlCA/jafWov8+ODGdZHCLivv7flZ
         dgqq1jLSv8mFAPN1vDaaHFtffJ+bjp5IJgG0WkO3lHf9B/iX6Su0gogTkZgQxWbRXIGh
         cx51ZOBIhEeTow5UiREucgqBWvFzJiRgRzeokZ3Dkh5c5Ue1GvkbvBOP6LK+fJ2o8BZD
         IcFw==
X-Gm-Message-State: AHYfb5gaopftmVuth+aZvEMxpe7pnWIt+Z95yIReMC9g8RS3d+CChI7t
        Wg/o3Dp4dd46fTGZBgNhFw==
X-Received: by 10.98.14.91 with SMTP id w88mr532586pfi.306.1503437704271;
        Tue, 22 Aug 2017 14:35:04 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c9dd:5ecb:d616:a602])
        by smtp.gmail.com with ESMTPSA id q7sm28278220pgr.54.2017.08.22.14.35.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 14:35:03 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] vcs-svn/repo_tree.h: remove repo_init declaration
Date:   Tue, 22 Aug 2017 14:35:01 -0700
Message-Id: <20170822213501.5928-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The svn specific declaration of repo_init was not used since 723b7a2789
(vcs-svn: eliminate repo_tree structure, 2010-12-10).

This was noticed when including repository.h via cache.h as that has the
same function with a different signature.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 vcs-svn/repo_tree.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
index 889c6a3c95..8592beb59b 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -17,7 +17,6 @@ void repo_commit(uint32_t revision, const char *author,
 		const struct strbuf *log, const char *uuid, const char *url,
 		long unsigned timestamp);
 void repo_diff(uint32_t r1, uint32_t r2);
-void repo_init(void);
 void repo_reset(void);
 
 #endif
-- 
2.14.0.rc0.3.g6c2e499285

