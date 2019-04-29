Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 060AE1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 22:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbfD2WEj (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 18:04:39 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:34334 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729398AbfD2WEj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 18:04:39 -0400
Received: by mail-ed1-f54.google.com with SMTP id a6so10567958edv.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 15:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zDooCss52vYie44Tojbhx7B39tGwAu8fiK3Q7R98HZU=;
        b=Xvn3L4nc20GMqL/fBF7soUBexlD4wWz5f+i8LGan4njFSqulFt5QyTUYfVPW/WhSUx
         G7uvgrj4AYP0mxbNHi4U45vgkrzea5H7DdOaPsvgZu7JLkLAwCsCFCz2IAW1jNTc4al2
         IPq87K47obYkBYHgxWxXApu0WR3s5+e+HOGLn6pawQJ/Z+OJc5dssA/gaNDCaNkB1/wL
         xz6SN8BcXvXBWf4i6wCvqrVMkhODi2RETHdpBBtvsxYAhumsdUXtWrTmXJ+PrLedte3Q
         Jz+jnNN+OBfLNC9vrRJvH1UtvtRJB7RZWtMJ6u3Lw4vvS+0vMVcZMV8ZeSZKbuswGMQV
         JSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zDooCss52vYie44Tojbhx7B39tGwAu8fiK3Q7R98HZU=;
        b=jX7VJYIXxrwvJzqz0C04jmFWSaM81Hp+FnaE3hbybc+jIvELFJ0rvFzGXAedjL5T4w
         mNYdL9h+U0xVTfnCcRwUGVuOE6nuiqH6sNUcAtWz6JiZ7aW4/n6RrubJGo8aNswQFoMn
         fSeO/y6MatQMN1ZSH23yDly/6UtCPQax2UGRE7jPqM7+1WbGw6/NyRJhi1C33LvOlOyE
         TcuzzmPPp5a6eO/9qTAqNOWQaqwD9ROwDAKybj+kXYOu5vlxgENov9iEj18x2yf5bqgk
         M5jQZ1wUrDRpR9S6/fVxWU4oJgw728G5j7Urf9Z5Qh7yazGP6/IHkCwemhyR/7M47R/T
         vWLQ==
X-Gm-Message-State: APjAAAWOvrtCCHnKUvv4WyoIRvUrXvpEG/vXYhMp18k7XDs8iKlYICLt
        v/ytVyMkcK57UeEo2TISt69zO8O7
X-Google-Smtp-Source: APXvYqymDlgxNuxeyLR1uXK8QcWwv/psjWn6WCoyXrY8mTEfF4/TZB9ZnE45muNGTd06Y5SuGZ2QgA==
X-Received: by 2002:a17:906:6b01:: with SMTP id q1mr5302100ejr.138.1556575476934;
        Mon, 29 Apr 2019 15:04:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9sm9762756edk.56.2019.04.29.15.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 15:04:36 -0700 (PDT)
Date:   Mon, 29 Apr 2019 15:04:36 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 22:04:35 GMT
Message-Id: <31aa7bfcab834b753cc9f52fc9cc187f65e2d964.1556575475.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.137.git.gitgitgadget@gmail.com>
References: <pull.137.git.gitgitgadget@gmail.com>
From:   "Thomas Braun via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] mingw: optionally disable side-band-64k for transport
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Braun <thomas.braun@byte-physics.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Braun <thomas.braun@byte-physics.de>

Since commit 0c499ea60f (send-pack: demultiplex a sideband stream with
status data, 2010-02-05) the built-in send-pack uses the side-band-64k
capability if advertised by the server.

Unfortunately this breaks pushing over the dump git protocol if used
over a network connection when using MinGW (but *not* when using
mingw-w64).

The detailed reasons for this, are courtesy of Jeff Preshing, quoted
from https://groups.google.com/d/msg/msysgit/at8D7J-h7mw/eaLujILGUWoJ:

	MinGW wraps Windows sockets in CRT file descriptors in order to
	mimic the functionality of POSIX sockets. This causes msvcrt.dll
	to treat sockets as Installable File System (IFS) handles,
	calling ReadFile, WriteFile, DuplicateHandle and CloseHandle on
	them. This approach works well in simple cases on recent
	versions of Windows, but does not support all usage patterns.
	In particular, using this approach, any attempt to read & write
	concurrently on the same socket (from one or more processes)
	will deadlock in a scenario where the read waits for a response
	from the server which is only invoked after the write. This is
	what send_pack currently attempts to do in the use_sideband
	codepath.

The new config option "sendpack.sideband" allows to override the
side-band-64k capability of the server, and thus makes the dump git
protocol work.

As this only affects builds against MinGW, the default is still to use
side band.

[jes: split out the documentation into Documentation/config/, touched up
the commit message.]

Signed-off-by: Thomas Braun <thomas.braun@byte-physics.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt          |  2 ++
 Documentation/config/sendpack.txt |  5 +++++
 send-pack.c                       | 14 +++++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/config/sendpack.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d87846faa6..e9b2d10e99 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -406,6 +406,8 @@ include::config/reset.txt[]
 
 include::config/sendemail.txt[]
 
+include::config/sendpack.txt[]
+
 include::config/sequencer.txt[]
 
 include::config/showbranch.txt[]
diff --git a/Documentation/config/sendpack.txt b/Documentation/config/sendpack.txt
new file mode 100644
index 0000000000..e306f657fb
--- /dev/null
+++ b/Documentation/config/sendpack.txt
@@ -0,0 +1,5 @@
+sendpack.sideband::
+	Allows to disable the side-band-64k capability for send-pack even
+	when it is advertised by the server. Makes it possible to work
+	around a limitation in the git for windows implementation together
+	with the dump git protocol. Defaults to true.
diff --git a/send-pack.c b/send-pack.c
index 6dc16c3211..fa9e8cf1fc 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -38,6 +38,16 @@ int option_parse_push_signed(const struct option *opt,
 	die("bad %s argument: %s", opt->long_name, arg);
 }
 
+static int config_use_sideband = 1;
+
+static int send_pack_config(const char *var, const char *value, void *unused)
+{
+	if (!strcmp("sendpack.sideband", var))
+		config_use_sideband = git_config_bool(var, value);
+
+	return 0;
+}
+
 static void feed_object(const struct object_id *oid, FILE *fh, int negative)
 {
 	if (negative && !has_object_file(oid))
@@ -390,6 +400,8 @@ int send_pack(struct send_pack_args *args,
 	const char *push_cert_nonce = NULL;
 	struct packet_reader reader;
 
+	git_config(send_pack_config, NULL);
+
 	/* Does the other end support the reporting? */
 	if (server_supports("report-status"))
 		status_report = 1;
@@ -397,7 +409,7 @@ int send_pack(struct send_pack_args *args,
 		allow_deleting_refs = 1;
 	if (server_supports("ofs-delta"))
 		args->use_ofs_delta = 1;
-	if (server_supports("side-band-64k"))
+	if (config_use_sideband && server_supports("side-band-64k"))
 		use_sideband = 1;
 	if (server_supports("quiet"))
 		quiet_supported = 1;
-- 
gitgitgadget
