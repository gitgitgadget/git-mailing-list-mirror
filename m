Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581212;
	b=Dx5C1t87IkvaAlcyqBQpnD9oNHbyo3+JqmII4whHn/Jgdd0HiVi073493AUxTkzYKy6g
	 2wikDqTcnLI6xMb/wKiDhKw1cYV6jLCykmxUSLvkXHKXr9i/PIymSaN8I/NNFeIqDm8nq
	 5feTINnvtpgRyXTENE6GihQM59VPfQPsRHAo+iKs4dWti+A79XhQZgQa/yI1lmShUY211
	 /jfgMEB9gMwMngPwZFvdBUIkmjjlDN25+MsapYmofCO6PgIlfehqHI2rp74csOaWGJlD3
	 K8NbUf7erInbwijqu0Dgyy0kiPJDC+PYrkxHATPAaY/SQadNkn/LHB17x+lZSyTjjSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581212;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=klT6eWnqkpnS4R6tkDWSbGJMoTMSAoVwvfR7wzh6h1I=;
	b=X2LSTa2ngNiVE/JNLAMNUAgy+xdCm/oJ+qX1VbLT2VNkSzBWpjoXP1hwzutd3vKc7n+R
	 PIiqNJuMO77Oo21bnzT2PeEwi+c3voSTC1Yhk1s5O1+xBdTmqCy9353/O2A04w5xUNPZV
	 1iyR/p/Z7HbqsiBlwm0S1TSPrkOWNKGUt7v8w2nHA9tZvydooWs63i2GMsu98iGb3Pw1K
	 nxrPo0bmvR08Bamug3XQSpMGvQC0cOehmLARPZlOAGfhs88jBPtaQwLKmbnRbNkozm2Yc
	 PKxa4bxT24f8WEZ/mkuFzk6PKZVlG267yC5CYwiDZrenq7hI1zoGhgZd48FsQltxq1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=p28TdkmD;
	arc=none smtp.remote-ip=220.197.31.7
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB037606A333
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 14:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB037606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=p28TdkmD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=kl
	T6eWnqkpnS4R6tkDWSbGJMoTMSAoVwvfR7wzh6h1I=; b=p28TdkmDkF/LkgFOJX
	mHJfBUO1YIKnlIdnKwQ8VEYrohElobROyzSkZ3shZnhLQaBDlORvMMNExgZz7p+3
	5AV9zcm7HKay+yguKiCv7QROY6Qhmdo+nU+GgfHfXWdtRWB0zJb5jyAFhsZGL5Gy
	wH8oDHLWw0i+Plq+/bZSdfkJs=
Received: from peter-desktop.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3n4KYIvdqu4gCCw--.24094S2;
	Fri, 13 Nov 2026 22:45:45 +0800 (CST)
From: YikunWei <YikunWei@126.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Bruno Haible <bruno@clisp.org>,
	Yikun Wei <YikunWei@126.com>
Subject: [PATCH] doc: include fmt-merge-msg config in the main config doc
Date: Fri, 13 Nov 2026 22:45:42 +0800
Message-ID: <20261113144543.46713-1-YikunWei@126.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n4KYIvdqu4gCCw--.24094S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFyxur47GF4Utw1DWrW5trb_yoWfWrgEka
	ykJa15WF4UZryxGr45ZFs7CFnrC3Z5WF17Z3s3ZF17A347Zr129348tayjyay5WwsI9r1r
	XFZ5CryDGrnFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU86Hq7UUUUU==
X-CM-SenderInfo: p1ln30xzhlqiyswou0bp/xtbBqRlHSWr3Ipkp9gAA3H

From: Yikun Wei <YikunWei@126.com>

config/fmt-merge-msg.adoc was only included by git-fmt-merge-msg(1),
so merge.branchdesc, merge.log and merge.suppressDest were missing
from git-config(1), the central configuration reference. Include it
in config.adoc (alphabetically between filter and format) so that
they are listed in `git help config`.

Signed-off-by: Yikun Wei <YikunWei@126.com>
---
 Documentation/config.adoc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/config.adoc b/Documentation/config.adoc
index aa6360e230..06ec247d92 100644
--- a/Documentation/config.adoc
+++ b/Documentation/config.adoc
@@ -498,6 +498,8 @@ include::config/fetch.adoc[]
 
 include::config/filter.adoc[]
 
+include::config/fmt-merge-msg.adoc[]
+
 include::config/format.adoc[]
 
 include::config/fsck.adoc[]
-- 
2.43.0

