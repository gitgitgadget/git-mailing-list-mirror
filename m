Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDABC20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 15:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbeLMP6a (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 10:58:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38681 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbeLMP6a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 10:58:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so2924217wml.3
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 07:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eTco90dHBcdffVsiSzHCp9xu9lZeK19Nar2IIVCqbb4=;
        b=os/xj/b6+6UCpg4QKo13a0sWM+QF/gQ5bK5gUEYsK8y9r2yKACCD9p62HjlX6dEgkM
         CKqoapnRxmkDlSYlc+sX7UfiR0GJsPCPfD4OrYT9gy00qMBTsBs2NfxiKlfdU0MSWg8x
         y6z7lg+spp+LLhV1UQ1r81CHnz4fo9YDpZAh0zx/NWQE9CptqQTtuin/Sg9HgfYsGGVN
         bolsQgCNIipibQbj073eHJ6OCJqKm1Z+1wJsdutqroptkqV3H53oEoERPAu8hj0PW18s
         wUFxD5bWJxtaG6PxLnOKI4jFX7EepPqSMgnAOrymGJwRZF2MOBAwOc4KO5E2446f/xMJ
         Ashg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eTco90dHBcdffVsiSzHCp9xu9lZeK19Nar2IIVCqbb4=;
        b=Vc7RxNz3koYfZ2eMGuHF23yKQqv43x3lXql95+a6uQO0K9KsQXzlEpeMEzt9/2QH0c
         uwThBGk1U0zvifqDXurJpJ+71I8GXEijk7p+brrVFkzZvZuPklaBZRRSrm3E3lVzOYCT
         2H9xZZsS0ZLiT+c9c+H1Flv60t1nIoNHc3Zd24caDUImkJu7RzQdfoXeCZMedfgYDIEv
         H9GeftdfzSylTGaGql9aaxxu7L4OECNtqa+xfbXW2BtC1jgsCh2Zt8z2FjLg+Nix5/43
         FVBg5ZJ/OA5U9BQXeYTUJFxwExRnGI+S4zQd61tVtNLZzkRbCvO8G2U6/tXqqntCkcMi
         bXpg==
X-Gm-Message-State: AA+aEWa0GKnUTQ2VTdY/IJbFtV1Fif4StBZTZjHfNFuelC5WCoCqSpuD
        3L4/Pnz7Gjyo/RJfmfPomGz9KCzG
X-Google-Smtp-Source: AFSGD/Vu8LR0LkvqfFBLYIrHzkAMz/ujtc3vTLQEorNQjTMbnUBGtScnGhHqnFFoPNcIWz8+WzAXbw==
X-Received: by 2002:a1c:dd04:: with SMTP id u4mr10735058wmg.84.1544716706775;
        Thu, 13 Dec 2018 07:58:26 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r69sm4047821wmd.4.2018.12.13.07.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 07:58:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/8] protocol v2 fixes
Date:   Thu, 13 Dec 2018 16:58:09 +0100
Message-Id: <20181213155817.27666-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I figured it would be easier for everyone if I rolled this all into
one series instead of Junio & us needing to keep track of what's based
on what.

The only change I made to Jeff's patches is my SOB and adding a
paragraph to the end of his 3/3 saying that the v2 push protocol
doesn't have the same issue (because it doesn't exist yet). I had that
question in this thread, and thought it was useful to clarify it.

No changes to Jonathan's one patch, except my SOB.

For the rest I incorporated Jonathan's suggestions / fixes with some
amendments. The suggestion to use env --unset isn't portable (and
there's now a check for that while we're at it), so instead we support
"GIT_TEST_PROTOCOL_VERSION=" which'll ignore the environment value.

Other changes in my patches are more narrowly skipping tests, i.e. no
"unset" anymore except for those tests where we're only doing v1 and
v2 tests. I also removed the "env" use in those cases that don't need
it (where we use e.g. test_must_fail), instead we just set the env
variable ourselves with native shell syntax.

Jeff King (3):
  serve: pass "config context" through to individual commands
  parse_hide_refs_config: handle NULL section
  upload-pack: support hidden refs with protocol v2

Jonathan Tan (1):
  builtin/fetch-pack: support protocol version 2

Ævar Arnfjörð Bjarmason (4):
  tests: add a check for unportable env --unset
  tests: add a special setup where for protocol.version
  tests: mark & fix tests broken under GIT_TEST_PROTOCOL_VERSION=1
  tests: mark tests broken under GIT_TEST_PROTOCOL_VERSION=2

 builtin/fetch-pack.c                 |  9 ++++++---
 builtin/upload-pack.c                |  1 +
 ls-refs.c                            | 16 +++++++++++++++-
 ls-refs.h                            |  3 ++-
 protocol.c                           | 13 ++++++++++++-
 refs.c                               |  3 ++-
 serve.c                              |  9 +++++----
 serve.h                              |  7 +++++++
 t/README                             |  6 ++++++
 t/check-non-portable-shell.pl        |  1 +
 t/t0410-partial-clone.sh             |  3 ++-
 t/t5400-send-pack.sh                 |  2 +-
 t/t5500-fetch-pack.sh                |  9 ++++++---
 t/t5503-tagfollow.sh                 |  8 ++++----
 t/t5512-ls-remote.sh                 | 14 ++++++++++----
 t/t5515-fetch-merge-logic.sh         |  2 +-
 t/t5516-fetch-push.sh                | 20 +++++++++++++-------
 t/t5537-fetch-shallow.sh             |  3 ++-
 t/t5539-fetch-http-shallow.sh        |  9 +++++----
 t/t5541-http-push-smart.sh           |  9 +++++++--
 t/t5551-http-fetch-smart.sh          | 19 +++++++++++--------
 t/t5552-skipping-fetch-negotiator.sh |  4 ++--
 t/t5570-git-daemon.sh                |  2 +-
 t/t5601-clone.sh                     | 11 +++++++++--
 t/t5700-protocol-v1.sh               |  1 +
 t/t5702-protocol-v2.sh               |  1 +
 t/t7406-submodule-update.sh          |  3 ++-
 upload-pack.c                        |  4 ++--
 upload-pack.h                        |  4 ++--
 29 files changed, 139 insertions(+), 57 deletions(-)

-- 
2.20.0.405.gbc1bbc6f85

