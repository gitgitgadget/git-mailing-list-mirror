Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0B9C20248
	for <e@80x24.org>; Fri, 22 Mar 2019 09:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfCVJdB (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 05:33:01 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:38319 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfCVJdB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 05:33:01 -0400
Received: by mail-wr1-f51.google.com with SMTP id g12so1537955wrm.5
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 02:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+kJvini9wuBtfe6Jf4KGTt8mOhW8xRN8yY1J4ZMMCHM=;
        b=WfBd3ljQKmMEYmV6QpnxZo+sTEl2L3qbZawtt8baD1N9S4aRduCgvxJnYkozhauoPn
         M6T54diy3IybJ/5VpFjO0EwO0cQ7wC+izY1nR9ghzMrE6wIYwb1DQmiiDamlvA72Bw0a
         9j/zmAxAldrZavuNNhVwUpp7RGhBmBQYRonuC61KUBk79hPrDbArp+SiV8d84OTHojYG
         oz/rWySUNGnCn8w+1+e+/NWVZ4EL7SQlTQFFeM/g38Vm10XwHwh59PRRmKEI/OUp/022
         DKFa/4kNx3CgfrmrMPt5vzNAYQN5BoDNumDga9jW+iJgZIMwLpseTpT/mCl9XZws99zy
         etMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+kJvini9wuBtfe6Jf4KGTt8mOhW8xRN8yY1J4ZMMCHM=;
        b=UXOQRutcx0JwA4sr2WerMd4f0pPz0N7fOHn50ukkHYqdQsgojEGdvNXtIvJAm9MQ9q
         +8vzWAhkPZdFS4NqqX0j5n4s8J4eEret6VLHON1aCgfY3Causcc7yLVrm/DJZAWJGR14
         UPCxHF2SA3qDr1Q2zvxfJBCp/KsVeOiyLK/GaasYHqCSy9j9zgcIcRicUrzHSDStgvp/
         VSrqY2TS8LSfPLJiwlO34KfTbG+uXexfbaVrPdICs1d5Lh6N5WlRMjHNlrTWvcoC2VAm
         fN5NH4BX53ZkUb7sjyTeYT0AMmmicTXDlZge8NJrDSD53QkGbDNIkNzs5mnhfWGlTHDH
         iS+g==
X-Gm-Message-State: APjAAAXta6T978kizV2dtoFEJ5OVQRIkXs5J69pMlNT1HnAG0mwpYlaX
        +wThHEfNsaBsJg3VmyX6zbs4tICSlR4=
X-Google-Smtp-Source: APXvYqzjEpukGKYtiSa2dkpz5xOONgYTbdAMHhbbovChMWe/ThVRtjEbKYs3nJZfuqoUmS1FUuVgkQ==
X-Received: by 2002:a5d:6b4a:: with SMTP id x10mr5554111wrw.63.1553247179138;
        Fri, 22 Mar 2019 02:32:59 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y197sm3521447wmd.34.2019.03.22.02.32.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 02:32:58 -0700 (PDT)
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
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/11] gc docs: modernize the advice for manually running "gc"
Date:   Fri, 22 Mar 2019 10:32:31 +0100
Message-Id: <20190322093242.5508-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190321205054.17109-1-avarab@gmail.com>
References: <20190321205054.17109-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patch v3 fixes a minor grammar issue noted by Junio in
<xmqqtvfvphv6.fsf@gitster-ct.c.googlers.com>, and another "while I'm
at it" formatting error.

Ævar Arnfjörð Bjarmason (11):
  gc docs: modernize the advice for manually running "gc"
  gc docs: stop noting "repack" flags
  gc docs: clean grammar for "gc.bigPackThreshold"
  gc docs: include the "gc.*" section from "config" in "gc"
  gc docs: re-flow the "gc.*" section in "config"
  gc docs: fix formatting for "gc.writeCommitGraph"
  gc docs: note how --aggressive impacts --window & --depth
  gc docs: downplay the usefulness of --aggressive
  gc docs: note "gc --aggressive" in "fast-import"
  gc docs: clarify that "gc" doesn't throw away referenced objects
  gc docs: remove incorrect reference to gc.auto=0

 Documentation/config/gc.txt       |  38 ++++++--
 Documentation/git-fast-import.txt |   7 ++
 Documentation/git-gc.txt          | 142 ++++++++++--------------------
 3 files changed, 86 insertions(+), 101 deletions(-)

Range-diff:
 1:  89719142c7 !  1:  a48ef8d5d8 gc docs: modernize the advice for manually running "gc"
    @@ -35,7 +35,7 @@
     -----------------------
     -$ git config --global gc.auto 0
     -----------------------
    -+When common porcelain operations that creates objects are run, they
    ++When common porcelain operations that create objects are run, they
     +will check whether the repository has grown substantially since the
     +last maintenance, and if so run `git gc` automatically. See `gc.auto`
     +below for how to disable this behavior.
 2:  d90a5b1b4c =  2:  21e66a7903 gc docs: stop noting "repack" flags
 3:  fedd9bb886 =  3:  c8a1342e34 gc docs: clean grammar for "gc.bigPackThreshold"
 4:  6fad05a67c =  4:  9163e2f885 gc docs: include the "gc.*" section from "config" in "gc"
 5:  994e22a0d6 =  5:  8fa0e26671 gc docs: re-flow the "gc.*" section in "config"
 -:  ---------- >  6:  b70396f029 gc docs: fix formatting for "gc.writeCommitGraph"
 6:  916433ef73 =  7:  04ee81a3c9 gc docs: note how --aggressive impacts --window & --depth
 7:  457357b464 =  8:  04af0afbcf gc docs: downplay the usefulness of --aggressive
 8:  d80a6021f5 =  9:  c35bc94416 gc docs: note "gc --aggressive" in "fast-import"
 9:  a5d31faf6f = 10:  702f2cd2d9 gc docs: clarify that "gc" doesn't throw away referenced objects
10:  9fd1203ad5 = 11:  08af3cc3ee gc docs: remove incorrect reference to gc.auto=0
-- 
2.21.0.360.g471c308f928

