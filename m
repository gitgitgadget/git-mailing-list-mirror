Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B4AC43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 17:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240281AbiGNRoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 13:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240322AbiGNRoS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 13:44:18 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA14167D7
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 10:44:16 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10c0e6dd55eso3309278fac.7
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 10:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=207yFmXbBTtf+6Z4cGDIIRgVv06FqToefW8qUUmWXsc=;
        b=zczKdwsS9fR0eDTyt4jJ4iUQqJfyO4RtsgWIGC7z8qqX8LxnODF1T48vX6f22wnQel
         ZH5SzLCPccPjMhk5C4fJh7YwWiZ9sHaTTPI8pahM8SbD3gIYOyxwE0mNAnD87bSo+qnc
         fsUrLpI5qDKxSvjvJtE2h/ys2UEEnstkXZjTaSTj+ny6wml00XJwR2bpKRWu3zRfSFJ2
         63PKDjhXD3gTUneAmeF/gAaaKVcaz3OngqZZhqfrSeGLy4zXhvPjlVLNFoGbvQ4rjhN0
         ljfbUmY0GeA/DGVlrKvq4Ea/zfm+OwUUjf2so+wwmm5MqOBlIEdxAYwlvZDsbypT5DFj
         yTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=207yFmXbBTtf+6Z4cGDIIRgVv06FqToefW8qUUmWXsc=;
        b=AHOxkvmlfeUatCfaDqguYf1WyoOpCt80C9N7xX3mIc7rH6vxhMOjpw91BVvqTbl+TT
         7/0MUyfn7IdfNQTPagM3JAY8Z0vq0bH0rzoQlGefl23K2gYmoN9wifQyeePVOAMIAwUu
         MVe6MTCSZBzWpWKODjdgz/OH9+5PqaqJ5X2vPAocAhy4smh5NY3DBa6nVs1xOYJtti7E
         TYJWssDOST3kP17h2zq4og2+PMbj1JxGTnfb8fYs9GhSbnec5CtJwujeuQfcdj5VV3S2
         K2LIvryewLGEcL1PGvOMyP1H21f6k1qkC9SOBF8zG/aFJ6O2RdYz9ATY7CRQkgBeE7hK
         GSqg==
X-Gm-Message-State: AJIora9LZKEHHZEjNSwPyFyVsdT55oCHagKWmHzdmm48itXULxqkcBaV
        CReBxLQGi1ICVQOBZO6GoOtp8QaQQcKXEA==
X-Google-Smtp-Source: AGRyM1s0Q9vkVDsQn+4RxovdMOF01hk1Cb6OfwG+3RTBbKuSbJfkXMxS9Bor+uo7dP3LKD6YtONLbQ==
X-Received: by 2002:a05:6871:84:b0:ec:4559:86e1 with SMTP id u4-20020a056871008400b000ec455986e1mr5283253oaa.225.1657820654562;
        Thu, 14 Jul 2022 10:44:14 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id bx17-20020a056830601100b0061c5ea08b2bsm906304otb.77.2022.07.14.10.44.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 10:44:13 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] doc: unify config info on some cmds
Date:   Thu, 14 Jul 2022 14:44:01 -0300
Message-Id: <cover.1657819649.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These three patches attempt to remove duplication between some
config/*.txt and git-*.txt files, to facilitate maintenance and fix any
divergences.

This series targets the most straightforward conversions, but there are
also other commands whose config documentation could possibly be unified
(maybe #leftoverbits):

- git-log.txt and config/log.txt have some duplications, but with
  different wordings, which could probably be standardized.

- git-send-email.txt has some config definitions "inlined" with the
  descriptions about the CLI options (e.g. sendemail.xmailer). Not sure
  if it is worth unifying the configs in this case.

- Some cmds like format-patch, status, and branch have some config variables
  defined at config/*, but not at git-*.txt. Maybe the latter could
  mention something like "See the full list of available <cmd>.*
  configuration variables at git-config(1)."

Matheus Tavares (3):
  doc: grep: unify configuration variables definitions
  doc: apply: unify configuration variables definitions
  doc: notes: unify configuration variables definitions

 Documentation/config/apply.txt |  7 +++-
 Documentation/config/grep.txt  | 10 ++++--
 Documentation/config/notes.txt | 62 ++++++++++++++++------------------
 Documentation/git-apply.txt    |  9 ++---
 Documentation/git-grep.txt     | 37 ++++----------------
 Documentation/git-notes.txt    | 54 ++---------------------------
 6 files changed, 53 insertions(+), 126 deletions(-)

-- 
2.37.0

