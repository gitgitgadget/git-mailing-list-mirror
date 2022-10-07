Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31207C433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 14:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiJGOiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 10:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiJGOiM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 10:38:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB57FBCF2
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 07:38:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b7so7589949wrq.9
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEXXiNQRXzyufaE/CBl8ayERAzueYPkY9LqKzWZB1H8=;
        b=OWZD6IaNbldzdAjuDpppGUz59DL+8mgU1emDy8fKH611sykg59OcIr2+CbJADfynuN
         gsVFC+i39JSKovuUe9blBR6ujaZDCoRIFwX8pmqhZ1egCpMTO/stHRn1rFtY5vxroxL5
         mdQ/qaiVfdZB6VCpaexokqo3ov6Il0SMNb480mCbDwv5D+I4+qLUjmD99AyAMUgJ5L0s
         NuKzH1dqp0HohshiKEA1g5zKjP9ldIf8qaXn7G9U+zyP2ze6ziGlIGgKLxP/qAihKXZC
         +2p77qTvTF5eJ3PJvmGMcrOfZGvvl+e2iQawZLQ4C+XQhGNOva+2wmLR9nfilDkwSLMK
         iEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEXXiNQRXzyufaE/CBl8ayERAzueYPkY9LqKzWZB1H8=;
        b=sKPrDc6W8BBu78NVZkSdEmwF5JzULQV1kA5bLYz4pMZAEolbCiIuywcSS5PZSQw1U6
         d4WLd0IC6GwZQcqSekRlYDjIw6CLY70uXT9HO4PJ6zFOMMCGB7sudx6BlXVXKcMXmWeo
         Ovn8rOs7t4VooSG6TAJzhFitO8hiiV4w2QyI1Vm9plS5vNWNgeFh8b2zzDfFpZKxaj5E
         1Uo8Hs+X4pItUkqYwPlBTF51fxgHiaaJ761FWZtyCCwPanBPTXFZKjjMmX/RyHPsii4z
         qSDABnZWyfS9XxPjo0ZTWaVkybUVaRMLC7Xtw7g8tKD7aUhHJodAruw3GUzm3HxFHGZ/
         kHrA==
X-Gm-Message-State: ACrzQf0dOWnZBSx2Eh5hhMREGlAcUsI4Jdt03Ta4/q4YSmRfxFiQqaC9
        IGChlpAr+a3EAP/ZCZlF5DitROrnTfo=
X-Google-Smtp-Source: AMsMyM5xEXi9xTSB3ffXxvDtPeje5wf1PSH7yKge1cvhl6+qHigpTBS9KPiYtO0gbfecuqXpo9VGJw==
X-Received: by 2002:a5d:4106:0:b0:22d:494:ca05 with SMTP id l6-20020a5d4106000000b0022d0494ca05mr3456194wrp.714.1665153489480;
        Fri, 07 Oct 2022 07:38:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iv14-20020a05600c548e00b003b4c40378casm8860003wmb.39.2022.10.07.07.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 07:38:08 -0700 (PDT)
Message-Id: <dd81a2cadec3e3f131d7b573bf110d4b6cc8f40d.1665153486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1355.v2.git.git.1665153486.gitgitgadget@gmail.com>
References: <pull.1355.git.git.1665056747.gitgitgadget@gmail.com>
        <pull.1355.v2.git.git.1665153486.gitgitgadget@gmail.com>
From:   "Daniel Sonbolian via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 07 Oct 2022 14:38:05 +0000
Subject: [PATCH v2 1/2] git-p4: minor optimization in read_pip_lines
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Daniel Sonbolian <dsal3389@gmail.com>,
        Daniel Sonbolian <dsal3389@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Sonbolian <dsal3389@gmail.com>

checking for an error condition before reading and/or decoding
lines from the pip stream to avoid unnecessary computation

Signed-off-by: Daniel Sonbolian <dsal3389@gmail.com>
---
 git-p4.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index d26a980e5ac..097272a5543 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -399,11 +399,15 @@ def read_pipe_lines(c, raw=False, *k, **kw):
 
     p = subprocess.Popen(c, stdout=subprocess.PIPE, *k, **kw)
     pipe = p.stdout
+
+    if p.wait():
+        die('Command failed: {}'.format(' '.join(c)))
+
     lines = pipe.readlines()
+    pipe.close()
+
     if not raw:
-        lines = [decode_text_stream(line) for line in lines]
-    if pipe.close() or p.wait():
-        die('Command failed: {}'.format(' '.join(c)))
+        return [decode_text_stream(line) for line in lines]
     return lines
 
 
-- 
gitgitgadget

