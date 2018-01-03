Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE2481F406
	for <e@80x24.org>; Wed,  3 Jan 2018 20:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeACUtm (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 15:49:42 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45159 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbeACUtk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 15:49:40 -0500
Received: by mail-wr0-f194.google.com with SMTP id o15so3008461wrf.12
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 12:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K91cvmj2WxPCU5bZfiIf0ZbAFCP/UQreHeo5Qr5PLhk=;
        b=udY4jUexcWin6f69vNx4036XplT5UfI6d/Hk5rW6RSiwQcKsfxZwLJhYcLjO3ay9aq
         J9mPNBEZ4OoIHoYPM3g3HfbRzKXq/itIp5B6WDrLWXS+fdJAtOlsg49fman2KAZl8eS9
         x5V0RDj4Cd13k8Sh5fezkVnzpmzgkg8KgGTYlEbdjVg0+ve3b3gj3NK1jFAokXafHTm5
         fMftYr/6kvIKJGG/Jpb0/rOxArM2A/rewH8gtdQgi8ZsR/9rDduhgQEJInFDzMAcSUZ4
         qhPMCI3sLa/pKeDROuqEvysWn1Mrgb1N5R97wiqmJMpEn4fNIaUnIxAKew3It3ZlzcsK
         DK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K91cvmj2WxPCU5bZfiIf0ZbAFCP/UQreHeo5Qr5PLhk=;
        b=YdrIivum2vmRW86sQWmUcIO9UPk6xqgWyeZPKRzCRbGT/MjNIOx/8GiWzd2wgpFnEe
         hMxCwgCKYqb6/smels7qMnJwXvaKXpIb6Xp2Rpees2I14C+6ZGhRs+CaESiNexuBTPTj
         3CwmWN9Oj4ZnulH8sHHMWvz5Dhj54whBK877vDixwdc/DFltmk82ei6wQHrY77JkOkSh
         ozJYyDpUSd/FAZQ1zED86w2jnmyLfJKzj4BjgqPF/JvAi7jgVI4s5iGUAemxpHESQL3w
         D2XjeDcSK6N5ulxkgw3Ov/2yWQCpYcryWFF/pl9ZEaHvSfRso0q2A3bbTx1sS/poKNxq
         ruNQ==
X-Gm-Message-State: AKGB3mJP31dn7diihNNLW1Gm3xF7hRH6ZSWylmEnHugmXHECbgK+6hHL
        HpxdsV/StxGxRqMdEMqh8Bt0txUu
X-Google-Smtp-Source: ACJfBotBLXvcqApsHTdOxOkVfD9OT9Y43U7YuUucUxZjfwOSuSMEPiopuqj2vHQ3OOtt6uCLI4qhsA==
X-Received: by 10.223.159.82 with SMTP id f18mr2382704wrg.219.1515012578106;
        Wed, 03 Jan 2018 12:49:38 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l9sm1908443wrb.45.2018.01.03.12.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 12:49:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/5] untracked cache bug fixes
Date:   Wed,  3 Jan 2018 20:49:23 +0000
Message-Id: <20180103204928.3769-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <CACsJy8BnxOz9brnkyZ58guTsUhgKKN_XQvbYaZJz17888pgHoQ@mail.gmail.com>
References: <CACsJy8BnxOz9brnkyZ58guTsUhgKKN_XQvbYaZJz17888pgHoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Took me a while to get around to this. This is a replacement for the
patches Duy and I have floating around on the list so far related to
the untracked cache bugs raised recently.

Part of this has been me incorporating Duy's work and writing commit
messages etc. for him.

Nguyễn Thái Ngọc Duy (3):
  dir.c: avoid stat() in valid_cached_dir()
  dir.c: fix missing dir invalidation in untracked code
  dir.c: stop ignoring opendir() error in open_cached_dir()

Ævar Arnfjörð Bjarmason (2):
  status: add a failing test showing a core.untrackedCache bug
  update-index doc: note a fixed bug in the untracked cache

 Documentation/git-update-index.txt | 16 +++++++
 dir.c                              | 33 ++++++++++-----
 t/t7063-status-untracked-cache.sh  | 87 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+), 11 deletions(-)

-- 
2.15.1.424.g9478a66081

