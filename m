Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1BD2134A
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 20:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709844634; cv=none; b=ZOgbEGMXgyOMGSEPAZ7ncxKM2oidLPomM9ZzNbjn6NESLC/TxdEIH1XB7zLAsfnn/Bwpg3zYgor0jHcK7WyF6BnkeW/bJH9H6xR5GP8ywDhnWbPijmMaWZePzFiZ1Ddm4udzSIzkMLmgOjxnE4p4EAXerRnYWdN8Q5cUPNVJho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709844634; c=relaxed/simple;
	bh=+SXlC9Xo9790m0nBm4K6/RTF2bYX3ZMDoifOsW/gC80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QXIrD9E/utZiyzhCcjTrqfh4T7ry5vWxAOHJTFf8xopBKpNaLiGDzlejpYqjmdpzPlH+x/9UtJvM4bQnRUW9XF8c/P6GW5EIggw5tfQi3Vg6wXW6EHFggXxmDKIrI3oPnrvTj34tHp57nC55QhxeBMIoOTNnNb0TDRgELBMJqEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=v0WEP26I; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="v0WEP26I"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1709844630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TQqAMKgWi+S40dtmJIvVTLg6UBNtc7n4+l50a4iotFk=;
	b=v0WEP26IeT0qWK/oV47D5UKuTQP1wlfS67KS0qkOkBYPctsVG2vLWzynXV9BYC+09H4Ga7
	nCMU+vvFAw2L7IoxJQ8CRAWTHgCkLUn4sfgY04xqun07LUMAQNVJHbyK6s2H4joks4JsZO
	hOsZ1rryhoBF+J211DezG6++/IV8UpDB93y/DiV67BF7VficHh16DOqLfdCHJE9EPDfMVD
	zM1cgOf0xMpIvqkqZUo2RvGAsRtQMCTwBB+kjfn2HpIHy1Hj31FeQ3uDYCU27mNa9opetU
	N0qkB8Ep1SXutMXR0NW5XSgoDfsNP+3+3GxRDbRKflp3xsEemy0oxGVaz7t4pA==
From: Ignacio Encinas <ignacio@iencinas.com>
To: git@vger.kernel.org
Cc: Ignacio Encinas <ignacio@iencinas.com>
Subject: [RFC PATCH 0/1] Add hostname condition to includeIf
Date: Thu,  7 Mar 2024 21:50:05 +0100
Message-ID: <20240307205006.467443-1-ignacio@iencinas.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hello,

First of all hello everyone, and thanks for developing git :)

I recently came across [1], which proposes further extending 
includeIf by supporting "hostname" as a condition.

I thought it would be a good feature to have in git so I gave 
it a try. Let me know what you think.

If you like the idea, I would be happy to add similar conditions
like "username".

[1] https://github.com/gitgitgadget/git/issues/1665

Ignacio Encinas (1):
  config: learn the "hostname:" includeIf condition

 Documentation/config.txt  |  9 +++++++++
 config.c                  | 16 ++++++++++++++++
 t/t1305-config-include.sh | 22 ++++++++++++++++++++++
 3 files changed, 47 insertions(+)


base-commit: b387623c12f3f4a376e4d35a610fd3e55d7ea907
-- 
2.44.0

