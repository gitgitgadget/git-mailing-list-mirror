Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E8A71F462
	for <e@80x24.org>; Tue, 11 Jun 2019 21:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406893AbfFKVGv (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 17:06:51 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:37557 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406793AbfFKVGv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 17:06:51 -0400
Received: by mail-pf1-f202.google.com with SMTP id x18so10442918pfj.4
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 14:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TY/pc/O4K+09a8iX32rX2S2j6uX1+FsQZvoILLyOFWc=;
        b=lEaCP18icfG71a7R5p2uhPWll7u/TrsReLDmk0IrrNy7lcYy1dlyXgJy/0HhtdQQOt
         wF65wl+NTp6z58Y+q6rRAIJ0ZIMcTx2Sn7aR9RUlK3JdPd8gZBj4orvNMs3YselEiwm1
         mW5aUmXNpE8ieBsn9WMwTEtsON8ngp9kcK9kFG31eFNpCgqMiyd/ECcJM7qyjCvwDu8s
         hPEkyz44yZ5ml5lAr0xn8yQfwQmga4M9jSttYLn4WXTZ+ag+jrS5Hs7NRyJTRHkOtbQ8
         M8/897X4KhDPATSuf1oJrWK3XSDK4w6ztrxWKPKwXSwgKtZlOnKUMjdUHQ9u8QqoGD/S
         N3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TY/pc/O4K+09a8iX32rX2S2j6uX1+FsQZvoILLyOFWc=;
        b=su23T6BS4cJdyYiW0qxz8m5XpCszlRYlG4FHDcRVRiCzpLLOUkDVOYVfN5JDJSAcqQ
         iejUhfMnEato7Wgr203tXRVqMC6djhgOTLqzlL2td8by7JuKDy0xBIyUQ/OIPeDuz2gC
         MnNjqbdHIfj+/o8rzT4eqDyLSI0EkpRiiMrtprLRJFjXhiKJJyA75ZXZezAhnDQHyfXc
         mzMkq0cZeHS9lDZz+ImvSI3O7O7GxDNM2fhc5AGVgi2rMLosQZJkNuzBUEYiSbPdzu4l
         w1rxHSXrK9ouSY9csKjVKpK3MGXXTmrg35rEqNiNVBa5vtv19vxo1+SFOGawAGHoamQn
         7lAA==
X-Gm-Message-State: APjAAAUMbvmwF4c+YQTU4l75Rvpw8ismu1taVTTiieId10TZJ/6ecg/p
        R0kuNaUW/QoSAKI7mf6LfyVU70FTTGT6fuQoJnPwq0zPKi5sYddu4Yhuwm4nLM5PPDjpAse1AQD
        E1f0OvdMGYc9bVOlkG3eI8/zZw+0gDtY0AW9UNi54Z6ErHIetvnSQzxXrJQb2NTMLWHEcUj2iPJ
        bN
X-Google-Smtp-Source: APXvYqwfDq9R7B9mGVpevEIIDTHUGjIrVjHwukwQrtT1i9zFfYYuNcp1GJDWp6wh2U7ACY4TB8LaJ+3LL20bBOyDxKt4
X-Received: by 2002:a63:8841:: with SMTP id l62mr20255991pgd.246.1560287210080;
 Tue, 11 Jun 2019 14:06:50 -0700 (PDT)
Date:   Tue, 11 Jun 2019 14:06:45 -0700
Message-Id: <cover.1560286956.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH 0/2] Improve test code coverage on jt/partial-clone-missing-ref-delta-base
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is on jt/partial-clone-missing-ref-delta-base.

Patch 1 is a cleanup, and patch 2 improves test code coverage. Thanks to
Stolee for the code coverage report.

I have checked this by running `make coverage` then `make cover_db_html`
on both "next" and this series, and comparing the output - the
relevant line indeed shows up as uncovered on "next", and covered on
this.

Jonathan Tan (2):
  t5616: use correct flag to check object is missing
  t5616: cover case of client having delta base

 t/t5616-partial-clone.sh | 41 ++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

