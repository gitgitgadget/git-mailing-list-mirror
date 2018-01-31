Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B6811F576
	for <e@80x24.org>; Wed, 31 Jan 2018 09:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753085AbeAaJbE (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 04:31:04 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45818 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752367AbeAaJbB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 04:31:01 -0500
Received: by mail-pg0-f67.google.com with SMTP id m136so9574256pga.12
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 01:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kg+9WeIO+Dr9BOvl5aBK3nIofDXKb5xvqbl291gWbtU=;
        b=MI7fcrWYLrdmKQuZuN559Xmtrv6Rk9EC8D5uGO4/xL+Ka7GYsKu6wO9K9iSu1pV90j
         MAZJAP6BRTK7T24+lLzhwxDuUNg6vkFU5lWBSP8N9XTK323e1HqBzJXblrBNRRJHdmpC
         WiHKyzrHRg7R0jeWyA0VQ43UBAA82tFNCOXp1LQJ4goX8YGuVV4ZitfpawAX768UTtN4
         cWU9Y9DtZvbAYHnoeZR8plvhcqPelWZmkWe0usecB+2M/BJEPCraP3pCm6jru9dNWEDK
         R6lTxse1fcwCjO9zJqZ3HjXnr1b/dD5YvmaSzBRL/Q9C+RiKnkkkOE9BRGnMuI0DM7gs
         19EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kg+9WeIO+Dr9BOvl5aBK3nIofDXKb5xvqbl291gWbtU=;
        b=o3JaeUg9z8WAD+WLt3wbumFC5SkY7yR3sdgNH5T2ItEU3m586SWkCsln1qs5HRJS6C
         RTxfr0DX+IPVXGzc2dRd3z/oX+BUIbptI3SiD7fQpbRymUu/y0E0pD3LH2xaBb1xfh7u
         KfLI8CORZ8sTe7m2ttc/fa7ALjJYQyYWg+qVKzxXS/dGR89O2YHFfDc2Y990dOEkem2F
         LdTuhGQL5WMhXwzGiBDf2AoguayxYAD7ErZfDcwH8kyeP5LkIqHNhpa+gZQus9VEHDcJ
         aQh805R9tVUzWJWZOatz4LVBGCtLnXOWiMvvEKFAIDr8NGoQ9MpnXFVGYcRnbf291ZMO
         kk8Q==
X-Gm-Message-State: AKwxytd8fjxJEH8b1Okrh0YyPnGEWd3e2JFggmkx9IjjXb9N711Qk8R7
        r016qjLP69b7YVReEqpXzgBVeQ==
X-Google-Smtp-Source: AH8x224iExzU14yR3Zha67Cdd8J9vY+/pOypGoK254D+/y1SSe2mEHXLmoBQazEsWV5pYib3H2A3qg==
X-Received: by 10.101.72.69 with SMTP id i5mr22637009pgs.9.1517391060879;
        Wed, 31 Jan 2018 01:31:00 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id j1sm34125034pff.94.2018.01.31.01.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 01:30:59 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 16:30:52 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        tim@tim-landscheidt.de,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 0/3] Add "git rebase --show-patch"
Date:   Wed, 31 Jan 2018 16:30:47 +0700
Message-Id: <20180131093051.15525-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180126095520.919-1-pclouds@gmail.com>
References: <20180126095520.919-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:

- keeps --show-patch, but it's renamed to be more specific and
  hopefully less misleading. Other names I thought of were
  --show-patch-in-progress, --show-stopped-patch or
  --show-conflict-patch but they don't look as good.

  Also, since this is a long option name, I don't think length
  matters. You either go with tab completion, alias or short option
  name when you want to type it fast.

- --show-patch now uses git show instead of format-patch, this
  gives coloring for all rebase cases

- people who are not happy with --show-patch can roll their own with
  the help from the pseudo ref ORIG_COMMIT

Nguyễn Thái Ngọc Duy (3):
  am: add --show-current-patch
  rebase: add --show-current-patch
  rebase: introduce and use pseudo-ref ORIG_COMMIT

 Documentation/git-am.txt               |  6 +++-
 Documentation/git-rebase.txt           |  7 +++-
 builtin/am.c                           | 46 +++++++++++++++++++++++---
 contrib/completion/git-completion.bash |  8 ++---
 git-rebase--am.sh                      |  3 ++
 git-rebase--interactive.sh             |  6 ++++
 git-rebase--merge.sh                   |  5 +++
 git-rebase.sh                          |  8 ++++-
 sequencer.c                            |  3 ++
 t/t3400-rebase.sh                      | 34 +++++++++++++++++++
 t/t3404-rebase-interactive.sh          |  8 +++++
 t/t4150-am.sh                          |  5 +++
 12 files changed, 128 insertions(+), 11 deletions(-)

-- 
2.16.1.205.g271f633410

