Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56179188A1F
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726692390; cv=none; b=cX2I7doQ6qokjsa0qNq7vuSt4SL/ObeA8OEvsC/oHakuhPDeRhKJV58/rSefS7lwS8mDD+xB62lhXjoOcgf1CHVQ6bGdvxz3bZgxo4+tCmUruTuhT8ZR0hN8y5QAXmvxROCdOSR5Gvidn0Xjkv7yKTxxyPV31CTjslheHwrHoMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726692390; c=relaxed/simple;
	bh=eIFU1v+r75nTl7k6TqVsjSx+OPVK3Qo1UrYC6u00KPs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gzWgkXbYYyECGc+EvWIX9EFLdXP7V9OV/N4qlNY6HPwDQil/+JwdQsqiQ/z1IGndFi0wdGtBsdGNWj1tROJ7kuggDOiqb1VcDbKUd68Aa89Gs0a6/i46RHPYSfRyxjcJoRQ9ie8fO2SNxDHEW5LXRn2FJF5i5frsWsPzKeB8P3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sszk2NPY; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sszk2NPY"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d4093722bso12694066b.0
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 13:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726692386; x=1727297186; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rnegS5743marQga3qkfKUpWErug4NS6mMIWutApA0A=;
        b=Sszk2NPYEJ2vYUw8rL6c5XJkGxH+pCG7FiHVJjFL9AZT2l7+6Y1HQrnyH5H86T/Clz
         S4tUsFmOmgUVr9bJx2TTzSp0XN/YpO7g5zMT2McmEse6+INYoIcyDI+GTlgsuGjj2hIT
         TSLI96fGuMDLQ38qTeOoMd4kUvzwuyLpeZgRGbOSBwTD2JZI5G/YTuysGvswbNE31THV
         ml3aRmxXb8Brfvj1a1jLGRgVrUSIYFxMa8MjBtCzSWQNcTa54b6BWIvw78J9hugrGLRH
         b9mALSCKauS18m3ZMuDQbzGNR/sbIg1ivno2kjZiml/ffouJS4+IRMtk9oBGT9lxbPMD
         rJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726692386; x=1727297186;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rnegS5743marQga3qkfKUpWErug4NS6mMIWutApA0A=;
        b=Ylaycdrb0Hb2pnc3BRPdQWI+ajUbjh/vHp/z23xVjQ4PPIPh4zKNlq6Cle8n1wT0h7
         +gbawa9ieVEJKwNgBgOuYAb9wnyZn9UOhA7UPKjEOweEG1eRdiNNym2IwrgL6ettpE9j
         JBP/s/HluNwet5Ej+Rn1YDsIH7/RZnPMkWCOaNDOIYzLdK4+/djGBplcTTyhakHfxvHY
         gp9Z/FPA0/oUwVLXUOwWCTxO9cL+H2ybxIWpGjKZZW5TzVt31UEjSnJVMq+cZ6fzF3oV
         emiSiQugkMLilc3yg3bduERIdkVAQ9smNDO1KczcN0bOzAWe3rSn7ahQ6PIibG/cBqHU
         9gOQ==
X-Gm-Message-State: AOJu0YySrmq2zccSgrRc27CiQm/U0t6i4rEux711CRVzYYo6tFQnnWIT
	85jlrvaoyhnburKDIKUO/pnRUaconqWsE9K7QQ0AUmvQv05ZhNMoz1JJhA==
X-Google-Smtp-Source: AGHT+IFFdmYH2/xWRUetnrwfePCOkNNeCjIkqQTGmIh9EjoJB75A+018xeP1a2CwaXaQrYv2ZbVFgQ==
X-Received: by 2002:a17:906:f5a3:b0:a86:9793:350d with SMTP id a640c23a62f3a-a90296795camr2339901166b.62.1726692385509;
        Wed, 18 Sep 2024 13:46:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061328e61sm634587766b.196.2024.09.18.13.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 13:46:25 -0700 (PDT)
Message-Id: <48b87cccedb3d7920a3184ca86ca9eec77c0fd01.1726692381.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
	<pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Sep 2024 20:46:17 +0000
Subject: [PATCH v2 2/6] repack: test --full-name-hash option
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
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The new '--full-name-hash' option for 'git repack' is a simple
pass-through to the underlying 'git pack-objects' subcommand. However,
this subcommand may have other options and a temporary filename as part
of the subcommand execution that may not be predictable or could change
over time.

The existing test_subcommand method requires an exact list of arguments
for the subcommand. This is too rigid for our needs here, so create a
new method, test_subcommand_flex. Use it to check that the
--full-name-hash option is passing through.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t7700-repack.sh       |  7 +++++++
 t/test-lib-functions.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index be1188e7365..1feb6643e69 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -776,6 +776,13 @@ test_expect_success 'repack -ad cleans up old .tmp-* packs' '
 	test_must_be_empty tmpfiles
 '
 
+test_expect_success '--full-name-hash option passes through to pack-objects' '
+	GIT_TRACE2_EVENT="$(pwd)/full-trace.txt" \
+		git repack -a --full-name-hash &&
+	test_subcommand_flex git pack-objects --full-name-hash <full-trace.txt
+'
+
+
 test_expect_success 'setup for update-server-info' '
 	git init update-server-info &&
 	test_commit -C update-server-info message
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index fde9bf54fc3..0d94730924a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1885,6 +1885,33 @@ test_subcommand () {
 	fi
 }
 
+
+# Check that the given subcommand was run with the given set of
+# arguments in order (but with possible extra arguments).
+#
+#	test_subcommand_flex [!] <command> <args>... < <trace>
+#
+# If the first parameter passed is !, this instead checks that
+# the given command was not called.
+#
+test_subcommand_flex () {
+	local negate=
+	if test "$1" = "!"
+	then
+		negate=t
+		shift
+	fi
+
+	local expr="$(printf '"%s".*' "$@")"
+
+	if test -n "$negate"
+	then
+		! grep "\[$expr\]"
+	else
+		grep "\[$expr\]"
+	fi
+}
+
 # Check that the given command was invoked as part of the
 # trace2-format trace on stdin.
 #
-- 
gitgitgadget

