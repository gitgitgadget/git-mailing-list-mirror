Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18C2220248
	for <e@80x24.org>; Sun,  7 Apr 2019 19:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfDGTwh (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 15:52:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38448 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfDGTwh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 15:52:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so12402443wmc.3
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 12:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s1PJ7xjZwYNE7NdyQEvhNH6kqiv62uYpxOYV8PtA9U8=;
        b=NGqfhJqjnnI8HbUvwdIH/AkZUvzsfYq2RapMvjfXs2aZQBdLjhgcs1PbQEaNYYcLz0
         NhwTdmIWFzeyFyhArpwXOh3rRm7z9m8XfXhS0n1kS7iegrRxNBojA8Rmsg+R7wKQG1nP
         F+XXVh6A8uMO2mi5bPmRwtT7+qbu9i//hCqLCb93Xk6QZ7k9Ptigv/Of2o5cgbrpg/VP
         JNnXmsXzR22DS77SA73aIlq1uRIVaHXK5O+ZT4KjpdTsU7XC6rCKSBJYxUr2Z/rhJyvh
         nf4z9Hb47uUIdhr9ccBNJEqkpCncZYBJPBFa+r6UtZXuD4jSMvQhbJzhoZHhYVGfrIFH
         F4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s1PJ7xjZwYNE7NdyQEvhNH6kqiv62uYpxOYV8PtA9U8=;
        b=V3anwvxKZZ0mEpk8C/VzvX6ZNlUARyqAvPWMTlufr3CtasIE5zppgZzhkafO55rnJA
         fNF+sIEH+l4W0eBWZG9/KThr/WiGOdWCVL28g6UheguK95LwSueqlTTS0QyFfqHC0wuE
         0x/tm89jlIes1OlY4Xa0anDROoJ4GHTziqLMfZ73KIkz0lhSJentRKaSo1EKg1nTTGRY
         l3V1FD9fuOooMiRf8kqcltLINj8zskoFJ0s14F5/U6Eo/DA9dzHiRlvLwnamBjHH0EWt
         XCWa1yCBXWqKVZq3KGhz1sRa7xFWIJtwKVeiNH1GNnpQ0h82KXkf2Utp9pJagIjhy8T5
         +pYw==
X-Gm-Message-State: APjAAAUDMpqC1X1ZclVxz+lsMCj57G4a9Jw0NHPqYoA2GtU8tvRxcBYF
        e+lSxsuB2mIL4GPgTAcXYkExWiSo
X-Google-Smtp-Source: APXvYqwZTV+jJEB2onB2OMagSFmYsNKMvq48AlnDXlvyE6B32b3DE50boF8+Jb7Cfngkuqrld7eD9g==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr16232491wmi.57.1554666755603;
        Sun, 07 Apr 2019 12:52:35 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16sm41815402wrs.0.2019.04.07.12.52.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Apr 2019 12:52:34 -0700 (PDT)
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
        Johannes Sixt <j6t@kdbg.org>, Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 00/11] gc docs: modernize and fix the documentation
Date:   Sun,  7 Apr 2019 21:52:06 +0200
Message-Id: <20190407195217.3607-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e
In-Reply-To: <20190322093242.5508-5-avarab@gmail.com>
References: <20190322093242.5508-5-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4 fixes a misbalanced quote noted by Todd Zullinger in
<20190330180415.GC4047@pobox.com>, and makes this equivalent to the
post-squash version sitting in gitster/ab/gc-docs now.

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
 1:  a48ef8d5d8 =  1:  a48ef8d5d8 gc docs: modernize the advice for manually running "gc"
 2:  21e66a7903 =  2:  21e66a7903 gc docs: stop noting "repack" flags
 3:  c8a1342e34 =  3:  c8a1342e34 gc docs: clean grammar for "gc.bigPackThreshold"
 4:  9163e2f885 !  4:  f54ef80e69 gc docs: include the "gc.*" section from "config" in "gc"
    @@ -100,7 +100,7 @@
     -configuration variable, then all loose objects are combined into a
     -single pack.  Setting the value of `gc.auto`
     -to 0 disables automatic packing of loose objects.
    -+See the `gc.auto' option in the "CONFIGURATION" section below for how
    ++See the `gc.auto` option in the "CONFIGURATION" section below for how
     +this heuristic works.
      +
     -If the number of packs exceeds the value of `gc.autoPackLimit`,
 5:  8fa0e26671 =  5:  4ea4cf885a gc docs: re-flow the "gc.*" section in "config"
 6:  b70396f029 =  6:  ae5755278f gc docs: fix formatting for "gc.writeCommitGraph"
 7:  04ee81a3c9 =  7:  fc3bd0d5f4 gc docs: note how --aggressive impacts --window & --depth
 8:  04af0afbcf =  8:  7cff026e58 gc docs: downplay the usefulness of --aggressive
 9:  c35bc94416 =  9:  64617c43f6 gc docs: note "gc --aggressive" in "fast-import"
10:  702f2cd2d9 = 10:  84e5c669eb gc docs: clarify that "gc" doesn't throw away referenced objects
11:  08af3cc3ee = 11:  6a027d25a7 gc docs: remove incorrect reference to gc.auto=0
-- 
2.21.0.392.gf8f6787159e

