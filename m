Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E61FC215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754862AbeEAMHS (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:07:18 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:44630 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754734AbeEAMHR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:07:17 -0400
Received: by mail-wr0-f174.google.com with SMTP id o15-v6so10636208wro.11
        for <git@vger.kernel.org>; Tue, 01 May 2018 05:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2O017o2IGBowl3Kll3eu1ufHtHzT5iUdI6oAZlwCixY=;
        b=gCGO8ogS7Q0FaRdWxAENPawwJGHg10yHmWv6Zi8KGKe/JALXsPaNfajvWzGc9/+fvy
         6gR4/baO9dkAN3z7PQMMCVBHUHaJvOMhVZM1SlviIuLvU4dij5752dShgkVf8zJikUH6
         PLYxynBKtC4lePwYpQbRli40/kwbrISpY8u+rz3gXfL1+DyjcMqFJ9KXFzKPHoYv/nD/
         M5LOSyu2l142L/2ECUh6uJs+7V/Oahw/uNu671BDjkLTLOnFmTtwqxmhZs8Xo1ET+nGz
         tRDKJ3DTKSTrrL8Z20NX8n98JCZriXBUkYNncqS/DoIWwjfZXeT/jLszL4lVbJoIrazB
         krSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2O017o2IGBowl3Kll3eu1ufHtHzT5iUdI6oAZlwCixY=;
        b=JBNX/cuHjF0IPwSfp+yP53MMsQ3qVfDUbSzdp1VytAD2/MQRpfNtEe+zlTKuC5ayq0
         SIuCqcmmaZg3jwj4NsEGupjTYumjs8ueFgbEi06NpKt2xfi9NiEkIfJKrSzcYgXqpHy3
         yMVKvd8nSmtToNVl2Efq/qKNYd/8hMIA7WGebYnWxBxivMCikXuisirM6Dq8h9pNu10R
         yIyEdBZ4nWTDaNY1q3h7HnkOBf82EvtuQZQr0jx6w5Eewc7j5f+zegBVUaPS+TCy5OPY
         ylBZJrr02Tf4VZHxBw7vZcRYiQe+H8IIWy5aNQ2Qvr5QhVAw/f4TC04Y6yVxMd9laorS
         ItIw==
X-Gm-Message-State: ALQs6tD7MzqKZhpLCsh1Ku9lyF8KURDv4oHxaBKgKgq5t9AYxoWq/p6+
        ko7wlus/WiRjOBdx9SilfWylgWNi
X-Google-Smtp-Source: AB8JxZomHeIhy1oEGbiUh8IFmhnQ8JIkOuA12qkw32BDwGAAQ4aDjNE3C+h5EAmVzhMQtqJWIWDawQ==
X-Received: by 2002:adf:db0b:: with SMTP id s11-v6mr10948481wri.241.1525176436134;
        Tue, 01 May 2018 05:07:16 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m134sm11738710wmg.4.2018.05.01.05.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 05:07:15 -0700 (PDT)
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
Subject: [PATCH v2 00/12] get_short_oid UI improvements
Date:   Tue,  1 May 2018 12:06:39 +0000
Message-Id: <20180501120651.15886-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180430220734.30133-1-avarab@gmail.com>
References: <20180430220734.30133-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A v2 addressing feedback so far. Comments inline per-patch.

Ævar Arnfjörð Bjarmason (12):
  sha1-name.c: remove stray newline
  sha1-array.h: align function arguments

No changes.

  git-p4: change "commitish" typo to "committish"

New, I fixed my own "commitish" elsewhere, fixing it here in this
unrelated area while I'm at it.

  cache.h: add comment explaining the order in object_type

New: Derrick Stolee pointed out why the object type enum used later is
ordered that way, explain that with a comment.

  sha1-name.c: move around the collect_ambiguous() function

Trivial grammar correction in commit message:
    -    collect_ambiguous() function is now, which would result in a
    +    collect_ambiguous() function is now. Without this we'd then have a

  get_short_oid: sort ambiguous objects by type, then SHA-1

* Grammar fixes in commit message
* Add docs to api-oid-array.txt documenting the new oid_array_for_each()
* Document in the commit message why we sort twice
* Note inline in sha1-array.c why oid_array_for_each() doesn't sort
  with a pointer to the API docs.
* Add test to assert that we sort objects in the order we expect, and
  that they're hash sorted within the object types.

  get_short_oid: learn to disambiguate by ^{tag}
  get_short_oid: learn to disambiguate by ^{blob}

No changes.

  get_short_oid / peel_onion: ^{tree} should be tree, not treeish

s/mean/be/ in subject line (to avoid wrapping in E-Mail).

  get_short_oid / peel_onion: ^{commit} should be commit, not committish

Rewrite commit message, now assumes less context from the rest of the
series & is easier to read stand-alone.

  config doc: document core.disambiguate

Change commitish to committish, and note the `$sha1:` peel syntax.

  get_short_oid: document & warn if we ignore the type selector

New: Explain why we ignore e.g. $sha1^{blob} if there's no blobs with
the $sha1 prefix.

 Documentation/config.txt                  | 17 +++++
 Documentation/technical/api-oid-array.txt | 17 +++--
 cache.h                                   | 13 +++-
 git-p4.py                                 |  6 +-
 sha1-array.c                              | 17 +++++
 sha1-array.h                              |  7 +-
 sha1-name.c                               | 80 +++++++++++++++++++----
 t/t1512-rev-parse-disambiguation.sh       | 58 +++++++++++++---
 8 files changed, 182 insertions(+), 33 deletions(-)

-- 
2.17.0.290.gded63e768a

