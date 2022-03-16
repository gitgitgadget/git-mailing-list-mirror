Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F65CC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 14:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbiCPOCd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 10:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241651AbiCPOCb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 10:02:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94AE66CB5
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 07:01:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id qa43so4327290ejc.12
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 07:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rWyx1o0YqfQORG8bq/JJWyZjjkSbEyIpUOm21BVP1Mw=;
        b=ZVf9hDS/CfYrhs2iDSCSKiXzm0mLlhsE6pKe3y04Ksteejs9j8Aqu8abk2IxSO+yjx
         7Le34QIopoKZ6p0e3uXBVam1kRHVqvpL+091h2SFliIOf17Y9gwH9is4iH2oRhrbWfy/
         M1x71jGw+LO80irAus/83IhAU+4OBCw0znGS4mM/SLVqLLbFeuYju9/hZBr1MXQfDNwG
         hk447265ABJc8uWpbZKylL3mSHoZY9n68S4Vy7zN4vPLjL81pPZkA3ng1N6P5Jvqac7O
         papSUZ/RMmm7UblYl88rLryZsxkZoZ51Zyh/WaRUedxlCxbKvtgmI0uaz4NNVjxgnUH+
         GGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rWyx1o0YqfQORG8bq/JJWyZjjkSbEyIpUOm21BVP1Mw=;
        b=K8Fh2dCtZEIF6DaudDOflmL8nAUocn5tjF0kh6ZUDAKeys2DlEPmknzbycOVBhDPnB
         lC2YrI2wXPGx9+oOaTiOO1jwfZ481eCO/DG7xJm7tHNYgG1+Lo758TvVZ4XwI0Af+JfG
         jD1DLnVtpbfH/91cg3Y2nUqunM/eEnQGrewwKplZyJg1UpBahdeAzcODdanxD1cbCYVW
         1mbmg2ECTF/Oy0Crdv4adf8wOqIqMEfcOW5vOpuOxqiTcy76zE4iSPWHLx3gi2my4XL2
         3wgGSng1CZ+DwcctobOy8R5G5PhMol3SS4GH3lflMZscNT4O/5oVVUgvqfAnYd9wunkE
         4W5g==
X-Gm-Message-State: AOAM5328AtIefBQHSd+yW+h1vVdD4WIKlMKNfMl19YoN2yXNJKgbulvx
        nGdRdjmPzIUHWTMr1DeEaBfSDSeJbwg=
X-Google-Smtp-Source: ABdhPJwHe7wp621P5u9qZlwOGBiHHIuZbVtOGw+pgwR9PZOgDBS9r/Cc5lTKQYLqETLA59qgnP9eIg==
X-Received: by 2002:a17:907:9956:b0:6b9:a6d9:a535 with SMTP id kl22-20020a170907995600b006b9a6d9a535mr148179ejc.64.1647439275347;
        Wed, 16 Mar 2022 07:01:15 -0700 (PDT)
Received: from fedora35.example.com ([151.27.250.86])
        by smtp.gmail.com with ESMTPSA id yy18-20020a170906dc1200b006d6e5c75029sm910011ejb.187.2022.03.16.07.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 07:01:14 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com,
        Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 0/2]  addition of all symbols defined by curl
Date:   Wed, 16 Mar 2022 14:01:04 +0000
Message-Id: <20220316140106.14678-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


This patch series is a reroll of the patch described here
https://lore.kernel.org/git/220315.86pmmndmre.gmgdl@evledraar.gmail.com/T/#m7bf710a79c39fb62d874054621ada0bab968d6a3
with the initial addition of the Junio C Hamano patch
https://lore.kernel.org/git/220315.86pmmndmre.gmgdl@evledraar.gmail.com/T/#mc9c88dedf2b93189c3e41186f33844e96e6dcc73
slightly modified by me to be independent of the second patch,
since it should be useful in any case.

The patch series is based on the git master branch

Elia Pinto (2):
  curl: streamline conditional compilation
  git-curl-compat.h: addition of all symbols defined by curl

 git-curl-compat.h | 2944 +++++++++++++++++++++++++++++++++++++++++++--
 http.c            |    6 +-
 2 files changed, 2879 insertions(+), 71 deletions(-)

-- 
2.35.1

