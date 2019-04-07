Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A702220248
	for <e@80x24.org>; Sun,  7 Apr 2019 19:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfDGTwv (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 15:52:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36956 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfDGTwt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 15:52:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so12389467wmf.2
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 12:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L+8KT0rRI3Y/uas5bEm2ecBWz03t+5nnF7RAFwHcIdA=;
        b=IjuOLe6AIGQXO1Y4LDL75YF/n/z837PoLfN+QNHwkLTNagA46H+SVVM5U5wveIGga2
         5HbcEFCZry4Rl0PZSSUGqqSADlU0xShNIVZ28tyWSNh2F4vGDXfVuR14i6xu+9NkTJEy
         zj459w0idqza209N2NHGsVkHiR3BFVcX33wuhVTjoxspsj+3Xo/s9/gxTunr8HniQ5bG
         lka6HUxqB52BBGHGoTnjgJd+izxlHAv+RkY9U1tJXroRasVPQs7L0KL6EjmdU/pTdFE+
         iIdUazxoEV7CAiax4Z9dLa7MaHyMRfpbHEQohOywOhVi2yOaro3/A15Ek98PAFKi3Roj
         QRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L+8KT0rRI3Y/uas5bEm2ecBWz03t+5nnF7RAFwHcIdA=;
        b=ggdK1ElY5DgMqoA3hD3uSlSvoptvGVSnmqm5KDqKDPsxodjlp5UxUHJi1tLFuar2r3
         4GWRRORNFfEG8d42afvKAdNrBe/LP/ryOHRtJXWdgNOD+85bMFVJ34KKFiXsqA8NziQN
         dGi1CnFcnjJANudVmVr7HsWlWokxamuhEpsOz4vx1LDgqsV9wTHY+NjTLKjxVrTyp656
         hN9Uackdxu6BOtW/7SbiwsvD/WjFjjHnJayQuqP5+XxauxPLKm+gN7BHCrBf1Q2UGEeN
         iQScUaJQ18O2xCA2HG3Tio1Q22Xbjq50l4bKsvUBs++VuRUyY1N5b+cfEA1N2kZ3Svpv
         acrQ==
X-Gm-Message-State: APjAAAXp+1QwPiRTeU8jf6qyaIx4gtPjnYmuT5e0AXeG1DvrDocxdli8
        ADwev1NVCMhtDN30OcGK0ko9YaG3RSg=
X-Google-Smtp-Source: APXvYqw0ecLobl/QNck5BpCOetHMB00USQ32EC+TUIEOguQdxclyvShzms9OJfbYoSUVeRv1YkXbzw==
X-Received: by 2002:a1c:dc43:: with SMTP id t64mr16023984wmg.19.1554666767617;
        Sun, 07 Apr 2019 12:52:47 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16sm41815402wrs.0.2019.04.07.12.52.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Apr 2019 12:52:46 -0700 (PDT)
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
Subject: [PATCH v4 09/11] gc docs: note "gc --aggressive" in "fast-import"
Date:   Sun,  7 Apr 2019 21:52:15 +0200
Message-Id: <20190407195217.3607-10-avarab@gmail.com>
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

Amend the "PACKFILE OPTIMIZATION" section in "fast-import" to explain
that simply running "git gc --aggressive" after a "fast-import" should
properly optimize the repository. This is simpler and more effective
than the existing "repack" advice (which I'm keeping as it helps
explain things) because it e.g. also packs the newly imported refs.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-fast-import.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 43ab3b1637..2248755cb7 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -1396,6 +1396,13 @@ deltas are suboptimal (see above) then also adding the `-f` option
 to force recomputation of all deltas can significantly reduce the
 final packfile size (30-50% smaller can be quite typical).
 
+Instead of running `git repack` you can also run `git gc
+--aggressive`, which will also optimize other things after an import
+(e.g. pack loose refs). As noted in the "AGGRESSIVE" section in
+linkgit:git-gc[1] the `--aggressive` option will find new deltas with
+the `-f` option to linkgit:git-repack[1]. For the reasons elaborated
+on above using `--aggressive` after a fast-import is one of the few
+cases where it's known to be worthwhile.
 
 MEMORY UTILIZATION
 ------------------
-- 
2.21.0.392.gf8f6787159e

