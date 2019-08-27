Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A280F1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 04:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfH0EFQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 00:05:16 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37781 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfH0EFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 00:05:16 -0400
Received: by mail-io1-f67.google.com with SMTP id q22so43031634iog.4
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 21:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XVN3uoweg9olm4lkkysRDVARDiy1wDmhHAGBz6iSCUo=;
        b=PMj9kDQkxDCR2MTxaNl0kmAbLUIk8eR1E0o9dlzO+x/PGfZiR0BeuKy4xRYlpkRWDM
         cjKSZ6e4wKFtSKCtfO+Ijbd0EjJvMvm4SZalQZj2pBUvRJV2cHiBi/YsWK29pVMkEAcu
         VjgGurrnN8ufBPbPi4HgVkl6LGEKjalFLR5pDTdef7DqDV5iXbjP5EVdYKZ5IPQa/0SL
         LaDqNX+uCv7qJIvM2VXU4QuhCrWVDRiHkZt3PhQbFmP4lfnJJB5wjQDenHrJt8CAm+ad
         bTqBP/5ZAPXFhL/GhIyc2rEKO/kqq+0BesOc4S0YvSOO+yqchQCgSc9udR7CgZYA5P8e
         h8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XVN3uoweg9olm4lkkysRDVARDiy1wDmhHAGBz6iSCUo=;
        b=cMRteLeCiO1Axf/qinlYuvLb+shaNDpdIcupRNPfZVrjQUAwFu20De8F2ImG4Gv+e+
         w0OYWK0bu1CfiufKQuhOKcnHbXf/IC9/a6Sfuy6IpcbulcXrjBKgu4HcKifE6sw58dIt
         05rbeoDDuvw2Ah75KTXuMx+H1Wtxy6GCSwYssBpXvoLGYSNPQpzo6lLTrOfnV4HcUyS7
         kbU42eDP/LY4SGIYeqjAkHyImVDZ8TI9nHsRAsJxPMXHamExFpUDy6vPYgwcsuvX+5YD
         4x3OIiBu2NNnc66NSs+3U0m423SjoXkAPQYu9uI2w6SsihzX73yMrrfDXWfARv9GjoJw
         IzkA==
X-Gm-Message-State: APjAAAWDFW8Eg/PS8teY63ZYg0PTLg9NE0aHs2CVgeurBLhut/atgNpX
        bXhbMG7Kn+wgZ4/zJZwxRmh84X79
X-Google-Smtp-Source: APXvYqwQPPvrkf/z0tqW+03jpNfh4SSvTyK+SMfAXVHx4neVxdP8z7D0gjfcIzd/bK9Z8u2rjC63tQ==
X-Received: by 2002:a5e:8b03:: with SMTP id g3mr3785329iok.170.1566878715046;
        Mon, 26 Aug 2019 21:05:15 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id p1sm9192865iol.11.2019.08.26.21.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 21:05:14 -0700 (PDT)
Date:   Tue, 27 Aug 2019 00:05:12 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2 10/13] t4014: remove confusing pipe in check_threading()
Message-ID: <8acc90f74d89301646f8120ebb79eb9170f64743.1566878374.git.liu.denton@gmail.com>
References: <cover.1566635008.git.liu.denton@gmail.com>
 <cover.1566878373.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566878373.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In check_threading(), there was a Git command in the upstream of a pipe.
In order to not lose its status code, it was saved into a file. However,
this may be confusing so rewrite to redirect IO to file. This allows us
to directly use the conventional &&-chain.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 18142ee5fa..67f4c62ed6 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -319,7 +319,7 @@ test_expect_success 'reroll count (-v)' '
 check_threading () {
 	expect="$1" &&
 	shift &&
-	(git format-patch --stdout "$@"; echo $? >status.out) |
+	git format-patch --stdout "$@" >patch &&
 	# Prints everything between the Message-ID and In-Reply-To,
 	# and replaces all Message-ID-lookalikes by a sequence number
 	perl -ne '
@@ -334,8 +334,7 @@ check_threading () {
 			print;
 		}
 		print "---\n" if /^From /i;
-	' >actual &&
-	test 0 = "$(cat status.out)" &&
+	' <patch >actual &&
 	test_cmp "$expect" actual
 }
 
-- 
2.23.0.248.g3a9dd8fb08

