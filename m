Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907D3C6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 09:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCVJvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 05:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjCVJuv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 05:50:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAEB1731
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 02:49:35 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d17so7894377wrb.11
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 02:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679478574;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zu5vMShQXGrtPlU6dEg3dRa8AB+Kxzy5IsTqSQgW2Fc=;
        b=liBWXjEEGY0g3Xh8W7VJ5OHMjV8401BNS96iLf3e553EoUIOUTbo5GD43Vf7yN+J7O
         YqUCRz3kEUj4WLDfmtL0HJj/JWa9z7mS6QNChtHRvhfiaJCJPE0+nuDH+SkAlwZTl6a1
         OAbZaGqRfTV07rJ7ZKKChPi3iV/tVJJqct4AO6jAcA9kd2UFk1BM5NiBwDDT7rKaYHB0
         dh3ICz5q1PJRSC00JuFQmKN1yIobMs957WFMuY6pn0aUix7QKBLctHv+B6qOIF6ZkNWx
         /Vt7s4cuaDpesuuYsHS+GJt2hhuYwZ7CrcAzzbC333qdWuGjcEN3uq5c93j2Q/wR759+
         D3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679478574;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zu5vMShQXGrtPlU6dEg3dRa8AB+Kxzy5IsTqSQgW2Fc=;
        b=0WdTFZamu6pTiWkfMO4LJNP+z5YKke1PKJPF5XgJ04AMrDc/UN3V2qu3UFmbkJmSvs
         FhzDMpVzeyuDdqYiN0IXxmlDhBVfa4Fax7iv9tXEMni49MgUhUAQiMAC/x8dUFP4qSK9
         2mq0JBikQWqH78Yd4fRNNXU+MiFpQ3yaVoBuxTRmuu1M8ICJj357BFBPsrVu9GL8CBXn
         L7okywGPUfE0jrOoxa4G+WAOFAfiWdIAskD6P9CxuCU1sAd6QsbsyWZNxnbGgtvZRelt
         DZXODJPEzH1AXGw6psLgexS/Mpz4NmQkR7Msnewk43uGku2i/CRXk5fe6ZggIax+41ae
         wCQw==
X-Gm-Message-State: AO0yUKU660O7VAocGRzIW4pfBLkXnE//4kqBHfdBiLmxuav8m1Wi3EZl
        Vzv4/k+OllYAEkhyCMKNJEhDKKug/to=
X-Google-Smtp-Source: AK7set+Ta9KXd7bEFPPE9JHADihUfmZdsUIJOx/BKRrOTB1utoaBaR18cmuYT7aEI4AiC5BYR3zOHA==
X-Received: by 2002:adf:f20a:0:b0:2ce:92af:adbe with SMTP id p10-20020adff20a000000b002ce92afadbemr4799341wro.59.1679478574156;
        Wed, 22 Mar 2023 02:49:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12-20020adfe34c000000b002da75c5e143sm1076359wrj.29.2023.03.22.02.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 02:49:34 -0700 (PDT)
Message-Id: <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
In-Reply-To: <pull.1471.git.git.1679153586903.gitgitgadget@gmail.com>
References: <pull.1471.git.git.1679153586903.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Mar 2023 09:49:31 +0000
Subject: [PATCH v2 0/2] Document the output format of ls-remote
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sean Allred <code@seanallred.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cc: Eric Sunshine sunshine@sunshineco.com cc: Felipe Contreras
felipe.contreras@gmail.com cc: Sean Allred allred.sean@gmail.com

Sean Allred (2):
  Update show-ref documentation for internal consistency
  Document the output format of ls-remote

 Documentation/git-ls-remote.txt | 24 ++++++++++++++++++++
 Documentation/git-show-ref.txt  | 40 +++++++++++++++++++++------------
 2 files changed, 50 insertions(+), 14 deletions(-)


base-commit: 950264636c68591989456e3ba0a5442f93152c1a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1471%2Fvermiculus%2Fsa%2Fdoc-ls-remote-output-format-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1471/vermiculus/sa/doc-ls-remote-output-format-v2
Pull-Request: https://github.com/git/git/pull/1471

Range-diff vs v1:

 -:  ----------- > 1:  4408b518810 Update show-ref documentation for internal consistency
 1:  a80059d90da ! 2:  44e79f0d69c Document the output format of ls-remote
     @@ Documentation/git-ls-remote.txt: OPTIONS
      +OUTPUT
      +------
      +
     -+The output is in the format: '<SHA-1 ID>' '<tab>' '<reference>'.
     ++The output is in the format:
     ++
     ++------------
     ++<OID> TAB <reference name> LF
     ++------------
     ++
     ++For example,
      +
      +----
      +$ git ls-remote

-- 
gitgitgadget
