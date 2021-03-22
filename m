Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D533C433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 03:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC7861939
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 03:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhCVDHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 23:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhCVDGn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 23:06:43 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E090EC061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 20:06:42 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g15so9993132pfq.3
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 20:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ydeT7JTILVu8eDcQXdB7Lwqiphd6qf+K7GCLIwf3FwI=;
        b=LXahT9QdkucTrcN7WHEbr1mtmAgmYDwDzUxBzN8WDf20K8JGNg4CUy6CTVUufuaEMX
         EFimpxRSCZM4BTkspugSrpSrChNwxMFBEUjVEv9TSv1dKRz86sMe+NlOE8gQR9oYleun
         1EJtOv89oGI3jMBSLO0XDXuD+Ne5+7uq+r+7AmhpX9MgGU9qqKgToWjijQZzwA9NXoYg
         imsgXkPJzjzKoRcyZST3rCg4pgVGlEd3xuAcwE29UsSqkM3qCVe7IWd75xi0NP7OahDa
         sw2risMkW4ADKZpzkGYhiVKNN1L0p28ZoQBlkAaI48hRtqdPNoql9Sz/MFweePEGHXHY
         XJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ydeT7JTILVu8eDcQXdB7Lwqiphd6qf+K7GCLIwf3FwI=;
        b=W7udWjfcSds2wIVO3xPWJIMXQXxuuUrbGRQK99J7PD1evuQ03sqVw0o2FLBtI8b3DW
         cHNGoXYr0UJjgBe/7VyG+DVqkIfEWQu3vSp6T+zWhk+g+ErIGUAv8FKv2C6VNcXi18VF
         cfKJxSaRoPfwyK5XFoR2t1Gd4kBB2AP5twIrjM9VyRBExXjZVERCHjtEpwl9+fgwe0t1
         6s/AuyEdMs93PmTcvuxPHbFyKem+vp2ImBi3c6tiV7Y9gukNXq+RU2Ic1ABRy0QAjgnL
         6Qn5NquwmIyLLgGrXJEW6BpCSfamNttGyB/LYpXavh0zidJ95GcVQLZaCJ78U4SB/SwV
         /IIg==
X-Gm-Message-State: AOAM532Y2e0DDSBNQKESvR47at40WVBL/Ix2aChqb/LzfFh2GhnGZcDN
        QECbhhrX3B9Xwt7GmCJveOnY0Xuo/YATg0nUzVBY77BVEwI=
X-Google-Smtp-Source: ABdhPJyVerZ7kTETC1sj4a++2KaIrnmnVsoNwXURsfnsmOjiK201IA3PvHyxBwulo02v2AtiCTEtu5CVe/zyyuB4VAI=
X-Received: by 2002:a63:141e:: with SMTP id u30mr21335338pgl.31.1616382402241;
 Sun, 21 Mar 2021 20:06:42 -0700 (PDT)
MIME-Version: 1.0
From:   shadewither <shdwthr@gmail.com>
Date:   Mon, 22 Mar 2021 11:06:31 +0800
Message-ID: <CAKrd5586jDVOSF-aYqqtA=Dt-Qn=zC89MHXkpS=7hNHP779stg@mail.gmail.com>
Subject: How to disable git verification of ssl proxy?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git version 2.25.1 / Ubuntu 20.04
http.sslverify=false does not work. git insists on verifying ssl proxy
and complains.
curl has an option of --proxy-insecure to disable proxy verification,
what is the equivalent for git?

$ GIT_CURL_VERBOSE=1 git ...
* Couldn't find host github.com in the .netrc file; using defaults
*   Trying 127.0.0.1:1088...
* TCP_NODELAY set
* Connected to 127.0.0.1 (127.0.0.1) port 1088 (#0)
* found 391 certificates in /etc/ssl/certs
* ALPN, offering http/1.1
* SSL connection using TLS1.3 / ECDHE_RSA_AES_256_GCM_SHA384
* server certificate verification OK
* server certificate status verification SKIPPED
* error fetching CN from cert:The requested data were not available.
* SSL: certificate subject name () does not match target host name '127.0.0.1'
* Closing connection 0
fatal: unable to access 'https://github.com/gdabah/distorm.git/': SSL:
certificate subject name () does not match target host name
'127.0.0.1'

--
yours,
shdwthr@gmail.com
