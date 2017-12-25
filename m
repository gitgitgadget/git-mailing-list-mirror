Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 758861F424
	for <e@80x24.org>; Mon, 25 Dec 2017 00:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750898AbdLYA2w (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 19:28:52 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:45994 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbdLYA2v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 19:28:51 -0500
Received: by mail-wr0-f176.google.com with SMTP id h1so32136803wre.12
        for <git@vger.kernel.org>; Sun, 24 Dec 2017 16:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DRAVlQZv3IzAqq+RgMJHq17d0eEZyPaFJlHOpNYxXc4=;
        b=JXUPhz/haICEigmMlLX1XZw49dFzz+huuIajsan+u06PP+bMBts7r3jmluyHezmQgP
         YoEqODLSnHc3qFu1MAAQZr5ZZZLmLmv9IWpysD3dDSKnZONwhqbMc0V7Z6E1TBVci4Fl
         PCTrX6npY1cNVFhzMP/8m88hl6KEWyp1/Xl4zXYzUUlwOdhUvYEuaVb4a6bP0D2K8o/q
         cLFjRZwE0sjA7i5WhT6CNXMcu9DzMw+Z3deSMmbND41dvlWX55eV2vcrvSntrKVNJNhX
         1LOXOehn3wSIBTeTxkqsCvPjV4tBndvWHlNoWxxT/KzLyMDg0Uy4ZMzGPcDWWot5MZ2T
         L1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DRAVlQZv3IzAqq+RgMJHq17d0eEZyPaFJlHOpNYxXc4=;
        b=V+Xh6X6gPS4S83ObNLNHFWPyQjU0/Xn9hPTJ/vTKfovoJt29vpqvfpwg70NwHY/YW1
         bG+BWQN3PrJ+NnArm8yDa4GNuBWVWJkq2XGBD62EBo0o7cxZTjXWG6KMBnWbsms4zC7I
         SPMTHxqwcQ/eop/z3mZgI/gkjCRgfme0XLgeBN7UP1ehR9R4/D0Ober0LqqUbwNklbt1
         SDUfqgT54Wk0gfVuIjO+fT/eWHRNjsRiEM84TnNHHW92XEebiBlqnDc8K3fTUJ91V5yR
         yOl2xViATTVDfb2FR7+PpecHuo6SRrXPm0rbF9HmAQvbJtnQM9G9VJpgH2QJP0J5ZpHi
         QTAw==
X-Gm-Message-State: AKGB3mKUpMY0tcfeP7hvTuUx6b8EkAc+JZZEPed+GI4KxDIWsEfuH5Gp
        LJez1tKQ0Gi/+F5n/vIVAmHD/PZq
X-Google-Smtp-Source: ACJfBos5fOfUksbxNOV7ArL8mniNFB5GbS1nymTR2y9xfAbptNC6Q6P24fv5Bty1o+gwQTKtyUI3/w==
X-Received: by 10.223.155.134 with SMTP id d6mr17148540wrc.174.1514161729880;
        Sun, 24 Dec 2017 16:28:49 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i65sm52923574wme.20.2017.12.24.16.28.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Dec 2017 16:28:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/7] increase wildmatch test coverage
Date:   Mon, 25 Dec 2017 00:28:28 +0000
Message-Id: <20171225002835.29005-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171223213012.1962-1-avarab@gmail.com>
References: <20171223213012.1962-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This v2 addresses comments by Johannes Sixt in
<8f4cdb23-8e2e-144a-1f70-99776b027166@kdbg.org> and there's osme other
cleanups as noted below.

Ævar Arnfjörð Bjarmason (7):
  wildmatch test: indent with tabs, not spaces
  wildmatch test: use more standard shell style

No changes.

  wildmatch test: don't try to vertically align our output

NEW: Don't try to do whitespace alignment in the tests.

  wildmatch test: use a paranoia pattern from nul_match()

Explain in the commit message why we're not using say '...'; exit 1. I
said I'd use this in <874logs7vi.fsf@evledraar.gmail.com>, but on
further consideration it's a bad idea.

  wildmatch test: remove dead fnmatch() test code
  wildmatch test: perform all tests under all wildmatch() modes

Just changes to rebase them on the changes above.

  wildmatch test: create & test files on disk in addition to in-memory

Avoid some forking by using a case statement instead of if .. grep &&
return.

Add comments to the code to clarify what it's doing.

Factoro out the repetitive part of the tests into functions, making
the patch shorter.

I didn't change the "rm -rf -- *" pattern Johannes was concerned
about, because after looking at it it would be a pain to create
some-test-subdir/ and only if some-test-subdir/$our_file gets created
cd to it and then remove it afterwards, it's much easier not to change
the directory. The test test_when_finished always runs in the
directory the tests executed in, so I don't see how this is dangerous
in practice.

I didn't move the "printf" pattern to here-docs as discussed in the
thread.

 t/helper/test-wildmatch.c |   2 +
 t/t3070-wildmatch.sh      | 759 +++++++++++++++++++++++++++++++---------------
 2 files changed, 516 insertions(+), 245 deletions(-)

-- 
2.15.1.424.g9478a66081

