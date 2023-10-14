Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB6E262BD
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="a7Z3DoQy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o3aA9LqN"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61088B7
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 14:46:56 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id A634332009BA;
	Sat, 14 Oct 2023 17:46:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sat, 14 Oct 2023 17:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to;
	 s=fm2; t=1697320015; x=1697406415; bh=y2Ku17LtD19XLKZbDXzVuE2sX
	fMsYhRiO8i2RRFQu9o=; b=a7Z3DoQy2RBxI4jRbgbhFVG3hc1gYYAkgnUGPoJHJ
	jlEOLTkME3VKLc2+KflruvbNP70YoqTrSYc0xwjtRb05DwNF+PHSHT7gwrh13ebc
	WsZXrSJ+b6NWEI8oleb60leYpovwHxbyny1gYKA0olfxBgPjKEWlFYlF1B37k2mg
	yq9KD1qdxeuXbE1NimXJAp9EZsl2jyfIW+d+uLPqL9yItoc9QTx+8INT9shj2HYz
	v/PE6vJtXMT4e8fWYQBvJMwgNHKq4Griy43HUJf6Rh8a+3rOmlhCl7r9I+mpbeL2
	2VLpCQlFswuCVDxB7KZtTzSXyhjzOM38eWXhkeH6w+frQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1697320015; x=1697406415; bh=y2Ku17LtD19XLKZbDXzVuE2sXfMsYhRiO8i
	2RRFQu9o=; b=o3aA9LqNPgJzrHcJpy7Bqf13KWBwNrwLUmU8pTcDRduMXg59GH3
	F/wak5awzuMShHCqTpsCug7VTWDplvgLt+bjZAlqvASRJb/Xw/gVe56mluqbnkTB
	85qtsT7QncJJdE5L0l17QKojt5ppPmRuBZrugBh5re8TYM0PESh1TcQw317V1vOq
	NoLvSL1PLIa0DVirhm4qA9T5C3HuCBo4vFVTTcv+qvn5+nEifH5EVRmEUPSPRhU4
	+FKBx0Lye8u20I8P8JSHFZlJSY8ZByCepTyH4UG3OJaJxESglNuJW2VgSNt9/qkE
	lb7HVNWofoRa6AZPWDolqLZwLGHUbgzQswg==
X-ME-Sender: <xms:TwwrZe4qNVWzatplqIuRvEKSVUx6odvOcDNwt8QH4yVHCz4tJZIxQqU>
    <xme:TwwrZX43k0ttLzuD65aCPnk6uBZVFMTq7HbAAQOtkiezEIpW9lR0AK7_Kcb9Q1-wT
    ATdp8kVw9gR0BLSjg>
X-ME-Received: <xmr:TwwrZdcsEtVkYn7r5kTir5DiB06Jkxy7oWkOCWZ99SZvvs2L6uxTvY6f0PF1KdfTdFPHjtDvr-L6eePPU1_ndUmdOO3zxRaQDrQcEhAktt5QAdCGY8lDp1_8pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieeiucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesthekredtre
    dtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceotghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgfelveeike
    egjeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvg
X-ME-Proxy: <xmx:TwwrZbKtHRoDhG5aBAKOx4ERFDD0gU-Gd_nP_8avAhcYlyKJGZrskg>
    <xmx:TwwrZSKlDIFpzEmJCOjUndUPx85PmPLybwx3P4AhgVL4IgQN8V4Waw>
    <xmx:TwwrZcx3_YZXbU96nzP33XgjHBv9x628FGgVZ-_Qd5drdSmvYiRKvQ>
    <xmx:TwwrZUj9xZAnEbZPzuhWJ10Q8QNeEVv28podOhINZHM671JZhT2TAA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Oct 2023 17:46:54 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	stolee@gmail.com
Subject: [PATCH 1/8] t7900: remove register dependency
Date: Sat, 14 Oct 2023 23:45:52 +0200
Message-ID: <6d9398e64d0acb69219877c54ba3fdfa0faa0dbf.1697319294.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.42.0.2.g879ad04204
In-Reply-To: <cover.1697319294.git.code@khaugsbakk.name>
References: <cover.1697319294.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`stop from existing schedule` depends on the preceding test `start from
empty cron table` because the preceding test registers the
repository. Without it, the “stop” test fails because `config` fails to
get the repository:

    git config --get --global --fixed-value maintenance.repo "$(pwd)"

Remove this dependency by setting up the state and tearing it down
independently.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 t/t7900-maintenance.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 487e326b3fa..ca86b2ba687 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -588,6 +588,7 @@ test_expect_success 'start --scheduler=<scheduler>' '
 '
 
 test_expect_success 'start from empty cron table' '
+	test_when_finished git maintenance unregister &&
 	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance start --scheduler=crontab &&
 
 	# start registers the repo
@@ -599,6 +600,8 @@ test_expect_success 'start from empty cron table' '
 '
 
 test_expect_success 'stop from existing schedule' '
+	test_when_finished git maintenance unregister &&
+	git maintenance register &&
 	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance stop &&
 
 	# stop does not unregister the repo
-- 
2.42.0.2.g879ad04204

