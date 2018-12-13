Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6823920A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 13:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbeLMNBO (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 08:01:14 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:45297 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbeLMNBO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 08:01:14 -0500
Received: by mail-pg1-f174.google.com with SMTP id y4so1024531pgc.12
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 05:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=yHuWLaF+XW/CwpSrHhjOUt40dZL+PlKqfZD3Sn7CYTA=;
        b=GMjdx6aOPN4W+n7ncvD5D7pfCVLiiTO65G85Ew9qikYHDLi7CQl66fI/Jah+mZlk7Y
         0XggODiwpWApAB9fYxRUkwWorP7dShPC0gQIE0SCKakkxrng64r63GC2ddTMNU3Y2IiK
         /rBJ+wS64htVDh4vSDpSwEYieBhwPcIfL3w9pMwxTKVnpd+CpQeEaECKr65Umq1yXJmV
         hP6SC/QqFkWfKGco+R1Tk7y5Iz3bKlIwV4aMvkp3YiNLY+SAbErwHqmn1NODAl2HBPkq
         z4mRIZwvnN2nAFKGYhoCvK4gKZkG2iExlsSa+0MCOthdN3aSddTpJRXDi28OXDO9Pfur
         +ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yHuWLaF+XW/CwpSrHhjOUt40dZL+PlKqfZD3Sn7CYTA=;
        b=RsAhv+rV811Lb6E4ab2UhIsAJsh2UZ91rORvh31VpVfmQIH6O+VZNd4Bl7Fb2te9qu
         AHclJWVCnf73lzbhUUWNXCKCYrsiC1+7qpbJrIYzUB34oyXzHjXht9M/pO7HP+a2WdqR
         M9KwJsJ+Av7OPakon2pRXcu06PfxnhRMw31Y3eSixo8rNdl5jjeG1CE+jnm6ZEE1hMLK
         83VwS9Ss7wcaALDlrkr8jX/hC1YUQo3zS9NfaWVjlNuaIZmxB7NgKzzsgZkpPVewrB0a
         QBVGwGJXRXobWUChxfy5x9H/cDLnEeer0iQlW3pZeQrilJ9DnwZa5x0e2jUQX8tSuTdu
         jxbg==
X-Gm-Message-State: AA+aEWba9KxS1nFMVJZZM9J+Xf37Qbf6tPavtQcguoAWqIeQo5NCF1BI
        xBUl8t4lFVKhO9/VpnJeLwkmfCna
X-Google-Smtp-Source: AFSGD/UTNaPM3dGWrXXFUjJihou/c0RSTmh+mEkty1tbWhs/ctRPCm8o/kvui4N/rQ2ioLfrAJP5zA==
X-Received: by 2002:a62:190e:: with SMTP id 14mr23864612pfz.70.1544706072343;
        Thu, 13 Dec 2018 05:01:12 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id m9sm2290713pgd.32.2018.12.13.05.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 05:01:11 -0800 (PST)
Date:   Thu, 13 Dec 2018 05:01:11 -0800 (PST)
X-Google-Original-Date: Thu, 13 Dec 2018 13:01:08 GMT
Message-Id: <pull.99.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fix regression in t9902 with NO_PERL
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

The oneline notwithstanding,13374987dd (completion: use _gitcompbuiltin for
format-patch, 2018-11-03) changed also the way send-email options are
completed, by asking the git send-email command itself what options it
offers.

Necessarily, this must fail when built with NO_PERL because send-email 
itself is a Perl script. Which means that we need the PERL prerequisite for
the send-email test case in t9902.

Johannes Schindelin (1):
  t9902: 'send-email' test case requires PERL

 t/t9902-completion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 5d826e972970a784bd7a7bdf587512510097b8c7
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-99%2Fdscho%2Ft9902-no-perl-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-99/dscho/t9902-no-perl-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/99
-- 
gitgitgadget
