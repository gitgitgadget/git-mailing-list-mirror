Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AD8A1F404
	for <e@80x24.org>; Sat, 24 Mar 2018 17:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbeCXRhb (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 13:37:31 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44762 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752527AbeCXRha (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 13:37:30 -0400
Received: by mail-pl0-f66.google.com with SMTP id 9-v6so9338016ple.11
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 10:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=vPeK2oMMITvSO5ReY/Poife/4w8qvbG3v2Sk+il40lY=;
        b=t0atbWNSBfepo8xuE1P3rFlRXViDEkimM90hNabmcmsIu5YDFeUBqBFVDySSpODZaZ
         PpedLAlL1mzyBaR4oS25r8fGGw6f+Gt6/eoVMO3uFcaYbXRAppM3/OTwCVrjjkUOOFKI
         bMT+SnuGNggr/VPypQDLH5t08UAhqzKuG/1yKggQLOiFZWSnpcw2ODlZ9CjILdOefaRt
         6hj42g3I8CxKOd5FEi8xs2kCkby7pePwoHhB6lEwYDHlDr1gHFQEjgG/dsHrW1xlquqI
         eHCNXpS+j9TFMjsdmrpkYRdr3/VxX14/DchOq8iVERFaRgL1SfC8fwNh6Y9+1HgMbRnD
         EoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vPeK2oMMITvSO5ReY/Poife/4w8qvbG3v2Sk+il40lY=;
        b=fe2l1enlnoSGfIOEbDzlTQuwYkTwTKYfDT9GRiSt+cvskkM+kgLNUJsb2L6o2LKadn
         UuvuELkP2Z5vOSTIsR0yWK/Z8DLfGyQ9iy/RBFOUxDuR0iZGNYrYpXBG9buer9ebWNDO
         ueRRGCpr7972ncreNdmZ1lg5UrOO/cEiKGYCi0C0aOCD7Qj1GsJ7Hz6HzB9qIRxA+DDN
         mC/VtmHuzbJSZnkYgCbyjHpt83Qy4N4JD096cYsn26kPJe0X3GjTmbknYW/9neNFEvuO
         zdLHw1lYj6ccOEgMJnQQjFnZcXq4XvnEzrCfN0tdok8g7gOiiix7p8M+bupPrQFd6XMd
         eEcg==
X-Gm-Message-State: AElRT7H5LTvbx2CwGFEK2TMFAEYsd4Y+xGxdAfg1aGykL7jxOnZ+kyhe
        7OTIJLcTs+ayj7/0Si/gYtF+10A=
X-Google-Smtp-Source: AG47ELtgOHD68AGyt6iXR0iWsWIwKaPsrXmzvp8BNmQJ9j9vsw1MRKz/Sq4ZeyL4p/CgcDgbKIQZCg==
X-Received: by 2002:a17:902:b68c:: with SMTP id c12-v6mr33499717pls.52.1521913050115;
        Sat, 24 Mar 2018 10:37:30 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id z6sm22005486pfe.9.2018.03.24.10.37.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 10:37:29 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH 0/4] Convert some stash functionality to a builtin
Date:   Sat, 24 Mar 2018 10:37:03 -0700
Message-Id: <20180324173707.17699-1-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been working on converting all of git stash to be a
builtin, however it's hard to get it all working at once with
limited time, so I've moved around half of it to a new
stash--helper builtin and called these functions from the shell
script. Once this is stabalized, it should be easier to convert
the rest of the commands one at a time without breaking
anything.

I've sent most of this code before, but that was targetting a
full replacement of stash. The code is overall the same, but
with some code review changes and updates for internal api
changes.

Since there seems to be interest from GSOC students who want to
work on converting builtins, I figured I should finish what I
have that works now so they could build on top of it.

Joel Teichroeb (4):
  stash: convert apply to builtin
  stash: convert branch to builtin
  stash: convert drop and clear to builtin
  stash: convert pop to builtin

 .gitignore              |   1 +
 Makefile                |   1 +
 builtin.h               |   1 +
 builtin/stash--helper.c | 514 ++++++++++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            |  13 +-
 git.c                   |   1 +
 6 files changed, 526 insertions(+), 5 deletions(-)
 create mode 100644 builtin/stash--helper.c

-- 
2.16.2

