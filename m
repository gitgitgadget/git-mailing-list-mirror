Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B0D420248
	for <e@80x24.org>; Mon, 18 Mar 2019 16:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfCRQPP (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 12:15:15 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:37027 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCRQPP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 12:15:15 -0400
Received: by mail-wr1-f44.google.com with SMTP id y15so17735886wro.4
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 09:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3P8Xr/VLYTHn8FykZdQac6ELSvXm0w6jZCs867vSKVU=;
        b=TNHFjKHrl/Ltb4g1Y6OKMF1LtMmBNfwdF4NAazrZq4hSk2TIrErxdJiuTGdwjg3THp
         wEqQkS1keOGshcPwRTWSQ94x2IKzjyajSEuOZ/roK9+DeL3cttwdh/30Y2/FA8++LM1h
         FGuAYC9TqiYuUw5dSel+jidERMBQKuE10iegLXPZo8C+3mtUDsavZJpAyDt2+FUgIJjd
         bDN3xqDW5nRWass4glKW/xSyPO+z0fQkHfRspOaEWlxSGJLrtFpN40Es0ibHVwUpoSIV
         fKuzCdNwp4YyymSx7F+LOUuIB0Dc+lKbsk/5KiOLN6o/zwHVYOcPaoGRZz++nNNM6dRG
         Brcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3P8Xr/VLYTHn8FykZdQac6ELSvXm0w6jZCs867vSKVU=;
        b=BheQ7ioGHlxPIsWxHSZk+CuyZkPsjMX1KfDl54z95grzKDz1ETZKcYBSuaBkLXkmHY
         QLksDrAqaJzgd06M38F8eQnwdAPfP3qy0f0iiGYNrXFPZA06eTCzCW24lYs+O8BjKwaF
         7chAhbGHsnAWyhWCu8qz0/bHcjK/4IdaUfjJmDFr5TRzpmfMX6tuq07TessRB4oQo9VH
         STjokQE9GqcRqRDvUDJ8LuePh5LMJsmqUinhKHhcWpareQfmm95QP4U5K0xw3bwAC8rV
         SZKrjenAs8jtPRHJft56v8PqxTuwD5Zrwc3tZ328Z7QsxWWvUrqWqlRgAltgqXtChYPY
         eeVA==
X-Gm-Message-State: APjAAAWhHiseZ/HTWrrE7Ll5BCExqymiBFTOv+sVoQzEkpPJ7xM3q/Kf
        6zQjK158fpNhjBr5Ej/9e6/SDKFGRmg=
X-Google-Smtp-Source: APXvYqyAOmlShEKb6xXzM2g7gZjiJub6jHfbAdsSenUGBXf5+C8pkKyue3uI/tIhgIkidmwj5BqoaQ==
X-Received: by 2002:a5d:6b46:: with SMTP id x6mr12016551wrw.94.1552925713188;
        Mon, 18 Mar 2019 09:15:13 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z9sm3269728wmf.12.2019.03.18.09.15.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 18 Mar 2019 09:15:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] gc docs: modernize and fix the documentation
Date:   Mon, 18 Mar 2019 17:14:58 +0100
Message-Id: <20190318161502.7979-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been annoyed by the "gc" docs for a while. This fixes most of the
issues I've noticed, and also removes the duplication between the "gc"
variables in git-config(1) and in git-gc(1), which was made possible
by Duy's Documentation/config/* series.

This should make the "gc" docs more awesome, and due to removing the
de-duplication results in a net deletion of lines. Yay.

The only thing I was on the fence about was removing the 'gc
"refs/remotes/*' config example, but I think the remaining docs
explain it well enough. It can be added back if someone insists...

Now, I was originally going to have 5 patches in this series by
modernizing the "NOTES" section, but that didn't make it in.

This series is unrelated (and does not conflict with) my in-flight gc
contention series
(https://public-inbox.org/git/20190315155959.12390-1-avarab@gmail.com/),
but the "git-gc" docs should be updated to discuss the
core.filesRefLockTimeout option and how it impacts contention, see 8/8
in that series for context. I.e. "you may have contention, but
core.filesRefLockTimeout can mitigate blah blah".

I was going to do that, but then thought that we should also mention
that on the server-side we mitigate most/all of the contention via the
quarantine, see "QUARANTINE ENVIRONMENT" in
git-receive-pack(1). I.e. we:

 1. Get the temp pack
 2. OK it (fsck, hooks etc.)
 3. Move *complete* previously temp packs over
 4. Update the refs

I.e. we are immune from the "concurrently with another process" race,
but of course something concurrently updating the "server" repo
without a quarantine environment may be subject to that race.

The only problem is that the last couple of paragraphs may be
wrong. That's just my understanding from a brief reading of
722ff7f876c ("receive-pack: quarantine objects until pre-receive
accepts", 2016-10-03) so I didn't want to include that in this
series. Peff (or others), any comments?

Ævar Arnfjörð Bjarmason (4):
  gc docs: modernize the advice for manually running "gc"
  gc docs: include the "gc.*" section from "config" in "gc"
  gc docs: de-duplicate "OPTIONS" and "CONFIGURATION"
  gc docs: downplay the usefulness of --aggressive

 Documentation/config/gc.txt |  39 ++++++++++--
 Documentation/git-gc.txt    | 120 +++++++++---------------------------
 2 files changed, 65 insertions(+), 94 deletions(-)

-- 
2.21.0.360.g471c308f928

