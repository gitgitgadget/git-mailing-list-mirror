Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3903C433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 11:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiJFLp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 07:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJFLpw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 07:45:52 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FA189816
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 04:45:51 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so760097wmq.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 04:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=53q8QlWhxhIN0tCgVj6Wzvvgw9jkk3e6vYNSmCNGx00=;
        b=hvyp4THZmOsZHlyFuywG26LmVmEqw+zHSS2yxRjk3BTR6dCKXFEiTi36wVN62smWRD
         OuCOk/99EaeummHcPRt0tIv3WGzBR1WeykeOGDHdj5eKj6IJhJtgfKQbGRdL7mhJZw1J
         BO8zXZ4HsTqV5sKtTgYNSQDD3nqwNHPNmbJP12pVccsTT5MR4toyCAhSa7Ri0IbkDqzy
         XPDnlzi2bkjnGiiCph2+NReUY4RtS2xa6X68jg5UKQWbPd8c2VHlndnNetfM3BBdYmlx
         M2mEVFVtss1HFXjg+CioTlCnYp9MFQD6mYAzQFzuQbBgw810+Es8SAqPR4MF+M1j7pQS
         A1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=53q8QlWhxhIN0tCgVj6Wzvvgw9jkk3e6vYNSmCNGx00=;
        b=15alA2ADWIXUAlkxxahIWSz4izEzbHRl8BdPi3d4ug9vBtx0jfH9cLZ/HzSYuC0hct
         V5V+0mAaxXJbd0TUz4Ou6m8Ob8svejO6bsU/XacmbNmrFkKl1/oiciMqOchdVbiKVUmi
         s2O3KiXm+lDY3imTNMZfXdciHzyXd4UV8GwO345Z/Mn+h/aO3ch+yKbDSSt52xTEDGQt
         Lz9QFtd6fuaeyYtxMfzgyYPk/m4EbMq9T5u283TnBuK2pQiTGRb0ubM1RHvWcBzdU0TG
         j/bzYII2LsPftmFU2hmudZWEVXVRZoezltMQ/h4+gfP8kvYI47fHtn+eplBQi5J4nVCe
         QudA==
X-Gm-Message-State: ACrzQf0zw110+b3wnso7E5ZpYfUTQ0o/H+W/ap3lBmlSuelT7/f4GXPa
        YQtNkuQDHjiozDAYWO2m7aeCPUuFjxc=
X-Google-Smtp-Source: AMsMyM6hRvsNaLxb5KlQyjZmBuuNH0l47IwlyHk4zmQdKwr6k4Hw418XRTymQUu4k1JHXlDhNgLWFA==
X-Received: by 2002:a05:600c:4e52:b0:3b4:91ec:b15d with SMTP id e18-20020a05600c4e5200b003b491ecb15dmr2888186wmq.119.1665056749447;
        Thu, 06 Oct 2022 04:45:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6-20020adfec86000000b0022b1d74dc56sm17640276wrn.79.2022.10.06.04.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 04:45:49 -0700 (PDT)
Message-Id: <71da6f53a44cd3390d122ff2c0446824313e5101.1665056747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1355.git.git.1665056747.gitgitgadget@gmail.com>
References: <pull.1355.git.git.1665056747.gitgitgadget@gmail.com>
From:   "dsal3389 via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Oct 2022 11:45:46 +0000
Subject: [PATCH 1/2] python file more pytonic, adjust "if" and "for"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     dsal3389 <dsal3389@gmail.com>, dsal3389 <dsal3389@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: dsal3389 <dsal3389@gmail.com>

L371
redesign few lines to get rid of the "else" statement

L404
moved the if statement below another if statement that
checks if it should exit the code, only if it doesnt need to,
then we can iterate the for loop and decode the text

Changes to be committed:
	modified:   git-p4.py

Signed-off-by: Daniel Sonbolian <dsal3389@gmail.com>
---
 git-p4.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index d26a980e5ac..0ba5115fa2e 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -368,10 +368,9 @@ def read_pipe(c, ignore_error=False, raw=False, *k, **kw):
        """
     retcode, out, err = read_pipe_full(c, *k, **kw)
     if retcode != 0:
-        if ignore_error:
-            out = ""
-        else:
+        if not ignore_error:
             die('Command failed: {}\nError: {}'.format(' '.join(c), err))
+        out = ""
     if not raw:
         out = decode_text_stream(out)
     return out
@@ -400,10 +399,10 @@ def read_pipe_lines(c, raw=False, *k, **kw):
     p = subprocess.Popen(c, stdout=subprocess.PIPE, *k, **kw)
     pipe = p.stdout
     lines = pipe.readlines()
-    if not raw:
-        lines = [decode_text_stream(line) for line in lines]
     if pipe.close() or p.wait():
         die('Command failed: {}'.format(' '.join(c)))
+    if not raw:
+        lines = [decode_text_stream(line) for line in lines]
     return lines
 
 
-- 
gitgitgadget

