Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56AAC20357
	for <e@80x24.org>; Mon, 10 Jul 2017 21:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754601AbdGJV4P (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 17:56:15 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36111 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbdGJV4O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 17:56:14 -0400
Received: by mail-lf0-f68.google.com with SMTP id f28so12303818lfi.3
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 14:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=09gnyP9gU/eBtDWWcUVrlse4FssHQccBME4FK5ygcvo=;
        b=JoguFAscKVbs7UfmUcKx5+ISZaj3Dxabdj3lu+eqwDjV/U16TyH9kxgesQofQnCcE2
         2SAfdwWjgFNr+dKE/pVcxFxjiZRwsZFZqPVJNCv1qk1KxuA1LufOhK+k+7jy27Hw6+tu
         RqcrPnQAtMloRsqBM9k7VOMAHRJxoCf3kNeFRIjZHfuSOa6MVipPiqAXjT7z29yhSzyb
         /bt1egVbB9e8r6LV2giyic9xXVhIv3h11vdHmI9ESI/8mmstY67pHXRFCogZFlcikTZB
         MBPtgpSLpDJfhu1QchDEi7T15a0x8qcQ0ucSL6mvAmn9v+mitiSflyh2Kb8pZPEGYmlL
         ta0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=09gnyP9gU/eBtDWWcUVrlse4FssHQccBME4FK5ygcvo=;
        b=Zz5d8EEPmK90cOIQ+OZKBMrJO3/I+LQFN0N+8MMmW7GVq0vS4unYy8vTUQyNfOqCqK
         5kNFswXeCEAkdYjy4t44plvyE7f9ky0TFqflqrWy0z8t2Wu6izUm8OJjwCw049/xSHhv
         dH2cHFbw5qu9/bs9VeZduQV+2Jba2mYqtRWN/cJXfb4aONuYhZGyyb9mi/ztLOymB2lm
         +UllbVWV7qgFmfIs4s1ml2pT+JHqXQrbkE5FQKxJEcTRCpfN/3TkHUz8adD11MZpNk9e
         uTpQ3ZwlG7GZ6BaVpoieSb5uqPRRh751py93FQK/BAizMFExebTpRBXoG83fziCAs1qv
         5yOg==
X-Gm-Message-State: AIVw112AXiVBtm+42bxvccE0OzjdyDlXpYSi0J9USRWQrDD0UAfrz4kP
        8twISrAKs2IgUX9QzVk=
X-Received: by 10.46.21.71 with SMTP id 7mr5285138ljv.50.1499723772352;
        Mon, 10 Jul 2017 14:56:12 -0700 (PDT)
Received: from localhost.localdomain (78-66-223-92-no2204.tbcn.telia.com. [78.66.223.92])
        by smtp.gmail.com with ESMTPSA id x13sm2617077ljd.64.2017.07.10.14.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 14:56:11 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH 0/7] tag: more fine-grained pager-configuration
Date:   Mon, 10 Jul 2017 23:55:13 +0200
Message-Id: <cover.1499723297.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.13.2.653.gfb5159d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using, e.g., `git -c pager.tag tag -a new-tag` results in errors such as "Vim: Warning: Output is not to a terminal" and a garbled terminal. A user who makes use of `git tag -a` and `git tag -l` will probably choose not to configure `pager.tag` or to set it to "no", so that `git tag -a` will actually work, at the cost of not getting the pager with `git tag -l`.

In the discussion at [1], it was brought up that 1) the individual builtins should be in charge of setting up the paging (as opposed to git.c which has no knowledge about what the command is about to do) and that 2) there could then be a configuration `pager.tag.list` to address the specific problem of `git tag`.

This is an attempt to implement something like that. I decided to let `pager.tag.list` fall back to `pager.tag` before falling back to "on". The default for `pager.tag` is still "off". I can see how that might seem confusing. However, my argument is that it would be awkward for `git tag -l` to ignore `pager.tag` -- we are after all running a subcommand of `git tag`. Also, this avoids a regression for someone who has set `pager.tag` and uses `git tag -l`.

I am not moving all builtins to handling the pager on their own, but instead introduce a flag IGNORE_PAGER_CONFIG and use it only with the tag builtin. That means there's another flag to reason about, but it avoids moving all builtins to handling the paging themselves just to make one of them do something more "clever".

The discussion mentioned above discusses various approaches. It also notes how the current pager.foo-configuration conflates _whether_ and _how_ to run a pager. Arguably, this series paints ourselves even further into that corner. The idea of `pager.foo.command` and `pager.foo.enabled` has been mentioned and this series might make such an approach slightly less clean, conceptually. We could introduce `paging.foo` as a "yes"/"no"/"maybe" to go alongside `pager.foo` which is then "less"/"cat"/.... That's definitely outside this series, but should not be prohibited by it...

A review would be much appreciated. Comments on the way I structured the series would be just as welcome as ones on the final result.

Martin

[1] https://public-inbox.org/git/nrmbrl$hsk$1@blaine.gmane.org/T/

Martin Ågren (7):
  api-builtin.txt: document SUPPORT_SUPER_PREFIX
  git.c: let builtins opt for handling `pager.foo` themselves
  git.c: provide setup_auto_pager()
  t7006: add tests for how git tag paginates
  tag: handle `pager.tag`-configuration within the builtin
  tag: make git tag -l consider new config `pager.tag.list`
  tag: make git tag -l use pager by default

 Documentation/git-tag.txt               |  4 +++
 Documentation/technical/api-builtin.txt | 10 ++++++
 builtin.h                               | 14 +++++++++
 builtin/tag.c                           |  4 +++
 git.c                                   | 44 +++++++++++++++++++++++++--
 t/t7006-pager.sh                        | 54 +++++++++++++++++++++++++++++++++
 6 files changed, 127 insertions(+), 3 deletions(-)

-- 
2.13.2.653.gfb5159d

