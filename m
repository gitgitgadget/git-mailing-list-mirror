Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCB06209B4
	for <e@80x24.org>; Wed, 14 Dec 2016 00:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752707AbcLNAJH (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 19:09:07 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33145 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbcLNAJF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 19:09:05 -0500
Received: by mail-pf0-f195.google.com with SMTP id 144so104487pfv.0
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 16:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=a3FBoCwWiGTAD56MvSuYZevcZSScXzGa95sHkyyu640=;
        b=O6QY8Z4QxyxUUQhiRvtOckoLbem/oklFABr63Xon9h8cAMJHwYOgg+nTVkrMXYiiuv
         6CzsFzKZQCr30l4gdutHFsAStRJOqVyTl4YIGHqNH0SLiCz7/69IY5HC85/cKbrW0NIt
         3piMDFhwve8wloxiVEJzo1e4ybB8YO/u9upxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a3FBoCwWiGTAD56MvSuYZevcZSScXzGa95sHkyyu640=;
        b=BggbqXqea07UPmDc86jeCOfdDRGyLfb8daOymlR4G0mz46jJ2okUcVMH+ssllSuSkE
         BtVim9vCv+NxyPd6FXgvh1+6GT6xUnhoBUrCUWCBwF5kH+YR0JS4IwZ+p8Um3eU1kCIm
         Rbxa/MFOcufefnzbhym1YwqMCii6YyP9KufXL9bkJGwu2ySdk1jMK8vn/QyJFaaWF+Tv
         iT6DLN5wcpHhAIoZb6li2Wsu8Moc4E6ExYFMhcdnT+/9wkH6acBYmiNroiyh9pQSHnTj
         usY7ZVlT52hwhY4ixIyc5q1iKjCAoHZTFRfJWEtmzG1iCbRmsnET7Pc0UGzHG5XJtzxt
         GtCA==
X-Gm-Message-State: AKaTC03WwXhRh2izp9UHteV0HGCGh34pjCvX3ajvrEqUO4urmp+NhpMVbuA2WpFh+NXivQ==
X-Received: by 10.84.172.131 with SMTP id n3mr196350050plb.5.1481665897931;
        Tue, 13 Dec 2016 13:51:37 -0800 (PST)
Received: from ethel.corp.roku (cpc108967-cmbg20-2-0-cust367.5-4.cable.virginm.net. [81.101.7.112])
        by smtp.gmail.com with ESMTPSA id p13sm82451817pgf.47.2016.12.13.13.51.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 13:51:37 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     viniciusalexandre@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv3] git-p4 worktree support
Date:   Tue, 13 Dec 2016 21:51:27 +0000
Message-Id: <20161213215128.20288-1-luke@diamand.org>
X-Mailer: git-send-email 2.8.2.703.g78b384c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Support for git-p4 worktrees.

Adds test cases for using git from a worktree, and
specifying the git directory either with the --git-dir
command-line option, or with $ENV{GIT_DIR}.

Luke Diamand (1):
  git-p4: support git worktrees

 git-p4.py                 | 17 +++++++++++++----
 t/t9800-git-p4-basic.sh   | 20 ++++++++++++++++++++
 t/t9806-git-p4-options.sh | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 4 deletions(-)

-- 
2.8.2.703.g78b384c.dirty

