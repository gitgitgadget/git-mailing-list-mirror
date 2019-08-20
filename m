Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5D121F461
	for <e@80x24.org>; Tue, 20 Aug 2019 07:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfHTHTK (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 03:19:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46884 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfHTHTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 03:19:09 -0400
Received: by mail-io1-f68.google.com with SMTP id x4so10042756iog.13
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 00:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4h4w05uUwEB+bxojpeOS/miaWfaQstd4GM5/QPxaGfc=;
        b=ke74waLS5PrjyNo319pocdJudZG/LyHSUKHA+nW4dWFfixdMcYXgaWyzZImY7dBFNL
         2keyzYLeRhROKKYOFUqt+P0wAubsFsArASpHJy6w866boh237fFZAAw17gNH/kBc4CTu
         e+wEEFXYvymosIy/l06BD2p1avZj6k3L8iUUkIAW658YWhjMlaD36xL5DuKgL+OL7CNs
         LMxQDxcgdVoLQto4EZ+U0Avnu3Mtj3D3I64xcRsvVh9t2IEUmD0UU/QbSA3CCxaOt185
         i4FdB1LZZi+y7TxCqfGVrVllCffHOFLLmeh3hWQxwN722kxW+SGTOXDtmOyxG8K0DAg1
         +JyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4h4w05uUwEB+bxojpeOS/miaWfaQstd4GM5/QPxaGfc=;
        b=p6/H32USGNkiBoMtnFR4HV5G3XVv/lWhwlOJeIREoUVwtf83VM46Pb6CPuHJxGpCYY
         vvPhyaIkE3gsjuUo772UCYKzK2CG8o3Wy6zVm9byHuEu3Z2kUA7LXXRH2VSg7lHNrRgV
         kPnn+pU2QUSVIdfZyaa97MTqbGAmhMac62CIh8VxWF3dKl+Ip3CWnm+eOgEDrnQJTskT
         jUemjy19mt6fKxUIGZHyphCOXJx48etz+CNBKql7lYsEMMFndKNjINWE/kaWXDKYGsLl
         dfTymSO0O0rFKkast7xm/J+5+ESS+g0oqeuRF+9d/EfVhA6dJijStfID5L3TBLvtOjVG
         lcoA==
X-Gm-Message-State: APjAAAW7ln4ZTkw2lUHDe3T1QSMJrpZ6iQ8UuwLVrFCTSSrp3HyU6RjB
        o/qDFEvg++6AlpBltFfarjOvhv5i
X-Google-Smtp-Source: APXvYqzndLarWnyOwMzeBPz3weKkJPyKJi/Te7PKv6HMv5bjvFc8Cha+GAhWoMrVMUPJOP/TmE5Fkg==
X-Received: by 2002:a5e:d717:: with SMTP id v23mr30485832iom.52.1566285548477;
        Tue, 20 Aug 2019 00:19:08 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id m20sm15016045ioh.4.2019.08.20.00.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 00:19:08 -0700 (PDT)
Date:   Tue, 20 Aug 2019 03:19:06 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 09/13] t4014: remove confusing pipe in check_threading()
Message-ID: <dec5a62e82a70e52e46b946bb98332d14d80a76c.1566285151.git.liu.denton@gmail.com>
References: <cover.1566258525.git.liu.denton@gmail.com>
 <cover.1566285151.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566285151.git.liu.denton@gmail.com>
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
index 176af4b902..7f74948e2c 100755
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

