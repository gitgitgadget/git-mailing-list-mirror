Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F28F1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 17:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeJZCQJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 22:16:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40657 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbeJZCQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 22:16:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id t22-v6so9025279lji.7
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tzTC2Mc724dROQu8aNk5m0qOMEJFQFJRq4GcMkdGRJ8=;
        b=hanK1TnAafNuWGZTKjguBQiCkZE/cNHUcMQ1JgXex2E3w1paRN+mYgij61kcKqrlZX
         KAM3qFARs2fHL+C3Kc5XdAa96YqnG/UjbvCIPuHxdXwS/kmhR7Cfu+s7xEQ5+cHIG76n
         i+yzVdo7OFMz2IfSo3tMeYQNyi5M4GkqooeskCOQLPEM0JyTs9EjtHAJYHm/arxGCkDb
         8t2JDS4MefW7XkLMZfPI5gk4tegZOQ88i9GiN2Nx6w7kzeSVfkm2t5RHrhXUQcnJTMwe
         LtaIuWHs3glpYwYYpaiX4k+x8jYtzYE/ZgafvbkAEFOOUPU71iIOXMqrdte79CgALwaI
         TmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tzTC2Mc724dROQu8aNk5m0qOMEJFQFJRq4GcMkdGRJ8=;
        b=Nus4HvM0W2ivBL5O4tZZ0al4TSl65H+22CGWf9Sh9S6g7XcRO520zRZeRrdOWWe/zd
         HwumB0ZoGpIPhH0sDvpoP9hSnBTwO7UbzU6ex3W4mf81xaKNg9OPZTFf+x3fEoqQ1WLF
         0ePck/dobwAsUAL0rG3XDPIEEwNFwarcd+S592/IqQOt2IwnIdUS9eCAxyG9GG7rOQBY
         jOvqxAWFTbjFfK7F5V6uN57v93+pDnj7QgbuT8UUT5ufS7Y2Bo08oI7oSQIQa30uMPrR
         YWkKy/4eZzPdfb21IexuatHa6Oxum18p3v3I93q2Vg5RfjiMBY/pyQC1j+ptyRpaHTwp
         5xbg==
X-Gm-Message-State: AGRZ1gKIWRhbGve/LERUKvZQf7cUk2ZQzAwzrjUd+dni9LR5w1uqzi+E
        +hgHKVjyYMask5Xln68+k7c06N+2TjWJMGpLMJvBNtSH
X-Google-Smtp-Source: AJdET5cAMfvq3R2qIO8eFncbZ2zW8e7iF+X2U7BvOKnfe6f4ch8NgrIkO6X0UXwlAw8iL8kbleunvvJpQxLm2k0grRQ=
X-Received: by 2002:a2e:d11:: with SMTP id 17-v6mr154985ljn.18.1540489341704;
 Thu, 25 Oct 2018 10:42:21 -0700 (PDT)
MIME-Version: 1.0
From:   Sebastian Staudt <koraktor@gmail.com>
Date:   Thu, 25 Oct 2018 19:41:45 +0200
Message-ID: <CA+xP2SYtBGoxyV+hfjvYeEVU6XuvoZubC+-ffdubRgee=JtWXA@mail.gmail.com>
Subject: [PATCH] travis-ci: no longer use containers
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Travis CI will soon deprecate the container-based infrastructure
enabled by `sudo: false` in ce59dffb34190e780be2fa9f449f842cadee9753.

More info:
https://blog.travis-ci.com/2018-10-04-combining-linux-infrastructures

Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
---
 .travis.yml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 4d4e26c9df..8d2499739e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,7 +1,5 @@
 language: c

-sudo: false
-
 cache:
   directories:
     - $HOME/travis-cache
--
2.19.1
