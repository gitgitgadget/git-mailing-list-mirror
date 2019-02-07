Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3B9C1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfBGKdp (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:33:45 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45359 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfBGKdp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:33:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id j3so2437909pfi.12
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sPVzCQOa9DrG2SS8xCyClHmXynwU4sMjaaMU5ALmS6g=;
        b=mTH+NTD3sqVPBMhGNnOqNOX7jna9VNQcADSB0Pv3RyM3/dT6hYC4Ks1WUFMimTq2ik
         i6wPFB5CQhY0tKlGjR5ATCRw3NO3gUDDeSPQBxaMSTdVxDmG2PGHDGLpkuoa2IaObdPD
         Irl71BY/b+9Dj72Ipcq8HxV8HzE4Y2TLNjREMGpWn6xpGBbm2erSA8g3JSjxuAxII8eL
         1xgx0+HNPM6GK7OtxSOryWDH0lFzr5fWmAoKpJ8qdAgXoWQWe1PIg6/CiWm6QKju6yI9
         b6C1ZUPCMMtvIbNPE6yGofY4KP0WJm06uzmtfpvHhviMzv1mmJQClkhybrALROHRIjQ6
         7W8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sPVzCQOa9DrG2SS8xCyClHmXynwU4sMjaaMU5ALmS6g=;
        b=jhrC22AX4TL+MkgxKDJy6gXi5mJvoXRJw6oZNLfH6iVtz6xspDQtugLDWS7H2Nq/e1
         gtlQq5n8FUIZ2NA1ZG+6hYf1wpYPC+b6yaZcAGAOIL8AZoIMBv7KJudL4xjsaiSn/9DI
         6S0wPf+LgEuHRjMB2U0ghGVbt7Vtn0od9w1rdM1kW9+iTR25m6Wi7aGAbQpigLNYhfhw
         d9cc98AIv1RX7PwTOj0CNGnZnJij+P4bwEvYOthr01SinbHM8iNSlgkkyxSEFByo4w1P
         1d+kPw6whVEMIbdM0+hnqXH4zQutZR5MGLwGeSkImG1zC2ckBTald6p+CODEKLyFTeuh
         Venw==
X-Gm-Message-State: AHQUAuZamxGQygzJOuY2E2HrAcAaepIvUyzPrr6sfdzvx4zIFFxfJcLI
        ncnwvkj4xlpYHIWyAxpVBGMcYAxQ
X-Google-Smtp-Source: AHgI3IYUqRCSaAB11Bwhqw3KFioU1LAf/vHZn3JhFCKvTi1a1Vd8wLBtmhBPcvU7SYDUAgJBhxuAcA==
X-Received: by 2002:a65:6684:: with SMTP id b4mr14186570pgw.55.1549535624533;
        Thu, 07 Feb 2019 02:33:44 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id p7sm13312814pfa.22.2019.02.07.02.33.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:33:43 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:33:39 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/21] nd/diff-parseopt part 2
Date:   Thu,  7 Feb 2019 17:33:05 +0700
Message-Id: <20190207103326.10693-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"What's cooking" mails seem to indicate that the series will be cooked
in full there then landed on master later. So here's the second part.
This continues to convert more diff options to parseopt.

Nguyễn Thái Ngọc Duy (21):
  diff.c: convert --patch-with-raw
  diff.c: convert --numstat and --shortstat
  diff.c: convert --dirstat and friends
  diff.c: convert --check
  diff.c: convert --summary
  diff.c: convert --patch-with-stat
  diff.c: convert --name-only
  diff.c: convert --name-status
  diff.c: convert -s|--no-patch
  diff.c: convert --stat*
  diff.c: convert --[no-]compact-summary
  diff.c: convert --output-*
  diff.c: convert -B|--break-rewrites
  diff.c: convert -M|--find-renames
  diff.c: convert -D|--irreversible-delete
  diff.c: convert -C|--find-copies
  diff.c: convert --find-copies-harder
  diff.c: convert --no-renames|--[no--rename-empty
  diff.c: convert --relative
  diff.c: convert --[no-]minimal
  diff.c: convert --ignore-some-changes

 Documentation/diff-options.txt |  20 ++
 diff.c                         | 510 +++++++++++++++++++--------------
 2 files changed, 319 insertions(+), 211 deletions(-)

-- 
2.20.1.682.gd5861c6d90

