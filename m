Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B22781F404
	for <e@80x24.org>; Mon,  1 Jan 2018 22:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbeAAWyx (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jan 2018 17:54:53 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45316 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752294AbeAAWyw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jan 2018 17:54:52 -0500
Received: by mail-wr0-f194.google.com with SMTP id o15so15001791wrf.12
        for <git@vger.kernel.org>; Mon, 01 Jan 2018 14:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1EjxNb8/000pTvsa3tI3i3ZC/vFI4eDlQCfP70HI7mY=;
        b=dsy2mXP3ZfRoWbgjbakhTuO2oDgz6u0BS3nfB+OWCqFSkCZat0ZIY0XOxGLtRvLy+E
         1Ur9c9gX/00sgJTzKITCYJQIHBz5VqJC9g+l2w6isvSEYTLM5rm62luIzxZpNVyM1lHq
         4MJIRruSZxILmhEiOrqliLSDuaRU71AWUdWRNePHlfRPbtb0g1egRaoaeVibHOXWKrc1
         JqI4FNIaUsQeyOMM6sHmPJWjdfo+badtF1PXvWEwK13V9WdBRVbfbuiF6MlJq0MKnNT9
         4qtCNn8PrEB33NWtXl1CBnDGY0wqKbFF5Tp17fZieqqgKmPOoeCznBF4JJ8lBSiOQcg3
         fKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1EjxNb8/000pTvsa3tI3i3ZC/vFI4eDlQCfP70HI7mY=;
        b=Mm+8Aup5qz8lqgtBgQqqXG5ZYcLN3FIxH5Z6/oPA7CcL6qvw/cMLRrZZ+BglF8qLJO
         c8bDqzXZWh2kNioGSGUu4Ajfv5WTWnizzjpgTMbNtlOgn+cT45uW3INWdzLZZvrtaiRQ
         T8JSBFN7UpMcwlWHwKo4SK9y/d6FEwBvBdQ0NjbfNddU+Kh8m+IQ8LUzVmJ4hq56uotc
         aBKxnpd4rnV8VpCDVkEI8Ru1h3HqlaYnvBmGEZvVwGue3P4oCXmkpr0RAktn9jP70h+/
         V19ZNK5X96oqR+8hFyFQmnXJLK4MubwCoB66vMRN7iZpHHh0dtuOHOhH7ieBOixxpxT1
         qnkg==
X-Gm-Message-State: AKGB3mJdIrR9HOLn1cgtQ3Bz/0Cu6PwrHbiU1e3hVq7ht3alkC+nWJbG
        t89a5pgpZxjV+GOLNGOLDiY=
X-Google-Smtp-Source: ACJfBou1k6t0dgW689q1azCItKZJutkZEi631wgJ76P4+VD0f/UyWuNM0KPVSNJ1T5pIl5Z9QVaLqw==
X-Received: by 10.223.139.16 with SMTP id n16mr38471013wra.84.1514847291787;
        Mon, 01 Jan 2018 14:54:51 -0800 (PST)
Received: from localhost.localdomain (94-21-23-100.pool.digikabel.hu. [94.21.23.100])
        by smtp.gmail.com with ESMTPSA id d7sm54186061wrd.54.2018.01.01.14.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jan 2018 14:54:51 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/4] branch: add '--show-description' option
Date:   Mon,  1 Jan 2018 23:54:44 +0100
Message-Id: <20180101225448.2561-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.67.g3a46dbca7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git branch' has an option to edit a branch's description, but lacks the
option to show that description.  The last patch adds the option to do
just that.  The first three patches are while-at-it minor cleanups and
fixes in the area.


SZEDER Gábor (4):
  branch: '--edit-description' is incompatible with other options
  t3200: fix a misindented line
  t3200: restore branch after "unborn --edit-description" test
  branch: add '--show-description' option

 Documentation/git-branch.txt           |  6 +++++-
 builtin/branch.c                       | 39 +++++++++++++++++++++++++++++++---
 contrib/completion/git-completion.bash |  4 ++--
 t/t3200-branch.sh                      | 26 ++++++++++++++++++++++-
 4 files changed, 68 insertions(+), 7 deletions(-)

-- 
2.16.0.rc0.67.g3a46dbca7

