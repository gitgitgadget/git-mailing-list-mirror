Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DC8A1F404
	for <e@80x24.org>; Wed, 31 Jan 2018 01:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbeAaBsN (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 20:48:13 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:42218 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbeAaBsM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 20:48:12 -0500
Received: by mail-lf0-f48.google.com with SMTP id q17so18257987lfa.9
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 17:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6BjZiPi5h4kzD3fxwmYJiOam8foatOAjtnDOHj6YfGM=;
        b=BvTE6l7dtBi/TlE8Z/F9aWGDqHXwDHc+5dFUakgRq56Z2FXWWUYG8EVssS/fhxzEh3
         MTwpNyKL6yu7u7tKrpg/gsaATb8Pr9OCoiSSOj5WYtd34Hp/Zj/xsgUmArbofr37buxm
         vmq2mH0Eot6H83Tu0tI/WpDPkZDHRLUA4BmCSZ+Z0CeJ4OxEdkpIOMBym8Ryo9ykabRa
         9sNGhIguYejudurAaT65kExKJKJAVuIQUV7tUkgzPXqciFCTi9MZqWbuNrmbT/viiG2n
         KdyoD5ipT+UlQMzzQDIKke/mNup7q70brpUdSH/5HkoHEhoTQWTccm3EKiBH8bgXcoOy
         eQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6BjZiPi5h4kzD3fxwmYJiOam8foatOAjtnDOHj6YfGM=;
        b=mBktb+6ft2FYUeUjr87as3qE2sEJh+uLlvCZUYtxixq3ANnUi1dn3G8KbuV1gSpoei
         985WVmZUBwYcX+OoVHipNpMUf3F/zXU3giX2k0dg6v30RF4aSM7icUlhbwqskgxJ/aq/
         iqTNNmMP1qmX2YPUOO8BA2KNXyLELExwJhp5IsXJKalQ28jJOJmYHyyuKkjKtDdSz2So
         3956wnNkIwDHhkuvNmpAIWFgWI8qKH5RygPVeYt1IsANy2MjhMDY4+dNEe32UqOwvv9M
         E7TqwwfetJLI0pVrXLWy9P4u8fVI84rIPmrBX1SDBVm5wCE288gYPLI3Ef6Q4LB+WNgH
         UHIQ==
X-Gm-Message-State: AKwxytfsdEpo/PAx52BCYjh19P3ZWKI2co/P2W8D7wGkIEjJUtsAGzup
        vdJUiIdUWjPbneiT15lJx2MAyhORuKGPJhIR5PPsXaDn
X-Google-Smtp-Source: AH8x224TKsco/+zod/9+Cjx7q6JPWncILVmaatthfGLYq7ht5QpZNzacgqYxJ9Xu7eV1SUlQhIzYFd2uWc27YPetrxQ=
X-Received: by 10.46.65.152 with SMTP id d24mr7420733ljf.109.1517363290673;
 Tue, 30 Jan 2018 17:48:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.46.74.1 with HTTP; Tue, 30 Jan 2018 17:47:50 -0800 (PST)
From:   Jonas Fonseca <jonas.fonseca@gmail.com>
Date:   Tue, 30 Jan 2018 20:47:50 -0500
Message-ID: <CAFuPQ1L7AKp5UXzLxUhFWkmK2HPRZhOMbapqdT7bCpbHSHkUow@mail.gmail.com>
Subject: [ANNOUNCE] tig-2.3.3
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

A regression in 2.3.1 (and 2.3.2) related with the detection of busy loops has
been revisited in version 2.3.3.

Release notes
-------------

Bug fixes:

 - Revert "Handle \n like \r (#758)". (GH #769)
 - Fix GH #164 by catching SIGHUP.
 - Change `refs_tags` type to `size_t`.

Change summary
--------------
The diffstat and log summary for changes made in this release.

 INSTALL.adoc      |  4 ++--
 Makefile          |  2 +-
 NEWS.adoc         |  9 +++++++++
 README.adoc       |  2 +-
 src/display.c     | 40 ----------------------------------------
 src/refdb.c       |  2 +-
 src/tig.c         | 12 ++++++++++++
 tools/aspell.dict |  2 +-
 8 files changed, 27 insertions(+), 46 deletions(-)

Alexander Droste (1):
      Revert "Handle \n like \r (#758)" (#769)

Jonas Fonseca (3):
      Fix #164 by catching SIGHUP
      Change refs_tags type to size_t
      tig-2.3.3

harshavardhan (1):
      updated https to https (#777)

-- 
Jonas Fonseca
