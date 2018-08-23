Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 034D61F404
	for <e@80x24.org>; Thu, 23 Aug 2018 20:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbeHXAHl (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 20:07:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34933 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeHXAHk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 20:07:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id j26-v6so5696844wre.2
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 13:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hk8Y1+hLTttHCnrvF09R6usrxByRcQ9n6XlOpZJW9kY=;
        b=dR97TBcuNklUjBgEGgfRYAgP4D7mbYxlsEY5eZjFbtGP77HdGGlBRr58DRztHPG40W
         Vdb/YEe1ZMCrqP44XoUraYmjodndpzDACSNAqaqU3GnWm/Aj8EhJy5oC8PNvlhtGInSF
         R1sNt59t9pBkcODb3YnMMEK2jBu+GGvvt3shhHC4tdllYn8aOucqWc0yke6ux42ihxwo
         ++C0YUCpFauGmCwRvZokJm8CV7FA561oOdhrmNy/dgGTfYsEJWXBLwftU+wV7CnBWlfV
         YrUQoRCiiBzQqZ3i3Xvo+0O4tjyISAp391L0shJBRVrFIwf521thNshhK4aMKlCR3BFc
         0UwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hk8Y1+hLTttHCnrvF09R6usrxByRcQ9n6XlOpZJW9kY=;
        b=LYwyj4/DphGRbwzNuFFckvXIWoF2fMFy3ppx/AMma306JzkpuLhEkQ6FlCBzrgwBRZ
         tNaaKtKTaZqvj4m11/C3zs3okXNId5kF3p4iVcXiXMeRi85ViIy1fFOSTw7xnBGCJgkp
         mzq0D1lY0PYK7YBjSmeVMLzJU5SVYeRUHYsgPtGpBkxl4D1YY1ALramNLeAInPpG4yYL
         kt26eGyUAbCJP+ZWAgL2h4aBgahW1s9A7LUxScbOhHg6hScS1MpnVi5TiXJL14XM9ovB
         B1voJGFZtSFjvPUfaOKElo4bX/2C7mn3hB1AW1CZjA7XJ7Gefes3G+fU1sGd350vg6dW
         pulA==
X-Gm-Message-State: APzg51BebmMKUVtYuFTRVVvuWmKDglcN3ro2602Xdm/07pCUBQIay6nZ
        kiXyl3xDxQEjakqy69FjC+P5STC/IRM=
X-Google-Smtp-Source: ANB0VdbI+IqIYLLpSn/hsHhg71DvnJ4DHAr1yMccLPTTzZ3xEbGpvHadj6kQBRxCHRYJOF6myKBH4Q==
X-Received: by 2002:adf:93a5:: with SMTP id 34-v6mr10183198wrp.97.1535056577718;
        Thu, 23 Aug 2018 13:36:17 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q16-v6sm3641898wrn.41.2018.08.23.13.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 13:36:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/5] OpenBSD & AIX etc. portability fixes
Date:   Thu, 23 Aug 2018 20:35:59 +0000
Message-Id: <20180823203604.5564-1-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
In-Reply-To: <20180823152502.3886-2-avarab@gmail.com>
References: <20180823152502.3886-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This grew a bit more. I'm going to stop poking at this for now. The
tests are still broken on OpenBSD (3-5 broken) and on AIX something
like 20-30 are broken, but this makes it slightly better.

Ævar Arnfjörð Bjarmason (5):
  tests: fix and add lint for non-portable head -c N
  tests: fix and add lint for non-portable seq
  tests: use shorter here-docs in chainlint.sed for AIX sed
  tests: fix version-specific portability issue in Perl JSON
  tests: fix and add lint for non-portable grep --file

 t/chainlint.sed                      |  8 ++++----
 t/check-non-portable-shell.pl        |  3 +++
 t/t0019/parse_json.perl              |  3 +++
 t/t5310-pack-bitmaps.sh              |  2 +-
 t/t5318-commit-graph.sh              |  2 +-
 t/t5552-skipping-fetch-negotiator.sh | 12 ++++++------
 t/t5703-upload-pack-ref-in-want.sh   |  4 ++--
 t/test-lib.sh                        |  4 ++--
 8 files changed, 22 insertions(+), 16 deletions(-)

-- 
2.18.0.865.gffc8e1a3cd6

