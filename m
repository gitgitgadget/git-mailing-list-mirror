Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7148E208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 12:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733305AbeHGPFb (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 11:05:31 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:45701 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeHGPFb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 11:05:31 -0400
Received: by mail-ua0-f202.google.com with SMTP id x17-v6so11246953uap.12
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 05:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CHOuwqRFreOf3UqzDjfj/eLHnUJzOEHchbUJdtJSgy4=;
        b=XjAeWfV8YaYvkeomJWsSYw3ZlMnhP0msqlnNUym0O3PDzUMC5H0X4GuP8r9861NGKf
         1aAhyllidDcpITe/deBW0yVbOccWGI74oL9R7Lmh74oHj4MWon3U+1LDNEttWibQ2P2P
         S4iVDCGyaiNRIOqnfzf3NQlzE1qrB9vrfEAaf846WOrXGI+ZkBUgMr0WjuUVUY4GAxOI
         o3Zu/Sl+TqDnXCzwl4wNWxlHhR8SPdjpdkoQD3RLoish9Sx5WU8crls74PL8aGJZ/1mf
         TW5AufRXuIMtSM3t3qeKCp3Tk9kMw3SewBY+2cTTlEVM/2AQg6xwdS0DiJGnHE7iD3SZ
         u7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CHOuwqRFreOf3UqzDjfj/eLHnUJzOEHchbUJdtJSgy4=;
        b=D6KNUHcx9cvY+1GL8CNPzHX+2FxqKb72mAGmC5nhkWqynzsV2Wfn6XE2TeXzmLSir0
         qENFIUOBe1/oha/nY3maDhd+zVHT+5Hcy8Aqe3hvdWPtnWA8mTdkDQMZyTjlvTU+2h7H
         8z+sNyoLX4/LS6px6Tf3WtYcTjq40/7KXx7ETm+dxbRirkBTlLWO5RB+KrTpdI3S3Yrg
         QAdn3Inh2XJXHjKlktQOXCugkCXFifk8pxj8mWJiILJE18fy+s73s5rmg0I1/dMMf8Zg
         vsFqE9vuMVWubfmAwOHlZFUv54ScT1rFyzk3M/+lp5ea3XKwrYD/0RSn6aKShpm8OQLl
         55WA==
X-Gm-Message-State: AOUpUlFj1R9nC4K30JkPK1ZfXOGH0JZ4sxzJduo/ua/SBc84XpI4b1xt
        vcxl6j8JA4gOT6WaIRq5B7NyK3Gb35E=
X-Google-Smtp-Source: AAOMgpeF6LtCQI4800aSRDXUnHlK5J3xgMXNpeRWsilyIFAhKH0ifQEhNRyn8izkgzqFNT+BZhSr/HWREys=
X-Received: by 2002:a1f:1c3:: with SMTP id 186-v6mr11604613vkb.59.1533646279678;
 Tue, 07 Aug 2018 05:51:19 -0700 (PDT)
Date:   Tue,  7 Aug 2018 14:51:07 +0200
Message-Id: <20180807125108.104293-1-hanwen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH v7 0/1]   sideband: highlight keywords in remote sideband output
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     gitster@pobox.com, sunshine@sunshineco.com, jrn@google.com
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix nits; remove debug printf.

Han-Wen Nienhuys (1):
  sideband: highlight keywords in remote sideband output

 Documentation/config.txt            |  12 +++
 help.c                              |   1 +
 help.h                              |   1 +
 sideband.c                          | 125 ++++++++++++++++++++++++++--
 t/t5409-colorize-remote-messages.sh |  87 +++++++++++++++++++
 5 files changed, 217 insertions(+), 9 deletions(-)
 create mode 100755 t/t5409-colorize-remote-messages.sh

--
2.18.0.597.ga71716f1ad-goog
