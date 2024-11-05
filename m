Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEC157333
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 03:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775915; cv=none; b=E7ypn4E3Rar3F43UTU0YW96QXHeH098FKR5yZ0zDGyupv926D5Z8vefvsyDzStt1IvTKM2TnYw3pew48WAMO24r7SNJlUAkYCkuQNfAQ8cUNePGUA3yeLvRWpw4sghF/JFalHeW+eBRB6CLyng1bq8Ng87n0cDxoJNJYJr2MlLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775915; c=relaxed/simple;
	bh=Vt3YrQ3jWrT0dtDOfAMJpw+PmiHpM06K5URswxzOZkw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=e6ITlyGKvqPkkjU02cVbSzUA0QGahfJekCNaqkquHAfVQ3Gj3kLYQ/13XwYREitxIHuLgwEkXrpLtUk1913uM5lT5sxQq/YRftGPeo3oW1/yqk9ddtOxafJ5+7c7H4Qd67S4vH64nEJxKoalTpjLT+8SOS2k+8nuwAWCOIGnoTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfekTEXi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfekTEXi"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so40521805e9.2
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 19:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730775912; x=1731380712; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peQ8AGR4b2Cxuq0GJXzCrXgDo0DQuq03CbIh//k1/yg=;
        b=jfekTEXieePCDEe/cYEjzjPpCHSgWm+S/WYoWetJmqy/0PJcPgE9gRu9Dk/5BC0yow
         3aH6ioopFndD7IgBFLtoG09btihozkzA7wMQz4ZN/Zws3TlYWTkVJwt5hF+8Xe5cXDiv
         a3W2+sQRVLgQ+FZAolb0+PeCnQfp5TJV3UbC5cGAjFJ3BxzoSg9TJXWDx9YxfA7J4Oar
         nDorGEqDSXlOdrnOULMtcnpuzdWFnGFGl4SuyxRZcDXZSSQIanaJpSBdwYvVBAsfkbGJ
         0meZIrwJ/UPci6i3HIfh0nribuYUA7Mbw693wWKTMzcWIoFUNoM4xlI7nCxOKza6YmAj
         zt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730775912; x=1731380712;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peQ8AGR4b2Cxuq0GJXzCrXgDo0DQuq03CbIh//k1/yg=;
        b=vy/LHTzPlxMWENIDGleU1SualYX1x0ucP3m8t+vQQYUXtZJrmSizDT8GqXUAsp2fQp
         oh/W25hD3PnvZIMtwcoFgsrsND9E/p7FE2E6UEMJ5Qqov7fUMiViQ56dBWCpnYhX6ftg
         7GRiSTbmB2/54zSzaCliRphK8zIAJSL3KAHJlwXSq1ewdsSKPJVn7hYmk2jbPXryqlX5
         2fpSoFR91AFsvNNYvnQvI7G8k2O5Q6wbN+TgybUd9jGLjZ5YRNyruvmpf9P1e/Iedlxv
         4yn642nBltlCRqJ6LsCf7WVzBmVrmjlzt8jQM+dFx3bw6cFM5iq6yhQc+YyyNw/qFMZ5
         CnPw==
X-Gm-Message-State: AOJu0YycHnPANHGfzGgm9bCz/8mVMIMn/4l4Yui6t2Fi2ew99XHuu9Xj
	sd35y8RKd7R3ilNpRw7s+VOMhxUfDswtQeYKdyalf5i5oBn8uXF+jKqRsg==
X-Google-Smtp-Source: AGHT+IHhFADvZ2eBBeJ6gAsDgHQDqJT4/Rm1fgN3TJREwpiqOUnkWCvb8CdGhzgQoi3pmx1QsqetmQ==
X-Received: by 2002:adf:fa07:0:b0:37d:54de:1609 with SMTP id ffacd0b85a97d-380610f3056mr24332718f8f.10.1730775911523;
        Mon, 04 Nov 2024 19:05:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116ad3fsm14602727f8f.95.2024.11.04.19.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 19:05:11 -0800 (PST)
Message-Id: <93395c93347274d075c3e29b3bd20dcc221b15be.1730775908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Nov 2024 03:05:02 +0000
Subject: [PATCH 2/7] repack: add --full-name-hash option
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
 t/test-lib-functions.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index c4c3d1a15d9..fc2cc9d37be 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -777,6 +777,13 @@ test_expect_success 'repack -ad cleans up old .tmp-* packs' '
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
index 78e054ab503..af47247f25f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1886,6 +1886,32 @@ test_subcommand () {
 	fi
 }
 
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

