Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F60C3B9D99
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546481; cv=none; b=Gkj0tMojMhujIgIlwmAmRA5FHgsu9TcbMY8FajBwAzcBoH1h6P/96N0HzvHAJDyUXH5DpntxXrQBj9DK35eQBW5ax78T1snNvXzu9MU2i+JRm1YjS4rFRz4b2oojIdZvIX2cyPkvYEGC7+rPSxCehjL/CZuz+zV7nNgpnePgS4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546481; c=relaxed/simple;
	bh=l5bkgj922K3/Znvr5Ig0KUDr2SUDzuTh2ovtpzoUWlc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rcNkTm6dzocBjh/NRe4lgX1ES3PkDab0CcEH7i39R5y/vwvOUeGX7TOGt2qvsNDYpM856s2h426NNQ1LW7mS/+6KKulw1YI45BTQN0mE8d+3Fnbwjbym733RZ2Qx2F5oHMS6Hb1ge1NIMoiu4d6ReSvkYtVX4+q+LeKQ1S0q9aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzsJF+Dl; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzsJF+Dl"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b4520f6b32so1283361eec.0
        for <git@vger.kernel.org>; Thu, 30 Apr 2026 03:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777546479; x=1778151279; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5JAe2OO06TJMnUvgcXKJDQFJEzcVOJ+jSMj947jAcM=;
        b=gzsJF+Dl82TXWf8b+f/0fMv+irIBo7RsgdeiUiz7BUEYFI3VQFfKq13d7egYTzK8Vl
         j59rBFpjXl4Wli8h9xcrazRyIfswEUh8BnVvwfcIgkieCRmB8KWtb5us54adMNBLDc42
         zSy8/nQ9LNTlM2IrIYLnnUtq5BKIHNGvfDg62M1UEuOl0V5941njEa2B/QQXtTr/eM1C
         GNEC34T9SWLqCk/hCiAcf0Rw9nPUF/qID26jvyOdLyPxAlsh8QffLKggtvCFEomDtgHk
         l2q4A8303KxTwqMqBboJC7Kv480ZJ/o272ulcv+H03Str5yIZrEuRn8wjWKtx73SFQpd
         nvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777546479; x=1778151279;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L5JAe2OO06TJMnUvgcXKJDQFJEzcVOJ+jSMj947jAcM=;
        b=es44sJf+aaD7xs0nB3hawHf33+8PJfRoIZd82Xwk5JaVwDCzetbopRBrUZ2MYL0JuA
         j7RkfJtOw0Q7XLAdxcDW5YtDKyKhSUuDPACWB51MD8swiYK6xomPRMBWit7++g/1/qFy
         jDR1Kffy4aBu5vrht4f0a9u+WfVu+iZFd1AEMapHHO4MUxsrrrdjbeb1klYLE7jXF6Lb
         QeA9a4e80AuKcSdQcCwZWeVd4r9cqGLYM/Vw7SN1SAtKT8Mkut2YyxozqjMFnwBcmIlJ
         ekhTWpkIf7L052AyUTDDRONnxDaeMI3Y78/K6rwsAkw/O1gQoElv4OXrZ7CCjWWozB9n
         f6xQ==
X-Gm-Message-State: AOJu0Yy3/UHFJfZkX8IitAQS0UXaXqbu9455WuMw5alzBRft1akOGSks
	tvcfhkHBN7ktA8OA0sf0122//iF9bbgADyjRN/74vqix2KitPqAZ+nFpE3eZlqNH
X-Gm-Gg: AeBDiesoqFCSPtqbmg60kLTAUTmcf69mC24JxMmJVSwGt/oLX3ESUXPHsKxqEkxo0kz
	6NqqDxX/aW3Zw1xrNqRaJYuWqFhHL1CAX/DeDpUeaEVDLsuVfcKIdQ6eJXWjAw0lYqltSOXh808
	YWqLfuC+8SxZXOtQACLLX8BdluvtaNZSNY4CUOl/cneQney1spQmbf5hFE/lRVLOBjvNFILLjGd
	Z5AVvAnDsqX4Hsn1v744HhFNspi2qn+cFoOQuzLfOVBHtHBZfuVs6P4wcrNhZ1Vsdc/3urTCiVj
	NLNqde7DGkgCe4I6N/jt+wdIdSIxU1VvnTQrmH7FdCoHvPOgfocUoFTW11cclMZE4xYonGe+TM6
	KpNdP8CiN8ShwmVWn02ZJ0AdkNCvBwrvbllXHfRApjskk3IFomhqr5h8QWodF/0QtpFvzt2O8EX
	EWU+ag8sikwWY/Apa4AWe/18XnM23Ve8AF0OA3
X-Received: by 2002:a05:7301:7c0b:b0:2de:c5ca:c1e8 with SMTP id 5a478bee46e88-2ed3bdf95f8mr901538eec.4.1777546478903;
        Thu, 30 Apr 2026 03:54:38 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.40.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1c070beesm6261319eec.14.2026.04.30.03.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 03:54:38 -0700 (PDT)
Message-Id: <650acab79ef5e45b6835b523a37cde184ad60e04.1777546472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2087.v2.git.1777546472.gitgitgadget@gmail.com>
References: <pull.2087.git.1776331259.gitgitgadget@gmail.com>
	<pull.2087.v2.git.1777546472.gitgitgadget@gmail.com>
From: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Apr 2026 10:54:31 +0000
Subject: [PATCH v2 3/4] t5563: add tests for http.emptyAuth with Negotiate
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
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>

From: Matthew John Cheetham <mjcheetham@outlook.com>

Add tests exercising the interaction between http.emptyAuth and
servers that advertise Negotiate (SPNEGO) authentication.

Verify that auto mode gives Negotiate a chance via empty auth
(resulting in two 401 responses before falling through to
credential_fill with Basic credentials), and that false mode
strips Negotiate immediately (only one 401 response).

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 t/t5563-simple-http-auth.sh | 74 +++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
index 0063581615..a7d475dd68 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -719,4 +719,78 @@ test_expect_success 'access using three-legged auth' '
 	EOF
 '
 
+test_lazy_prereq SPNEGO 'curl --version | grep -qi "SPNEGO\|GSS-API\|Kerberos\|negotiate"'
+
+test_expect_success SPNEGO 'http.emptyAuth=auto attempts Negotiate before credential_fill' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	username=alice
+	password=secret-passwd
+	EOF
+
+	# Basic base64(alice:secret-passwd)
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	id=1 creds=Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
+	id=1 status=200
+	id=default response=WWW-Authenticate: Negotiate
+	id=default response=WWW-Authenticate: Basic realm="example.com"
+	EOF
+
+	test_config_global credential.helper test-helper &&
+	GIT_TRACE_CURL="$TRASH_DIRECTORY/trace-auto" \
+		git -c http.emptyAuth=auto \
+		ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	# In auto mode with a Negotiate+Basic server, there should be
+	# three 401 responses: (1) initial no-auth request, (2) empty-auth
+	# retry where Negotiate fails (no Kerberos ticket), (3) libcurl
+	# internal Negotiate retry. The fourth attempt uses Basic
+	# credentials from credential_fill and succeeds.
+	grep "HTTP/[0-9.]* 401" "$TRASH_DIRECTORY/trace-auto" >actual_401s &&
+	test_line_count = 3 actual_401s &&
+
+	expect_credential_query get <<-EOF
+	capability[]=authtype
+	capability[]=state
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=Negotiate
+	wwwauth[]=Basic realm="example.com"
+	EOF
+'
+
+test_expect_success SPNEGO 'http.emptyAuth=false skips Negotiate' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	username=alice
+	password=secret-passwd
+	EOF
+
+	# Basic base64(alice:secret-passwd)
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	id=1 creds=Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
+	id=1 status=200
+	id=default response=WWW-Authenticate: Negotiate
+	id=default response=WWW-Authenticate: Basic realm="example.com"
+	EOF
+
+	test_config_global credential.helper test-helper &&
+	GIT_TRACE_CURL="$TRASH_DIRECTORY/trace-false" \
+		git -c http.emptyAuth=false \
+		ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	# With emptyAuth=false, Negotiate is stripped immediately and
+	# credential_fill is called right away. Only one 401 response.
+	grep "HTTP/[0-9.]* 401" "$TRASH_DIRECTORY/trace-false" >actual_401s &&
+	test_line_count = 1 actual_401s
+'
+
 test_done
-- 
gitgitgadget

