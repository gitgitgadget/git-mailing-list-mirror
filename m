Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBD3A1F461
	for <e@80x24.org>; Fri, 17 May 2019 19:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfEQT4Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 15:56:16 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:39152 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfEQT4P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 15:56:15 -0400
Received: by mail-wm1-f45.google.com with SMTP id n25so7416242wmk.4
        for <git@vger.kernel.org>; Fri, 17 May 2019 12:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gyESKageTZcYEpYR/bAbofGmWiJ+zOND2EsCtC+Kcs0=;
        b=FBE1kl91dwxH/fROkbod35MiU14lQjRZjuud0zc+zBQRdKcHCLwqJQxYdxm9NBFufo
         R/cPmpvW0EeNhc3fz3D+AaxpMVYDybs6xdYsEnxKovAMAE/i8R6ERGgyl5ZwyX1fU1m/
         epQWFRV+pthBdZcN51K3M+2GY8rrOo2la1AVD8HO0csi+KyUThJeCtGmLrOlQreM/orO
         G2hsDru5LECe+sEOXKq9K8tbiRLWHoBovSxTI26o6DNySedsL0tAWTtT/oThKVEc1hsX
         PxSGGw3RgCTkcLKD24a4XeV7NlSoyq52/DJSnF8B6VoM2Z7AnF4rh9JUOc8uYlKRDNks
         IMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gyESKageTZcYEpYR/bAbofGmWiJ+zOND2EsCtC+Kcs0=;
        b=YWkW4xthlyhjdwNu2sKeQaakcOqVAUEDyPoFTrVyQBe7S7CDvyog12QpQwamUNl6jM
         AhLxn2bbv0QfFXjE1+afQ0zvjn4dlMKuGC7SXHxyGupK1CvGxbfVqRmm3/EZPR7CDI57
         mtT/k+PHCZAaWj0DHiCMPU+Q81+BkSFIzgM0nDTfHy9FdDa4z3DAIFNrPquLM6Z/AVMV
         6piAS7StnLlHmNIsVTsai7MsGuMtGbc2JOOF0NrOQ9Gw/37urf7L42Jx5TnmU5SO0nF/
         AMlTD7M0d1pDmD+zdPS2FYw66m+c6tpUjuE2TOtkPTTo08o/7WkwoTlLg03sCULGpSpV
         8mbA==
X-Gm-Message-State: APjAAAWcGkK7Dq2w8Qwpjd1V5boVortuvyhf9n9x1CbMFSFPPjI7VHWh
        ondl3bn+/de7tP++LlgOqrC/E/xVgyM=
X-Google-Smtp-Source: APXvYqzsUf6LhqcbxiosJSW36TKLI5l/rrrVmh4QYLqj2PY5/ESj3hN2Yuj4JJfwnMMe9DQQDzR97Q==
X-Received: by 2002:a1c:2d0e:: with SMTP id t14mr3551903wmt.33.1558122973660;
        Fri, 17 May 2019 12:56:13 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r2sm18691149wrr.65.2019.05.17.12.56.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 17 May 2019 12:56:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stephen Boyd <swboyd@chromium.org>, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, sunshine@sunshineco.com,
        xypron.glpk@gmx.de, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] ab/send-email-transferencoding-fix-for-the-fix
Date:   Fri, 17 May 2019 21:55:40 +0200
Message-Id: <20190517195545.29729-1-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.259.g3cce4bfedb
In-Reply-To: <xmqqsgtd3fw3.fsf@gitster-ct.c.googlers.com>
References: <xmqqsgtd3fw3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This ab/send-email-transferencoding-fix-for-the-fix series goes on top
of the ab/send-email-transferencoding-fix merged into "next". It fixes
the sendemail.identity issue Stephen Boyd reported, and then some.

Maybe it would be more understandable to rewind the existing topic out
of next and produce a new rebased series, but I think this is actually
easier to review, and documents some of the tricky edge cases for
future contributors.

I did make sure that the new tests I added for existing behavior were
actually testing existing behavior, and not whatever bugs I got into
"next" by running the test on top of "master", only the expected (now
fixed) tests fail there, not any tests for existing sendemail.identity
behavior.

Ævar Arnfjörð Bjarmason (5):
  send-email: remove cargo-culted multi-patch pattern in tests
  send-email: fix broken transferEncoding tests
  send-email: document --no-[to|cc|bcc]
  send-email: fix regression in sendemail.identity parsing
  send-email: remove support for deprecated sendemail.smtpssl

 Documentation/config/sendemail.txt |   3 -
 Documentation/git-send-email.txt   |  11 ++-
 git-send-email.perl                |  78 ++++++++++--------
 t/t9001-send-email.sh              | 122 +++++++++++++++++++++--------
 4 files changed, 144 insertions(+), 70 deletions(-)

-- 
2.21.0.1020.gf2820cf01a

