Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D1391F403
	for <e@80x24.org>; Fri,  8 Jun 2018 20:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752979AbeFHUc4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 16:32:56 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35120 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752883AbeFHUcz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 16:32:55 -0400
Received: by mail-wr0-f177.google.com with SMTP id l10-v6so14557879wrn.2
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 13:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gjBm1vJLcvmShHokBrZbbfRq0g6LUGQgWNbvJTSgVzA=;
        b=e8d5bN+umPJWR8eGzjZUF2gOC2fsxd7qbS94D1GFNZTjUcvwXMwh8NvR/4acs6l08U
         OeX3gvOpEIUCVf3F7MsG0VvpIKiW2Z1xw2SJhXe/LSrNjzIVbqeU4dvJJYOvB2ks9MNt
         U5BBERVOBiTKaeQ0d/gWWUsVr3GoLOf6xIFPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gjBm1vJLcvmShHokBrZbbfRq0g6LUGQgWNbvJTSgVzA=;
        b=ch2NROR33N1+pHr9zQaSB7X6pMt+l1AtjvakMr9cqiIatCoM9k5oJfmkTqwMDf3cW5
         rDkJbBdyX6p6oznTiyijfD6ViCIeoFrwq95aKhDV6PA9hrohnoEC37YnS7IQjlvU6n5a
         KstahigF2Nryk9wptvZjAdR12VnM/y8YWVLLCYWD6t3rNgWg29lmR1ENlKxaRbZ+s/QW
         f1OUuR6niXRhYY9FVa7nwEEfzOcTNSCPk9TQRfu2iJ0B2ZdIrBZM1bkfBVgyV9IE69q3
         25Ai4Im5WrS1uV5jSB7nme4jZ8sELdyG3qeXxlRFuEqB6ovGAk9r7mqdkF8hEQmWwtOs
         dPXA==
X-Gm-Message-State: APt69E1Cuk3/q9EEZ19LzgD17SCMZhNkvGttnsxyAwq/PTESAfovjD63
        b2elDAsnT++0/yZnzdVqB9O4i7BG
X-Google-Smtp-Source: ADUXVKLxDBXcVbrJByoDeR6LHEio3mBos4SBCUBfCgbFlkESZ3gqQW+tV7WIhKYRX83rWUXh+NssfA==
X-Received: by 2002:adf:ad4c:: with SMTP id p70-v6mr5669725wrc.44.1528489974253;
        Fri, 08 Jun 2018 13:32:54 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id k82-v6sm240001wmg.10.2018.06.08.13.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 13:32:53 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Eric Scouten <eric@scouten.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Merland Romain <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lex Spoon <lex@lexspoon.org>, viniciusalexandre@gmail.com,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 0/6] git-p4: some small fixes updated
Date:   Fri,  8 Jun 2018 21:32:42 +0100
Message-Id: <20180608203248.16311-1-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an updated version of the set of changes I posted recently,
following comments on the list:

disable automatic sync after git-p4 submit:
    https://marc.info/?l=git&m=152818734814838&w=2

better handling of being logged out by Perforce:
   https://marc.info/?l=git&m=152818893815326&w=2

adapt the block size automatically on git-p4 submit:
   https://marc.info/?l=git&m=152819004315688&w=2

- Spelling corrections (Eric)
- Improved comments (Eric)
- Exception class hierarchy fix (Merland)
- test simplification (Eric)


Luke Diamand (6):
  git-p4: disable-rebase: allow setting this via configuration
  git-p4: add option to disable syncing of p4/master with p4
  git-p4: better error reporting when p4 fails
  git-p4: raise exceptions from p4CmdList based on error from p4 server
  git-p4: narrow the scope of exceptions caught when parsing an int
  git-p4: auto-size the block

 Documentation/git-p4.txt |  13 +++-
 git-p4.py                | 161 +++++++++++++++++++++++++++++++++------
 t/t9818-git-p4-block.sh  |   8 ++
 t/t9833-errors.sh        |  78 +++++++++++++++++++
 4 files changed, 236 insertions(+), 24 deletions(-)
 create mode 100755 t/t9833-errors.sh

-- 
2.17.0.392.gdeb1a6e9b7

