Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB94F20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 21:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeLMVXC (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 16:23:02 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46493 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeLMVXC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 16:23:02 -0500
Received: by mail-qk1-f194.google.com with SMTP id q1so2026637qkf.13
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 13:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xeNVN9+xZEG00zmsFhuiQZh4w/SdTU79L+k2mnf3fq0=;
        b=vfBC65WHSrEzQw5s/xlugXg56FaRciIQJ9deU/VafJqljT/ZWVmbFsMcbPIow/a7Kz
         f3+gyynClPGKoDoJfLgBaWoPv5zQgUM+9KiIXo36B+nggpVo8QrQ1LrGTJjRY/kz1uWF
         zKIYxavb5FfqNzI+3qj1EoYldQAOk47Rd+4NHcxaaGOXPP6TxmenIPAkqo2uU6NDLHxt
         o701aeRpyOafE18qg60qKeaLSQ4DaP/jbZf2Qx4dI+7VmXMtVFlWWjlam/cCoIwgjqOu
         d3Uji3bdIIBm6jIrqkBBFDEK9inuzlcwIYem+DptbnvdKdDSBO6XdV73grZtcrncN2Q7
         SjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xeNVN9+xZEG00zmsFhuiQZh4w/SdTU79L+k2mnf3fq0=;
        b=BI31qoozrL1a/GAB688lSpiKDGoIaStxsQpbu1ZnYKTClGNZwMK5OtWcr9q0k3N7mf
         lQLXKdOWox6TiAHz3LhzRkLFE/cK63/VvROmvt+iStOTDK0YK76qboXQAOjiUPWqdWeP
         Y81fNbpVVTNWQi4RIhJPXY1fHQF5NwuO4my9aS7lyrWPOuiJpc2/4aCxyboSJgwu7sMt
         n0BgaQUbzXIWGI8p2RY9X2ThMkUjH3u0/ktuXHoHFiMICA5mtvQbt5hfCCiL/4iNvJUv
         8Mh87BThZOKCkEbCZHJZypMvQGWWgo7w8Cy4fborLdTZoKHt0+iXeqbhbKzO8OSdqNQ+
         QAmw==
X-Gm-Message-State: AA+aEWaC3VkKn++gJlLaM6qqd4yMsCGMgtHJ/JOVecdN8xt4IlJAZ2wc
        DgKHte3xdg54gwKkZ5ORlVJ/uHZj
X-Google-Smtp-Source: AFSGD/Xjpp5NkSnC1SNx8T6Re8Suf2zkTNPwrpLEpZqHsY/rlbDFQTiUWdJ6Jcq7hQJ9DkNUXOTwVQ==
X-Received: by 2002:a37:f23:: with SMTP id z35mr357010qkg.171.1544736180963;
        Thu, 13 Dec 2018 13:23:00 -0800 (PST)
Received: from localhost.localdomain ([142.154.219.74])
        by smtp.gmail.com with ESMTPSA id f13sm1552840qkm.52.2018.12.13.13.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 13:23:00 -0800 (PST)
From:   John Passaro <john.a.passaro@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, alex.crezoff@gmail.com, peff@peff.net,
        mgorny@gentoo.org, John Passaro <john.a.passaro@gmail.com>
Subject: [PATCH 0/4] Expose gpgsig in pretty-print
Date:   Thu, 13 Dec 2018 16:22:52 -0500
Message-Id: <20181213212256.48122-1-john.a.passaro@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, users who do not have GPG installed have no way to discern
signed from unsigned commits without examining raw commit data. I
propose two new pretty-print placeholders to expose this information:

%GR: full ("R"aw) contents of gpgsig header
%G+: Y/N if the commit has nonempty gpgsig header or not

The second is of course much more likely to be used, but having exposed
the one, exposing the other too adds almost no complexity.

I'm open to suggestion on the names of these placeholders.

This commit is based on master but e5a329a279 ("run-command: report exec
failure" 2018-12-11) is required for the tests to pass.

One note is that this change touches areas of the pretty-format
documentation that are radically revamped in aw/pretty-trailers: see
42617752d4 ("doc: group pretty-format.txt placeholders descriptions"
2018-12-08). I have another version of this branch based on that branch
as well, so you can use that in case conflicts with aw/pretty-trailers
arise.

See:
- https://github.com/jpassaro/git/tree/jp/pretty-expose-gpgsig
- https://github.com/jpassaro/git/tree/jp/pretty-expose-gpgsig--based-on-aw-pretty-trailers

John Passaro (4):
  pretty: expose raw commit signature
  t/t7510-signed-commit.sh: test new placeholders
  doc, tests: pretty behavior when gpg missing
  docs/pretty-formats: add explanation + copy edits

 Documentation/pretty-formats.txt |  21 ++++--
 pretty.c                         |  36 ++++++++-
 t/t7510-signed-commit.sh         | 125 +++++++++++++++++++++++++++++--
 3 files changed, 167 insertions(+), 15 deletions(-)


base-commit: 5d826e972970a784bd7a7bdf587512510097b8c7
prerequisite-patch-id: aedfe228fd293714d9cd0392ac22ff1cba7365db
-- 
2.19.1

