Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 604E01F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 18:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932812AbeGHSbu (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 14:31:50 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36594 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932383AbeGHSbt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 14:31:49 -0400
Received: by mail-wm0-f48.google.com with SMTP id s14-v6so18551118wmc.1
        for <git@vger.kernel.org>; Sun, 08 Jul 2018 11:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6FoVAL+g6qt+Guw/K8wefccswnE6c9u8CyfhHn/iciE=;
        b=bM/kcn+2Y9cH6JlmQrzEyYHtpELMMzKkq+eN9JSo3qX2t5xIo/PfH1MCr/7u2u5y9o
         GwzkmdxIZJwu2AMLn6er+365+gu9N9geT0syPHrVdd1qLiSdPoy8XstY7fTX0j/JWErv
         PqciNdZxPI6AWa++0WMUBIXu57sx79yIAYfwH+8F1q3RDQodTWzv0zVDwHi6bFJnI/BV
         1CuBYu2b0ZbuAayoWJaaRCSMeA+ZywzHqUtspWbS+6ynkbSTq909dkfYJpIlRg7MPSrc
         XuYKXUYm/zsePan/nNN0ROlmvBKHtDuYSCwpa7Q2AfK4dehQ3aGDdvK8Mz1y+am1+Fjp
         xg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6FoVAL+g6qt+Guw/K8wefccswnE6c9u8CyfhHn/iciE=;
        b=NNZyoRDFpgA8pOfOK5tb/SIAsz31gE9EB5EO7yZqQQQcarVU0z9NKVVgPWPbvCVRRy
         i9/IZ0BhAFhy3l30srYB9mwaJ/UWDyDBtK3nGIgHE8iV4NftUJWROBJqCdjkaOTgSCnk
         TwbxxFv1V8MO39N23sMbBBrBxUk9BYwXC03DU9m+5W8WEXI290Zw0gyfOStkx57uA15g
         3r/nAuHfy82fo3WDeMUMq5qVjFjJ6/FabfKGruXctaoxDPKefyyOjluWtqJudvjbbxdI
         Ftt7e+dDdjRZLA69NC6oPtYfe9HwVoG9AC5t0IuO835jItrewcAWs0VqrR6kjaUVuN4c
         jHag==
X-Gm-Message-State: AOUpUlHAfL2yd6K3NYAK/rPgXOsswB5RRMbUk6i28bIhGi5zlAFG4OH8
        7FAvjYVvxtIP0tusYjcgSCGlOq18
X-Google-Smtp-Source: AAOMgpdHBy0TZ4TH0Vr3k+ucQUz4QVUsQjvi9GwF3QubCZBm0jqckGR53XdElq3Z6htw/L4Dirpxjw==
X-Received: by 2002:a1c:6585:: with SMTP id z127-v6mr5028169wmb.5.1531074707932;
        Sun, 08 Jul 2018 11:31:47 -0700 (PDT)
Received: from C02WQ21WHTDF.fritz.box (p5DDB5D90.dip0.t-ipconnect.de. [93.219.93.144])
        by smtp.gmail.com with ESMTPSA id c7-v6sm26114917wre.73.2018.07.08.11.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 11:31:47 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Johannes.Schindelin@gmx.de,
        jehan@orb.com, whee@smaertness.net, me@ttaylorr.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1 0/2] convert: add alias support for 'working-tree-encoding' attributes
Date:   Sun,  8 Jul 2018 20:30:34 +0200
Message-Id: <20180708183036.29459-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

this series adds Git config based alias support for
'working-tree-encoding' attributes that were introduced in 107642fe26
("convert: add 'working-tree-encoding' attribute", 2018-04-15).
The feature was suggested by Steve Groeger in [1].

The first patch is a refactoring with no functional change intended.
The second patch is the actual change.

Thanks,
Lars

[1] https://public-inbox.org/git/OF5D40FE06.C18CD7CD-ON002582B9.002B7A02-002582B9.002B7A07@notes.na.collabserv.com/

Base Ref: master
Web-Diff: https://github.com/larsxschneider/git/commit/0cbee9bd8d
Checkout: git fetch https://github.com/larsxschneider/git encoding-alias-v1 && git checkout 0cbee9bd8d

Lars Schneider (2):
  convert: refactor conversion driver config parsing
  convert: add alias support for 'working-tree-encoding' attributes

 Documentation/gitattributes.txt  |  19 ++++++
 convert.c                        | 114 ++++++++++++++++++++++---------
 t/t0028-working-tree-encoding.sh |  28 ++++++++
 3 files changed, 129 insertions(+), 32 deletions(-)


base-commit: e3331758f12da22f4103eec7efe1b5304a9be5e9
--
2.18.0

