Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D6A3BE643
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812063; cv=pass; b=mcfgIgN7nKEgdxQ243W05SpR/s+JraAAi/X7eMYVFjPFjpWtH19VF4v5yihwfkEeQog8XsX9wTvVY43e6DY4XGqaPZQS/61SSxt98AiCTsuOwJ7M+52N2AJMaOSYKU8j7xGHckQ+H4f03vOZalNCarPxTnH1HYY5JaXHuDFADXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812063; c=relaxed/simple;
	bh=DgOcfElrBFo58QYesK5qbmoQr49zzeZEMYL5Vp8xOdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkdPIBWEuo0Ut6P+sPbIIO+k80Ppl6rZbknhpC/8rTlhWg3MWqGR5RDLG0UI/+P6Aubg0Sbpz/nRdu25oTl+AHAWo26acEhJuX3kMqk4DnR6ax5F4QvzLDbxGtY6JVEHUW5xEb3YbnaPiXlCtuz3qXd6Ay9eeo0qi9Rmw6GjUQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=GFq05pOT; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="GFq05pOT"
ARC-Seal: i=1; a=rsa-sha256; t=1775812045; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TYGkHIXA6QOBpY8Dnpa3roFMRPQrMMXtOPX65KNI4mCHZpNDA+tmrYoPlksE/fWRAv6Rb/uD50Zn+84yuyNOetFVSXMDheyB3++5Bn8HV++eBnwoc6sE1FdZCwaBwkBeTXTBdH2BA5amcRTSYPRWzt+pxQC91jB+sK4ZLB6UYuY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775812045; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cAx5R5Hz9u3x3zBb3MwKOzbgvONb5JEmjpWvyjtn+LI=; 
	b=C0ORSspNPmCAPdjaARgH7sCdEWp0r3amh4CRQARrmuvX5XPwKasHjtxtB2oQiPWIItjXUqM3XOyQRj9KYlXJnYNka2lRXLPlE2yFVP6JWkgOnY3XCeZ3fLlNXnvzvaSqvowTbWATq3nenXffS+BvNHWQrLbwQ+SZrBkuF3XHdac=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775812045;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=cAx5R5Hz9u3x3zBb3MwKOzbgvONb5JEmjpWvyjtn+LI=;
	b=GFq05pOTP96DPC91JmkMantJ2QJFjUTd4IqjUbDveU8bTrQ2HhowRF5s6vb6AcnQ
	6425R15NXehp+35GGBnG6J5gVM7e2AP4825mtGm5qfIUEfNXd+SuU4Pv83VHK5iT3Eh
	sG6c8mrTaFETuQ5MVHqyJVmAGsspcbMFuqgLdKQ8=
Received: by mx.zohomail.com with SMTPS id 1775812044690709.5159356731109;
	Fri, 10 Apr 2026 02:07:24 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v7 13/13] t1800: test SIGPIPE with parallel hooks
Date: Fri, 10 Apr 2026 12:06:08 +0300
Message-ID: <20260410090608.75283-14-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410090608.75283-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260410090608.75283-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Jeff King <peff@peff.net>

We recently fixed a bug in commit 2226ffaacd (run_processes_parallel():
fix order of sigpipe handling, 2026-04-08) where a hook that caused us
to get SIGPIPE would accidentally trigger the run_processes_parallel()
cleanup handler killing the child processes.

For a single hook, this meant killing the already-exited hook. This case
was triggered by our tests, but was only a problem on some platforms.

But if you have multiple hooks running in parallel, this causes a
problem everywhere, since one hook failing to read its input would take
down all hooks. Now that we have parallel hook support, we can add a
test for this case. It should pass already, due to the existing fix.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 t/t1800-hook.sh | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 41b2b2c746..0132e772e4 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -1190,4 +1190,42 @@ test_expect_success 'friendly-name matching unknown event warns' '
 	test_grep "same as its event" err
 '
 
+test_expect_success 'hooks in parallel that do not read input' '
+	# Add this to our $PATH to avoid having to write the whole trash
+	# directory into our config options, which would require quoting.
+	mkdir bin &&
+	PATH=$PWD/bin:$PATH &&
+
+	write_script bin/hook-fast <<-\EOF &&
+	# This hook does not read its input, so the parent process
+	# may see SIGPIPE if it is not ignored. It should happen
+	# relatively quickly.
+	exit 0
+	EOF
+
+	write_script bin/hook-slow <<-\EOF &&
+	# This hook is slow, so we expect it to still be running
+	# when the other hook has exited (and the parent has a pipe error
+	# writing to it).
+	#
+	# So we want to be slow enough that we expect this to happen, but not
+	# so slow that the test takes forever. 1 second is probably enough
+	# in practice (and if it is occasionally not on a loaded system, we
+	# will err on the side of having the test pass).
+	sleep 1
+	exit 0
+	EOF
+
+	git init --bare parallel.git &&
+	git -C parallel.git config hook.fast.command "hook-fast" &&
+	git -C parallel.git config hook.fast.event pre-receive &&
+	git -C parallel.git config hook.fast.parallel true &&
+	git -C parallel.git config hook.slow.command "hook-slow" &&
+	git -C parallel.git config hook.slow.event pre-receive &&
+	git -C parallel.git config hook.slow.parallel true &&
+	git -C parallel.git config hook.jobs 2 &&
+
+	git push ./parallel.git "+refs/heads/*:refs/heads/*"
+'
+
 test_done
-- 
2.52.0

