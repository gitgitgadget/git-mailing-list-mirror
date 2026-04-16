Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6918639A074
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331267; cv=none; b=SRIqqA5rRIa3Hz6vGTu7Q+4fcc+qnJoedcMMIJPRfLMrY9JzoO8t1qcJYECnQ4kL9CmT5oafL18OqA4ZBCuJidMEe9uJrDEU6peBChe3kjszc29FfbloxAsQBt6E8ZXntb4ZPNF7P+ActsyA51jTxlsaufInkLSE6ph5b917nkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331267; c=relaxed/simple;
	bh=l5bkgj922K3/Znvr5Ig0KUDr2SUDzuTh2ovtpzoUWlc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AsRDz9CiJxZ39pRopkV6HAGdAhjOQs1bI2KJmwFndILCxtjQG+mnhewy529L2jbQhCQ2vQD2uzev+xslpk+rDR+mTazomcX8DF2sQoydSRCJHWXwztgAGLHDJC4Y4+MfLtkVKpZ3/jT9aQ2A2mz262i+v9mkWpafTVyToMEh52Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNyxbNEL; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNyxbNEL"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c6df0b9bbso364039c88.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 02:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776331265; x=1776936065; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5JAe2OO06TJMnUvgcXKJDQFJEzcVOJ+jSMj947jAcM=;
        b=HNyxbNELAMLVGRcRMOA1NCpKSaXZZhDgdHFJiw+FWrmB/q3IBsWDHWZozvkuYJ0c2d
         1X6tlUE/AcBKpBQxwFJU3l4KHGqUDaXhyl2aRKWXSlhCnjxl9xHikTR6EuLB3B4IAv6G
         Lh0KzUdQwupnIMbxiZtoo2YQUtquwuuo5wx+QRwScqMv2ZN7BPLUsse1N4xUTnjdzKwv
         y02QopStHvdfWy+QjF6MROYxtzAwucVPvxfbgCYxD5ujZyues10lDPV39+Gbpk3KGjXc
         gspOvG8cw+7KwKsYCJdRl7JvksOctx9jH5LG35ZMTJRpirfvU1gZRxFCepg2eVr1U5E+
         b6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331265; x=1776936065;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L5JAe2OO06TJMnUvgcXKJDQFJEzcVOJ+jSMj947jAcM=;
        b=oaQgyr1lLOdzPIVdNccaituLt63Wy4Ip/eV9gg4V62J4xzKsVsh/XexvtT7FSasWAN
         CUwGoZCVBjYcJ2rNR6lqNjg8PP6kuJB96wc0byvcN8526MNFTCx3ZBBlsGIKn7saeXbg
         v7j2AAwLqEvEYxCrYzPCrZGtrQBMaY1rQEnE1MGX99iOxvqJVHL1MFn/pmPp58iZeA+H
         HRs250NQZvdqPXvQMjwQ94bdSTTbELadrqP17lsaBnNk6uF3+jDQ3BTlOtwPiLxB2SGn
         jylrpzNc48vQCqMJdt1qp1PuL4AoAh2hcv4ccIq5YZgl6VXZ3F/UojPV/MkjQtY3cnkK
         a1Aw==
X-Gm-Message-State: AOJu0YxuumFw3tdKWy5ft9YKdrNleWHp+ptkbU75Z7rgzjsCf7Uwx3SR
	s0WuKsK4AC8my4fKxtEhjPdJeg/Ll1DfxJn0TxaSLl6eFkc5swdY5hecKUgOOw==
X-Gm-Gg: AeBDietBZ0S2xKoGqlE76Nx/SOvPJ5WkW+Yzq9/T5a+rgBY+fohoH1fV2lMZGCC9GNs
	s8RZwec8KdO1lkp1aE8xkXthhCRR2SRLgZiH7RQBg0GH7lcVGPCDhNbdIk8ceQYS5apcuVB2B+Z
	PtbJaRwNgmh60rcBAntFYdO1tTKwyhPk2Uf+1q12uJwciplmbPQyRPZiz8NXlDDxRotNCmK29m6
	ICu4rq2lUJWbUkLMfQ4pMginG48j8tyWvHcMdl+ZRr3nLQk2ZFvCTHQBgESuI535LFtTsa4yNM+
	CE5N2erFd7X6NBIDIKoa0HlwsGCtERXBFyoOQ59zsgm8cy75VI4/QkTXhaKH33SidURwOfRa/gt
	b9vjiSRfFYV0dhcQudWDpE67xDkCR9mv4zl0+eFU7c/DdDRAJNA+YzxfloKN/zIxhpH5wQpQ7qR
	jfxALUm7odQnIswlBvIRRXAe0=
X-Received: by 2002:a05:7022:eac7:b0:127:33e0:ea33 with SMTP id a92af1059eb24-12c34ede98bmr13973067c88.22.1776331265041;
        Thu, 16 Apr 2026 02:21:05 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.72.2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e6a860fsm5115740c88.11.2026.04.16.02.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:21:04 -0700 (PDT)
Message-Id: <650acab79ef5e45b6835b523a37cde184ad60e04.1776331259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2087.git.1776331259.gitgitgadget@gmail.com>
References: <pull.2087.git.1776331259.gitgitgadget@gmail.com>
From: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Apr 2026 09:20:59 +0000
Subject: [PATCH 3/3] t5563: add tests for http.emptyAuth with Negotiate
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
