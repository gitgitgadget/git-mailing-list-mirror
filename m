Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1E091F667
	for <e@80x24.org>; Wed, 16 Aug 2017 22:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbdHPWus (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 18:50:48 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:37368 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752382AbdHPWur (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 18:50:47 -0400
Received: by mail-pg0-f54.google.com with SMTP id y129so30059812pgy.4
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 15:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gOGA6x5+NsBFeIA8sjeIOfp0yl/9AK4NuiN5Pp87LQI=;
        b=Ep5WAdJ8IimMOoBZhaniY687T3XZa89ogL6rtySs2LmpAanYHKxuia3Ab1pT0AdYjh
         QbCQKJvRwnnZW0uS13YLROB/0kwuHj++3PFMMwG+cLPWcw/LcPpej5zBeo2xgE8duHZj
         5Jm+fnjrE2DHbR7D7A0FMUzw5CrcnCl22+44M6ZGK17eC2XREpCLq1IczxYZkC3Jdb0b
         Z1eP4E+v7cUWYBaZNoKYxyEefgstXOMZVJNiELnfgzhMlFm6cGgqT0r1lNried6A+bp5
         Tv+VXdGHYT2Avr7pDvVrcNM6+XEy8CApQgxGe4fMS3wEY3VjzqNySceB6Q6iE33RU7Ob
         wd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gOGA6x5+NsBFeIA8sjeIOfp0yl/9AK4NuiN5Pp87LQI=;
        b=Xib6z8mQzQKQJ5JRg28EO9+mymT3+yw4SYllDoxEeF+jFvaWlpc+hNm5h6pGhVrIfN
         mh9C9GTh2PJwyfw4HGGdSGaGfzPzNHK8K0ojh0EnvRwQ02j7/nc2VjzkpLKEo5xZ2TNO
         ZhzBGIzyJFnGKbIEeKIHV0nPyCQKiCA1NR5Wu+p7RAaSfN/rD9d7IsmiULsSvUxz9G7q
         ESfb/Ukxm5GcxwTjMJYeqJ3MhhkqbCBmDFG36rbVkGV1nQJEPH3BLKCPmhuB22ljw348
         bMJJb+72O0CFbUq/f1dmkF4yNtqiF27N6dqtGr1IcpQtK0PJd2UmYs4hp9mkUr/zMSbF
         l1AA==
X-Gm-Message-State: AHYfb5g3peQ6fb0f3ktp3qA9BGorBTH8rj60dejhK8aZSdqFKuJxGdJ8
        O4EuFvE5V42xGX4N
X-Received: by 10.98.100.20 with SMTP id y20mr3140443pfb.11.1502923846579;
        Wed, 16 Aug 2017 15:50:46 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:116d:67f0:85cb:53be])
        by smtp.gmail.com with ESMTPSA id x124sm3510437pfx.65.2017.08.16.15.50.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 16 Aug 2017 15:50:45 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule.sh: remove unused variable
Date:   Wed, 16 Aug 2017 15:50:42 -0700
Message-Id: <20170816225042.32765-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This could have been part of 48308681b0 (git submodule update: have a
dedicated helper for cloning, 2016-02-29).

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index e131760eec..9dcec7b356 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -611,7 +611,6 @@ cmd_update()
 		die_if_unmatched "$mode" "$sha1"
 
 		name=$(git submodule--helper name "$sm_path") || exit
-		url=$(git config submodule."$name".url)
 		if ! test -z "$update"
 		then
 			update_module=$update
-- 
2.14.0.rc0.3.g6c2e499285

