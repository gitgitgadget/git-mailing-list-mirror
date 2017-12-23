Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21B7F1F404
	for <e@80x24.org>; Sat, 23 Dec 2017 21:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752828AbdLWVa0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 16:30:26 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36327 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbdLWVaY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 16:30:24 -0500
Received: by mail-wm0-f46.google.com with SMTP id b76so27294906wmg.1
        for <git@vger.kernel.org>; Sat, 23 Dec 2017 13:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zwgB1sJl1gDLIFm25CWA/fBUeEAENov1cpWiF+mOF6A=;
        b=YHuxaKCWVMUFZBruery5pCrpnKJy3/NZu5d22ycQM65nk5d12Ct0qF2itDGhrnR/mU
         HbX89MtcFrWCtacz06FDR0OtBRP0YzUQ922OB7WLuHEle/XxhSTS1bPzyuLiTr6CiFA6
         uwyhFh159RMVFDz4xyO9Lvd/v6oF3tv+gEA7jF6VxYkXwzyOknIJ6EivTpLUZWYhUGnF
         IfkAm9qdwDqKb4CEC9QPGcAfbi7A87m9YHIlf4AwpRB9B6BNWQj0k8MCmq0FNk1gLqGq
         A4FL2VPjZbl1lCE3MKBIPk8nE+/AXYpEReKossNDwdqeZJ5faHlJz3vmIi9KibHSbyF6
         s69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zwgB1sJl1gDLIFm25CWA/fBUeEAENov1cpWiF+mOF6A=;
        b=C+jPcLRxH2MNfOOAz/9S+rle0J9PMqNeMdE0/C/uU4sPhwsALL38ZZcOIB2zWYjYOj
         IStLwnmysGnulXuDSAtSUFfjp/rtwxaFNJDPlbni9KfLM9XaX148lIXhbKrInKg5rgz6
         bWJ3ubPyEv6dpLLt4Msdoo3A1I6g8AQZ+6epLubFTgkVjB0T00zs5UugV+JOCD22UQno
         6o97k8CBGPCgoNPya7S2EG08KAVMk2ElP3fJ0yOkHZ1fa988hNi2rQeLeImmzmYCL6H8
         ricF052eAirVum6dpQOvb/3Ia5Gu2NXoEpNuiLM9xheJVO3sLtgrVwDfXpuMIzH7318U
         HlFw==
X-Gm-Message-State: AKGB3mIdhEQDt9nJpbRJUaEBwPcAbz0pSIHOx6Eul11Dm/LWD1GA4UsZ
        2Q4w3fELgDRcS3QsGo7npLAp3vuT
X-Google-Smtp-Source: ACJfBosU/R/0mJBujWgm+xw62msgUpsUDetnkXx4X2kTQyj3cewK11qw5SEk1bzs2EHCRkbEI3yuSQ==
X-Received: by 10.28.54.207 with SMTP id y76mr17075441wmh.94.1514064623101;
        Sat, 23 Dec 2017 13:30:23 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c2sm29074950wrc.81.2017.12.23.13.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Dec 2017 13:30:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] increase wildmatch test coverage
Date:   Sat, 23 Dec 2017 21:30:06 +0000
Message-Id: <20171223213012.1962-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This increases the test coverage we have for wildmatch, and hopefully
doesn't break anything, but see the fantastic hack that is 6/6 and
form your own opinion.

The backstory of this is that back in June I posted an RFC series here
to the list to refactor wildmatch() itself to no-op support
precompiling patterns:
https://public-inbox.org/git/20170622213810.14785-1-avarab@gmail.com/

The intent was to swap out wildmatch() to use PCRE as an engine, my
performance tests reveal that that was probably a dumb idea.

We may still want something like those patches I submitted back in
June, in particular we could rewrite wildmatch.c itself to precompile
a pattern. if this makes it in I'll see about rebasing those on top,
but I'm not in any rush with those.

But in writing up those initial patches (and some "use PCRE for this")
that hasn't made it on the list, I discovered that I didn't have any
faith in our wildmatch tests, it was easy to find case I could break
and all tests would still pass.

This series fixes that, whatever we do with wildmatch in the future
it'll be really nice to have this, since we now have exhaustive test
coverage of wildmatch, both through the raw function as before (but as
5/6 there were holes in that), and more importantly by doing the same
tests through ls-files, which is the interface users actually use, and
as 6/6 reveals sometimes behaves differently than the underlying
matching function.

Ævar Arnfjörð Bjarmason (6):
  wildmatch test: indent with tabs, not spaces
  wildmatch test: use more standard shell style
  wildmatch test: use a paranoia pattern from nul_match()
  wildmatch test: remove dead fnmatch() test code
  wildmatch test: perform all tests under all wildmatch() modes
  wildmatch test: create & test files on disk in addition to in-memory

 a[]b                      |   0
 t/helper/test-wildmatch.c |   2 +
 t/t3070-wildmatch.sh      | 802 ++++++++++++++++++++++++++++++++--------------
 3 files changed, 558 insertions(+), 246 deletions(-)
 create mode 100644 a[]b

-- 
2.15.1.424.g9478a66081

