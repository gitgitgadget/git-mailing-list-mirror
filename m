Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4E461F463
	for <e@80x24.org>; Wed, 25 Sep 2019 08:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442637AbfIYIUy (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 04:20:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44132 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442604AbfIYIUy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 04:20:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so2920447pfn.11
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 01:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GtQhtCXxCKQtvXldK676Wvm7h6mCpMwmzuIG4Fr/RN4=;
        b=RhPji3gHNmAsnprmZCiWPQCrOHsijuq8j+SZ7SvRWZAuVZLwI1+NCJTLufBU2uRYoi
         6f05nXndohVaBzRHkByE7OxtHU4o3hhPkP31zONI0MJ1upckiomNiTnZNxgzkkBX4Hp6
         i8W/h4GTkXxjVu6ma89nsBMiQiwAa0Qs7PrmJULZpGYL0Wnm5vD9mtlGWVs3qmd7s8eI
         sLG4B0SMIZTTUZcdU4FvhJTSwHakAAj2S0oTM4JDgMT7PLTmSJ+lc7vpEbpUQaoWB/bX
         htrn9+RbBYXkBId0V/uqkng7ujpxCe4ImleNgLpEsUuhr6BdDIMfqER7Kho4IQeY1bL1
         FQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GtQhtCXxCKQtvXldK676Wvm7h6mCpMwmzuIG4Fr/RN4=;
        b=N3KAhrrsmAscIBm71QSs7egr8ssnMK2+jL9s/GvXbBCrkaFE2DopE4PIgAb4HCzahn
         SfzDxQPIExQ2zDQJ/scdwliTBgl+/3imzpw+4X6XwjoHhUl3ZtDoiUJ+vx5Rf7dVCW7P
         FdTDHImc697uew+L7K9ui1LS6ZyPP5l38Miryfoc474wn/tICwDOGeNA6RNJSwg2+mRa
         bYtLEZh4mhs2TVgumkYz36uV17Kee9R3M6tzEiytMYOTmTqdLG4Y5nZqIM6acVwIV1xc
         g/Qe23107Q/OxuSOICZjT0SMZAY4BvvLa3kPWIeHrHVD+lhix1W7Y4YcpqgJnb/ypcA5
         tlSA==
X-Gm-Message-State: APjAAAU09btlMO5cXZO6OebnpHLEpwIji33BqQF3wAvvacVAYv+OPc7k
        i7x60D/1wVVIEJYWpmvr0IuwDD/9
X-Google-Smtp-Source: APXvYqywtcKP0RCVg+7qDnPQqxd0IVNGymCh8703ObfWDgbdQZk2jFCgFPrLal/cq7cSgeBxMWts1w==
X-Received: by 2002:a63:1c4b:: with SMTP id c11mr7597653pgm.216.1569399653285;
        Wed, 25 Sep 2019 01:20:53 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id p190sm8309134pfb.160.2019.09.25.01.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 01:20:52 -0700 (PDT)
Date:   Wed, 25 Sep 2019 01:20:49 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 0/4] fixes related to `make hdr-check`
Message-ID: <cover.1569398897.git.liu.denton@gmail.com>
References: <cover.1569263631.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1569263631.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first two patches fix errors causing `make hdr-check` to fail. The third is
legacy from v1 but provides code cleanup so we leave it. Finally, the last
patch is a patch which improves the portability and correctness of `hdr-check`.

Changes since v1:

* Reordered patches to put fixes first

* Took Peff's improvement suggestions for the $(HCO) target

* Added "pack-bitmap.h: fix unused variable warning"


Denton Liu (4):
  apply.h: include missing header
  promisor-remote.h: include missing header
  pack-bitmap.h: remove magic number
  Makefile: emulate compile in $(HCO) target better

 .gitignore        |  1 +
 Makefile          | 12 +++++++++---
 apply.h           |  1 +
 pack-bitmap.h     |  6 +++---
 promisor-remote.h |  2 ++
 5 files changed, 16 insertions(+), 6 deletions(-)

Range-diff against v1:
1:  0336d1345a < -:  ---------- Makefile: use $(ALL_CFLAGS) in $(HCO) target
2:  1fc6dfc5fa = 1:  74efb6c04c apply.h: include missing header
3:  8ccbd81673 = 2:  2befc450fb promisor-remote.h: include missing header
4:  a3a3357925 ! 3:  50e37c16f9 pack-bitmap.h: fix unused variable warning
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    pack-bitmap.h: fix unused variable warning
    +    pack-bitmap.h: remove magic number
     
    -    When we ran `make hdr-check`, we got the following warning on Arch Linux:
    +    When we ran `make hdr-check` with the following patch
    +
    +            diff --git a/Makefile b/Makefile
    +            index f879697ea3..d8df4e316b 100644
    +            --- a/Makefile
    +            +++ b/Makefile
    +            @@ -2773,7 +2773,7 @@ CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))
    +            HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
    +
    +            $(HCO): %.hco: %.h FORCE
    +            -       $(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $<
    +            +       $(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $(ALL_CFLAGS) $<
    +
    +            .PHONY: hdr-check $(HCO)
    +            hdr-check: $(HCO)
    +
    +    and with `DEVELOPER=1`, we got the following warning on Arch Linux:
     
                 pack-bitmap.h:20:19: error: ‘BITMAP_IDX_SIGNATURE’ defined but not used [-Werror=unused-const-variable=]
                    20 | static const char BITMAP_IDX_SIGNATURE[] = {'B', 'I', 'T', 'M'};
    @@ Commit message
                 cc1: all warnings being treated as errors
     
         "Use" the BITMAP_IDX_SIGNATURE variable by making the size of
    -    bitmap_disk_header.magic equal to the size of BITMAP_IDX_SIGNATURE. An
    -    alternative was to simply add MAYBE_UNUSED. However, this design was
    -    chosen because we eliminate the magic number (4) in the process.
    +    bitmap_disk_header.magic equal to the size of BITMAP_IDX_SIGNATURE,
    +    thereby eliminating the magic number (4).
    +
    +    An alternative was to simply add MAYBE_UNUSED, however that does not
    +    eliminate the magic number.
    +
    +    Another alternative was to change the definition to
    +
    +            extern const char BITMAP_IDX_SIGNATURE[4];
    +
    +    However, this design was also not chosen as the static definition allows
    +    us to keep the declaration together for readability along with removing
    +    the magic number.
     
      ## pack-bitmap.h ##
     @@ pack-bitmap.h: struct commit;
-:  ---------- > 4:  14def72319 Makefile: emulate compile in $(HCO) target better
-- 
2.23.0.248.g3a9dd8fb08

