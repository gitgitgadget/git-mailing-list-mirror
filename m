Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF43E1F462
	for <e@80x24.org>; Sun,  2 Jun 2019 11:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfFBLE2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jun 2019 07:04:28 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:43671 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfFBLE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jun 2019 07:04:28 -0400
Received: by mail-wr1-f47.google.com with SMTP id r18so354746wrm.10
        for <git@vger.kernel.org>; Sun, 02 Jun 2019 04:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i+fJKCrQ4nf46crTTk/Wan1TLLGiDIZUjLoBuvi2cUE=;
        b=sIJrfDVM/fsyklC6YlcS3iGigeFbFkXKM4BuXh4g6dHr+ZyEXE2xY9yvXSd2T8+xdC
         hX137ZQ+3vjfBS/xvmhX7BZcf9kDAS1HFemBeuUKJqJ61kW8v+qEmMcTS8kZl+sqd0+V
         wn3RQfHokh4FF0QLiNHJRQsJVzdos9xj6Yh+zU5FKInNcVsNYzp/b1Ap1fVDMuX9BLQX
         +Lndz3Ft7vHVCeAWSGK2HtwQ3klQJn1Dtt/6g+y4gkmbqs4QyEvFnn3xxJUbPYgl3YwP
         FxjM9tjHq/nHh6Rg9oOdB1ipfpAOoStw3gIMcjdww1PPCmrIQifilICxeh3BMWXjpNcZ
         M3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i+fJKCrQ4nf46crTTk/Wan1TLLGiDIZUjLoBuvi2cUE=;
        b=jml1BO4Vr506qNuKubgvvT8CnRqUQogSITbTpD9ZKUrUHv3YmgZq21onI6VUXpyWVg
         QJoSiGbPLV8yy2kpQ8YRmdn3P4ZNmRYZrFuqhxJ3wjNAIEA9p3BJP6ZLseH4rE4Q0Ykc
         l3ZB1oHNu8ffeIQ8xESbpA3UTtYEOpzCWsFRYWTBVovJ/ASn9fnsG/c/zCp/wwCRdN5x
         BCb1vlPos17EPmYLX4kXH8Lh/iBgN4YkCSR1gnifmB7wV8gBWEfwTSSn08kgQ5h6G8cN
         dlp3QjvqRCVkrzSvOHqRZfDCtdzOvdSCO5Su9LLx74WpdxbZ/VyjtvsQTaD3U+ytH4Ln
         WTEA==
X-Gm-Message-State: APjAAAV2U1zGFZp5duuIY5c7sbiB339cXYSjLQ09jXROAxLXcmYx/Yyc
        B77ghqeP+ZJLegBjDbtAYYvVLqHS
X-Google-Smtp-Source: APXvYqwDK1HdzFf9xwe9E0yIfev9vZGggGjW82x0qbvAQnKtreTLqQe8ZezCdqPUQO/oFb7ZRAIDoA==
X-Received: by 2002:a5d:68cd:: with SMTP id p13mr12721217wrw.0.1559473466105;
        Sun, 02 Jun 2019 04:04:26 -0700 (PDT)
Received: from andromeda.localnet ([80.215.95.183])
        by smtp.gmail.com with ESMTPSA id v184sm21120486wma.6.2019.06.02.04.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Jun 2019 04:04:25 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Why is there still git-rebase--am.sh?
Date:   Sun, 02 Jun 2019 13:04:15 +0200
Message-ID: <3322453.bNc8J3RWDa@andromeda>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I was wandering in rebase=E2=80=99s source code, and found out that even th=
ough=20
run_specific_rebase() no longer calls git-rebase--am.sh since 21853626ea=20
("built-in rebase: call `git am` directly", 2019-01-18), this commit did no=
t=20
remove the code to call it.  I guess it was an oversight.

Now that git-legacy-rebase.sh is gone (since d03ebd411c, "rebase: remove th=
e=20
rebase.useBuiltin setting", 2019-03-18), I would expect this file to be=20
completely removed, too.

May I send a patch to remove git-rebase--am.sh, or is there a reason to kee=
p=20
it?

Cheers,
Alban




