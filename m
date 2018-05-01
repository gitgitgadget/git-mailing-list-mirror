Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFB69215F4
	for <e@80x24.org>; Tue,  1 May 2018 18:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756278AbeEASke (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 14:40:34 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:33187 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756203AbeEASkd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 14:40:33 -0400
Received: by mail-wr0-f174.google.com with SMTP id o4-v6so11567185wrm.0
        for <git@vger.kernel.org>; Tue, 01 May 2018 11:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZNaexXI+vPdYz4HYz1E+g5i7SXgUz7Tw1wmtwN7Msuc=;
        b=TBPJIbEkZJoZqd2um3dWj2B3dHNYz4rYLb+Ls1qVL5An+PR1a1Z6ncEq+756YbIGPD
         Gt1zxHW66vU6lS12yYOafhsPycuOn1xEiY7F5yGuFOJtzVNtsm5x9aF6fphh8iz9vJR0
         EGNHQufu4Q4Q5fSI/1j4rRqeJfjVonozQ0mz841cN3kRZgKJNfqR0UXjlE7JoTsq6gE2
         qWthcyuodxltrBZSovTUow5Jn1wXCNIK+4jvGsqXy6Ijl0ioiARF41CjeOorBHjB2mJg
         k+APxUtaJR2i5sBy/Ox6iatMYT2IUaOyIuoCjy3OmIsGIbfxVSNf7F5dX/9tsFn0BY7d
         QMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZNaexXI+vPdYz4HYz1E+g5i7SXgUz7Tw1wmtwN7Msuc=;
        b=Kfs2XXSO9jGHlheVr5KzmTsbNT+lXlzqP1UEpmq6KLFgwpF4AGy/aGZG7TldkqlFWV
         ammsbsi+7HA/bI2d3mKdUeOxl/CE6aTFAuWOL2a4lldn3vdRTTDS+4e2BpvE6yc1aNKY
         ZruVhvziJ2+3A9VHjjhpjJ1AYX05qk5E+5GDsbVUrWR90dvdoyg/Z16z66yTYC0Qn/2w
         dYDn08kPNEKOvzeZ6DUDFZQzkK95vTDRTVIZVqGV8W6T0rBENqUCZXYmGgvDFVD9VbZ+
         73DML4OriPmxtuPL1Hgpm9KDPUKJHR+lhttxtgX5cYwut2TOJLIsvR9pAfmq3IpVnDLM
         5BXw==
X-Gm-Message-State: ALQs6tAAm1oKkcrgqVXjPAx2QoaQxAasFjp5oXUVn3YgO0GaXnNEXUpg
        qi5SO9XHvbLRuOGYloicxHeTSZ4L
X-Google-Smtp-Source: AB8JxZppV46Sjnck2KThVt/GA8bNQFnWVMTI8Sp0A/+2MKw361nARi9XsIyD3yWVBxhzPh+V7ETRzw==
X-Received: by 2002:adf:aa04:: with SMTP id p4-v6mr11552445wrd.226.1525200031565;
        Tue, 01 May 2018 11:40:31 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b57-v6sm15366920wra.9.2018.05.01.11.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 11:40:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/12] get_short_oid UI improvements
Date:   Tue,  1 May 2018 18:40:04 +0000
Message-Id: <20180501184016.15061-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180501120651.15886-1-avarab@gmail.com>
References: <20180501120651.15886-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Comments inline:

Ævar Arnfjörð Bjarmason (12):
  sha1-name.c: remove stray newline

No changes.

  sha1-array.h: align function arguments

Mention the correct commit to blame for disalignment in the commit
message, and also fix it in the *.c file.

  git-p4: change "commitish" typo to "committish"

No changes.

  cache.h: add comment explaining the order in object_type

Trivial commit message rewording.

  sha1-name.c: move around the collect_ambiguous() function

No changes.

  get_short_oid: sort ambiguous objects by type, then SHA-1

The biggest change in v3 is the no change at all to the code, but a
lengthy explanation of why I didn't go for Derrick's simpler
implementation. Maybe I'm wrong about that, but I felt uneasy
offloading undocumented (or if I documented it, it would only be for
this one edge-case) magic on the oid_array API. Instead I'm just
making this patch a bit more complex.

  get_short_oid: learn to disambiguate by ^{tag}
  get_short_oid: learn to disambiguate by ^{blob}
  get_short_oid / peel_onion: ^{tree} should be tree, not treeish
  get_short_oid / peel_onion: ^{commit} should be commit, not committish
  config doc: document core.disambiguate
  get_short_oid: document & warn if we ignore the type selector

No changes except one trivial commit message formatting fix.

 Documentation/config.txt                  | 17 +++++
 Documentation/technical/api-oid-array.txt | 17 +++--
 cache.h                                   | 13 +++-
 git-p4.py                                 |  6 +-
 sha1-array.c                              | 21 +++++-
 sha1-array.h                              |  7 +-
 sha1-name.c                               | 80 +++++++++++++++++++----
 t/t1512-rev-parse-disambiguation.sh       | 58 +++++++++++++---
 8 files changed, 184 insertions(+), 35 deletions(-)

-- 
2.17.0.290.gded63e768a

