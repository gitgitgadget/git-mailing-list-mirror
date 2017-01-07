Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA70420756
	for <e@80x24.org>; Sat,  7 Jan 2017 21:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932681AbdAGVlt (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 16:41:49 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:32977 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753768AbdAGVlr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 16:41:47 -0500
Received: by mail-oi0-f65.google.com with SMTP id j15so6631951oih.0
        for <git@vger.kernel.org>; Sat, 07 Jan 2017 13:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OEYJbBOuicA5G3uzV3Gi2gH3ZjotIMnbjMYb8aszieM=;
        b=HOedvTjGUFu8YM0tXhp4skTDlVisOURIEab8RFnWKmR4JIorQkXKddqVFjopo6Vv2C
         Hct6NRCabiT5X1O7PtJuAR/OrSPyfHLKQBGK7txDQBM67WerPM79pwb4Iub3uyuMRZ9V
         7BpXuddoxKywWHhgzlZdwbDLF+zstTrNdhHlbuEFLkyau6ILsTTjEihxxzYsdcLEuNkS
         8GTSpfs/EkM2+bi2zzsh7KpCa9BgUwjnM2TNjSJK/FEBCxBPuE/FmzP2JNuMfzvujeca
         6D8doGvJ3tBisafGDK2V4kN795ZK9DvAffz9DjZ5fgPCCKjw75g0uBVoDDMz5m9GQ5QF
         /5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OEYJbBOuicA5G3uzV3Gi2gH3ZjotIMnbjMYb8aszieM=;
        b=tdY85vgv1TauvbrY7q+yIm7vaA6fjZ4rb2AFg/JHZjXvPCDJZy1AKttF7Je7gXunck
         NPVcxMDHSmCLTix+c01wlGIZiTrkwd2icTmLsxFyvIDMWOaxeFJqigSEKPl6pSsf793S
         tr53DIq1jUpRIR0WE4xVJB30Ofl3NlWYstEpB3fnuazr6rP6bY+4sbDWaryRguo59Sct
         uvZLmbRgrCGlG3aPw4Laoxx14a4yS0DeWEaxD45vo22/mzMVZluK0Xw+qR5kY6SSu47I
         C9x7CsKp9TrJcs36QzsS/fiKFC7gAhLhEuTUmzreeF+y2WqKFn5QjCEBEAechLp26Zy4
         FGPA==
X-Gm-Message-State: AIkVDXK5lIlZUZt7A6RgtjHucad4EI7hYv+jbIKtYTYwV7JJUS5XopHsYenC45s80bxOzg==
X-Received: by 10.202.48.132 with SMTP id w126mr4214897oiw.133.1483825307161;
        Sat, 07 Jan 2017 13:41:47 -0800 (PST)
Received: from localhost.localdomain ([2605:6000:9fc0:56:811:343f:f904:d318])
        by smtp.gmail.com with ESMTPSA id b129sm39384562oia.4.2017.01.07.13.41.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jan 2017 13:41:46 -0800 (PST)
From:   Steven Penny <svnpenn@gmail.com>
To:     git@vger.kernel.org
Cc:     Steven Penny <svnpenn@gmail.com>
Subject: [PATCH] Makefile: POSIX windres
Date:   Sat,  7 Jan 2017 15:41:10 -0600
Message-Id: <20170107214110.3124-1-svnpenn@gmail.com>
X-Mailer: git-send-email 2.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When environment variable POSIXLY_CORRECT is set, the "input -o output" syntax
is not supported.

http://cygwin.com/ml/cygwin/2017-01/msg00036.html

Signed-off-by: Steven Penny <svnpenn@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d861bd9..a2a1212 100644
--- a/Makefile
+++ b/Makefile
@@ -1816,7 +1816,7 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
 git.res: git.rc GIT-VERSION-FILE
 	$(QUIET_RC)$(RC) \
 	  $(join -DMAJOR= -DMINOR=, $(wordlist 1,2,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
-	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" $< -o $@
+	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" -i $< -o $@
 
 # This makes sure we depend on the NO_PERL setting itself.
 $(SCRIPT_PERL_GEN): GIT-BUILD-OPTIONS
-- 
2.8.3

