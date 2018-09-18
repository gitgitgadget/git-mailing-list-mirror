Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D4AB1F404
	for <e@80x24.org>; Tue, 18 Sep 2018 05:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeIRLF6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 07:05:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42904 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeIRLF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 07:05:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id v17-v6so577091wrr.9
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 22:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BNo0YnOOeHnruiTqITTO5389OudUu66qwtnEAxkCPEc=;
        b=urPlLGSbqEpd2PtrntQ07xjp5xqx//wv+I99VcLg0ol5KVPjR4aqen2NTJmvJtdfQy
         YYr/l+sBfLZMD/h79k0JYZLKMMXAViVv2RNQWWf/+WXi7ogn+CO+/e5bTIkWgNNhlAaY
         00+j0QfmsXdKlTY8YLviCNgmSwwLygs5k1vIiozfz2muc8BufCNOJ3az/colW2GZ3K0u
         4u0yF0RH8nHCuJlCgl/gkHB67mzLQsLj1rQGYoL6MWGPn1DNJYK9AOnnYmEDeLkjaFpn
         TxBbbdumY4Z26Di5Mbne7huCDdGbrFsn3lhKOmx0Xb8lOjaHTuIDcYYO3C6UWhOksmmW
         bNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BNo0YnOOeHnruiTqITTO5389OudUu66qwtnEAxkCPEc=;
        b=HpYm2Il/HhWL6U81xM2akoQGHTbHpypMM4Fc3xhzMXwJUjDOf/c81Il3ep5Vsp37VD
         ES4JhCr1bbZL47JIW//03sXBb4TCmIn90X1hGILD40Lc75thkq5VwrH09JfveePBt1y9
         qcbBsQmYvSECLacaS2oZr8yPiupPM2RnqmruTJ+lPNWysx1N3dIrnl+N4bS1wxQJeSyz
         vZ2e0l/PV0D51S/V06XLv8hJCR4pKRp0JpvaOdZWDb/ZrRx7tcbdH5wCTH2DwJEg9NoD
         aoMiU73BVKTPEor52eCJQ+PlduJCJTT59xCY+ChxChdcYMs/No3OO8x3cGnK+JEQxvt2
         4g8w==
X-Gm-Message-State: APzg51CY5a+xw0ruu2gUGptOQQPysTESoPChiTsG372uGlQGcTrzTRZZ
        EDXT+s4bBNnznjDNwaLoCozcB+fgx/0=
X-Google-Smtp-Source: ANB0Vda4PnJ9i06E0mNlNHc9I6/jzT5maU6hJSz7i/QFVM/PMlY2/P0KJnp8Q6xpWnsD1c7hd070kw==
X-Received: by 2002:adf:ae5a:: with SMTP id u26-v6mr22598341wrd.246.1537248900432;
        Mon, 17 Sep 2018 22:35:00 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id u127-v6sm1021943wmf.48.2018.09.17.22.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 22:34:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] config doc: add missing list separator for checkout.optimizeNewBranch
Date:   Tue, 18 Sep 2018 05:34:49 +0000
Message-Id: <20180918053449.14047-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a
In-Reply-To: <20180816182653.15580-1-benpeart@microsoft.com>
References: <20180816182653.15580-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation added in fa655d8411 ("checkout: optimize "git
checkout -b <new_branch>"", 2018-08-16) didn't add the double-colon
needed for the labeled list separator, as a result the added
documentation all got squashed into one paragraph. Fix that by adding
the list separator.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Junio: Feel free to squash this in, but per your recent E-Mail it
doesn't seem you're planning to rewind "next", so this can go on top
of gitster/bp/checkout-new-branch-optim.

 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ac71ade256..1546833213 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1153,7 +1153,7 @@ and by linkgit:git-worktree[1] when 'git worktree add' refers to a
 remote branch. This setting might be used for other checkout-like
 commands or functionality in the future.
 
-checkout.optimizeNewBranch
+checkout.optimizeNewBranch::
 	Optimizes the performance of "git checkout -b <new_branch>" when
 	using sparse-checkout.  When set to true, git will not update the
 	repo based on the current sparse-checkout settings.  This means it
-- 
2.19.0.rc2.392.g5ba43deb5a

