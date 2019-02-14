Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9167F1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 19:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405556AbfBNTGr (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 14:06:47 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:44662 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405544AbfBNTGq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 14:06:46 -0500
Received: by mail-pg1-f201.google.com with SMTP id a2so4947775pgt.11
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 11:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=++hSdkUpqpsSuoeFbgXx6WKJlgGm28wjyEz20Xf4KTk=;
        b=CMY0DFB873AZIkI7/KIiVIo2cHTAygZSw0RINhn1muRjHikHYFDJ/TYlNanvqVSrbG
         e8Nl7QQaCiMfXipL8K2Sr6nLkdesP/58+chktEsfrBq4L310Oz2JH6ifzz/tgnsluuk3
         bFhHThMUiPT8af2ir7Fpc36G8Lfe62n2kT9r4BQXd6eywShAyu9sCyqu3vTkmfFoUhkf
         DPodnHfr8pexUfdciQ/3tC2lnMX/Ca1EobO9r+zy1b7lOgf+OtEVy6dTYVQPXdTHQ8oX
         ADyUfr5Q0L4Qc6ku0r4ZoOM16heARSO1RufMDwArHbiH67L02S0/lkUSRSdkB+H4waEi
         YxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=++hSdkUpqpsSuoeFbgXx6WKJlgGm28wjyEz20Xf4KTk=;
        b=UoolBmxhHXxhnLTNXZTkRBxlXR0yfCX/GPda463/zEGH42xenswLAueY3aYT+hApm3
         nAfmU50O5SJoyabU9Ckjlu3o/vJ+MdOLYYadBE4thO9AiXX+6nffBo+4SkS7Jv6XBWxT
         myNK/Rzl3ijYOaoDiabGcGEVxVyEFQyqwUE3Nn6o8xvD0Q7Ldgf0xoQdBrQ+LvplN//x
         1gM5mU+S2khTsC1U7+mwAZrKcOfYT5+wwqgIvnfe2ALlCkTmTNIo0WePxbGKUWyqO00D
         zdSNCt4sZQKJv3cbThhN6QFiFEcL8pcRLGk8NWh14xceFPsxB0fQbAL9f8x1SfqlL1pw
         F7sQ==
X-Gm-Message-State: AHQUAuaBbhupPrTOgIsqmadbdRQufgqjzAcGHrqFX3u87s+ybE6NoWHi
        ZDaia4Cg01qCcdJq72/fnnBat88Z/EY1QhpMJN/qiVwbuGHmu9o1ZxDwI9HjeyIjVLZUWWuFeFx
        +2ytcOuA7BRNMI0hWX9P4rb9FF5rXQz6kiTdkEwuGLg/uFDa+W0K8PYoVGex/cSvBaFW/BgHYjD
        99
X-Google-Smtp-Source: AHgI3IavM3x8rCY/cphZACHO7mOFWepwYN6fylGOund/JnuJZp8R7yqKgh84r/FfoqBXCR9xAxHYfMCDaWlbBntQ6qEn
X-Received: by 2002:a62:3286:: with SMTP id y128mr2026270pfy.82.1550171205840;
 Thu, 14 Feb 2019 11:06:45 -0800 (PST)
Date:   Thu, 14 Feb 2019 11:06:34 -0800
Message-Id: <cover.1550170980.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 0/5] Protocol v2 fix: http and auth
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peff noticed an issue with my http auth in protocol v2 patch earlier
[1], and in the ensuing discussion, I thought that it would be best to
make v2 use post_rpc() as well (to be the same as v0/v1) instead of
using its own functions, to fix this issue and try to avoid a similar
issue in the future. Besides that, there is also a net reduction in
lines of code.

So here are the patches. First 4 are refactoring - the last one has the
actual change. This is on the master branch.

[1] https://public-inbox.org/git/20190206212928.GB12737@sigill.intra.peff.net/

Jonathan Tan (5):
  remote-curl: reduce scope of rpc_state.argv
  remote-curl: reduce scope of rpc_state.stdin_preamble
  remote-curl: reduce scope of rpc_state.result
  remote-curl: refactor reading into rpc_state's buf
  remote-curl: use post_rpc() for protocol v2 also

 pkt-line.c             |   2 +-
 pkt-line.h             |   1 +
 remote-curl.c          | 351 ++++++++++++++++++-----------------------
 t/t5702-protocol-v2.sh |  26 ++-
 4 files changed, 181 insertions(+), 199 deletions(-)

-- 
2.19.0.271.gfe8321ec05.dirty

