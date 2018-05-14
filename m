Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BA261F42D
	for <e@80x24.org>; Mon, 14 May 2018 10:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbeENK2b (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 06:28:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38500 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbeENK23 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 06:28:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id m129-v6so14096118wmb.3
        for <git@vger.kernel.org>; Mon, 14 May 2018 03:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1OEY2GY0qXp4SMAzA8ZAK/rgPD90DHohPeVwijPwHhc=;
        b=UFvdDUCbBdxrGe18J5Wt7veC8bIN0b63skoJBdTUBQ6Lg1jg7KYk7OCanw8HvQu1af
         EV7FVzM9aDy7/C1qfL0K5BdcWj+d4vpqO1mQ/Y+7Bxz+PAM/KA3NjH5Rj8OXy1aBsPK0
         wUBpQ4+21tOuKIfV0QyPHQi1kLIu1bajNPnn8UMJ2xcCoeMEdT/mLebjYw5KN5wbcUUj
         ah8WhHEpSkQyuodxOfFUMAG/K157IvrlDHVCN49twz5NOg5lg8O85PSUC2rsWUQaCz0h
         Um3yANgbGFpQFP5UEWE38JumBaIBxYrvcTCMwJliW9jZEolJOTbLAUBQryj6Ff+gnU8L
         WfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1OEY2GY0qXp4SMAzA8ZAK/rgPD90DHohPeVwijPwHhc=;
        b=KLIat9UgdBisi9NKjdgbyW6VOb7no542uCl6lckjQmBsmHNhjuH5Toj1wBVWHwiDBa
         6xP2AaCFie7bUTey4sc02/J6uRBZgFDPtxfFs/xq5XtKXLPqCtiVowyGLRDUdqUCydwc
         KE9GaioBWtHMZSqX9SdE2ixmb0hDFgRC40EIy/kQlleipIOs31egJZHDzIsMT3vjB+O1
         D8eTCtsBm0pOigTT8ePil+5EO05ExkdZBIq6+KbntuPq3CNiFvhOmr5SY8JQW33l6SGf
         u73Rigu3sQT4Nfhd5n5tocgk4rCS4OxlliMrlf5OiOQD+4VIecOmxATv1IHkTMjXqwW1
         xm/w==
X-Gm-Message-State: ALKqPwcB90ZxwFk89efFNxqglJ0s1NI4Y/3qt+BcVsYyF/3qsXLSYc48
        Ab6oT84XPaOneD69NrPhGom0dA==
X-Google-Smtp-Source: AB8JxZreN0D226SRvzL3wKj85KHcu/3pnGQTD806lpJeis5D6RYkACEfKSHn8J+4YNsReG370B/7Rw==
X-Received: by 2002:a1c:57c6:: with SMTP id l189-v6mr4865523wmb.161.1526293708636;
        Mon, 14 May 2018 03:28:28 -0700 (PDT)
Received: from localhost.localdomain (x590c390c.dyn.telefonica.de. [89.12.57.12])
        by smtp.gmail.com with ESMTPSA id s14-v6sm8740470wmb.5.2018.05.14.03.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 May 2018 03:28:27 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t7005-editor: get rid of the SPACES_IN_FILENAMES prereq
Date:   Mon, 14 May 2018 12:28:12 +0200
Message-Id: <20180514102812.7924-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.756.gcf614c5aff
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The last two tests 'editor with a space' and 'core.editor with a
space' in 't7005-editor.sh' need the SPACES_IN_FILENAMES prereq to
ensure that they are only run on filesystems that allow, well, spaces
in filesnames.  However, we have been putting a space in the name of
the trash directory for just over a decade now, so we wouldn't be able
to run any of our tests on such a filesystem in the first place.

This prereq is therefore unnecessary, remove it.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t7005-editor.sh | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 29e5043b94..b2ca77b338 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -111,14 +111,8 @@ do
 	'
 done
 
-if echo 'echo space > "$1"' > "e space.sh"
-then
-	# FS supports spaces in filenames
-	test_set_prereq SPACES_IN_FILENAMES
-fi
-
-test_expect_success SPACES_IN_FILENAMES 'editor with a space' '
-
+test_expect_success 'editor with a space' '
+	echo "echo space >\$1" >"e space.sh" &&
 	chmod a+x "e space.sh" &&
 	GIT_EDITOR="./e\ space.sh" git commit --amend &&
 	test space = "$(git show -s --pretty=format:%s)"
@@ -126,7 +120,7 @@ test_expect_success SPACES_IN_FILENAMES 'editor with a space' '
 '
 
 unset GIT_EDITOR
-test_expect_success SPACES_IN_FILENAMES 'core.editor with a space' '
+test_expect_success 'core.editor with a space' '
 
 	git config core.editor \"./e\ space.sh\" &&
 	git commit --amend &&
-- 
2.17.0.756.gcf614c5aff

