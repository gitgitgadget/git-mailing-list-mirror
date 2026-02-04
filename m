Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19138413229
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214817; cv=none; b=gaZCoyFUP9my9EqTkbJDsQcM2l6fQVfAteQgsI7vH7cs+r77Ekb6E+atgSHZMyANOkb+GIqynVqGy95/dvKqk1Efku8J4EGZyQRuvAkG3mP7x1pw2H7HD2cm2SK9rTpDV5zFRbsAmyGsu8GWeOqkkX89H1/ItQ51YrS8DPSI+W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214817; c=relaxed/simple;
	bh=CjKF/nYmyTc11AjcN/EzAoHqgTaeOjDbx2GUEBHa17E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GYV4298g1pstl3KXxXO3x0S+u/wZ38Z64Py/jI30ODvBKEo9JEtLUDUDS3nCZkCjREdC3YztSfduKvV+41FFtFzRczWBiEY1BqljxPdQDFsjOeZ9fJQEIWWl5H8tbj3TvZ+zTx7ObCo2odZsj6zbGniF6u1QkvEPuOKF2DU8G1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRcsuOkf; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRcsuOkf"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-409470ad5bbso2589576fac.0
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 06:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770214815; x=1770819615; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PGq7hJbJIzaYvEsDHxF6kHn1Go/RldMKEyAhR4ajgc=;
        b=ZRcsuOkfMJOfBZjxekQQHQQIpQxV/Hs7B1/0t7lfmVzxC9MQBVFCosuo8kDQFT0sZx
         830HoF1nYY0H+2bvsH7bY6xwz8lqgtm/hzL48cN9f9hLrhuXrb56YR4wwRz4EeI7LOoM
         yOrXbSWmjNHjQHb7NztKRz6ZFjWp3Fxke+qg5Rx8o65SqVVrd8QKQDMaRBQVKcpDKLbB
         ZiD3TSm4NbZwSrgZX6k1dTmjjP1Ei1lVDKYCF2BM4/A2az6RInGcUoWiszJUSh8G6yPo
         TgRRCEHoXjzBM8ikF9iOLVjvSxvc3nqRUt139pO+nQ1mSTBruQ+KztZ6Gl5hFOCEZNFj
         1zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770214815; x=1770819615;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8PGq7hJbJIzaYvEsDHxF6kHn1Go/RldMKEyAhR4ajgc=;
        b=tgGYkaWFTMnoSV3e/bNu/48I/BLRH3ulG/VylU/4w9thN1szoWaHeyh3V3pyKihNdK
         OaiPbDTHdLTYFcRAPUDvCjU0RWzGBAmAX72B+elRc3W1QdSO20keppOXhNPvxxjJIkE5
         qTspqljUZwcfRa+LwawuobV5j/OaaX02qhZwfAeJelFy7RrBOa8/2CCXW+UlOHglibAG
         k0jyDGXsD29qEoLwYr/bD8EDC1dfyJzwTu+AhphD9w4Df+Pv0N0g6aVDM8sIjl+qe35s
         gUt4Y3fD2AdhHmSfVk5cSw69a5nMqp5ZQau5k+lahbGnrE17W1dqEyrl6R1F3AE3zI1J
         4CMA==
X-Gm-Message-State: AOJu0Yys6wlXrf4WgXluJlEEp8OUumpxfVewxpFHIf3FbKsgHI0gtxZw
	f8OBdOFQHCdRXFCC3l7ThPEJhzbOvPnAmg0npE1DxNHYWzDG5h8zZxCBD9zZ2Q==
X-Gm-Gg: AZuq6aK/s3LO//buBXQL0+T64+Uy6ynUH/C8ehfFRf2WbUrlkEcOUPUjr2i0thBedAl
	jAKqiOpo8xxaIO25TKEi87UT2YjiIPkhYiOrm02ICCJtKcSS3y0El2LCJpe4EuyqD6f9npEzVoP
	A29mov5Pok67iiWsGOaG33H84EBeTrrhJcApVRvW49uf+d4V8lbinKUb1kjez9dsSgX7lngG9pd
	/9sMvuPlwD65qGsEm2vWMoi9Bf2AZ63c62h9GFGjxsyyDXXlmGGRebKS0Pfm4bSD5Kt8Z/65ubs
	u/gKZlwYk0qlTiW0VfwcDNZ1/p55LuMXszNuMPr4MrGXbV6LqdO9+9Xd9rkObNLTExIiZ7N/XKc
	anin9Z04q3bzhhU20+UozfGFCNb5LX6prdNooY7TdKXIS4MQRNPWefAehotdwwwxd43vTsIbft5
	uWBFQPSik7JmtP0Q==
X-Received: by 2002:a05:6870:1685:b0:3e8:983c:c8a with SMTP id 586e51a60fabf-40a53ee7b76mr1482796fac.37.1770214815464;
        Wed, 04 Feb 2026 06:20:15 -0800 (PST)
Received: from [127.0.0.1] ([52.173.182.164])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a54426647sm1660899fac.13.2026.02.04.06.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 06:20:14 -0800 (PST)
Message-Id: <014e959cf4a4e19afe6becdb155f49d0f96739f8.1770214803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Feb 2026 14:19:58 +0000
Subject: [PATCH 06/11] docs: add design doc for config-batch
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This document will be a place that tracks the future directions of the
'git config-batch' builtin. We plan to remove items as they are
implemented in new commands and documented in the builtin documentation.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/technical/config-batch.adoc | 70 +++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/technical/config-batch.adoc

diff --git a/Documentation/technical/config-batch.adoc b/Documentation/technical/config-batch.adoc
new file mode 100644
index 0000000000..dbd614ad4f
--- /dev/null
+++ b/Documentation/technical/config-batch.adoc
@@ -0,0 +1,70 @@
+Git Config-Batch Design Notes
+=============================
+
+The `git config-batch` builtin has a robust protocol for parsing multiple
+commands over `stdin` and providing structured output over `stdout`. The
+intended use is for scripts or third-party software to interact with the
+config settings of a repository multiple times within the same Git process.
+The protocol is built with versioning that allows the consumer to know when
+a certain command is available and to fall back to single-use `git config`
+processes if the installed Git version does not have the latest commands
+at the required versions.
+
+Recommended interaction pattern
+-------------------------------
+
+This section provides a guide for ideal interaction with the `git
+config-batch` command and its protocol.
+
+For maximum compatibility, do not attempt parsing the output of `git
+version` to determine which commands are available. Instead, first check
+if the `git config-batch` command succeeds and does not die immediately
+due to the builtin being unavailable. Then, use the v1 of the `help`
+command to get a list of available commands and versions. Use this list to
+determine if your capabilities are available or should be replaced with an
+appropriate `git config` single-use process.
+
+Further, all automated tooling would be better off using the
+NUL-terminated format instead of the whitespace-delimited format, in case
+config keys contain spaces or config values contain newlines. The
+whitespace-delimited version is available for simpler integration and
+human inspection.
+
+Current commands
+----------------
+
+See the documentation in linkgit::config-batch[1] for the latest set of
+available commands and their protocols.
+
+Future commands
+---------------
+
+The following modes of `git config` are not currently available as commands
+in `git config-batch`, but are planned for future integration:
+
+`git config list [--<scope>]`::
+	Getting all values, regardless of config key, would require a
+	multi-valued output similar to the `help` command. This tool will
+	likely assume advanced options such as `--show-origin`.
+
+`git config set [--<scope>] <key> <value>`::
+	It will be desirable to set a config key at a given scope as a
+	single value, replacing the current value at that scope, if it
+	exists and is a single value. A `set` command could satisfy this
+	purpose.
+
+`git config set --all [<value-pattern>|--fixed-value=<fixedvalue>] <key> <value>`::
+	When replacing multiple values, it may be necessary to have a different
+	output describing the places those values were set, so it may need to
+	be implemented via a `set-all` command to differentiate from a `set`
+	command.
+
+`git config unset <key>`::
+
+`git config unset --all [<value-pattern>|--fixed-value=<fixedvalue>] <key>`::
+
+`git config get --all --rexexp <key-pattern> [<value-options>]`::
+
+`--replace-all` option::
+
+`--type=<type>` option::
-- 
gitgitgadget

