Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2481F453
	for <e@80x24.org>; Tue, 30 Oct 2018 18:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeJaDjT (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 23:39:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45017 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbeJaDjT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 23:39:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id j13-v6so2792323pff.11
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 11:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=/k8MG7eBTJH9A2+WfNdPQSJ6WBFgRot0eWOMMay5KuI=;
        b=UsehFAH7VW7oHHUwZYVumt1AZNXR6zjl5zrx1MeLtQ15eQ43JhVNg8tOOJGOHcdbYt
         DtdNT9UFA4Zpz5VBrmTFlIPjVZ+IkQ+MtWA1/OSHIjx2n7Ow7GCE91GrpVbfRE3oB0by
         W6Z0wZH7U988td27E4ARTVdmMuOf/76OFWC4Kt/NusOWs1EM8nX2TefKMJqlyIVZHvOD
         bBIH0vE76e/9H9vEURTrld7NVlUIVT1vo8hWMdGp4loXm7XAK7UVgqcyvI0/fMVln70E
         t548kH4pqRzmVru+q8pdKxsbALXeufGcj0CIjubxT2CxSGWSk0Bd2sa2oJY2iW4di6+Y
         igNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/k8MG7eBTJH9A2+WfNdPQSJ6WBFgRot0eWOMMay5KuI=;
        b=Q0iPTJHYT0pyd7vbsccWi+WiaWkCSCBkMRzmcAD3eqXBMiECULf7/QsIWqpeGd7LkQ
         S02UvX0NU/Lfh44ZqB7TE5VrQFo8FWjbzCQ6NeBNkAWAUCJB5m4w027/W1PIzHTzRrvY
         fBuiGzqilWjnvuD4pkW1wQpsgsjl7OKrEuVZ0fy+FOyE+RSSYW5Wg6tVtBr7aRj5vhNa
         aAB6PT3GNZcxrELBj0b0paOR9457njbOWRXgq4jMmR7fbUx/5t5k9dFMcnjLTX2CpGxR
         37OGuHh1GAi7H9AP4wb9tQ7vT52+LxBRB2veBGQHHCSULlrCE6zuYHPzhdqga2GI6BoE
         szPQ==
X-Gm-Message-State: AGRZ1gIq3Nhmr0QXRHSRoRN4CmhWKDL/l1ZZXScxFbnuRy9GJPVcx4WN
        4p/9ZDr8T5PANW+yCCt28K69cVxp
X-Google-Smtp-Source: AJdET5fKq7binP1hWLUs91NqIdpzodNIBQ91hNuj7BsKvcvZdK7jJZxzDdD/2JZZIqdJuWPJCK9M5w==
X-Received: by 2002:a62:670f:: with SMTP id b15-v6mr4101149pfc.243.1540925080112;
        Tue, 30 Oct 2018 11:44:40 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id p82-v6sm48949238pfa.47.2018.10.30.11.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:44:39 -0700 (PDT)
Date:   Tue, 30 Oct 2018 11:44:39 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Oct 2018 18:44:36 GMT
Message-Id: <pull.61.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] mingw: fix isatty() after dup2()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch has been looong in the waiting (well over a year) for being sent
to the Git mailing list; it is a fixup for a change of isatty() on Windows
that had long made it into git.git's master branch.

Johannes Schindelin (1):
  mingw: fix isatty() after dup2()

 compat/mingw.h   |  3 +++
 compat/winansi.c | 12 ++++++++++++
 2 files changed, 15 insertions(+)


base-commit: 4ede3d42dfb57f9a41ac96a1f216c62eb7566cc2
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-61%2Fdscho%2Fmingw-isatty-and-dup2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-61/dscho/mingw-isatty-and-dup2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/61
-- 
gitgitgadget
