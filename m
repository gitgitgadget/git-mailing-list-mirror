Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA0FD1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 11:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfGALdK (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 07:33:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54109 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfGALdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 07:33:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so15482321wmj.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 04:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sQz8Ie5rRk2iJSiJl/EI/27sLvJCvqB5tRCnR4OEvF8=;
        b=SihauTZpJuZZEnmXLMyc4CPNnJ2pJa1Mi9wr6nKhiN0qmJpelEIY9MmfQzvceatUAU
         kpOhqqXOKgTLymer7IcPvZJMOi/fSijAX86CdS1a2yA/WUuJGueL5yVdXimT51NlnRUz
         tvAFp04C2Y5C7kYCDkiIBsOpqO0u2tnLjS7d9V8WH6THJx3/t8AG63ATZapHc1BBGW++
         mZw3dU4dK6saeIxrq3y7z9yfW3zFKJj1AbyVQ++wga4saXF01hRDpZWPg6ACIhL/yxxO
         QR0GF5426ReFJA6/hZBGa6dyWdJUuifeH9f5Ql8giLZkfq4imOWvwAjtkVRp6Q4vY+D8
         NGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sQz8Ie5rRk2iJSiJl/EI/27sLvJCvqB5tRCnR4OEvF8=;
        b=GDx5NzmsaUZaHz3dL+aRm2GtlTg0yMenhhe6wsDPOmty7f8gJ60kWcZEShMrN3yHUV
         +gIFoXQoxfkkUBfn/DprB/VFCOMFn46wcvLHBnSSpEmq07cIDqRoxm8aEkbGNfZTZaE0
         e4k2xJKU95wX8KPtbJnp0MYx3kvflIueYkjOWpT3ZrkTJrj+TC+jPgpnS0bYeJd+FU1/
         lrFGgcAYYW8aroLbbJTcaKx5QX1jtmQMa1W/ygj4avIqZxeHr2Vw/cT4HY7CPitSpwsL
         vc8mLGIHQLKYKzuH7of/p7enCiWVpsGv6WWbqzydZZ9cPLqcEVefd6QOu/BD+d8esKX3
         RnnA==
X-Gm-Message-State: APjAAAXQ6PoA9R4rZ6IOIpR1GKtOx6CsTXu1T8vfHRGWBbQc6GmLwMPq
        3pXNuLhdQzPfKUB4PVnhpDU=
X-Google-Smtp-Source: APXvYqz0HkLgFYu4HRs2E18WBNwrPkVTVTnLOLJnowyX4EPxnDBjK2+FBVxTBVb1cNyiBI1vds5+Ow==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr15637043wma.123.1561980787224;
        Mon, 01 Jul 2019 04:33:07 -0700 (PDT)
Received: from szeder.dev (x4db347f2.dyn.telefonica.de. [77.179.71.242])
        by smtp.gmail.com with ESMTPSA id x3sm10302725wrp.78.2019.07.01.04.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 04:33:05 -0700 (PDT)
Date:   Mon, 1 Jul 2019 13:33:04 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5319: don't trip over a user name with whitespace
Message-ID: <20190701113304.GK21574@szeder.dev>
References: <pull.261.git.gitgitgadget@gmail.com>
 <d4a3f56b-5eaa-1325-f8c1-be6797a9ac03@kdbg.org>
 <CAPig+cRpOHRgtCXXiqAZtmEtkWnMy7=4GsTVv0XB9R3fF0-66A@mail.gmail.com>
 <1a5bb5f9-e090-7f42-ec3f-cd74bcad831f@kdbg.org>
 <20190630222537.GA21696@sigill.intra.peff.net>
 <3e5c0286-7514-9e00-fbc5-5b0ad9403d30@kdbg.org>
 <20190701091602.GA24791@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190701091602.GA24791@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 01, 2019 at 05:16:02AM -0400, Jeff King wrote:
> I see Gábor suggested using "wc -c" elsewhere in the thread. That would
> be fine with me, too, though I think the required sed there may be
> getting pretty unreadable, too. :)

It could be done even without 'sed', though at the expense of running
a coupe more 'wc -c's in a loop:

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 79bfaeafa9..bacec5e2e4 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -443,7 +443,12 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
 		touch -m -t 201901010002 .git/objects/pack/pack-B* &&
 		touch -m -t 201901010003 .git/objects/pack/pack-A* &&
 		ls .git/objects/pack >expect &&
-		MINSIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 1) &&
+		MINSIZE=$(
+			for pack in .git/objects/pack/*pack
+			do
+				wc -c <"$pack"
+			done | sort -n | head -n 1
+		) &&
 		git multi-pack-index repack --batch-size=$MINSIZE &&
 		ls .git/objects/pack >actual &&
 		test_cmp expect actual
@@ -455,7 +460,12 @@ test_expect_success 'repack creates a new pack' '
 		cd dup &&
 		ls .git/objects/pack/*idx >idx-list &&
 		test_line_count = 5 idx-list &&
-		THIRD_SMALLEST_SIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 3 | tail -n 1) &&
+		THIRD_SMALLEST_SIZE=$(
+			for pack in .git/objects/pack/*pack
+			do
+				wc -c <"$pack"
+			done | sort -n | head -n 3 | tail -n 1
+		) &&
 		BATCH_SIZE=$(($THIRD_SMALLEST_SIZE + 1)) &&
 		git multi-pack-index repack --batch-size=$BATCH_SIZE &&
 		ls .git/objects/pack/*idx >idx-list &&

Is it really better?  Dunno, but at least there is no subtlety with
the leading padding spaces.

