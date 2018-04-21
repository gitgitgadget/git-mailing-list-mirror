Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A6071F404
	for <e@80x24.org>; Sat, 21 Apr 2018 03:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeDUDpb (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 23:45:31 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:38279 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeDUDpa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 23:45:30 -0400
Received: by mail-pf0-f171.google.com with SMTP id o76so379048pfi.5
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 20:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=T6TngJwDPqn7VtXBdHLhy3iavGvTvcKFrnHvgLTYtd0=;
        b=qI+SaS4ncksLmq9bR/tBuCpMAUpIdv8tdJrpgoyAa0GCkkjt8o/EDxoNjabYt5udRk
         k3Hp9BngUUJEhrRWrUduVPxOqn3tLRVta7od+Xomq726mZue1mWiZaRq0s1lkD7d74Sl
         BrxlxOiegy4+2ulVGWyNPnTdwpQgqnvrtIEmjFjbbQeo1wQHB+JTW4gqd72eyWMqBTxV
         RxRCNzOtN3uiV4Llz0HK0Lv+ccS5Xv/wwxFAjPKAnxqZPeitre6gScNP/RqKDqDlNjLR
         1tqbcrGEg+nkWkRp1qqQuUgjNjJr1+7bGHFDJkvKJ0W+S+w+VAyqn87qhHocFp4+ECdw
         cCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=T6TngJwDPqn7VtXBdHLhy3iavGvTvcKFrnHvgLTYtd0=;
        b=FGIRifCnq8JmWuyEyoMPDsy4PaGuPEiSYaObLu1FsVuDE4LPItCsFdeASgTz36zISP
         s2kgw6CMKJPKuGKhDAzm4O9an8PAYgBUxCFmPz25yufO8LYfCB3SDGILz6PB+fVNDpop
         VKzWsBFt6z1x+8ndVO7n4Bfi9h5G2Zmh9JWHb6dweQNyUdLrKtKswOWorXpqHBxECo3r
         /mF3Tdcn3lr1n3lxh+COwl/9Z94Nk7JBBhXzuZNHEhAOdt9FdwWcBuedHP8NZi2TdVkp
         ok3R0FudLmPT5SdMVFB1O+4p8WCCJi8eKlalfUCZN78mAngxOubQURFLQyGzF0duLd3f
         wpuQ==
X-Gm-Message-State: ALQs6tDMr1m64r9ajyG6EkIt3fIrRVeP/iSXDboiFaDsecqXx1XrwUFu
        pbriGJZj/m2yCBgdJ5RYeQH+LDoBdIA=
X-Google-Smtp-Source: AIpwx4/HNlh/N5JBClE/REEdwnoyN1aMH1YR7GLId3H6IsKZZLRW1X/nI6b7YgCTorqypEd9U9RxJQ==
X-Received: by 10.99.42.137 with SMTP id q131mr10218570pgq.379.1524282329077;
        Fri, 20 Apr 2018 20:45:29 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:ddb8:3db2:8ad2:955])
        by smtp.gmail.com with ESMTPSA id d77sm17849366pfe.127.2018.04.20.20.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Apr 2018 20:45:27 -0700 (PDT)
Date:   Fri, 20 Apr 2018 20:45:26 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, peff@peff.net
Subject: [PATCH 0/6] Teach '--column-number' to 'git-grep(1)'
Message-ID: <20180421034526.GA24606@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is a series to add --column-number to 'git-grep(1)', and
support jumping to the correct column when using Peff's 'git-jump'.

I have chosen -m as the short form of --column-number, because -c was
taken, and -m is close to -n (the short form of --line-number).

The description in each patch is extensive, and can serve as a reference
during review. Thank you in advance for your time, and--as always--I
look forward to your feedback :-).


Thanks,
Taylor

Taylor Blau (6):
  grep.c: take regmatch_t as argument in match_line()
  grep.c: take column number as argument to show_line()
  grep.[ch]: teach columnnum, color_columnno to grep_opt
  grep.c: display column number of first match
  builtin/grep.c: show column numbers via --column-number
  contrib/git-jump/git-jump: use column number when grep-ing

 Documentation/config.txt   |  5 +++++
 Documentation/git-grep.txt |  9 ++++++++-
 builtin/grep.c             |  1 +
 contrib/git-jump/git-jump  |  2 +-
 grep.c                     | 33 ++++++++++++++++++++++++---------
 grep.h                     |  2 ++
 t/t7810-grep.sh            | 22 ++++++++++++++++++++++
 7 files changed, 63 insertions(+), 11 deletions(-)

--
2.17.0
