Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D35FD1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeJTUu3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40884 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbeJTUu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id r83-v6so33087473ljr.7
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ADiVqlUm/b0kdF+Gkq/SFbu25n54BU53BlFuUamW26Y=;
        b=g2gQ7GLzq/YlGqYnRvoidWpj8QEpukqsWo0kMyRfQh5mxZdIQrVeE0uWVI8nYnLHJa
         tsfecIs4Cgt3dU5GfniOH9Unlro78Z0myDnbUKqR+jNvYirQZiM8f68Nmrts8C58hva5
         21Jjl2A2QgRy2OPlDI3/4J868s3IlcFKR21LoGJzhs0AlGagBmCTo3QYQy1bWOmHw/G6
         VFH6HnBNB0SuTLVfLFTWPM8iJm/zXxR15mww8H3ZhwOK5+AliwrfxDVBD/zzpIO54Svq
         c6ObTtxFkfdakEz8laqmzrcINiOyq6Aam/MnpSK1EPesZirMk+CY08y3sTg0ls+QDdLf
         E6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ADiVqlUm/b0kdF+Gkq/SFbu25n54BU53BlFuUamW26Y=;
        b=jBK5GoLmzAQtwZSYMRFGBfN3O068QIZxhHYwnZeZpl51/cx94oREk5cIRI7JveFI3c
         MmGSKLCUJ/kiYK6INGtugd50SkZXF9/T8yzE54xHhdWfP/7BogF4Y3SNXau51a+eodqJ
         jr6xpVDjxsiK98BtsWfTjGjVVEmNNeNd/Q7R+HKx5wsOP3DOU+j2zvwYNpfSC2UOREjb
         2eUm9MaZsGXsP1XVIq2ww3KuZ9nqpHtCsGj0pZJ3c9bbAxLV++9TuiZBCuGZtb0EKp10
         FoDfVzK8JZ3AqSqFRC8sUg6h+VfSNfF0hbrR+hJ36nXENq+BpylIKX2OcK9LmuvetW2v
         epwg==
X-Gm-Message-State: ABuFfoiKy+ugvzHb8pzCok9HRqA84GtmBEQwBoQAI5l/PH1euK3HOiiJ
        PO1zi/nLJQtcbYWuCkG+n503xRWN
X-Google-Smtp-Source: ACcGV62o7rftqmo0K95tJ+O6fLxqfH98Fjl4IQUelpXL/pbNZQ21NOptXXP2FcTXvQIweExXYL09Wg==
X-Received: by 2002:a2e:1241:: with SMTP id t62-v6mr24483511lje.81.1540039206634;
        Sat, 20 Oct 2018 05:40:06 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:40:05 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 42/59] config.txt: move protocol.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:31 +0200
Message-Id: <20181020123848.2785-43-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181020123848.2785-1-pclouds@gmail.com>
References: <20181020123848.2785-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt          | 65 +------------------------------
 Documentation/protocol-config.txt | 64 ++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/protocol-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 364e5fdbf1..f57b494041 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -634,70 +634,7 @@ include::pager-config.txt[]
 
 include::pretty-config.txt[]
 
-protocol.allow::
-	If set, provide a user defined default policy for all protocols which
-	don't explicitly have a policy (`protocol.<name>.allow`).  By default,
-	if unset, known-safe protocols (http, https, git, ssh, file) have a
-	default policy of `always`, known-dangerous protocols (ext) have a
-	default policy of `never`, and all other protocols have a default
-	policy of `user`.  Supported policies:
-+
---
-
-* `always` - protocol is always able to be used.
-
-* `never` - protocol is never able to be used.
-
-* `user` - protocol is only able to be used when `GIT_PROTOCOL_FROM_USER` is
-  either unset or has a value of 1.  This policy should be used when you want a
-  protocol to be directly usable by the user but don't want it used by commands which
-  execute clone/fetch/push commands without user input, e.g. recursive
-  submodule initialization.
-
---
-
-protocol.<name>.allow::
-	Set a policy to be used by protocol `<name>` with clone/fetch/push
-	commands. See `protocol.allow` above for the available policies.
-+
-The protocol names currently used by git are:
-+
---
-  - `file`: any local file-based path (including `file://` URLs,
-    or local paths)
-
-  - `git`: the anonymous git protocol over a direct TCP
-    connection (or proxy, if configured)
-
-  - `ssh`: git over ssh (including `host:path` syntax,
-    `ssh://`, etc).
-
-  - `http`: git over http, both "smart http" and "dumb http".
-    Note that this does _not_ include `https`; if you want to configure
-    both, you must do so individually.
-
-  - any external helpers are named by their protocol (e.g., use
-    `hg` to allow the `git-remote-hg` helper)
---
-
-protocol.version::
-	Experimental. If set, clients will attempt to communicate with a
-	server using the specified protocol version.  If unset, no
-	attempt will be made by the client to communicate using a
-	particular protocol version, this results in protocol version 0
-	being used.
-	Supported versions:
-+
---
-
-* `0` - the original wire protocol.
-
-* `1` - the original wire protocol with the addition of a version string
-  in the initial response from the server.
-
-* `2` - link:technical/protocol-v2.html[wire protocol version 2].
-
---
+include::protocol-config.txt[]
 
 include::pull-config.txt[]
 
diff --git a/Documentation/protocol-config.txt b/Documentation/protocol-config.txt
new file mode 100644
index 0000000000..bfccc07491
--- /dev/null
+++ b/Documentation/protocol-config.txt
@@ -0,0 +1,64 @@
+protocol.allow::
+	If set, provide a user defined default policy for all protocols which
+	don't explicitly have a policy (`protocol.<name>.allow`).  By default,
+	if unset, known-safe protocols (http, https, git, ssh, file) have a
+	default policy of `always`, known-dangerous protocols (ext) have a
+	default policy of `never`, and all other protocols have a default
+	policy of `user`.  Supported policies:
++
+--
+
+* `always` - protocol is always able to be used.
+
+* `never` - protocol is never able to be used.
+
+* `user` - protocol is only able to be used when `GIT_PROTOCOL_FROM_USER` is
+  either unset or has a value of 1.  This policy should be used when you want a
+  protocol to be directly usable by the user but don't want it used by commands which
+  execute clone/fetch/push commands without user input, e.g. recursive
+  submodule initialization.
+
+--
+
+protocol.<name>.allow::
+	Set a policy to be used by protocol `<name>` with clone/fetch/push
+	commands. See `protocol.allow` above for the available policies.
++
+The protocol names currently used by git are:
++
+--
+  - `file`: any local file-based path (including `file://` URLs,
+    or local paths)
+
+  - `git`: the anonymous git protocol over a direct TCP
+    connection (or proxy, if configured)
+
+  - `ssh`: git over ssh (including `host:path` syntax,
+    `ssh://`, etc).
+
+  - `http`: git over http, both "smart http" and "dumb http".
+    Note that this does _not_ include `https`; if you want to configure
+    both, you must do so individually.
+
+  - any external helpers are named by their protocol (e.g., use
+    `hg` to allow the `git-remote-hg` helper)
+--
+
+protocol.version::
+	Experimental. If set, clients will attempt to communicate with a
+	server using the specified protocol version.  If unset, no
+	attempt will be made by the client to communicate using a
+	particular protocol version, this results in protocol version 0
+	being used.
+	Supported versions:
++
+--
+
+* `0` - the original wire protocol.
+
+* `1` - the original wire protocol with the addition of a version string
+  in the initial response from the server.
+
+* `2` - link:technical/protocol-v2.html[wire protocol version 2].
+
+--
-- 
2.19.1.647.g708186aaf9

