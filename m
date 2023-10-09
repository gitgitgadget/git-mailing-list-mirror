Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CF0E95A8E
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 01:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344723AbjJIBTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 21:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJIBTF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 21:19:05 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88A38F
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 18:19:04 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a22eaafd72so49976867b3.3
        for <git@vger.kernel.org>; Sun, 08 Oct 2023 18:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696814344; x=1697419144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L60VXxPByPbS6BjNHjmWN2p0nZyMw4iIxqxP57K1IRI=;
        b=KfVj8Z6QTZrbHtYQ8RQ3Cp6uzi4uOOhVeDDkH29PuTfaSRdxkRIjTxn6EWduhZuGye
         vrJW/bmf/KE9hcPiYt2kzeVBhpfsGrcbzVcizARC6w74AfXcKR1NvDyCA/D9lzGaNNFf
         +5LcBg+JNgUcQsUSfqZbUU0SGW4ABD3gYecWVNFy3Uw8xFYQCvRduHHrB+B3t6TDo0Px
         akKQfUXOJxd0ns8PXS/rvZXbtZqe+cp1n4zdIKxVL9q6o4QF/reVBdemCyvHbjgBz5tL
         04pXCkOJbW1iM+EM/nW0XKqR+oXl1wXpbmwBihGFJRowufIGjeLzLLolRVktheH/B1e+
         K+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696814344; x=1697419144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L60VXxPByPbS6BjNHjmWN2p0nZyMw4iIxqxP57K1IRI=;
        b=M2wZ4NLqwT/aPNw+0w5dDQ1QIlqtrKPJrVhgDVfTQlhrQgZHnCtArFi1norGGiZ+6n
         +HZ1L+sAUhYH3O+xtmx6qfm05y71gpRWlazFkYghCGCpMGPzPkW8DFPD6wDmLIOiOjyO
         c1UQ+UfSuW7TKCZoCVjR0NABf485kg0OWTk+PBOUQq5AkHd1mXfgNdoSQv+Oo35N6u/j
         bnCHvKkoRLkIc+WL0XbduqFC1NA1x/q1QYgFK+ffK/8FcQeCgP75g98E/x/ze1PZBOxH
         HTyfD68UhlXBIPeX72gjDZITFza9GF62+z9TTqvzcME+gxCj6UegL0Z5AKwk8n8DvPPd
         4M2Q==
X-Gm-Message-State: AOJu0YwXU7ABdzGcWNlB1gBrsDvdTMfxd27BiWxplIWop+3sy/H1UnBk
        6IxANTBjqmp4PX3KSYXGIbgPlMAlb39VkhU=
X-Google-Smtp-Source: AGHT+IFILdyks8POehn2RZGcr7cI/iYNi9m6B4mpU7fNE81/TosWVpo38Or2YLR2iEgjivlu+Gy6uA==
X-Received: by 2002:a0d:ccd5:0:b0:5a1:d6e4:917e with SMTP id o204-20020a0dccd5000000b005a1d6e4917emr14402183ywd.25.1696814343961;
        Sun, 08 Oct 2023 18:19:03 -0700 (PDT)
Received: from localhost.localdomain ([102.89.34.102])
        by smtp.gmail.com with ESMTPSA id u196-20020a0debcd000000b0059bdba29ffdsm3268802ywe.13.2023.10.08.18.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 18:19:03 -0700 (PDT)
From:   Naomi Ibe <naomi.ibeh69@gmail.com>
To:     git@vger.kernel.org
Cc:     Naomi Ibe <naomi.ibeh69@gmail.com>
Subject: [PATCH 0/1] *** EDITED add.c ***
Date:   Mon,  9 Oct 2023 02:18:42 +0100
Message-Id: <20231009011842.1956-1-naomi.ibeh69@gmail.com>
X-Mailer: git-send-email 2.36.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

*** BLURB HERE ***

Naomi (1):
  [OUTREACHY] Fixed add.c file to conform to guidelines when using die()
    listed in issue #635

 builtin/add.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.36.1.windows.1

