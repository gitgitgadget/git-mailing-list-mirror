Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBCDC433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 01:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbiALBVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 20:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiALBVg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 20:21:36 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1208FC06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 17:21:36 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n2-20020a255902000000b0060f9d75eafeso1907630ybb.1
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 17:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to
         :content-transfer-encoding;
        bh=OnETnzAMDlG/2ynMl5BDj9H2NbkETrkHaeoxNKTAl9Q=;
        b=SUim+AVlMhE0a0sLLK+QFA3DDxe3R9PaPeiscSaHIi4Ji6XbmEL50pLaXj21Nwbbfl
         wep8xo9LBRFF/M+GarXPpeqf3OThyOysrjN68PiTZj+ACYe9yhI/5eSQNsbh1T3y1sCP
         72ecZn9QE6ApvEBimYPdo0xTAMe5MX7UYWK8i5Rq3uUU9LNghOvLIT5Hzs6DSvnRHrdV
         3fZ8D6/5G3TaQ38Wh5nTTKWSQ8l65b1s/edeBR1wZQGQIP5P00uS93r0C1x4KSmmaQ4l
         mxo7Iin1c+gz9yPEYCEt+2BVE1a4jRo+OfkSnYZ1qXf911xY0aEZqQUr8kcElyjYYsxA
         jDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to
         :content-transfer-encoding;
        bh=OnETnzAMDlG/2ynMl5BDj9H2NbkETrkHaeoxNKTAl9Q=;
        b=vENbjK3zr4nOqYDBc+SfVvLUGjZl1FfklLyEtycB8S2UbXHGbi3HrHJGYAdvOoV34i
         RoPHADZUbf26SEgIdbnD7O6+bUSFJAJx9aWOU9VnK1Y6lPJ6Pfw19zVlp7jzqtePj2UR
         +i8YRIqO4BlhRg8suwMBzFV85HoTuwFRgiJ62WdGoLFYozD3UHxNF5cLDIaFmIfm6qd9
         7gxKEqM7NAzwPylMg8TEB57zJehombpZ2XP71RQfF5s3MsYQzOIYqJ0z2wUwK4N32/LN
         ORbXtznoi7mNeuZYFLnXm8rHQe+NrEtuUHXuqTiwTpZGehFq5l2lqMwifRjx24IKzhvL
         t29w==
X-Gm-Message-State: AOAM533ZecJMC1VB3x1sO41OeinZu0Undn7VFJZGWEOp0YXCCORkUST5
        NmnIq9UHVoPc/4JRQItnRcUbbp9jxENFZ8KDbdE=
X-Google-Smtp-Source: ABdhPJyJV9vTaSkCqZW/R6YL4e5e/Upyw9WUR7hG2a16UCCwFc4kkCAzAwuE1VDZbWq3YGNgtHM87fW7ZxQF6EBZaLE=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:5535:8952:4e2:8bd])
 (user=emilyshaffer job=sendgmr) by 2002:a25:3620:: with SMTP id
 d32mr10363451yba.222.1641950495354; Tue, 11 Jan 2022 17:21:35 -0800 (PST)
Date:   Tue, 11 Jan 2022 17:21:30 -0800
Message-ID: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [PATCH 0/3] Fix SunCC compiler complaints new in v2.35.0-rc0
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git-core-auto+context-review@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Message-ID: <20220112012130.oJLS-HIfgXXTRt8-YaKc-N_UzKBKqz23dw82jFg3w0w@z>

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

This trivial set of patches fixes compiler complaints from SunCC on
Solaris that are new in v2.35.0-rc0.

The first two are only a minor annoyance, and not the first or only
warnings of those categories that we emit, but if we can avoid adding
new ones...

The third one is a generic integer overflow bug, and will probably
result in logic errors or failures in the reftable tests on some other
platform.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
  test-tool genzeros: initialize "zeros" to avoid SunCC warning
  reftable: remove unreachable "return" statements
  reftable tests: avoid "int" overflow, use "uint64_t"

 reftable/merged_test.c   | 4 ++--
 reftable/refname.c       | 1 -
 reftable/writer.c        | 1 -
 t/helper/test-genzeros.c | 3 +--
 4 files changed, 3 insertions(+), 6 deletions(-)
