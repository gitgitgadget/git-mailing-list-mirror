Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9B7F20248
	for <e@80x24.org>; Tue,  9 Apr 2019 20:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDIUbj (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 16:31:39 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:44415 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfDIUbj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 16:31:39 -0400
Received: by mail-vk1-f202.google.com with SMTP id f3so8908232vkb.11
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 13:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=umBF97FPxq5eFNMnh7m87tyGpxrYccxwVo5zigdamHw=;
        b=k+qbMeW7qIVgmn4fYS1lUlw5JiXnrq0vyMV5rwb/ITfZEhZ4p5d1WdWu6wruSy8+HY
         ALbhE5QMzKWMB/di7paYJRb2iskz0MVeh1wSeOQ2RVu8E5JRgAyxAHzJAXXjCSuhZncQ
         6IHWapBQupxvIwu7QbvXXe4d8vRIORberFKTJn3Uu72GTxD1kewCZY66wV5fDm/ttuhm
         M/hhN4ywvDX/zigmc9ym0ewLGeqbRcX2xSCrcgSg+XVKRpkzXrivBmRra/eVYWTEBwJ2
         FmcElIX4BX2e9iBficrSjgFO9FQsyhMGaS0wudH/mlVikpUX6W0Y2Y5vJxYuRYgceLmM
         xi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=umBF97FPxq5eFNMnh7m87tyGpxrYccxwVo5zigdamHw=;
        b=DUZ07ZuxR9mm6eqQKfGnLQNX0QDZ0fbmXszA84HgdEdtUnvU18PfK6RJ15favzH6U+
         eTW74R53enxFM9Mjf72TFgYUA5CuZ6687pke7lon4ElehxvRRXXDhES1Lkj/oGKobaTh
         8vwwunIQK3kNZEkiUUKAiXpm3yuzusz+tTmSDja43hU6z3x6SbPNkRaUj2uVMCW3Rl3L
         MtjnqFdeZLI10+uhE2sXH/IgipVAM304z+YHdGr9T4xSdX6APCrD24QgPCi11oKLlTs0
         fbJj60OmfmmWagQfcX4KYlGXlzp5EAC92gZOA51WxxaQ/UnncGrY+ykPeZ68B/2i8gwf
         Bbvw==
X-Gm-Message-State: APjAAAUl/98PuLrQtHIJAx1lNgW+G3XgXt0LTRWejeqbHQ0yQEkuYrU5
        kW93ieDMPLTW7Kzma3/x1yFH/2BpDr/V0uwCn672QZIFAuUBxPHe66yluKyj5xeJFbIePffyUkq
        7JtJHQKkmpWlRv9jbUeRoTOlmYkXNaMGJLqPCNE7On8JSvROjngQ4iudAgQyXvd3oTx5qG2/yf3
        yR
X-Google-Smtp-Source: APXvYqyAnipJqg9MdtVaiWXSTwk3MGFfPpNXJVg5CLp4PCmhD6jhxyftyDhOFmoP79qfM6m+Gig5RYwDCm5PlTQMNnkn
X-Received: by 2002:a67:c911:: with SMTP id w17mr1490561vsk.3.1554841897652;
 Tue, 09 Apr 2019 13:31:37 -0700 (PDT)
Date:   Tue,  9 Apr 2019 13:31:32 -0700
In-Reply-To: <20190405204413.93900-1-jonathantanmy@google.com>
Message-Id: <cover.1554841624.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190405204413.93900-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v2 0/2] Server options when cloning
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I created v2 by rewriting jt/clone-server-option, so you'll see some
Reviewed-by lines and Signed-off-by lines with another name than mine.

Changes from v1:
 - Broke long line. (DUP->NODUP was already done by Junio in
   jt/clone-server-option, so you don't see it in the range-diff below.)
 - Warn if server-option is specified but not sent to the server (in
   fetch and clone).
 - Document that server's handling of server-option is server-specific.

These patches are on maint, matching jt/clone-server-option, but should
apply cleanly on master too.

Jonathan Tan (2):
  transport: warn if server options are unsupported
  clone: send server options when using protocol v2

 Documentation/fetch-options.txt |  3 ++-
 Documentation/git-clone.txt     |  8 +++++++
 builtin/clone.c                 |  6 ++++++
 t/t5702-protocol-v2.sh          | 38 +++++++++++++++++++++++++++++++++
 transport.c                     |  8 +++++++
 5 files changed, 62 insertions(+), 1 deletion(-)

Range-diff against v1:
-:  ---------- > 1:  af3cc05324 transport: warn if server options are unsupported
1:  90ce94e039 ! 2:  142c25abd2 clone: send server options when using protocol v2
    @@ -11,10 +11,27 @@
         has "-o" for another parameter, teach "clone" only to receive
         "--server-option".
     
    +    Explain in the documentation, both for clone and for fetch, that server
    +    handling of server options are server-specific.
    +
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
         Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    + diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
    + --- a/Documentation/fetch-options.txt
    + +++ b/Documentation/fetch-options.txt
    +@@
    + --server-option=<option>::
    + 	Transmit the given string to the server when communicating using
    + 	protocol version 2.  The given string must not contain a NUL or LF
    +-	character.
    ++	character.  The server's handling of server options, including
    ++	unknown ones, is server-specific.
    + 	When multiple `--server-option=<option>` are given, they are all
    + 	sent to the other side in the order listed on the command line.
    + 
    +
      diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
      --- a/Documentation/git-clone.txt
      +++ b/Documentation/git-clone.txt
    @@ -25,7 +42,8 @@
     +--server-option=<option>::
     +	Transmit the given string to the server when communicating using
     +	protocol version 2.  The given string must not contain a NUL or LF
    -+	character.
    ++	character.  The server's handling of server options, including
    ++	unknown ones, is server-specific.
     +	When multiple `--server-option=<option>` are given, they are all
     +	sent to the other side in the order listed on the command line.
     +
    @@ -48,8 +66,8 @@
      		   N_("separate git dir from working tree")),
      	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
      			N_("set config inside the new repository")),
    -+	OPT_STRING_LIST(0, "server-option", &server_options, N_("server-specific"),
    -+			N_("option to transmit")),
    ++	OPT_STRING_LIST(0, "server-option", &server_options,
    ++			N_("server-specific"), N_("option to transmit")),
      	OPT_SET_INT('4', "ipv4", &family, N_("use IPv4 addresses only"),
      			TRANSPORT_FAMILY_IPV4),
      	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
    @@ -68,7 +86,7 @@
      --- a/t/t5702-protocol-v2.sh
      +++ b/t/t5702-protocol-v2.sh
     @@
    - 	grep "server-option=world" log
    + 	grep "Ignoring server options" err
      '
      
     +test_expect_success 'server-options are sent when cloning' '
    @@ -81,6 +99,16 @@
     +	grep "server-option=hello" log &&
     +	grep "server-option=world" log
     +'
    ++
    ++test_expect_success 'warn if using server-option with clone with legacy protocol' '
    ++	test_when_finished "rm -rf myclone" &&
    ++
    ++	GIT_TEST_PROTOCOL_VERSION=0 git -c protocol.version=0 \
    ++		clone --server-option=hello --server-option=world \
    ++		"file://$(pwd)/file_parent" myclone 2>err &&
    ++
    ++	grep "Ignoring server options" err
    ++'
     +
      test_expect_success 'upload-pack respects config using protocol v2' '
      	git init server &&
-- 
2.21.0.392.gf8f6787159e-goog

