Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D0A61F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbeJ0PEw (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34831 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbeJ0PEw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id d7-v6so2494451lfi.2
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cnkd3x3pdqHZSBmE35NyqcxDv/tej/2bqZyDvDZ682E=;
        b=iJrt03y/q8mqHNtKVONOwDSEgylgT85Mrt00p0EjUbKYeNiHJirv7OMQbUhAZcx4FW
         GeQg1D2DI72i/2JIiNLY5/XMxq9hTvZtptbO0BM51mDgXgu5NTcH88NTGdKH8hzbFh/c
         urxVFBWjV//RIZJ53g6AXaQHbY+Pm5f19bfafIQYSUpLSHXW9LV+4mln+k1GT3EIiaiX
         EbSLk8hxCWFyMvqacZwTrzyL7st9oEyIcGLQZnkoEMNn96PKz0/eU+kvOfxcH/N89teh
         KXI+jfVj4u9OzUp8Dds2fPtghLCeIjJQWIxqQvSy53YhVEYxfXeV3jEoDcDOSxJ+M31j
         YJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cnkd3x3pdqHZSBmE35NyqcxDv/tej/2bqZyDvDZ682E=;
        b=pHdTdz4VXM+Md68LNlEkKI7wBfxJTp2HaDLJG+n1RSc1qp/u+6SjfJC41irzbRkMlM
         w3ELTIhjAtxSNYfq8WDjLc/aAv7nDWXI6jp0GoW8Q4U+32fc3S/Q+I9nQF7EBPh/QZp/
         I5STBUZSMTjQZviRjP3iAAUGHJ93J1czR2OftQGhzrM6FP88w1Xnx8p+/462OfR2zT8L
         nnvob5nYVSruwagCYev4yiBMPcSOravb6HknPOg6rM/oyNUzz7f2GzpTtFdSBXV7lfGX
         9GiJaBc9y2MXD2vsC0LGeWgb46wACPPNpewRTBciHJG1FgGLM87jcA3zOtwTumaSXtGt
         tzog==
X-Gm-Message-State: AGRZ1gK+5IibdpHNV7tRORf7VO2vo0Ee6Ef6fxL6kWpBBJEbhO4nJTBO
        mBBpYUMQpO0VX7AxIFPzPTrJEl4v
X-Google-Smtp-Source: AJdET5dWlJSljG2LCeuwiD8ZiXBMgYnCZ7DiI9rL0Km7eMIEjHbRh8BB8Glh9EJBG+4qpKySE3UhlQ==
X-Received: by 2002:a19:53d9:: with SMTP id h86-v6mr3993969lfl.75.1540621496243;
        Fri, 26 Oct 2018 23:24:56 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:55 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 52/78] config.txt: move protocol.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:25 +0200
Message-Id: <20181027062351.30446-53-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
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
 Documentation/config/protocol.txt | 64 ++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/config/protocol.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d55776c383..e80148a133 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -383,70 +383,7 @@ include::config/pager.txt[]
 
 include::config/pretty.txt[]
 
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
+include::config/protocol.txt[]
 
 include::pull-config.txt[]
 
diff --git a/Documentation/config/protocol.txt b/Documentation/config/protocol.txt
new file mode 100644
index 0000000000..bfccc07491
--- /dev/null
+++ b/Documentation/config/protocol.txt
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

