Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E38B1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 21:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388553AbfKHVij (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 16:38:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36278 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388444AbfKHVij (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 16:38:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so8643433wrx.3
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 13:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=niemier-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8D60MFcn0y/ZrocvXjUgk9pOET5QKILUlFinNlp4F5w=;
        b=Sj1kNXJ9zeZSz+Wpj8fiHRf7DM8/XuOUNTTWp0YucJ3gzw7tl9jEEn332tIo5v4deD
         QoVaM/mS3LwXIjIuGfp4avck+gmOgUNMZ7k691gfuCH1J0+riwQ6+O8W6TWlVx/2OhPY
         Ikn/kY/yWDbFyUuSTXQGa1mfpGtDZi2FOsjiQUerWxbnc8Lq6P892hgQO/2wHEnMovEA
         H0Bdd/njZzodQtxFr1J3nCh4novRgWgkjeUEE2DOQt7hY5KnOpHIDticTW107h/uHZxQ
         PTysJLa2UD1S4xTPOdsDT5McUbULusz0JoGGEh7sfCnpBPutXvFl0vh7+Jb8lD6Bn3Jb
         5XmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8D60MFcn0y/ZrocvXjUgk9pOET5QKILUlFinNlp4F5w=;
        b=WmMwJNngs8Kg+YeOuYkvHczuTUl84DBTwCZksi8G0mDack+5lRcyjY2CHDdz2aBUC+
         1pY9ib5IrxzjXAd2HWwJFrQHfdkoikC4pHRiAO+A8k8WBSJLgIopx/0xqg2KjRo2Hb4M
         JOP2au11OKWmS/NTbP/gMD+2HMOgzkwNgJykaJyJ6mvQv+VPDsGIymOacl53b3WacsJI
         VvU1tmwnRdEEELm32Wu+tGxnfog+rYg+NB3yqqnctDk9c+iXh0ysmu4j0MZzTiBKVa9D
         PthKvc3E+cwMFrbQ1CL0XhLo6rGd38WfByAXhjvpHcHIIqEYJGi5nf/Ri8mRJzc+Q3pl
         gXWg==
X-Gm-Message-State: APjAAAXrO+ZFX9c+b9M7L2jeCD7G4MSwLdt8f9IGIw7Ccf7e63FbkDNy
        BUnm0tgb3jmrBfyCK6VtpYePNFC6JS4Wug==
X-Google-Smtp-Source: APXvYqyDYFhm9j/AhmIU0EpQreISYnM7GtcRVadtu7PIAh5R32Eysrha/kkjNl15G1xYg23XOIZzlQ==
X-Received: by 2002:a5d:6351:: with SMTP id b17mr7167989wrw.126.1573249117321;
        Fri, 08 Nov 2019 13:38:37 -0800 (PST)
Received: from niuniobook.home (83.25.107.61.ipv4.supernova.orange.pl. [83.25.107.61])
        by smtp.gmail.com with ESMTPSA id w7sm2996835wru.62.2019.11.08.13.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 13:38:36 -0800 (PST)
From:   =?UTF-8?q?=C5=81ukasz=20Niemier?= <lukasz@niemier.pl>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Niemier?= <lukasz@niemier.pl>
Subject: [PATCH v4] userdiff: add Elixir to supported userdiff languages
Date:   Fri,  8 Nov 2019 22:38:24 +0100
Message-Id: <20191108213824.11622-1-lukasz@niemier.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106234941.48926-1-lukasz@niemier.pl>
References: <20191106234941.48926-1-lukasz@niemier.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds support for xfuncref in Elixir[1] language which is Ruby-like
language that runs on Erlang[3] Virtual Machine (BEAM).

[1]: https://elixir-lang.org
[2]: https://www.erlang.org

Signed-off-by: Łukasz Niemier <lukasz@niemier.pl>
---
Add entry to the documentation of gitattributes as well.

 Documentation/gitattributes.txt        |  2 ++
 t/t4018-diff-funcname.sh               |  1 +
 t/t4018/elixir-do-not-pick-end         |  5 +++++
 t/t4018/elixir-ex-unit-test            |  6 ++++++
 t/t4018/elixir-function                |  5 +++++
 t/t4018/elixir-macro                   |  5 +++++
 t/t4018/elixir-module                  |  9 +++++++++
 t/t4018/elixir-module-func             |  8 ++++++++
 t/t4018/elixir-nested-module           |  9 +++++++++
 t/t4018/elixir-private-function        |  5 +++++
 t/t4018/elixir-protocol                |  6 ++++++
 t/t4018/elixir-protocol-implementation |  5 +++++
 userdiff.c                             | 12 ++++++++++++
 13 files changed, 78 insertions(+)
 create mode 100644 t/t4018/elixir-do-not-pick-end
 create mode 100644 t/t4018/elixir-ex-unit-test
 create mode 100644 t/t4018/elixir-function
 create mode 100644 t/t4018/elixir-macro
 create mode 100644 t/t4018/elixir-module
 create mode 100644 t/t4018/elixir-module-func
 create mode 100644 t/t4018/elixir-nested-module
 create mode 100644 t/t4018/elixir-private-function
 create mode 100644 t/t4018/elixir-protocol
 create mode 100644 t/t4018/elixir-protocol-implementation

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index c5a528c667..03d8fe6f30 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -812,6 +812,8 @@ patterns are available:
 
 - `dts` suitable for devicetree (DTS) files.
 
+- `elixir` suitable for source code in the Elixir language.
+
 - `fortran` suitable for source code in the Fortran language.
 
 - `fountain` suitable for Fountain documents.
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 6f5ef0035e..c0f4839543 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -32,6 +32,7 @@ diffpatterns="
 	csharp
 	css
 	dts
+	elixir
 	fortran
 	fountain
 	golang
diff --git a/t/t4018/elixir-do-not-pick-end b/t/t4018/elixir-do-not-pick-end
new file mode 100644
index 0000000000..fae08ba7e8
--- /dev/null
+++ b/t/t4018/elixir-do-not-pick-end
@@ -0,0 +1,5 @@
+defmodule RIGHT do
+end
+#
+#
+# ChangeMe; do not pick up 'end' line
diff --git a/t/t4018/elixir-ex-unit-test b/t/t4018/elixir-ex-unit-test
new file mode 100644
index 0000000000..0560a2b697
--- /dev/null
+++ b/t/t4018/elixir-ex-unit-test
@@ -0,0 +1,6 @@
+defmodule Test do
+  test "RIGHT" do
+    assert true == true
+    assert ChangeMe
+  end
+end
diff --git a/t/t4018/elixir-function b/t/t4018/elixir-function
new file mode 100644
index 0000000000..d452f495a7
--- /dev/null
+++ b/t/t4018/elixir-function
@@ -0,0 +1,5 @@
+def function(RIGHT, arg) do
+  # comment
+  # comment
+  ChangeMe
+end
diff --git a/t/t4018/elixir-macro b/t/t4018/elixir-macro
new file mode 100644
index 0000000000..4f925e9ad4
--- /dev/null
+++ b/t/t4018/elixir-macro
@@ -0,0 +1,5 @@
+defmacro foo(RIGHT) do
+  # Code
+  # Code
+  ChangeMe
+end
diff --git a/t/t4018/elixir-module b/t/t4018/elixir-module
new file mode 100644
index 0000000000..91a4e7aa20
--- /dev/null
+++ b/t/t4018/elixir-module
@@ -0,0 +1,9 @@
+defmodule RIGHT do
+  @moduledoc """
+  Foo bar
+  """
+
+  def ChangeMe(a) where is_map(a) do
+    a
+  end
+end
diff --git a/t/t4018/elixir-module-func b/t/t4018/elixir-module-func
new file mode 100644
index 0000000000..c9910d0675
--- /dev/null
+++ b/t/t4018/elixir-module-func
@@ -0,0 +1,8 @@
+defmodule Foo do
+  def fun(RIGHT) do
+     # Code
+     # Code
+     # Code
+     ChangeMe
+  end
+end
diff --git a/t/t4018/elixir-nested-module b/t/t4018/elixir-nested-module
new file mode 100644
index 0000000000..771ebc5c42
--- /dev/null
+++ b/t/t4018/elixir-nested-module
@@ -0,0 +1,9 @@
+defmodule MyApp.RIGHT do
+  @moduledoc """
+  Foo bar
+  """
+
+  def ChangeMe(a) where is_map(a) do
+    a
+  end
+end
diff --git a/t/t4018/elixir-private-function b/t/t4018/elixir-private-function
new file mode 100644
index 0000000000..1aabe33b7a
--- /dev/null
+++ b/t/t4018/elixir-private-function
@@ -0,0 +1,5 @@
+defp function(RIGHT, arg) do
+  # comment
+  # comment
+  ChangeMe
+end
diff --git a/t/t4018/elixir-protocol b/t/t4018/elixir-protocol
new file mode 100644
index 0000000000..7d9173691e
--- /dev/null
+++ b/t/t4018/elixir-protocol
@@ -0,0 +1,6 @@
+defprotocol RIGHT do
+  @doc """
+  Calculates the size (and not the length!) of a data structure
+  """
+  def size(data, ChangeMe)
+end
diff --git a/t/t4018/elixir-protocol-implementation b/t/t4018/elixir-protocol-implementation
new file mode 100644
index 0000000000..f9234bbfc4
--- /dev/null
+++ b/t/t4018/elixir-protocol-implementation
@@ -0,0 +1,5 @@
+defimpl RIGHT do
+  # Docs
+  # Docs
+  def foo(ChangeMe), do: :ok
+end
diff --git a/userdiff.c b/userdiff.c
index e187d356f6..577053c10a 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -32,6 +32,18 @@ PATTERNS("dts",
 	 /* Property names and math operators */
 	 "[a-zA-Z0-9,._+?#-]+"
 	 "|[-+*/%&^|!~]|>>|<<|&&|\\|\\|"),
+PATTERNS("elixir",
+	 "^[ \t]*((def(macro|module|impl|protocol|p)?|test)[ \t].*)$",
+	 /* Atoms, names, and module attributes */
+	 "|[@:]?[a-zA-Z0-9@_?!]+"
+	 /* Numbers with specific base */
+	 "|[-+]?0[xob][0-9a-fA-F]+"
+	 /* Numbers */
+	 "|[-+]?[0-9][0-9_.]*([eE][-+]?[0-9_]+)?"
+	 /* Operators and atoms that represent them */
+	 "|:?(\\+\\+|--|\\.\\.|~~~|<>|\\^\\^\\^|<?\\|>|<<<?|>?>>|<<?~|~>?>|<~>|<=|>=|===?|!==?|=~|&&&?|\\|\\|\\|?|=>|<-|\\\\\\\\|->)"
+	 /* Not real operators, but should be grouped */
+	 "|:?%[A-Za-z0-9_.]\\{\\}?"),
 IPATTERN("fortran",
 	 "!^([C*]|[ \t]*!)\n"
 	 "!^[ \t]*MODULE[ \t]+PROCEDURE[ \t]\n"
-- 
2.23.0

